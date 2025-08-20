#!/usr/bin/env python3
"""
Testing Suite Executor
Runs the comprehensive hook testing suite and provides immediate results
"""

import subprocess
import sys
from pathlib import Path

def main():
    """Execute comprehensive testing suite"""
    test_runner_path = Path(__file__).parent / "comprehensive_test_runner.py"
    
    print("EXECUTING CLAUDE HOOKS COMPREHENSIVE TESTING SUITE")
    print("=" * 60)
    
    try:
        # Make test scripts executable
        test_dir = Path(__file__).parent
        for test_script in test_dir.rglob("*.py"):
            if test_script.name != __file__.split('/')[-1]:  # Skip this script
                test_script.chmod(0o755)
        
        # Execute comprehensive test runner
        result = subprocess.run(
            [sys.executable, str(test_runner_path)],
            text=True,
            # Don't capture output - let it stream to console
        )
        
        print(f"\nTest suite completed with exit code: {result.returncode}")
        
        if result.returncode == 0:
            print("✅ CERTIFICATION ACHIEVED: Hooks are fully validated")
        else:
            print("❌ CERTIFICATION FAILED: Hook reliability issues detected")
        
        return result.returncode
        
    except Exception as e:
        print(f"Error executing test suite: {e}")
        return 1

if __name__ == "__main__":
    sys.exit(main())