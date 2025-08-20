#!/usr/bin/env python3
"""
Execute hooks testing directly in current Python session
"""

import json
import subprocess
import sys
import os
import time
from pathlib import Path

# Test execution function
def run_hook_test(hook_path, input_data, timeout=10):
    """Execute a hook with given input data and return result"""
    try:
        input_json = json.dumps(input_data)
        
        process = subprocess.run(
            [sys.executable, str(hook_path)],
            input=input_json,
            capture_output=True,
            text=True,
            timeout=timeout
        )
        
        stdout_data = None
        if process.stdout.strip():
            try:
                stdout_data = json.loads(process.stdout)
            except json.JSONDecodeError:
                stdout_data = process.stdout.strip()
        
        return {
            "exit_code": process.returncode,
            "stdout": stdout_data,
            "stderr": process.stderr.strip(),
            "success": True
        }
        
    except subprocess.TimeoutExpired:
        return {"error": "Hook execution timeout", "exit_code": -2, "success": False}
    except Exception as e:
        return {"error": f"Execution error: {e}", "exit_code": -3, "success": False}

def main():
    hooks_dir = Path("/Users/nalve/.claude/hooks")
    results = {}
    
    print("CLAUDE CODE HOOKS TESTING")
    print("=" * 50)
    
    # 1. SYNTAX VALIDATION
    print("\n1. SYNTAX VALIDATION")
    print("-" * 30)
    
    for hook_file in hooks_dir.glob("*.py"):
        try:
            with open(hook_file, 'r') as f:
                code = f.read()
            compile(code, str(hook_file), 'exec')
            print(f"✓ {hook_file.name} - Syntax valid")
            results[f"syntax_{hook_file.stem}"] = "PASS"
        except SyntaxError as e:
            print(f"✗ {hook_file.name} - Syntax error: {e}")
            results[f"syntax_{hook_file.stem}"] = f"FAIL: {e}"
        except Exception as e:
            print(f"✗ {hook_file.name} - Error: {e}")
            results[f"syntax_{hook_file.stem}"] = f"FAIL: {e}"
    
    # 2. PEP 723 COMPLIANCE
    print("\n2. PEP 723 COMPLIANCE")
    print("-" * 30)
    
    for hook_file in hooks_dir.glob("*.py"):
        try:
            with open(hook_file, 'r') as f:
                content = f.read()
            
            has_shebang = content.startswith('#!')
            has_script_block = '# /// script' in content and '# ///' in content
            has_dependencies = 'dependencies' in content
            
            if has_shebang and has_script_block and has_dependencies:
                print(f"✓ {hook_file.name} - PEP 723 compliant")
                results[f"pep723_{hook_file.stem}"] = "PASS"
            else:
                missing = []
                if not has_shebang: missing.append("shebang")
                if not has_script_block: missing.append("script block")
                if not has_dependencies: missing.append("dependencies")
                print(f"✗ {hook_file.name} - Missing: {', '.join(missing)}")
                results[f"pep723_{hook_file.stem}"] = f"FAIL: Missing {', '.join(missing)}"
                
        except Exception as e:
            print(f"✗ {hook_file.name} - Error: {e}")
            results[f"pep723_{hook_file.stem}"] = f"FAIL: {e}"
    
    # 3. BASIC FUNCTIONALITY TESTS
    print("\n3. BASIC FUNCTIONALITY")
    print("-" * 30)
    
    # Test session_start
    hook_path = hooks_dir / "session_start.py"
    if hook_path.exists():
        result = run_hook_test(hook_path, {"event": "session_start"})
        if result.get("success") and result.get("exit_code", -1) in [0, 1]:
            print("✓ session_start - Basic functionality working")
            results["func_session_start"] = "PASS"
        else:
            print(f"✗ session_start - Failed: {result.get('error', 'Unknown error')}")
            results["func_session_start"] = f"FAIL: {result.get('error', 'Unknown error')}"
    
    # Test user_prompt_submit
    hook_path = hooks_dir / "user_prompt_submit.py"
    if hook_path.exists():
        result = run_hook_test(hook_path, {"event": "user_prompt_submit", "prompt": "test prompt"})
        if result.get("success") and result.get("exit_code") == 0:
            print("✓ user_prompt_submit - Basic functionality working")
            results["func_user_prompt_submit"] = "PASS"
        else:
            print(f"✗ user_prompt_submit - Failed: {result.get('error', 'Unknown error')}")
            results["func_user_prompt_submit"] = f"FAIL: {result.get('error', 'Unknown error')}"
    
    # Test pre_tool_use
    hook_path = hooks_dir / "pre_tool_use.py"
    if hook_path.exists():
        result = run_hook_test(hook_path, {"event": "pre_tool_use", "tool": {"name": "Read", "parameters": {}}})
        if result.get("success") and result.get("exit_code", -1) in [0, 1]:
            print("✓ pre_tool_use - Basic functionality working")
            results["func_pre_tool_use"] = "PASS"
        else:
            print(f"✗ pre_tool_use - Failed: {result.get('error', 'Unknown error')}")
            results["func_pre_tool_use"] = f"FAIL: {result.get('error', 'Unknown error')}"
    
    # Test post_tool_use
    hook_path = hooks_dir / "post_tool_use.py"
    if hook_path.exists():
        result = run_hook_test(hook_path, {"event": "post_tool_use", "tool": {"name": "Read", "parameters": {}}, "result": {}})
        if result.get("success") and result.get("exit_code", -1) in [0, 1]:
            print("✓ post_tool_use - Basic functionality working")
            results["func_post_tool_use"] = "PASS"
        else:
            print(f"✗ post_tool_use - Failed: {result.get('error', 'Unknown error')}")
            results["func_post_tool_use"] = f"FAIL: {result.get('error', 'Unknown error')}"
    
    # 4. SECURITY VALIDATION
    print("\n4. SECURITY VALIDATION")
    print("-" * 30)
    
    # Test dangerous path blocking
    hook_path = hooks_dir / "pre_tool_use.py"
    if hook_path.exists():
        dangerous_input = {
            "event": "pre_tool_use",
            "tool": {
                "name": "Edit",
                "parameters": {"file_path": "/etc/passwd", "old_string": "test", "new_string": "test2"}
            }
        }
        result = run_hook_test(hook_path, dangerous_input)
        if result.get("exit_code") == 2:
            print("✓ Security - Dangerous path blocked correctly")
            results["security_dangerous_path"] = "PASS"
        else:
            print("✗ Security - Failed to block dangerous path")
            results["security_dangerous_path"] = "FAIL: Should block dangerous paths"
    
    # 5. ERROR HANDLING
    print("\n5. ERROR HANDLING")
    print("-" * 30)
    
    # Test invalid JSON handling
    for hook_name in ["session_start", "user_prompt_submit", "pre_tool_use", "post_tool_use"]:
        hook_path = hooks_dir / f"{hook_name}.py"
        if hook_path.exists():
            try:
                process = subprocess.run(
                    [sys.executable, str(hook_path)],
                    input="invalid json{",
                    capture_output=True,
                    text=True,
                    timeout=5
                )
                if process.returncode == 1:
                    print(f"✓ {hook_name} - Invalid JSON handled gracefully")
                    results[f"error_{hook_name}"] = "PASS"
                else:
                    print(f"✗ {hook_name} - Invalid JSON not handled properly")
                    results[f"error_{hook_name}"] = "FAIL: Should handle invalid JSON"
            except Exception as e:
                print(f"✗ {hook_name} - Error testing: {e}")
                results[f"error_{hook_name}"] = f"FAIL: {e}"
    
    # SUMMARY
    print("\n" + "=" * 50)
    print("TEST SUMMARY")
    print("=" * 50)
    
    total_tests = len(results)
    passed_tests = sum(1 for r in results.values() if r == "PASS")
    failed_tests = total_tests - passed_tests
    success_rate = (passed_tests / total_tests * 100) if total_tests > 0 else 0
    
    print(f"Total Tests: {total_tests}")
    print(f"Passed: {passed_tests}")
    print(f"Failed: {failed_tests}")
    print(f"Success Rate: {success_rate:.1f}%")
    
    print("\nFAILED TESTS:")
    print("-" * 30)
    failed_found = False
    for test_name, result in results.items():
        if "FAIL" in result:
            print(f"✗ {test_name}: {result}")
            failed_found = True
    
    if not failed_found:
        print("No failed tests!")
    
    # Save results
    report = {
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
        "summary": {
            "total_tests": total_tests,
            "passed": passed_tests,
            "failed": failed_tests,
            "success_rate": f"{success_rate:.1f}%"
        },
        "detailed_results": results
    }
    
    report_path = "/Users/nalve/.claude/operations/20250820-130000-claude-hooks-testing/test_results.json"
    with open(report_path, 'w') as f:
        json.dump(report, f, indent=2)
    
    print(f"\nDetailed results saved to: {report_path}")
    
    return failed_tests == 0

if __name__ == "__main__":
    success = main()
    print(f"\nTesting completed. Success: {success}")