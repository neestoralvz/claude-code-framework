#!/usr/bin/env python3
"""
TDD Test Case 2: Python Type Error Reproduction
Tests the exact TypeError on line 400 of dashboard_api.py
"""

import unittest
import sys
from pathlib import Path
from unittest.mock import Mock, patch

# Add dashboard scripts to path for testing
dashboard_scripts = Path("/Users/nalve/.claude/system/dashboard/scripts")
sys.path.insert(0, str(dashboard_scripts))

class TestPythonTypeError(unittest.TestCase):
    """Test cases for Python type error in log_message method."""
    
    def setUp(self):
        """Set up test environment."""
        # Import the module after path setup
        try:
            import dashboard_api
            self.dashboard_module = dashboard_api
        except ImportError as e:
            self.fail(f"Could not import dashboard_api: {e}")
    
    def test_log_message_type_error_reproduction(self):
        """Reproduce the exact TypeError from log_message method."""
        
        # Create a mock request handler instance
        handler = self.dashboard_module.DashboardRequestHandler(
            Mock(), Mock(), Mock()
        )
        
        # Mock the parent log_message method
        with patch.object(handler.__class__.__bases__[0], 'log_message'):
            
            # Test case 1: String status code (typical HTTP request scenario)
            # This should FAIL with TypeError: '>=' not supported between 'str' and 'int'
            with self.assertRaises(TypeError) as context:
                handler.log_message("GET /api/health", "200", "OK")
            
            self.assertIn("'>=' not supported", str(context.exception))
    
    def test_log_message_with_various_status_codes(self):
        """Test log_message with various HTTP status code formats."""
        
        handler = self.dashboard_module.DashboardRequestHandler(
            Mock(), Mock(), Mock()
        )
        
        # Test with string status codes (current broken behavior)
        test_cases = [
            ("GET /api/health", "200", "OK"),     # Success - should not log
            ("GET /api/health", "404", "Not Found"),  # Client error - should log
            ("GET /api/health", "500", "Server Error"),  # Server error - should log
        ]
        
        with patch.object(handler.__class__.__bases__[0], 'log_message') as mock_super:
            for format_str, status_code, message in test_cases:
                
                # This should FAIL due to string comparison with integer
                try:
                    handler.log_message(format_str, status_code, message)
                    
                    # If we get here without TypeError, the bug is fixed
                    if int(status_code) >= 400:
                        mock_super.assert_called()
                    else:
                        mock_super.assert_not_called()
                        
                except TypeError as e:
                    # This is the expected failure - type comparison error
                    self.assertIn("'>=' not supported", str(e))
                    self.assertIn("'str' and 'int'", str(e))
                
                mock_super.reset_mock()
    
    def test_current_implementation_fails(self):
        """Verify the current implementation fails with string status codes."""
        
        # Read the actual source code to verify the bug exists
        dashboard_api_path = Path("/Users/nalve/.claude/system/dashboard/scripts/dashboard_api.py")
        
        with open(dashboard_api_path, 'r') as f:
            content = f.read()
        
        # Look for the problematic line
        lines = content.split('\n')
        log_message_found = False
        problematic_line = None
        
        for i, line in enumerate(lines):
            if 'def log_message' in line:
                log_message_found = True
            elif log_message_found and 'args[1] >= 400' in line:
                problematic_line = i + 1
                break
        
        self.assertIsNotNone(problematic_line, 
                           "Could not find the problematic line 'args[1] >= 400'")
        
        # Verify the line contains string-to-int comparison without conversion
        problem_line = lines[problematic_line - 1]
        self.assertIn('args[1] >= 400', problem_line)
        self.assertNotIn('int(args[1])', problem_line)

if __name__ == "__main__":
    unittest.main()