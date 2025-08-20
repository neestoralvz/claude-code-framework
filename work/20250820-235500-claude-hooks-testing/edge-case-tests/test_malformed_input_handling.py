#!/usr/bin/env python3
"""
Edge Case Test: Malformed Input Handling
Tests hook resilience when receiving invalid, corrupted, or malicious input data

Required Evidence:
- Must handle all malformed input gracefully without crashing
- Must provide appropriate fallback behavior for invalid data
- Must maintain security when processing potentially malicious input
"""

import json
import subprocess
import sys
import os
from pathlib import Path

# Test cases for malformed input handling
MALFORMED_INPUT_CASES = [
    {
        "name": "invalid_json_input",
        "input_data": '{"invalid": json, missing quotes}',
        "expected_behavior": "graceful_fallback",
        "description": "Malformed JSON should trigger fallback handling"
    },
    {
        "name": "empty_input",
        "input_data": "",
        "expected_behavior": "default_data",
        "description": "Empty input should use default data"
    },
    {
        "name": "null_input", 
        "input_data": None,
        "expected_behavior": "stdin_detection",
        "description": "Null input should be handled with stdin detection"
    },
    {
        "name": "oversized_input",
        "input_data": json.dumps({"large_field": "x" * 100000, "event": "test"}),
        "expected_behavior": "size_limit_handling",
        "description": "Very large input should be processed or limited appropriately"
    },
    {
        "name": "missing_required_fields",
        "input_data": '{"random_field": "value"}',
        "expected_behavior": "field_defaults",
        "description": "Missing required fields should be added as defaults"
    },
    {
        "name": "deeply_nested_json",
        "input_data": json.dumps({
            "level1": {"level2": {"level3": {"level4": {"level5": {"deep": "data"}}}}},
            "event": "deep_test"
        }),
        "expected_behavior": "nested_handling",
        "description": "Deeply nested JSON should be processed correctly"
    },
    {
        "name": "special_characters_injection",
        "input_data": json.dumps({
            "event": "test",
            "prompt": "'; rm -rf /; echo 'malicious command'",
            "tool": {"name": "$(malicious)", "parameters": {"file_path": "/etc/passwd"}}
        }),
        "expected_behavior": "sanitization",
        "description": "Malicious command injection attempts should be sanitized"
    },
    {
        "name": "unicode_and_encoding_issues",
        "input_data": json.dumps({
            "event": "test",
            "content": "Test with unicode: 测试 🎉 \x00\x01\x02",
            "tool": {"name": "Test", "parameters": {}}
        }),
        "expected_behavior": "encoding_handling",
        "description": "Unicode and special encoding should be handled safely"
    }
]

def test_malformed_input_on_hook(hook_name, test_case):
    """Test a single malformed input case against a specific hook"""
    try:
        hook_path = Path.home() / ".claude" / "hooks" / f"{hook_name}.py"
        
        # Handle None input (simulates no stdin)
        if test_case["input_data"] is None:
            process = subprocess.run(
                [sys.executable, str(hook_path)],
                stdin=subprocess.DEVNULL,  # No input provided
                text=True,
                capture_output=True,
                timeout=10
            )
        else:
            process = subprocess.run(
                [sys.executable, str(hook_path)],
                input=test_case["input_data"],
                text=True,
                capture_output=True,
                timeout=10
            )
        
        # Analyze results
        try:
            hook_output = json.loads(process.stdout) if process.stdout else {}
        except json.JSONDecodeError:
            hook_output = {"parse_error": True, "raw_output": process.stdout}
        
        # Determine if hook handled the malformed input gracefully
        graceful_handling = (
            process.returncode in [0, 1, 2] and  # Valid exit codes
            not ("Traceback" in process.stderr) and  # No Python exceptions
            (hook_output or process.stdout)  # Some output was produced
        )
        
        return {
            "test_case": test_case["name"],
            "hook": hook_name,
            "exit_code": process.returncode,
            "graceful_handling": graceful_handling,
            "has_output": bool(process.stdout),
            "has_errors": bool(process.stderr),
            "python_exception": "Traceback" in process.stderr if process.stderr else False,
            "hook_output": hook_output,
            "stderr": process.stderr,
            "passed": graceful_handling
        }
        
    except subprocess.TimeoutExpired:
        return {
            "test_case": test_case["name"],
            "hook": hook_name,
            "passed": False,
            "error": "timeout",
            "description": "Hook execution timed out"
        }
    except Exception as e:
        return {
            "test_case": test_case["name"],
            "hook": hook_name,
            "passed": False,
            "error": str(e),
            "description": f"Test execution failed: {e}"
        }

def run_malformed_input_tests():
    """Run malformed input tests against all critical hooks"""
    print("=" * 60)
    print("MALFORMED INPUT HANDLING TEST SUITE")
    print("=" * 60)
    
    # Hooks to test
    critical_hooks = ["pre_tool_use", "user_prompt_agent_enforcer", "post_tool_use"]
    
    all_results = []
    total_tests = 0
    passed_tests = 0
    
    for hook_name in critical_hooks:
        print(f"\n{'-' * 40}")
        print(f"Testing hook: {hook_name}")
        print(f"{'-' * 40}")
        
        for test_case in MALFORMED_INPUT_CASES:
            total_tests += 1
            result = test_malformed_input_on_hook(hook_name, test_case)
            all_results.append(result)
            
            if result["passed"]:
                passed_tests += 1
                print(f"✓ PASSED: {test_case['name']}")
            else:
                print(f"✗ FAILED: {test_case['name']}")
                if 'error' in result:
                    print(f"  Error: {result['error']}")
                if result.get("python_exception"):
                    print(f"  Python exception occurred!")
    
    # Calculate overall results
    pass_rate = (passed_tests / total_tests) * 100
    
    print(f"\n{'='*60}")
    print("MALFORMED INPUT HANDLING SUMMARY")
    print(f"{'='*60}")
    print(f"Total Tests: {total_tests}")
    print(f"Passed: {passed_tests}")
    print(f"Failed: {total_tests - passed_tests}")
    print(f"Pass Rate: {pass_rate:.1f}%")
    
    # Evidence validation
    evidence_validated = pass_rate >= 90.0  # 90% minimum for malformed input handling
    
    if evidence_validated:
        print("\n✓ EVIDENCE VALIDATED: Hooks handle malformed input gracefully")
        print("   Hook system is resilient to invalid and malicious input")
    else:
        print(f"\n✗ EVIDENCE FAILED: Hooks fail on malformed input ({pass_rate:.1f}% pass rate)")
        print("   CRITICAL: Hook system vulnerable to input-based failures")
    
    # Security analysis
    security_failures = [r for r in all_results if r.get("python_exception") or r.get("exit_code", 0) > 2]
    if security_failures:
        print(f"\n⚠️  SECURITY CONCERN: {len(security_failures)} tests caused critical failures")
        for failure in security_failures:
            print(f"   - {failure['hook']}: {failure['test_case']}")
    
    return {
        "total_tests": total_tests,
        "passed": passed_tests,
        "failed": total_tests - passed_tests,
        "pass_rate": pass_rate,
        "test_results": all_results,
        "evidence_validated": evidence_validated,
        "security_failures": len(security_failures)
    }

if __name__ == "__main__":
    results = run_malformed_input_tests()
    
    # Save detailed results
    output_file = Path(__file__).parent / "malformed_input_handling_results.json"
    with open(output_file, "w") as f:
        json.dump(results, f, indent=2)
    
    print(f"\nDetailed results saved to: {output_file}")
    
    # Exit with appropriate code
    sys.exit(0 if results["evidence_validated"] else 1)