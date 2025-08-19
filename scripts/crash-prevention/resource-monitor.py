#!/usr/bin/env python3
"""
Claude Code Resource Monitor
Real-time system resource monitoring with crash prevention capabilities
"""

import psutil
import time
import json
import logging
from datetime import datetime
from typing import Dict, List, Optional, Tuple
from pathlib import Path

class ResourceMonitor:
    """Monitors system resources to prevent crashes"""
    
    def __init__(self, config_file: Optional[str] = None):
        self.config = self._load_config(config_file)
        self.thresholds = self.config.get('thresholds', {})
        self.log_file = Path(self.config.get('log_file', '/Users/nalve/.claude/logs/resource-monitor.log'))
        self.setup_logging()
        
    def _load_config(self, config_file: Optional[str]) -> Dict:
        """Load configuration with defaults"""
        default_config = {
            'thresholds': {
                'memory_warning': 80.0,      # %
                'memory_critical': 90.0,     # %
                'cpu_warning': 75.0,         # %
                'cpu_critical': 90.0,        # %
                'disk_warning': 85.0,        # %
                'disk_critical': 95.0,       # %
                'process_memory_mb': 500,    # MB per process
                'max_processes': 5,          # Max Claude processes
                'check_interval': 5.0        # seconds
            },
            'log_file': '/Users/nalve/.claude/logs/resource-monitor.log'
        }
        
        if config_file and Path(config_file).exists():
            try:
                with open(config_file, 'r') as f:
                    user_config = json.load(f)
                    default_config.update(user_config)
            except Exception as e:
                logging.warning(f"Failed to load config {config_file}: {e}")
                
        return default_config
    
    def setup_logging(self):
        """Setup logging configuration"""
        self.log_file.parent.mkdir(parents=True, exist_ok=True)
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s [%(levelname)s] %(message)s',
            handlers=[
                logging.FileHandler(self.log_file),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)
    
    def get_system_metrics(self) -> Dict:
        """Get current system resource metrics"""
        try:
            # Memory metrics
            memory = psutil.virtual_memory()
            swap = psutil.swap_memory()
            
            # CPU metrics  
            cpu_percent = psutil.cpu_percent(interval=1.0)
            cpu_count = psutil.cpu_count()
            
            # Disk metrics
            disk = psutil.disk_usage('/')
            
            # Claude process metrics
            claude_processes = self.get_claude_processes()
            
            metrics = {
                'timestamp': datetime.now().isoformat(),
                'memory': {
                    'total': memory.total,
                    'available': memory.available,
                    'percent': memory.percent,
                    'used': memory.used,
                    'free': memory.free
                },
                'swap': {
                    'total': swap.total,
                    'used': swap.used,
                    'percent': swap.percent
                },
                'cpu': {
                    'percent': cpu_percent,
                    'count': cpu_count
                },
                'disk': {
                    'total': disk.total,
                    'used': disk.used,
                    'free': disk.free,
                    'percent': (disk.used / disk.total) * 100
                },
                'processes': {
                    'claude_count': len(claude_processes),
                    'claude_processes': claude_processes
                }
            }
            
            return metrics
            
        except Exception as e:
            self.logger.error(f"Failed to get system metrics: {e}")
            return {}
    
    def get_claude_processes(self) -> List[Dict]:
        """Get information about running Claude processes"""
        claude_processes = []
        
        for proc in psutil.process_iter(['pid', 'name', 'memory_info', 'cpu_percent']):
            try:
                if 'claude' in proc.info['name'].lower():
                    memory_mb = proc.info['memory_info'].rss / (1024 * 1024)
                    claude_processes.append({
                        'pid': proc.info['pid'],
                        'name': proc.info['name'],
                        'memory_mb': round(memory_mb, 2),
                        'cpu_percent': proc.info['cpu_percent']
                    })
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                continue
                
        return claude_processes
    
    def check_thresholds(self, metrics: Dict) -> List[Dict]:
        """Check if any thresholds are exceeded"""
        alerts = []
        
        # Memory checks
        memory_percent = metrics['memory']['percent']
        if memory_percent >= self.thresholds['memory_critical']:
            alerts.append({
                'type': 'CRITICAL',
                'resource': 'memory',
                'value': memory_percent,
                'threshold': self.thresholds['memory_critical'],
                'message': f"Memory usage critical: {memory_percent:.1f}%"
            })
        elif memory_percent >= self.thresholds['memory_warning']:
            alerts.append({
                'type': 'WARNING',
                'resource': 'memory',
                'value': memory_percent,
                'threshold': self.thresholds['memory_warning'],
                'message': f"Memory usage high: {memory_percent:.1f}%"
            })
        
        # CPU checks
        cpu_percent = metrics['cpu']['percent']
        if cpu_percent >= self.thresholds['cpu_critical']:
            alerts.append({
                'type': 'CRITICAL',
                'resource': 'cpu',
                'value': cpu_percent,
                'threshold': self.thresholds['cpu_critical'],
                'message': f"CPU usage critical: {cpu_percent:.1f}%"
            })
        elif cpu_percent >= self.thresholds['cpu_warning']:
            alerts.append({
                'type': 'WARNING',
                'resource': 'cpu',
                'value': cpu_percent,
                'threshold': self.thresholds['cpu_warning'],
                'message': f"CPU usage high: {cpu_percent:.1f}%"
            })
        
        # Disk checks
        disk_percent = metrics['disk']['percent']
        if disk_percent >= self.thresholds['disk_critical']:
            alerts.append({
                'type': 'CRITICAL',
                'resource': 'disk',
                'value': disk_percent,
                'threshold': self.thresholds['disk_critical'],
                'message': f"Disk usage critical: {disk_percent:.1f}%"
            })
        elif disk_percent >= self.thresholds['disk_warning']:
            alerts.append({
                'type': 'WARNING',
                'resource': 'disk',
                'value': disk_percent,
                'threshold': self.thresholds['disk_warning'],
                'message': f"Disk usage high: {disk_percent:.1f}%"
            })
        
        # Claude process checks
        claude_count = metrics['processes']['claude_count']
        if claude_count > self.thresholds['max_processes']:
            alerts.append({
                'type': 'WARNING',
                'resource': 'processes',
                'value': claude_count,
                'threshold': self.thresholds['max_processes'],
                'message': f"Too many Claude processes: {claude_count}"
            })
        
        # Individual process memory checks
        for proc in metrics['processes']['claude_processes']:
            if proc['memory_mb'] > self.thresholds['process_memory_mb']:
                alerts.append({
                    'type': 'WARNING',
                    'resource': 'process_memory',
                    'value': proc['memory_mb'],
                    'threshold': self.thresholds['process_memory_mb'],
                    'message': f"Claude process {proc['pid']} using {proc['memory_mb']:.1f}MB"
                })
        
        return alerts
    
    def should_prevent_operation(self, operation_type: str = 'default') -> Tuple[bool, str]:
        """Check if operation should be prevented due to resource constraints"""
        metrics = self.get_system_metrics()
        alerts = self.check_thresholds(metrics)
        
        # Find critical alerts
        critical_alerts = [a for a in alerts if a['type'] == 'CRITICAL']
        
        if critical_alerts:
            reasons = [alert['message'] for alert in critical_alerts]
            return True, f"Operation prevented: {'; '.join(reasons)}"
        
        # Check operation-specific thresholds
        if operation_type == 'bulk_file_ops':
            memory_percent = metrics['memory']['percent']
            claude_count = metrics['processes']['claude_count']
            
            if memory_percent > 85.0 or claude_count > 3:
                return True, f"Bulk operations prevented: Memory {memory_percent:.1f}%, Claude processes {claude_count}"
        
        return False, ""
    
    def log_metrics(self, metrics: Dict, alerts: List[Dict]):
        """Log metrics and alerts"""
        if alerts:
            for alert in alerts:
                if alert['type'] == 'CRITICAL':
                    self.logger.critical(alert['message'])
                else:
                    self.logger.warning(alert['message'])
        
        # Log summary every 10 checks
        if not hasattr(self, '_check_count'):
            self._check_count = 0
        self._check_count += 1
        
        if self._check_count % 10 == 0:
            self.logger.info(f"System Status: Memory {metrics['memory']['percent']:.1f}%, "
                           f"CPU {metrics['cpu']['percent']:.1f}%, "
                           f"Disk {metrics['disk']['percent']:.1f}%, "
                           f"Claude processes {metrics['processes']['claude_count']}")
    
    def monitor_loop(self):
        """Main monitoring loop"""
        self.logger.info("Starting resource monitor")
        
        try:
            while True:
                metrics = self.get_system_metrics()
                if metrics:
                    alerts = self.check_thresholds(metrics)
                    self.log_metrics(metrics, alerts)
                
                time.sleep(self.thresholds['check_interval'])
                
        except KeyboardInterrupt:
            self.logger.info("Resource monitor stopped")
        except Exception as e:
            self.logger.error(f"Monitor loop error: {e}")

if __name__ == "__main__":
    monitor = ResourceMonitor()
    monitor.monitor_loop()