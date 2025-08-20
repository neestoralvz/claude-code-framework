#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "json", "sys", "os", "subprocess", "re"]
# ///

"""
Claude Code Hook: ERROR ATTENTION PROTOCOL - PreToolUse

MISSION CRITICAL: Zero Error Tolerance Enforcement

This hook implements the ERROR ATTENTION PROTOCOL for pre-tool validation:
- NEVER normalize errors → Every error triggers immediate attention and resolution
- IMMEDIATE AGENT DEPLOYMENT → Deploy specialized error-resolution agents instantly
- ZERO ERROR TOLERANCE → No error is acceptable or normal
- FRAMEWORK ENFORCEMENT → Universal Operation Mode compliance validation

Exit Codes:
- 0: Success, framework compliance verified
- 1: Non-blocking warning, framework guidance provided
- 2: BLOCKING ERROR, framework violation detected - IMMEDIATE AGENT DEPLOYMENT REQUIRED
"""

import json
import sys
import os
import subprocess
import re
from pathlib import Path
from datetime import datetime


def load_hook_data():
    """Load and validate hook data with ERROR ATTENTION PROTOCOL enforcement"""
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
    """Create default data structure with error attention markers"""
    return {
        'event': 'pre_tool_use',
        'source': 'claude_code',
        'tool': {'name': 'unknown', 'parameters': {}},
        'conversation_context': '',
        'timestamp': datetime.now().isoformat(),
        'input_source': reason,
        'error_attention_active': True
    }


def create_error_data(error_type, error_msg):
    """Create error data with immediate attention required"""
    return {
        'event': 'pre_tool_use',
        'source': 'claude_code',
        'tool': {'name': 'unknown', 'parameters': {}},
        'conversation_context': '',
        'timestamp': datetime.now().isoformat(),
        'input_error': error_msg,
        'error_type': error_type,
        'input_source': 'error_fallback',
        'error_attention_required': True,
        'immediate_agent_deployment_needed': True
    }


def validate_and_enhance_data(data):
    """Validate and enhance data with ERROR ATTENTION PROTOCOL markers"""
    required_fields = ['event', 'source', 'tool', 'conversation_context', 'timestamp']
    
    for field in required_fields:
        if field not in data:
            if field == 'tool':
                data[field] = {'name': 'unknown', 'parameters': {}}
            elif field == 'timestamp':
                data[field] = datetime.now().isoformat()
            else:
                data[field] = '' if field != 'event' else 'pre_tool_use'
    
    data['error_attention_active'] = True
    data['input_source'] = 'validated_json'
    return data


def validate_context7_compliance(tool_data, conversation_context):
    """ERROR ATTENTION PROTOCOL: Validate Context7 usage for all code creation"""
    tool_name = tool_data.get('name', '')
    tool_params = tool_data.get('parameters', {})
    
    # Tools that require Context7 compliance
    code_creation_tools = ['Write', 'Edit', 'MultiEdit']
    if tool_name not in code_creation_tools:
        return {'valid': True, 'warnings': [], 'errors': [], 'agent_deployment_required': False}
    
    errors = []
    warnings = []
    agent_deployment_required = False
    
    # Check if Context7 was used in conversation context
    context_str = str(conversation_context).lower()
    context7_indicators = ['context7', 'websearch', 'webfetch', 'research']
    
    has_context7_usage = any(indicator in context_str for indicator in context7_indicators)
    
    # Check file extensions that require Context7 research
    file_path = tool_params.get('file_path', '')
    if file_path:
        code_extensions = ['.py', '.js', '.ts', '.go', '.rs', '.java', '.cpp', '.c', '.sh']
        requires_context7 = any(file_path.endswith(ext) for ext in code_extensions)
        
        if requires_context7 and not has_context7_usage:
            errors.append("ERROR ATTENTION PROTOCOL VIOLATION: Context7 research MANDATORY for code creation")
            errors.append("IMMEDIATE ACTION REQUIRED: Deploy Context7 research before proceeding")
            agent_deployment_required = True
    
    # Check for hook/script creation without research
    if 'hook' in file_path.lower() or 'script' in file_path.lower():
        if not has_context7_usage:
            errors.append("CRITICAL VIOLATION: Hook/script creation requires Context7 research")
            errors.append("DEPLOY claude-hooks-developer agent IMMEDIATELY")
            agent_deployment_required = True
    
    return {
        'valid': len(errors) == 0,
        'warnings': warnings,
        'errors': errors,
        'agent_deployment_required': agent_deployment_required,
        'framework_violation_detected': len(errors) > 0
    }


def validate_agent_deployment_compliance(tool_data, conversation_context):
    """ERROR ATTENTION PROTOCOL: Validate specialized agent deployment"""
    tool_name = tool_data.get('name', '')
    
    errors = []
    warnings = []
    agent_deployment_required = False
    
    # Tools that require agent deployment
    complex_tools = ['Write', 'Edit', 'MultiEdit', 'Task']
    if tool_name not in complex_tools:
        return {'valid': True, 'warnings': [], 'errors': [], 'agent_deployment_required': False}
    
    context_str = str(conversation_context).lower()
    
    # Check for agent deployment indicators
    agent_indicators = ['agent', 'specialist', 'deploy', 'task']
    has_agent_deployment = any(indicator in context_str for indicator in agent_indicators)
    
    # Direct work detection (framework violation)
    direct_work_patterns = ['i will', 'let me', 'i\'ll create', 'i\'ll implement', 'i\'ll write']
    has_direct_work = any(pattern in context_str for pattern in direct_work_patterns)
    
    if has_direct_work and not has_agent_deployment:
        errors.append("FRAMEWORK VIOLATION: Direct work detected - AGENT DEPLOYMENT MANDATORY")
        errors.append("ERROR ATTENTION PROTOCOL: Deploy specialized agents for ALL work")
        agent_deployment_required = True
    
    # Check for specialized work requiring specific agents
    specialized_patterns = {
        'hook': 'claude-hooks-developer',
        'test': 'testing-strategy-specialist', 
        'security': 'security-specialist',
        'performance': 'performance-specialist'
    }
    
    for pattern, required_agent in specialized_patterns.items():
        if pattern in context_str and required_agent not in context_str:
            warnings.append(f"Consider deploying {required_agent} agent for {pattern} work")
    
    return {
        'valid': len(errors) == 0,
        'warnings': warnings,
        'errors': errors,
        'agent_deployment_required': agent_deployment_required,
        'framework_violation_detected': len(errors) > 0
    }


def validate_progressive_thinking_usage(conversation_context):
    """ERROR ATTENTION PROTOCOL: Validate 4-level Progressive Thinking methodology"""
    context_str = str(conversation_context).lower()
    
    errors = []
    warnings = []
    
    # Check for Progressive Thinking indicators
    thinking_levels = ['think', 'think hard', 'think harder', 'ultra think']
    thinking_usage = [level for level in thinking_levels if level in context_str]
    
    # Complex tasks require Progressive Thinking
    complexity_indicators = ['complex', 'multi-step', 'framework', 'system', 'integration']
    is_complex = any(indicator in context_str for indicator in complexity_indicators)
    
    if is_complex and len(thinking_usage) < 2:
        warnings.append("Complex task detected - consider Progressive Thinking methodology")
        warnings.append("Use 4-level analysis: Think → Think Hard → Think Harder → Ultra Think")
    
    return {
        'valid': True,  # Progressive Thinking is encouraged, not strictly required
        'warnings': warnings,
        'errors': errors,
        'framework_guidance_provided': len(warnings) > 0
    }


def validate_todowrite_compliance(tool_data, conversation_context):
    """ERROR ATTENTION PROTOCOL: Validate TodoWrite usage for task tracking"""
    tool_name = tool_data.get('name', '')
    context_str = str(conversation_context).lower()
    
    errors = []
    warnings = []
    
    # Multi-step operations require TodoWrite
    multi_step_tools = ['Write', 'Edit', 'MultiEdit']
    if tool_name in multi_step_tools:
        has_todowrite = 'todowrite' in context_str or 'todo' in context_str
        
        # Check for multiple file operations indicating complex workflow
        file_operation_count = context_str.count('file_path')
        if file_operation_count > 1 and not has_todowrite:
            warnings.append("Multi-file operation detected - TodoWrite recommended for tracking")
        
        # Check for framework work requiring structured approach  
        framework_indicators = ['hook', 'system', 'framework', 'protocol']
        needs_structure = any(indicator in context_str for indicator in framework_indicators)
        
        if needs_structure and not has_todowrite:
            warnings.append("Framework work detected - TodoWrite tracking recommended")
    
    return {
        'valid': True,
        'warnings': warnings,
        'errors': errors,
        'tracking_recommended': len(warnings) > 0
    }


def validate_evidence_requirements(conversation_context):
    """ERROR ATTENTION PROTOCOL: Validate evidence-based approach"""
    context_str = str(conversation_context).lower()
    
    warnings = []
    
    # Claims requiring evidence
    claim_patterns = ['will work', 'should work', 'this fixes', 'this solves']
    evidence_patterns = ['test', 'validate', 'verify', 'proof', 'evidence']
    
    has_claims = any(pattern in context_str for pattern in claim_patterns)
    has_evidence = any(pattern in context_str for pattern in evidence_patterns)
    
    if has_claims and not has_evidence:
        warnings.append("Claims detected - provide evidence/validation for all statements")
        warnings.append("Framework requirement: Test and demonstrate all solutions")
    
    return {
        'valid': True,
        'warnings': warnings,
        'errors': [],
        'evidence_guidance_provided': len(warnings) > 0
    }


def get_git_status():
    """Get current git status for context"""
    try:
        result = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        return result.stdout.strip() if result.returncode == 0 else ""
    except Exception:
        return ""


def main():
    """Main ERROR ATTENTION PROTOCOL enforcement"""
    try:
        # Load and validate input
        hook_data = load_hook_data()
        
        tool_data = hook_data.get('tool', {})
        conversation_context = hook_data.get('conversation_context', '')
        
        # Run ERROR ATTENTION PROTOCOL validations
        validations = [
            validate_context7_compliance(tool_data, conversation_context),
            validate_agent_deployment_compliance(tool_data, conversation_context),
            validate_progressive_thinking_usage(conversation_context),
            validate_todowrite_compliance(tool_data, conversation_context),
            validate_evidence_requirements(conversation_context)
        ]
        
        # Collect results
        all_errors = []
        all_warnings = []
        agent_deployment_required = False
        framework_violations = False
        
        for validation in validations:
            all_errors.extend(validation.get('errors', []))
            all_warnings.extend(validation.get('warnings', []))
            if validation.get('agent_deployment_required', False):
                agent_deployment_required = True
            if validation.get('framework_violation_detected', False):
                framework_violations = True
        
        # ERROR ATTENTION PROTOCOL: Determine response
        if all_errors or framework_violations:
            # CRITICAL: Framework violations require immediate attention
            result = {
                'allowed': False,
                'error_attention_protocol_activated': True,
                'framework_violations_detected': framework_violations,
                'immediate_agent_deployment_required': agent_deployment_required,
                'errors': all_errors,
                'warnings': all_warnings,
                'tool': tool_data,
                'required_actions': [
                    "STOP current operation",
                    "Deploy specialized agents immediately", 
                    "Address all framework violations",
                    "Return to Universal Operation Mode compliance"
                ],
                'metadata': {
                    'hook_name': 'error_attention_pre_tool_use',
                    'protocol_status': 'VIOLATION_DETECTED',
                    'timestamp': datetime.now().isoformat(),
                    'git_status': get_git_status()
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(2)  # BLOCKING ERROR - IMMEDIATE ATTENTION REQUIRED
        
        elif all_warnings:
            # Framework guidance provided
            result = {
                'allowed': True,
                'error_attention_protocol_active': True,
                'framework_guidance_provided': True,
                'errors': [],
                'warnings': all_warnings,
                'tool': tool_data,
                'recommendations': [
                    "Follow Universal Operation Mode principles",
                    "Deploy specialized agents for complex work",
                    "Use Progressive Thinking for analysis",
                    "Provide evidence for all claims"
                ],
                'metadata': {
                    'hook_name': 'error_attention_pre_tool_use',
                    'protocol_status': 'GUIDANCE_PROVIDED',
                    'timestamp': datetime.now().isoformat(),
                    'git_status': get_git_status()
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(1)  # Non-blocking warning with guidance
        
        else:
            # Framework compliance verified
            result = {
                'allowed': True,
                'error_attention_protocol_active': True,
                'framework_compliance_verified': True,
                'errors': [],
                'warnings': [],
                'tool': tool_data,
                'status': "Universal Operation Mode compliance verified",
                'metadata': {
                    'hook_name': 'error_attention_pre_tool_use',
                    'protocol_status': 'COMPLIANT',
                    'timestamp': datetime.now().isoformat(),
                    'git_status': get_git_status()
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(0)  # Success - Framework compliance verified
        
    except Exception as e:
        # ERROR ATTENTION PROTOCOL: Even hook errors require attention
        result = {
            'allowed': True,  # Don't block on hook errors
            'error_attention_protocol_error': True,
            'hook_execution_error': str(e),
            'errors': [f"Hook execution error: {e}"],
            'warnings': ["ERROR ATTENTION PROTOCOL: Hook error requires investigation"],
            'tool': {'name': 'unknown', 'parameters': {}},
            'required_actions': [
                "Investigate hook execution error",
                "Verify hook system integrity",
                "Consider hook system maintenance"
            ],
            'metadata': {
                'hook_name': 'error_attention_pre_tool_use',
                'protocol_status': 'HOOK_ERROR',
                'timestamp': datetime.now().isoformat(),
                'error_type': 'hook_execution_error'
            }
        }
        print(json.dumps(result, indent=2))
        sys.exit(1)  # Non-blocking error with attention required


if __name__ == "__main__":
    main()