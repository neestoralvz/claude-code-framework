#!/usr/bin/env python3
"""
Performance Benchmark: Hook Execution Profiler
Measures hook execution performance, memory usage, and efficiency metrics

Required Evidence:
- Must measure execution time for all hooks under various conditions
- Must validate hooks execute within acceptable time limits (<1s for normal operations)
- Must identify performance bottlenecks and optimization opportunities
"""

import json
import subprocess
import sys
import os
import time
import statistics
import psutil
from pathlib import Path

# Performance test scenarios
PERFORMANCE_TEST_SCENARIOS = [
    {
        "name": "lightweight_validation",
        "hook": "pre_tool_use",
        "input": {
            "event": "pre_tool_use",
            "tool": {"name": "Read", "parameters": {"file_path": "/tmp/test.txt"}},
            "conversation_context": "Simple read operation"
        },
        "expected_max_time": 0.5,  # 500ms max for lightweight operations
        "iterations": 100
    },
    {
        "name": "complex_validation",
        "hook": "pre_tool_use", 
        "input": {
            "event": "pre_tool_use",
            "tool": {
                "name": "MultiEdit",
                "parameters": {
                    "file_path": "/tmp/large_file.py",
                    "edits": [{"old_string": f"line_{i}", "new_string": f"new_line_{i}"} for i in range(50)]
                }
            },
            "conversation_context": "Complex multi-edit operation with extensive validation requirements"
        },
        "expected_max_time": 1.0,  # 1s max for complex operations
        "iterations": 50
    },
    {
        "name": "agent_enforcement",
        "hook": "user_prompt_agent_enforcer",
        "input": {
            "event": "user_prompt_submit",
            "prompt": "Create a comprehensive web application with authentication, database integration, API endpoints, real-time features, and advanced security measures"
        },
        "expected_max_time": 0.3,  # 300ms max for prompt processing
        "iterations": 100
    },
    {
        "name": "session_initialization",
        "hook": "session_start",
        "input": {
            "event": "session_start",
            "context": "Starting new development session with full framework initialization"
        },
        "expected_max_time": 2.0,  # 2s max for session start (more complex)
        "iterations": 20
    }
]

def measure_hook_performance(scenario):
    """Measure performance metrics for a single hook scenario"""
    print(f"\nProfiling: {scenario['name']}")
    
    hook_path = Path.home() / ".claude" / "hooks" / f"{scenario['hook']}.py"
    if not hook_path.exists():
        return {
            "scenario": scenario["name"],
            "error": f"Hook file not found: {hook_path}",
            "passed": False
        }
    
    execution_times = []
    memory_usage = []
    cpu_usage = []
    successful_runs = 0
    failed_runs = 0
    
    # Get baseline system stats
    process = psutil.Process()
    baseline_memory = process.memory_info().rss / 1024 / 1024  # MB
    
    print(f"  Running {scenario['iterations']} iterations...")
    
    for i in range(scenario["iterations"]):
        try:
            # Prepare input
            input_json = json.dumps(scenario["input"])
            
            # Measure execution
            start_time = time.perf_counter()
            start_cpu = process.cpu_percent()
            start_memory = process.memory_info().rss / 1024 / 1024
            
            # Execute hook
            result = subprocess.run(
                [sys.executable, str(hook_path)],
                input=input_json,
                text=True,
                capture_output=True,
                timeout=5  # 5s timeout for performance tests
            )
            
            end_time = time.perf_counter()
            end_cpu = process.cpu_percent()
            end_memory = process.memory_info().rss / 1024 / 1024
            
            execution_time = end_time - start_time
            memory_delta = end_memory - start_memory
            cpu_delta = end_cpu - start_cpu
            
            # Record metrics
            execution_times.append(execution_time)
            memory_usage.append(memory_delta)
            cpu_usage.append(cpu_delta)
            
            if result.returncode in [0, 1, 2]:  # Valid exit codes
                successful_runs += 1
            else:
                failed_runs += 1
                
            # Progress indicator
            if (i + 1) % 10 == 0:
                avg_time = statistics.mean(execution_times[-10:])
                print(f"    Progress: {i+1}/{scenario['iterations']}, Avg time: {avg_time:.3f}s")
                
        except subprocess.TimeoutExpired:
            failed_runs += 1
            execution_times.append(5.0)  # Timeout value
        except Exception as e:
            failed_runs += 1
            print(f"    Error in iteration {i}: {e}")
    
    # Calculate performance statistics
    if execution_times:
        avg_time = statistics.mean(execution_times)
        median_time = statistics.median(execution_times)
        min_time = min(execution_times)
        max_time = max(execution_times)
        stddev_time = statistics.stdev(execution_times) if len(execution_times) > 1 else 0
        
        # Percentiles
        sorted_times = sorted(execution_times)
        p95_time = sorted_times[int(0.95 * len(sorted_times))]
        p99_time = sorted_times[int(0.99 * len(sorted_times))]
    else:
        avg_time = median_time = min_time = max_time = stddev_time = p95_time = p99_time = 0
    
    # Performance validation
    performance_passed = (
        max_time <= scenario["expected_max_time"] and
        p95_time <= scenario["expected_max_time"] * 0.8 and  # 95% of runs should be well under limit
        successful_runs >= scenario["iterations"] * 0.95  # 95% success rate minimum
    )
    
    return {
        "scenario": scenario["name"],
        "hook": scenario["hook"],
        "iterations": scenario["iterations"],
        "successful_runs": successful_runs,
        "failed_runs": failed_runs,
        "success_rate": (successful_runs / scenario["iterations"]) * 100,
        "timing": {
            "avg_time": avg_time,
            "median_time": median_time, 
            "min_time": min_time,
            "max_time": max_time,
            "stddev_time": stddev_time,
            "p95_time": p95_time,
            "p99_time": p99_time
        },
        "memory": {
            "avg_usage": statistics.mean(memory_usage) if memory_usage else 0,
            "max_usage": max(memory_usage) if memory_usage else 0
        },
        "cpu": {
            "avg_usage": statistics.mean(cpu_usage) if cpu_usage else 0,
            "max_usage": max(cpu_usage) if cpu_usage else 0
        },
        "performance_target": scenario["expected_max_time"],
        "performance_passed": performance_passed,
        "passed": performance_passed
    }

def run_performance_benchmarks():
    """Run all performance benchmarks"""
    print("=" * 60)
    print("HOOK PERFORMANCE BENCHMARK SUITE")
    print("=" * 60)
    
    benchmark_results = []
    total_scenarios = len(PERFORMANCE_TEST_SCENARIOS)
    passed_scenarios = 0
    
    for scenario in PERFORMANCE_TEST_SCENARIOS:
        result = measure_hook_performance(scenario)
        benchmark_results.append(result)
        
        if result["passed"]:
            passed_scenarios += 1
            status = "✓ PASSED"
        else:
            status = "✗ FAILED"
        
        print(f"\n{'-' * 40}")
        print(f"{status}: {scenario['name']}")
        
        if 'error' not in result:
            print(f"  Success Rate: {result['success_rate']:.1f}%")
            print(f"  Avg Time: {result['timing']['avg_time']:.3f}s")
            print(f"  Max Time: {result['timing']['max_time']:.3f}s")
            print(f"  P95 Time: {result['timing']['p95_time']:.3f}s")
            print(f"  Target: <{result['performance_target']:.1f}s")
            
            if result['timing']['max_time'] > result['performance_target']:
                print(f"  ⚠️  Performance target exceeded!")
        else:
            print(f"  Error: {result['error']}")
    
    # Overall performance summary
    pass_rate = (passed_scenarios / total_scenarios) * 100
    evidence_validated = pass_rate >= 90.0  # 90% of performance tests must pass
    
    print(f"\n{'='*60}")
    print("PERFORMANCE BENCHMARK SUMMARY")
    print(f"{'='*60}")
    print(f"Total Scenarios: {total_scenarios}")
    print(f"Passed: {passed_scenarios}")
    print(f"Failed: {total_scenarios - passed_scenarios}")
    print(f"Pass Rate: {pass_rate:.1f}%")
    
    # Performance insights
    all_avg_times = [r['timing']['avg_time'] for r in benchmark_results if 'timing' in r]
    if all_avg_times:
        overall_avg = statistics.mean(all_avg_times)
        print(f"Overall Avg Execution Time: {overall_avg:.3f}s")
    
    if evidence_validated:
        print("\n✓ EVIDENCE VALIDATED: Hook performance meets requirements")
        print("   All hooks execute within acceptable time limits")
    else:
        print(f"\n✗ EVIDENCE FAILED: Hook performance inadequate ({pass_rate:.1f}% pass rate)")
        print("   CRITICAL: Some hooks exceed performance requirements")
    
    return {
        "total_scenarios": total_scenarios,
        "passed": passed_scenarios,
        "failed": total_scenarios - passed_scenarios,
        "pass_rate": pass_rate,
        "benchmark_results": benchmark_results,
        "evidence_validated": evidence_validated
    }

if __name__ == "__main__":
    results = run_performance_benchmarks()
    
    # Save detailed results
    output_file = Path(__file__).parent / "hook_performance_results.json"
    with open(output_file, "w") as f:
        json.dump(results, f, indent=2)
    
    print(f"\nDetailed results saved to: {output_file}")
    
    # Exit with appropriate code
    sys.exit(0 if results["evidence_validated"] else 1)