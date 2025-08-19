#!/usr/bin/env python3
"""
Claude Code Early Warning System
Proactive monitoring and alerting for potential crash conditions
"""

import time
import json
import threading
import logging
from typing import Dict, List, Optional, Callable, Any, Tuple
from pathlib import Path
from datetime import datetime, timedelta
from collections import deque
from enum import Enum
from resource_monitor import ResourceMonitor
from graceful_degradation import GracefulDegradationManager, PerformanceLevel

class AlertLevel(Enum):
    """Alert severity levels"""
    INFO = "info"
    WARNING = "warning"
    CRITICAL = "critical"
    EMERGENCY = "emergency"

class Alert:
    """Alert object with metadata"""
    
    def __init__(self, 
                 level: AlertLevel,
                 message: str,
                 alert_type: str,
                 data: Optional[Dict] = None):
        self.level = level
        self.message = message
        self.alert_type = alert_type
        self.data = data or {}
        self.timestamp = datetime.now()
        self.id = f"{alert_type}_{int(time.time())}"
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            'id': self.id,
            'level': self.level.value,
            'message': self.message,
            'type': self.alert_type,
            'data': self.data,
            'timestamp': self.timestamp.isoformat()
        }

class EarlyWarningSystem:
    """Proactive monitoring system for crash prevention"""
    
    def __init__(self, check_interval: float = 10.0):
        self.check_interval = check_interval
        self.resource_monitor = ResourceMonitor()
        self.degradation_manager = GracefulDegradationManager()
        
        # Alert storage
        self.active_alerts: Dict[str, Alert] = {}
        self.alert_history: deque = deque(maxlen=1000)
        self.alert_callbacks: List[Callable[[Alert], None]] = []
        
        # Monitoring data
        self.metrics_history: deque = deque(maxlen=100)  # Last 100 measurements
        self.trend_window = 20  # Number of measurements for trend analysis
        
        # Warning thresholds
        self.thresholds = {
            'memory_trend_rate': 2.0,      # % per minute
            'cpu_sustained_high': 80.0,     # % for sustained period
            'process_growth_rate': 1,       # processes per minute
            'disk_growth_rate': 100,        # MB per minute
            'response_time_degradation': 2.0  # response time multiplier
        }
        
        # State tracking
        self.monitoring_active = False
        self.monitoring_thread: Optional[threading.Thread] = None
        self.last_health_check = time.time()
        
        self.setup_logging()
    
    def setup_logging(self):
        """Setup logging configuration"""
        log_file = Path('/Users/nalve/.claude/logs/early-warning.log')
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
    
    def add_alert_callback(self, callback: Callable[[Alert], None]):
        """Add callback function for alert notifications"""
        self.alert_callbacks.append(callback)
    
    def create_alert(self, 
                    level: AlertLevel,
                    message: str,
                    alert_type: str,
                    data: Optional[Dict] = None) -> Alert:
        """Create and process new alert"""
        alert = Alert(level, message, alert_type, data)
        
        # Store alert
        self.active_alerts[alert.id] = alert
        self.alert_history.append(alert)
        
        # Log alert
        log_level = {
            AlertLevel.INFO: logging.INFO,
            AlertLevel.WARNING: logging.WARNING,
            AlertLevel.CRITICAL: logging.CRITICAL,
            AlertLevel.EMERGENCY: logging.CRITICAL
        }[level]
        
        self.logger.log(log_level, f"[{alert_type}] {message}")
        
        # Notify callbacks
        for callback in self.alert_callbacks:
            try:
                callback(alert)
            except Exception as e:
                self.logger.error(f"Alert callback error: {e}")
        
        return alert
    
    def clear_alert(self, alert_id: str):
        """Clear resolved alert"""
        if alert_id in self.active_alerts:
            alert = self.active_alerts.pop(alert_id)
            self.logger.info(f"Alert cleared: {alert.message}")
    
    def analyze_memory_trends(self, metrics: Dict[str, Any]) -> Optional[Alert]:
        """Analyze memory usage trends for early warning"""
        if len(self.metrics_history) < self.trend_window:
            return None
        
        # Calculate memory usage trend
        recent_metrics = list(self.metrics_history)[-self.trend_window:]
        memory_values = [m['memory']['percent'] for m in recent_metrics]
        timestamps = [m['timestamp'] for m in recent_metrics]
        
        # Simple linear trend calculation
        if len(memory_values) >= 3:
            time_span = (datetime.fromisoformat(timestamps[-1]) - 
                        datetime.fromisoformat(timestamps[0])).total_seconds() / 60.0  # minutes
            
            if time_span > 0:
                memory_change = memory_values[-1] - memory_values[0]
                trend_rate = memory_change / time_span  # % per minute
                
                current_memory = memory_values[-1]
                
                # Project when memory might hit critical levels
                if trend_rate > self.thresholds['memory_trend_rate']:
                    time_to_critical = (90.0 - current_memory) / trend_rate if trend_rate > 0 else float('inf')
                    
                    if time_to_critical < 5.0:  # Less than 5 minutes to critical
                        return self.create_alert(
                            AlertLevel.EMERGENCY,
                            f"Memory exhaustion imminent: {current_memory:.1f}% "
                            f"trending +{trend_rate:.1f}%/min, critical in {time_to_critical:.1f}min",
                            "memory_trend_critical",
                            {
                                'current_memory': current_memory,
                                'trend_rate': trend_rate,
                                'time_to_critical': time_to_critical
                            }
                        )
                    elif time_to_critical < 15.0:  # Less than 15 minutes to critical
                        return self.create_alert(
                            AlertLevel.CRITICAL,
                            f"Memory usage trending high: {current_memory:.1f}% "
                            f"+{trend_rate:.1f}%/min, critical in {time_to_critical:.1f}min",
                            "memory_trend_warning",
                            {
                                'current_memory': current_memory,
                                'trend_rate': trend_rate,
                                'time_to_critical': time_to_critical
                            }
                        )
        
        return None
    
    def analyze_cpu_patterns(self, metrics: Dict[str, Any]) -> Optional[Alert]:
        """Analyze CPU usage patterns"""
        if len(self.metrics_history) < 10:
            return None
        
        # Check for sustained high CPU usage
        recent_metrics = list(self.metrics_history)[-10:]
        cpu_values = [m['cpu']['percent'] for m in recent_metrics]
        
        sustained_high = all(cpu > self.thresholds['cpu_sustained_high'] for cpu in cpu_values)
        
        if sustained_high:
            avg_cpu = sum(cpu_values) / len(cpu_values)
            return self.create_alert(
                AlertLevel.WARNING,
                f"Sustained high CPU usage: {avg_cpu:.1f}% average over last 10 measurements",
                "cpu_sustained_high",
                {
                    'average_cpu': avg_cpu,
                    'measurements': len(cpu_values),
                    'threshold': self.thresholds['cpu_sustained_high']
                }
            )
        
        return None
    
    def analyze_process_growth(self, metrics: Dict[str, Any]) -> Optional[Alert]:
        """Analyze Claude process growth patterns"""
        if len(self.metrics_history) < 5:
            return None
        
        recent_metrics = list(self.metrics_history)[-5:]
        process_counts = [m['processes']['claude_count'] for m in recent_metrics]
        
        # Check for rapid process growth
        if len(process_counts) >= 3:
            growth = process_counts[-1] - process_counts[0]
            if growth >= 2:  # 2 or more new processes in recent measurements
                return self.create_alert(
                    AlertLevel.WARNING,
                    f"Rapid Claude process growth: {growth} new processes detected",
                    "process_growth",
                    {
                        'process_growth': growth,
                        'current_count': process_counts[-1],
                        'measurements': len(process_counts)
                    }
                )
        
        return None
    
    def analyze_system_stability(self, metrics: Dict[str, Any]) -> Optional[Alert]:
        """Analyze overall system stability indicators"""
        if len(self.metrics_history) < 5:
            return None
        
        recent_metrics = list(self.metrics_history)[-5:]
        
        # Check for multiple resource pressures
        memory_high = all(m['memory']['percent'] > 85.0 for m in recent_metrics)
        cpu_high = all(m['cpu']['percent'] > 75.0 for m in recent_metrics)
        process_high = any(m['processes']['claude_count'] > 5 for m in recent_metrics)
        
        if sum([memory_high, cpu_high, process_high]) >= 2:
            return self.create_alert(
                AlertLevel.CRITICAL,
                "Multiple resource pressure indicators detected - system instability risk",
                "system_instability",
                {
                    'memory_pressure': memory_high,
                    'cpu_pressure': cpu_high,
                    'process_pressure': process_high,
                    'current_metrics': metrics
                }
            )
        
        return None
    
    def analyze_error_patterns(self) -> Optional[Alert]:
        """Analyze error log patterns for warning signs"""
        try:
            # Check for recent error patterns in logs
            error_log = Path('/Users/nalve/.claude/logs/hooks/error-handler.log')
            
            if error_log.exists():
                # Read recent log entries
                with open(error_log, 'r') as f:
                    lines = f.readlines()
                
                # Check last 20 lines for error patterns
                recent_lines = lines[-20:] if len(lines) > 20 else lines
                error_count = sum(1 for line in recent_lines if '[ERROR]' in line)
                
                if error_count > 5:  # More than 5 errors in recent entries
                    return self.create_alert(
                        AlertLevel.WARNING,
                        f"High error rate detected: {error_count} errors in recent log entries",
                        "error_pattern",
                        {
                            'error_count': error_count,
                            'log_entries_checked': len(recent_lines)
                        }
                    )
        
        except Exception as e:
            self.logger.debug(f"Error analyzing log patterns: {e}")
        
        return None
    
    def check_disk_space_trends(self, metrics: Dict[str, Any]) -> Optional[Alert]:
        """Check disk space usage trends"""
        disk_percent = metrics['disk']['percent']
        
        if disk_percent > 90.0:
            return self.create_alert(
                AlertLevel.CRITICAL,
                f"Low disk space: {disk_percent:.1f}% used",
                "disk_space_critical",
                {
                    'disk_percent': disk_percent,
                    'free_gb': metrics['disk']['free'] / (1024**3)
                }
            )
        elif disk_percent > 85.0:
            return self.create_alert(
                AlertLevel.WARNING,
                f"Disk space getting low: {disk_percent:.1f}% used",
                "disk_space_warning",
                {
                    'disk_percent': disk_percent,
                    'free_gb': metrics['disk']['free'] / (1024**3)
                }
            )
        
        return None
    
    def perform_health_check(self) -> Dict[str, Any]:
        """Perform comprehensive system health check"""
        start_time = time.time()
        
        # Get current metrics
        metrics = self.resource_monitor.get_system_metrics()
        if not metrics:
            return {'error': 'Unable to get system metrics'}
        
        # Store metrics for trend analysis
        self.metrics_history.append(metrics)
        
        # Run all analysis functions
        potential_alerts = [
            self.analyze_memory_trends(metrics),
            self.analyze_cpu_patterns(metrics),
            self.analyze_process_growth(metrics),
            self.analyze_system_stability(metrics),
            self.analyze_error_patterns(),
            self.check_disk_space_trends(metrics)
        ]
        
        # Filter out None results
        new_alerts = [alert for alert in potential_alerts if alert is not None]
        
        check_duration = time.time() - start_time
        self.last_health_check = time.time()
        
        return {
            'timestamp': datetime.now().isoformat(),
            'check_duration': check_duration,
            'metrics': metrics,
            'new_alerts': len(new_alerts),
            'active_alerts': len(self.active_alerts),
            'system_status': self._determine_system_status()
        }
    
    def _determine_system_status(self) -> str:
        """Determine overall system status based on alerts"""
        if not self.active_alerts:
            return "healthy"
        
        alert_levels = [alert.level for alert in self.active_alerts.values()]
        
        if AlertLevel.EMERGENCY in alert_levels:
            return "emergency"
        elif AlertLevel.CRITICAL in alert_levels:
            return "critical"
        elif AlertLevel.WARNING in alert_levels:
            return "warning"
        else:
            return "info"
    
    def start_monitoring(self):
        """Start continuous monitoring"""
        if self.monitoring_active:
            self.logger.warning("Monitoring already active")
            return
        
        self.monitoring_active = True
        self.monitoring_thread = threading.Thread(target=self._monitoring_loop, daemon=True)
        self.monitoring_thread.start()
        
        self.logger.info(f"Early warning system started (check interval: {self.check_interval}s)")
    
    def stop_monitoring(self):
        """Stop continuous monitoring"""
        self.monitoring_active = False
        
        if self.monitoring_thread:
            self.monitoring_thread.join(timeout=5.0)
        
        self.logger.info("Early warning system stopped")
    
    def _monitoring_loop(self):
        """Main monitoring loop"""
        while self.monitoring_active:
            try:
                health_check = self.perform_health_check()
                
                # Log periodic health status
                if len(self.metrics_history) % 6 == 0:  # Every 6th check (roughly every minute)
                    status = health_check['system_status']
                    active_alerts = len(self.active_alerts)
                    self.logger.info(f"System status: {status} ({active_alerts} active alerts)")
                
                time.sleep(self.check_interval)
                
            except Exception as e:
                self.logger.error(f"Monitoring loop error: {e}")
                time.sleep(self.check_interval)
    
    def get_status_report(self) -> Dict[str, Any]:
        """Get comprehensive status report"""
        return {
            'monitoring_active': self.monitoring_active,
            'system_status': self._determine_system_status(),
            'active_alerts': [alert.to_dict() for alert in self.active_alerts.values()],
            'recent_alerts': [alert.to_dict() for alert in list(self.alert_history)[-10:]],
            'metrics_history_size': len(self.metrics_history),
            'last_health_check': self.last_health_check,
            'check_interval': self.check_interval,
            'thresholds': self.thresholds
        }

# Example alert callback function
def console_alert_handler(alert: Alert):
    """Example alert handler that prints to console"""
    timestamp = alert.timestamp.strftime('%H:%M:%S')
    print(f"🚨 [{timestamp}] {alert.level.value.upper()}: {alert.message}")

def log_alert_handler(alert: Alert):
    """Example alert handler that writes to dedicated alert log"""
    alert_log = Path('/Users/nalve/.claude/logs/alerts.log')
    alert_log.parent.mkdir(parents=True, exist_ok=True)
    
    with open(alert_log, 'a') as f:
        f.write(f"{alert.timestamp.isoformat()} [{alert.level.value.upper()}] "
                f"{alert.alert_type}: {alert.message}\n")

if __name__ == "__main__":
    # Example usage
    warning_system = EarlyWarningSystem(check_interval=5.0)
    
    # Add alert handlers
    warning_system.add_alert_callback(console_alert_handler)
    warning_system.add_alert_callback(log_alert_handler)
    
    print("=== Early Warning System Demo ===")
    
    # Perform manual health check
    health_check = warning_system.perform_health_check()
    print(f"Health check completed in {health_check['check_duration']:.3f}s")
    print(f"System status: {health_check['system_status']}")
    
    # Get status report
    status = warning_system.get_status_report()
    print(f"Active alerts: {len(status['active_alerts'])}")
    
    # Start monitoring for demonstration
    print("\nStarting monitoring for 30 seconds...")
    warning_system.start_monitoring()
    
    try:
        time.sleep(30)
    except KeyboardInterrupt:
        print("\nMonitoring interrupted")
    finally:
        warning_system.stop_monitoring()
        
    # Final status
    final_status = warning_system.get_status_report()
    print(f"Final status: {final_status['system_status']}")
    print(f"Total alerts generated: {len(warning_system.alert_history)}")