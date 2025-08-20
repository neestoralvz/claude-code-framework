#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "json", "sys", "os", "subprocess", "re"]
# ///

"""
Claude Code Hook: ERROR ATTENTION PROTOCOL - PostToolUse

MISSION CRITICAL: Zero Error Tolerance Enforcement - Post-Execution Validation

This hook implements the ERROR ATTENTION PROTOCOL for post-tool validation:
- NEVER normalize errors → Every error triggers immediate attention and resolution
- IMMEDIATE AGENT DEPLOYMENT → Deploy error-resolution agents on any failure
- ZERO ERROR TOLERANCE → No error is acceptable or normal
- EVIDENCE VALIDATION → Verify all claims and implementations work correctly

Exit Codes:
- 0: Success, tool execution validated and compliant
- 1: Non-blocking warning, validation concerns identified
- 2: BLOCKING ERROR, tool execution failed validation - IMMEDIATE ATTENTION REQUIRED
"""

import json
import sys
import os
import subprocess
import re
from pathlib import Path
from datetime import datetime


def load_hook_data():
    """Load and validate post-tool execution data"""
    try:
        if sys.stdin.isatty():
            return create_default_data("no_stdin")
        
        stdin_content = sys.stdin.read().strip()
        if not stdin_content:
            return create_default_data("empty_stdin")
        
        data = json.loads(stdin_content)
        return validate_and_enhance_data(data)
        
    except json.JSONDecodeError as e:
        return create_error_data("json_decode_error", str(e))
    except Exception as e:
        return create_error_data("general_error", str(e))


def create_default_data(reason):
    """Create default post-tool data structure"""
    return {
        'event': 'post_tool_use',
        'source': 'claude_code',
        'tool': {'name': 'unknown', 'parameters': {}},
        'result': {'success': False, 'output': ''},
        'timestamp': datetime.now().isoformat(),
        'input_source': reason,
        'error_attention_active': True
    }


def create_error_data(error_type, error_msg):
    """Create error data requiring immediate attention"""
    return {
        'event': 'post_tool_use',
        'source': 'claude_code',
        'tool': {'name': 'unknown', 'parameters': {}},
        'result': {'success': False, 'output': '', 'error': error_msg},
        'timestamp': datetime.now().isoformat(),
        'input_error': error_msg,
        'error_type': error_type,
        'input_source': 'error_fallback',
        'error_attention_required': True,
        'immediate_agent_deployment_needed': True
    }


def validate_and_enhance_data(data):
    """Validate and enhance post-tool data"""
    required_fields = ['event', 'source', 'tool', 'result', 'timestamp']
    
    for field in required_fields:
        if field not in data:
            if field == 'tool':
                data[field] = {'name': 'unknown', 'parameters': {}}
            elif field == 'result':
                data[field] = {'success': False, 'output': ''}
            elif field == 'timestamp':
                data[field] = datetime.now().isoformat()
            else:
                data[field] = '' if field != 'event' else 'post_tool_use'
    
    data['error_attention_active'] = True
    data['input_source'] = 'validated_json'
    return data


def validate_tool_execution_success(tool_data, result_data):
    """ERROR ATTENTION PROTOCOL: Validate tool executed successfully"""
    tool_name = tool_data.get('name', '')
    success = result_data.get('success', False)
    output = result_data.get('output', '')
    error = result_data.get('error', '')
    
    errors = []
    warnings = []
    attention_required = False
    
    # Tool execution failure is NEVER acceptable
    if not success:
        errors.append("ERROR ATTENTION PROTOCOL: Tool execution FAILED")
        errors.append(f"Tool: {tool_name} - Error: {error}")
        errors.append("IMMEDIATE ACTION: Deploy error-resolution specialist")
        attention_required = True
    
    # Check for error indicators in output
    if output:
        error_patterns = ['error:', 'failed:', 'exception:', 'traceback:', 'fatal:']
        for pattern in error_patterns:
            if pattern.lower() in output.lower():
                errors.append(f"ERROR DETECTED in tool output: {pattern}")
                attention_required = True
    
    # File operation validation
    file_operation_tools = ['Write', 'Edit', 'MultiEdit']
    if tool_name in file_operation_tools:
        file_path = tool_data.get('parameters', {}).get('file_path', '')
        if file_path:
            # Verify file was actually created/modified
            if not os.path.exists(file_path):
                errors.append(f"CRITICAL: File operation claimed success but file not found: {file_path}")
                attention_required = True
            else:
                # Check file modification time
                try:
                    stat_info = os.stat(file_path)
                    mod_time = datetime.fromtimestamp(stat_info.st_mtime)
                    current_time = datetime.now()
                    time_diff = (current_time - mod_time).total_seconds()
                    
                    if time_diff > 60:  # File not modified in last minute
                        warnings.append(f"File modification timestamp suspicious: {file_path}")
                except Exception as e:
                    warnings.append(f"Could not verify file modification: {e}")
    
    return {
        'valid': len(errors) == 0,
        'errors': errors,
        'warnings': warnings,
        'attention_required': attention_required,
        'execution_verified': success and len(errors) == 0
    }


def validate_evidence_requirements(tool_data, result_data):
    """ERROR ATTENTION PROTOCOL: Validate evidence-based claims"""
    tool_name = tool_data.get('name', '')
    output = result_data.get('output', '')
    
    warnings = []
    evidence_issues = []
    
    # Tools that create code require validation evidence
    code_tools = ['Write', 'Edit', 'MultiEdit']
    if tool_name in code_tools:
        file_path = tool_data.get('parameters', {}).get('file_path', '')
        
        if file_path and file_path.endswith('.py'):
            # Python files should be syntax-checked
            try:
                result = subprocess.run(
                    ['python3', '-m', 'py_compile', file_path],
                    capture_output=True, text=True
                )
                if result.returncode != 0:
                    evidence_issues.append(f"Python syntax error in {file_path}: {result.stderr}")
            except Exception:
                warnings.append(f"Could not validate Python syntax for {file_path}")
        
        # Hook files require executable permissions
        if 'hook' in file_path.lower() and file_path.endswith('.py'):
            if not os.access(file_path, os.X_OK):
                warnings.append(f"Hook file may need executable permissions: {file_path}")
    
    # Check for claims without evidence in output
    claim_patterns = ['will work', 'should work', 'this fixes', 'successfully', 'completed']
    test_patterns = ['test', 'verify', 'validate', 'check', 'proof']
    
    has_claims = any(pattern in output.lower() for pattern in claim_patterns)
    has_evidence = any(pattern in output.lower() for pattern in test_patterns)
    
    if has_claims and not has_evidence:
        warnings.append("Claims made without evidence - validate and test all implementations")
    
    return {
        'valid': len(evidence_issues) == 0,
        'warnings': warnings,
        'errors': evidence_issues,
        'evidence_validation_needed': len(warnings) > 0 or len(evidence_issues) > 0
    }


def validate_framework_compliance_post_execution(tool_data, result_data):
    """ERROR ATTENTION PROTOCOL: Validate framework compliance after execution"""
    tool_name = tool_data.get('name', '')
    file_path = tool_data.get('parameters', {}).get('file_path', '')
    
    errors = []
    warnings = []
    compliance_issues = False
    
    # Validate created files follow framework standards
    if tool_name in ['Write', 'Edit', 'MultiEdit'] and file_path:
        
        # Check for unauthorized documentation creation
        if file_path.endswith('.md') and 'README' in file_path.upper():
            if tool_name == 'Write':  # New file creation
                warnings.append("Framework violation: Avoid creating documentation unless explicitly requested")
        
        # Validate hook files have proper structure
        if 'hook' in file_path.lower() and file_path.endswith('.py'):
            try:
                with open(file_path, 'r') as f:
                    content = f.read()
                
                # Check for PEP 723 compliance
                if '# /// script' not in content:
                    errors.append("FRAMEWORK VIOLATION: Hook missing PEP 723 script metadata")
                    compliance_issues = True
                
                # Check for proper exit code handling
                exit_patterns = ['sys.exit(0)', 'sys.exit(1)', 'sys.exit(2)']
                if not any(pattern in content for pattern in exit_patterns):
                    errors.append("FRAMEWORK VIOLATION: Hook missing proper exit code handling")
                    compliance_issues = True
                
                # Check for JSON output structure
                if 'json.dumps' not in content:
                    warnings.append("Hook should provide structured JSON output")
                
            except Exception as e:
                warnings.append(f"Could not validate hook file structure: {e}")
        
        # Check for framework directory violations
        claude_dir = str(Path.home() / '.claude')
        if file_path.startswith(claude_dir):
            if '/system/' in file_path and tool_name == 'Write':
                warnings.append("Creating new system files - ensure this follows framework guidelines")
    
    return {
        'valid': len(errors) == 0,
        'errors': errors,
        'warnings': warnings,
        'compliance_issues_detected': compliance_issues,
        'framework_verification_needed': len(errors) > 0 or len(warnings) > 0
    }


def check_git_status_changes():
    """Check if git status has new changes requiring attention"""
    try:
        result = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        
        status_output = result.stdout.strip()
        if status_output:
            lines = status_output.split('\n')
            untracked = [line for line in lines if line.startswith('??')]
            modified = [line for line in lines if line.startswith(' M') or line.startswith('M ')]
            
            return {
                'has_changes': True,
                'untracked_files': len(untracked),
                'modified_files': len(modified),
                'total_changes': len(lines),
                'status': status_output
            }
        
        return {'has_changes': False, 'status': ''}
        
    except Exception:
        return {'has_changes': False, 'error': 'Could not check git status'}


def main():
    """Main ERROR ATTENTION PROTOCOL post-tool validation"""
    try:
        # Load and validate input
        hook_data = load_hook_data()
        
        tool_data = hook_data.get('tool', {})
        result_data = hook_data.get('result', {})
        
        # Run ERROR ATTENTION PROTOCOL validations
        validations = [
            validate_tool_execution_success(tool_data, result_data),
            validate_evidence_requirements(tool_data, result_data),
            validate_framework_compliance_post_execution(tool_data, result_data)
        ]
        
        # Collect results
        all_errors = []
        all_warnings = []
        attention_required = False
        compliance_issues = False
        
        for validation in validations:
            all_errors.extend(validation.get('errors', []))
            all_warnings.extend(validation.get('warnings', []))
            if validation.get('attention_required', False):
                attention_required = True
            if validation.get('compliance_issues_detected', False):
                compliance_issues = True
        
        # Check git status for changes
        git_status = check_git_status_changes()
        
        # ERROR ATTENTION PROTOCOL: Determine response
        if all_errors or attention_required or compliance_issues:
            # CRITICAL: Validation failures require immediate attention
            result = {
                'validation_status': 'FAILED',
                'error_attention_protocol_activated': True,
                'immediate_investigation_required': True,
                'framework_compliance_issues': compliance_issues,
                'errors': all_errors,
                'warnings': all_warnings,
                'tool': tool_data,
                'result': result_data,
                'required_actions': [
                    "STOP and investigate validation failures",
                    "Deploy error-resolution specialists immediately",
                    "Address all compliance issues before continuing",
                    "Verify all implementations with evidence"
                ],
                'git_status': git_status,
                'metadata': {
                    'hook_name': 'error_attention_post_tool_use',
                    'protocol_status': 'VALIDATION_FAILED',
                    'timestamp': datetime.now().isoformat(),
                    'attention_level': 'CRITICAL'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(2)  # BLOCKING ERROR - IMMEDIATE ATTENTION REQUIRED
        
        elif all_warnings:
            # Validation concerns identified
            result = {
                'validation_status': 'CONCERNS_IDENTIFIED',
                'error_attention_protocol_active': True,
                'validation_concerns_present': True,
                'errors': [],
                'warnings': all_warnings,
                'tool': tool_data,
                'result': result_data,
                'recommendations': [
                    "Review validation concerns",
                    "Provide evidence for all claims",
                    "Follow framework compliance guidelines",
                    "Consider additional validation steps"
                ],
                'git_status': git_status,
                'metadata': {
                    'hook_name': 'error_attention_post_tool_use',
                    'protocol_status': 'CONCERNS_IDENTIFIED',
                    'timestamp': datetime.now().isoformat(),
                    'attention_level': 'MODERATE'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(1)  # Non-blocking warning with validation concerns
        
        else:
            # Tool execution validated successfully
            result = {
                'validation_status': 'SUCCESS',
                'error_attention_protocol_active': True,
                'tool_execution_validated': True,
                'framework_compliance_verified': True,
                'errors': [],
                'warnings': [],
                'tool': tool_data,
                'result': result_data,
                'status': "Tool execution successfully validated",
                'git_status': git_status,
                'metadata': {
                    'hook_name': 'error_attention_post_tool_use',
                    'protocol_status': 'VALIDATED',
                    'timestamp': datetime.now().isoformat(),
                    'attention_level': 'NONE'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(0)  # Success - Tool execution validated
        
    except Exception as e:
        # ERROR ATTENTION PROTOCOL: Hook execution errors require attention
        result = {
            'validation_status': 'HOOK_ERROR',
            'error_attention_protocol_error': True,
            'hook_execution_error': str(e),
            'errors': [f"Post-tool hook execution error: {e}"],
            'warnings': ["ERROR ATTENTION PROTOCOL: Hook error requires investigation"],
            'tool': {'name': 'unknown', 'parameters': {}},
            'required_actions': [
                "Investigate post-tool hook execution error",
                "Verify hook system integrity",
                "Ensure tool validation system is functional"
            ],
            'metadata': {
                'hook_name': 'error_attention_post_tool_use',
                'protocol_status': 'HOOK_ERROR',
                'timestamp': datetime.now().isoformat(),
                'error_type': 'hook_execution_error',
                'attention_level': 'HIGH'
            }
        }
        print(json.dumps(result, indent=2))
        sys.exit(1)  # Non-blocking error with attention required


if __name__ == "__main__":
    main()