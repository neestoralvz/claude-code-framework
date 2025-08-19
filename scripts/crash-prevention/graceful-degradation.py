#!/usr/bin/env python3
"""
Claude Code Graceful Degradation System
Implements graceful degradation when system resources are constrained
"""

import time
import psutil
import logging
from typing import Dict, List, Optional, Callable, Any, Tuple
from pathlib import Path
from enum import Enum
from resource_monitor import ResourceMonitor

class PerformanceLevel(Enum):
    """Performance levels for graceful degradation"""
    OPTIMAL = "optimal"
    REDUCED = "reduced"
    MINIMAL = "minimal"
    EMERGENCY = "emergency"

class OperationMode(Enum):
    """Operation modes with different resource requirements"""
    FULL_FEATURED = "full_featured"
    ESSENTIAL_ONLY = "essential_only"
    READ_ONLY = "read_only"
    MAINTENANCE = "maintenance"

class GracefulDegradationManager:
    """Manages graceful degradation based on system resources"""
    
    def __init__(self):
        self.resource_monitor = ResourceMonitor()
        self.current_level = PerformanceLevel.OPTIMAL
        self.current_mode = OperationMode.FULL_FEATURED
        self.degradation_history: List[Dict] = []
        self.setup_logging()
        
        # Performance thresholds
        self.thresholds = {
            PerformanceLevel.OPTIMAL: {
                'memory_max': 70.0,
                'cpu_max': 60.0,
                'processes_max': 3
            },
            PerformanceLevel.REDUCED: {
                'memory_max': 85.0,
                'cpu_max': 80.0,
                'processes_max': 5
            },
            PerformanceLevel.MINIMAL: {
                'memory_max': 95.0,
                'cpu_max': 90.0,
                'processes_max': 7
            },
            PerformanceLevel.EMERGENCY: {
                'memory_max': 100.0,
                'cpu_max': 100.0,
                'processes_max': 10
            }
        }
        
        # Operation configurations for each performance level
        self.operation_configs = {
            PerformanceLevel.OPTIMAL: {
                'batch_size': 10,
                'pause_between_batches': 1.0,
                'max_concurrent_ops': 5,
                'enable_full_validation': True,
                'enable_detailed_logging': True,
                'max_file_size_mb': 50,
                'max_output_lines': 5000
            },
            PerformanceLevel.REDUCED: {
                'batch_size': 5,
                'pause_between_batches': 2.0,
                'max_concurrent_ops': 3,
                'enable_full_validation': True,
                'enable_detailed_logging': False,
                'max_file_size_mb': 20,
                'max_output_lines': 2000
            },
            PerformanceLevel.MINIMAL: {
                'batch_size': 3,
                'pause_between_batches': 3.0,
                'max_concurrent_ops': 2,
                'enable_full_validation': False,
                'enable_detailed_logging': False,
                'max_file_size_mb': 10,
                'max_output_lines': 1000
            },
            PerformanceLevel.EMERGENCY: {
                'batch_size': 1,
                'pause_between_batches': 5.0,
                'max_concurrent_ops': 1,
                'enable_full_validation': False,
                'enable_detailed_logging': False,
                'max_file_size_mb': 5,
                'max_output_lines': 500
            }
        }
    
    def setup_logging(self):
        """Setup logging configuration"""
        log_file = Path('/Users/nalve/.claude/logs/graceful-degradation.log')
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
    
    def assess_system_state(self) -> Dict[str, Any]:
        """Assess current system state and resource usage"""
        metrics = self.resource_monitor.get_system_metrics()
        
        if not metrics:
            return {'error': 'Unable to get system metrics'}
        
        memory_percent = metrics['memory']['percent']
        cpu_percent = metrics['cpu']['percent']
        claude_processes = metrics['processes']['claude_count']
        
        # Calculate stress scores
        memory_stress = memory_percent / 100.0
        cpu_stress = cpu_percent / 100.0
        process_stress = min(claude_processes / 5.0, 1.0)  # Normalize to 5 processes
        
        overall_stress = (memory_stress + cpu_stress + process_stress) / 3.0
        
        return {
            'memory_percent': memory_percent,
            'cpu_percent': cpu_percent,
            'claude_processes': claude_processes,
            'memory_stress': memory_stress,
            'cpu_stress': cpu_stress,
            'process_stress': process_stress,
            'overall_stress': overall_stress,
            'metrics': metrics
        }
    
    def determine_performance_level(self) -> PerformanceLevel:
        """Determine appropriate performance level based on system state"""
        state = self.assess_system_state()
        
        if 'error' in state:
            self.logger.warning("Unable to assess system state, using REDUCED performance")
            return PerformanceLevel.REDUCED
        
        memory_percent = state['memory_percent']
        cpu_percent = state['cpu_percent']
        claude_processes = state['claude_processes']
        
        # Check emergency conditions first
        if (memory_percent >= 95.0 or 
            cpu_percent >= 95.0 or 
            claude_processes >= 8):
            return PerformanceLevel.EMERGENCY
        
        # Check minimal conditions
        if (memory_percent >= 90.0 or 
            cpu_percent >= 85.0 or 
            claude_processes >= 6):
            return PerformanceLevel.MINIMAL
        
        # Check reduced conditions
        if (memory_percent >= 80.0 or 
            cpu_percent >= 75.0 or 
            claude_processes >= 4):
            return PerformanceLevel.REDUCED
        
        # Otherwise optimal
        return PerformanceLevel.OPTIMAL
    
    def update_performance_level(self) -> Tuple[PerformanceLevel, Dict[str, Any]]:
        """Update current performance level and return configuration"""
        previous_level = self.current_level
        self.current_level = self.determine_performance_level()
        
        if self.current_level != previous_level:
            self.logger.info(f"Performance level changed: {previous_level.value} → {self.current_level.value}")
            
            # Record degradation event
            self.degradation_history.append({
                'timestamp': time.time(),
                'from_level': previous_level.value,
                'to_level': self.current_level.value,
                'system_state': self.assess_system_state()
            })
            
            # Keep only recent history
            if len(self.degradation_history) > 50:
                self.degradation_history.pop(0)
        
        return self.current_level, self.operation_configs[self.current_level]
    
    def get_current_config(self) -> Dict[str, Any]:
        """Get current operation configuration"""
        level, config = self.update_performance_level()
        
        # Add system state information
        config['performance_level'] = level.value
        config['system_state'] = self.assess_system_state()
        
        return config
    
    def should_defer_operation(self, operation_type: str) -> Tuple[bool, str]:
        """Check if operation should be deferred due to resource constraints"""
        level, config = self.update_performance_level()
        
        # Emergency level - defer all non-essential operations
        if level == PerformanceLevel.EMERGENCY:
            if operation_type not in ['read_file', 'system_status', 'emergency_cleanup']:
                return True, f"Emergency mode: deferring {operation_type}"
        
        # Minimal level - defer complex operations
        elif level == PerformanceLevel.MINIMAL:
            if operation_type in ['bulk_file_ops', 'system_analysis', 'complex_search']:
                return True, f"Minimal mode: deferring {operation_type}"
        
        # Reduced level - defer resource-intensive operations
        elif level == PerformanceLevel.REDUCED:
            if operation_type in ['bulk_file_ops', 'parallel_processing']:
                return True, f"Reduced mode: deferring {operation_type}"
        
        return False, ""
    
    def adapt_operation_parameters(self, operation_type: str, 
                                 default_params: Dict[str, Any]) -> Dict[str, Any]:
        """Adapt operation parameters based on current performance level"""
        config = self.get_current_config()
        adapted_params = default_params.copy()
        
        # Apply performance-based adaptations
        if 'batch_size' in adapted_params:
            adapted_params['batch_size'] = min(
                adapted_params['batch_size'], 
                config['batch_size']
            )
        
        if 'pause_between_batches' in adapted_params:
            adapted_params['pause_between_batches'] = max(
                adapted_params['pause_between_batches'],
                config['pause_between_batches']
            )
        
        if 'max_output_lines' in adapted_params:
            adapted_params['max_output_lines'] = min(
                adapted_params['max_output_lines'],
                config['max_output_lines']
            )
        
        if 'max_file_size_mb' in adapted_params:
            adapted_params['max_file_size_mb'] = min(
                adapted_params['max_file_size_mb'],
                config['max_file_size_mb']
            )
        
        # Add performance level info
        adapted_params['performance_level'] = config['performance_level']
        
        self.logger.debug(f"Adapted parameters for {operation_type}: {adapted_params}")
        
        return adapted_params
    
    def wait_for_resources(self, 
                          required_level: PerformanceLevel = PerformanceLevel.REDUCED,
                          max_wait_time: float = 60.0) -> bool:
        """Wait for system resources to reach required level"""
        start_time = time.time()
        
        self.logger.info(f"Waiting for resources to reach {required_level.value} level")
        
        while time.time() - start_time < max_wait_time:
            current_level = self.determine_performance_level()
            
            # Check if we've reached acceptable level
            level_order = [
                PerformanceLevel.OPTIMAL,
                PerformanceLevel.REDUCED,
                PerformanceLevel.MINIMAL,
                PerformanceLevel.EMERGENCY
            ]
            
            current_index = level_order.index(current_level)
            required_index = level_order.index(required_level)
            
            if current_index <= required_index:
                self.logger.info(f"Resources available at {current_level.value} level")
                return True
            
            # Wait and check again
            time.sleep(5.0)
            self.logger.debug(f"Still waiting for resources... current: {current_level.value}")
        
        self.logger.warning(f"Resource wait timeout after {max_wait_time}s")
        return False
    
    def execute_with_degradation(self, 
                               operation_func: Callable,
                               operation_type: str,
                               default_params: Dict[str, Any],
                               *args, **kwargs) -> Any:
        """Execute operation with graceful degradation"""
        
        # Check if operation should be deferred
        should_defer, defer_reason = self.should_defer_operation(operation_type)
        
        if should_defer:
            self.logger.warning(f"Operation deferred: {defer_reason}")
            raise RuntimeError(f"Operation deferred due to resource constraints: {defer_reason}")
        
        # Adapt parameters based on current performance level
        adapted_params = self.adapt_operation_parameters(operation_type, default_params)
        
        # Merge adapted parameters with kwargs
        kwargs.update(adapted_params)
        
        start_time = time.time()
        
        try:
            self.logger.info(f"Executing {operation_type} with {self.current_level.value} performance")
            result = operation_func(*args, **kwargs)
            
            duration = time.time() - start_time
            self.logger.info(f"Operation {operation_type} completed in {duration:.2f}s")
            
            return result
            
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"Operation {operation_type} failed after {duration:.2f}s: {e}")
            raise
    
    def get_status_report(self) -> Dict[str, Any]:
        """Get comprehensive status report"""
        state = self.assess_system_state()
        config = self.get_current_config()
        
        return {
            'current_level': self.current_level.value,
            'current_mode': self.current_mode.value,
            'system_state': state,
            'operation_config': config,
            'recent_degradations': self.degradation_history[-5:] if self.degradation_history else [],
            'recommendations': self._generate_recommendations(state)
        }
    
    def _generate_recommendations(self, state: Dict[str, Any]) -> List[str]:
        """Generate recommendations based on current system state"""
        recommendations = []
        
        if state.get('memory_percent', 0) > 85:
            recommendations.append("High memory usage detected - consider reducing batch sizes")
        
        if state.get('cpu_percent', 0) > 80:
            recommendations.append("High CPU usage detected - consider increasing pause intervals")
        
        if state.get('claude_processes', 0) > 4:
            recommendations.append("Multiple Claude processes detected - consider closing unused instances")
        
        if state.get('overall_stress', 0) > 0.8:
            recommendations.append("System under high stress - recommend minimal operations only")
        
        if not recommendations:
            recommendations.append("System performance is good - normal operations can proceed")
        
        return recommendations

# Example usage functions
def example_resource_intensive_operation(batch_size: int = 10, 
                                       pause_between_batches: float = 1.0,
                                       max_output_lines: int = 5000,
                                       **kwargs) -> Dict[str, Any]:
    """Example resource-intensive operation that can be adapted"""
    
    # Simulate work with adapted parameters
    time.sleep(0.1 * batch_size)  # Simulate processing time
    
    return {
        'processed_items': batch_size,
        'pause_used': pause_between_batches,
        'output_limit': max_output_lines,
        'performance_level': kwargs.get('performance_level', 'unknown')
    }

if __name__ == "__main__":
    # Example usage
    degradation_manager = GracefulDegradationManager()
    
    print("=== Graceful Degradation System Demo ===")
    
    # Get current status
    status = degradation_manager.get_status_report()
    print(f"Current performance level: {status['current_level']}")
    print(f"Memory usage: {status['system_state']['memory_percent']:.1f}%")
    print(f"CPU usage: {status['system_state']['cpu_percent']:.1f}%")
    
    # Example operation with degradation
    try:
        default_params = {
            'batch_size': 20,
            'pause_between_batches': 0.5,
            'max_output_lines': 10000
        }
        
        result = degradation_manager.execute_with_degradation(
            example_resource_intensive_operation,
            "example_operation",
            default_params
        )
        
        print(f"Operation result: {result}")
        
    except Exception as e:
        print(f"Operation failed: {e}")
    
    # Show recommendations
    print("\nRecommendations:")
    for rec in status['recommendations']:
        print(f"  • {rec}")