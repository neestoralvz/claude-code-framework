#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "json", "sys", "os", "datetime", "subprocess"]
# ///

"""
Claude Code Hook: UserPromptSubmit

Automatically injects session context into user prompts including:
- Current framework status and recent work
- Available personalities and when to use them  
- Relevant system documentation references
- Progressive thinking reminders for complex tasks

Exit Codes:
- 0: Success, continue with modified prompt
- 1: Non-blocking error, continue with original prompt
- 2: Blocking error, stop execution
"""

import json
import sys
import os
import subprocess
from pathlib import Path
from datetime import datetime


def load_hook_data():
    """Load and validate hook data from stdin - fallback to defaults if no input"""
    try:
        # Check if stdin has data available
        if sys.stdin.isatty():
            # No input provided, use defaults
            print("DEBUG: No stdin input detected, using defaults", file=sys.stderr)
            return {
                'event': 'user_prompt_submit',
                'prompt': 'Hello! How can I help you today?',
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
                'event': 'user_prompt_submit',
                'prompt': 'Hello! How can I help you today?',
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
            data['event'] = 'user_prompt_submit'
        if 'prompt' not in data:
            print("DEBUG: Adding missing 'prompt' field", file=sys.stderr)
            data['prompt'] = 'Hello! How can I help you today?'
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
            'event': 'user_prompt_submit',
            'prompt': 'Hello! How can I help you today?',
            'source': 'claude_code',
            'timestamp': datetime.now().isoformat(),
            'input_error': str(e),
            'input_source': 'fallback'
        }
    except Exception as e:
        # Any other error, create fallback data
        print(f"DEBUG: Input processing failed, using defaults: {e}", file=sys.stderr)
        return {
            'event': 'user_prompt_submit',
            'prompt': 'Hello! How can I help you today?',
            'source': 'claude_code',
            'timestamp': datetime.now().isoformat(),
            'input_error': str(e),
            'input_source': 'fallback'
        }


def get_git_status():
    """Get current git status and recent commits"""
    try:
        # Get current branch
        branch_result = subprocess.run(
            ['git', 'branch', '--show-current'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        current_branch = branch_result.stdout.strip() if branch_result.returncode == 0 else "unknown"
        
        # Get recent commits
        log_result = subprocess.run(
            ['git', 'log', '--oneline', '-5'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        recent_commits = log_result.stdout.strip() if log_result.returncode == 0 else "No commits found"
        
        # Get git status
        status_result = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        changes = status_result.stdout.strip() if status_result.returncode == 0 else ""
        
        return {
            'branch': current_branch,
            'recent_commits': recent_commits,
            'has_changes': bool(changes),
            'status': changes
        }
    except Exception:
        return {'branch': 'unknown', 'recent_commits': 'Unable to get git info', 'has_changes': False, 'status': ''}


def get_framework_context():
    """Get current framework status and available resources"""
    claude_dir = Path.home() / '.claude'
    
    context = {
        'timestamp': datetime.now().isoformat(),
        'working_directory': str(Path.cwd()),
        'claude_directory': str(claude_dir)
    }
    
    # Check for system documentation
    system_dir = claude_dir / 'system'
    if system_dir.exists():
        context['system_docs'] = {
            'principles': (system_dir / 'PRINCIPLES.md').exists(),
            'personalities': (system_dir / 'PERSONALITIES.md').exists(),
            'standards': (system_dir / 'STANDARDS.md').exists(),
            'processes': (system_dir / 'PROCESSES.md').exists(),
            'examples': (system_dir / 'EXAMPLES.md').exists()
        }
    
    # Check for existing agents
    agents_dir = claude_dir / 'agents'
    if agents_dir.exists():
        context['available_agents'] = [
            f.stem for f in agents_dir.glob('*.md') if f.is_file()
        ]
    
    # Add git context
    context['git'] = get_git_status()
    
    return context


def detect_task_complexity(prompt):
    """Analyze prompt to determine if TodoWrite should be recommended"""
    complexity_indicators = [
        'create', 'build', 'implement', 'develop', 'design',
        'multiple', 'several', 'steps', 'phases', 'workflow',
        'system', 'framework', 'complete', 'comprehensive',
        'integrate', 'coordinate', 'manage', 'organize'
    ]
    
    prompt_lower = prompt.lower()
    complexity_score = sum(1 for indicator in complexity_indicators if indicator in prompt_lower)
    
    # Check for numbered lists or comma-separated tasks
    has_multiple_tasks = (',' in prompt and len(prompt.split(',')) > 2) or any(
        f"{i}." in prompt for i in range(1, 6)
    )
    
    return complexity_score >= 3 or has_multiple_tasks


def generate_context_injection(original_prompt, framework_context):
    """Generate context to inject into the user prompt"""
    
    context_sections = []
    
    # Framework status
    if framework_context.get('system_docs'):
        docs = framework_context['system_docs']
        available_docs = [doc for doc, exists in docs.items() if exists]
        if available_docs:
            context_sections.append(
                f"📚 Available System Documentation: {', '.join(available_docs)}"
            )
    
    # Git status
    git_info = framework_context.get('git', {})
    if git_info.get('branch'):
        git_status = f"🔧 Git Status: Branch '{git_info['branch']}'"
        if git_info.get('has_changes'):
            git_status += " (uncommitted changes)"
        context_sections.append(git_status)
    
    # Recent work context
    if git_info.get('recent_commits'):
        context_sections.append(f"📋 Recent Work:\n{git_info['recent_commits']}")
    
    # Task complexity detection
    if detect_task_complexity(original_prompt):
        context_sections.append(
            "💡 Task Complexity Detected: Consider using TodoWrite for multi-step tasks"
        )
    
    # Personality recommendations based on prompt analysis
    prompt_lower = original_prompt.lower()
    personality_hints = []
    
    if any(word in prompt_lower for word in ['plan', 'coordinate', 'organize', 'strategy']):
        personality_hints.append("🎭 Strategic Orchestrator for planning and coordination")
    
    if any(word in prompt_lower for word in ['validate', 'check', 'verify', 'test', 'secure']):
        personality_hints.append("🛡️ System Guardian for validation and quality assurance")
    
    if any(word in prompt_lower for word in ['explore', 'brainstorm', 'discuss', 'think about']):
        personality_hints.append("🤝 Collaborative Partner for exploration and discussion")
    
    if any(word in prompt_lower for word in ['research', 'investigate', 'analyze', 'study']):
        personality_hints.append("🔍 Research Specialist for deep investigation")
    
    if any(word in prompt_lower for word in ['document', 'organize', 'structure', 'catalog']):
        personality_hints.append("📚 Knowledge Curator for documentation and organization")
    
    if personality_hints:
        context_sections.append("🎯 Suggested Personalities:\n" + "\n".join(f"  • {hint}" for hint in personality_hints))
    
    # Framework reminders
    framework_reminders = [
        "🔄 Remember: Use TodoWrite for tasks with 2+ steps",
        "📖 Quick Reference: READ system/index.md for navigation",
        "⚡ Keep it simple, make it easy"
    ]
    context_sections.append("Framework Reminders:\n" + "\n".join(f"  • {reminder}" for reminder in framework_reminders))
    
    if not context_sections:
        return original_prompt
    
    # Inject context at the beginning of the prompt
    context_injection = "\n".join(context_sections)
    
    return f"""SESSION CONTEXT:
{context_injection}

---

USER REQUEST:
{original_prompt}"""


def main():
    """Main hook execution"""
    try:
        # Load and validate input (now always returns data)
        hook_data = load_hook_data()
        
        # Get framework context
        framework_context = get_framework_context()
        
        # Generate enhanced prompt
        original_prompt = hook_data['prompt']
        enhanced_prompt = generate_context_injection(original_prompt, framework_context)
        
        # Output modified hook data
        result = hook_data.copy()
        result['prompt'] = enhanced_prompt
        result['metadata'] = {
            'hook_name': 'user_prompt_submit',
            'modified': True,
            'context_injected': True,
            'framework_context': framework_context,
            'input_source': hook_data.get('input_source', 'unknown')
        }
        
        # Add input error info if present
        if 'input_error' in hook_data:
            result['metadata']['input_error'] = hook_data['input_error']
        
        print(json.dumps(result, indent=2))
        
        # Exit with appropriate code based on input quality
        if hook_data.get('input_source') in ['fallback', 'default', 'empty']:
            sys.exit(1)  # Non-blocking warning - input issues but hook worked
        else:
            sys.exit(0)  # Success - normal operation
        
    except Exception as e:
        print(f"Hook execution error: {e}", file=sys.stderr)
        
        # Provide minimal fallback result
        fallback_result = {
            'event': 'user_prompt_submit',
            'prompt': f'Hello! How can I help you today?\n\n(Note: Hook encountered error: {e})',
            'source': 'claude_code',
            'timestamp': datetime.now().isoformat(),
            'metadata': {
                'hook_name': 'user_prompt_submit',
                'modified': False,
                'context_injected': False,
                'hook_error': True,
                'error_message': str(e)
            }
        }
        
        print(json.dumps(fallback_result, indent=2))
        sys.exit(1)  # Non-blocking error


if __name__ == "__main__":
    main()