#!/usr/bin/env python3
"""
Simple test script to validate hook syntax and basic functionality
"""

import json
import subprocess
import sys
from pathlib import Path

def test_hook_syntax(hook_file):
    """Test if hook file has valid Python syntax"""
    try:
        result = subprocess.run(
            [sys.executable, '-m', 'py_compile', hook_file],
            capture_output=True, text=True
        )
        return result.returncode == 0, result.stderr
    except Exception as e:
        return False, str(e)

def test_hook_execution(hook_file, test_data):
    """Test hook execution with sample data"""
    try:
        result = subprocess.run(
            [sys.executable, hook_file],
            input=json.dumps(test_data),
            capture_output=True, text=True, timeout=10
        )
        return {
            'success': True,
            'exit_code': result.returncode,
            'stdout': result.stdout,
            'stderr': result.stderr
        }
    except subprocess.TimeoutExpired:
        return {'success': False, 'error': 'Timeout'}
    except Exception as e:
        return {'success': False, 'error': str(e)}

def main():
    hooks_dir = Path(__file__).parent
    hooks = [
        ('user_prompt_submit.py', {
            'event': 'user_prompt_submit',
            'prompt': 'Test prompt for validation'
        }),
        ('pre_tool_use.py', {
            'event': 'pre_tool_use',
            'tool': {
                'name': 'Read',
                'parameters': {'file_path': '/test/path'}
            }
        }),
        ('post_tool_use.py', {
            'event': 'post_tool_use',
            'tool': {
                'name': 'Read',
                'parameters': {'file_path': '/test/path'}
            },
            'result': {}
        }),
        ('session_start.py', {
            'event': 'session_start'
        })
    ]
    
    print("🧪 Testing Claude Code Hooks")
    print("=" * 40)
    
    all_passed = True
    
    for hook_name, test_data in hooks:
        hook_file = hooks_dir / hook_name
        print(f"\n📋 Testing {hook_name}")
        
        # Test syntax
        syntax_valid, syntax_error = test_hook_syntax(hook_file)
        if syntax_valid:
            print("  ✓ Syntax validation passed")
        else:
            print(f"  ✗ Syntax validation failed: {syntax_error}")
            all_passed = False
            continue
        
        # Test execution
        exec_result = test_hook_execution(hook_file, test_data)
        if exec_result['success']:
            print(f"  ✓ Execution test passed (exit code: {exec_result['exit_code']})")
            if exec_result['stderr']:
                print(f"    Warning: {exec_result['stderr']}")
        else:
            print(f"  ✗ Execution test failed: {exec_result.get('error', 'Unknown error')}")
            all_passed = False
    
    print("\n" + "=" * 40)
    if all_passed:
        print("🎉 All hook tests passed!")
        return 0
    else:
        print("❌ Some hook tests failed!")
        return 1

if __name__ == "__main__":
    sys.exit(main())