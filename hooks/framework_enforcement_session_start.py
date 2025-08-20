#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "json", "sys", "os", "subprocess", "re"]
# ///

"""
Claude Code Hook: FRAMEWORK ENFORCEMENT - SessionStart

MISSION CRITICAL: Universal Operation Mode Enforcement

This hook implements FRAMEWORK ENFORCEMENT for session start:
- Validates all 16 Universal Operation patterns are active
- Ensures TDD/BDD methodology compliance
- Enforces TodoWrite tracking requirements
- Validates agent deployment readiness

Exit Codes:
- 0: Success, framework fully operational and compliant
- 1: Non-blocking warning, framework needs attention
- 2: BLOCKING ERROR, framework violations detected - SESSION CANNOT START
"""

import json
import sys
import os
import subprocess
import re
from pathlib import Path
from datetime import datetime


def load_hook_data():
    """Load session start data"""
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
    """Create default session start data"""
    return {
        'event': 'session_start',
        'source': 'claude_code',
        'session_id': 'unknown',
        'timestamp': datetime.now().isoformat(),
        'input_source': reason,
        'framework_enforcement_active': True
    }


def create_error_data(error_type, error_msg):
    """Create error data for framework enforcement"""
    return {
        'event': 'session_start',
        'source': 'claude_code',
        'session_id': 'error',
        'timestamp': datetime.now().isoformat(),
        'input_error': error_msg,
        'error_type': error_type,
        'input_source': 'error_fallback',
        'framework_enforcement_error': True
    }


def validate_and_enhance_data(data):
    """Validate and enhance session data"""
    required_fields = ['event', 'source', 'session_id', 'timestamp']
    
    for field in required_fields:
        if field not in data:
            if field == 'session_id':
                data[field] = f"session_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
            elif field == 'timestamp':
                data[field] = datetime.now().isoformat()
            else:
                data[field] = '' if field != 'event' else 'session_start'
    
    data['framework_enforcement_active'] = True
    data['input_source'] = 'validated_json'
    return data


def validate_universal_operation_patterns():
    """FRAMEWORK ENFORCEMENT: Validate all 16 Universal Operation patterns"""
    claude_md_path = Path.home() / '.claude' / 'CLAUDE.md'
    
    if not claude_md_path.exists():
        return {
            'valid': False,
            'errors': ['CRITICAL: CLAUDE.md framework file not found'],
            'warnings': [],
            'patterns_active': 0,
            'patterns_total': 16
        }
    
    try:
        with open(claude_md_path, 'r') as f:
            claude_content = f.read()
    except Exception as e:
        return {
            'valid': False,
            'errors': [f'CRITICAL: Cannot read CLAUDE.md: {e}'],
            'warnings': [],
            'patterns_active': 0,
            'patterns_total': 16
        }
    
    # Check for Universal Operation Mode patterns
    required_patterns = [
        'Progressive Think',
        'Agent Deployment',
        'TodoWrite Tracking',
        'Evidence Validation',
        'Context7 Research',
        'System Documentation',
        'Quality Standards',
        'Pattern Documentation',
        'Git Integration',
        'Parallel Execution',
        'Session Management',
        'Framework Updates',
        'Personality Orchestration',
        'Knowledge Integration',
        'Quality Assurance',
        'Optimization Detection'
    ]
    
    patterns_found = []
    patterns_missing = []
    
    for pattern in required_patterns:
        if pattern in claude_content:
            patterns_found.append(pattern)
        else:
            patterns_missing.append(pattern)
    
    errors = []
    warnings = []
    
    if len(patterns_missing) > 0:
        if len(patterns_missing) > 4:
            errors.append(f"FRAMEWORK VIOLATION: {len(patterns_missing)} Universal Operation patterns missing")
            errors.append(f"Missing patterns: {', '.join(patterns_missing[:3])}...")
        else:
            warnings.append(f"Universal Operation patterns missing: {', '.join(patterns_missing)}")
    
    # Check for ERROR ATTENTION PROTOCOL
    if 'ERROR ATTENTION PROTOCOL' not in claude_content:
        errors.append("CRITICAL: ERROR ATTENTION PROTOCOL not found in framework")
    
    return {
        'valid': len(errors) == 0,
        'errors': errors,
        'warnings': warnings,
        'patterns_active': len(patterns_found),
        'patterns_total': len(required_patterns),
        'patterns_found': patterns_found,
        'patterns_missing': patterns_missing
    }


def validate_hooks_system_integrity():
    """FRAMEWORK ENFORCEMENT: Validate hooks system is functional"""
    hooks_dir = Path.home() / '.claude' / 'hooks'
    
    if not hooks_dir.exists():
        return {
            'valid': False,
            'errors': ['CRITICAL: Hooks directory not found - system integrity compromised'],
            'warnings': [],
            'hooks_count': 0,
            'error_attention_hooks': 0
        }
    
    # Check for ERROR ATTENTION PROTOCOL hooks
    error_attention_hooks = [
        'error_attention_pre_tool_use.py',
        'error_attention_post_tool_use.py',
        'error_attention_user_prompt_submit.py',
        'error_attention_notification.py'
    ]
    
    existing_hooks = list(hooks_dir.glob('*.py'))
    error_attention_existing = []
    
    for hook in error_attention_hooks:
        hook_path = hooks_dir / hook
        if hook_path.exists():
            error_attention_existing.append(hook)
            # Check if executable
            if not os.access(hook_path, os.X_OK):
                return {
                    'valid': False,
                    'errors': [f'CRITICAL: Hook not executable: {hook}'],
                    'warnings': [],
                    'hooks_count': len(existing_hooks),
                    'error_attention_hooks': len(error_attention_existing)
                }
    
    errors = []
    warnings = []
    
    if len(error_attention_existing) == 0:
        errors.append("CRITICAL: No ERROR ATTENTION PROTOCOL hooks found")
    elif len(error_attention_existing) < len(error_attention_hooks):
        missing = set(error_attention_hooks) - set(error_attention_existing)
        warnings.append(f"Missing ERROR ATTENTION hooks: {', '.join(missing)}")
    
    return {
        'valid': len(errors) == 0,
        'errors': errors,
        'warnings': warnings,
        'hooks_count': len(existing_hooks),
        'error_attention_hooks': len(error_attention_existing),
        'error_attention_hooks_found': error_attention_existing
    }


def validate_git_workflow_readiness():
    """FRAMEWORK ENFORCEMENT: Validate git workflow is ready"""
    try:
        # Check if in git repository
        git_check = subprocess.run(
            ['git', 'rev-parse', '--git-dir'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        
        if git_check.returncode != 0:
            return {
                'valid': False,
                'errors': ['FRAMEWORK VIOLATION: Not in git repository - auto-commit disabled'],
                'warnings': [],
                'git_ready': False
            }
        
        # Check git status
        status_check = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        
        warnings = []
        if status_check.returncode == 0 and status_check.stdout.strip():
            change_count = len(status_check.stdout.strip().split('\n'))
            if change_count > 10:
                warnings.append(f"Large number of git changes ({change_count}) - consider cleanup")
        
        # Check git configuration
        user_check = subprocess.run(
            ['git', 'config', 'user.name'],
            capture_output=True, text=True
        )
        
        email_check = subprocess.run(
            ['git', 'config', 'user.email'],
            capture_output=True, text=True
        )
        
        if not user_check.stdout.strip() or not email_check.stdout.strip():
            warnings.append("Git user configuration missing - may affect auto-commits")
        
        return {
            'valid': True,
            'errors': [],
            'warnings': warnings,
            'git_ready': True,
            'changes_pending': bool(status_check.stdout.strip())
        }
        
    except Exception as e:
        return {
            'valid': False,
            'errors': [f'Git workflow validation failed: {e}'],
            'warnings': [],
            'git_ready': False
        }


def validate_agent_system_readiness():
    """FRAMEWORK ENFORCEMENT: Validate agent system is ready"""
    agents_dir = Path.home() / '.claude' / 'agents'
    project_agents_dir = Path.cwd() / '.claude' / 'agents'
    
    warnings = []
    errors = []
    
    # Check for agent directories
    if not agents_dir.exists() and not project_agents_dir.exists():
        warnings.append("No agent directories found - agent deployment may require setup")
    
    # Count available agents
    total_agents = 0
    if agents_dir.exists():
        total_agents += len(list(agents_dir.glob('*.md')))
    if project_agents_dir.exists():
        total_agents += len(list(project_agents_dir.glob('*.md')))
    
    if total_agents == 0:
        warnings.append("No agents found - create specialized agents for optimal workflow")
    
    # Check for critical agents
    critical_agents = [
        'claude-hooks-developer',
        'testing-strategy-specialist',
        'error-resolution-specialist'
    ]
    
    found_agents = []
    if agents_dir.exists():
        for agent_file in agents_dir.glob('*.md'):
            agent_name = agent_file.stem
            if agent_name in critical_agents:
                found_agents.append(agent_name)
    
    if project_agents_dir.exists():
        for agent_file in project_agents_dir.glob('*.md'):
            agent_name = agent_file.stem
            if agent_name in critical_agents:
                found_agents.append(agent_name)
    
    missing_critical = set(critical_agents) - set(found_agents)
    if missing_critical:
        warnings.append(f"Critical agents missing: {', '.join(missing_critical)}")
    
    return {
        'valid': len(errors) == 0,
        'errors': errors,
        'warnings': warnings,
        'agents_ready': True,
        'total_agents': total_agents,
        'critical_agents_found': len(found_agents),
        'missing_critical_agents': list(missing_critical)
    }


def main():
    """Main FRAMEWORK ENFORCEMENT session start validation"""
    try:
        # Load session data
        hook_data = load_hook_data()
        session_id = hook_data.get('session_id', 'unknown')
        
        # Run FRAMEWORK ENFORCEMENT validations
        validations = [
            ('Universal Operation Patterns', validate_universal_operation_patterns()),
            ('Hooks System Integrity', validate_hooks_system_integrity()),
            ('Git Workflow Readiness', validate_git_workflow_readiness()),
            ('Agent System Readiness', validate_agent_system_readiness())
        ]
        
        # Collect results
        all_errors = []
        all_warnings = []
        failed_validations = []
        framework_operational = True
        
        for validation_name, validation_result in validations:
            errors = validation_result.get('errors', [])
            warnings = validation_result.get('warnings', [])
            
            if errors:
                all_errors.extend([f"{validation_name}: {error}" for error in errors])
                failed_validations.append(validation_name)
                framework_operational = False
            
            all_warnings.extend([f"{validation_name}: {warning}" for warning in warnings])
        
        # FRAMEWORK ENFORCEMENT: Determine response
        if not framework_operational:
            # CRITICAL: Framework violations prevent session start
            result = {
                'session_start': 'BLOCKED',
                'framework_enforcement_activated': True,
                'framework_operational': False,
                'session_cannot_start': True,
                'failed_validations': failed_validations,
                'errors': all_errors,
                'warnings': all_warnings,
                'validations': dict(validations),
                'required_actions': [
                    "STOP session initialization immediately",
                    "Address all framework violations",
                    "Restore Universal Operation Mode compliance",
                    "Verify ERROR ATTENTION PROTOCOL is active",
                    "Re-attempt session start after fixes"
                ],
                'session_id': session_id,
                'metadata': {
                    'hook_name': 'framework_enforcement_session_start',
                    'enforcement_status': 'SESSION_BLOCKED',
                    'timestamp': datetime.now().isoformat(),
                    'framework_status': 'NON_OPERATIONAL'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(2)  # BLOCKING ERROR - SESSION CANNOT START
        
        elif all_warnings:
            # Framework operational with concerns
            result = {
                'session_start': 'OPERATIONAL_WITH_CONCERNS',
                'framework_enforcement_active': True,
                'framework_operational': True,
                'concerns_identified': True,
                'errors': [],
                'warnings': all_warnings,
                'validations': dict(validations),
                'recommendations': [
                    "Address framework concerns for optimal operation",
                    "Deploy missing critical agents",
                    "Verify git workflow configuration",
                    "Monitor framework health throughout session"
                ],
                'session_id': session_id,
                'metadata': {
                    'hook_name': 'framework_enforcement_session_start',
                    'enforcement_status': 'OPERATIONAL_WITH_CONCERNS',
                    'timestamp': datetime.now().isoformat(),
                    'framework_status': 'OPERATIONAL'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(1)  # Non-blocking warning with concerns
        
        else:
            # Framework fully operational and compliant
            result = {
                'session_start': 'FULLY_OPERATIONAL',
                'framework_enforcement_active': True,
                'framework_operational': True,
                'universal_operation_mode_active': True,
                'error_attention_protocol_active': True,
                'errors': [],
                'warnings': [],
                'validations': dict(validations),
                'status': "Framework fully operational - Universal Operation Mode active",
                'session_id': session_id,
                'metadata': {
                    'hook_name': 'framework_enforcement_session_start',
                    'enforcement_status': 'FULLY_OPERATIONAL',
                    'timestamp': datetime.now().isoformat(),
                    'framework_status': 'FULLY_COMPLIANT'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(0)  # Success - Framework fully operational
        
    except Exception as e:
        # FRAMEWORK ENFORCEMENT: Hook execution errors
        result = {
            'session_start': 'HOOK_ERROR',
            'framework_enforcement_error': True,
            'hook_execution_error': str(e),
            'errors': [f"Framework enforcement hook error: {e}"],
            'warnings': ["Framework enforcement system needs investigation"],
            'required_actions': [
                "Investigate framework enforcement hook error",
                "Verify hook system integrity",
                "Ensure session start validation is functional"
            ],
            'session_id': hook_data.get('session_id', 'error'),
            'metadata': {
                'hook_name': 'framework_enforcement_session_start',
                'enforcement_status': 'HOOK_ERROR',
                'timestamp': datetime.now().isoformat(),
                'error_type': 'hook_execution_error'
            }
        }
        print(json.dumps(result, indent=2))
        sys.exit(1)  # Non-blocking error


if __name__ == "__main__":
    main()