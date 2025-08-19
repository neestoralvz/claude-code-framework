#!/usr/bin/env python3
"""
Claude Code Batch Processor
Safe batch processing with resource monitoring and limits
"""

import time
import logging
from typing import List, Callable, Any, Dict, Optional, Generator
from pathlib import Path
from resource_monitor import ResourceMonitor

class BatchProcessor:
    """Safely processes large batches with resource monitoring"""
    
    def __init__(self, 
                 batch_size: int = 5,
                 pause_between_batches: float = 2.0,
                 memory_check_interval: int = 10,
                 max_memory_percent: float = 85.0):
        
        self.batch_size = batch_size
        self.pause_between_batches = pause_between_batches
        self.memory_check_interval = memory_check_interval
        self.max_memory_percent = max_memory_percent
        
        self.resource_monitor = ResourceMonitor()
        self.processed_count = 0
        
        # Setup logging
        log_file = Path('/Users/nalve/.claude/logs/batch-processor.log')
        log_file.parent.mkdir(parents=True, exist_ok=True)
        
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s [%(levelname)s] %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)
    
    def create_batches(self, items: List[Any]) -> Generator[List[Any], None, None]:
        """Split items into safe batch sizes"""
        for i in range(0, len(items), self.batch_size):
            yield items[i:i + self.batch_size]
    
    def check_resources_before_batch(self) -> bool:
        """Check if system resources allow processing next batch"""
        should_prevent, reason = self.resource_monitor.should_prevent_operation('bulk_file_ops')
        
        if should_prevent:
            self.logger.warning(f"Batch processing paused: {reason}")
            return False
        
        return True
    
    def wait_for_resources(self, max_wait_time: float = 60.0) -> bool:
        """Wait for resources to become available"""
        start_time = time.time()
        wait_interval = 5.0
        
        while time.time() - start_time < max_wait_time:
            if self.check_resources_before_batch():
                return True
            
            self.logger.info(f"Waiting for resources... ({int(time.time() - start_time)}s)")
            time.sleep(wait_interval)
        
        self.logger.error(f"Resource wait timeout after {max_wait_time}s")
        return False
    
    def process_batch_safely(self, 
                           items: List[Any], 
                           processor_func: Callable[[Any], Any],
                           **kwargs) -> List[Any]:
        """Process a batch with safety checks"""
        
        # Pre-batch resource check
        if not self.check_resources_before_batch():
            if not self.wait_for_resources():
                raise RuntimeError("System resources unavailable for batch processing")
        
        results = []
        batch_start_time = time.time()
        
        self.logger.info(f"Processing batch of {len(items)} items")
        
        for i, item in enumerate(items):
            try:
                # Periodic memory checks during batch
                if i > 0 and i % self.memory_check_interval == 0:
                    metrics = self.resource_monitor.get_system_metrics()
                    memory_percent = metrics.get('memory', {}).get('percent', 0)
                    
                    if memory_percent > self.max_memory_percent:
                        self.logger.warning(f"Memory usage high during batch: {memory_percent:.1f}%")
                        time.sleep(1.0)  # Brief pause to allow memory cleanup
                
                # Process item
                result = processor_func(item, **kwargs)
                results.append(result)
                self.processed_count += 1
                
                # Small pause between items to prevent overwhelming
                if i < len(items) - 1:  # Don't pause after last item
                    time.sleep(0.1)
                    
            except Exception as e:
                self.logger.error(f"Error processing item {i}: {e}")
                results.append(None)  # Placeholder for failed item
        
        batch_duration = time.time() - batch_start_time
        self.logger.info(f"Batch completed in {batch_duration:.2f}s")
        
        return results
    
    def process_all_batches(self, 
                          items: List[Any], 
                          processor_func: Callable[[Any], Any],
                          **kwargs) -> List[Any]:
        """Process all items in safe batches"""
        
        if not items:
            self.logger.info("No items to process")
            return []
        
        total_items = len(items)
        self.logger.info(f"Starting batch processing: {total_items} items, "
                        f"batch size {self.batch_size}, "
                        f"pause {self.pause_between_batches}s")
        
        all_results = []
        batch_count = 0
        
        try:
            for batch in self.create_batches(items):
                batch_count += 1
                batch_results = self.process_batch_safely(batch, processor_func, **kwargs)
                all_results.extend(batch_results)
                
                # Progress logging
                progress = (len(all_results) / total_items) * 100
                self.logger.info(f"Progress: {len(all_results)}/{total_items} ({progress:.1f}%)")
                
                # Pause between batches (except for last batch)
                if len(all_results) < total_items:
                    self.logger.debug(f"Pausing {self.pause_between_batches}s between batches")
                    time.sleep(self.pause_between_batches)
        
        except KeyboardInterrupt:
            self.logger.info(f"Batch processing interrupted. Processed {len(all_results)}/{total_items} items")
            raise
        except Exception as e:
            self.logger.error(f"Batch processing failed: {e}")
            raise
        
        self.logger.info(f"Batch processing completed: {len(all_results)}/{total_items} items processed")
        return all_results

class FileProcessor(BatchProcessor):
    """Specialized batch processor for file operations"""
    
    def __init__(self, **kwargs):
        super().__init__(batch_size=3, pause_between_batches=1.0, **kwargs)
    
    def read_file_safely(self, file_path: Path) -> Optional[str]:
        """Safely read a file with error handling"""
        try:
            if not file_path.exists():
                self.logger.warning(f"File not found: {file_path}")
                return None
            
            # Check file size before reading
            file_size = file_path.stat().st_size
            if file_size > 10 * 1024 * 1024:  # 10MB limit
                self.logger.warning(f"Large file skipped: {file_path} ({file_size} bytes)")
                return None
            
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                return f.read()
                
        except Exception as e:
            self.logger.error(f"Error reading {file_path}: {e}")
            return None
    
    def process_files_in_batches(self, file_paths: List[Path]) -> List[Optional[str]]:
        """Process multiple files in safe batches"""
        return self.process_all_batches(file_paths, self.read_file_safely)

# Example usage functions
def example_file_validation(file_path: Path) -> Dict[str, Any]:
    """Example: Validate a file (safe processing function)"""
    try:
        if not file_path.exists():
            return {'valid': False, 'error': 'File not found'}
        
        # Check basic properties
        stat = file_path.stat()
        return {
            'valid': True,
            'size': stat.st_size,
            'path': str(file_path),
            'readable': file_path.is_file()
        }
    except Exception as e:
        return {'valid': False, 'error': str(e)}

def example_safe_grep(file_path: Path, pattern: str) -> Dict[str, Any]:
    """Example: Safe grep operation with resource limits"""
    try:
        if not file_path.exists():
            return {'matches': [], 'error': 'File not found'}
        
        matches = []
        line_count = 0
        max_lines = 10000  # Limit to prevent memory issues
        
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                line_count += 1
                if line_count > max_lines:
                    break
                
                if pattern.lower() in line.lower():
                    matches.append({
                        'line_number': line_count,
                        'content': line.strip()[:200]  # Limit line length
                    })
        
        return {
            'matches': matches,
            'lines_scanned': line_count,
            'file': str(file_path)
        }
        
    except Exception as e:
        return {'matches': [], 'error': str(e)}

if __name__ == "__main__":
    # Example usage
    processor = FileProcessor()
    
    # Example: Process agent files safely
    agent_dir = Path('/Users/nalve/.claude/agents')
    if agent_dir.exists():
        agent_files = list(agent_dir.rglob('*.md'))
        print(f"Found {len(agent_files)} agent files")
        
        # Validate files in batches
        results = processor.process_all_batches(agent_files, example_file_validation)
        
        valid_files = [r for r in results if r and r.get('valid')]
        print(f"Validated {len(valid_files)} files successfully")