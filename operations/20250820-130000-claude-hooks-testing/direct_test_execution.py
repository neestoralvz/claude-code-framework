#!/usr/bin/env python3
"""
Direct execution of hook tests
"""

import json
import subprocess
import sys
import os
import time
from pathlib import Path

def test_hooks():
    hooks_dir = Path("/Users/nalve/.claude/hooks")
    results = {}
    
    print("CLAUDE CODE HOOKS TESTING")
    print("=" * 50)
    
    # 1. Check if hooks exist
    hook_files = ["session_start.py", "user_prompt_submit.py", "pre_tool_use.py", "post_tool_use.py"]
    existing_hooks = []
    
    print("\n1. HOOK FILES CHECK")
    print("-" * 30)
    for hook_file in hook_files:
        hook_path = hooks_dir / hook_file
        if hook_path.exists():
            print(f"✓ {hook_file} exists")
            existing_hooks.append(hook_file)
            results[f"exists_{hook_file}"] = "PASS"
        else:
            print(f"✗ {hook_file} missing")
            results[f"exists_{hook_file}"] = "FAIL: File not found"
    
    # 2. Syntax validation
    print("\n2. SYNTAX VALIDATION")
    print("-" * 30)
    
    for hook_file in existing_hooks:
        hook_path = hooks_dir / hook_file
        try:
            with open(hook_path, 'r') as f:
                code = f.read()
            compile(code, str(hook_path), 'exec')
            print(f"✓ {hook_file} - Syntax valid")
            results[f"syntax_{hook_file}"] = "PASS"
        except SyntaxError as e:
            print(f"✗ {hook_file} - Syntax error: {e}")
            results[f"syntax_{hook_file}"] = f"FAIL: {e}"
        except Exception as e:
            print(f"✗ {hook_file} - Error: {e}")
            results[f"syntax_{hook_file}"] = f"FAIL: {e}"
    
    # 3. Executable permissions
    print("\n3. EXECUTABLE PERMISSIONS")
    print("-" * 30)
    
    for hook_file in existing_hooks:
        hook_path = hooks_dir / hook_file
        if os.access(hook_path, os.X_OK):
            print(f"✓ {hook_file} - Executable")
            results[f"executable_{hook_file}"] = "PASS"
        else:
            print(f"✗ {hook_file} - Not executable")
            results[f"executable_{hook_file}"] = "FAIL: Not executable"
    
    # 4. Basic execution test
    print("\n4. BASIC EXECUTION TESTS")
    print("-" * 30)
    
    test_cases = {
        "session_start.py": {"event": "session_start"},
        "user_prompt_submit.py": {"event": "user_prompt_submit", "prompt": "test prompt"},
        "pre_tool_use.py": {"event": "pre_tool_use", "tool": {"name": "Read", "parameters": {}}},
        "post_tool_use.py": {"event": "post_tool_use", "tool": {"name": "Read", "parameters": {}}, "result": {}}
    }
    
    for hook_file in existing_hooks:
        if hook_file in test_cases:
            hook_path = hooks_dir / hook_file
            try:
                input_data = test_cases[hook_file]
                input_json = json.dumps(input_data)
                
                # Execute with timeout
                process = subprocess.run(
                    [sys.executable, str(hook_path)],
                    input=input_json,
                    capture_output=True,
                    text=True,
                    timeout=10
                )
                
                if process.returncode in [0, 1]:  # Success or non-blocking warning
                    print(f"✓ {hook_file} - Executed successfully (exit code: {process.returncode})")
                    results[f"execution_{hook_file}"] = "PASS"
                elif process.returncode == 2:  # Blocking error
                    print(f"✗ {hook_file} - Blocking error (exit code: 2)")
                    results[f"execution_{hook_file}"] = "FAIL: Blocking error"
                else:
                    print(f"✗ {hook_file} - Failed (exit code: {process.returncode})")
                    results[f"execution_{hook_file}"] = f"FAIL: Exit code {process.returncode}"
                    
                # Check stderr for errors
                if process.stderr.strip():
                    print(f"  Warning: stderr output detected: {process.stderr.strip()[:100]}...")
                    
            except subprocess.TimeoutExpired:
                print(f"✗ {hook_file} - Execution timeout")
                results[f"execution_{hook_file}"] = "FAIL: Timeout"
            except Exception as e:
                print(f"✗ {hook_file} - Execution error: {e}")
                results[f"execution_{hook_file}"] = f"FAIL: {e}"
    
    # 5. Error handling test  
    print("\n5. ERROR HANDLING TESTS")
    print("-" * 30)
    
    for hook_file in existing_hooks:
        hook_path = hooks_dir / hook_file
        try:
            # Test invalid JSON
            process = subprocess.run(
                [sys.executable, str(hook_path)],
                input="invalid json{",
                capture_output=True,
                text=True,
                timeout=5
            )
            
            if process.returncode == 1:  # Should handle gracefully
                print(f"✓ {hook_file} - Invalid JSON handled gracefully")
                results[f"error_handling_{hook_file}"] = "PASS"
            else:
                print(f"✗ {hook_file} - Invalid JSON not handled properly (exit: {process.returncode})")
                results[f"error_handling_{hook_file}"] = f"FAIL: Exit code {process.returncode}"
                
        except Exception as e:
            print(f"✗ {hook_file} - Error testing failed: {e}")
            results[f"error_handling_{hook_file}"] = f"FAIL: {e}"
    
    # 6. Security test (pre_tool_use only)
    print("\n6. SECURITY VALIDATION")
    print("-" * 30)
    
    if "pre_tool_use.py" in existing_hooks:
        hook_path = hooks_dir / "pre_tool_use.py"
        try:
            # Test dangerous file path
            dangerous_input = {
                "event": "pre_tool_use",
                "tool": {
                    "name": "Edit",
                    "parameters": {"file_path": "/etc/passwd", "old_string": "test", "new_string": "test2"}
                }
            }
            input_json = json.dumps(dangerous_input)
            
            process = subprocess.run(
                [sys.executable, str(hook_path)],
                input=input_json,
                capture_output=True,
                text=True,
                timeout=10
            )
            
            if process.returncode == 2:  # Should block dangerous operations
                print("✓ pre_tool_use - Dangerous path blocked correctly")
                results["security_dangerous_path"] = "PASS"
            else:
                print(f"✗ pre_tool_use - Failed to block dangerous path (exit: {process.returncode})")
                results["security_dangerous_path"] = f"FAIL: Should block with exit code 2"
                
        except Exception as e:
            print(f"✗ Security test failed: {e}")
            results["security_dangerous_path"] = f"FAIL: {e}"
    
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
    
    if failed_tests > 0:
        print("\nFAILED TESTS:")
        print("-" * 30)
        for test_name, result in results.items():
            if "FAIL" in result:
                print(f"✗ {test_name}: {result}")
    else:
        print("\n✓ All tests passed!")
    
    # Generate recommendations
    recommendations = []
    
    # Check for critical failures
    syntax_failures = [t for t in results if "syntax_" in t and "FAIL" in results[t]]
    if syntax_failures:
        recommendations.append("CRITICAL: Fix syntax errors before deployment")
    
    execution_failures = [t for t in results if "execution_" in t and "FAIL" in results[t]]
    if execution_failures:
        recommendations.append("CRITICAL: Fix execution failures")
    
    security_failures = [t for t in results if "security_" in t and "FAIL" in results[t]]
    if security_failures:
        recommendations.append("CRITICAL: Address security validation failures immediately")
    
    executable_failures = [t for t in results if "executable_" in t and "FAIL" in results[t]]
    if executable_failures:
        recommendations.append("Make hook files executable: chmod +x /Users/nalve/.claude/hooks/*.py")
    
    if not recommendations:
        recommendations.append("All tests passed! Hooks are ready for production deployment")
    
    print("\nRECOMMENDATIONS:")
    print("-" * 30)
    for rec in recommendations:
        print(f"• {rec}")
    
    # Save results
    report = {
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
        "summary": {
            "total_tests": total_tests,
            "passed": passed_tests,
            "failed": failed_tests,
            "success_rate": f"{success_rate:.1f}%"
        },
        "detailed_results": results,
        "recommendations": recommendations
    }
    
    return report

if __name__ == "__main__":
    report = test_hooks()
    
    # Save report
    report_path = "/Users/nalve/.claude/operations/20250820-130000-claude-hooks-testing/final_test_report.json"
    try:
        with open(report_path, 'w') as f:
            json.dump(report, f, indent=2)
        print(f"\nFinal report saved to: {report_path}")
    except Exception as e:
        print(f"Could not save report: {e}")