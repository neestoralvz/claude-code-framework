#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "json", "sys", "os", "datetime", "subprocess"]
# ///

"""
Claude Code Hook: SessionStart

Provides automatic session orientation including:
- Current framework status and recent work summary
- Available personalities and suggested usage
- Recent git activity and working directory status
- Framework health check and recommendations
- Quick access to system documentation

Exit Codes:
- 0: Success, session context provided
- 1: Non-blocking warning, partial context provided
- 2: Blocking error (reserved, not used in session start context)
"""

import json
import sys
import os
import subprocess
from pathlib import Path
from datetime import datetime, timedelta


def load_hook_data():
    """Load and validate hook data from stdin - fallback to defaults if no input"""
    try:
        # Check if stdin has data available
        if sys.stdin.isatty():
            # No input provided, use defaults
            print("DEBUG: No stdin input detected, using defaults", file=sys.stderr)
            return {
                'event': 'session_start',
                'source': 'claude_code',
                'timestamp': datetime.now().isoformat(),
                'input_source': 'default'
            }
        
        # Try to read from stdin
        stdin_content = sys.stdin.read().strip()
        print(f"DEBUG: Stdin content received: '{stdin_content[:100]}...'", file=sys.stderr)
        
        if not stdin_content:
            # Empty input, use defaults
            print("DEBUG: Empty stdin input, using defaults", file=sys.stderr)
            return {
                'event': 'session_start',
                'source': 'claude_code',
                'timestamp': datetime.now().isoformat(),
                'input_source': 'empty'
            }
        
        # Try to parse as JSON
        data = json.loads(stdin_content)
        print(f"DEBUG: JSON parsed successfully, keys: {list(data.keys())}", file=sys.stderr)
        
        # Ensure required fields exist, add defaults if missing
        if 'event' not in data:
            print("DEBUG: Adding missing 'event' field", file=sys.stderr)
            data['event'] = 'session_start'
        if 'source' not in data:
            data['source'] = 'claude_code'
        if 'timestamp' not in data:
            data['timestamp'] = datetime.now().isoformat()
        
        data['input_source'] = 'json'
        return data
        
    except json.JSONDecodeError as e:
        # JSON parsing failed, create fallback data
        print(f"DEBUG: JSON parsing failed, using defaults: {e}", file=sys.stderr)
        return {
            'event': 'session_start',
            'source': 'claude_code',
            'timestamp': datetime.now().isoformat(),
            'input_error': str(e),
            'input_source': 'fallback'
        }
    except Exception as e:
        # Any other error, create fallback data
        print(f"DEBUG: Input processing failed, using defaults: {e}", file=sys.stderr)
        return {
            'event': 'session_start',
            'source': 'claude_code',
            'timestamp': datetime.now().isoformat(),
            'input_error': str(e),
            'input_source': 'fallback'
        }


def get_git_activity():
    """Get recent git activity and status"""
    try:
        # Get current branch
        branch_result = subprocess.run(
            ['git', 'branch', '--show-current'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        current_branch = branch_result.stdout.strip() if branch_result.returncode == 0 else "unknown"
        
        # Get recent commits (last 24 hours)
        yesterday = (datetime.now() - timedelta(days=1)).strftime('%Y-%m-%d')
        log_result = subprocess.run(
            ['git', 'log', '--oneline', '--since', yesterday],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        recent_commits = log_result.stdout.strip() if log_result.returncode == 0 else ""
        
        # Get git status
        status_result = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        changes = status_result.stdout.strip() if status_result.returncode == 0 else ""
        
        # Get last commit info
        last_commit_result = subprocess.run(
            ['git', 'log', '-1', '--pretty=format:%h %s (%cr)'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        last_commit = last_commit_result.stdout.strip() if last_commit_result.returncode == 0 else "No commits"
        
        return {
            'branch': current_branch,
            'recent_commits_24h': recent_commits,
            'uncommitted_changes': bool(changes),
            'status_details': changes,
            'last_commit': last_commit,
            'commits_today': len(recent_commits.split('\n')) if recent_commits else 0
        }
    except Exception as e:
        return {
            'branch': 'unknown',
            'recent_commits_24h': '',
            'uncommitted_changes': False,
            'status_details': '',
            'last_commit': f'Git info unavailable: {e}',
            'commits_today': 0
        }


def check_framework_health():
    """Check framework health and integrity"""
    claude_dir = Path.home() / '.claude'
    health_status = {
        'overall': 'healthy',
        'issues': [],
        'recommendations': [],
        'components': {}
    }
    
    # Check essential files
    essential_files = {
        'CLAUDE.md': 'Main framework configuration',
        'system/index.md': 'System navigation hub',
        'system/PRINCIPLES.md': 'Decision-making guidelines',
        'system/PERSONALITIES.md': 'Interaction styles',
        'system/STANDARDS.md': 'Implementation standards',
        'system/PROCESSES.md': 'Workflow processes'
    }
    
    for file_path, description in essential_files.items():
        full_path = claude_dir / file_path
        if full_path.exists():
            health_status['components'][file_path] = 'present'
        else:
            health_status['components'][file_path] = 'missing'
            health_status['issues'].append(f"Missing {description}: {file_path}")
            health_status['overall'] = 'degraded'
    
    # Check hooks directory
    hooks_dir = claude_dir / 'hooks'
    if hooks_dir.exists():
        hook_files = list(hooks_dir.glob('*.py'))
        health_status['components']['hooks'] = f'{len(hook_files)} hooks found'
        
        # Check if hooks are executable
        non_executable = [f for f in hook_files if not os.access(f, os.X_OK)]
        if non_executable:
            health_status['recommendations'].append(
                f"Make {len(non_executable)} hook files executable"
            )
    else:
        health_status['components']['hooks'] = 'missing'
        health_status['recommendations'].append("Create hooks directory for automation")
    
    # Check for agent files
    agents_dir = claude_dir / 'agents'
    if agents_dir.exists():
        agent_files = list(agents_dir.glob('*.md'))
        health_status['components']['agents'] = f'{len(agent_files)} agents available'
    else:
        health_status['components']['agents'] = 'no agents directory'
    
    # Overall health assessment
    if len(health_status['issues']) > 2:
        health_status['overall'] = 'needs_attention'
    
    return health_status


def get_available_personalities():
    """Get available personalities and their usage contexts"""
    personalities = [
        {
            'name': '🎭 Strategic Orchestrator',
            'context': 'Complex planning, agent coordination, system-wide decisions',
            'trigger': 'planning OR coordination OR strategy'
        },
        {
            'name': '🛡️ System Guardian',
            'context': 'Protecting framework integrity, validation, quality assurance',
            'trigger': 'validation OR security OR quality'
        },
        {
            'name': '🤝 Collaborative Partner',
            'context': 'Exploring ideas, brainstorming, complex problem-solving',
            'trigger': 'exploration OR brainstorming OR discussion'
        },
        {
            'name': '🚀 Action-Oriented Assistant',
            'context': 'Efficient execution, direct results, focused task completion',
            'trigger': 'efficiency OR execution OR focused tasks'
        },
        {
            'name': '🔍 Research Specialist',
            'context': 'Deep investigation, comprehensive analysis, information synthesis',
            'trigger': 'research OR investigation OR analysis'
        },
        {
            'name': '🧠 Deep Thinker',
            'context': 'Complex problems, philosophical questions, systematic reasoning',
            'trigger': 'complex problems OR philosophical questions'
        },
        {
            'name': '📚 Knowledge Curator',
            'context': 'Organizing information, documentation, knowledge management',
            'trigger': 'organization OR documentation OR structure'
        }
    ]
    
    return personalities


def get_working_directory_context():
    """Get working directory context and project information"""
    cwd = Path.cwd()
    context = {
        'current_directory': str(cwd),
        'directory_name': cwd.name,
        'is_git_repo': False,
        'project_type': 'unknown',
        'recent_files': []
    }
    
    # Check if it's a git repository
    if (cwd / '.git').exists():
        context['is_git_repo'] = True
    
    # Detect project type
    if (cwd / 'package.json').exists():
        context['project_type'] = 'Node.js'
    elif (cwd / 'requirements.txt').exists() or (cwd / 'pyproject.toml').exists():
        context['project_type'] = 'Python'
    elif (cwd / 'Cargo.toml').exists():
        context['project_type'] = 'Rust'
    elif (cwd / 'go.mod').exists():
        context['project_type'] = 'Go'
    elif (cwd / '.claude').exists():
        context['project_type'] = 'Claude Framework'
    
    # Get recently modified files (last 24 hours)
    try:
        yesterday = datetime.now() - timedelta(days=1)
        recent_files = []
        
        for file_path in cwd.rglob('*'):
            if file_path.is_file() and file_path.stat().st_mtime > yesterday.timestamp():
                # Skip hidden files and common build/cache directories
                if not any(part.startswith('.') for part in file_path.parts):
                    if not any(ignore in str(file_path) for ignore in ['node_modules', '__pycache__', 'target', '.git']):
                        recent_files.append(str(file_path.relative_to(cwd)))
        
        context['recent_files'] = recent_files[:10]  # Limit to 10 most recent
    except Exception:
        context['recent_files'] = []
    
    return context


def generate_session_orientation(hook_data=None):
    """Generate comprehensive session orientation"""
    orientation = {
        'timestamp': datetime.now().isoformat(),
        'git_activity': get_git_activity(),
        'framework_health': check_framework_health(),
        'personalities': get_available_personalities(),
        'working_directory': get_working_directory_context(),
        'quick_commands': [
            "READ system/index.md - Navigate framework documentation",
            "USE TodoWrite for multi-step tasks",
            "CHECK git status before major changes", 
            "FOLLOW Simple and Easy Framework principles",
            "CHOOSE appropriate personality for task context"
        ]
    }
    
    # Add hook data information if available
    if hook_data:
        orientation['hook_data'] = {
            'event': hook_data.get('event', 'unknown'),
            'source': hook_data.get('source', 'unknown'),
            'has_input_error': 'input_error' in hook_data
        }
        if 'input_error' in hook_data:
            orientation['hook_data']['input_error'] = hook_data['input_error']
    
    return orientation


def format_orientation_message(orientation):
    """Format orientation data into a user-friendly message"""
    lines = []
    
    # Header
    lines.append("🚀 SESSION STARTED")
    lines.append("=" * 50)
    
    # Working Directory Status
    wd = orientation['working_directory']
    lines.append(f"📍 Working Directory: {wd['directory_name']}")
    lines.append(f"   Type: {wd['project_type']}")
    if wd['recent_files']:
        lines.append(f"   Recent Activity: {len(wd['recent_files'])} files modified (24h)")
    
    # Git Status
    git = orientation['git_activity']
    lines.append(f"🔧 Git Status: Branch '{git['branch']}'")
    lines.append(f"   Last Commit: {git['last_commit']}")
    if git['uncommitted_changes']:
        lines.append("   ⚠️  Uncommitted changes present")
    if git['commits_today'] > 0:
        lines.append(f"   📈 {git['commits_today']} commits today")
    
    # Framework Health
    health = orientation['framework_health']
    lines.append(f"🛡️  Framework Health: {health['overall'].upper()}")
    if health['issues']:
        lines.append("   Issues:")
        for issue in health['issues']:
            lines.append(f"     • {issue}")
    if health['recommendations']:
        lines.append("   Recommendations:")
        for rec in health['recommendations']:
            lines.append(f"     • {rec}")
    
    # Available Personalities
    lines.append("🎭 Available Personalities:")
    for personality in orientation['personalities']:
        lines.append(f"   {personality['name']}")
        lines.append(f"     Use for: {personality['context']}")
    
    # Hook Information (if available)
    if 'hook_data' in orientation:
        hook_info = orientation['hook_data']
        lines.append(f"🔗 Hook Status: Event '{hook_info['event']}' from {hook_info['source']}")
        if hook_info['has_input_error']:
            lines.append(f"   ⚠️  Input processing issue: {hook_info.get('input_error', 'Unknown error')}")
    
    # Quick Commands
    lines.append("⚡ Quick Commands:")
    for command in orientation['quick_commands']:
        lines.append(f"   • {command}")
    
    lines.append("=" * 50)
    lines.append("Ready to collaborate! What would you like to work on?")
    
    return "\n".join(lines)


def main():
    """Main hook execution"""
    try:
        # Load and validate input (now always returns data)
        hook_data = load_hook_data()
        
        # Generate session orientation
        orientation = generate_session_orientation(hook_data)
        
        # Format message for display
        orientation_message = format_orientation_message(orientation)
        
        # Create result
        result = {
            'session_started': True,
            'orientation_data': orientation,
            'display_message': orientation_message,
            'metadata': {
                'hook_name': 'session_start',
                'execution_time': datetime.now().isoformat(),
                'framework_status': orientation['framework_health']['overall']
            }
        }
        
        print(json.dumps(result, indent=2))
        
        # Determine exit code based on framework health
        health_status = orientation['framework_health']['overall']
        if health_status == 'needs_attention':
            sys.exit(1)  # Non-blocking warning
        else:
            sys.exit(0)  # Success
        
    except Exception as e:
        print(f"Hook execution error: {e}", file=sys.stderr)
        
        # Provide minimal fallback orientation
        fallback_result = {
            'session_started': True,
            'orientation_data': {
                'timestamp': datetime.now().isoformat(),
                'error': str(e)
            },
            'display_message': f"🚀 SESSION STARTED\n\nHook error occurred: {e}\n\nContinuing with basic session...",
            'metadata': {
                'hook_name': 'session_start',
                'execution_time': datetime.now().isoformat(),
                'hook_error': True
            }
        }
        
        print(json.dumps(fallback_result, indent=2))
        sys.exit(1)  # Non-blocking error


if __name__ == "__main__":
    main()