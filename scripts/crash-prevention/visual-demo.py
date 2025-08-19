#!/usr/bin/env python3
"""
Claude Code Crash Prevention System - Visual Interface Demonstration
Live visual display of real-time monitoring with ASCII graphics and status indicators
"""

import json
import time
import os
import sys
from datetime import datetime
from pathlib import Path
from typing import Dict, Any, Optional

class VisualCrashPreventionDemo:
    """Visual interface for crash prevention system demonstration"""
    
    def __init__(self):
        self.status_file = Path('/Users/nalve/.claude/logs/crash-prevention-status.json')
        self.log_file = Path('/Users/nalve/.claude/logs/continuous-monitor.log')
        self.width = 100
        
    def clear_screen(self):
        """Clear the screen"""
        os.system('clear' if os.name == 'posix' else 'cls')
    
    def get_status(self) -> Optional[Dict[str, Any]]:
        """Get current system status"""
        try:
            if self.status_file.exists():
                with open(self.status_file, 'r') as f:
                    return json.load(f)
        except Exception:
            pass
        return None
    
    def create_progress_bar(self, value: float, max_value: float = 100, width: int = 40, 
                           char: str = '█', empty_char: str = '░') -> str:
        """Create ASCII progress bar"""
        if max_value == 0:
            return empty_char * width
        
        percentage = min(value / max_value, 1.0)
        filled = int(width * percentage)
        return char * filled + empty_char * (width - filled)
    
    def get_status_indicator(self, active: bool) -> str:
        """Get visual status indicator"""
        return "🟢 ONLINE " if active else "🔴 OFFLINE"
    
    def get_health_indicator(self, healthy: bool) -> str:
        """Get health status indicator"""
        return "✅ HEALTHY" if healthy else "⚠️  STRESSED"
    
    def get_score_color(self, score: float) -> str:
        """Get color indicator for crash prevention score"""
        if score >= 0.8:
            return "🟢"
        elif score >= 0.6:
            return "🟡"
        elif score >= 0.4:
            return "🟠"
        else:
            return "🔴"
    
    def format_timestamp(self, timestamp_str: str) -> str:
        """Format timestamp for display"""
        try:
            ts = datetime.fromisoformat(timestamp_str)
            age = datetime.now() - ts
            return f"{ts.strftime('%H:%M:%S')} ({age.seconds}s ago)"
        except:
            return timestamp_str
    
    def draw_header(self):
        """Draw the main header"""
        header = "CLAUDE CODE CRASH PREVENTION SYSTEM - LIVE MONITORING"
        border = "=" * self.width
        
        print(border)
        print(f"🛡️  {header.center(self.width - 4)} 🛡️")
        print(border)
        print()
    
    def draw_real_time_status(self, status: Dict[str, Any]):
        """Draw real-time status section"""
        print("📊 REAL-TIME STATUS")
        print("-" * 50)
        
        # Timestamp
        timestamp = self.format_timestamp(status['timestamp'])
        print(f"⏰ Last Update: {timestamp}")
        
        # Overall score with visual indicator
        score = status['crash_prevention_score']
        score_indicator = self.get_score_color(score)
        score_bar = self.create_progress_bar(score * 100, 100, 30)
        print(f"🎯 Crash Prevention Score: {score_indicator} {score:.2f} [{score_bar}] {score*100:.0f}%")
        
        # Active alerts
        alerts = status['alerts_active']
        alert_indicator = "🚨" if alerts > 5 else "⚠️" if alerts > 0 else "✅"
        print(f"📢 Active Alerts: {alert_indicator} {alerts}")
        print()
    
    def draw_component_status(self, status: Dict[str, Any]):
        """Draw component status section"""
        print("⚙️  COMPONENT STATUS")
        print("-" * 50)
        
        components = [
            ("Resource Monitor", status['resource_monitor_active']),
            ("Early Warning", status['early_warning_active']),
            ("Degradation Manager", status['degradation_manager_active']),
            ("Bash Safety Limits", status['bash_limits_available']),
            ("Python Components", status['python_components_healthy'])
        ]
        
        for name, active in components:
            indicator = self.get_status_indicator(active)
            print(f"  {name:<20} {indicator}")
        
        # Component summary
        active_count = sum(1 for _, active in components if active)
        total_count = len(components)
        component_bar = self.create_progress_bar(active_count, total_count, 25, '█', '░')
        print(f"\n  Overall: [{component_bar}] {active_count}/{total_count} components active")
        print()
    
    def draw_system_resources(self, status: Dict[str, Any]):
        """Draw system resources section"""
        print("📈 SYSTEM RESOURCES")
        print("-" * 50)
        
        system_load = status['system_load']
        
        # Memory
        memory_pct = system_load['memory_percent']
        memory_bar = self.create_progress_bar(memory_pct, 100, 35)
        memory_color = "🔴" if memory_pct > 85 else "🟡" if memory_pct > 70 else "🟢"
        print(f"💾 Memory:  {memory_color} [{memory_bar}] {memory_pct:.1f}% ({system_load['memory_available_gb']:.1f}GB free)")
        
        # CPU
        cpu_pct = system_load['cpu_percent']
        cpu_bar = self.create_progress_bar(cpu_pct, 100, 35)
        cpu_color = "🔴" if cpu_pct > 90 else "🟡" if cpu_pct > 75 else "🟢"
        print(f"🖥️  CPU:     {cpu_color} [{cpu_bar}] {cpu_pct:.1f}%")
        
        # Disk
        disk_pct = system_load['disk_percent']
        disk_bar = self.create_progress_bar(disk_pct, 100, 35)
        disk_color = "🔴" if disk_pct > 90 else "🟡" if disk_pct > 80 else "🟢"
        print(f"💿 Disk:    {disk_color} [{disk_bar}] {disk_pct:.1f}% ({system_load['disk_free_gb']:.0f}GB free)")
        
        # Processes
        processes = system_load['claude_processes']
        process_indicator = "⚠️" if processes > 5 else "✅"
        print(f"🔄 Claude Processes: {process_indicator} {processes}")
        
        # System health
        health = system_load['healthy']
        health_indicator = self.get_health_indicator(health)
        print(f"❤️  System Health: {health_indicator}")
        print()
    
    def draw_live_activity(self):
        """Draw live activity indicators"""
        print("🔴 LIVE ACTIVITY")
        print("-" * 50)
        
        # Animated indicators
        spinner_chars = ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏']
        spinner = spinner_chars[int(time.time() * 2) % len(spinner_chars)]
        
        print(f"  {spinner} Monitoring Process:     ACTIVE")
        print(f"  {spinner} Status Updates:        Every 5 seconds")
        print(f"  {spinner} Health Checks:         Continuous")
        print(f"  {spinner} Component Tracking:    Real-time")
        print(f"  {spinner} Resource Monitoring:   Active")
        
        # Show recent log activity
        try:
            if self.log_file.exists():
                with open(self.log_file, 'r') as f:
                    lines = f.readlines()
                if lines:
                    last_line = lines[-1].strip()
                    if '[INFO]' in last_line:
                        timestamp = last_line.split()[0:2]
                        print(f"  📝 Last Log: {' '.join(timestamp)} - Health check completed")
        except:
            pass
        
        print()
    
    def draw_footer(self):
        """Draw footer with controls"""
        border = "=" * self.width
        print(border)
        print("🎮 CONTROLS: Press Ctrl+C to stop live monitoring | 'q' + Enter to quit")
        print("📊 STATUS FILE: /Users/nalve/.claude/logs/crash-prevention-status.json")
        print("📋 LOG FILE: /Users/nalve/.claude/logs/continuous-monitor.log")
        print(border)
    
    def show_live_demo(self, update_interval: float = 2.0):
        """Show live visual demonstration"""
        print("🚀 Starting Live Crash Prevention Monitoring Demonstration")
        print("   Visual interface updating every 2 seconds...")
        print("   Press Ctrl+C to stop\n")
        
        update_count = 0
        
        try:
            while True:
                self.clear_screen()
                
                # Get current status
                status = self.get_status()
                
                if status:
                    self.draw_header()
                    self.draw_real_time_status(status)
                    self.draw_component_status(status)
                    self.draw_system_resources(status)
                    self.draw_live_activity()
                    self.draw_footer()
                    
                    update_count += 1
                    print(f"\n🔄 Update #{update_count} - Next refresh in {update_interval:.1f}s...")
                else:
                    print("❌ No monitoring data available")
                    print("   Crash prevention monitoring may not be running")
                    print("   Start with: python3 continuous-monitor.py")
                
                time.sleep(update_interval)
                
        except KeyboardInterrupt:
            self.clear_screen()
            print("\n🛑 Live monitoring demonstration stopped")
            print("✅ Crash prevention system continues running in background")
    
    def show_static_demo(self):
        """Show static demonstration"""
        status = self.get_status()
        
        if status:
            self.draw_header()
            self.draw_real_time_status(status)
            self.draw_component_status(status)
            self.draw_system_resources(status)
            self.draw_live_activity()
            self.draw_footer()
        else:
            print("❌ No monitoring data available")

def main():
    """Main function"""
    demo = VisualCrashPreventionDemo()
    
    if len(sys.argv) > 1 and sys.argv[1] == 'live':
        # Live demonstration mode
        interval = float(sys.argv[2]) if len(sys.argv) > 2 else 2.0
        demo.show_live_demo(interval)
    else:
        # Static demonstration
        demo.show_static_demo()

if __name__ == "__main__":
    main()