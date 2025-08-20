#!/usr/bin/env python3
# /// script
# dependencies = ["pathlib", "os", "stat"]
# ///

"""
Hook Executable Permission Setup

Makes all ERROR ATTENTION PROTOCOL hooks executable for Claude Code integration.
"""

import os
import stat
from pathlib import Path

def main():
    hooks_dir = Path.home() / '.claude' / 'hooks'
    
    error_attention_hooks = [
        'error_attention_pre_tool_use.py',
        'error_attention_post_tool_use.py', 
        'error_attention_user_prompt_submit.py',
        'error_attention_notification.py'
    ]
    
    for hook_file in error_attention_hooks:
        hook_path = hooks_dir / hook_file
        if hook_path.exists():
            # Make executable
            current_mode = hook_path.stat().st_mode
            hook_path.chmod(current_mode | stat.S_IEXEC)
            print(f"Made executable: {hook_path}")
        else:
            print(f"Hook not found: {hook_path}")

if __name__ == "__main__":
    main()