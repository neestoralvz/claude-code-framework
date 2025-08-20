#!/usr/bin/env python3
"""
Error Detection Test: Context7 Bypass Detection
Tests that hooks detect and block Context7 framework violations

Required Evidence:
- Must detect Context7 bypass attempts with 100% accuracy
- Must block operations until Context7 research is completed
- Must provide clear error messages for Context7 violations
"""

import json
import subprocess
import sys
import os
from pathlib import Path

# Test data for Context7 bypass scenarios
BYPASS_SCENARIOS = [
    {
        "name": "direct_code_creation_without_context7",
        "hook_input": {
            "event": "pre_tool_use",
            "tool": {
                "name": "Write",
                "parameters": {
                    "file_path": "/tmp/test_script.py",
                    "content": "#!/usr/bin/env python3\nprint('Direct creation without Context7')"
                }
            },
            "conversation_context": "Create a Python script that does something"
        },
        "expected_error": True,
        "expected_message": "Context7 research required before code creation"
    },
    {
        "name": "library_integration_without_context7",
        "hook_input": {
            "event": "pre_tool_use", 
            "tool": {
                "name": "Edit",
                "parameters": {
                    "file_path": "/tmp/existing_file.py",
                    "old_string": "import requests",
                    "new_string": "import requests\nimport boto3"
                }
            },
            "conversation_context": "Add AWS SDK integration"
        },
        "expected_error": True,
        "expected_message": "Context7 research required for library integration"
    },
    {
        "name": "context7_compliant_operation",
        "hook_input": {
            "event": "pre_tool_use",
            "tool": {
                "name": "Write", 
                "parameters": {
                    "file_path": "/tmp/compliant_file.py",
                    "content": "# Created after Context7 research\nprint('Compliant implementation')"
                }
            },
            "conversation_context": "Used Context7 to research Python best practices before implementation"
        },
        "expected_error": False,
        "expected_message": None
    }
]

def run_hook_test(scenario):
    """Run a single hook test scenario and validate results"""
    try:
        # Convert test data to JSON
        hook_input_json = json.dumps(scenario["hook_input"])
        
        # Run the pre_tool_use hook
        hook_path = Path.home() / ".claude" / "hooks" / "pre_tool_use.py"
        process = subprocess.run(
            [sys.executable, str(hook_path)],
            input=hook_input_json,
            text=True,
            capture_output=True,
            timeout=10
        )
        
        # Parse hook output
        try:
            hook_output = json.loads(process.stdout) if process.stdout else {}
        except json.JSONDecodeError:
            hook_output = {"parse_error": True, "raw_output": process.stdout}
        
        # Validate test results
        test_result = {
            "scenario": scenario["name"],
            "exit_code": process.returncode,
            "expected_error": scenario["expected_error"],
            "hook_output": hook_output,
            "stderr": process.stderr,
            "passed": False,
            "details": {}
        }
        
        # Check if error detection worked correctly
        if scenario["expected_error"]:
            # Should block with exit code 2
            test_result["passed"] = (process.returncode == 2)
            test_result["details"]["error_blocking"] = process.returncode == 2
            test_result["details"]["error_message_present"] = bool(hook_output.get("errors"))
        else:
            # Should allow with exit code 0
            test_result["passed"] = (process.returncode == 0)
            test_result["details"]["operation_allowed"] = process.returncode == 0
            test_result["details"]["no_errors"] = not bool(hook_output.get("errors"))
            
        return test_result
        
    except subprocess.TimeoutExpired:
        return {
            "scenario": scenario["name"],
            "passed": False,
            "error": "Hook execution timeout",
            "details": {"timeout": True}
        }
    except Exception as e:
        return {
            "scenario": scenario["name"],
            "passed": False,
            "error": str(e),
            "details": {"exception": True}
        }

def run_all_tests():
    """Run all Context7 bypass detection tests"""
    print("=" * 60)
    print("CONTEXT7 BYPASS DETECTION TEST SUITE")
    print("=" * 60)
    
    test_results = []
    passed_count = 0
    
    for scenario in BYPASS_SCENARIOS:
        print(f"\nTesting: {scenario['name']}")
        result = run_hook_test(scenario)
        test_results.append(result)
        
        if result["passed"]:
            passed_count += 1
            print(f"✓ PASSED: {scenario['name']}")
        else:
            print(f"✗ FAILED: {scenario['name']}")
            print(f"  Details: {result.get('details', {})}")
            if 'error' in result:
                print(f"  Error: {result['error']}")
    
    # Generate summary report
    total_tests = len(BYPASS_SCENARIOS)
    pass_rate = (passed_count / total_tests) * 100
    
    print(f"\n{'='*60}")
    print("TEST SUMMARY")
    print(f"{'='*60}")
    print(f"Total Tests: {total_tests}")
    print(f"Passed: {passed_count}")
    print(f"Failed: {total_tests - passed_count}")
    print(f"Pass Rate: {pass_rate:.1f}%")
    
    # Evidence validation
    if pass_rate == 100.0:
        print("\n✓ EVIDENCE VALIDATED: Context7 bypass detection working at 100% accuracy")
    else:
        print(f"\n✗ EVIDENCE FAILED: Context7 bypass detection only {pass_rate:.1f}% accurate")
        print("   CRITICAL: Framework violation detection is not reliable")
    
    return {
        "total_tests": total_tests,
        "passed": passed_count,
        "failed": total_tests - passed_count,
        "pass_rate": pass_rate,
        "test_results": test_results,
        "evidence_validated": pass_rate == 100.0
    }

if __name__ == "__main__":
    results = run_all_tests()
    
    # Save detailed results
    output_file = Path(__file__).parent / "context7_bypass_detection_results.json"
    with open(output_file, "w") as f:
        json.dump(results, f, indent=2)
    
    print(f"\nDetailed results saved to: {output_file}")
    
    # Exit with appropriate code
    sys.exit(0 if results["evidence_validated"] else 1)