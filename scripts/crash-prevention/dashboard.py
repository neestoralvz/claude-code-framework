#!/usr/bin/env python3
"""
Claude Code Crash Prevention System Dashboard
Real-time monitoring and status display
"""

import json
import time
import os
from pathlib import Path
from datetime import datetime, timedelta
from typing import Dict, Any, Optional

class CrashPreventionDashboard:
    """Simple dashboard for monitoring crash prevention system"""
    
    def __init__(self):
        self.status_file = Path('/Users/nalve/.claude/logs/crash-prevention-status.json')
        self.log_file = Path('/Users/nalve/.claude/logs/continuous-monitor.log')
    
    def get_current_status(self) -> Optional[Dict[str, Any]]:
        """Get current system status"""
        try:
            if self.status_file.exists():
                with open(self.status_file, 'r') as f:
                    return json.load(f)
        except Exception:
            pass
        return None
    
    def format_status_indicator(self, active: bool) -> str:
        """Format status indicator"""
        return "🟢 ACTIVE" if active else "🔴 INACTIVE"
    
    def format_health_indicator(self, healthy: bool) -> str:
        """Format health indicator"""
        return "✅ HEALTHY" if healthy else "⚠️ UNHEALTHY"
    
    def format_score_indicator(self, score: float) -> str:
        """Format crash prevention score"""
        if score >= 0.8:
            return f"🟢 {score:.2f} (EXCELLENT)"
        elif score >= 0.6:
            return f"🟡 {score:.2f} (GOOD)"
        elif score >= 0.4:
            return f"🟠 {score:.2f} (FAIR)"
        else:
            return f"🔴 {score:.2f} (POOR)"
    
    def display_status(self):
        """Display current system status"""
        status = self.get_current_status()
        
        if not status:
            print("❌ No status data available - monitoring may not be running")
            return
        
        # Header
        print("="*70)
        print("🛡️  CLAUDE CODE CRASH PREVENTION SYSTEM DASHBOARD")
        print("="*70)
        
        # Timestamp
        timestamp = datetime.fromisoformat(status['timestamp'])
        age = datetime.now() - timestamp
        print(f"📅 Last Update: {timestamp.strftime('%Y-%m-%d %H:%M:%S')} ({age.seconds}s ago)")
        
        # Overall Status
        print(f"\n🔍 OVERALL STATUS:")
        print(f"   Crash Prevention Score: {self.format_score_indicator(status['crash_prevention_score'])}")
        print(f"   Active Alerts: {status['alerts_active']}")
        
        # Component Status
        print(f"\n⚙️  COMPONENT STATUS:")
        print(f"   Resource Monitor:     {self.format_status_indicator(status['resource_monitor_active'])}")
        print(f"   Early Warning:        {self.format_status_indicator(status['early_warning_active'])}")
        print(f"   Degradation Manager:  {self.format_status_indicator(status['degradation_manager_active'])}")
        print(f"   Bash Safety Limits:   {self.format_status_indicator(status['bash_limits_available'])}")
        print(f"   Python Components:    {self.format_health_indicator(status['python_components_healthy'])}")
        
        # System Load
        system_load = status['system_load']
        print(f"\n📊 SYSTEM RESOURCES:")
        print(f"   Memory Usage:    {system_load['memory_percent']:.1f}% ({system_load['memory_available_gb']:.1f}GB available)")
        print(f"   CPU Usage:       {system_load['cpu_percent']:.1f}%")
        print(f"   Disk Usage:      {system_load['disk_percent']:.1f}% ({system_load['disk_free_gb']:.1f}GB free)")
        print(f"   Claude Processes: {system_load['claude_processes']}")
        print(f"   System Health:   {self.format_health_indicator(system_load['healthy'])}")
        
        # Recommendations
        recommendations = self.get_recommendations(status)
        if recommendations:
            print(f"\n💡 RECOMMENDATIONS:")
            for i, rec in enumerate(recommendations, 1):
                print(f"   {i}. {rec}")
        
        print("="*70)
    
    def get_recommendations(self, status: Dict[str, Any]) -> list:
        """Generate recommendations based on status"""
        recommendations = []
        
        if status['crash_prevention_score'] < 0.5:
            recommendations.append("CRITICAL: Multiple components failing - restart monitoring system")
        
        if not status['resource_monitor_active']:
            recommendations.append("Resource monitor offline - restart crash prevention system")
        
        if not status['early_warning_active']:
            recommendations.append("Early warning system offline - check component health")
        
        if status['system_load']['memory_percent'] > 85:
            recommendations.append("High memory usage - consider reducing active operations")
        
        if status['system_load']['cpu_percent'] > 90:
            recommendations.append("High CPU usage - system may be under stress")
        
        if status['alerts_active'] > 5:
            recommendations.append("High number of alerts - investigate system issues")
        
        if not recommendations:
            recommendations.append("All systems operating normally")
        
        return recommendations
    
    def monitor_continuously(self, interval: int = 5):
        """Monitor continuously with live updates"""
        print("🔄 Starting live monitoring (Press Ctrl+C to stop)")
        print(f"   Update interval: {interval} seconds\n")
        
        try:
            while True:
                # Clear screen (basic)
                os.system('clear' if os.name == 'posix' else 'cls')
                
                self.display_status()
                
                print(f"\n⏱️  Next update in {interval} seconds...")
                time.sleep(interval)
                
        except KeyboardInterrupt:
            print("\n\n🛑 Live monitoring stopped")
    
    def show_logs(self, lines: int = 20):
        """Show recent log entries"""
        print(f"📋 RECENT LOG ENTRIES (last {lines} lines):")
        print("-" * 70)
        
        try:
            if self.log_file.exists():
                with open(self.log_file, 'r') as f:
                    log_lines = f.readlines()
                
                # Show last N lines
                recent_lines = log_lines[-lines:] if len(log_lines) > lines else log_lines
                
                for line in recent_lines:
                    print(line.rstrip())
            else:
                print("❌ Log file not found")
        except Exception as e:
            print(f"❌ Error reading logs: {e}")
        
        print("-" * 70)
    
    def show_help(self):
        """Show help information"""
        print("""
🛡️  Claude Code Crash Prevention Dashboard

Commands:
  python3 dashboard.py                 - Show current status
  python3 dashboard.py monitor         - Live monitoring mode
  python3 dashboard.py logs            - Show recent log entries
  python3 dashboard.py help            - Show this help

Examples:
  # Quick status check
  python3 dashboard.py
  
  # Live monitoring with updates every 3 seconds
  python3 dashboard.py monitor
  
  # Show last 50 log entries
  python3 dashboard.py logs
""")

def main():
    """Main function"""
    import sys
    
    dashboard = CrashPreventionDashboard()
    
    if len(sys.argv) == 1:
        # Default: show status
        dashboard.display_status()
    elif sys.argv[1] == 'monitor':
        # Live monitoring mode
        interval = int(sys.argv[2]) if len(sys.argv) > 2 else 5
        dashboard.monitor_continuously(interval)
    elif sys.argv[1] == 'logs':
        # Show logs
        lines = int(sys.argv[2]) if len(sys.argv) > 2 else 20
        dashboard.show_logs(lines)
    elif sys.argv[1] == 'help':
        # Show help
        dashboard.show_help()
    else:
        print(f"Unknown command: {sys.argv[1]}")
        dashboard.show_help()
        sys.exit(1)

if __name__ == "__main__":
    main()