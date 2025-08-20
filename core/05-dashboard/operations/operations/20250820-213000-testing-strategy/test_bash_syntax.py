#!/usr/bin/env python3
"""
TDD Test Case 1: Bash Syntax Error Reproduction
Tests the exact bash syntax error on line 7 of start_dashboard.sh
"""

import subprocess
import os
import tempfile
import unittest
from pathlib import Path

class TestBashSyntaxError(unittest.TestCase):
    """Test cases for bash script syntax validation."""
    
    def setUp(self):
        """Set up test environment."""
        self.dashboard_root = Path("/Users/nalve/.claude/system/dashboard")
        self.start_script = self.dashboard_root / "start_dashboard.sh"
        
    def test_bash_syntax_validation(self):
        """Test that bash script has valid syntax."""
        
        # Run bash syntax check on the actual script
        result = subprocess.run(
            ["bash", "-n", str(self.start_script)],
            capture_output=True,
            text=True
        )
        
        # This should FAIL initially due to Python docstring syntax
        self.assertEqual(result.returncode, 0, 
                        f"Bash syntax error detected:\n{result.stderr}")
    
    def test_script_execution_dry_run(self):
        """Test script can at least parse without execution errors."""
        
        # Try to parse the script without executing main logic
        result = subprocess.run(
            ["bash", "-c", f"source {self.start_script} 2>/dev/null || echo 'PARSE_ERROR'"],
            capture_output=True,
            text=True
        )
        
        # Should not contain parse errors
        self.assertNotIn("PARSE_ERROR", result.stdout,
                        "Script parsing failed - likely syntax error")
    
    def test_docstring_syntax_error(self):
        """Test specifically for Python docstring in bash file."""
        
        with open(self.start_script, 'r') as f:
            content = f.read()
        
        # Check for Python-style docstrings (triple quotes)
        lines = content.split('\n')
        for i, line in enumerate(lines[:10]):  # Check first 10 lines
            if '"""' in line:
                self.fail(f"Python docstring syntax found at line {i+1}: {line.strip()}")

if __name__ == "__main__":
    unittest.main()