#!/usr/bin/env python3
"""
Test Environment Validator
Validates that all testing components are properly configured before execution
"""

import sys
import os
from pathlib import Path
import json

def validate_test_environment():
    """Validate testing environment setup"""
    print("VALIDATING CLAUDE HOOKS TESTING ENVIRONMENT")
    print("=" * 50)
    
    validation_results = {
        "hook_files_exist": False,
        "test_scripts_created": False,
        "test_structure_valid": False,
        "dependencies_available": False,
        "permissions_correct": False
    }
    
    # Check hook files exist
    hooks_dir = Path.home() / ".claude" / "hooks"
    critical_hooks = ["pre_tool_use.py", "user_prompt_agent_enforcer.py", "post_tool_use.py"]
    
    hooks_found = []
    for hook_name in critical_hooks:
        hook_path = hooks_dir / hook_name
        if hook_path.exists():
            hooks_found.append(hook_name)
    
    validation_results["hook_files_exist"] = len(hooks_found) >= 2  # At least 2 critical hooks
    print(f"Hook Files Found: {len(hooks_found)}/{len(critical_hooks)} ({'✓' if validation_results['hook_files_exist'] else '✗'})")
    for hook in hooks_found:
        print(f"  ✓ {hook}")
    
    # Check test scripts
    test_dir = Path(__file__).parent
    test_categories = [
        "error-detection-tests",
        "framework-compliance-tests", 
        "edge-case-tests",
        "performance-benchmarks",
        "system-integration-tests"
    ]
    
    categories_found = 0
    total_test_scripts = 0
    
    for category in test_categories:
        category_dir = test_dir / category
        if category_dir.exists():
            categories_found += 1
            test_scripts = list(category_dir.glob("*.py"))
            total_test_scripts += len(test_scripts)
            print(f"  ✓ {category}: {len(test_scripts)} test scripts")
        else:
            print(f"  ✗ {category}: missing")
    
    validation_results["test_scripts_created"] = categories_found == len(test_categories)
    validation_results["test_structure_valid"] = total_test_scripts >= 8  # Minimum test coverage
    
    print(f"Test Categories: {categories_found}/{len(test_categories)} ({'✓' if validation_results['test_scripts_created'] else '✗'})")
    print(f"Total Test Scripts: {total_test_scripts} ({'✓' if validation_results['test_structure_valid'] else '✗'})")
    
    # Check Python dependencies
    required_modules = ["json", "subprocess", "pathlib", "statistics", "threading", "concurrent.futures"]
    missing_modules = []
    
    for module in required_modules:
        try:
            __import__(module)
        except ImportError:
            missing_modules.append(module)
    
    validation_results["dependencies_available"] = len(missing_modules) == 0
    print(f"Python Dependencies: {'✓' if validation_results['dependencies_available'] else '✗'}")
    if missing_modules:
        print(f"  Missing: {', '.join(missing_modules)}")
    
    # Check file permissions
    test_runner = test_dir / "comprehensive_test_runner.py"
    permissions_ok = test_runner.exists() and os.access(test_runner, os.R_OK)
    validation_results["permissions_correct"] = permissions_ok
    print(f"File Permissions: {'✓' if permissions_ok else '✗'}")
    
    # Overall validation
    all_valid = all(validation_results.values())
    
    print("\n" + "=" * 50)
    print("ENVIRONMENT VALIDATION SUMMARY")
    print("=" * 50)
    
    for check, result in validation_results.items():
        print(f"{check.replace('_', ' ').title()}: {'✓ PASS' if result else '✗ FAIL'}")
    
    if all_valid:
        print("\n✅ ENVIRONMENT READY: All validation checks passed")
        print("   Testing suite is ready for execution")
    else:
        print("\n❌ ENVIRONMENT NOT READY: Some validation checks failed")
        print("   Please resolve issues before running tests")
    
    return all_valid

if __name__ == "__main__":
    is_valid = validate_test_environment()
    sys.exit(0 if is_valid else 1)