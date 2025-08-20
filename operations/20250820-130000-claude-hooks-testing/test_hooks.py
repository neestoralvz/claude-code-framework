#!/usr/bin/env python3
"""
Claude Code Hooks Testing Framework

Comprehensive testing suite for validating all 4 Claude Code hooks:
- session_start.py - Session orientation functionality  
- user_prompt_submit.py - Context injection capabilities
- pre_tool_use.py - Workflow validation and blocking
- post_tool_use.py - Framework maintenance automation

Tests cover:
- Syntax validation and PEP 723 compliance
- Exit code handling (0/1/2)
- JSON input/output processing
- Security validation and input sanitization
- Framework integration compliance
- Error handling and edge cases
- Performance and timeout validation
"""

import json
import subprocess
import sys
import os
import tempfile
import time
from pathlib import Path
from unittest.mock import patch
import traceback

class HookTester:
    def __init__(self, hooks_dir="/Users/nalve/.claude/hooks"):
        self.hooks_dir = Path(hooks_dir)
        self.test_results = {}
        self.total_tests = 0
        self.passed_tests = 0
        self.failed_tests = 0
        
    def log(self, message, level="INFO"):
        """Log test messages with timestamp"""
        timestamp = time.strftime("%H:%M:%S")
        print(f"[{timestamp}] {level}: {message}")
    
    def run_hook(self, hook_name, input_data, timeout=10):
        """Execute a hook with given input data and return result"""
        hook_path = self.hooks_dir / f"{hook_name}.py"
        
        if not hook_path.exists():
            return {"error": f"Hook file not found: {hook_path}", "exit_code": -1}
        
        try:
            # Prepare input JSON
            input_json = json.dumps(input_data)
            
            # Execute hook with timeout
            process = subprocess.run(
                [sys.executable, str(hook_path)],
                input=input_json,
                capture_output=True,
                text=True,
                timeout=timeout
            )
            
            # Parse output if JSON
            stdout_data = None
            if process.stdout.strip():
                try:
                    stdout_data = json.loads(process.stdout)
                except json.JSONDecodeError:
                    stdout_data = process.stdout.strip()
            
            return {
                "exit_code": process.returncode,
                "stdout": stdout_data,
                "stderr": process.stderr.strip(),
                "execution_time": timeout - 10 if timeout else 0  # Rough estimate
            }
            
        except subprocess.TimeoutExpired:
            return {"error": "Hook execution timeout", "exit_code": -2}
        except Exception as e:
            return {"error": f"Execution error: {e}", "exit_code": -3}
    
    def test_syntax_validation(self):
        """Test syntax validation for all hooks"""
        self.log("Testing syntax validation...")
        
        for hook_file in self.hooks_dir.glob("*.py"):
            test_name = f"syntax_validation_{hook_file.stem}"
            self.total_tests += 1
            
            try:
                # Check syntax by compiling
                with open(hook_file, 'r') as f:
                    code = f.read()
                compile(code, str(hook_file), 'exec')
                
                self.log(f"✓ {hook_file.name} - Syntax valid")
                self.test_results[test_name] = {"status": "PASS", "message": "Syntax valid"}
                self.passed_tests += 1
                
            except SyntaxError as e:
                self.log(f"✗ {hook_file.name} - Syntax error: {e}", "ERROR")
                self.test_results[test_name] = {"status": "FAIL", "message": f"Syntax error: {e}"}
                self.failed_tests += 1
            except Exception as e:
                self.log(f"✗ {hook_file.name} - Error: {e}", "ERROR")
                self.test_results[test_name] = {"status": "FAIL", "message": f"Error: {e}"}
                self.failed_tests += 1
    
    def test_pep723_compliance(self):
        """Test PEP 723 embedded metadata compliance"""
        self.log("Testing PEP 723 compliance...")
        
        for hook_file in self.hooks_dir.glob("*.py"):
            test_name = f"pep723_compliance_{hook_file.stem}"
            self.total_tests += 1
            
            try:
                with open(hook_file, 'r') as f:
                    content = f.read()
                
                # Check for shebang
                has_shebang = content.startswith('#!')
                
                # Check for PEP 723 metadata block
                has_script_block = '# /// script' in content and '# ///' in content
                
                # Check for dependencies field
                has_dependencies = 'dependencies' in content
                
                if has_shebang and has_script_block and has_dependencies:
                    self.log(f"✓ {hook_file.name} - PEP 723 compliant")
                    self.test_results[test_name] = {"status": "PASS", "message": "PEP 723 compliant"}
                    self.passed_tests += 1
                else:
                    missing = []
                    if not has_shebang: missing.append("shebang")
                    if not has_script_block: missing.append("script block")
                    if not has_dependencies: missing.append("dependencies")
                    
                    self.log(f"✗ {hook_file.name} - Missing: {', '.join(missing)}", "ERROR")
                    self.test_results[test_name] = {"status": "FAIL", "message": f"Missing: {', '.join(missing)}"}
                    self.failed_tests += 1
                    
            except Exception as e:
                self.log(f"✗ {hook_file.name} - Error: {e}", "ERROR")
                self.test_results[test_name] = {"status": "FAIL", "message": f"Error: {e}"}
                self.failed_tests += 1
    
    def test_exit_codes(self):
        """Test proper exit code handling for all scenarios"""
        self.log("Testing exit code handling...")
        
        # Test scenarios for each hook
        test_scenarios = {
            "session_start": [
                {"input": {"event": "session_start"}, "expected_codes": [0, 1]},
                {"input": {"event": "wrong_event"}, "expected_codes": [1]},
                {"input": {}, "expected_codes": [1]},
            ],
            "user_prompt_submit": [
                {"input": {"event": "user_prompt_submit", "prompt": "test prompt"}, "expected_codes": [0]},
                {"input": {"event": "user_prompt_submit"}, "expected_codes": [1]},  # Missing prompt
                {"input": {"event": "wrong_event", "prompt": "test"}, "expected_codes": [1]},
            ],
            "pre_tool_use": [
                {"input": {"event": "pre_tool_use", "tool": {"name": "Read", "parameters": {}}}, "expected_codes": [0]},
                {"input": {"event": "pre_tool_use", "tool": {"name": "Edit", "parameters": {"file_path": "/etc/passwd"}}}, "expected_codes": [2]},  # Dangerous file
                {"input": {"event": "pre_tool_use"}, "expected_codes": [1]},  # Missing tool
            ],
            "post_tool_use": [
                {"input": {"event": "post_tool_use", "tool": {"name": "Read", "parameters": {}}, "result": {}}, "expected_codes": [0, 1]},
                {"input": {"event": "post_tool_use"}, "expected_codes": [1]},  # Missing tool
                {"input": {"event": "wrong_event", "tool": {}}, "expected_codes": [1]},
            ]
        }
        
        for hook_name, scenarios in test_scenarios.items():
            for i, scenario in enumerate(scenarios):
                test_name = f"exit_code_{hook_name}_{i}"
                self.total_tests += 1
                
                result = self.run_hook(hook_name, scenario["input"])
                exit_code = result.get("exit_code", -1)
                
                if exit_code in scenario["expected_codes"]:
                    self.log(f"✓ {hook_name} scenario {i} - Exit code {exit_code} as expected")
                    self.test_results[test_name] = {"status": "PASS", "message": f"Exit code {exit_code} as expected"}
                    self.passed_tests += 1
                else:
                    self.log(f"✗ {hook_name} scenario {i} - Exit code {exit_code}, expected {scenario['expected_codes']}", "ERROR")
                    self.test_results[test_name] = {"status": "FAIL", "message": f"Exit code {exit_code}, expected {scenario['expected_codes']}"}
                    self.failed_tests += 1
    
    def test_json_processing(self):
        """Test JSON input parsing and output validation"""
        self.log("Testing JSON processing...")
        
        # Test valid JSON processing
        valid_scenarios = {
            "session_start": {"event": "session_start"},
            "user_prompt_submit": {"event": "user_prompt_submit", "prompt": "test prompt"},
            "pre_tool_use": {"event": "pre_tool_use", "tool": {"name": "Read", "parameters": {}}},
            "post_tool_use": {"event": "post_tool_use", "tool": {"name": "Read", "parameters": {}}, "result": {}}
        }
        
        for hook_name, input_data in valid_scenarios.items():
            test_name = f"json_valid_{hook_name}"
            self.total_tests += 1
            
            result = self.run_hook(hook_name, input_data)
            
            if result.get("exit_code", -1) >= 0 and isinstance(result.get("stdout"), (dict, str)):
                self.log(f"✓ {hook_name} - Valid JSON processing")
                self.test_results[test_name] = {"status": "PASS", "message": "Valid JSON processing"}
                self.passed_tests += 1
            else:
                self.log(f"✗ {hook_name} - JSON processing failed", "ERROR") 
                self.test_results[test_name] = {"status": "FAIL", "message": "JSON processing failed"}
                self.failed_tests += 1
        
        # Test invalid JSON handling
        for hook_name in valid_scenarios.keys():
            test_name = f"json_invalid_{hook_name}"
            self.total_tests += 1
            
            # Use subprocess to send invalid JSON directly
            hook_path = self.hooks_dir / f"{hook_name}.py"
            try:
                process = subprocess.run(
                    [sys.executable, str(hook_path)],
                    input="invalid json{",
                    capture_output=True,
                    text=True,
                    timeout=5
                )
                
                if process.returncode == 1:  # Should handle invalid JSON gracefully
                    self.log(f"✓ {hook_name} - Invalid JSON handled gracefully")
                    self.test_results[test_name] = {"status": "PASS", "message": "Invalid JSON handled gracefully"}
                    self.passed_tests += 1
                else:
                    self.log(f"✗ {hook_name} - Invalid JSON not handled properly", "ERROR")
                    self.test_results[test_name] = {"status": "FAIL", "message": "Invalid JSON not handled properly"}
                    self.failed_tests += 1
                    
            except Exception as e:
                self.log(f"✗ {hook_name} - Error testing invalid JSON: {e}", "ERROR")
                self.test_results[test_name] = {"status": "FAIL", "message": f"Error testing invalid JSON: {e}"}
                self.failed_tests += 1
    
    def test_security_validation(self):
        """Test security validation and input sanitization"""
        self.log("Testing security validation...")
        
        # Test path traversal attempts
        dangerous_paths = [
            "/etc/passwd",
            "../../../etc/passwd", 
            "/usr/bin/sudo",
            "/System/Library/",
            "C:\\Windows\\System32\\",
        ]
        
        for dangerous_path in dangerous_paths:
            test_name = f"security_path_{dangerous_path.replace('/', '_').replace('\\', '_').replace(':', '_')}"
            self.total_tests += 1
            
            input_data = {
                "event": "pre_tool_use",
                "tool": {
                    "name": "Edit",
                    "parameters": {"file_path": dangerous_path, "old_string": "test", "new_string": "test2"}
                }
            }
            
            result = self.run_hook("pre_tool_use", input_data)
            exit_code = result.get("exit_code", -1)
            
            if exit_code == 2:  # Should block dangerous operations
                self.log(f"✓ Security - Blocked dangerous path: {dangerous_path}")
                self.test_results[test_name] = {"status": "PASS", "message": f"Blocked dangerous path: {dangerous_path}"}
                self.passed_tests += 1
            else:
                self.log(f"✗ Security - Failed to block dangerous path: {dangerous_path}", "ERROR")
                self.test_results[test_name] = {"status": "FAIL", "message": f"Failed to block dangerous path: {dangerous_path}"}
                self.failed_tests += 1
        
        # Test command injection attempts
        malicious_content = [
            "import os; os.system('rm -rf /')",
            "subprocess.run(['rm', '-rf', '/'])",
            "eval('__import__(\"os\").system(\"ls\")')",
            "exec('import subprocess; subprocess.call([\"id\"])')"
        ]
        
        for content in malicious_content:
            test_name = f"security_injection_{hash(content) % 1000}"
            self.total_tests += 1
            
            input_data = {
                "event": "pre_tool_use", 
                "tool": {
                    "name": "Write",
                    "parameters": {"file_path": "/tmp/test.py", "content": content}
                }
            }
            
            result = self.run_hook("pre_tool_use", input_data)
            stdout = result.get("stdout", {})
            
            # Check if warnings were generated for dangerous patterns
            warnings = stdout.get("warnings", []) if isinstance(stdout, dict) else []
            has_security_warning = any("dangerous" in str(w).lower() for w in warnings)
            
            if has_security_warning:
                self.log(f"✓ Security - Detected dangerous pattern in content")
                self.test_results[test_name] = {"status": "PASS", "message": "Detected dangerous pattern"}
                self.passed_tests += 1
            else:
                self.log(f"✗ Security - Failed to detect dangerous pattern", "ERROR")
                self.test_results[test_name] = {"status": "FAIL", "message": "Failed to detect dangerous pattern"}
                self.failed_tests += 1
    
    def test_framework_integration(self):
        """Test Simple and Easy Framework compliance"""
        self.log("Testing framework integration...")
        
        # Test TodoWrite detection
        test_name = "framework_todowrite_detection"
        self.total_tests += 1
        
        complex_prompt = "I need to create a new feature, implement multiple components, design the architecture, and integrate everything together"
        input_data = {"event": "user_prompt_submit", "prompt": complex_prompt}
        
        result = self.run_hook("user_prompt_submit", input_data)
        stdout = result.get("stdout", {})
        
        if isinstance(stdout, dict) and "prompt" in stdout:
            enhanced_prompt = stdout["prompt"]
            if "TodoWrite" in enhanced_prompt:
                self.log("✓ Framework - TodoWrite detection working")
                self.test_results[test_name] = {"status": "PASS", "message": "TodoWrite detection working"}
                self.passed_tests += 1
            else:
                self.log("✗ Framework - TodoWrite not detected for complex task", "ERROR")
                self.test_results[test_name] = {"status": "FAIL", "message": "TodoWrite not detected"}
                self.failed_tests += 1
        else:
            self.log("✗ Framework - Invalid output format", "ERROR")
            self.test_results[test_name] = {"status": "FAIL", "message": "Invalid output format"}
            self.failed_tests += 1
        
        # Test emoji warning
        test_name = "framework_emoji_warning"
        self.total_tests += 1
        
        input_data = {
            "event": "pre_tool_use",
            "tool": {
                "name": "Write",
                "parameters": {"file_path": "/tmp/test.txt", "content": "Hello 🌟 World 🚀"}
            }
        }
        
        result = self.run_hook("pre_tool_use", input_data)
        stdout = result.get("stdout", {})
        
        warnings = stdout.get("warnings", []) if isinstance(stdout, dict) else []
        has_emoji_warning = any("emoji" in str(w).lower() for w in warnings)
        
        if has_emoji_warning:
            self.log("✓ Framework - Emoji warning working")
            self.test_results[test_name] = {"status": "PASS", "message": "Emoji warning working"}
            self.passed_tests += 1
        else:
            self.log("✗ Framework - Emoji warning not triggered", "ERROR")
            self.test_results[test_name] = {"status": "FAIL", "message": "Emoji warning not triggered"}
            self.failed_tests += 1
    
    def test_error_handling(self):
        """Test error handling and edge cases"""
        self.log("Testing error handling...")
        
        # Test missing required fields
        error_scenarios = [
            ("session_start", {}),  # Missing event
            ("user_prompt_submit", {"event": "user_prompt_submit"}),  # Missing prompt
            ("pre_tool_use", {"event": "pre_tool_use"}),  # Missing tool
            ("post_tool_use", {"event": "post_tool_use"}),  # Missing tool
        ]
        
        for hook_name, input_data in error_scenarios:
            test_name = f"error_handling_{hook_name}"
            self.total_tests += 1
            
            result = self.run_hook(hook_name, input_data)
            exit_code = result.get("exit_code", -1)
            
            if exit_code == 1:  # Should handle errors gracefully
                self.log(f"✓ {hook_name} - Error handled gracefully")
                self.test_results[test_name] = {"status": "PASS", "message": "Error handled gracefully"}
                self.passed_tests += 1
            else:
                self.log(f"✗ {hook_name} - Error not handled properly", "ERROR")
                self.test_results[test_name] = {"status": "FAIL", "message": "Error not handled properly"}
                self.failed_tests += 1
    
    def test_performance(self):
        """Test performance and timeout validation"""
        self.log("Testing performance...")
        
        # Test execution time limits
        for hook_name in ["session_start", "user_prompt_submit", "pre_tool_use", "post_tool_use"]:
            test_name = f"performance_{hook_name}"
            self.total_tests += 1
            
            # Prepare valid input
            input_data = {"event": hook_name}
            if hook_name == "user_prompt_submit":
                input_data["prompt"] = "test prompt"
            elif hook_name in ["pre_tool_use", "post_tool_use"]:
                input_data["tool"] = {"name": "Read", "parameters": {}}
                if hook_name == "post_tool_use":
                    input_data["result"] = {}
            
            start_time = time.time()
            result = self.run_hook(hook_name, input_data, timeout=10)
            execution_time = time.time() - start_time
            
            if execution_time < 5.0 and result.get("exit_code", -1) >= 0:  # Should complete within 5 seconds
                self.log(f"✓ {hook_name} - Performance acceptable ({execution_time:.2f}s)")
                self.test_results[test_name] = {"status": "PASS", "message": f"Performance acceptable ({execution_time:.2f}s)"}
                self.passed_tests += 1
            else:
                self.log(f"✗ {hook_name} - Performance issue ({execution_time:.2f}s)", "ERROR")
                self.test_results[test_name] = {"status": "FAIL", "message": f"Performance issue ({execution_time:.2f}s)"}
                self.failed_tests += 1
    
    def run_all_tests(self):
        """Run all test suites"""
        self.log("Starting comprehensive hook testing...")
        
        try:
            self.test_syntax_validation()
            self.test_pep723_compliance()
            self.test_exit_codes()
            self.test_json_processing()
            self.test_security_validation()
            self.test_framework_integration()
            self.test_error_handling()
            self.test_performance()
            
        except Exception as e:
            self.log(f"Test suite error: {e}", "ERROR")
            self.log(traceback.format_exc(), "ERROR")
    
    def generate_report(self):
        """Generate comprehensive test report"""
        report = {
            "summary": {
                "total_tests": self.total_tests,
                "passed": self.passed_tests,
                "failed": self.failed_tests,
                "success_rate": f"{(self.passed_tests/self.total_tests*100):.1f}%" if self.total_tests > 0 else "0%"
            },
            "detailed_results": self.test_results,
            "recommendations": []
        }
        
        # Generate recommendations based on failures
        failed_tests = {k: v for k, v in self.test_results.items() if v["status"] == "FAIL"}
        
        if any("syntax" in test for test in failed_tests):
            report["recommendations"].append("Fix syntax errors in hook files before deployment")
        
        if any("pep723" in test for test in failed_tests):
            report["recommendations"].append("Update hook files to comply with PEP 723 metadata format")
        
        if any("security" in test for test in failed_tests):
            report["recommendations"].append("Critical: Address security validation failures immediately")
        
        if any("performance" in test for test in failed_tests):
            report["recommendations"].append("Optimize hook performance to meet timeout requirements")
        
        if self.failed_tests == 0:
            report["recommendations"].append("All tests passed! Hooks are ready for production deployment")
        
        return report

if __name__ == "__main__":
    tester = HookTester()
    tester.run_all_tests()
    
    report = tester.generate_report()
    
    print("\n" + "="*80)
    print("CLAUDE CODE HOOKS TEST REPORT")
    print("="*80)
    print(f"Total Tests: {report['summary']['total_tests']}")
    print(f"Passed: {report['summary']['passed']}")
    print(f"Failed: {report['summary']['failed']}")
    print(f"Success Rate: {report['summary']['success_rate']}")
    print("\nRecommendations:")
    for rec in report["recommendations"]:
        print(f"• {rec}")
    
    # Save detailed report
    report_file = "/Users/nalve/.claude/operations/20250820-130000-claude-hooks-testing/test_report.json"
    with open(report_file, 'w') as f:
        json.dump(report, f, indent=2)
    
    print(f"\nDetailed report saved to: {report_file}")
    
    # Exit with appropriate code
    sys.exit(0 if report["summary"]["failed"] == 0 else 1)