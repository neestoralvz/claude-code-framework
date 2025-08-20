#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "json", "sys", "os", "subprocess", "re"]
# ///

"""
Claude Code Hook: ERROR ATTENTION PROTOCOL - UserPromptSubmit

MISSION CRITICAL: Zero Error Tolerance Enforcement - Prompt Analysis

This hook implements the ERROR ATTENTION PROTOCOL for user prompt analysis:
- NEVER normalize errors → Every error triggers immediate attention and resolution
- IMMEDIATE AGENT DEPLOYMENT → Deploy specialized agents for complex requests
- ZERO ERROR TOLERANCE → No error is acceptable or normal
- UNIVERSAL OPERATION MODE → Enforce all 16 pattern compliance

Exit Codes:
- 0: Success, prompt analyzed and enhanced with framework context
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
    """Load and validate user prompt data"""
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
    """Create default prompt data structure"""
    return {
        'event': 'user_prompt_submit',
        'source': 'claude_code',
        'prompt': '',
        'timestamp': datetime.now().isoformat(),
        'input_source': reason,
        'error_attention_active': True
    }


def create_error_data(error_type, error_msg):
    """Create error data requiring immediate attention"""
    return {
        'event': 'user_prompt_submit',
        'source': 'claude_code', 
        'prompt': '',
        'timestamp': datetime.now().isoformat(),
        'input_error': error_msg,
        'error_type': error_type,
        'input_source': 'error_fallback',
        'error_attention_required': True,
        'immediate_agent_deployment_needed': True
    }


def validate_and_enhance_data(data):
    """Validate and enhance prompt data"""
    required_fields = ['event', 'source', 'prompt', 'timestamp']
    
    for field in required_fields:
        if field not in data:
            if field == 'timestamp':
                data[field] = datetime.now().isoformat()
            else:
                data[field] = '' if field != 'event' else 'user_prompt_submit'
    
    data['error_attention_active'] = True
    data['input_source'] = 'validated_json'
    return data


def analyze_prompt_complexity(prompt_text):
    """ERROR ATTENTION PROTOCOL: Analyze prompt complexity for agent deployment"""
    prompt_lower = prompt_text.lower()
    
    complexity_indicators = {
        'high_complexity': [
            'system', 'framework', 'architecture', 'integration', 'comprehensive',
            'implement', 'build', 'create', 'develop', 'design', 'deploy'
        ],
        'multi_step': [
            'first', 'then', 'next', 'finally', 'step', 'phase', 'stage',
            'multiple', 'several', 'many', 'various', 'all'
        ],
        'specialized_domains': [
            'hook', 'security', 'performance', 'test', 'database', 'api',
            'protocol', 'algorithm', 'optimization', 'validation'
        ],
        'error_patterns': [
            'error', 'fix', 'debug', 'problem', 'issue', 'failure', 'broken',
            'not working', 'failed', 'exception', 'crash'
        ]
    }
    
    analysis = {
        'complexity_score': 0,
        'indicators_found': {},
        'requires_agent_deployment': False,
        'requires_progressive_thinking': False,
        'requires_todowrite': False,
        'specialized_agents_needed': []
    }
    
    # Calculate complexity score
    for category, indicators in complexity_indicators.items():
        found = [indicator for indicator in indicators if indicator in prompt_lower]
        if found:
            analysis['indicators_found'][category] = found
            analysis['complexity_score'] += len(found)
    
    # Determine requirements based on complexity
    if analysis['complexity_score'] >= 5:
        analysis['requires_agent_deployment'] = True
        analysis['requires_progressive_thinking'] = True
        analysis['requires_todowrite'] = True
    elif analysis['complexity_score'] >= 3:
        analysis['requires_agent_deployment'] = True
        analysis['requires_todowrite'] = True
    elif analysis['complexity_score'] >= 1:
        analysis['requires_agent_deployment'] = True
    
    # Identify specialized agents needed
    agent_mapping = {
        'hook': 'claude-hooks-developer',
        'test': 'testing-strategy-specialist',
        'security': 'security-specialist',
        'performance': 'performance-specialist',
        'debug': 'debugging-specialist',
        'error': 'error-resolution-specialist',
        'database': 'database-specialist',
        'api': 'api-specialist'
    }
    
    for keyword, agent in agent_mapping.items():
        if keyword in prompt_lower:
            analysis['specialized_agents_needed'].append(agent)
    
    return analysis


def validate_universal_operation_mode_compliance(prompt_text):
    """ERROR ATTENTION PROTOCOL: Validate Universal Operation Mode compliance"""
    prompt_lower = prompt_text.lower()
    
    errors = []
    warnings = []
    compliance_issues = False
    
    # Check for direct work requests (framework violation)
    direct_work_patterns = [
        'write', 'create', 'implement', 'build', 'develop', 'code',
        'fix', 'update', 'modify', 'change', 'add', 'remove'
    ]
    
    direct_requests = [pattern for pattern in direct_work_patterns if pattern in prompt_lower]
    
    if direct_requests and 'agent' not in prompt_lower:
        errors.append("FRAMEWORK VIOLATION: Direct work request without agent deployment")
        errors.append("ERROR ATTENTION PROTOCOL: ALL work requires specialized agent deployment")
        errors.append(f"Detected direct work patterns: {', '.join(direct_requests[:3])}")
        compliance_issues = True
    
    # Check for Context7 bypass attempts
    code_patterns = ['python', 'javascript', 'typescript', 'hook', 'script', '.py', '.js']
    needs_context7 = any(pattern in prompt_lower for pattern in code_patterns)
    
    if needs_context7 and 'context7' not in prompt_lower and 'websearch' not in prompt_lower:
        errors.append("FRAMEWORK VIOLATION: Code creation without Context7 research")
        errors.append("MANDATORY: Use Context7 for all library documentation and best practices")
        compliance_issues = True
    
    # Check for missing Progressive Thinking on complex tasks
    complex_indicators = ['system', 'framework', 'comprehensive', 'complex', 'integration']
    is_complex = any(indicator in prompt_lower for indicator in complex_indicators)
    
    if is_complex and not any(thinking in prompt_lower for thinking in ['think', 'analyze', 'consider']):
        warnings.append("Complex task detected - Progressive Thinking methodology recommended")
        warnings.append("Use 4-level analysis: Think → Think Hard → Think Harder → Ultra Think")
    
    # Check for evidence requirements bypass
    claim_patterns = ['will work', 'should work', 'fixes', 'solves', 'handles']
    makes_claims = any(pattern in prompt_lower for pattern in claim_patterns)
    
    if makes_claims and not any(evidence in prompt_lower for evidence in ['test', 'verify', 'validate', 'prove']):
        warnings.append("Claims made - evidence and validation required for all statements")
    
    return {
        'compliant': len(errors) == 0,
        'errors': errors,
        'warnings': warnings,
        'compliance_issues_detected': compliance_issues,
        'immediate_agent_deployment_required': compliance_issues
    }


def check_framework_status():
    """Check current framework and system status"""
    try:
        git_result = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        git_status = git_result.stdout.strip() if git_result.returncode == 0 else ""
        
        # Count recent commits
        recent_commits = subprocess.run(
            ['git', 'log', '--oneline', '--since="24 hours ago"'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        commit_count = len(recent_commits.stdout.strip().split('\n')) if recent_commits.returncode == 0 else 0
        
        # Check for hooks directory
        hooks_dir = Path.home() / '.claude' / 'hooks'
        hooks_exist = hooks_dir.exists()
        hook_count = len(list(hooks_dir.glob('*.py'))) if hooks_exist else 0
        
        return {
            'git_has_changes': bool(git_status),
            'git_change_count': len(git_status.split('\n')) if git_status else 0,
            'recent_commits': commit_count,
            'hooks_directory_exists': hooks_exist,
            'hook_files_count': hook_count,
            'framework_active': hooks_exist and hook_count > 0
        }
        
    except Exception as e:
        return {
            'error': str(e),
            'framework_status_unknown': True
        }


def generate_enhanced_prompt_context(prompt_text, complexity_analysis, framework_status):
    """Generate enhanced context for Claude to process the request"""
    
    context_sections = []
    
    # ERROR ATTENTION PROTOCOL Status
    context_sections.append("=== ERROR ATTENTION PROTOCOL ACTIVE ===")
    context_sections.append("ZERO ERROR TOLERANCE - Every error triggers immediate attention")
    context_sections.append("IMMEDIATE AGENT DEPLOYMENT - Deploy specialized agents for all work")
    context_sections.append("UNIVERSAL OPERATION MODE - All 16 patterns must be active")
    context_sections.append("")
    
    # Complexity Analysis
    if complexity_analysis['complexity_score'] > 0:
        context_sections.append("=== PROMPT COMPLEXITY ANALYSIS ===")
        context_sections.append(f"Complexity Score: {complexity_analysis['complexity_score']}")
        
        if complexity_analysis['requires_agent_deployment']:
            context_sections.append("MANDATORY: Specialized agent deployment required")
        if complexity_analysis['requires_progressive_thinking']:
            context_sections.append("MANDATORY: Progressive Thinking 4-level methodology required")
        if complexity_analysis['requires_todowrite']:
            context_sections.append("MANDATORY: TodoWrite task tracking required")
        
        if complexity_analysis['specialized_agents_needed']:
            agents = ', '.join(complexity_analysis['specialized_agents_needed'])
            context_sections.append(f"RECOMMENDED AGENTS: {agents}")
        context_sections.append("")
    
    # Framework Status
    context_sections.append("=== FRAMEWORK STATUS ===")
    if framework_status.get('framework_active'):
        context_sections.append("Framework Status: ACTIVE")
        context_sections.append(f"Hook Files: {framework_status.get('hook_files_count', 0)}")
    else:
        context_sections.append("Framework Status: NEEDS ATTENTION")
    
    if framework_status.get('git_has_changes'):
        context_sections.append(f"Git Changes: {framework_status.get('git_change_count', 0)} files")
    
    context_sections.append(f"Recent Commits: {framework_status.get('recent_commits', 0)}")
    context_sections.append("")
    
    # Universal Operation Patterns Reminder
    context_sections.append("=== MANDATORY UNIVERSAL OPERATION PATTERNS ===")
    patterns = [
        "1. Progressive Think (4 levels mandatory)",
        "2. Agent Deployment (specialized agents FIRST)",
        "3. TodoWrite Tracking (atomic tasks)",
        "4. Evidence Validation (proof required)",
        "5. Context7 Research (mandatory for code)",
        "6. Framework Compliance (all standards)",
        "7. TDD/BDD Methodology (all development)",
        "8. Git Workflow Automation (auto-commit)"
    ]
    context_sections.extend(patterns)
    context_sections.append("")
    
    # Original Prompt
    context_sections.append("=== USER REQUEST ===")
    context_sections.append(prompt_text)
    
    return '\n'.join(context_sections)


def main():
    """Main ERROR ATTENTION PROTOCOL prompt analysis"""
    try:
        # Load and validate input
        hook_data = load_hook_data()
        prompt_text = hook_data.get('prompt', '')
        
        # Perform ERROR ATTENTION PROTOCOL analysis
        complexity_analysis = analyze_prompt_complexity(prompt_text)
        compliance_validation = validate_universal_operation_mode_compliance(prompt_text)
        framework_status = check_framework_status()
        
        # Generate enhanced prompt context
        enhanced_context = generate_enhanced_prompt_context(
            prompt_text, complexity_analysis, framework_status
        )
        
        # ERROR ATTENTION PROTOCOL: Determine response
        if compliance_validation['compliance_issues_detected']:
            # CRITICAL: Framework violations require immediate attention
            result = {
                'prompt_processing': 'BLOCKED',
                'error_attention_protocol_activated': True,
                'framework_violations_detected': True,
                'immediate_agent_deployment_required': True,
                'errors': compliance_validation['errors'],
                'warnings': compliance_validation['warnings'],
                'complexity_analysis': complexity_analysis,
                'framework_status': framework_status,
                'required_actions': [
                    "STOP current request processing",
                    "Deploy specialized agents immediately",
                    "Address all framework violations",
                    "Return to Universal Operation Mode compliance",
                    "Re-submit request with proper framework compliance"
                ],
                'enhanced_prompt': enhanced_context,
                'metadata': {
                    'hook_name': 'error_attention_user_prompt_submit',
                    'protocol_status': 'VIOLATION_DETECTED',
                    'timestamp': datetime.now().isoformat(),
                    'attention_level': 'CRITICAL'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(2)  # BLOCKING ERROR - IMMEDIATE ATTENTION REQUIRED
        
        elif compliance_validation['warnings'] or complexity_analysis['requires_agent_deployment']:
            # Framework guidance and agent deployment required
            result = {
                'prompt_processing': 'ENHANCED',
                'error_attention_protocol_active': True,
                'framework_guidance_provided': True,
                'agent_deployment_recommended': complexity_analysis['requires_agent_deployment'],
                'errors': [],
                'warnings': compliance_validation['warnings'],
                'complexity_analysis': complexity_analysis,
                'framework_status': framework_status,
                'recommendations': [
                    "Follow Universal Operation Mode principles",
                    "Deploy specialized agents for complex work",
                    "Use Progressive Thinking for analysis",
                    "Implement TodoWrite task tracking",
                    "Provide evidence for all claims"
                ],
                'enhanced_prompt': enhanced_context,
                'metadata': {
                    'hook_name': 'error_attention_user_prompt_submit',
                    'protocol_status': 'GUIDANCE_PROVIDED',
                    'timestamp': datetime.now().isoformat(),
                    'attention_level': 'MODERATE'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(1)  # Non-blocking warning with guidance
        
        else:
            # Prompt analysis complete with framework context
            result = {
                'prompt_processing': 'ENHANCED',
                'error_attention_protocol_active': True,
                'framework_context_provided': True,
                'errors': [],
                'warnings': [],
                'complexity_analysis': complexity_analysis,
                'framework_status': framework_status,
                'status': "Prompt enhanced with framework context and ERROR ATTENTION PROTOCOL",
                'enhanced_prompt': enhanced_context,
                'metadata': {
                    'hook_name': 'error_attention_user_prompt_submit',
                    'protocol_status': 'ENHANCED',
                    'timestamp': datetime.now().isoformat(),
                    'attention_level': 'NONE'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(0)  # Success - Prompt enhanced with framework context
        
    except Exception as e:
        # ERROR ATTENTION PROTOCOL: Hook execution errors require attention
        result = {
            'prompt_processing': 'HOOK_ERROR',
            'error_attention_protocol_error': True,
            'hook_execution_error': str(e),
            'errors': [f"User prompt hook execution error: {e}"],
            'warnings': ["ERROR ATTENTION PROTOCOL: Hook error requires investigation"],
            'required_actions': [
                "Investigate user prompt hook execution error",
                "Verify hook system integrity",
                "Ensure prompt analysis system is functional"
            ],
            'enhanced_prompt': hook_data.get('prompt', ''),
            'metadata': {
                'hook_name': 'error_attention_user_prompt_submit',
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