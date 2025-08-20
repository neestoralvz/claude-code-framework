#!/usr/bin/env python3
"""
TDD GREEN PHASE: Validate Fixes
Tests that the fixes resolve the identified issues
"""

import subprocess
import sys
import os
from pathlib import Path
from unittest.mock import Mock

def test_bash_syntax_fix():
    """Test that bash syntax error is fixed."""
    print("🟢 Testing bash syntax fix...")
    
    result = subprocess.run(
        ["bash", "-n", "/Users/nalve/.claude/system/dashboard/start_dashboard.sh"],
        capture_output=True,
        text=True
    )
    
    if result.returncode == 0:
        print("   ✅ PASS: Bash syntax is now valid")
        return True
    else:
        print(f"   ❌ FAIL: Bash syntax error persists: {result.stderr}")
        return False

def test_python_type_fix():
    """Test that Python type error is fixed."""
    print("🟢 Testing Python type error fix...")
    
    # Change to scripts directory for import
    original_cwd = os.getcwd()
    os.chdir("/Users/nalve/.claude/system/dashboard/scripts")
    sys.path.insert(0, "/Users/nalve/.claude/system/dashboard/scripts")
    
    try:
        import dashboard_api
        handler = dashboard_api.DashboardRequestHandler(Mock(), Mock(), Mock())
        
        # Test cases that should now work
        test_cases = [
            ("GET /api/health", "200", "OK"),         # Should not log
            ("GET /api/health", "404", "Not Found"),  # Should log
            ("GET /api/health", "500", "Server Error") # Should log
        ]
        
        success = True
        for format_str, status_code, message in test_cases:
            try:
                # This should not raise TypeError anymore
                with unittest_mock_patch(handler.__class__.__bases__[0], 'log_message') as mock_super:
                    handler.log_message(format_str, status_code, message)
                    
                    # Verify correct behavior
                    if int(status_code) >= 400:
                        mock_super.assert_called_with(format_str, status_code, message)
                    else:
                        mock_super.assert_not_called()
                        
                print(f"   ✅ PASS: Status {status_code} handled correctly")
                        
            except TypeError as e:
                print(f"   ❌ FAIL: TypeError still occurs with {status_code}: {e}")
                success = False
            except Exception as e:
                print(f"   ⚠️  Other error with {status_code}: {e}")
                success = False
        
        return success
        
    except ImportError as e:
        print(f"   ❌ FAIL: Cannot import dashboard_api: {e}")
        return False
    finally:
        os.chdir(original_cwd)
        if "/Users/nalve/.claude/system/dashboard/scripts" in sys.path:
            sys.path.remove("/Users/nalve/.claude/system/dashboard/scripts")

def unittest_mock_patch(cls, method_name):
    """Simple mock patch for testing."""
    class MockPatch:
        def __init__(self):
            self.called = False
            self.call_args = None
            
        def __enter__(self):
            self.original_method = getattr(cls, method_name)
            def mock_method(*args, **kwargs):
                self.called = True
                self.call_args = (args, kwargs)
            setattr(cls, method_name, mock_method)
            return self
            
        def __exit__(self, *args):
            setattr(cls, method_name, self.original_method)
            
        def assert_called_with(self, *expected_args):
            if not self.called:
                raise AssertionError("Method was not called")
            if self.call_args[0] != expected_args:
                raise AssertionError(f"Called with {self.call_args[0]}, expected {expected_args}")
                
        def assert_not_called(self):
            if self.called:
                raise AssertionError("Method was called when it shouldn't have been")
    
    return MockPatch()

def test_dashboard_startup():
    """Test that dashboard can start without errors."""
    print("🟢 Testing dashboard startup...")
    
    # Test help flag to verify script can execute
    result = subprocess.run(
        ["/Users/nalve/.claude/system/dashboard/start_dashboard.sh", "--help"],
        capture_output=True,
        text=True,
        timeout=10
    )
    
    if result.returncode == 0:
        print("   ✅ PASS: Dashboard script executes successfully")
        return True
    else:
        print(f"   ❌ FAIL: Dashboard script fails: {result.stderr}")
        return False

def main():
    """Run all GREEN phase tests."""
    print("🟢 TDD GREEN PHASE: Testing Fixes")
    print("=" * 50)
    
    tests = [
        test_bash_syntax_fix,
        test_python_type_fix,
        test_dashboard_startup
    ]
    
    results = []
    for test in tests:
        try:
            result = test()
            results.append(result)
        except Exception as e:
            print(f"   💥 TEST ERROR: {e}")
            results.append(False)
        print()
    
    passed = sum(results)
    total = len(results)
    
    print("=" * 50)
    if passed == total:
        print(f"🎉 GREEN PHASE SUCCESS: All {total} tests passed!")
        print("Ready for REFACTOR phase: Production validation")
    else:
        print(f"❌ GREEN PHASE PARTIAL: {passed}/{total} tests passed")
        print("Need to fix remaining issues before proceeding")
    print("=" * 50)

if __name__ == "__main__":
    main()