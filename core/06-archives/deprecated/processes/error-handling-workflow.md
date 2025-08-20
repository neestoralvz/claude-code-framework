
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Error Handling Workflow

**Context**: Workflow process defining procedural steps and execution patterns


How to deploy specialized agents to systematically handle errors when they occur.

**MANDATORY**: All error handling must be performed through agent deployment. Never attempt direct error resolution.

## When Something Goes Wrong

**Deploy error-capture-specialist** to document the error:

**Agent Instructions**: "Capture error details for [error/issue]:
- Document what was being attempted
- Record exact input that caused the problem
- Capture complete error message and stack trace
- Note system state when error occurred"

## Error Analysis Process

**Deploy debugging-specialist** to analyze the error:

**Agent Instructions**: "Analyze [error] to determine:
- Error type: validation, resource, configuration, or other
- Root cause analysis
- Check for similar past errors and resolutions
- Identify error category and appropriate fix strategy"

## Recovery Strategies

**Deploy recovery-specialist** to implement appropriate fix:

**Agent Instructions**: "Implement recovery for [error type]:
- Validation errors: Fix input data and retry
- Missing resources: Create or locate required resources
- Configuration problems: Verify settings and dependencies
- Unexpected errors: Research and apply specific solutions"

## Prevention Planning

**Deploy prevention-specialist** to implement safeguards:

**Agent Instructions**: "Create prevention measures for [error]:
- Add validation checks to catch errors early
- Improve error messages for clarity
- Update documentation with troubleshooting steps
- Implement defensive coding practices"

## Documentation

**Deploy documentation-specialist** to capture learnings:

**Agent Instructions**: "Document error resolution for [error]:
- Record what went wrong
- Document fix applied
- List prevention measures implemented
- Create knowledge base entry for future reference"

---
