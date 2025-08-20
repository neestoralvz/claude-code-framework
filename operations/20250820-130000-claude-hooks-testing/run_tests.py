#!/usr/bin/env python3
"""
Direct test runner for Claude Code hooks
Executes all tests and generates comprehensive report
"""

import sys
import os
sys.path.append(os.path.dirname(__file__))

from test_hooks import HookTester
import json

def main():
    print("Claude Code Hooks Testing Framework")
    print("=" * 50)
    
    tester = HookTester()
    
    try:
        tester.run_all_tests()
        report = tester.generate_report()
        
        print("\nTEST SUMMARY")
        print("-" * 30)
        print(f"Total Tests: {report['summary']['total_tests']}")
        print(f"Passed: {report['summary']['passed']}")
        print(f"Failed: {report['summary']['failed']}")
        print(f"Success Rate: {report['summary']['success_rate']}")
        
        print("\nFAILED TESTS:")
        print("-" * 30)
        failed_count = 0
        for test_name, result in report['detailed_results'].items():
            if result['status'] == 'FAIL':
                print(f"✗ {test_name}: {result['message']}")
                failed_count += 1
        
        if failed_count == 0:
            print("No failed tests!")
        
        print("\nRECOMMENDATIONS:")
        print("-" * 30)
        for rec in report['recommendations']:
            print(f"• {rec}")
        
        # Save detailed report
        report_path = "/Users/nalve/.claude/operations/20250820-130000-claude-hooks-testing/test_report.json"
        with open(report_path, 'w') as f:
            json.dump(report, f, indent=2)
        
        print(f"\nDetailed report saved to: {report_path}")
        
        return report['summary']['failed'] == 0
        
    except Exception as e:
        print(f"Test execution error: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)