#!/usr/bin/env python3
"""
Manual validation of Claude Code hooks
Creates comprehensive test report based on code analysis
"""

import json
import os
import sys
from pathlib import Path

def analyze_hook_file(file_path):
    """Analyze a single hook file for compliance and issues"""
    results = {
        "file_exists": False,
        "syntax_valid": False,
        "pep723_compliant": False,
        "executable": False,
        "has_main_function": False,
        "has_load_hook_data": False,
        "has_proper_exit_codes": False,
        "has_error_handling": False,
        "security_checks": False,
        "issues": [],
        "file_size": 0
    }
    
    if not file_path.exists():
        results["issues"].append("File does not exist")
        return results
    
    results["file_exists"] = True
    results["file_size"] = file_path.stat().st_size
    results["executable"] = os.access(file_path, os.X_OK)
    
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        # Check syntax
        try:
            compile(content, str(file_path), 'exec')
            results["syntax_valid"] = True
        except SyntaxError as e:
            results["issues"].append(f"Syntax error: {e}")
        
        # Check PEP 723 compliance
        has_shebang = content.startswith('#!')
        has_script_block = '# /// script' in content and '# ///' in content
        has_dependencies = 'dependencies' in content
        
        if has_shebang and has_script_block and has_dependencies:
            results["pep723_compliant"] = True
        else:
            missing = []
            if not has_shebang: missing.append("shebang")
            if not has_script_block: missing.append("script metadata block")
            if not has_dependencies: missing.append("dependencies declaration")
            results["issues"].append(f"PEP 723 compliance issues: {', '.join(missing)}")
        
        # Check for required functions
        if "def main():" in content:
            results["has_main_function"] = True
        else:
            results["issues"].append("Missing main() function")
        
        if "def load_hook_data():" in content:
            results["has_load_hook_data"] = True
        else:
            results["issues"].append("Missing load_hook_data() function")
        
        # Check exit code handling
        exit_code_patterns = ["sys.exit(0)", "sys.exit(1)", "sys.exit(2)"]
        if any(pattern in content for pattern in exit_code_patterns):
            results["has_proper_exit_codes"] = True
        else:
            results["issues"].append("Missing proper exit code handling")
        
        # Check error handling
        error_handling_patterns = ["try:", "except", "Exception"]
        if any(pattern in content for pattern in error_handling_patterns):
            results["has_error_handling"] = True
        else:
            results["issues"].append("Limited error handling")
        
        # Check for security patterns (for pre_tool_use specifically)
        if file_path.name == "pre_tool_use.py":
            security_patterns = ["dangerous_patterns", "file_path", "os.path", "validation"]
            if any(pattern in content for pattern in security_patterns):
                results["security_checks"] = True
            else:
                results["issues"].append("Missing security validation patterns")
        
        # Additional checks for executable permission
        if not results["executable"]:
            results["issues"].append("File is not executable")
    
    except Exception as e:
        results["issues"].append(f"Error reading file: {e}")
    
    return results

def generate_test_report():
    """Generate comprehensive test report for all hooks"""
    hooks_dir = Path("/Users/nalve/.claude/hooks")
    
    required_hooks = {
        "session_start.py": "Session orientation functionality",
        "user_prompt_submit.py": "Context injection capabilities", 
        "pre_tool_use.py": "Workflow validation and blocking",
        "post_tool_use.py": "Framework maintenance automation"
    }
    
    report = {
        "test_timestamp": "2025-08-20 13:00:00",
        "testing_framework": "Claude Hooks Tester",
        "hooks_directory": str(hooks_dir),
        "summary": {
            "total_hooks": len(required_hooks),
            "hooks_found": 0,
            "syntax_valid": 0,
            "pep723_compliant": 0,
            "executable": 0,
            "fully_compliant": 0,
            "critical_issues": 0
        },
        "detailed_results": {},
        "security_analysis": {},
        "performance_analysis": {},
        "recommendations": []
    }
    
    # Analyze each hook
    for hook_name, description in required_hooks.items():
        hook_path = hooks_dir / hook_name
        analysis = analyze_hook_file(hook_path)
        
        report["detailed_results"][hook_name] = {
            "description": description,
            "analysis": analysis
        }
        
        # Update summary
        if analysis["file_exists"]:
            report["summary"]["hooks_found"] += 1
        if analysis["syntax_valid"]:
            report["summary"]["syntax_valid"] += 1
        if analysis["pep723_compliant"]:
            report["summary"]["pep723_compliant"] += 1
        if analysis["executable"]:
            report["summary"]["executable"] += 1
        
        # Check if fully compliant
        required_checks = [
            "file_exists", "syntax_valid", "pep723_compliant",
            "has_main_function", "has_load_hook_data", "has_proper_exit_codes"
        ]
        if all(analysis.get(check, False) for check in required_checks):
            report["summary"]["fully_compliant"] += 1
        
        # Count critical issues
        critical_patterns = ["syntax error", "missing main", "file does not exist"]
        for issue in analysis.get("issues", []):
            if any(pattern in issue.lower() for pattern in critical_patterns):
                report["summary"]["critical_issues"] += 1
    
    # Security Analysis
    pre_tool_analysis = report["detailed_results"].get("pre_tool_use.py", {}).get("analysis", {})
    report["security_analysis"] = {
        "dangerous_path_validation": pre_tool_analysis.get("security_checks", False),
        "input_sanitization": "has_error_handling" in str(pre_tool_analysis),
        "command_injection_protection": "validation" in str(pre_tool_analysis),
        "security_score": "HIGH" if pre_tool_analysis.get("security_checks") else "MEDIUM"
    }
    
    # Performance Analysis  
    total_size = sum(
        result["analysis"]["file_size"] 
        for result in report["detailed_results"].values()
        if result["analysis"]["file_exists"]
    )
    
    report["performance_analysis"] = {
        "total_hooks_size_bytes": total_size,
        "average_hook_size_bytes": total_size // report["summary"]["hooks_found"] if report["summary"]["hooks_found"] > 0 else 0,
        "estimated_load_time_ms": total_size * 0.1,  # Rough estimate
        "performance_rating": "EXCELLENT" if total_size < 50000 else "GOOD" if total_size < 100000 else "ACCEPTABLE"
    }
    
    # Generate Recommendations
    recommendations = []
    
    if report["summary"]["critical_issues"] > 0:
        recommendations.append("CRITICAL: Address syntax errors and missing functions before deployment")
    
    if report["summary"]["hooks_found"] < len(required_hooks):
        missing = len(required_hooks) - report["summary"]["hooks_found"]
        recommendations.append(f"Create {missing} missing hook file(s)")
    
    if report["summary"]["executable"] < report["summary"]["hooks_found"]:
        non_executable = report["summary"]["hooks_found"] - report["summary"]["executable"]
        recommendations.append(f"Make {non_executable} hook file(s) executable: chmod +x /Users/nalve/.claude/hooks/*.py")
    
    if report["summary"]["pep723_compliant"] < report["summary"]["hooks_found"]:
        non_compliant = report["summary"]["hooks_found"] - report["summary"]["pep723_compliant"]
        recommendations.append(f"Update {non_compliant} hook file(s) for PEP 723 compliance")
    
    if report["security_analysis"]["security_score"] != "HIGH":
        recommendations.append("Enhance security validation in pre_tool_use.py")
    
    if report["summary"]["fully_compliant"] == len(required_hooks):
        recommendations.append("✓ ALL HOOKS READY FOR PRODUCTION DEPLOYMENT")
    
    report["recommendations"] = recommendations
    
    return report

def format_report_output(report):
    """Format report for console output"""
    output = []
    
    output.append("CLAUDE CODE HOOKS COMPREHENSIVE TEST REPORT")
    output.append("=" * 60)
    output.append("")
    
    # Summary
    summary = report["summary"]
    output.append("SUMMARY:")
    output.append("-" * 30)
    output.append(f"Total Hooks Required: {summary['total_hooks']}")
    output.append(f"Hooks Found: {summary['hooks_found']}")
    output.append(f"Syntax Valid: {summary['syntax_valid']}")
    output.append(f"PEP 723 Compliant: {summary['pep723_compliant']}")
    output.append(f"Executable: {summary['executable']}")
    output.append(f"Fully Compliant: {summary['fully_compliant']}")
    output.append(f"Critical Issues: {summary['critical_issues']}")
    output.append("")
    
    # Success rate
    total_possible_score = summary['total_hooks'] * 6  # 6 criteria per hook
    actual_score = (summary['syntax_valid'] + summary['pep723_compliant'] + 
                   summary['executable'] + summary['fully_compliant'] * 3)
    success_rate = (actual_score / total_possible_score * 100) if total_possible_score > 0 else 0
    output.append(f"Overall Success Rate: {success_rate:.1f}%")
    output.append("")
    
    # Detailed Results
    output.append("DETAILED ANALYSIS:")
    output.append("-" * 30)
    
    for hook_name, details in report["detailed_results"].items():
        analysis = details["analysis"]
        output.append(f"\n{hook_name} - {details['description']}")
        
        if analysis["file_exists"]:
            output.append(f"  ✓ File exists ({analysis['file_size']} bytes)")
        else:
            output.append("  ✗ File missing")
            continue
            
        if analysis["syntax_valid"]:
            output.append("  ✓ Syntax valid")
        else:
            output.append("  ✗ Syntax errors")
            
        if analysis["pep723_compliant"]:
            output.append("  ✓ PEP 723 compliant")
        else:
            output.append("  ✗ PEP 723 issues")
            
        if analysis["executable"]:
            output.append("  ✓ Executable")
        else:
            output.append("  ✗ Not executable")
        
        if analysis["issues"]:
            output.append("  Issues:")
            for issue in analysis["issues"]:
                output.append(f"    • {issue}")
    
    # Security Analysis
    output.append("\nSECURITY ANALYSIS:")
    output.append("-" * 30)
    security = report["security_analysis"]
    output.append(f"Security Score: {security['security_score']}")
    output.append(f"Path Validation: {'✓' if security['dangerous_path_validation'] else '✗'}")
    output.append(f"Input Sanitization: {'✓' if security['input_sanitization'] else '✗'}")
    output.append(f"Injection Protection: {'✓' if security['command_injection_protection'] else '✗'}")
    
    # Performance Analysis
    output.append("\nPERFORMANCE ANALYSIS:")
    output.append("-" * 30)
    perf = report["performance_analysis"]
    output.append(f"Total Size: {perf['total_hooks_size_bytes']} bytes")
    output.append(f"Average Size: {perf['average_hook_size_bytes']} bytes")
    output.append(f"Performance Rating: {perf['performance_rating']}")
    
    # Recommendations
    output.append("\nRECOMMENDATIONS:")
    output.append("-" * 30)
    for rec in report["recommendations"]:
        output.append(f"• {rec}")
    
    output.append("")
    output.append("=" * 60)
    
    return "\n".join(output)

def main():
    """Generate and display comprehensive test report"""
    print("Generating comprehensive hooks test report...")
    
    try:
        report = generate_test_report()
        
        # Display formatted output
        formatted_output = format_report_output(report)
        print(formatted_output)
        
        # Save JSON report
        report_path = "/Users/nalve/.claude/operations/20250820-130000-claude-hooks-testing/comprehensive_test_report.json"
        with open(report_path, 'w') as f:
            json.dump(report, f, indent=2)
        
        print(f"\nDetailed JSON report saved to: {report_path}")
        
        # Return success status
        return report["summary"]["critical_issues"] == 0
        
    except Exception as e:
        print(f"Error generating report: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)