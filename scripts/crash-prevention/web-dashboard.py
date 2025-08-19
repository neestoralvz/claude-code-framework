#!/usr/bin/env python3
"""
Claude Code Crash Prevention System - Web Dashboard
Modern web-based interface for real-time monitoring
"""

import json
import time
import os
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, Optional
from http.server import HTTPServer, BaseHTTPRequestHandler
import urllib.parse
import threading

class CrashPreventionWebServer(BaseHTTPRequestHandler):
    """Web server for crash prevention dashboard"""
    
    def __init__(self, *args, **kwargs):
        self.status_file = Path('/Users/nalve/.claude/logs/crash-prevention-status.json')
        self.log_file = Path('/Users/nalve/.claude/logs/continuous-monitor.log')
        super().__init__(*args, **kwargs)
    
    def do_GET(self):
        """Handle GET requests"""
        if self.path == '/':
            self.serve_dashboard()
        elif self.path == '/api/status':
            self.serve_status_api()
        elif self.path == '/api/logs':
            self.serve_logs_api()
        elif self.path.startswith('/static/'):
            self.serve_static()
        else:
            self.send_error(404)
    
    def serve_dashboard(self):
        """Serve the main dashboard HTML"""
        html_content = self.generate_dashboard_html()
        
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.send_header('Cache-Control', 'no-cache')
        self.end_headers()
        self.wfile.write(html_content.encode('utf-8'))
    
    def serve_status_api(self):
        """Serve status data as JSON API"""
        try:
            if self.status_file.exists():
                with open(self.status_file, 'r') as f:
                    status_data = json.load(f)
                
                # Add server timestamp
                status_data['server_timestamp'] = datetime.now().isoformat()
                
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.send_header('Cache-Control', 'no-cache')
                self.end_headers()
                self.wfile.write(json.dumps(status_data, indent=2).encode('utf-8'))
            else:
                self.send_error(404, "Status file not found")
        except Exception as e:
            self.send_error(500, f"Error reading status: {e}")
    
    def serve_logs_api(self):
        """Serve recent logs as JSON API"""
        try:
            if self.log_file.exists():
                with open(self.log_file, 'r') as f:
                    lines = f.readlines()
                
                # Get last 50 lines
                recent_lines = lines[-50:] if len(lines) > 50 else lines
                
                log_data = {
                    'logs': [line.strip() for line in recent_lines],
                    'total_lines': len(lines),
                    'timestamp': datetime.now().isoformat()
                }
                
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.send_header('Cache-Control', 'no-cache')
                self.end_headers()
                self.wfile.write(json.dumps(log_data, indent=2).encode('utf-8'))
            else:
                self.send_error(404, "Log file not found")
        except Exception as e:
            self.send_error(500, f"Error reading logs: {e}")
    
    def serve_static(self):
        """Serve static files (CSS, JS)"""
        # For this demo, we'll inline everything in the HTML
        self.send_error(404)
    
    def generate_dashboard_html(self) -> str:
        """Generate the complete dashboard HTML with embedded CSS and JavaScript"""
        return """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Claude Code Crash Prevention Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }
        
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        
        .status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 20px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
        
        .card h3 {
            font-size: 1.3em;
            margin-bottom: 15px;
            color: #4fc3f7;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .metric {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 10px 0;
            padding: 8px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .metric:last-child {
            border-bottom: none;
        }
        
        .metric-label {
            font-weight: 500;
        }
        
        .metric-value {
            font-weight: bold;
            font-size: 1.1em;
        }
        
        .progress-bar {
            width: 100%;
            height: 8px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 4px;
            overflow: hidden;
            margin: 5px 0;
        }
        
        .progress-fill {
            height: 100%;
            transition: width 0.3s ease;
            border-radius: 4px;
        }
        
        .progress-good { background: #4caf50; }
        .progress-warning { background: #ff9800; }
        .progress-critical { background: #f44336; }
        
        .status-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 8px;
        }
        
        .status-online { background: #4caf50; box-shadow: 0 0 10px #4caf50; }
        .status-offline { background: #f44336; box-shadow: 0 0 10px #f44336; }
        .status-warning { background: #ff9800; box-shadow: 0 0 10px #ff9800; }
        
        .live-indicator {
            display: inline-block;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        
        .logs-section {
            margin-top: 30px;
        }
        
        .logs-container {
            background: rgba(0, 0, 0, 0.3);
            border-radius: 10px;
            padding: 20px;
            max-height: 400px;
            overflow-y: auto;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            line-height: 1.4;
        }
        
        .log-entry {
            margin: 2px 0;
            padding: 2px 0;
        }
        
        .log-info { color: #4fc3f7; }
        .log-warning { color: #ff9800; }
        .log-error { color: #f44336; }
        
        .update-info {
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            font-size: 0.9em;
        }
        
        .alert-badge {
            display: inline-block;
            background: #f44336;
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8em;
            font-weight: bold;
            margin-left: 10px;
        }
        
        .score-display {
            text-align: center;
            margin: 20px 0;
        }
        
        .score-circle {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            font-weight: bold;
            border: 4px solid;
            transition: all 0.3s ease;
        }
        
        .score-excellent { border-color: #4caf50; background: rgba(76, 175, 80, 0.2); }
        .score-good { border-color: #8bc34a; background: rgba(139, 195, 74, 0.2); }
        .score-fair { border-color: #ff9800; background: rgba(255, 152, 0, 0.2); }
        .score-poor { border-color: #f44336; background: rgba(244, 67, 54, 0.2); }
        
        @media (max-width: 768px) {
            .status-grid {
                grid-template-columns: 1fr;
            }
            
            .header h1 {
                font-size: 2em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🛡️ Claude Code Crash Prevention Dashboard</h1>
            <p>Real-time system monitoring and protection status</p>
            <div class="live-indicator">🔴 LIVE</div>
        </div>
        
        <div class="status-grid">
            <!-- Overall Status Card -->
            <div class="card">
                <h3>🎯 Overall Status</h3>
                <div class="score-display">
                    <div id="scoreCircle" class="score-circle">
                        <span id="scoreValue">--</span>
                    </div>
                    <div id="scoreLabel">Loading...</div>
                </div>
                <div class="metric">
                    <span class="metric-label">Active Alerts</span>
                    <span class="metric-value" id="activeAlerts">--</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Last Update</span>
                    <span class="metric-value" id="lastUpdate">--</span>
                </div>
            </div>
            
            <!-- Component Status Card -->
            <div class="card">
                <h3>⚙️ Component Status</h3>
                <div id="componentStatus">
                    <div class="metric">
                        <span class="metric-label">
                            <span class="status-indicator" id="resourceMonitorStatus"></span>
                            Resource Monitor
                        </span>
                        <span class="metric-value" id="resourceMonitorText">--</span>
                    </div>
                    <div class="metric">
                        <span class="metric-label">
                            <span class="status-indicator" id="earlyWarningStatus"></span>
                            Early Warning
                        </span>
                        <span class="metric-value" id="earlyWarningText">--</span>
                    </div>
                    <div class="metric">
                        <span class="metric-label">
                            <span class="status-indicator" id="degradationStatus"></span>
                            Degradation Manager
                        </span>
                        <span class="metric-value" id="degradationText">--</span>
                    </div>
                    <div class="metric">
                        <span class="metric-label">
                            <span class="status-indicator" id="bashLimitsStatus"></span>
                            Bash Safety Limits
                        </span>
                        <span class="metric-value" id="bashLimitsText">--</span>
                    </div>
                </div>
            </div>
            
            <!-- System Resources Card -->
            <div class="card">
                <h3>📊 System Resources</h3>
                <div class="metric">
                    <span class="metric-label">Memory Usage</span>
                    <span class="metric-value" id="memoryValue">--</span>
                </div>
                <div class="progress-bar">
                    <div id="memoryProgress" class="progress-fill"></div>
                </div>
                
                <div class="metric">
                    <span class="metric-label">CPU Usage</span>
                    <span class="metric-value" id="cpuValue">--</span>
                </div>
                <div class="progress-bar">
                    <div id="cpuProgress" class="progress-fill"></div>
                </div>
                
                <div class="metric">
                    <span class="metric-label">Disk Usage</span>
                    <span class="metric-value" id="diskValue">--</span>
                </div>
                <div class="progress-bar">
                    <div id="diskProgress" class="progress-fill"></div>
                </div>
                
                <div class="metric">
                    <span class="metric-label">Claude Processes</span>
                    <span class="metric-value" id="processCount">--</span>
                </div>
            </div>
            
            <!-- System Health Card -->
            <div class="card">
                <h3>❤️ System Health</h3>
                <div class="metric">
                    <span class="metric-label">Overall Health</span>
                    <span class="metric-value" id="systemHealth">--</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Memory Available</span>
                    <span class="metric-value" id="memoryAvailable">--</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Disk Free</span>
                    <span class="metric-value" id="diskFree">--</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Python Components</span>
                    <span class="metric-value" id="pythonComponents">--</span>
                </div>
            </div>
        </div>
        
        <!-- Recent Logs Section -->
        <div class="logs-section">
            <div class="card">
                <h3>📋 Recent Activity Logs</h3>
                <div class="logs-container" id="logsContainer">
                    <div class="log-entry">Loading logs...</div>
                </div>
            </div>
        </div>
        
        <div class="update-info">
            <p>🔄 Auto-refreshing every 3 seconds | 📊 Data from continuous monitoring system</p>
            <p>🖥️ Server: <span id="serverInfo">localhost</span> | ⚡ Status: <span id="connectionStatus">Connected</span></p>
        </div>
    </div>
    
    <script>
        // Global variables
        let updateInterval;
        let isConnected = true;
        
        // Initialize dashboard
        document.addEventListener('DOMContentLoaded', function() {
            updateDashboard();
            startAutoUpdate();
        });
        
        // Start automatic updates
        function startAutoUpdate() {
            updateInterval = setInterval(updateDashboard, 3000); // 3 seconds
        }
        
        // Update dashboard data
        async function updateDashboard() {
            try {
                await Promise.all([
                    updateStatus(),
                    updateLogs()
                ]);
                updateConnectionStatus(true);
            } catch (error) {
                console.error('Update failed:', error);
                updateConnectionStatus(false);
            }
        }
        
        // Update status data
        async function updateStatus() {
            const response = await fetch('/api/status');
            if (!response.ok) throw new Error('Status API failed');
            
            const data = await response.json();
            
            // Update overall status
            updateOverallStatus(data);
            
            // Update component status
            updateComponentStatus(data);
            
            // Update system resources
            updateSystemResources(data);
            
            // Update system health
            updateSystemHealth(data);
        }
        
        // Update overall status section
        function updateOverallStatus(data) {
            const score = data.crash_prevention_score || 0;
            const scorePercent = Math.round(score * 100);
            
            document.getElementById('scoreValue').textContent = scorePercent + '%';
            document.getElementById('activeAlerts').textContent = data.alerts_active || 0;
            
            // Add alert badge if alerts > 0
            const alertsElement = document.getElementById('activeAlerts');
            if (data.alerts_active > 0) {
                alertsElement.innerHTML = data.alerts_active + '<span class="alert-badge">' + data.alerts_active + '</span>';
            }
            
            // Update score circle color
            const scoreCircle = document.getElementById('scoreCircle');
            const scoreLabel = document.getElementById('scoreLabel');
            
            scoreCircle.className = 'score-circle';
            if (score >= 0.8) {
                scoreCircle.classList.add('score-excellent');
                scoreLabel.textContent = 'Excellent Protection';
            } else if (score >= 0.6) {
                scoreCircle.classList.add('score-good');
                scoreLabel.textContent = 'Good Protection';
            } else if (score >= 0.4) {
                scoreCircle.classList.add('score-fair');
                scoreLabel.textContent = 'Fair Protection';
            } else {
                scoreCircle.classList.add('score-poor');
                scoreLabel.textContent = 'Poor Protection';
            }
            
            // Update timestamp
            if (data.timestamp) {
                const timestamp = new Date(data.timestamp);
                const now = new Date();
                const ageSeconds = Math.floor((now - timestamp) / 1000);
                document.getElementById('lastUpdate').textContent = ageSeconds + 's ago';
            }
        }
        
        // Update component status section
        function updateComponentStatus(data) {
            const components = [
                ['resourceMonitor', data.resource_monitor_active],
                ['earlyWarning', data.early_warning_active],
                ['degradation', data.degradation_manager_active],
                ['bashLimits', data.bash_limits_available]
            ];
            
            components.forEach(([name, active]) => {
                const statusElement = document.getElementById(name + 'Status');
                const textElement = document.getElementById(name + 'Text');
                
                if (active) {
                    statusElement.className = 'status-indicator status-online';
                    textElement.textContent = 'ONLINE';
                } else {
                    statusElement.className = 'status-indicator status-offline';
                    textElement.textContent = 'OFFLINE';
                }
            });
        }
        
        // Update system resources section
        function updateSystemResources(data) {
            const systemLoad = data.system_load || {};
            
            // Memory
            const memoryPercent = systemLoad.memory_percent || 0;
            document.getElementById('memoryValue').textContent = memoryPercent.toFixed(1) + '%';
            updateProgressBar('memoryProgress', memoryPercent);
            
            // CPU
            const cpuPercent = systemLoad.cpu_percent || 0;
            document.getElementById('cpuValue').textContent = cpuPercent.toFixed(1) + '%';
            updateProgressBar('cpuProgress', cpuPercent);
            
            // Disk
            const diskPercent = systemLoad.disk_percent || 0;
            document.getElementById('diskValue').textContent = diskPercent.toFixed(1) + '%';
            updateProgressBar('diskProgress', diskPercent);
            
            // Processes
            document.getElementById('processCount').textContent = systemLoad.claude_processes || 0;
        }
        
        // Update system health section
        function updateSystemHealth(data) {
            const systemLoad = data.system_load || {};
            
            document.getElementById('systemHealth').textContent = systemLoad.healthy ? '✅ Healthy' : '⚠️ Stressed';
            document.getElementById('memoryAvailable').textContent = 
                (systemLoad.memory_available_gb || 0).toFixed(1) + 'GB';
            document.getElementById('diskFree').textContent = 
                (systemLoad.disk_free_gb || 0).toFixed(0) + 'GB';
            document.getElementById('pythonComponents').textContent = 
                data.python_components_healthy ? '✅ Healthy' : '❌ Issues';
        }
        
        // Update progress bar
        function updateProgressBar(elementId, percent) {
            const element = document.getElementById(elementId);
            element.style.width = percent + '%';
            
            // Update color based on percentage
            element.className = 'progress-fill';
            if (percent >= 90) {
                element.classList.add('progress-critical');
            } else if (percent >= 70) {
                element.classList.add('progress-warning');
            } else {
                element.classList.add('progress-good');
            }
        }
        
        // Update logs section
        async function updateLogs() {
            const response = await fetch('/api/logs');
            if (!response.ok) throw new Error('Logs API failed');
            
            const data = await response.json();
            const logsContainer = document.getElementById('logsContainer');
            
            logsContainer.innerHTML = '';
            
            data.logs.slice(-20).forEach(logLine => {
                const logElement = document.createElement('div');
                logElement.className = 'log-entry';
                
                if (logLine.includes('[ERROR]')) {
                    logElement.classList.add('log-error');
                } else if (logLine.includes('[WARNING]')) {
                    logElement.classList.add('log-warning');
                } else {
                    logElement.classList.add('log-info');
                }
                
                logElement.textContent = logLine;
                logsContainer.appendChild(logElement);
            });
            
            // Scroll to bottom
            logsContainer.scrollTop = logsContainer.scrollHeight;
        }
        
        // Update connection status
        function updateConnectionStatus(connected) {
            const statusElement = document.getElementById('connectionStatus');
            if (connected !== isConnected) {
                isConnected = connected;
                statusElement.textContent = connected ? 'Connected' : 'Disconnected';
                statusElement.style.color = connected ? '#4caf50' : '#f44336';
            }
        }
        
        // Handle page visibility changes
        document.addEventListener('visibilitychange', function() {
            if (document.hidden) {
                clearInterval(updateInterval);
            } else {
                startAutoUpdate();
                updateDashboard();
            }
        });
    </script>
</body>
</html>"""

def start_web_server(port: int = 8080):
    """Start the web dashboard server"""
    server_address = ('', port)
    httpd = HTTPServer(server_address, CrashPreventionWebServer)
    
    print(f"🌐 Starting Crash Prevention Web Dashboard")
    print(f"   Server: http://localhost:{port}")
    print(f"   Status API: http://localhost:{port}/api/status")
    print(f"   Logs API: http://localhost:{port}/api/logs")
    print(f"   Press Ctrl+C to stop\n")
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n🛑 Web dashboard stopped")
        httpd.shutdown()

if __name__ == "__main__":
    import sys
    
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8080
    start_web_server(port)