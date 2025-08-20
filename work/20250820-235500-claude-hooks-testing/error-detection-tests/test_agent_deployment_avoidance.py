#!/usr/bin/env python3
"""
Error Detection Test: Agent Deployment Avoidance Detection
Tests that hooks detect and enforce mandatory agent deployment for all specialized work

Required Evidence:
- Must detect direct implementation attempts with 100% accuracy
- Must enforce specialized agent deployment for specialized tasks
- Must block operations until proper agent orchestration is used
"""

import json
import subprocess
import sys
import os
from pathlib import Path

# Test scenarios for agent deployment avoidance
AGENT_AVOIDANCE_SCENARIOS = [
    {
        "name": "direct_implementation_attempt",
        "hook_input": {
            "event": "user_prompt_submit",
            "prompt": "Create a Python script that processes CSV files and generates reports"
        },
        "expected_enforcement": True,
        "expected_message": "MANDATORY: Must use Task tool with appropriate specialized agents"
    },
    {
        "name": "complex_development_without_agents",
        "hook_input": {
            "event": "user_prompt_submit", 
            "prompt": "Build a web API with authentication and database integration"
        },
        "expected_enforcement": True,
        "expected_message": "specialized agents for specialized tasks"
    },
    {
        "name": "simple_file_operation",
        "hook_input": {
            "event": "user_prompt_submit",
            "prompt": "Read the contents of README.md file"
        },
        "expected_enforcement": False,
        "expected_message": None
    },
    {
        "name": "agent_compliant_request",
        "hook_input": {
            "event": "user_prompt_submit",
            "prompt": "Use Task tool to deploy specialized agent for database migration implementation"
        },
        "expected_enforcement": False,
        "expected_message": None
    },
    {
        "name": "implementation_with_existing_agent_mention",
        "hook_input": {
            "event": "user_prompt_submit",
            "prompt": "Create authentication system using existing security agent patterns"
        },
        "expected_enforcement": False,
        "expected_message": None
    }
]

def test_agent_enforcer_hook(scenario):
    """Test the user_prompt_agent_enforcer.py hook with given scenario"""
    try:
        # Convert test data to JSON
        hook_input_json = json.dumps(scenario["hook_input"])
        
        # Run the agent enforcer hook
        hook_path = Path.home() / ".claude" / "hooks" / "user_prompt_agent_enforcer.py"
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
            "expected_enforcement": scenario["expected_enforcement"],
            "hook_output": hook_output,
            "stderr": process.stderr,
            "passed": False,
            "details": {}
        }
        
        # Check if agent enforcement worked correctly
        if scenario["expected_enforcement"]:
            # Should inject enforcement message
            enforcement_applied = hook_output.get("metadata", {}).get("agent_enforcement_applied", False)
            enforcement_message_present = "MANDATORY" in hook_output.get("prompt", "")
            
            test_result["passed"] = enforcement_applied and enforcement_message_present
            test_result["details"]["enforcement_applied"] = enforcement_applied
            test_result["details"]["enforcement_message_present"] = enforcement_message_present
            test_result["details"]["modified_prompt"] = hook_output.get("prompt", "")
        else:
            # Should pass through unchanged
            no_enforcement = not hook_output.get("metadata", {}).get("agent_enforcement_applied", False)
            original_prompt_preserved = hook_output.get("prompt") == scenario["hook_input"]["prompt"]
            
            test_result["passed"] = no_enforcement and (original_prompt_preserved or not hook_output.get("prompt"))
            test_result["details"]["no_enforcement"] = no_enforcement
            test_result["details"]["prompt_preserved"] = original_prompt_preserved
            
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

def run_all_agent_enforcement_tests():
    """Run all agent deployment enforcement tests"""
    print("=" * 60)
    print("AGENT DEPLOYMENT ENFORCEMENT TEST SUITE")
    print("=" * 60)
    
    test_results = []
    passed_count = 0
    
    for scenario in AGENT_AVOIDANCE_SCENARIOS:
        print(f"\nTesting: {scenario['name']}")
        result = test_agent_enforcer_hook(scenario)
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
    total_tests = len(AGENT_AVOIDANCE_SCENARIOS)
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
        print("\n✓ EVIDENCE VALIDATED: Agent deployment enforcement working at 100% accuracy")
    else:
        print(f"\n✗ EVIDENCE FAILED: Agent deployment enforcement only {pass_rate:.1f}% accurate")
        print("   CRITICAL: Mandatory agent deployment is not being enforced")
    
    return {
        "total_tests": total_tests,
        "passed": passed_count,
        "failed": total_tests - passed_count,
        "pass_rate": pass_rate,
        "test_results": test_results,
        "evidence_validated": pass_rate == 100.0
    }

if __name__ == "__main__":
    results = run_all_agent_enforcement_tests()
    
    # Save detailed results
    output_file = Path(__file__).parent / "agent_deployment_enforcement_results.json"
    with open(output_file, "w") as f:
        json.dump(results, f, indent=2)
    
    print(f"\nDetailed results saved to: {output_file}")
    
    # Exit with appropriate code
    sys.exit(0 if results["evidence_validated"] else 1)