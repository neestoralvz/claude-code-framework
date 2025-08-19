# Claude Code Crash Prevention System

Comprehensive crash prevention measures for the Claude Code system implementing resource monitoring, batch processing limits, memory usage checks, sequential file processing workflows, terminal output limits, timeout mechanisms, graceful degradation, and early warning systems.

## Components

### 1. Resource Monitor (`resource-monitor.py`)
Real-time system resource monitoring with crash prevention capabilities.

**Features:**
- Memory, CPU, disk, and process monitoring
- Configurable thresholds and alerts
- Claude process tracking
- Resource constraint detection
- psutil-based comprehensive metrics

**Usage:**
```python
from resource_monitor import ResourceMonitor

monitor = ResourceMonitor()
metrics = monitor.get_system_metrics()
should_prevent, reason = monitor.should_prevent_operation('bulk_file_ops')
```

### 2. Batch Processor (`batch-processor.py`)
Safe batch processing with resource monitoring and limits.

**Features:**
- Configurable batch sizes and pause intervals
- Memory checks during processing
- Resource exhaustion prevention
- Progress tracking and error handling
- Specialized file processing capabilities

**Usage:**
```python
from batch_processor import BatchProcessor, FileProcessor

processor = BatchProcessor(batch_size=5, pause_between_batches=2.0)
results = processor.process_all_batches(items, processor_func)

file_processor = FileProcessor()
file_contents = file_processor.process_files_in_batches(file_paths)
```

### 3. Safe Operations Library (`safe-operations.sh`)
Bash library providing safe wrappers for common operations.

**Features:**
- Command execution with timeout and output limits
- File reading with size constraints
- Batch file processing with resource checks
- Safe grep and find operations
- Terminal buffer overflow prevention

**Usage:**
```bash
source safe-operations.sh

safe_exec 60 1000 ls -la /large/directory
safe_read_file large_file.txt 10M 1000
safe_batch_process 5 2 *.md
check_memory_usage
```

### 4. Terminal Limits (`terminal-limits.sh`)
Prevents terminal buffer overflow and excessive output.

**Features:**
- Output line and byte limits
- Intelligent truncation with context
- Line width limiting for readability
- Log file rotation
- Progress indicators for long operations

**Usage:**
```bash
source terminal-limits.sh

exec_with_limits 500 100 find /large/directory -name "*.log"
echo "long content" | stream_with_limits 200 80
truncate_output large_output.txt 1000
safe_pager huge_file.txt
```

### 5. Timeout Manager (`timeout-manager.py`)
Comprehensive timeout mechanisms for long-running operations.

**Features:**
- Context manager for timeout operations
- Function decorators for automatic timeouts
- Subprocess execution with timeouts
- Iterative processing with per-item and total timeouts
- Adaptive timeouts based on operation history

**Usage:**
```python
from timeout_manager import TimeoutManager, SubprocessTimeoutManager

timeout_manager = TimeoutManager(default_timeout=120.0)

# Context manager approach
with timeout_manager.timeout_context(60.0, "file_processing") as check_timeout:
    # Your operation here
    result = process_files()

# Subprocess with timeout
subprocess_manager = SubprocessTimeoutManager()
result = subprocess_manager.run_command_with_timeout(["ls", "-la"], timeout_seconds=30.0)
```

### 6. Graceful Degradation (`graceful-degradation.py`)
Implements graceful degradation when system resources are constrained.

**Features:**
- Performance level assessment (OPTIMAL, REDUCED, MINIMAL, EMERGENCY)
- Automatic parameter adaptation based on resource availability
- Operation deferral for resource-intensive tasks
- Resource waiting and availability checking
- Performance-based configuration management

**Usage:**
```python
from graceful_degradation import GracefulDegradationManager

degradation_manager = GracefulDegradationManager()

# Check if operation should be deferred
should_defer, reason = degradation_manager.should_defer_operation("bulk_file_ops")

# Execute with adaptive parameters
result = degradation_manager.execute_with_degradation(
    operation_func,
    "file_processing",
    default_params
)
```

### 7. Early Warning System (`early-warning-system.py`)
Proactive monitoring and alerting for potential crash conditions.

**Features:**
- Memory usage trend analysis
- CPU pattern monitoring
- Process growth detection
- System stability assessment
- Error pattern analysis
- Configurable alert callbacks

**Usage:**
```python
from early_warning_system import EarlyWarningSystem

warning_system = EarlyWarningSystem(check_interval=10.0)
warning_system.add_alert_callback(console_alert_handler)
warning_system.start_monitoring()

# Get status report
status = warning_system.get_status_report()
```

## Integration Examples

### Complete Crash Prevention Workflow

```python
#!/usr/bin/env python3
"""Example: Complete crash prevention workflow"""

from resource_monitor import ResourceMonitor
from batch_processor import BatchProcessor
from timeout_manager import TimeoutManager
from graceful_degradation import GracefulDegradationManager
from early_warning_system import EarlyWarningSystem

def safe_file_processing_workflow(file_paths, processing_function):
    """Example of complete crash prevention workflow"""
    
    # 1. Initialize components
    resource_monitor = ResourceMonitor()
    batch_processor = BatchProcessor()
    timeout_manager = TimeoutManager()
    degradation_manager = GracefulDegradationManager()
    warning_system = EarlyWarningSystem()
    
    # 2. Start monitoring
    warning_system.start_monitoring()
    
    try:
        # 3. Check system state
        should_prevent, reason = resource_monitor.should_prevent_operation('bulk_file_ops')
        if should_prevent:
            print(f"Operation prevented: {reason}")
            return None
        
        # 4. Get adaptive configuration
        config = degradation_manager.get_current_config()
        
        # 5. Process with timeouts and batching
        results = []
        for batch in batch_processor.create_batches(file_paths):
            batch_results = timeout_manager.run_with_timeout(
                processing_function,
                timeout_seconds=config.get('timeout', 60.0),
                operation_name="batch_processing",
                batch
            )
            results.extend(batch_results)
        
        return results
        
    finally:
        # 6. Stop monitoring
        warning_system.stop_monitoring()

# Usage
file_paths = [Path(f) for f in glob.glob("*.md")]
results = safe_file_processing_workflow(file_paths, my_processing_function)
```

### Bash Integration

```bash
#!/bin/bash
# Example: Safe bash operations with full crash prevention

source scripts/crash-prevention/safe-operations.sh
source scripts/crash-prevention/terminal-limits.sh

# Apply terminal limits
apply_terminal_limits

# Check resources before starting
if ! check_resources "bulk_file_ops"; then
    echo "Insufficient resources for operation"
    exit 1
fi

# Process files safely
echo "Processing files with crash prevention..."
safe_batch_process 3 2 *.md | stream_with_limits 1000 120

# Monitor memory during operation
check_memory_usage

echo "Operation completed safely"
```

## Configuration

### Resource Monitor Configuration
```json
{
    "thresholds": {
        "memory_warning": 80.0,
        "memory_critical": 90.0,
        "cpu_warning": 75.0,
        "cpu_critical": 90.0,
        "disk_warning": 85.0,
        "disk_critical": 95.0,
        "process_memory_mb": 500,
        "max_processes": 5
    },
    "log_file": "/Users/nalve/.claude/logs/resource-monitor.log"
}
```

### Graceful Degradation Levels
- **OPTIMAL**: Full features, large batches, detailed logging
- **REDUCED**: Medium batches, reduced logging, basic validation
- **MINIMAL**: Small batches, minimal features, essential operations only
- **EMERGENCY**: Single-item processing, read-only operations, critical functions only

## Installation and Setup

1. **Install Dependencies:**
```bash
pip install psutil
```

2. **Make Scripts Executable:**
```bash
chmod +x scripts/crash-prevention/*.sh
chmod +x scripts/crash-prevention/*.py
```

3. **Create Log Directories:**
```bash
mkdir -p /Users/nalve/.claude/logs
```

4. **Test Installation:**
```bash
python scripts/crash-prevention/resource-monitor.py
bash scripts/crash-prevention/safe-operations.sh
```

## Monitoring and Logs

All components write to dedicated log files in `/Users/nalve/.claude/logs/`:

- `resource-monitor.log` - Resource monitoring data
- `batch-processor.log` - Batch processing operations
- `safe-operations.log` - Safe operations library
- `terminal-limits.log` - Terminal output management
- `timeout-manager.log` - Timeout operations
- `graceful-degradation.log` - Performance level changes
- `early-warning.log` - Proactive alerts
- `alerts.log` - Consolidated alert log

## Emergency Procedures

### High Memory Usage
1. System automatically reduces batch sizes
2. Pauses between operations increase
3. Non-essential operations defer
4. Early warning alerts trigger

### Process Overload
1. Monitor detects excess Claude processes
2. New operations wait for resource availability
3. Graceful degradation reduces concurrent operations
4. Timeout mechanisms prevent hanging

### System Instability
1. Emergency performance level activates
2. Only essential read operations allowed
3. All batch operations pause
4. Early warning system provides immediate alerts

## Troubleshooting

### Common Issues

**Resource monitor not working:**
- Check psutil installation: `pip install psutil`
- Verify log directory permissions
- Check Python path in scripts

**Timeouts too aggressive:**
- Adjust timeout values in configuration
- Use adaptive timeout manager for automatic adjustment
- Monitor operation history for better predictions

**False positive alerts:**
- Adjust thresholds in early warning system
- Review alert patterns in logs
- Customize alert callbacks for your environment

### Debug Mode
Enable detailed logging for troubleshooting:

```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

## Performance Impact

The crash prevention system is designed to have minimal impact:

- **Resource monitoring**: ~0.1% CPU overhead
- **Batch processing**: Adds 1-5 second pauses between batches
- **Terminal limits**: Negligible impact on normal operations
- **Timeouts**: Only active during long operations
- **Graceful degradation**: Reactive, only when resources constrained
- **Early warning**: Background monitoring every 10 seconds

## Future Enhancements

Planned improvements:
- Machine learning for predictive resource management
- Integration with system notification services
- Web dashboard for real-time monitoring
- Automatic recovery procedures
- Cloud resource scaling integration