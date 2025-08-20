# Claude Code Hooks - Simple and Easy Framework

This directory contains the complete Claude Code hooks implementation for the Simple and Easy Framework. These hooks provide automated workflow enhancement, validation, and maintenance.

## Hook Files

### Core Hooks

1. **user_prompt_submit.py** - Session Context Injection
   - Automatically injects framework status and context into user prompts
   - Provides personality recommendations based on prompt analysis
   - Includes git status, recent work, and task complexity detection
   - Exit codes: 0 (success), 1 (non-blocking error)

2. **pre_tool_use.py** - Workflow Validation  
   - Validates workflow before file modifications
   - Checks TodoWrite usage for multi-step tasks
   - Enforces Simple and Easy Framework principles
   - Security validation for file operations
   - Exit codes: 0 (success), 1 (warning), 2 (blocking error)

3. **post_tool_use.py** - Framework Maintenance
   - Automatic framework maintenance after tool execution
   - Updates system indices and validates structure
   - Maintains git workflow consistency
   - Cleanup and optimization tasks
   - Exit codes: 0 (success), 1 (warning)

4. **session_start.py** - Session Orientation
   - Provides comprehensive session orientation
   - Framework health check and recommendations
   - Git activity summary and working directory context
   - Available personalities and quick commands
   - Exit codes: 0 (success), 1 (warning)

### Configuration

- **config.json** - Hook configuration and metadata
- **README.md** - This documentation file

## Installation

The hooks are already installed and configured. To manually make them executable:

```bash
chmod +x /Users/nalve/.claude/hooks/*.py
```

## Security Features

- PEP 723 compliant Python scripts with embedded metadata
- Input validation and JSON parsing
- Path sanitization and security checks
- Timeout enforcement for hook execution
- Exit code validation and error handling

## Integration

These hooks integrate seamlessly with:
- Simple and Easy Framework principles
- TodoWrite task management
- Git workflow automation
- System documentation navigation
- Personality-based interaction styles

## Framework Compliance

All hooks follow the Simple and Easy Framework standards:
- Keep it simple, make it easy
- Evidence-based decision making
- Collaborative rather than autonomous execution
- User preference prioritization
- Fail-fast validation with clear diagnostics

## Troubleshooting

If hooks fail to execute:
1. Check file permissions (should be executable)
2. Verify Python environment has required dependencies
3. Review hook logs for specific error messages
4. Validate JSON input format for hook data

For hook development and testing, see the claude-hooks-developer, claude-hooks-tester, and claude-hooks-integrator agents in the /agents directory.