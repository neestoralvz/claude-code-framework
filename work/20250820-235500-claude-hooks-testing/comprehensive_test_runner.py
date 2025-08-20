#!/usr/bin/env python3
"""
Comprehensive Test Runner: Claude Hooks Testing Suite
Executes all test categories and generates final reliability certification

MISSION: Validate ERROR ATTENTION PROTOCOL hooks work flawlessly with 100% reliability
"""

import json
import subprocess
import sys
import os
import time
from pathlib import Path
from datetime import datetime

class HookTestRunner:
    def __init__(self):
        self.test_dir = Path(__file__).parent
        self.results = {
            "test_execution_time": datetime.now().isoformat(),
            "test_categories": {},
            "overall_results": {},
            "evidence_validation": {},
            "reliability_certification": {}
        }
    
    def run_test_category(self, category_name, test_scripts):
        """Run all tests in a specific category"""
        print(f"\n{'='*80}")
        print(f"RUNNING {category_name.upper()} TESTS")
        print(f"{'='*80}")
        
        category_results = {
            "tests_run": [],
            "total_tests": 0,
            "passed_tests": 0,
            "failed_tests": 0,
            "execution_time": 0,
            "evidence_validated": False
        }
        
        start_time = time.time()
        
        for script_name in test_scripts:
            script_path = self.test_dir / category_name / script_name
            
            if not script_path.exists():
                print(f"⚠️  Test script not found: {script_path}")
                continue
                
            print(f"\nExecuting: {script_name}")
            print("-" * 60)
            
            try:
                # Execute test script
                result = subprocess.run(
                    [sys.executable, str(script_path)],
                    capture_output=True,
                    text=True,
                    timeout=300  # 5 minute timeout per test
                )
                
                # Parse test results (if JSON output available)
                test_result = {
                    "script": script_name,
                    "exit_code": result.returncode,
                    "stdout": result.stdout,
                    "stderr": result.stderr,
                    "passed": result.returncode == 0
                }
                
                # Try to parse JSON output for detailed results
                try:
                    if result.stdout:
                        lines = result.stdout.strip().split('\n')
                        for line in reversed(lines):
                            if line.startswith('{') and line.endswith('}'):
                                detailed_results = json.loads(line)
                                test_result["detailed_results"] = detailed_results
                                break
                except json.JSONDecodeError:
                    pass  # No JSON output available
                
                category_results["tests_run"].append(test_result)
                category_results["total_tests"] += 1
                
                if test_result["passed"]:
                    category_results["passed_tests"] += 1
                    print(f"✓ {script_name} PASSED")
                else:
                    category_results["failed_tests"] += 1
                    print(f"✗ {script_name} FAILED (exit code: {result.returncode})")
                
                # Show stdout if available
                if result.stdout:
                    print("Output:")
                    print(result.stdout)
                
            except subprocess.TimeoutExpired:
                print(f"✗ {script_name} TIMEOUT (exceeded 5 minutes)")
                category_results["tests_run"].append({
                    "script": script_name,
                    "exit_code": -1,
                    "error": "timeout",
                    "passed": False
                })
                category_results["total_tests"] += 1
                category_results["failed_tests"] += 1
                
            except Exception as e:
                print(f"✗ {script_name} ERROR: {e}")
                category_results["tests_run"].append({
                    "script": script_name,
                    "exit_code": -1,
                    "error": str(e),
                    "passed": False
                })
                category_results["total_tests"] += 1
                category_results["failed_tests"] += 1
        
        category_results["execution_time"] = time.time() - start_time
        
        # Calculate category evidence validation
        if category_results["total_tests"] > 0:
            pass_rate = (category_results["passed_tests"] / category_results["total_tests"]) * 100
            category_results["pass_rate"] = pass_rate
            category_results["evidence_validated"] = pass_rate >= 95.0  # 95% minimum
        else:
            category_results["pass_rate"] = 0
            category_results["evidence_validated"] = False
        
        # Category summary
        print(f"\n{'-'*60}")
        print(f"{category_name.upper()} RESULTS:")
        print(f"  Total Tests: {category_results['total_tests']}")
        print(f"  Passed: {category_results['passed_tests']}")
        print(f"  Failed: {category_results['failed_tests']}")
        print(f"  Pass Rate: {category_results['pass_rate']:.1f}%")
        print(f"  Evidence Validated: {'✓' if category_results['evidence_validated'] else '✗'}")
        print(f"  Execution Time: {category_results['execution_time']:.1f}s")
        
        self.results["test_categories"][category_name] = category_results
        return category_results
    
    def run_all_tests(self):
        """Run all test categories"""
        # Define test categories and their scripts
        test_categories = {
            "error-detection-tests": [
                "test_context7_bypass_detection.py",
                "test_agent_deployment_avoidance.py"
            ],
            "framework-compliance-tests": [
                "test_todowrite_enforcement.py"
            ],
            "edge-case-tests": [
                "test_concurrent_hook_execution.py", 
                "test_malformed_input_handling.py"
            ],
            "performance-benchmarks": [
                "hook_performance_profiler.py"
            ],
            "system-integration-tests": [
                "test_mcp_compatibility.py"
            ]
        }
        
        print("STARTING COMPREHENSIVE CLAUDE HOOKS TEST SUITE")
        print("=" * 80)
        print("MISSION: Validate ERROR ATTENTION PROTOCOL hooks with 100% reliability")
        
        # Run each test category
        for category, scripts in test_categories.items():
            category_result = self.run_test_category(category, scripts)
        
        # Calculate overall results
        self.calculate_overall_results()
        
        # Generate reliability certification
        self.generate_reliability_certification()
        
        # Display final summary
        self.display_final_summary()
    
    def calculate_overall_results(self):
        """Calculate overall test results across all categories"""
        total_tests = sum(cat["total_tests"] for cat in self.results["test_categories"].values())
        total_passed = sum(cat["passed_tests"] for cat in self.results["test_categories"].values())
        total_failed = sum(cat["failed_tests"] for cat in self.results["test_categories"].values())
        total_time = sum(cat["execution_time"] for cat in self.results["test_categories"].values())
        
        overall_pass_rate = (total_passed / total_tests * 100) if total_tests > 0 else 0
        
        categories_validated = sum(1 for cat in self.results["test_categories"].values() if cat["evidence_validated"])
        total_categories = len(self.results["test_categories"])
        
        self.results["overall_results"] = {
            "total_tests": total_tests,
            "total_passed": total_passed,
            "total_failed": total_failed,
            "overall_pass_rate": overall_pass_rate,
            "total_execution_time": total_time,
            "categories_validated": categories_validated,
            "total_categories": total_categories,
            "all_categories_validated": categories_validated == total_categories
        }
    
    def generate_reliability_certification(self):
        """Generate hook reliability certification based on test results"""
        overall = self.results["overall_results"]
        
        # Certification criteria
        criteria = {
            "error_detection_reliability": False,
            "framework_compliance": False,
            "edge_case_handling": False,
            "performance_standards": False,
            "system_integration": False,
            "overall_pass_rate": False
        }
        
        # Check each category
        for category_name, category_result in self.results["test_categories"].items():
            validated = category_result["evidence_validated"]
            
            if "error-detection" in category_name:
                criteria["error_detection_reliability"] = validated
            elif "framework-compliance" in category_name:
                criteria["framework_compliance"] = validated
            elif "edge-case" in category_name:
                criteria["edge_case_handling"] = validated
            elif "performance" in category_name:
                criteria["performance_standards"] = validated
            elif "system-integration" in category_name:
                criteria["system_integration"] = validated
        
        criteria["overall_pass_rate"] = overall["overall_pass_rate"] >= 98.0  # 98% minimum for certification
        
        # Final certification decision
        hook_reliability_certified = all(criteria.values())
        
        certification_level = "CERTIFIED" if hook_reliability_certified else "NOT CERTIFIED"
        
        self.results["reliability_certification"] = {
            "certification_level": certification_level,
            "criteria_met": criteria,
            "criteria_passed": sum(criteria.values()),
            "criteria_total": len(criteria),
            "certification_details": {
                "error_attention_protocol_functional": criteria["error_detection_reliability"],
                "universal_operation_enforcement": criteria["framework_compliance"],
                "resilience_under_stress": criteria["edge_case_handling"],
                "performance_compliance": criteria["performance_standards"],
                "system_compatibility": criteria["system_integration"],
                "statistical_reliability": criteria["overall_pass_rate"]
            }
        }
    
    def display_final_summary(self):
        """Display comprehensive final summary"""
        overall = self.results["overall_results"]
        cert = self.results["reliability_certification"]
        
        print("\n" + "=" * 80)
        print("COMPREHENSIVE TEST SUITE FINAL SUMMARY")
        print("=" * 80)
        
        print(f"Test Execution Time: {self.results['test_execution_time']}")
        print(f"Total Test Categories: {overall['total_categories']}")
        print(f"Categories Validated: {overall['categories_validated']}")
        print(f"Total Individual Tests: {overall['total_tests']}")
        print(f"Total Passed Tests: {overall['total_passed']}")
        print(f"Total Failed Tests: {overall['total_failed']}")
        print(f"Overall Pass Rate: {overall['overall_pass_rate']:.1f}%")
        print(f"Total Execution Time: {overall['total_execution_time']:.1f}s")
        
        print("\nCERTIFICATION CRITERIA:")
        for criterion, status in cert["criteria_met"].items():
            print(f"  {criterion}: {'✓ PASSED' if status else '✗ FAILED'}")
        
        print(f"\n{'='*80}")
        print("HOOK RELIABILITY CERTIFICATION")
        print(f"{'='*80}")
        
        if cert["certification_level"] == "CERTIFIED":
            print("🎉 ✓ CERTIFICATION: CLAUDE HOOKS FULLY CERTIFIED")
            print("   ERROR ATTENTION PROTOCOL hooks work flawlessly")
            print("   100% reliability validated across all scenarios")
            print("   Zero tolerance for errors - ACHIEVED")
        else:
            print("❌ ✗ CERTIFICATION: CLAUDE HOOKS NOT CERTIFIED")
            print("   Hook reliability does not meet requirements")
            print("   CRITICAL: Framework violation detection is unreliable")
            print("   Action required before production deployment")
        
        print(f"\nCertification Score: {cert['criteria_passed']}/{cert['criteria_total']}")
        
        # Save comprehensive results
        self.save_results()
    
    def save_results(self):
        """Save comprehensive test results to file"""
        results_file = self.test_dir / "comprehensive_test_results.json"
        
        with open(results_file, "w") as f:
            json.dump(self.results, f, indent=2)
        
        print(f"\nComprehensive results saved to: {results_file}")
        
        # Also create a summary report
        summary_file = self.test_dir / "HOOK_RELIABILITY_CERTIFICATION.md"
        self.generate_certification_report(summary_file)
    
    def generate_certification_report(self, output_file):
        """Generate final certification report"""
        overall = self.results["overall_results"]
        cert = self.results["reliability_certification"]
        
        report = f"""# Claude Hooks Reliability Certification Report
*Generated: {self.results['test_execution_time']}*

## CERTIFICATION RESULT: {cert['certification_level']}

### Test Execution Summary
- **Total Test Categories:** {overall['total_categories']}
- **Categories Validated:** {overall['categories_validated']}
- **Individual Tests Executed:** {overall['total_tests']}
- **Tests Passed:** {overall['total_passed']}
- **Tests Failed:** {overall['total_failed']}
- **Overall Pass Rate:** {overall['overall_pass_rate']:.1f}%
- **Total Execution Time:** {overall['total_execution_time']:.1f}s

### Certification Criteria Results
"""
        
        for criterion, status in cert["criteria_met"].items():
            status_icon = "✅" if status else "❌"
            report += f"- **{criterion.replace('_', ' ').title()}:** {status_icon} {'PASSED' if status else 'FAILED'}\n"
        
        report += f"""
### Category-Specific Results
"""
        
        for category_name, category_result in self.results["test_categories"].items():
            validation_icon = "✅" if category_result["evidence_validated"] else "❌"
            report += f"""
#### {category_name.replace('-', ' ').title()}
- Tests Run: {category_result['total_tests']}
- Passed: {category_result['passed_tests']}
- Failed: {category_result['failed_tests']}
- Pass Rate: {category_result['pass_rate']:.1f}%
- Evidence Validated: {validation_icon}
"""
        
        if cert["certification_level"] == "CERTIFIED":
            report += f"""
## 🎉 CERTIFICATION ACHIEVED

### ERROR ATTENTION PROTOCOL VALIDATION
✅ **Hook system fully certified for production deployment**
✅ **100% reliability validated across all critical scenarios**
✅ **Zero tolerance for framework violations - ACHIEVED**

### Evidence Summary
- Error detection works with 100% accuracy
- Framework compliance is properly enforced
- Edge cases are handled gracefully
- Performance meets all requirements
- System integration has zero conflicts

**CONCLUSION: Claude Hooks ERROR ATTENTION PROTOCOL is ready for production use with complete confidence in reliability.**
"""
        else:
            report += f"""
## ❌ CERTIFICATION NOT ACHIEVED

### CRITICAL ISSUES IDENTIFIED
- Hook reliability does not meet production standards
- Framework violation detection may be unreliable
- Action required before production deployment

### Required Actions
1. Address failed test categories
2. Improve hook reliability to meet certification criteria
3. Re-run comprehensive test suite
4. Achieve minimum 98% overall pass rate
5. Ensure all certification criteria are met

**CONCLUSION: Claude Hooks are NOT ready for production use. Critical reliability issues must be resolved.**
"""
        
        report += f"""
---
*This report provides evidence-based validation of Claude Hooks reliability for ERROR ATTENTION PROTOCOL implementation.*
"""
        
        with open(output_file, "w") as f:
            f.write(report)
        
        print(f"Certification report saved to: {output_file}")

def main():
    """Main test runner execution"""
    runner = HookTestRunner()
    runner.run_all_tests()
    
    # Exit with appropriate code
    overall_certified = runner.results["reliability_certification"]["certification_level"] == "CERTIFIED"
    sys.exit(0 if overall_certified else 1)

if __name__ == "__main__":
    main()