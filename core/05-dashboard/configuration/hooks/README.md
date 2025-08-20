# Claude Code Hooks System

This directory contains hook scripts that integrate with Claude Code's workflow automation system to enforce proper agent usage and validate user interactions.

## Overview

The hooks system uses PEP 723 compliant Python scripts that process JSON input from stdin and provide structured output for Claude Code event handling.

## Configuration

Hook configuration is managed in `config.json`:

```json
{
  "hooks": {
    "user_prompt_submit": [
      {
        "name": "agent_enforcer",
        "script": "user_prompt_agent_enforcer.py",
        "enabled": true,
        "description": "Enforces agent usage for implementation requests"
      }
    ]
  },
  "global_settings": {
    "timeout_seconds": 30,
    "max_retries": 3,
    "log_level": "INFO"
  }
}
```

## Available Hooks

### user_prompt_agent_enforcer.py

**Event**: `user_prompt_submit`  
**Purpose**: Enforces the usage of specialized agents for implementation requests

**Behavior**:
- Detects implementation keywords in user prompts (both Spanish and English)
- Injects mandatory agent usage message when implementation requests are detected
- Allows prompts that already mention Task tool or agents to pass through
- Returns exit code 0 (allow with message injection)

**Keywords Detected**:
- Spanish: crear, implementar, generar, escribir código, desarrollar, construir, hacer, programar, codificar, realizar
- English: create, implement, generate, write code, develop, build, make, program, code, write, construct, design, setup, configure, deploy, install

**Input Format**:
```json
{
  "prompt": "User prompt text here"
}
```

**Output Format** (when enforcement is applied):
```json
{
  "prompt": "Original prompt + enforcement message",
  "metadata": {
    "agent_enforcement_applied": true,
    "original_prompt": "Original user prompt",
    "hook_version": "1.0"
  }
}
```

## Exit Codes

Hook scripts use the following exit code conventions:
- `0`: Success (allow with potential modifications)
- `1`: Non-blocking error (allow but log error)
- `2`: Blocking error (prevent submission)

## Testing

### Manual Testing

Use the provided test scripts:

```bash
# Run comprehensive tests
python3 test_agent_enforcer.py

# Run manual validation
python3 manual_test.py

# Validate hook functions directly
python3 validate_hook.py
```

### Test Cases

The hook is tested with various prompt patterns:

**Should trigger enforcement**:
- "Crear una función para calcular la suma"
- "Implement a sorting algorithm"
- "Generate a Python script"
- "Write code to handle API requests"

**Should NOT trigger enforcement**:
- "What is the difference between lists and tuples?"
- "Use Task tool with data-processing-agent"
- "Deploy agent for this specialized task"
- "How does the agent framework work?"

## Development Guidelines

### Hook Structure

All hooks should follow this pattern:

```python
#!/usr/bin/env python3
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///

"""Hook description and purpose"""

import json
import sys

def load_json_from_stdin():
    """Load and validate JSON from stdin"""
    # Implementation

def main():
    """Main hook execution"""
    try:
        data = load_json_from_stdin()
        # Process data
        print(json.dumps(result))
        sys.exit(0)
    except Exception as e:
        print(f"ERROR: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
```

### Security Considerations

- Always validate input JSON structure
- Use subprocess with proper timeout handling for external commands
- Sanitize any user input before processing
- Never execute arbitrary code from user prompts
- Log security-relevant events appropriately

### Performance Requirements

- Hooks must complete within 30 seconds (configurable timeout)
- Minimize external dependencies
- Use efficient string matching algorithms
- Handle large prompts gracefully

## Integration

Hooks integrate with Claude Code's event lifecycle:

1. User submits prompt
2. `user_prompt_submit` event triggers
3. Configured hooks execute in sequence
4. Hook output modifies or blocks submission
5. Modified prompt continues to Claude processing

## Troubleshooting

### Common Issues

1. **Hook not executing**: Check `config.json` syntax and hook file permissions
2. **JSON parsing errors**: Validate input data structure
3. **Timeout errors**: Optimize hook performance or increase timeout
4. **Import errors**: Verify Python path and dependencies

### Debugging

Enable debug logging by setting `log_level: "DEBUG"` in `config.json`.

View hook execution logs in Claude Code system logs.

## Contributing

When adding new hooks:

1. Follow PEP 723 format for metadata
2. Include comprehensive tests
3. Document all parameters and exit codes
4. Update this README with hook descriptions
5. Validate security implications

---

This hooks system ensures that Claude Code conversations properly utilize the agent framework for implementation tasks, maintaining consistency and quality across all interactions.