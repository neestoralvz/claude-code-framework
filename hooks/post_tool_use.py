#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "json", "sys", "os", "datetime", "subprocess"]
# ///

"""
Claude Code Hook: PostToolUse

Automatic framework maintenance after tool execution including:
- Update system indices when files are modified
- Validate framework structure integrity
- Maintain git workflow consistency
- Update documentation references
- Cleanup and optimization tasks

Exit Codes:
- 0: Success, maintenance completed
- 1: Non-blocking warning, maintenance partially completed
- 2: Blocking error (reserved, not used in post-tool context)
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
                'event': 'post_tool_use',
                'source': 'claude_code',
                'tool': {
                    'name': 'unknown',
                    'parameters': {}
                },
                'result': {},
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
                'event': 'post_tool_use',
                'source': 'claude_code',
                'tool': {
                    'name': 'unknown',
                    'parameters': {}
                },
                'result': {},
                'timestamp': datetime.now().isoformat(),
                'input_source': 'empty'
            }
        
        # Try to parse as JSON
        data = json.loads(stdin_content)
        print(f"DEBUG: JSON parsed successfully, keys: {list(data.keys())}", file=sys.stderr)
        
        # Ensure required fields exist, add defaults if missing
        if 'event' not in data:
            print("DEBUG: Adding missing 'event' field", file=sys.stderr)
            data['event'] = 'post_tool_use'
        if 'source' not in data:
            data['source'] = 'claude_code'
        if 'tool' not in data:
            print("DEBUG: Adding missing 'tool' field", file=sys.stderr)
            data['tool'] = {
                'name': 'unknown',
                'parameters': {}
            }
        if 'result' not in data:
            data['result'] = {}
        if 'timestamp' not in data:
            data['timestamp'] = datetime.now().isoformat()
        
        data['input_source'] = 'json'
        return data
        
    except json.JSONDecodeError as e:
        # JSON parsing failed, create fallback data
        print(f"DEBUG: JSON parsing failed, using defaults: {e}", file=sys.stderr)
        return {
            'event': 'post_tool_use',
            'source': 'claude_code',
            'tool': {
                'name': 'unknown',
                'parameters': {}
            },
            'result': {},
            'timestamp': datetime.now().isoformat(),
            'input_error': str(e),
            'input_source': 'fallback'
        }
    except Exception as e:
        # Any other error, create fallback data
        print(f"DEBUG: Input processing failed, using defaults: {e}", file=sys.stderr)
        return {
            'event': 'post_tool_use',
            'source': 'claude_code',
            'tool': {
                'name': 'unknown',
                'parameters': {}
            },
            'result': {},
            'timestamp': datetime.now().isoformat(),
            'input_error': str(e),
            'input_source': 'fallback'
        }


def get_claude_directory():
    """Get the .claude directory path"""
    return Path.home() / '.claude'


def update_system_indices(modified_files):
    """Update system index files when framework files are modified"""
    claude_dir = get_claude_directory()
    system_dir = claude_dir / 'system'
    
    if not system_dir.exists():
        return []
    
    actions = []
    
    # Check if any system files were modified
    system_files_modified = any(
        str(system_dir) in file_path for file_path in modified_files
    )
    
    if system_files_modified:
        # Update main index if it exists
        index_file = system_dir / 'index.md'
        if index_file.exists():
            try:
                # Touch the index file to update its modification time
                index_file.touch()
                actions.append(f"Updated system index timestamp: {index_file}")
            except Exception as e:
                actions.append(f"Warning: Could not update index file: {e}")
        
        # Check for new files that need to be added to indices
        for subdir in ['principles', 'personalities', 'standards', 'processes', 'examples']:
            subdir_path = system_dir / subdir
            if subdir_path.exists():
                md_files = list(subdir_path.glob('*.md'))
                if md_files:
                    actions.append(f"Found {len(md_files)} files in {subdir}/")
    
    return actions


def validate_framework_structure():
    """Validate framework structure integrity"""
    claude_dir = get_claude_directory()
    validations = []
    warnings = []
    
    # Check essential framework files
    essential_files = [
        'CLAUDE.md',
        'system/index.md',
        'system/PRINCIPLES.md',
        'system/PERSONALITIES.md',
        'system/STANDARDS.md',
        'system/PROCESSES.md'
    ]
    
    for file_path in essential_files:
        full_path = claude_dir / file_path
        if full_path.exists():
            validations.append(f"✓ {file_path}")
        else:
            warnings.append(f"Missing essential file: {file_path}")
    
    # Check directory structure
    essential_dirs = [
        'system',
        'system/principles',
        'system/personalities', 
        'system/standards',
        'system/processes'
    ]
    
    for dir_path in essential_dirs:
        full_path = claude_dir / dir_path
        if full_path.exists():
            validations.append(f"✓ {dir_path}/")
        else:
            warnings.append(f"Missing directory: {dir_path}/")
    
    return validations, warnings


def maintain_git_workflow(tool_result):
    """Maintain git workflow consistency"""
    actions = []
    
    try:
        # Check if there are uncommitted changes
        result = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True, text=True, cwd=os.getcwd()
        )
        
        if result.returncode == 0 and result.stdout.strip():
            actions.append("Git status: Uncommitted changes detected")
            
            # Suggest git workflow based on Simple and Easy Framework
            actions.append("Reminder: Framework prefers automatic commit + push workflow")
        else:
            actions.append("Git status: Working directory clean")
            
    except Exception as e:
        actions.append(f"Git check failed: {e}")
    
    return actions


def cleanup_and_optimize():
    """Perform cleanup and optimization tasks"""
    actions = []
    claude_dir = get_claude_directory()
    
    # Check for old log files
    logs_dir = claude_dir / 'logs'
    if logs_dir.exists():
        log_files = list(logs_dir.glob('*.log'))
        large_logs = [f for f in log_files if f.stat().st_size > 10 * 1024 * 1024]  # > 10MB
        
        if large_logs:
            actions.append(f"Found {len(large_logs)} large log files (>10MB)")
    
    # Check for old shell snapshots
    snapshots_dir = claude_dir / 'shell-snapshots'
    if snapshots_dir.exists():
        snapshot_files = list(snapshots_dir.glob('*.sh'))
        if len(snapshot_files) > 50:
            actions.append(f"Found {len(snapshot_files)} shell snapshots (consider cleanup)")
    
    # Check hook files permissions
    hooks_dir = claude_dir / 'hooks'
    if hooks_dir.exists():
        hook_files = list(hooks_dir.glob('*.py'))
        for hook_file in hook_files:
            if not os.access(hook_file, os.X_OK):
                try:
                    hook_file.chmod(0o755)
                    actions.append(f"Made hook executable: {hook_file.name}")
                except Exception as e:
                    actions.append(f"Could not make {hook_file.name} executable: {e}")
    
    return actions


def update_documentation_references(modified_files):
    """Update documentation references when files are moved or renamed"""
    actions = []
    claude_dir = get_claude_directory()
    
    # Check for documentation files that might need reference updates
    md_files_modified = [f for f in modified_files if f.endswith('.md')]
    
    if md_files_modified:
        actions.append(f"Documentation files modified: {len(md_files_modified)}")
        
        # Check CLAUDE.md for broken references (basic check)
        claude_md = claude_dir / 'CLAUDE.md'
        if claude_md.exists():
            try:
                content = claude_md.read_text()
                # Count references to system files
                ref_count = content.count('system/')
                actions.append(f"CLAUDE.md contains {ref_count} system references")
            except Exception as e:
                actions.append(f"Could not validate CLAUDE.md references: {e}")
    
    return actions


def update_dashboard_metrics(hook_data):
    """Update dashboard metrics with hook execution data"""
    actions = []
    
    try:
        claude_dir = get_claude_directory()
        metrics_updater = claude_dir / 'system' / 'dashboard' / 'scripts' / 'update_dashboard_metrics.py'
        
        if metrics_updater.exists() and os.access(metrics_updater, os.X_OK):
            # Call the metrics updater script
            import sys
            import importlib.util
            
            # Load the metrics updater module
            spec = importlib.util.spec_from_file_location("dashboard_updater", metrics_updater)
            dashboard_updater = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(dashboard_updater)
            
            # Update metrics using the loaded module
            updater = dashboard_updater.DashboardMetricsUpdater()
            success = updater.update_from_hook_data(hook_data)
            
            if success:
                actions.append("✓ Dashboard metrics updated")
            else:
                actions.append("⚠ Dashboard metrics update failed")
        else:
            actions.append("Dashboard metrics updater not found or not executable")
            
    except Exception as e:
        actions.append(f"Dashboard metrics update error: {e}")
    
    return actions


def main():
    """Main hook execution"""
    try:
        # Load and validate input (now always returns data)
        hook_data = load_hook_data()
        
        tool_data = hook_data.get('tool', {})
        tool_result = hook_data.get('result', {})
        
        # Determine modified files from tool execution
        modified_files = []
        tool_name = tool_data.get('name', '')
        tool_params = tool_data.get('parameters', {})
        
        if tool_name in ['Edit', 'MultiEdit', 'Write']:
            file_path = tool_params.get('file_path', '')
            if file_path:
                modified_files.append(file_path)
        
        # Add modified files to hook data for metrics
        hook_data['modified_files'] = modified_files
        
        # Perform maintenance tasks
        maintenance_actions = []
        warnings = []
        
        # 1. Update system indices
        index_actions = update_system_indices(modified_files)
        maintenance_actions.extend(index_actions)
        
        # 2. Validate framework structure
        validations, structure_warnings = validate_framework_structure()
        maintenance_actions.extend(validations)
        warnings.extend(structure_warnings)
        
        # 3. Maintain git workflow
        git_actions = maintain_git_workflow(tool_result)
        maintenance_actions.extend(git_actions)
        
        # 4. Update documentation references
        doc_actions = update_documentation_references(modified_files)
        maintenance_actions.extend(doc_actions)
        
        # 5. Cleanup and optimize
        cleanup_actions = cleanup_and_optimize()
        maintenance_actions.extend(cleanup_actions)
        
        # 6. Update dashboard metrics
        hook_data['warnings'] = warnings  # Add warnings to hook data for metrics
        metrics_actions = update_dashboard_metrics(hook_data)
        maintenance_actions.extend(metrics_actions)
        
        # Generate result
        result = {
            'tool': tool_data,
            'maintenance_completed': True,
            'actions_taken': maintenance_actions,
            'warnings': warnings,
            'modified_files': modified_files,
            'metadata': {
                'hook_name': 'post_tool_use',
                'execution_time': datetime.now().isoformat(),
                'maintenance_success': len(warnings) == 0
            }
        }
        
        print(json.dumps(result, indent=2))
        
        # Exit with appropriate code
        if warnings:
            sys.exit(1)  # Non-blocking warning
        else:
            sys.exit(0)  # Success
        
    except Exception as e:
        print(f"Hook execution error: {e}", file=sys.stderr)
        
        # On error, still provide basic result
        result = {
            'tool': {
                'name': 'unknown',
                'parameters': {}
            },
            'maintenance_completed': False,
            'actions_taken': [],
            'warnings': [f"Hook error: {e}"],
            'modified_files': [],
            'metadata': {
                'hook_name': 'post_tool_use',
                'execution_time': datetime.now().isoformat(),
                'hook_error': True
            }
        }
        print(json.dumps(result, indent=2))
        sys.exit(1)  # Non-blocking error


if __name__ == "__main__":
    main()