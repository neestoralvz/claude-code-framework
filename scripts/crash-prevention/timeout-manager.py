#!/usr/bin/env python3
"""
Claude Code Timeout Manager
Comprehensive timeout mechanisms for long-running operations
"""

import time
import signal
import threading
import subprocess
import logging
from typing import Optional, Callable, Any, Dict, Union, List
from pathlib import Path
from contextlib import contextmanager
from functools import wraps

class TimeoutError(Exception):
    """Custom timeout exception"""
    pass

class TimeoutManager:
    """Manages timeouts for various operations"""
    
    def __init__(self, default_timeout: float = 120.0):
        self.default_timeout = default_timeout
        self.active_timeouts: Dict[str, threading.Timer] = {}
        self.setup_logging()
    
    def setup_logging(self):
        """Setup logging configuration"""
        log_file = Path('/Users/nalve/.claude/logs/timeout-manager.log')
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
    
    @contextmanager
    def timeout_context(self, timeout_seconds: float, operation_name: str = "operation"):
        """Context manager for timeout operations"""
        
        timeout_occurred = threading.Event()
        timer = None
        
        def timeout_handler():
            timeout_occurred.set()
            self.logger.warning(f"Timeout occurred for {operation_name} after {timeout_seconds}s")
        
        try:
            # Start timeout timer
            timer = threading.Timer(timeout_seconds, timeout_handler)
            timer.start()
            
            # Store active timeout
            timeout_id = f"{operation_name}_{int(time.time())}"
            self.active_timeouts[timeout_id] = timer
            
            self.logger.info(f"Started timeout for {operation_name}: {timeout_seconds}s")
            
            # Yield control with timeout check function
            def check_timeout():
                if timeout_occurred.is_set():
                    raise TimeoutError(f"Operation '{operation_name}' timed out after {timeout_seconds} seconds")
            
            yield check_timeout
            
        finally:
            # Clean up
            if timer:
                timer.cancel()
            if timeout_id in self.active_timeouts:
                del self.active_timeouts[timeout_id]
            
            if timeout_occurred.is_set():
                self.logger.error(f"Operation {operation_name} was terminated due to timeout")
            else:
                self.logger.info(f"Operation {operation_name} completed within timeout")

    def timeout_decorator(self, timeout_seconds: Optional[float] = None):
        """Decorator to add timeout to functions"""
        
        def decorator(func: Callable) -> Callable:
            @wraps(func)
            def wrapper(*args, **kwargs):
                timeout = timeout_seconds or self.default_timeout
                operation_name = f"{func.__name__}"
                
                with self.timeout_context(timeout, operation_name) as check_timeout:
                    # Execute function with periodic timeout checks
                    return func(*args, **kwargs)
                    
            return wrapper
        return decorator
    
    def run_with_timeout(self, 
                        func: Callable, 
                        timeout_seconds: Optional[float] = None,
                        operation_name: Optional[str] = None,
                        *args, **kwargs) -> Any:
        """Run function with timeout"""
        
        timeout = timeout_seconds or self.default_timeout
        name = operation_name or func.__name__
        
        with self.timeout_context(timeout, name) as check_timeout:
            return func(*args, **kwargs)

class SubprocessTimeoutManager(TimeoutManager):
    """Specialized timeout manager for subprocess operations"""
    
    def run_command_with_timeout(self, 
                                command: Union[str, List[str]], 
                                timeout_seconds: float = 60.0,
                                shell: bool = False,
                                capture_output: bool = True) -> Dict[str, Any]:
        """Run subprocess command with timeout"""
        
        operation_name = f"subprocess_{command if isinstance(command, str) else ' '.join(command)}"
        self.logger.info(f"Starting subprocess with timeout: {timeout_seconds}s")
        
        start_time = time.time()
        
        try:
            # Start subprocess
            process = subprocess.Popen(
                command,
                shell=shell,
                stdout=subprocess.PIPE if capture_output else None,
                stderr=subprocess.PIPE if capture_output else None,
                text=True
            )
            
            # Wait for completion with timeout
            try:
                stdout, stderr = process.communicate(timeout=timeout_seconds)
                exit_code = process.returncode
                
                duration = time.time() - start_time
                self.logger.info(f"Subprocess completed in {duration:.2f}s with exit code {exit_code}")
                
                return {
                    'success': True,
                    'exit_code': exit_code,
                    'stdout': stdout if capture_output else None,
                    'stderr': stderr if capture_output else None,
                    'duration': duration,
                    'timeout_occurred': False
                }
                
            except subprocess.TimeoutExpired:
                # Timeout occurred - terminate process
                self.logger.warning(f"Subprocess timeout after {timeout_seconds}s, terminating...")
                
                process.terminate()
                
                # Give process time to terminate gracefully
                try:
                    process.wait(timeout=5.0)
                except subprocess.TimeoutExpired:
                    # Force kill if still running
                    self.logger.warning("Process didn't terminate gracefully, force killing...")
                    process.kill()
                    process.wait()
                
                duration = time.time() - start_time
                
                return {
                    'success': False,
                    'exit_code': -1,
                    'stdout': None,
                    'stderr': f"Command timed out after {timeout_seconds} seconds",
                    'duration': duration,
                    'timeout_occurred': True
                }
                
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"Subprocess error: {e}")
            
            return {
                'success': False,
                'exit_code': -1,
                'stdout': None,
                'stderr': str(e),
                'duration': duration,
                'timeout_occurred': False
            }

class IterativeTimeoutManager(TimeoutManager):
    """Timeout manager for iterative operations like file processing"""
    
    def process_with_timeouts(self, 
                            items: List[Any],
                            processor_func: Callable[[Any], Any],
                            item_timeout: float = 30.0,
                            total_timeout: float = 300.0,
                            progress_callback: Optional[Callable] = None) -> List[Any]:
        """Process items with per-item and total timeouts"""
        
        results = []
        start_time = time.time()
        
        self.logger.info(f"Processing {len(items)} items with timeouts: "
                        f"item={item_timeout}s, total={total_timeout}s")
        
        with self.timeout_context(total_timeout, "batch_processing") as check_total_timeout:
            
            for i, item in enumerate(items):
                # Check total timeout
                check_total_timeout()
                
                # Process individual item with timeout
                try:
                    with self.timeout_context(item_timeout, f"item_{i}") as check_item_timeout:
                        result = processor_func(item)
                        results.append(result)
                        
                        # Progress callback
                        if progress_callback:
                            progress_callback(i + 1, len(items))
                            
                except TimeoutError as e:
                    self.logger.warning(f"Item {i} timeout: {e}")
                    results.append(None)
                except Exception as e:
                    self.logger.error(f"Item {i} error: {e}")
                    results.append(None)
                
                # Check if we're approaching total timeout
                elapsed = time.time() - start_time
                remaining = total_timeout - elapsed
                
                if remaining < item_timeout and i < len(items) - 1:
                    self.logger.warning(f"Stopping early: insufficient time remaining ({remaining:.1f}s)")
                    break
        
        duration = time.time() - start_time
        success_count = sum(1 for r in results if r is not None)
        
        self.logger.info(f"Batch processing completed: {success_count}/{len(results)} successful "
                        f"in {duration:.2f}s")
        
        return results

class AdaptiveTimeoutManager(TimeoutManager):
    """Timeout manager that adapts based on operation history"""
    
    def __init__(self, default_timeout: float = 120.0):
        super().__init__(default_timeout)
        self.operation_history: Dict[str, List[float]] = {}
        self.min_timeout = 10.0
        self.max_timeout = 600.0
    
    def _update_history(self, operation_name: str, duration: float):
        """Update operation history for adaptive timeouts"""
        if operation_name not in self.operation_history:
            self.operation_history[operation_name] = []
        
        history = self.operation_history[operation_name]
        history.append(duration)
        
        # Keep only recent history (last 10 operations)
        if len(history) > 10:
            history.pop(0)
    
    def _calculate_adaptive_timeout(self, operation_name: str) -> float:
        """Calculate timeout based on operation history"""
        if operation_name not in self.operation_history:
            return self.default_timeout
        
        history = self.operation_history[operation_name]
        if not history:
            return self.default_timeout
        
        # Use 95th percentile of historical durations + buffer
        sorted_durations = sorted(history)
        percentile_95 = sorted_durations[int(len(sorted_durations) * 0.95)]
        
        # Add 50% buffer
        adaptive_timeout = percentile_95 * 1.5
        
        # Apply min/max constraints
        adaptive_timeout = max(self.min_timeout, min(adaptive_timeout, self.max_timeout))
        
        return adaptive_timeout
    
    def run_adaptive(self, 
                    func: Callable, 
                    operation_name: str,
                    manual_timeout: Optional[float] = None,
                    *args, **kwargs) -> Any:
        """Run function with adaptive timeout based on history"""
        
        if manual_timeout:
            timeout = manual_timeout
        else:
            timeout = self._calculate_adaptive_timeout(operation_name)
        
        start_time = time.time()
        
        try:
            with self.timeout_context(timeout, operation_name) as check_timeout:
                result = func(*args, **kwargs)
                
            # Record successful duration
            duration = time.time() - start_time
            self._update_history(operation_name, duration)
            
            self.logger.info(f"Adaptive operation '{operation_name}' completed in {duration:.2f}s "
                           f"(timeout was {timeout:.1f}s)")
            
            return result
            
        except TimeoutError:
            # Don't update history for timeouts
            self.logger.error(f"Adaptive operation '{operation_name}' timed out after {timeout:.1f}s")
            raise

# Example usage functions
def example_long_operation(duration: float = 5.0) -> str:
    """Example function that takes time"""
    time.sleep(duration)
    return f"Completed after {duration} seconds"

def example_file_processor(file_path: Path) -> Dict[str, Any]:
    """Example file processing with potential timeout"""
    try:
        time.sleep(0.5)  # Simulate processing time
        
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        return {
            'file': str(file_path),
            'size': len(content),
            'lines': content.count('\n'),
            'success': True
        }
    except Exception as e:
        return {
            'file': str(file_path),
            'error': str(e),
            'success': False
        }

if __name__ == "__main__":
    # Example usage
    timeout_manager = TimeoutManager(default_timeout=10.0)
    subprocess_manager = SubprocessTimeoutManager()
    iterative_manager = IterativeTimeoutManager()
    adaptive_manager = AdaptiveTimeoutManager()
    
    # Example 1: Basic timeout
    print("=== Basic Timeout Example ===")
    try:
        result = timeout_manager.run_with_timeout(
            example_long_operation, 
            timeout_seconds=3.0,
            operation_name="test_operation",
            duration=2.0
        )
        print(f"Result: {result}")
    except TimeoutError as e:
        print(f"Timeout: {e}")
    
    # Example 2: Subprocess timeout
    print("\n=== Subprocess Timeout Example ===")
    cmd_result = subprocess_manager.run_command_with_timeout(
        ["sleep", "2"], 
        timeout_seconds=3.0
    )
    print(f"Command result: {cmd_result}")
    
    # Example 3: Iterative processing
    print("\n=== Iterative Processing Example ===")
    test_files = [Path(f"/tmp/test_{i}.txt") for i in range(3)]
    
    # Create test files
    for test_file in test_files:
        test_file.write_text(f"Test content for {test_file.name}")
    
    try:
        results = iterative_manager.process_with_timeouts(
            test_files,
            example_file_processor,
            item_timeout=2.0,
            total_timeout=10.0
        )
        print(f"Processed {len(results)} files")
    finally:
        # Cleanup test files
        for test_file in test_files:
            if test_file.exists():
                test_file.unlink()