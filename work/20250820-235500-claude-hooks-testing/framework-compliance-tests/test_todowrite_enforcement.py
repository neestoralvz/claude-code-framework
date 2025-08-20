#!/usr/bin/env python3
"""
Framework Compliance Test: TodoWrite Enforcement
Tests that hooks enforce TodoWrite usage for multi-step tasks as required by Universal Operation Mandates

Required Evidence:
- Must detect multi-step operations without TodoWrite tracking
- Must warn when complex tasks lack proper task breakdown
- Must validate TodoWrite integration across all workflows
"""

import json
import subprocess
import sys
import os
from pathlib import Path

# Test scenarios for TodoWrite enforcement
TODOWRITE_SCENARIOS = [
    {
        "name": "multi_step_file_modifications_without_todowrite",
        "hook_input": {
            "event": "pre_tool_use",
            "tool": {
                "name": "MultiEdit",
                "parameters": {
                    "file_path": "/tmp/complex_file.py",
                    "edits": [
                        {"old_string": "old1", "new_string": "new1"},
                        {"old_string": "old2", "new_string": "new2"},
                        {"old_string": "old3", "new_string": "new3"}
                    ]
                }
            },
            "conversation_context": "Refactor the application to improve performance and add new features"
        },
        "expected_warning": True,
        "expected_message": "TodoWrite"
    },
    {
        "name": "complex_task_with_todowrite_mentioned",
        "hook_input": {
            "event": "pre_tool_use",
            "tool": {
                "name": "Write",
                "parameters": {
                    "file_path": "/tmp/new_service.py",
                    "content": "# New microservice implementation\nclass APIService:\n    pass"
                }
            },
            "conversation_context": "Used TodoWrite to break down microservice implementation into atomic tasks"
        },
        "expected_warning": False,
        "expected_message": None
    },
    {
        "name": "simple_read_operation",
        "hook_input": {
            "event": "pre_tool_use",
            "tool": {
                "name": "Read",
                "parameters": {
                    "file_path": "/tmp/config.json"
                }
            },
            "conversation_context": "Check current configuration"
        },
        "expected_warning": False,
        "expected_message": None
    },
    {
        "name": "complex_implementation_without_todo_tracking",
        "hook_input": {
            "event": "pre_tool_use",
            "tool": {
                "name": "Write", 
                "parameters": {
                    "file_path": "/tmp/complex_system.py",
                    "content": "# Complex system with authentication, database, and API endpoints\nclass ComplexSystem:\n    def __init__(self):\n        pass"
                }
            },
            "conversation_context": "Build comprehensive system with multiple components and integrations"
        },
        "expected_warning": True,
        "expected_message": "TodoWrite"
    }
]

def test_todowrite_enforcement(scenario):
    """Test TodoWrite enforcement in pre_tool_use hook"""
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
            "expected_warning": scenario["expected_warning"],
            "hook_output": hook_output,
            "stderr": process.stderr,
            "passed": False,
            "details": {}
        }
        
        # Check TodoWrite enforcement
        warnings = hook_output.get("warnings", [])
        has_todowrite_warning = any("TodoWrite" in str(warning) for warning in warnings)
        
        if scenario["expected_warning"]:
            # Should have TodoWrite warning
            test_result["passed"] = has_todowrite_warning
            test_result["details"]["todowrite_warning_present"] = has_todowrite_warning
            test_result["details"]["warnings"] = warnings
        else:
            # Should not have TodoWrite warning
            test_result["passed"] = not has_todowrite_warning
            test_result["details"]["no_todowrite_warning"] = not has_todowrite_warning
            test_result["details"]["warnings"] = warnings
            
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

def run_todowrite_enforcement_tests():
    """Run all TodoWrite enforcement tests"""
    print("=" * 60)
    print("TODOWRITE ENFORCEMENT TEST SUITE")
    print("=" * 60)
    
    test_results = []
    passed_count = 0
    
    for scenario in TODOWRITE_SCENARIOS:
        print(f"\nTesting: {scenario['name']}")
        result = test_todowrite_enforcement(scenario)
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
    total_tests = len(TODOWRITE_SCENARIOS)
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
        print("\n✓ EVIDENCE VALIDATED: TodoWrite enforcement working at 100% accuracy")
        print("   Universal Operation Mandate for task tracking is properly enforced")
    else:
        print(f"\n✗ EVIDENCE FAILED: TodoWrite enforcement only {pass_rate:.1f}% accurate")
        print("   CRITICAL: Universal Operation Mandate for task tracking is not properly enforced")
    
    return {
        "total_tests": total_tests,
        "passed": passed_count,
        "failed": total_tests - passed_count,
        "pass_rate": pass_rate,
        "test_results": test_results,
        "evidence_validated": pass_rate == 100.0
    }

if __name__ == "__main__":
    results = run_todowrite_enforcement_tests()
    
    # Save detailed results
    output_file = Path(__file__).parent / "todowrite_enforcement_results.json"
    with open(output_file, "w") as f:
        json.dump(results, f, indent=2)
    
    print(f"\nDetailed results saved to: {output_file}")
    
    # Exit with appropriate code
    sys.exit(0 if results["evidence_validated"] else 1)