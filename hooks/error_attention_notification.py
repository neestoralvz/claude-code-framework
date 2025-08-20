#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "json", "sys", "os", "subprocess", "re"]
# ///

"""
Claude Code Hook: ERROR ATTENTION PROTOCOL - Notification Handler

MISSION CRITICAL: Zero Error Tolerance Enforcement - Error Response System

This hook implements the ERROR ATTENTION PROTOCOL for notification handling:
- NEVER normalize errors → Every error triggers immediate attention and resolution
- IMMEDIATE AGENT DEPLOYMENT → Deploy error-resolution agents on notifications
- ZERO ERROR TOLERANCE → No error is acceptable or normal  
- AUTOMATIC ERROR RESPONSE → Deploy specialized agents for error resolution

Exit Codes:
- 0: Success, notification processed and agents deployed if needed
- 1: Non-blocking warning, notification processed with concerns
- 2: BLOCKING ERROR, critical notification requires immediate attention
"""

import json
import sys
import os
import subprocess
import re
from pathlib import Path
from datetime import datetime


def load_hook_data():
    """Load and validate notification data"""
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
    """Create default notification data structure"""
    return {
        'event': 'notification',
        'source': 'claude_code',
        'notification': {
            'type': 'unknown',
            'message': '',
            'level': 'info'
        },
        'timestamp': datetime.now().isoformat(),
        'input_source': reason,
        'error_attention_active': True
    }


def create_error_data(error_type, error_msg):
    """Create error data requiring immediate attention"""
    return {
        'event': 'notification',
        'source': 'claude_code',
        'notification': {
            'type': 'error',
            'message': error_msg,
            'level': 'critical'
        },
        'timestamp': datetime.now().isoformat(),
        'input_error': error_msg,
        'error_type': error_type,
        'input_source': 'error_fallback',
        'error_attention_required': True,
        'immediate_agent_deployment_needed': True
    }


def validate_and_enhance_data(data):
    """Validate and enhance notification data"""
    required_fields = ['event', 'source', 'notification', 'timestamp']
    
    for field in required_fields:
        if field not in data:
            if field == 'notification':
                data[field] = {'type': 'unknown', 'message': '', 'level': 'info'}
            elif field == 'timestamp':
                data[field] = datetime.now().isoformat()
            else:
                data[field] = '' if field != 'event' else 'notification'
    
    data['error_attention_active'] = True
    data['input_source'] = 'validated_json'
    return data


def analyze_notification_severity(notification_data):
    """ERROR ATTENTION PROTOCOL: Analyze notification severity"""
    notification_type = notification_data.get('type', '').lower()
    message = notification_data.get('message', '').lower()
    level = notification_data.get('level', '').lower()
    
    # Critical error patterns requiring immediate attention
    critical_patterns = [
        'error', 'exception', 'failed', 'failure', 'crash', 'critical',
        'timeout', 'permission denied', 'access denied', 'not found',
        'syntax error', 'runtime error', 'segmentation fault', 'traceback'
    ]
    
    # Framework violation patterns
    framework_violation_patterns = [
        'framework violation', 'context7 bypass', 'agent not deployed',
        'direct work detected', 'compliance issue', 'protocol violation'
    ]
    
    # Warning patterns requiring attention
    warning_patterns = [
        'warning', 'deprecated', 'outdated', 'insecure', 'vulnerable',
        'performance', 'memory', 'disk space', 'rate limit'
    ]
    
    analysis = {
        'severity_level': 'info',
        'requires_immediate_attention': False,
        'requires_agent_deployment': False,
        'agent_types_needed': [],
        'blocking_required': False,
        'patterns_detected': []
    }
    
    # Check for critical patterns
    for pattern in critical_patterns:
        if pattern in message or pattern in notification_type:
            analysis['patterns_detected'].append(pattern)
            analysis['severity_level'] = 'critical'
            analysis['requires_immediate_attention'] = True
            analysis['requires_agent_deployment'] = True
            analysis['blocking_required'] = True
    
    # Check for framework violations
    for pattern in framework_violation_patterns:
        if pattern in message:
            analysis['patterns_detected'].append(f"framework_violation: {pattern}")
            analysis['severity_level'] = 'critical'
            analysis['requires_immediate_attention'] = True
            analysis['requires_agent_deployment'] = True
            analysis['blocking_required'] = True
            analysis['agent_types_needed'].append('framework-compliance-specialist')
    
    # Check for warning patterns
    if analysis['severity_level'] == 'info':
        for pattern in warning_patterns:
            if pattern in message or pattern in notification_type:
                analysis['patterns_detected'].append(pattern)
                analysis['severity_level'] = 'warning'
                analysis['requires_agent_deployment'] = True
    
    # Determine required agents based on notification content
    agent_mapping = {
        'error': 'error-resolution-specialist',
        'test': 'testing-strategy-specialist',
        'security': 'security-specialist',
        'performance': 'performance-specialist',
        'hook': 'claude-hooks-developer',
        'git': 'git-workflow-specialist',
        'framework': 'framework-compliance-specialist'
    }
    
    for keyword, agent in agent_mapping.items():
        if keyword in message or keyword in notification_type:
            if agent not in analysis['agent_types_needed']:
                analysis['agent_types_needed'].append(agent)
    
    return analysis


def deploy_automatic_error_response_agents(severity_analysis):
    """ERROR ATTENTION PROTOCOL: Automatically deploy response agents"""
    deployment_plan = {
        'agents_to_deploy': [],
        'deployment_instructions': [],
        'priority_level': 'normal',
        'immediate_actions': []
    }
    
    if severity_analysis['requires_agent_deployment']:
        deployment_plan['priority_level'] = 'high' if severity_analysis['severity_level'] == 'critical' else 'normal'
        
        # Add required agents
        for agent_type in severity_analysis['agent_types_needed']:
            deployment_plan['agents_to_deploy'].append({
                'agent_type': agent_type,
                'priority': 'immediate' if severity_analysis['requires_immediate_attention'] else 'normal',
                'specialization': f"Handle {severity_analysis['severity_level']} level notifications"
            })
        
        # Generate deployment instructions
        if severity_analysis['blocking_required']:
            deployment_plan['immediate_actions'].append("STOP all current operations")
            deployment_plan['immediate_actions'].append("Deploy error-resolution specialists immediately")
        
        deployment_plan['deployment_instructions'] = [
            f"Deploy {len(deployment_plan['agents_to_deploy'])} specialized agents",
            f"Severity level: {severity_analysis['severity_level']}",
            f"Patterns detected: {', '.join(severity_analysis['patterns_detected'][:3])}",
            "Coordinate agent responses for comprehensive error resolution"
        ]
        
        if severity_analysis['requires_immediate_attention']:
            deployment_plan['immediate_actions'].append("Escalate to ERROR ATTENTION PROTOCOL")
            deployment_plan['immediate_actions'].append("Document error patterns for prevention")
    
    return deployment_plan


def create_agent_deployment_manifest(deployment_plan, notification_data):
    """Create manifest for automatic agent deployment"""
    manifest = {
        'deployment_type': 'automatic_error_response',
        'trigger_event': 'notification',
        'trigger_data': notification_data,
        'timestamp': datetime.now().isoformat(),
        'agents': [],
        'coordination_strategy': 'parallel_specialized_response'
    }
    
    # Generate agent specifications
    for agent_spec in deployment_plan['agents_to_deploy']:
        agent_manifest = {
            'agent_type': agent_spec['agent_type'],
            'priority': agent_spec['priority'],
            'specialization': agent_spec['specialization'],
            'deployment_method': 'task_tool_invocation',
            'expected_outcome': f"Resolve {notification_data.get('notification', {}).get('level', 'unknown')} level issue",
            'integration_points': ['error_attention_protocol', 'universal_operation_mode']
        }
        manifest['agents'].append(agent_manifest)
    
    return manifest


def log_error_attention_activity(notification_data, severity_analysis, deployment_plan):
    """Log ERROR ATTENTION PROTOCOL activity for analysis"""
    try:
        log_dir = Path.home() / '.claude' / 'work' / 'error_attention_logs'
        log_dir.mkdir(parents=True, exist_ok=True)
        
        log_entry = {
            'timestamp': datetime.now().isoformat(),
            'event_type': 'notification_processed',
            'notification': notification_data,
            'severity_analysis': severity_analysis,
            'deployment_plan': deployment_plan,
            'protocol_status': 'active',
            'attention_level': severity_analysis['severity_level']
        }
        
        log_file = log_dir / f"error_attention_{datetime.now().strftime('%Y%m%d')}.jsonl"
        with open(log_file, 'a') as f:
            f.write(json.dumps(log_entry) + '\n')
            
    except Exception as e:
        # Don't fail on logging errors
        print(f"DEBUG: Error logging failed: {e}", file=sys.stderr)


def main():
    """Main ERROR ATTENTION PROTOCOL notification handler"""
    try:
        # Load and validate input
        hook_data = load_hook_data()
        notification_data = hook_data.get('notification', {})
        
        # Analyze notification severity
        severity_analysis = analyze_notification_severity(notification_data)
        
        # Create automatic error response deployment plan
        deployment_plan = deploy_automatic_error_response_agents(severity_analysis)
        
        # Create agent deployment manifest
        agent_manifest = create_agent_deployment_manifest(deployment_plan, notification_data)
        
        # Log ERROR ATTENTION PROTOCOL activity
        log_error_attention_activity(notification_data, severity_analysis, deployment_plan)
        
        # ERROR ATTENTION PROTOCOL: Determine response
        if severity_analysis['blocking_required']:
            # CRITICAL: Blocking errors require immediate attention and agent deployment
            result = {
                'notification_processing': 'BLOCKED',
                'error_attention_protocol_activated': True,
                'immediate_attention_required': True,
                'automatic_agent_deployment_triggered': True,
                'severity_analysis': severity_analysis,
                'deployment_plan': deployment_plan,
                'agent_manifest': agent_manifest,
                'required_actions': [
                    "STOP all current operations immediately",
                    "Deploy error-resolution specialists now",
                    "Address critical notification before continuing",
                    "Implement ERROR ATTENTION PROTOCOL procedures"
                ],
                'notification': notification_data,
                'metadata': {
                    'hook_name': 'error_attention_notification',
                    'protocol_status': 'CRITICAL_RESPONSE_ACTIVATED',
                    'timestamp': datetime.now().isoformat(),
                    'attention_level': 'CRITICAL',
                    'agents_deployed': len(deployment_plan['agents_to_deploy'])
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(2)  # BLOCKING ERROR - IMMEDIATE AGENT DEPLOYMENT REQUIRED
        
        elif severity_analysis['requires_agent_deployment']:
            # Agent deployment recommended for error resolution
            result = {
                'notification_processing': 'AGENT_DEPLOYMENT_RECOMMENDED',
                'error_attention_protocol_active': True,
                'automatic_agent_deployment_triggered': True,
                'severity_analysis': severity_analysis,
                'deployment_plan': deployment_plan,
                'agent_manifest': agent_manifest,
                'recommendations': [
                    "Deploy specialized agents for error resolution",
                    "Monitor error patterns for prevention",
                    "Follow ERROR ATTENTION PROTOCOL procedures",
                    "Document resolution approach for future reference"
                ],
                'notification': notification_data,
                'metadata': {
                    'hook_name': 'error_attention_notification',
                    'protocol_status': 'AGENT_DEPLOYMENT_RECOMMENDED',
                    'timestamp': datetime.now().isoformat(),
                    'attention_level': severity_analysis['severity_level'].upper(),
                    'agents_recommended': len(deployment_plan['agents_to_deploy'])
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(1)  # Non-blocking warning with agent deployment
        
        else:
            # Notification processed successfully
            result = {
                'notification_processing': 'SUCCESS',
                'error_attention_protocol_active': True,
                'notification_analyzed': True,
                'severity_analysis': severity_analysis,
                'status': "Notification processed with ERROR ATTENTION PROTOCOL monitoring",
                'notification': notification_data,
                'metadata': {
                    'hook_name': 'error_attention_notification',
                    'protocol_status': 'MONITORING_ACTIVE',
                    'timestamp': datetime.now().isoformat(),
                    'attention_level': 'NONE'
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(0)  # Success - Notification processed
        
    except Exception as e:
        # ERROR ATTENTION PROTOCOL: Hook execution errors require attention
        result = {
            'notification_processing': 'HOOK_ERROR',
            'error_attention_protocol_error': True,
            'hook_execution_error': str(e),
            'errors': [f"Notification hook execution error: {e}"],
            'warnings': ["ERROR ATTENTION PROTOCOL: Hook error requires investigation"],
            'required_actions': [
                "Investigate notification hook execution error",
                "Verify hook system integrity",
                "Ensure notification handling system is functional"
            ],
            'notification': hook_data.get('notification', {}),
            'metadata': {
                'hook_name': 'error_attention_notification',
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