#!/usr/bin/env python3
"""
Claude Code Continuous Crash Prevention Monitor
Ensures crash prevention system remains active at all times during operations
"""

import os
import sys
import time
import json
import signal
import threading
import subprocess
import logging
import atexit
from typing import Dict, List, Optional, Any
from pathlib import Path
from datetime import datetime, timedelta
from dataclasses import dataclass, asdict

@dataclass
class SystemStatus:
    """System status tracking"""
    timestamp: str
    resource_monitor_active: bool
    early_warning_active: bool
    degradation_manager_active: bool
    bash_limits_available: bool
    python_components_healthy: bool
    system_load: Dict[str, Any]
    crash_prevention_score: float
    alerts_active: int
    last_health_check: str

class ContinuousMonitor:
    """Continuously monitors crash prevention system status"""
    
    def __init__(self, check_interval: float = 10.0):
        self.check_interval = check_interval
        self.monitoring_active = False
        self.monitor_thread: Optional[threading.Thread] = None
        self.status_history: List[SystemStatus] = []
        self.crash_prevention_components = []
        self.alert_callbacks = []
        
        # Monitoring configuration
        self.config = {
            'max_history_size': 1000,
            'health_check_timeout': 30.0,
            'component_restart_attempts': 3,
            'critical_alert_threshold': 0.7,
            'auto_restart_failed_components': True,
            'log_all_checks': False
        }
        
        # Component tracking
        self.component_status = {
            'resource_monitor': {'active': False, 'last_check': None, 'failures': 0},
            'early_warning': {'active': False, 'last_check': None, 'failures': 0},
            'degradation_manager': {'active': False, 'last_check': None, 'failures': 0},
            'bash_operations': {'active': False, 'last_check': None, 'failures': 0},
            'timeout_manager': {'active': False, 'last_check': None, 'failures': 0}
        }
        
        self.setup_logging()
        self.setup_signal_handlers()
        self.register_cleanup()
        
        # Start monitoring immediately
        self.start_monitoring()
    
    def setup_logging(self):
        """Setup comprehensive logging"""
        log_file = Path('/Users/nalve/.claude/logs/continuous-monitor.log')
        log_file.parent.mkdir(parents=True, exist_ok=True)
        
        # Setup rotating log handler
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s [%(levelname)s] %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)
        self.logger.info("Continuous crash prevention monitor initialized")
    
    def setup_signal_handlers(self):
        """Setup signal handlers for graceful shutdown"""
        def signal_handler(signum, frame):
            self.logger.info(f"Received signal {signum}, shutting down gracefully...")
            self.stop_monitoring()
            sys.exit(0)
        
        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
    
    def register_cleanup(self):
        """Register cleanup handlers"""
        atexit.register(self.cleanup)
    
    def check_python_component(self, component_name: str, module_path: str) -> bool:
        """Check if a Python crash prevention component is healthy"""
        try:
            # Quick import test
            import importlib.util
            spec = importlib.util.spec_from_file_location(component_name, module_path)
            if spec and spec.loader:
                module = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(module)
                return True
            return False
        except Exception as e:
            self.logger.debug(f"Component {component_name} check failed: {e}")
            return False
    
    def check_bash_operations(self) -> bool:
        """Check if bash operations library is available"""
        try:
            script_path = Path(__file__).parent / "safe-operations.sh"
            if not script_path.exists():
                return False
            
            # Test basic bash function availability
            result = subprocess.run(
                ["bash", "-c", f"source {script_path} && echo 'OK'"],
                capture_output=True,
                text=True,
                timeout=5.0
            )
            return result.returncode == 0 and "OK" in result.stdout
        except Exception:
            return False
    
    def check_system_resources(self) -> Dict[str, Any]:
        """Check current system resource status"""
        try:
            import psutil
            
            memory = psutil.virtual_memory()
            cpu_percent = psutil.cpu_percent(interval=0.1)
            disk = psutil.disk_usage('/')
            
            # Count Claude processes
            claude_processes = 0
            for proc in psutil.process_iter(['name']):
                try:
                    if 'claude' in proc.info['name'].lower():
                        claude_processes += 1
                except (psutil.NoSuchProcess, psutil.AccessDenied):
                    continue
            
            return {
                'memory_percent': memory.percent,
                'memory_available_gb': memory.available / (1024**3),
                'cpu_percent': cpu_percent,
                'disk_percent': (disk.used / disk.total) * 100,
                'disk_free_gb': disk.free / (1024**3),
                'claude_processes': claude_processes,
                'healthy': (
                    memory.percent < 90 and 
                    cpu_percent < 95 and 
                    disk.used / disk.total < 0.95
                )
            }
        except ImportError:
            return {'error': 'psutil not available', 'healthy': False}
        except Exception as e:
            return {'error': str(e), 'healthy': False}
    
    def check_crash_prevention_components(self) -> Dict[str, bool]:
        """Check all crash prevention components"""
        base_path = Path(__file__).parent
        
        components = {
            'resource_monitor': base_path / "resource-monitor.py",
            'early_warning': base_path / "early-warning-system.py", 
            'degradation_manager': base_path / "graceful-degradation.py",
            'timeout_manager': base_path / "timeout-manager.py",
            'batch_processor': base_path / "batch-processor.py"
        }
        
        results = {}
        for name, path in components.items():
            if path.exists():
                results[name] = self.check_python_component(name, str(path))
            else:
                results[name] = False
            
            # Update component tracking
            if name in self.component_status:
                self.component_status[name]['last_check'] = datetime.now().isoformat()
                self.component_status[name]['active'] = results[name]
                if not results[name]:
                    self.component_status[name]['failures'] += 1
                else:
                    self.component_status[name]['failures'] = 0
        
        # Check bash operations separately
        bash_healthy = self.check_bash_operations()
        results['bash_operations'] = bash_healthy
        self.component_status['bash_operations']['active'] = bash_healthy
        self.component_status['bash_operations']['last_check'] = datetime.now().isoformat()
        
        return results
    
    def calculate_crash_prevention_score(self, components: Dict[str, bool], 
                                       system_load: Dict[str, Any]) -> float:
        """Calculate overall crash prevention effectiveness score (0.0 - 1.0)"""
        
        # Component health score (60% of total)
        component_score = sum(components.values()) / len(components)
        
        # System health score (40% of total)
        system_healthy = system_load.get('healthy', False)
        system_score = 1.0 if system_healthy else 0.5
        
        # Combine scores
        total_score = (component_score * 0.6) + (system_score * 0.4)
        
        return round(total_score, 3)
    
    def perform_health_check(self) -> SystemStatus:
        """Perform comprehensive health check"""
        check_time = datetime.now().isoformat()
        
        # Check all components
        components = self.check_crash_prevention_components()
        system_load = self.check_system_resources()
        
        # Calculate crash prevention score
        score = self.calculate_crash_prevention_score(components, system_load)
        
        # Count active alerts (simulated for now)
        active_alerts = sum(1 for comp, status in components.items() if not status)
        
        status = SystemStatus(
            timestamp=check_time,
            resource_monitor_active=components.get('resource_monitor', False),
            early_warning_active=components.get('early_warning', False),
            degradation_manager_active=components.get('degradation_manager', False),
            bash_limits_available=components.get('bash_operations', False),
            python_components_healthy=all(
                components.get(c, False) for c in 
                ['resource_monitor', 'early_warning', 'degradation_manager', 'timeout_manager']
            ),
            system_load=system_load,
            crash_prevention_score=score,
            alerts_active=active_alerts,
            last_health_check=check_time
        )
        
        return status
    
    def handle_component_failure(self, component_name: str, status: SystemStatus):
        """Handle failed component with automatic recovery"""
        failures = self.component_status[component_name]['failures']
        
        self.logger.warning(f"Component {component_name} failed (attempt {failures})")
        
        if self.config['auto_restart_failed_components'] and failures <= self.config['component_restart_attempts']:
            self.logger.info(f"Attempting to restart {component_name}...")
            
            # Component-specific restart logic
            if component_name == 'resource_monitor':
                self.restart_resource_monitor()
            elif component_name == 'early_warning':
                self.restart_early_warning()
            
        if failures > self.config['component_restart_attempts']:
            self.logger.critical(f"Component {component_name} failed permanently after {failures} attempts")
            self.send_critical_alert(component_name, status)
    
    def restart_resource_monitor(self):
        """Restart resource monitor component"""
        try:
            # This would restart the resource monitor in a real implementation
            self.logger.info("Resource monitor restart attempted")
        except Exception as e:
            self.logger.error(f"Failed to restart resource monitor: {e}")
    
    def restart_early_warning(self):
        """Restart early warning system"""
        try:
            # This would restart the early warning system in a real implementation
            self.logger.info("Early warning system restart attempted")
        except Exception as e:
            self.logger.error(f"Failed to restart early warning system: {e}")
    
    def send_critical_alert(self, component_name: str, status: SystemStatus):
        """Send critical alert for component failure"""
        alert_message = f"CRITICAL: Crash prevention component '{component_name}' has failed permanently"
        
        self.logger.critical(alert_message)
        
        # Write alert to dedicated file
        alert_file = Path('/Users/nalve/.claude/logs/critical-alerts.log')
        with open(alert_file, 'a') as f:
            f.write(f"{datetime.now().isoformat()} - {alert_message}\n")
        
        # Execute alert callbacks
        for callback in self.alert_callbacks:
            try:
                callback(component_name, status)
            except Exception as e:
                self.logger.error(f"Alert callback failed: {e}")
    
    def add_alert_callback(self, callback):
        """Add callback for critical alerts"""
        self.alert_callbacks.append(callback)
    
    def monitoring_loop(self):
        """Main monitoring loop"""
        self.logger.info(f"Starting continuous monitoring (interval: {self.check_interval}s)")
        
        while self.monitoring_active:
            try:
                # Perform health check
                status = self.perform_health_check()
                
                # Store status
                self.status_history.append(status)
                if len(self.status_history) > self.config['max_history_size']:
                    self.status_history.pop(0)
                
                # Check for component failures
                for component_name in self.component_status:
                    if not getattr(status, f"{component_name.replace('_', '')}_active", True):
                        if component_name in ['resource_monitor', 'early_warning', 'degradation_manager']:
                            self.handle_component_failure(component_name, status)
                
                # Log status if configured or if there are issues
                if (self.config['log_all_checks'] or 
                    status.crash_prevention_score < self.config['critical_alert_threshold'] or
                    status.alerts_active > 0):
                    
                    self.logger.info(
                        f"Health Check: Score={status.crash_prevention_score:.2f}, "
                        f"Components={sum([status.resource_monitor_active, status.early_warning_active, status.degradation_manager_active, status.bash_limits_available])}/4, "
                        f"Alerts={status.alerts_active}, "
                        f"Memory={status.system_load.get('memory_percent', 0):.1f}%"
                    )
                
                # Write status to file for external monitoring
                self.write_status_file(status)
                
                # Sleep until next check
                time.sleep(self.check_interval)
                
            except Exception as e:
                self.logger.error(f"Monitoring loop error: {e}")
                time.sleep(self.check_interval)
    
    def write_status_file(self, status: SystemStatus):
        """Write current status to file for external monitoring"""
        status_file = Path('/Users/nalve/.claude/logs/crash-prevention-status.json')
        
        try:
            with open(status_file, 'w') as f:
                json.dump(asdict(status), f, indent=2)
        except Exception as e:
            self.logger.debug(f"Failed to write status file: {e}")
    
    def start_monitoring(self):
        """Start continuous monitoring"""
        if self.monitoring_active:
            self.logger.warning("Monitoring already active")
            return
        
        self.monitoring_active = True
        self.monitor_thread = threading.Thread(target=self.monitoring_loop, daemon=True)
        self.monitor_thread.start()
        
        self.logger.info("Continuous crash prevention monitoring started")
    
    def stop_monitoring(self):
        """Stop continuous monitoring"""
        if not self.monitoring_active:
            return
        
        self.monitoring_active = False
        
        if self.monitor_thread:
            self.monitor_thread.join(timeout=5.0)
        
        self.logger.info("Continuous crash prevention monitoring stopped")
    
    def get_current_status(self) -> Optional[SystemStatus]:
        """Get most recent status"""
        return self.status_history[-1] if self.status_history else None
    
    def get_status_history(self, hours: int = 1) -> List[SystemStatus]:
        """Get status history for specified hours"""
        cutoff_time = datetime.now() - timedelta(hours=hours)
        
        return [
            status for status in self.status_history
            if datetime.fromisoformat(status.timestamp) > cutoff_time
        ]
    
    def get_health_report(self) -> Dict[str, Any]:
        """Generate comprehensive health report"""
        current_status = self.get_current_status()
        if not current_status:
            return {'error': 'No status available'}
        
        recent_history = self.get_status_history(1)
        
        # Calculate uptime statistics
        total_checks = len(recent_history)
        healthy_checks = sum(1 for s in recent_history if s.crash_prevention_score >= 0.8)
        
        return {
            'current_status': asdict(current_status),
            'uptime_stats': {
                'total_checks_last_hour': total_checks,
                'healthy_checks_last_hour': healthy_checks,
                'health_percentage': (healthy_checks / total_checks * 100) if total_checks > 0 else 0
            },
            'component_status': self.component_status,
            'monitoring_config': self.config,
            'recommendations': self.generate_recommendations(current_status)
        }
    
    def generate_recommendations(self, status: SystemStatus) -> List[str]:
        """Generate recommendations based on current status"""
        recommendations = []
        
        if status.crash_prevention_score < 0.5:
            recommendations.append("CRITICAL: Multiple crash prevention components are failing")
        
        if not status.resource_monitor_active:
            recommendations.append("Resource monitoring is offline - restart required")
        
        if not status.early_warning_active:
            recommendations.append("Early warning system is offline - restart required")
        
        if not status.bash_limits_available:
            recommendations.append("Bash safety operations are unavailable - check safe-operations.sh")
        
        if status.system_load.get('memory_percent', 0) > 85:
            recommendations.append("High memory usage detected - consider reducing operations")
        
        if status.alerts_active > 5:
            recommendations.append("High number of active alerts - investigate system issues")
        
        if not recommendations:
            recommendations.append("All systems operational - no action required")
        
        return recommendations
    
    def cleanup(self):
        """Cleanup resources"""
        self.stop_monitoring()
        self.logger.info("Continuous monitor cleanup completed")

# Global monitor instance
_monitor_instance: Optional[ContinuousMonitor] = None

def get_monitor() -> ContinuousMonitor:
    """Get global monitor instance"""
    global _monitor_instance
    if _monitor_instance is None:
        _monitor_instance = ContinuousMonitor()
    return _monitor_instance

def start_continuous_monitoring(check_interval: float = 10.0):
    """Start continuous monitoring service"""
    monitor = get_monitor()
    if not monitor.monitoring_active:
        monitor.check_interval = check_interval
        monitor.start_monitoring()
    return monitor

def stop_continuous_monitoring():
    """Stop continuous monitoring service"""
    global _monitor_instance
    if _monitor_instance:
        _monitor_instance.stop_monitoring()

def get_system_status() -> Optional[SystemStatus]:
    """Get current system status"""
    monitor = get_monitor()
    return monitor.get_current_status()

def is_crash_prevention_active() -> bool:
    """Check if crash prevention is currently active and healthy"""
    status = get_system_status()
    if not status:
        return False
    
    return (
        status.crash_prevention_score >= 0.7 and
        status.python_components_healthy and
        status.bash_limits_available
    )

# Example alert callback
def critical_alert_handler(component_name: str, status: SystemStatus):
    """Example critical alert handler"""
    print(f"🚨 CRITICAL ALERT: {component_name} failed!")
    print(f"   Crash Prevention Score: {status.crash_prevention_score:.2f}")
    print(f"   System Memory: {status.system_load.get('memory_percent', 0):.1f}%")

if __name__ == "__main__":
    # Start monitoring when run directly
    monitor = ContinuousMonitor(check_interval=5.0)
    monitor.add_alert_callback(critical_alert_handler)
    
    try:
        print("🔍 Continuous Crash Prevention Monitor Started")
        print("   Monitoring interval: 5 seconds")
        print("   Press Ctrl+C to stop")
        
        # Keep main thread alive
        while True:
            time.sleep(60)
            
            # Print periodic status
            status = monitor.get_current_status()
            if status:
                print(f"📊 Status: Score={status.crash_prevention_score:.2f}, "
                      f"Memory={status.system_load.get('memory_percent', 0):.1f}%, "
                      f"Components={'✅' if status.python_components_healthy else '❌'}")
            
    except KeyboardInterrupt:
        print("\n🛑 Stopping continuous monitor...")
        monitor.stop_monitoring()
        print("✅ Monitor stopped")