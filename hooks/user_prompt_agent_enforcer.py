#!/usr/bin/env python3
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///

"""
Claude Code Hook: User Prompt Agent Enforcer

This hook enforces the usage of specialized agents for implementation requests
to ensure the agent framework is properly utilized instead of direct implementation.

Event: user_prompt_submit
Exit Codes:
- 0: Allow with potential message injection
- 2: Block submission (not used in this implementation)
"""

import json
import sys
import re
from typing import Dict, Any, List


def load_json_from_stdin() -> Dict[str, Any]:
    """Load and validate JSON data from stdin."""
    try:
        data = json.load(sys.stdin)
        if not isinstance(data, dict):
            raise ValueError("Input must be a JSON object")
        return data
    except json.JSONDecodeError as e:
        print(f"ERROR: Invalid JSON input: {e}", file=sys.stderr)
        sys.exit(1)
    except ValueError as e:
        print(f"ERROR: {e}", file=sys.stderr)
        sys.exit(1)


def get_implementation_keywords() -> List[str]:
    """Return keywords that indicate implementation requests."""
    return [
        # Spanish keywords
        'crear', 'implementar', 'generar', 'escribir código', 'desarrollar',
        'construir', 'hacer', 'programar', 'codificar', 'realizar',
        
        # English keywords
        'create', 'implement', 'generate', 'write code', 'develop',
        'build', 'make', 'program', 'code', 'write', 'construct',
        'design', 'setup', 'configure', 'deploy', 'install'
    ]


def contains_implementation_request(prompt: str) -> bool:
    """
    Check if the prompt contains implementation-related keywords.
    
    Args:
        prompt: The user prompt text to analyze
        
    Returns:
        bool: True if implementation keywords are detected
    """
    if not prompt:
        return False
    
    # Convert to lowercase for case-insensitive matching
    prompt_lower = prompt.lower()
    keywords = get_implementation_keywords()
    
    # Check for exact word matches to avoid false positives
    for keyword in keywords:
        # Use word boundaries to match complete words
        pattern = r'\b' + re.escape(keyword) + r'\b'
        if re.search(pattern, prompt_lower):
            return True
    
    return False


def should_enforce_agents(data: Dict[str, Any]) -> bool:
    """
    Determine if agent enforcement should be triggered.
    
    Args:
        data: The hook input data
        
    Returns:
        bool: True if agents should be enforced
    """
    prompt = data.get('prompt', '')
    
    # Skip enforcement if prompt already mentions Task tool or agents
    if 'task tool' in prompt.lower() or 'agent' in prompt.lower():
        return False
    
    # Check for implementation keywords
    return contains_implementation_request(prompt)


def create_enforcement_message() -> str:
    """Create the mandatory agent usage message."""
    return (
        "MANDATORY: Must use Task tool with appropriate specialized agents. "
        "No direct implementation allowed. Deploy specialized agents for "
        "specialized tasks according to the agent framework requirements."
    )


def main():
    """Main hook execution function."""
    try:
        # Load input data from stdin
        data = load_json_from_stdin()
        
        # Check if we should enforce agent usage
        if should_enforce_agents(data):
            # Create enforcement message
            enforcement_msg = create_enforcement_message()
            
            # Output the modified prompt data with enforcement message
            modified_data = {
                "prompt": data.get('prompt', '') + '\n\n' + enforcement_msg,
                "metadata": {
                    "agent_enforcement_applied": True,
                    "original_prompt": data.get('prompt', ''),
                    "hook_version": "1.0"
                }
            }
            
            print(json.dumps(modified_data, indent=2))
        else:
            # Pass through unchanged
            print(json.dumps(data, indent=2))
        
        # Exit with success code (allow submission)
        sys.exit(0)
        
    except Exception as e:
        print(f"ERROR: Hook execution failed: {e}", file=sys.stderr)
        # Exit with non-blocking error code
        sys.exit(1)


if __name__ == "__main__":
    main()