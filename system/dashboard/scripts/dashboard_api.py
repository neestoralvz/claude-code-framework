#!/usr/bin/env python3
"""
Dashboard API Server

Lightweight API server to provide real-time data for the Claude Framework Dashboard.
Serves metrics, health status, and navigation data.
"""

import json
import os
import sys
from pathlib import Path
from datetime import datetime
from typing import Dict, Any
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import threading
import time

# Add scripts directory to Python path for imports
SCRIPTS_DIR = Path(__file__).parent
sys.path.insert(0, str(SCRIPTS_DIR))

try:
    from collect_metrics import FrameworkMetricsCollector
    from health_check import FrameworkHealthChecker
    from agent_tracker import AgentUsageTracker
    from git_operations_monitor import GitOperationsMonitor
    from update_dashboard_metrics import DashboardMetricsUpdater
except ImportError as e:
    print(f"Warning: Could not import some modules: {e}", file=sys.stderr)

class DashboardAPIHandler(BaseHTTPRequestHandler):
    """HTTP request handler for dashboard API endpoints."""
    
    def __init__(self, *args, framework_root=None, **kwargs):
        self.framework_root = Path(framework_root) if framework_root else Path.home() / '.claude'
        self.dashboard_data_dir = self.framework_root / 'system' / 'dashboard' / 'data'
        super().__init__(*args, **kwargs)
    
    def do_GET(self):
        """Handle GET requests."""
        try:
            parsed_path = urlparse(self.path)
            path = parsed_path.path
            query_params = parse_qs(parsed_path.query)
            
            # Route requests
            if path == '/api/health':
                self.handle_health_check()
            elif path == '/api/metrics':
                self.handle_metrics()
            elif path == '/api/agents':
                self.handle_agents()
            elif path == '/api/git-status':
                self.handle_git_status()
            elif path == '/api/operations':
                self.handle_operations()
            elif path == '/api/navigation':
                self.handle_navigation()
            elif path == '/api/realtime-metrics':
                self.handle_realtime_metrics()
            elif path == '/api/status':
                self.handle_overall_status()
            elif path.startswith('/api/'):
                self.send_error(404, "API endpoint not found")
            else:
                # Serve static files (dashboard HTML/CSS/JS)
                self.handle_static_file()
                
        except Exception as e:
            self.send_error(500, f"Internal server error: {e}")
    
    def handle_health_check(self):
        """Handle health check endpoint."""
        try:
            # Use cached data if recent, otherwise run fresh check
            cached_data = self.get_cached_data('health_check')
            
            if cached_data and self.is_data_fresh(cached_data, minutes=5):
                data = cached_data
            else:
                checker = FrameworkHealthChecker(str(self.framework_root))
                data = checker.run_all_checks()
                self.cache_data('health_check', data)
            
            self.send_json_response(data)
            
        except Exception as e:
            self.send_json_response({
                "error": str(e),
                "health_score": 0,
                "status": "error"
            })
    
    def handle_metrics(self):
        """Handle metrics endpoint."""
        try:
            # Use cached metrics if recent
            cached_data = self.get_cached_data('metrics')
            
            if cached_data and self.is_data_fresh(cached_data, minutes=10):
                data = cached_data
            else:
                collector = FrameworkMetricsCollector(str(self.framework_root))
                data = collector.collect_all_metrics()
                self.cache_data('metrics', data)
            
            self.send_json_response(data)
            
        except Exception as e:
            self.send_json_response({
                "error": str(e),
                "timestamp": datetime.now().isoformat()
            })
    
    def handle_agents(self):
        """Handle agent usage endpoint."""
        try:
            cached_data = self.get_cached_data('agent_usage')
            
            if cached_data and self.is_data_fresh(cached_data, minutes=15):
                data = cached_data
            else:
                tracker = AgentUsageTracker(str(self.framework_root))
                data = tracker.analyze_agent_usage()
                self.cache_data('agent_usage', data)
            
            self.send_json_response(data)
            
        except Exception as e:
            self.send_json_response({
                "error": str(e),
                "usage_summary": {"total_deployments": 0}
            })
    
    def handle_git_status(self):
        """Handle git status endpoint."""
        try:
            cached_data = self.get_cached_data('git_status')
            
            if cached_data and self.is_data_fresh(cached_data, minutes=2):
                data = cached_data
            else:
                monitor = GitOperationsMonitor(str(self.framework_root))
                data = monitor.get_comprehensive_status()
                self.cache_data('git_status', data)
            
            self.send_json_response(data)
            
        except Exception as e:
            self.send_json_response({
                "error": str(e),
                "git_status": {"repository_exists": False}
            })
    
    def handle_operations(self):
        """Handle operations endpoint."""
        try:
            monitor = GitOperationsMonitor(str(self.framework_root))
            data = monitor.get_operations_status()
            self.send_json_response(data)
            
        except Exception as e:
            self.send_json_response({
                "error": str(e),
                "exists": False,
                "total_operations": 0
            })
    
    def handle_navigation(self):
        """Handle navigation data endpoint."""
        try:
            nav_data = self.generate_navigation_data()
            self.send_json_response(nav_data)
            
        except Exception as e:
            self.send_json_response({
                "error": str(e),
                "navigation": []
            })
    
    def handle_realtime_metrics(self):
        """Handle real-time metrics from hooks."""
        try:
            updater = DashboardMetricsUpdater(str(self.framework_root))
            data = updater.get_current_metrics()
            self.send_json_response(data)
            
        except Exception as e:
            self.send_json_response({
                "error": str(e),
                "last_updated": datetime.now().isoformat()
            })
    
    def handle_overall_status(self):
        """Handle overall dashboard status endpoint."""
        try:
            # Combine key metrics for dashboard overview
            updater = DashboardMetricsUpdater(str(self.framework_root))
            realtime_data = updater.get_current_metrics()
            
            status = {
                "timestamp": datetime.now().isoformat(),
                "framework_health": {
                    "score": realtime_data.get('framework_health', {}).get('health_score', 0),
                    "issues": realtime_data.get('framework_health', {}).get('issues_detected', 0)
                },
                "activity_summary": {
                    "total_executions": realtime_data.get('tool_usage', {}).get('total_executions', 0),
                    "files_modified_today": realtime_data.get('file_modifications', {}).get('files_modified_today', 0),
                    "sessions_today": realtime_data.get('session_data', {}).get('session_starts_today', 0)
                },
                "agent_activity": {
                    "total_deployments": realtime_data.get('agent_activity', {}).get('total_agent_deployments', 0),
                    "unique_agents": len(realtime_data.get('agent_activity', {}).get('agent_mentions', {}))
                }
            }
            
            self.send_json_response(status)
            
        except Exception as e:
            self.send_json_response({
                "error": str(e),
                "timestamp": datetime.now().isoformat()
            })
    
    def handle_static_file(self):
        """Handle static file requests."""
        try:
            # Map request path to file system
            path = self.path.lstrip('/')
            
            if not path or path == '/':
                path = 'index.html'
            
            # Security check - prevent directory traversal
            if '..' in path or path.startswith('/'):
                self.send_error(403, "Access forbidden")
                return
            
            file_path = self.framework_root / 'system' / 'dashboard' / path
            
            if not file_path.exists():
                self.send_error(404, "File not found")
                return
            
            # Determine content type
            content_type = self.get_content_type(file_path.suffix)
            
            # Send file
            with open(file_path, 'rb') as f:
                content = f.read()
            
            self.send_response(200)
            self.send_header('Content-Type', content_type)
            self.send_header('Content-Length', str(len(content)))
            self.send_header('Cache-Control', 'no-cache')
            self.end_headers()
            self.wfile.write(content)
            
        except Exception as e:
            self.send_error(500, f"Error serving file: {e}")
    
    def get_content_type(self, extension: str) -> str:
        """Get content type based on file extension."""
        content_types = {
            '.html': 'text/html',
            '.css': 'text/css',
            '.js': 'application/javascript',
            '.json': 'application/json',
            '.png': 'image/png',
            '.jpg': 'image/jpeg',
            '.jpeg': 'image/jpeg',
            '.gif': 'image/gif',
            '.svg': 'image/svg+xml',
            '.ico': 'image/x-icon'
        }
        return content_types.get(extension.lower(), 'text/plain')
    
    def generate_navigation_data(self) -> Dict[str, Any]:
        """Generate navigation data for the dashboard."""
        system_dir = self.framework_root / 'system'
        
        navigation = {
            "timestamp": datetime.now().isoformat(),
            "categories": []
        }
        
        # System components
        if system_dir.exists():
            categories = [
                {
                    "name": "Core Framework",
                    "icon": "🧱",
                    "items": [
                        {"name": "Principles", "path": "system/PRINCIPLES.md", "count": self.count_items_in_file(system_dir / "PRINCIPLES.md")},
                        {"name": "Personalities", "path": "system/PERSONALITIES.md", "count": self.count_directory_files(system_dir / "personalities")},
                        {"name": "Processes", "path": "system/PROCESSES.md", "count": self.count_directory_files(system_dir / "processes")},
                        {"name": "Standards", "path": "system/STANDARDS.md", "count": self.count_directory_files(system_dir / "standards")}
                    ]
                },
                {
                    "name": "Tools & Utilities",
                    "icon": "🔧", 
                    "items": [
                        {"name": "Tools", "path": "system/TOOLS.md", "count": self.count_directory_files(system_dir / "tools")},
                        {"name": "Examples", "path": "system/EXAMPLES.md", "count": self.count_directory_files(system_dir / "examples")},
                        {"name": "Hooks", "path": "hooks/README.md", "count": self.count_directory_files(self.framework_root / "hooks", "*.py")}
                    ]
                },
                {
                    "name": "Operations & History",
                    "icon": "📁",
                    "items": [
                        {"name": "Recent Operations", "path": "operations/", "count": self.count_directory_files(self.framework_root / "operations")},
                        {"name": "Dashboard Data", "path": "system/dashboard/data/", "count": self.count_directory_files(self.dashboard_data_dir)}
                    ]
                }
            ]
            
            navigation["categories"] = categories
        
        return navigation
    
    def count_items_in_file(self, file_path: Path) -> int:
        """Count numbered items in a markdown file."""
        if not file_path.exists():
            return 0
        
        try:
            content = file_path.read_text()
            # Count numbered list items
            import re
            return len(re.findall(r'^\d+\.\s', content, re.MULTILINE))
        except Exception:
            return 0
    
    def count_directory_files(self, dir_path: Path, pattern: str = "*.md") -> int:
        """Count files in a directory matching pattern."""
        if not dir_path.exists():
            return 0
        
        try:
            return len(list(dir_path.glob(pattern)))
        except Exception:
            return 0
    
    def get_cached_data(self, cache_key: str) -> Dict[str, Any]:
        """Get cached data if available."""
        cache_file = self.dashboard_data_dir / f"{cache_key}_cache.json"
        
        if not cache_file.exists():
            return None
        
        try:
            with open(cache_file, 'r') as f:
                return json.load(f)
        except Exception:
            return None
    
    def cache_data(self, cache_key: str, data: Dict[str, Any]):
        """Cache data to file."""
        cache_file = self.dashboard_data_dir / f"{cache_key}_cache.json"
        
        try:
            self.dashboard_data_dir.mkdir(parents=True, exist_ok=True)
            with open(cache_file, 'w') as f:
                json.dump(data, f, indent=2, default=str)
        except Exception:
            pass  # Silently fail on cache errors
    
    def is_data_fresh(self, data: Dict[str, Any], minutes: int = 5) -> bool:
        """Check if cached data is still fresh."""
        if 'timestamp' not in data:
            return False
        
        try:
            data_time = datetime.fromisoformat(data['timestamp'])
            age = (datetime.now() - data_time).total_seconds() / 60
            return age < minutes
        except Exception:
            return False
    
    def send_json_response(self, data: Dict[str, Any]):
        """Send JSON response."""
        response_data = json.dumps(data, indent=2, default=str)
        
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Length', str(len(response_data)))
        self.send_header('Access-Control-Allow-Origin', '*')  # Enable CORS
        self.send_header('Cache-Control', 'no-cache')
        self.end_headers()
        self.wfile.write(response_data.encode('utf-8'))
    
    def log_message(self, format, *args):
        """Override log message to reduce noise."""
        # Only log errors
        if args and args[1] >= 400:
            super().log_message(format, *args)

class DashboardServer:
    """Dashboard HTTP server wrapper."""
    
    def __init__(self, host='127.0.0.1', port=8080, framework_root=None):
        self.host = host
        self.port = port
        self.framework_root = framework_root or str(Path.home() / '.claude')
        self.server = None
        self.server_thread = None
    
    def start(self):
        """Start the dashboard server."""
        try:
            # Create custom handler class with framework_root
            def handler(*args, **kwargs):
                return DashboardAPIHandler(*args, framework_root=self.framework_root, **kwargs)
            
            self.server = HTTPServer((self.host, self.port), handler)
            
            print(f"🚀 Starting Claude Dashboard Server at http://{self.host}:{self.port}")
            print(f"📁 Framework root: {self.framework_root}")
            print(f"🌐 Dashboard URL: http://{self.host}:{self.port}")
            print(f"📊 API endpoints available at http://{self.host}:{self.port}/api/")
            
            # Start server in a separate thread
            self.server_thread = threading.Thread(target=self.server.serve_forever)
            self.server_thread.daemon = True
            self.server_thread.start()
            
            return True
            
        except Exception as e:
            print(f"❌ Failed to start dashboard server: {e}")
            return False
    
    def stop(self):
        """Stop the dashboard server."""
        if self.server:
            self.server.shutdown()
            self.server.server_close()
            print("🛑 Dashboard server stopped")
    
    def is_running(self) -> bool:
        """Check if server is running."""
        return self.server is not None and self.server_thread is not None and self.server_thread.is_alive()

def main():
    """Main function to run the dashboard server."""
    import argparse
    
    parser = argparse.ArgumentParser(description='Claude Framework Dashboard Server')
    parser.add_argument('--host', default='127.0.0.1', help='Server host (default: 127.0.0.1)')
    parser.add_argument('--port', type=int, default=8080, help='Server port (default: 8080)')
    parser.add_argument('--framework-root', help='Framework root directory (default: ~/.claude)')
    
    args = parser.parse_args()
    
    server = DashboardServer(
        host=args.host,
        port=args.port,
        framework_root=args.framework_root
    )
    
    if server.start():
        try:
            # Keep server running
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("\n🔄 Shutting down dashboard server...")
            server.stop()
    else:
        sys.exit(1)

if __name__ == "__main__":
    main()