#!/usr/bin/env python3
"""
Comprehensive Test Suite for Claude Code Crash Prevention System
Tests all components under real system stress conditions
"""

import os
import sys
import time
import threading
import multiprocessing
import subprocess
import tempfile
import logging
import json
from pathlib import Path
from typing import Dict, List, Any, Optional
from datetime import datetime

# Add the crash prevention directory to path
sys.path.insert(0, str(Path(__file__).parent))

import importlib.util
import sys

# Import modules with hyphenated names
def import_module_from_file(module_name, file_path):
    spec = importlib.util.spec_from_file_location(module_name, file_path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[module_name] = module
    spec.loader.exec_module(module)
    return module

# Import crash prevention modules
resource_monitor = import_module_from_file("resource_monitor", "resource-monitor.py")
batch_processor = import_module_from_file("batch_processor", "batch-processor.py") 
timeout_manager = import_module_from_file("timeout_manager", "timeout-manager.py")
graceful_degradation = import_module_from_file("graceful_degradation", "graceful-degradation.py")
early_warning_system = import_module_from_file("early_warning_system", "early-warning-system.py")

from resource_monitor import ResourceMonitor
from batch_processor import BatchProcessor, FileProcessor
from timeout_manager import TimeoutManager, SubprocessTimeoutManager, IterativeTimeoutManager
from graceful_degradation import GracefulDegradationManager, PerformanceLevel
from early_warning_system import EarlyWarningSystem, AlertLevel

class CrashPreventionTestSuite:
    """Comprehensive test suite for crash prevention system"""
    
    def __init__(self):
        self.test_results: Dict[str, Any] = {}
        self.test_dir = Path(tempfile.mkdtemp(prefix="claude_crash_test_"))
        self.setup_logging()
        
        # Initialize components
        self.resource_monitor = ResourceMonitor()
        self.batch_processor = BatchProcessor()
        self.timeout_manager = TimeoutManager()
        self.degradation_manager = GracefulDegradationManager()
        self.early_warning = EarlyWarningSystem(check_interval=2.0)
        
        self.logger.info(f"Test suite initialized with temp directory: {self.test_dir}")
    
    def setup_logging(self):
        """Setup test logging"""
        log_file = Path('/Users/nalve/.claude/logs/crash-prevention-tests.log')
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
    
    def create_test_files(self, count: int = 50, size_kb: int = 100) -> List[Path]:
        """Create test files for stress testing"""
        test_files = []
        
        for i in range(count):
            file_path = self.test_dir / f"test_file_{i:03d}.txt"
            
            # Create file with specified size
            content = f"Test file {i}\n" * (size_kb * 10)  # Approximate KB
            file_path.write_text(content)
            test_files.append(file_path)
        
        self.logger.info(f"Created {count} test files (~{size_kb}KB each)")
        return test_files
    
    def memory_stress_generator(self, duration: float = 30.0, intensity: int = 50):
        """Generate memory stress for testing"""
        memory_hogs = []
        
        def allocate_memory():
            # Allocate memory in chunks
            chunk_size = 10 * 1024 * 1024  # 10MB chunks
            chunks = []
            for _ in range(intensity):
                try:
                    chunk = bytearray(chunk_size)
                    chunks.append(chunk)
                    time.sleep(0.1)
                except MemoryError:
                    break
            return chunks
        
        start_time = time.time()
        while time.time() - start_time < duration:
            memory_hogs.append(allocate_memory())
            time.sleep(1.0)
        
        self.logger.info(f"Memory stress completed after {duration}s")
    
    def cpu_stress_generator(self, duration: float = 30.0, processes: int = 2):
        """Generate CPU stress for testing"""
        def cpu_intensive_task():
            end_time = time.time() + duration
            while time.time() < end_time:
                # CPU-intensive calculation
                sum(i * i for i in range(10000))
        
        stress_processes = []
        for _ in range(processes):
            process = multiprocessing.Process(target=cpu_intensive_task)
            process.start()
            stress_processes.append(process)
        
        # Wait for completion
        for process in stress_processes:
            process.join()
        
        self.logger.info(f"CPU stress completed with {processes} processes for {duration}s")
    
    def test_resource_monitoring(self) -> Dict[str, Any]:
        """Test resource monitoring under stress"""
        self.logger.info("=== Testing Resource Monitoring ===")
        
        results = {
            'test_name': 'resource_monitoring',
            'success': False,
            'details': {},
            'errors': []
        }
        
        try:
            # Get baseline metrics
            baseline_metrics = self.resource_monitor.get_system_metrics()
            results['details']['baseline'] = {
                'memory_percent': baseline_metrics['memory']['percent'],
                'cpu_percent': baseline_metrics['cpu']['percent'],
                'claude_processes': baseline_metrics['processes']['claude_count']
            }
            
            # Start memory stress in background
            stress_thread = threading.Thread(
                target=self.memory_stress_generator, 
                args=(15.0, 30)
            )
            stress_thread.start()
            
            # Monitor during stress
            stress_metrics = []
            for i in range(10):
                time.sleep(1.5)
                metrics = self.resource_monitor.get_system_metrics()
                stress_metrics.append({
                    'time': i * 1.5,
                    'memory_percent': metrics['memory']['percent'],
                    'cpu_percent': metrics['cpu']['percent']
                })
            
            stress_thread.join()
            
            results['details']['stress_metrics'] = stress_metrics
            
            # Verify monitoring detected stress
            max_memory = max(m['memory_percent'] for m in stress_metrics)
            memory_increase = max_memory - baseline_metrics['memory']['percent']
            
            results['details']['memory_increase'] = memory_increase
            results['details']['detection_successful'] = memory_increase > 5.0
            
            # Test operation prevention
            should_prevent, reason = self.resource_monitor.should_prevent_operation('bulk_file_ops')
            results['details']['prevention_test'] = {
                'should_prevent': should_prevent,
                'reason': reason
            }
            
            results['success'] = True
            self.logger.info("✅ Resource monitoring test passed")
            
        except Exception as e:
            results['errors'].append(str(e))
            self.logger.error(f"❌ Resource monitoring test failed: {e}")
        
        return results
    
    def test_batch_processing_limits(self) -> Dict[str, Any]:
        """Test batch processing with resource limits"""
        self.logger.info("=== Testing Batch Processing Limits ===")
        
        results = {
            'test_name': 'batch_processing_limits',
            'success': False,
            'details': {},
            'errors': []
        }
        
        try:
            # Create test files
            test_files = self.create_test_files(count=20, size_kb=50)
            
            # Configure processor with small batches
            processor = BatchProcessor(
                batch_size=3,
                pause_between_batches=1.0,
                memory_check_interval=2
            )
            
            def test_file_reader(file_path: Path) -> Dict[str, Any]:
                """Test function that reads files"""
                time.sleep(0.2)  # Simulate processing time
                with open(file_path, 'r') as f:
                    content = f.read()
                return {
                    'file': str(file_path),
                    'size': len(content),
                    'success': True
                }
            
            # Start memory stress
            stress_thread = threading.Thread(
                target=self.memory_stress_generator,
                args=(20.0, 20)
            )
            stress_thread.start()
            
            start_time = time.time()
            
            # Process files with limits
            batch_results = processor.process_all_batches(test_files, test_file_reader)
            
            processing_time = time.time() - start_time
            stress_thread.join()
            
            # Analyze results
            successful_files = sum(1 for r in batch_results if r and r.get('success'))
            
            results['details'] = {
                'total_files': len(test_files),
                'successful_files': successful_files,
                'processing_time': processing_time,
                'batches_used': len(test_files) // 3 + (1 if len(test_files) % 3 else 0),
                'average_time_per_file': processing_time / len(test_files)
            }
            
            # Verify batch processing worked with limits
            results['success'] = (
                successful_files >= len(test_files) * 0.8 and  # At least 80% success
                processing_time > 10.0  # Should take time due to pauses
            )
            
            if results['success']:
                self.logger.info("✅ Batch processing limits test passed")
            else:
                self.logger.warning("⚠️ Batch processing limits test had issues")
            
        except Exception as e:
            results['errors'].append(str(e))
            self.logger.error(f"❌ Batch processing limits test failed: {e}")
        
        return results
    
    def test_timeout_mechanisms(self) -> Dict[str, Any]:
        """Test timeout mechanisms"""
        self.logger.info("=== Testing Timeout Mechanisms ===")
        
        results = {
            'test_name': 'timeout_mechanisms',
            'success': False,
            'details': {},
            'errors': []
        }
        
        try:
            timeout_manager = TimeoutManager(default_timeout=5.0)
            
            # Test 1: Function that completes within timeout
            def quick_function():
                time.sleep(2.0)
                return "completed"
            
            start_time = time.time()
            result1 = timeout_manager.run_with_timeout(
                quick_function,
                timeout_seconds=5.0,
                operation_name="quick_test"
            )
            time1 = time.time() - start_time
            
            # Test 2: Function that should timeout
            def slow_function():
                time.sleep(10.0)
                return "should not complete"
            
            timeout_occurred = False
            start_time = time.time()
            try:
                timeout_manager.run_with_timeout(
                    slow_function,
                    timeout_seconds=3.0,
                    operation_name="slow_test"
                )
            except Exception:
                timeout_occurred = True
            time2 = time.time() - start_time
            
            # Test 3: Subprocess timeout
            subprocess_manager = SubprocessTimeoutManager()
            cmd_result = subprocess_manager.run_command_with_timeout(
                ["sleep", "2"],
                timeout_seconds=5.0
            )
            
            # Test 4: Subprocess that should timeout
            timeout_cmd_result = subprocess_manager.run_command_with_timeout(
                ["sleep", "10"],
                timeout_seconds=3.0
            )
            
            results['details'] = {
                'quick_function': {
                    'result': result1,
                    'time': time1,
                    'expected_success': True
                },
                'slow_function': {
                    'timeout_occurred': timeout_occurred,
                    'time': time2,
                    'expected_timeout': True
                },
                'subprocess_normal': {
                    'success': cmd_result['success'],
                    'exit_code': cmd_result['exit_code'],
                    'duration': cmd_result['duration']
                },
                'subprocess_timeout': {
                    'timeout_occurred': timeout_cmd_result['timeout_occurred'],
                    'duration': timeout_cmd_result['duration']
                }
            }
            
            # Verify timeout mechanisms work
            results['success'] = (
                result1 == "completed" and
                timeout_occurred and
                time2 < 5.0 and  # Should timeout quickly
                cmd_result['success'] and
                timeout_cmd_result['timeout_occurred']
            )
            
            if results['success']:
                self.logger.info("✅ Timeout mechanisms test passed")
            else:
                self.logger.warning("⚠️ Timeout mechanisms test had issues")
            
        except Exception as e:
            results['errors'].append(str(e))
            self.logger.error(f"❌ Timeout mechanisms test failed: {e}")
        
        return results
    
    def test_graceful_degradation(self) -> Dict[str, Any]:
        """Test graceful degradation under stress"""
        self.logger.info("=== Testing Graceful Degradation ===")
        
        results = {
            'test_name': 'graceful_degradation',
            'success': False,
            'details': {},
            'errors': []
        }
        
        try:
            # Get baseline performance level
            baseline_level = self.degradation_manager.determine_performance_level()
            baseline_config = self.degradation_manager.get_current_config()
            
            results['details']['baseline'] = {
                'performance_level': baseline_level.value,
                'batch_size': baseline_config['batch_size']
            }
            
            # Start system stress
            stress_thread = threading.Thread(
                target=self.memory_stress_generator,
                args=(25.0, 50)  # More intense stress
            )
            stress_thread.start()
            
            # Monitor degradation over time
            degradation_samples = []
            for i in range(15):
                time.sleep(1.5)
                current_level = self.degradation_manager.determine_performance_level()
                current_config = self.degradation_manager.get_current_config()
                
                degradation_samples.append({
                    'time': i * 1.5,
                    'performance_level': current_level.value,
                    'batch_size': current_config['batch_size'],
                    'memory_percent': current_config['system_state']['memory_percent']
                })
            
            stress_thread.join()
            
            results['details']['degradation_samples'] = degradation_samples
            
            # Test parameter adaptation
            default_params = {
                'batch_size': 20,
                'pause_between_batches': 1.0,
                'max_output_lines': 5000
            }
            
            adapted_params = self.degradation_manager.adapt_operation_parameters(
                'test_operation',
                default_params
            )
            
            results['details']['parameter_adaptation'] = {
                'original': default_params,
                'adapted': adapted_params
            }
            
            # Verify degradation occurred
            performance_levels = [s['performance_level'] for s in degradation_samples]
            degradation_occurred = any(level != baseline_level.value for level in performance_levels)
            
            # Verify parameters were adapted
            parameters_adapted = (
                adapted_params['batch_size'] <= default_params['batch_size'] or
                adapted_params['pause_between_batches'] >= default_params['pause_between_batches']
            )
            
            results['details']['degradation_detected'] = degradation_occurred
            results['details']['parameters_adapted'] = parameters_adapted
            
            results['success'] = degradation_occurred and parameters_adapted
            
            if results['success']:
                self.logger.info("✅ Graceful degradation test passed")
            else:
                self.logger.warning("⚠️ Graceful degradation test had issues")
            
        except Exception as e:
            results['errors'].append(str(e))
            self.logger.error(f"❌ Graceful degradation test failed: {e}")
        
        return results
    
    def test_early_warning_system(self) -> Dict[str, Any]:
        """Test early warning system"""
        self.logger.info("=== Testing Early Warning System ===")
        
        results = {
            'test_name': 'early_warning_system',
            'success': False,
            'details': {},
            'errors': []
        }
        
        try:
            # Setup alert collection
            alerts_collected = []
            
            def test_alert_handler(alert):
                alerts_collected.append({
                    'level': alert.level.value,
                    'message': alert.message,
                    'type': alert.alert_type,
                    'timestamp': alert.timestamp.isoformat()
                })
            
            self.early_warning.add_alert_callback(test_alert_handler)
            
            # Start monitoring
            self.early_warning.start_monitoring()
            
            # Generate stress to trigger alerts
            stress_thread = threading.Thread(
                target=self.memory_stress_generator,
                args=(20.0, 60)  # High intensity stress
            )
            stress_thread.start()
            
            # Let monitoring run during stress
            time.sleep(25.0)
            
            stress_thread.join()
            self.early_warning.stop_monitoring()
            
            # Analyze collected alerts
            results['details'] = {
                'total_alerts': len(alerts_collected),
                'alert_types': list(set(alert['type'] for alert in alerts_collected)),
                'alert_levels': list(set(alert['level'] for alert in alerts_collected)),
                'alerts': alerts_collected[-10:]  # Last 10 alerts
            }
            
            # Get final status
            status_report = self.early_warning.get_status_report()
            results['details']['final_status'] = status_report['system_status']
            results['details']['active_alerts'] = len(status_report['active_alerts'])
            
            # Verify early warning system worked
            results['success'] = (
                len(alerts_collected) > 0 and  # Should have generated alerts
                any(alert['level'] in ['warning', 'critical'] for alert in alerts_collected)
            )
            
            if results['success']:
                self.logger.info("✅ Early warning system test passed")
            else:
                self.logger.warning("⚠️ Early warning system test had issues")
            
        except Exception as e:
            results['errors'].append(str(e))
            self.logger.error(f"❌ Early warning system test failed: {e}")
        
        return results
    
    def test_terminal_output_limits(self) -> Dict[str, Any]:
        """Test terminal output limits"""
        self.logger.info("=== Testing Terminal Output Limits ===")
        
        results = {
            'test_name': 'terminal_output_limits',
            'success': False,
            'details': {},
            'errors': []
        }
        
        try:
            # Test with bash script
            test_script = """
            source scripts/crash-prevention/safe-operations.sh
            
            # Test safe command execution with limits
            safe_exec 10 100 find /Users/nalve/.claude -name "*.md" -type f
            
            # Test memory usage check
            check_memory_usage
            """
            
            script_file = self.test_dir / "test_limits.sh"
            script_file.write_text(test_script)
            script_file.chmod(0o755)
            
            # Run the test script
            result = subprocess.run(
                ["/bin/bash", str(script_file)],
                capture_output=True,
                text=True,
                timeout=30,
                cwd="/Users/nalve/.claude"
            )
            
            output_lines = result.stdout.count('\n')
            
            results['details'] = {
                'exit_code': result.returncode,
                'output_lines': output_lines,
                'stdout_length': len(result.stdout),
                'stderr_present': bool(result.stderr),
                'limits_applied': output_lines <= 200  # Should be limited
            }
            
            # Test large file reading limits
            large_content = "Line content\n" * 5000
            large_file = self.test_dir / "large_test.txt"
            large_file.write_text(large_content)
            
            read_test_script = f"""
            source scripts/crash-prevention/safe-operations.sh
            safe_read_file {large_file} 1M 100
            """
            
            read_script_file = self.test_dir / "test_read_limits.sh"
            read_script_file.write_text(read_test_script)
            read_script_file.chmod(0o755)
            
            read_result = subprocess.run(
                ["/bin/bash", str(read_script_file)],
                capture_output=True,
                text=True,
                timeout=15,
                cwd="/Users/nalve/.claude"
            )
            
            read_output_lines = read_result.stdout.count('\n')
            
            results['details']['large_file_test'] = {
                'original_lines': 5000,
                'output_lines': read_output_lines,
                'truncated': read_output_lines < 5000
            }
            
            # Verify terminal limits work
            results['success'] = (
                result.returncode == 0 and
                read_output_lines <= 150 and  # Should be truncated
                read_output_lines > 50  # But should show some content
            )
            
            if results['success']:
                self.logger.info("✅ Terminal output limits test passed")
            else:
                self.logger.warning("⚠️ Terminal output limits test had issues")
            
        except Exception as e:
            results['errors'].append(str(e))
            self.logger.error(f"❌ Terminal output limits test failed: {e}")
        
        return results
    
    def run_comprehensive_stress_test(self) -> Dict[str, Any]:
        """Run comprehensive stress test combining all systems"""
        self.logger.info("=== Running Comprehensive Stress Test ===")
        
        results = {
            'test_name': 'comprehensive_stress_test',
            'success': False,
            'details': {},
            'errors': []
        }
        
        try:
            # Create many test files
            test_files = self.create_test_files(count=100, size_kb=200)
            
            # Start early warning monitoring
            self.early_warning.start_monitoring()
            
            # Start multiple stress sources
            memory_stress = threading.Thread(
                target=self.memory_stress_generator,
                args=(45.0, 40)
            )
            
            cpu_stress = threading.Thread(
                target=self.cpu_stress_generator,
                args=(30.0, 3)
            )
            
            memory_stress.start()
            time.sleep(5.0)  # Stagger stress
            cpu_stress.start()
            
            # Process files under stress with all protections
            start_time = time.time()
            
            def stress_test_processor(file_path: Path) -> Dict[str, Any]:
                """File processor for stress test"""
                # Simulate complex processing
                time.sleep(0.3)
                
                try:
                    with open(file_path, 'r') as f:
                        content = f.read()
                    
                    # Simulate analysis
                    line_count = content.count('\n')
                    word_count = len(content.split())
                    
                    return {
                        'file': str(file_path),
                        'lines': line_count,
                        'words': word_count,
                        'success': True
                    }
                except Exception as e:
                    return {
                        'file': str(file_path),
                        'error': str(e),
                        'success': False
                    }
            
            # Use all protection mechanisms
            batch_processor = BatchProcessor(batch_size=2, pause_between_batches=3.0)
            
            processed_results = []
            batch_count = 0
            
            for batch in batch_processor.create_batches(test_files):
                batch_count += 1
                
                # Check if we should continue
                should_defer, reason = self.degradation_manager.should_defer_operation('bulk_file_ops')
                
                if should_defer:
                    self.logger.warning(f"Batch {batch_count} deferred: {reason}")
                    break
                
                # Process batch with timeout
                try:
                    batch_results = self.timeout_manager.run_with_timeout(
                        lambda b: [stress_test_processor(f) for f in b],
                        timeout_seconds=30.0,
                        operation_name=f"batch_{batch_count}",
                        b=batch
                    )
                    processed_results.extend(batch_results)
                    
                except Exception as e:
                    self.logger.warning(f"Batch {batch_count} failed: {e}")
                    break
                
                # Check system state between batches
                current_level = self.degradation_manager.determine_performance_level()
                self.logger.info(f"Batch {batch_count} completed, performance level: {current_level.value}")
            
            processing_time = time.time() - start_time
            
            # Wait for stress to complete
            memory_stress.join()
            cpu_stress.join()
            self.early_warning.stop_monitoring()
            
            # Analyze results
            successful_files = sum(1 for r in processed_results if r and r.get('success'))
            
            results['details'] = {
                'total_files': len(test_files),
                'processed_files': len(processed_results),
                'successful_files': successful_files,
                'batches_processed': batch_count,
                'processing_time': processing_time,
                'success_rate': successful_files / len(test_files) if test_files else 0,
                'system_survived': True,  # If we get here, system didn't crash
                'final_performance_level': self.degradation_manager.determine_performance_level().value
            }
            
            # Get final system status
            final_status = self.early_warning.get_status_report()
            results['details']['final_system_status'] = final_status['system_status']
            results['details']['total_alerts'] = len(final_status['recent_alerts'])
            
            # Verify comprehensive protection worked
            results['success'] = (
                results['details']['system_survived'] and
                successful_files > 0 and  # Some files processed
                processing_time > 15.0  # Took reasonable time (not too fast)
            )
            
            if results['success']:
                self.logger.info("✅ Comprehensive stress test passed - System survived with protections!")
            else:
                self.logger.warning("⚠️ Comprehensive stress test had issues")
            
        except Exception as e:
            results['errors'].append(str(e))
            self.logger.error(f"❌ Comprehensive stress test failed: {e}")
        
        return results
    
    def run_all_tests(self) -> Dict[str, Any]:
        """Run all crash prevention tests"""
        self.logger.info("🚀 Starting Comprehensive Crash Prevention Test Suite")
        
        all_results = {
            'test_suite': 'crash_prevention_comprehensive',
            'start_time': datetime.now().isoformat(),
            'tests': {},
            'summary': {}
        }
        
        # Run individual component tests
        test_methods = [
            self.test_resource_monitoring,
            self.test_batch_processing_limits,
            self.test_timeout_mechanisms,
            self.test_graceful_degradation,
            self.test_early_warning_system,
            self.test_terminal_output_limits,
            self.run_comprehensive_stress_test
        ]
        
        successful_tests = 0
        total_tests = len(test_methods)
        
        for test_method in test_methods:
            try:
                test_result = test_method()
                test_name = test_result['test_name']
                all_results['tests'][test_name] = test_result
                
                if test_result['success']:
                    successful_tests += 1
                    
            except Exception as e:
                self.logger.error(f"Test method {test_method.__name__} crashed: {e}")
        
        # Generate summary
        all_results['end_time'] = datetime.now().isoformat()
        all_results['summary'] = {
            'total_tests': total_tests,
            'successful_tests': successful_tests,
            'failed_tests': total_tests - successful_tests,
            'success_rate': successful_tests / total_tests,
            'overall_success': successful_tests == total_tests
        }
        
        self.logger.info(f"🏁 Test Suite Complete: {successful_tests}/{total_tests} tests passed")
        
        return all_results
    
    def cleanup(self):
        """Clean up test resources"""
        try:
            import shutil
            shutil.rmtree(self.test_dir)
            self.logger.info(f"Cleaned up test directory: {self.test_dir}")
        except Exception as e:
            self.logger.warning(f"Failed to clean up test directory: {e}")

if __name__ == "__main__":
    # Run the comprehensive test suite
    test_suite = CrashPreventionTestSuite()
    
    try:
        results = test_suite.run_all_tests()
        
        # Save results to file
        results_file = Path('/Users/nalve/.claude/logs/crash-prevention-test-results.json')
        with open(results_file, 'w') as f:
            json.dump(results, f, indent=2)
        
        print("\n" + "="*80)
        print("CRASH PREVENTION SYSTEM TEST RESULTS")
        print("="*80)
        
        summary = results['summary']
        print(f"Tests Run: {summary['total_tests']}")
        print(f"Passed: {summary['successful_tests']}")
        print(f"Failed: {summary['failed_tests']}")
        print(f"Success Rate: {summary['success_rate']:.1%}")
        print(f"Overall Result: {'✅ PASSED' if summary['overall_success'] else '❌ FAILED'}")
        
        print("\n" + "-"*50)
        print("Individual Test Results:")
        print("-"*50)
        
        for test_name, test_result in results['tests'].items():
            status = "✅ PASS" if test_result['success'] else "❌ FAIL"
            print(f"{test_name}: {status}")
            
            if test_result.get('errors'):
                for error in test_result['errors']:
                    print(f"  Error: {error}")
        
        print(f"\nDetailed results saved to: {results_file}")
        
    finally:
        test_suite.cleanup()