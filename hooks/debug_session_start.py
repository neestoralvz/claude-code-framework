#!/usr/bin/env python3
"""
Debug version of session_start hook to capture actual Claude Code input
"""

import json
import sys
import os
from datetime import datetime

def debug_input():
    """Debug what Claude Code actually sends to the hook"""
    debug_info = {
        'timestamp': datetime.now().isoformat(),
        'stdin_available': not sys.stdin.isatty(),
        'stdin_content': None,
        'argv': sys.argv,
        'env_vars': {k: v for k, v in os.environ.items() if 'CLAUDE' in k.upper()},
        'working_directory': os.getcwd()
    }
    
    # Try to read from stdin
    try:
        if not sys.stdin.isatty():
            stdin_content = sys.stdin.read()
            debug_info['stdin_content'] = stdin_content
            debug_info['stdin_length'] = len(stdin_content)
            
            # Try to parse as JSON
            if stdin_content.strip():
                try:
                    parsed_json = json.loads(stdin_content)
                    debug_info['parsed_json'] = parsed_json
                except json.JSONDecodeError as e:
                    debug_info['json_parse_error'] = str(e)
            else:
                debug_info['stdin_empty'] = True
        else:
            debug_info['stdin_is_tty'] = True
    except Exception as e:
        debug_info['stdin_read_error'] = str(e)
    
    # Output debug information
    print(json.dumps(debug_info, indent=2))
    
    return debug_info

if __name__ == "__main__":
    debug_input()