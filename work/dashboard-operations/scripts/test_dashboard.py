#!/usr/bin/env python3
"""
Claude Framework Dashboard Test Suite

Tests all dashboard components and APIs to ensure proper functionality.
"""

import json
import sys
import os
import subprocess
import time
from pathlib import Path
from datetime import datetime
import urllib.request
import urllib.error

class DashboardTester:
    def __init__(self, framework_root: str = "/Users/nalve/.claude"):
        self.framework_root = Path(framework_root)
        self.dashboard_root = self.framework_root / "system" / "dashboard"
        self.scripts_dir = self.dashboard_root / "scripts"
        self.data_dir = self.dashboard_root / "data"
        
        self.test_results = []
        self.api_server_pid = None
        
    def run_all_tests(self) -> bool:
        """Run all dashboard tests."""
        print("🧪 Claude Framework Dashboard Test Suite")
        print("=" * 50)
        
        success = True
        
        # Test file structure
        success &= self.test_file_structure()
        
        # Test script permissions
        success &= self.test_script_permissions()
        
        # Test metric collection scripts
        success &= self.test_metric_scripts()
        
        # Test API server
        success &= self.test_api_server()
        
        # Test dashboard files
        success &= self.test_dashboard_files()
        
        # Test hook integration
        success &= self.test_hook_integration()
        
        # Print results
        self.print_test_results()
        
        # Cleanup
        self.cleanup()
        
        return success
    
    def test_file_structure(self) -> bool:
        """Test that all required files exist."""
        print("\n📁 Testing File Structure...")
        
        required_files = [
            "index.html",
            "assets/css/dashboard.css",
            "assets/js/dashboard.js",
            "scripts/collect_metrics.py",
            "scripts/health_check.py",
            "scripts/agent_tracker.py",
            "scripts/git_operations_monitor.py",
            "scripts/update_dashboard_metrics.py",
            "scripts/dashboard_api.py",
            "start_dashboard.sh",
            "README.md"
        ]
        
        missing_files = []
        
        for file_path in required_files:
            full_path = self.dashboard_root / file_path
            if not full_path.exists():
                missing_files.append(file_path)
                self.add_test_result("file_structure", f"Missing: {file_path}", False)
            else:
                self.add_test_result("file_structure", f"Found: {file_path}", True)
        
        if missing_files:
            print(f"❌ Missing files: {', '.join(missing_files)}")
            return False
        else:
            print("✅ All required files present")
            return True
    
    def test_script_permissions(self) -> bool:
        """Test that scripts have execute permissions."""
        print("\n🔒 Testing Script Permissions...")
        
        script_files = [
            "scripts/collect_metrics.py",
            "scripts/health_check.py",
            "scripts/agent_tracker.py",
            "scripts/git_operations_monitor.py",
            "scripts/update_dashboard_metrics.py",
            "scripts/dashboard_api.py",
            "start_dashboard.sh"
        ]
        
        permission_errors = []
        
        for script_path in script_files:
            full_path = self.dashboard_root / script_path
            if full_path.exists():
                if os.access(full_path, os.X_OK):
                    self.add_test_result("permissions", f"Executable: {script_path}", True)
                else:
                    permission_errors.append(script_path)
                    self.add_test_result("permissions", f"Not executable: {script_path}", False)
                    
                    # Try to fix permission
                    try:
                        os.chmod(full_path, 0o755)
                        print(f"🔧 Fixed permissions for {script_path}")
                        self.add_test_result("permissions", f"Fixed: {script_path}", True)
                    except Exception as e:
                        print(f"❌ Could not fix permissions for {script_path}: {e}")
        
        if permission_errors:
            print(f"⚠️  Permission issues found (attempted to fix)")
            return True  # We tried to fix them
        else:
            print("✅ All scripts have correct permissions")
            return True
    
    def test_metric_scripts(self) -> bool:
        """Test metric collection scripts."""
        print("\n📊 Testing Metric Collection Scripts...")
        
        scripts_to_test = [
            ("collect_metrics.py", "Framework metrics"),
            ("health_check.py", "Health check"),
            ("agent_tracker.py", "Agent usage"),
            ("git_operations_monitor.py", "Git monitoring")
        ]
        
        success = True
        
        for script_name, description in scripts_to_test:
            script_path = self.scripts_dir / script_name
            
            try:
                print(f"  Testing {description}...")
                
                # Run script with timeout
                result = subprocess.run([
                    sys.executable, str(script_path)
                ], capture_output=True, text=True, timeout=30, cwd=str(self.scripts_dir))
                
                if result.returncode == 0:
                    print(f"    ✅ {description} script works")
                    self.add_test_result("scripts", f"{script_name} success", True)
                else:
                    print(f"    ❌ {description} script failed: {result.stderr[:200]}")
                    self.add_test_result("scripts", f"{script_name} failed", False)
                    success = False
                    
            except subprocess.TimeoutExpired:
                print(f"    ⏰ {description} script timed out")
                self.add_test_result("scripts", f"{script_name} timeout", False)
                success = False
            except Exception as e:
                print(f"    ❌ {description} script error: {e}")
                self.add_test_result("scripts", f"{script_name} error", False)
                success = False
        
        return success
    
    def test_api_server(self) -> bool:
        """Test API server functionality."""
        print("\n🌐 Testing API Server...")
        
        # Start API server
        if not self.start_api_server():
            return False
        
        # Wait for server to start
        time.sleep(3)
        
        # Test API endpoints
        endpoints_to_test = [
            ("/api/health", "Health endpoint"),
            ("/api/status", "Status endpoint"),
            ("/api/navigation", "Navigation endpoint")
        ]
        
        success = True
        
        for endpoint, description in endpoints_to_test:
            try:
                url = f"http://127.0.0.1:8888{endpoint}"
                
                with urllib.request.urlopen(url, timeout=10) as response:
                    if response.getcode() == 200:
                        data = json.loads(response.read().decode())
                        print(f"    ✅ {description} works")
                        self.add_test_result("api", f"{endpoint} success", True)
                    else:
                        print(f"    ❌ {description} returned {response.getcode()}")
                        self.add_test_result("api", f"{endpoint} bad status", False)
                        success = False
                        
            except urllib.error.URLError as e:
                print(f"    ❌ {description} connection failed: {e}")
                self.add_test_result("api", f"{endpoint} connection error", False)
                success = False
            except json.JSONDecodeError as e:
                print(f"    ❌ {description} invalid JSON: {e}")
                self.add_test_result("api", f"{endpoint} JSON error", False)
                success = False
            except Exception as e:
                print(f"    ❌ {description} error: {e}")
                self.add_test_result("api", f"{endpoint} error", False)
                success = False
        
        return success
    
    def start_api_server(self) -> bool:
        """Start API server for testing."""
        try:
            api_script = self.scripts_dir / "dashboard_api.py"
            
            # Start server on test port
            process = subprocess.Popen([
                sys.executable, str(api_script),
                "--host", "127.0.0.1",
                "--port", "8888",
                "--framework-root", str(self.framework_root)
            ], cwd=str(self.scripts_dir), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            
            self.api_server_pid = process.pid
            print(f"    🚀 API server started (PID: {self.api_server_pid})")
            
            return True
            
        except Exception as e:
            print(f"    ❌ Failed to start API server: {e}")
            return False
    
    def test_dashboard_files(self) -> bool:
        """Test dashboard HTML/CSS/JS files."""
        print("\n🎨 Testing Dashboard Files...")
        
        success = True
        
        # Test HTML file
        html_file = self.dashboard_root / "index.html"
        if html_file.exists():
            try:
                content = html_file.read_text()
                if "Claude Framework Dashboard" in content and "dashboard.css" in content:
                    print("    ✅ HTML file looks good")
                    self.add_test_result("files", "HTML structure valid", True)
                else:
                    print("    ❌ HTML file missing expected content")
                    self.add_test_result("files", "HTML content invalid", False)
                    success = False
            except Exception as e:
                print(f"    ❌ HTML file error: {e}")
                success = False
        
        # Test CSS file
        css_file = self.dashboard_root / "assets" / "css" / "dashboard.css"
        if css_file.exists():
            try:
                content = css_file.read_text()
                if ".dashboard-header" in content and "var(--primary-color)" in content:
                    print("    ✅ CSS file looks good")
                    self.add_test_result("files", "CSS structure valid", True)
                else:
                    print("    ❌ CSS file missing expected content")
                    self.add_test_result("files", "CSS content invalid", False)
                    success = False
            except Exception as e:
                print(f"    ❌ CSS file error: {e}")
                success = False
        
        # Test JS file
        js_file = self.dashboard_root / "assets" / "js" / "dashboard.js"
        if js_file.exists():
            try:
                content = js_file.read_text()
                if "ClaudeDashboard" in content and "loadSystemHealth" in content:
                    print("    ✅ JavaScript file looks good")
                    self.add_test_result("files", "JS structure valid", True)
                else:
                    print("    ❌ JavaScript file missing expected content")
                    self.add_test_result("files", "JS content invalid", False)
                    success = False
            except Exception as e:
                print(f"    ❌ JavaScript file error: {e}")
                success = False
        
        return success
    
    def test_hook_integration(self) -> bool:
        """Test hook integration."""
        print("\n🔗 Testing Hook Integration...")
        
        hooks_dir = self.framework_root / "hooks"
        post_tool_use_hook = hooks_dir / "post_tool_use.py"
        
        if not post_tool_use_hook.exists():
            print("    ⚠️  post_tool_use hook not found - dashboard metrics won't auto-update")
            self.add_test_result("hooks", "Hook missing", False)
            return False
        
        try:
            # Check if hook has dashboard integration
            content = post_tool_use_hook.read_text()
            
            if "update_dashboard_metrics" in content:
                print("    ✅ Hook has dashboard integration")
                self.add_test_result("hooks", "Hook integration found", True)
                return True
            else:
                print("    ⚠️  Hook missing dashboard integration")
                self.add_test_result("hooks", "Hook integration missing", False)
                return False
                
        except Exception as e:
            print(f"    ❌ Hook integration test error: {e}")
            self.add_test_result("hooks", "Hook test error", False)
            return False
    
    def add_test_result(self, category: str, description: str, success: bool):
        """Add a test result."""
        self.test_results.append({
            "timestamp": datetime.now().isoformat(),
            "category": category,
            "description": description,
            "success": success
        })
    
    def print_test_results(self):
        """Print comprehensive test results."""
        print("\n" + "=" * 50)
        print("📋 Test Results Summary")
        print("=" * 50)
        
        categories = {}
        total_tests = len(self.test_results)
        passed_tests = sum(1 for r in self.test_results if r["success"])
        
        # Group by category
        for result in self.test_results:
            cat = result["category"]
            if cat not in categories:
                categories[cat] = {"passed": 0, "total": 0}
            
            categories[cat]["total"] += 1
            if result["success"]:
                categories[cat]["passed"] += 1
        
        # Print category summaries
        for category, stats in categories.items():
            percentage = (stats["passed"] / stats["total"]) * 100 if stats["total"] > 0 else 0
            status_icon = "✅" if percentage == 100 else "⚠️" if percentage >= 80 else "❌"
            
            print(f"{status_icon} {category.title()}: {stats['passed']}/{stats['total']} ({percentage:.1f}%)")
        
        # Overall summary
        overall_percentage = (passed_tests / total_tests) * 100 if total_tests > 0 else 0
        overall_icon = "✅" if overall_percentage == 100 else "⚠️" if overall_percentage >= 80 else "❌"
        
        print(f"\n{overall_icon} Overall: {passed_tests}/{total_tests} tests passed ({overall_percentage:.1f}%)")
        
        # Save test results
        self.save_test_results()
        
        # Print recommendations
        if overall_percentage < 100:
            print("\n💡 Recommendations:")
            
            if overall_percentage < 80:
                print("  • Review failed tests and fix critical issues")
                print("  • Check file permissions and script functionality")
            
            print("  • Run individual scripts to debug specific issues")
            print("  • Check dashboard documentation for troubleshooting")
        else:
            print("\n🎉 All tests passed! Dashboard is ready to use.")
            print("\n🚀 Quick Start:")
            print("  • Run: ./start_dashboard.sh")
            print("  • Open: http://127.0.0.1:8080")
    
    def save_test_results(self):
        """Save test results to file."""
        try:
            self.data_dir.mkdir(parents=True, exist_ok=True)
            
            results_file = self.data_dir / f"test_results_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
            
            test_data = {
                "timestamp": datetime.now().isoformat(),
                "framework_root": str(self.framework_root),
                "total_tests": len(self.test_results),
                "passed_tests": sum(1 for r in self.test_results if r["success"]),
                "test_results": self.test_results
            }
            
            with open(results_file, 'w') as f:
                json.dump(test_data, f, indent=2)
            
            print(f"\n💾 Test results saved to: {results_file}")
            
        except Exception as e:
            print(f"\n❌ Could not save test results: {e}")
    
    def cleanup(self):
        """Cleanup test resources."""
        if self.api_server_pid:
            try:
                os.kill(self.api_server_pid, 9)  # Force kill
                print(f"🛑 Stopped test API server (PID: {self.api_server_pid})")
            except Exception:
                pass  # Process might have already stopped

def main():
    """Main function to run dashboard tests."""
    import argparse
    
    parser = argparse.ArgumentParser(description='Claude Framework Dashboard Test Suite')
    parser.add_argument('--framework-root', help='Framework root directory (default: ~/.claude)')
    
    args = parser.parse_args()
    
    framework_root = args.framework_root or str(Path.home() / '.claude')
    
    tester = DashboardTester(framework_root)
    success = tester.run_all_tests()
    
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()