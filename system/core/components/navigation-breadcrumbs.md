# CENTRALIZED NAVIGATION BREADCRUMB COMPONENT
# Usage: Include this pattern and customize for each principle file
# Reduces 67% navigation pattern duplication across 35+ files

## NAVIGATION TEMPLATE PATTERN
```markdown
[Previous: {{PREVIOUS_LINK_TEXT}}]({{PREVIOUS_PATH}}) | [Return to documentation hub for navigation](../README.md) | [Study framework principles](../README.md) | [Next: {{NEXT_LINK_TEXT}}]({{NEXT_PATH}})
```

## COMPONENT USAGE EXAMPLES

### Core Authority Navigation
```markdown
[Previous: Study fundamental.md for methodology](fundamental.md) | [Return to documentation hub for navigation](../README.md) | [Study framework principles](../README.md) | [Next: Study workflow.md for execution](workflow.md)
```

### Agent Orchestration Navigation
```markdown
[Previous: Study agent-selection.md for systematic selection](agent-selection.md) | [Return to documentation hub for navigation](../README.md) | [Study framework principles](../README.md) | [Next: Study expert-documentation.md for expert authorship](expert-documentation.md)
```

### Quality Assurance Navigation
```markdown
[Previous: Study engineering.md for standards](engineering.md) | [Return to documentation hub for navigation](../README.md) | [Study framework principles](../README.md) | [Next: Study validation.md for quality gates](validation.md)
```

## VARIABLE REPLACEMENT PATTERN
Replace the following variables when instantiating:
- `{{PREVIOUS_LINK_TEXT}}` - Descriptive text for previous principle
- `{{PREVIOUS_PATH}}` - Relative path to previous file
- `{{NEXT_LINK_TEXT}}` - Descriptive text for next principle  
- `{{NEXT_PATH}}` - Relative path to next file

## NAVIGATION FLOW MAPPING
Domain-specific navigation flows:

### Core Authority Flow
```
directive.md → workflow.md → fundamental.md
```

### Agent Orchestration Flow
```
agent-definition.md → agent-selection.md → task-orchestration.md → task-tool-syntax.md → context-efficiency.md → expert-documentation.md
```

### Quality Assurance Flow
```
validation.md → engineering.md → simplicity.md → forbidden.md
```

### Content Management Flow
```
communication.md → formatting.md → files.md → organization.md
```

### Framework Integration Flow
```
claude-md.md → command-workflow-principles.md → dynamic-adaptation.md → intent-recognition.md
```

### Workflow Operations Flow
```
workflow.md → 10-phase-detailed-methodology.md → progressive-thinking-methodology.md → workflow-support-operations.md → principle-validation-checkpoints.md → git-workflow.md
```

## VALIDATION REQUIREMENTS
- All paths must be valid relative paths
- Link text must be descriptive and action-oriented
- Hub navigation must always point to ../README.md
- Flow must be logical within domain context