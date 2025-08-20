#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "json", "sys", "os", "subprocess"]
# ///

"""
Claude Code Hook: PreToolUse

Validates workflow before file modifications including:
- Check TodoWrite usage for multi-step tasks
- Verify git status before major changes
- Validate file modification patterns
- Enforce Simple and Easy Framework principles

Exit Codes:
- 0: Success, continue with tool execution
- 1: Non-blocking warning, continue with tool execution  
- 2: Blocking error, prevent tool execution
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
                'event': 'pre_tool_use',
                'source': 'claude_code',
                'tool': {
                    'name': 'unknown',
                    'parameters': {}
                },
                'conversation_context': '',
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
                'event': 'pre_tool_use',
                'source': 'claude_code',
                'tool': {
                    'name': 'unknown',
                    'parameters': {}
                },
                'conversation_context': '',
                'timestamp': datetime.now().isoformat(),
                'input_source': 'empty'
            }
        
        # Try to parse as JSON
        data = json.loads(stdin_content)
        print(f"DEBUG: JSON parsed successfully, keys: {list(data.keys())}", file=sys.stderr)
        
        # Ensure required fields exist, add defaults if missing
        if 'event' not in data:
            print("DEBUG: Adding missing 'event' field", file=sys.stderr)
            data['event'] = 'pre_tool_use'
        if 'source' not in data:
            data['source'] = 'claude_code'
        if 'tool' not in data:
            print("DEBUG: Adding missing 'tool' field", file=sys.stderr)
            data['tool'] = {
                'name': 'unknown',
                'parameters': {}
            }
        if 'conversation_context' not in data:
            data['conversation_context'] = ''
        if 'timestamp' not in data:
            data['timestamp'] = datetime.now().isoformat()
        
        data['input_source'] = 'json'
        return data
        
    except json.JSONDecodeError as e:
        # JSON parsing failed, create fallback data
        print(f"DEBUG: JSON parsing failed, using defaults: {e}", file=sys.stderr)
        return {
            'event': 'pre_tool_use',
            'source': 'claude_code',
            'tool': {
                'name': 'unknown',
                'parameters': {}
            },
            'conversation_context': '',
            'timestamp': datetime.now().isoformat(),
            'input_error': str(e),
            'input_source': 'fallback'
        }
    except Exception as e:
        # Any other error, create fallback data
        print(f"DEBUG: Input processing failed, using defaults: {e}", file=sys.stderr)
        return {
            'event': 'pre_tool_use',
            'source': 'claude_code',
            'tool': {
                'name': 'unknown',
                'parameters': {}
            },
            'conversation_context': '',
            'timestamp': datetime.now().isoformat(),
            'input_error': str(e),
            'input_source': 'fallback'
        }


def get_git_status():
    """Get current git status"""
    try:
        result = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        return result.stdout.strip() if result.returncode == 0 else ""
    except Exception:
        return ""


def validate_file_modification_tools(tool_data):
    """Validate tools that modify files"""
    tool_name = tool_data.get('name', '')
    tool_params = tool_data.get('parameters', {})
    
    file_modification_tools = ['Edit', 'MultiEdit', 'Write']
    if tool_name not in file_modification_tools:
        return {'valid': True, 'warnings': [], 'errors': []}
    
    warnings = []
    errors = []
    
    # Check for file paths
    file_path = tool_params.get('file_path', '')
    
    # Validate absolute paths
    if file_path and not os.path.isabs(file_path):
        errors.append(f"File path must be absolute, got: {file_path}")
    
    # Check for dangerous file modifications
    dangerous_patterns = [
        '/etc/', '/usr/', '/System/', '/bin/', '/sbin/'
    ]
    if file_path and any(pattern in file_path for pattern in dangerous_patterns):
        errors.append(f"Dangerous file modification attempted: {file_path}")
    
    # For Write tool, check if overwriting existing files
    if tool_name == 'Write' and file_path:
        if os.path.exists(file_path):
            warnings.append(f"Write tool will overwrite existing file: {file_path}")
    
    # Check for framework file modifications
    claude_dir = str(Path.home() / '.claude')
    if file_path and file_path.startswith(claude_dir):
        if '/system/' in file_path:
            warnings.append("Modifying system framework files - ensure this is intentional")
    
    return {'valid': len(errors) == 0, 'warnings': warnings, 'errors': errors}


def validate_todo_workflow(tool_data, conversation_context):
    """Check if TodoWrite should be used for complex tasks"""
    tool_name = tool_data.get('name', '')
    
    # Skip validation for non-action tools
    non_action_tools = ['Read', 'LS', 'Glob', 'Grep', 'WebSearch']
    if tool_name in non_action_tools:
        return {'valid': True, 'warnings': [], 'errors': []}
    
    warnings = []
    
    # Check if this is part of a multi-step process
    file_modification_tools = ['Edit', 'MultiEdit', 'Write']
    if tool_name in file_modification_tools:
        # Check if TodoWrite was mentioned in recent context
        context_str = str(conversation_context).lower()
        has_todo_mention = 'todowrite' in context_str or 'todo' in context_str
        
        if not has_todo_mention:
            warnings.append(
                "Multi-step file modifications detected. Consider using TodoWrite for task tracking."
            )
    
    return {'valid': True, 'warnings': warnings, 'errors': []}


def validate_framework_principles(tool_data):
    """Validate adherence to Simple and Easy Framework principles"""
    tool_name = tool_data.get('name', '')
    tool_params = tool_data.get('parameters', {})
    
    warnings = []
    errors = []
    
    # Check for unnecessary file creation
    if tool_name == 'Write':
        file_path = tool_params.get('file_path', '')
        if file_path:
            # Check for documentation file creation
            if file_path.endswith('.md') and 'README' in file_path.upper():
                warnings.append(
                    "Framework principle: Avoid creating documentation files unless explicitly requested"
                )
            
            # Check for new file creation vs editing existing
            if not os.path.exists(file_path):
                warnings.append(
                    "Framework principle: Prefer editing existing files over creating new ones"
                )
    
    # Validate content for emojis (if content is available)
    if tool_name in ['Write', 'Edit', 'MultiEdit']:
        content_fields = ['content', 'new_string']
        for field in content_fields:
            content = tool_params.get(field, '')
            if content and any(ord(char) > 127 for char in content):
                # Simple emoji detection
                warnings.append(
                    "Framework principle: Avoid emojis unless explicitly requested"
                )
                break
    
    return {'valid': len(errors) == 0, 'warnings': warnings, 'errors': errors}


def validate_security_practices(tool_data):
    """Validate security best practices"""
    tool_name = tool_data.get('name', '')
    tool_params = tool_data.get('parameters', {})
    
    warnings = []
    errors = []
    
    # Check for command execution in file content
    if tool_name in ['Write', 'Edit', 'MultiEdit']:
        content_fields = ['content', 'new_string']
        dangerous_patterns = ['subprocess.', 'os.system', 'eval(', 'exec(', '__import__']
        
        for field in content_fields:
            content = tool_params.get(field, '')
            if content:
                for pattern in dangerous_patterns:
                    if pattern in content:
                        warnings.append(f"Potentially dangerous code pattern detected: {pattern}")
    
    # Check file permissions and ownership
    file_path = tool_params.get('file_path', '')
    if file_path and os.path.exists(file_path):
        try:
            stat_info = os.stat(file_path)
            # Check if file is executable
            if stat_info.st_mode & 0o111:
                warnings.append(f"Modifying executable file: {file_path}")
        except Exception:
            pass  # Ignore permission errors
    
    return {'valid': len(errors) == 0, 'warnings': warnings, 'errors': errors}


def main():
    """Main hook execution"""
    try:
        # Load and validate input (now always returns data)
        hook_data = load_hook_data()
        
        tool_data = hook_data.get('tool', {})
        conversation_context = hook_data.get('conversation_context', '')
        
        # Run all validations
        validations = [
            validate_file_modification_tools(tool_data),
            validate_todo_workflow(tool_data, conversation_context),
            validate_framework_principles(tool_data),
            validate_security_practices(tool_data)
        ]
        
        # Collect all warnings and errors
        all_warnings = []
        all_errors = []
        
        for validation in validations:
            all_warnings.extend(validation.get('warnings', []))
            all_errors.extend(validation.get('errors', []))
        
        # Determine exit code
        if all_errors:
            # Blocking errors - prevent execution
            result = {
                'allowed': False,
                'errors': all_errors,
                'warnings': all_warnings,
                'tool': tool_data,
                'metadata': {
                    'hook_name': 'pre_tool_use',
                    'validation_failed': True,
                    'git_status': get_git_status()
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(2)  # Blocking error
        
        elif all_warnings:
            # Non-blocking warnings - continue with warnings
            result = {
                'allowed': True,
                'errors': [],
                'warnings': all_warnings,
                'tool': tool_data,
                'metadata': {
                    'hook_name': 'pre_tool_use',
                    'warnings_present': True,
                    'git_status': get_git_status()
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(1)  # Non-blocking warning
        
        else:
            # All validations passed
            result = {
                'allowed': True,
                'errors': [],
                'warnings': [],
                'tool': tool_data,
                'metadata': {
                    'hook_name': 'pre_tool_use',
                    'validation_passed': True,
                    'git_status': get_git_status()
                }
            }
            print(json.dumps(result, indent=2))
            sys.exit(0)  # Success
        
    except Exception as e:
        print(f"Hook execution error: {e}", file=sys.stderr)
        # On error, allow execution to continue
        result = {
            'allowed': True,
            'errors': [f"Hook error: {e}"],
            'warnings': [],
            'tool': {
                'name': 'unknown',
                'parameters': {}
            },
            'metadata': {
                'hook_name': 'pre_tool_use',
                'hook_error': True,
                'execution_time': datetime.now().isoformat()
            }
        }
        print(json.dumps(result, indent=2))
        sys.exit(1)  # Non-blocking error


if __name__ == "__main__":
    main()