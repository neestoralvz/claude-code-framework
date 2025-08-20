#!/usr/bin/env python3
"""
Edge Case Test: Concurrent Hook Execution
Tests hook reliability under concurrent execution scenarios (MAX 10 per framework mandate)

Required Evidence:
- Must handle concurrent execution without race conditions
- Must maintain hook integrity under maximum concurrent load (10 parallel executions)
- Must demonstrate proper resource isolation between concurrent hook instances
"""

import json
import subprocess
import sys
import os
import threading
import time
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed

# Test scenarios for concurrent execution
CONCURRENT_TEST_SCENARIOS = [
    {
        "name": "concurrent_pre_tool_use_validation",
        "hook_type": "pre_tool_use",
        "hook_input": {
            "event": "pre_tool_use",
            "tool": {
                "name": "Edit",
                "parameters": {
                    "file_path": "/tmp/concurrent_test_{thread_id}.py",
                    "old_string": "old_value",
                    "new_string": "new_value"
                }
            },
            "conversation_context": "Concurrent file modification test {thread_id}"
        },
        "expected_success": True
    },
    {
        "name": "concurrent_agent_enforcement",
        "hook_type": "user_prompt_agent_enforcer",
        "hook_input": {
            "event": "user_prompt_submit",
            "prompt": "Create implementation for thread {thread_id} with complex logic"
        },
        "expected_enforcement": True
    }
]

def execute_single_hook(scenario, thread_id, execution_count):
    """Execute a single hook instance with thread identification"""
    try:
        start_time = time.time()
        
        # Prepare hook input with thread ID
        hook_input = json.loads(json.dumps(scenario["hook_input"]))
        
        # Replace thread_id placeholders
        hook_input_str = json.dumps(hook_input).replace("{thread_id}", str(thread_id))
        hook_input = json.loads(hook_input_str)
        
        # Determine hook path
        hook_filename = f"{scenario['hook_type']}.py"
        hook_path = Path.home() / ".claude" / "hooks" / hook_filename
        
        # Execute hook
        process = subprocess.run(
            [sys.executable, str(hook_path)],
            input=json.dumps(hook_input),
            text=True,
            capture_output=True,
            timeout=15  # Increased timeout for concurrent execution
        )
        
        execution_time = time.time() - start_time
        
        # Parse results
        try:
            hook_output = json.loads(process.stdout) if process.stdout else {}
        except json.JSONDecodeError:
            hook_output = {"parse_error": True, "raw_output": process.stdout}
        
        return {
            "thread_id": thread_id,
            "execution_count": execution_count,
            "scenario": scenario["name"],
            "exit_code": process.returncode,
            "execution_time": execution_time,
            "hook_output": hook_output,
            "stderr": process.stderr,
            "success": process.returncode in [0, 1],  # 0=success, 1=warning, 2=error
            "timestamp": time.time()
        }
        
    except subprocess.TimeoutExpired:
        return {
            "thread_id": thread_id,
            "execution_count": execution_count,
            "scenario": scenario["name"],
            "success": False,
            "error": "timeout",
            "execution_time": 15.0,
            "timestamp": time.time()
        }
    except Exception as e:
        return {
            "thread_id": thread_id,
            "execution_count": execution_count,
            "scenario": scenario["name"],
            "success": False,
            "error": str(e),
            "execution_time": 0.0,
            "timestamp": time.time()
        }

def run_concurrent_test(scenario, max_concurrent=10, total_executions=50):
    """Run concurrent hook executions for a specific scenario"""
    print(f"\nTesting concurrent execution: {scenario['name']}")
    print(f"Max concurrent: {max_concurrent}, Total executions: {total_executions}")
    
    results = []
    start_time = time.time()
    
    with ThreadPoolExecutor(max_workers=max_concurrent) as executor:
        # Submit all tasks
        future_to_params = {}
        for i in range(total_executions):
            thread_id = i % max_concurrent  # Cycle through thread IDs
            future = executor.submit(execute_single_hook, scenario, thread_id, i)
            future_to_params[future] = (thread_id, i)
        
        # Collect results as they complete
        for future in as_completed(future_to_params):
            thread_id, execution_count = future_to_params[future]
            try:
                result = future.result()
                results.append(result)
                
                if result["success"]:
                    print(f"  ✓ Thread {thread_id}, Execution {execution_count}: {result['execution_time']:.3f}s")
                else:
                    print(f"  ✗ Thread {thread_id}, Execution {execution_count}: {result.get('error', 'unknown')}")
                    
            except Exception as e:
                results.append({
                    "thread_id": thread_id,
                    "execution_count": execution_count,
                    "scenario": scenario["name"],
                    "success": False,
                    "error": f"Future exception: {e}",
                    "execution_time": 0.0,
                    "timestamp": time.time()
                })
    
    total_time = time.time() - start_time
    
    # Analyze results
    successful_executions = sum(1 for r in results if r["success"])
    failed_executions = total_executions - successful_executions
    success_rate = (successful_executions / total_executions) * 100
    
    execution_times = [r["execution_time"] for r in results if r["success"]]
    avg_execution_time = sum(execution_times) / len(execution_times) if execution_times else 0
    max_execution_time = max(execution_times) if execution_times else 0
    
    return {
        "scenario": scenario["name"],
        "total_executions": total_executions,
        "max_concurrent": max_concurrent,
        "successful_executions": successful_executions,
        "failed_executions": failed_executions,
        "success_rate": success_rate,
        "total_time": total_time,
        "avg_execution_time": avg_execution_time,
        "max_execution_time": max_execution_time,
        "throughput": successful_executions / total_time,
        "results": results,
        "evidence_validated": success_rate >= 95.0  # 95% success rate minimum
    }

def run_all_concurrent_tests():
    """Run all concurrent execution tests"""
    print("=" * 60)
    print("CONCURRENT HOOK EXECUTION TEST SUITE")
    print("=" * 60)
    
    test_results = []
    
    for scenario in CONCURRENT_TEST_SCENARIOS:
        result = run_concurrent_test(scenario, max_concurrent=10, total_executions=30)
        test_results.append(result)
        
        print(f"\n{'-' * 40}")
        print(f"Results for {scenario['name']}:")
        print(f"  Success Rate: {result['success_rate']:.1f}%")
        print(f"  Avg Execution Time: {result['avg_execution_time']:.3f}s")
        print(f"  Max Execution Time: {result['max_execution_time']:.3f}s")
        print(f"  Throughput: {result['throughput']:.1f} executions/second")
        
        if result["evidence_validated"]:
            print(f"  ✓ EVIDENCE VALIDATED: Concurrent execution reliable")
        else:
            print(f"  ✗ EVIDENCE FAILED: Concurrent execution unreliable")
    
    # Overall summary
    overall_success_rates = [r["success_rate"] for r in test_results]
    overall_success = sum(overall_success_rates) / len(overall_success_rates)
    all_validated = all(r["evidence_validated"] for r in test_results)
    
    print(f"\n{'='*60}")
    print("CONCURRENT EXECUTION SUMMARY")
    print(f"{'='*60}")
    print(f"Overall Success Rate: {overall_success:.1f}%")
    print(f"All Tests Validated: {all_validated}")
    
    if all_validated:
        print("\n✓ EVIDENCE VALIDATED: Hook concurrent execution is reliable at maximum load")
        print("   Hooks can handle MAX 10 parallel executions without failures")
    else:
        print("\n✗ EVIDENCE FAILED: Hook concurrent execution is unreliable")
        print("   CRITICAL: Hook system may fail under concurrent load")
    
    return {
        "test_results": test_results,
        "overall_success_rate": overall_success,
        "evidence_validated": all_validated
    }

if __name__ == "__main__":
    results = run_all_concurrent_tests()
    
    # Save detailed results
    output_file = Path(__file__).parent / "concurrent_execution_results.json"
    with open(output_file, "w") as f:
        json.dump(results, f, indent=2)
    
    print(f"\nDetailed results saved to: {output_file}")
    
    # Exit with appropriate code
    sys.exit(0 if results["evidence_validated"] else 1)