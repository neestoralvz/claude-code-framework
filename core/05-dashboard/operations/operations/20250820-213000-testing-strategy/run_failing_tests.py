#!/usr/bin/env python3
# Make executable
import os
os.chmod(__file__, 0o755)
"""
TDD Red Phase: Run Failing Tests
Execute tests that should fail due to current bugs
"""

import subprocess
import sys
from pathlib import Path

def run_test_file(test_file):
    """Run a single test file and capture results."""
    print(f"\n{'='*60}")
    print(f"Running: {test_file.name}")
    print(f"{'='*60}")
    
    result = subprocess.run(
        [sys.executable, str(test_file)], 
        capture_output=True, 
        text=True,
        cwd=test_file.parent
    )
    
    print(f"Exit Code: {result.returncode}")
    if result.stdout:
        print(f"STDOUT:\n{result.stdout}")
    if result.stderr:
        print(f"STDERR:\n{result.stderr}")
    
    return result.returncode == 0

def main():
    """Run all failing tests."""
    operations_dir = Path(__file__).parent
    
    test_files = [
        operations_dir / "test_bash_syntax.py",
        operations_dir / "test_python_type_error.py"
    ]
    
    print("TDD RED PHASE: Running Tests That Should Fail")
    print("=" * 60)
    
    all_passed = True
    for test_file in test_files:
        if test_file.exists():
            passed = run_test_file(test_file)
            if passed:
                print(f"⚠️  WARNING: {test_file.name} PASSED (should have FAILED)")
                all_passed = False
            else:
                print(f"✅ EXPECTED: {test_file.name} FAILED (confirming bug exists)")
        else:
            print(f"❌ Test file not found: {test_file}")
            all_passed = False
    
    print("\n" + "="*60)
    if not all_passed:
        print("🔴 RED PHASE COMPLETE: Tests failed as expected - bugs confirmed")
        print("Next: GREEN PHASE - Fix the code to make tests pass")
    else:
        print("🟡 UNEXPECTED: Some tests passed - bugs may already be fixed")
    print("="*60)

if __name__ == "__main__":
    main()