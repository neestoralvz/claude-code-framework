
[Previous: Study link-action-verbs.md for action standards](link-action-verbs.md) | [Return to hub for navigation](../../philosophy/index.md) | [Review PRINCIPLES.md for framework](../principles/PRINCIPLES.md) | [Next: Apply link-validation-tools.md for testing](link-validation-tools.md)

# LINK USE CASES COMPONENT

## Table of Contents
- [Purpose](#purpose)
- [Architecture](#architecture)
- [Available Components](#available-components)
- [Usage Guidelines](#usage-guidelines)
- [Implementation Guide](#implementation-guide)
- [Benefits](#benefits)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Purpose

⏺ **Principle**: This component implements [communication.md](../../../principles/communication.md) clarity standards by defining purpose patterns that help users understand link objectives and context.

Establish standardized use case patterns that make link purposes immediately clear to users.

## Purpose Indicators

### "to [achieve goal]"
- **Example**: `[Read CLAUDE.md to initialize system](../../../../CLAUDE.md)`
- **Usage**: When link serves specific objective

### "for [specific purpose]"
- **Example**: `[Apply workflow.md#validation for verification](workflow.md#validation)`
- **Usage**: When link provides particular function

### "when [condition]"
- **Example**: `[Deploy project-optimizer.md when performance issues arise](../../../../agents/project-management/coordination/project-optimizer.md)`
- **Usage**: When link applies to specific situations

## Context Patterns

### Initial Understanding
- **Pattern**: "to understand", "for overview", "to learn"
- **Examples**:
  - `[Read CLAUDE.md to understand system initialization](../../../../CLAUDE.md)`
  - `[Study PRINCIPLES.md for framework overview](principles/PRINCIPLES.md)`
  - `[Browse commands index to learn available tools](../../philosophy/index.md)`

### Implementation
- **Pattern**: "for implementation", "to apply", "for execution"
- **Examples**:
  - `[Apply workflow.md#validation for implementation](workflow.md#validation)`
  - `[Execute analyze-file.md to examine code](../commands/analyze-file.md)`
  - `[Deploy project-optimizer.md for execution](../../../../agents/project-management/coordination/project-optimizer.md)`

### Reference
- **Pattern**: "for details", "for complete information", "for specification"
- **Examples**:
  - `[Review fundamental.md#evidence for complete requirements](fundamental.md#evidence)`
  - `[Study formatting.md for detailed specifications](../../../principles/formatting.md)`
  - `[Access engineering.md#testing for full details](engineering.md#testing)`

### Navigation
- **Pattern**: "for central access", "for overview", "for options"
- **Examples**:
  - `[Navigate to Documentation Hub for central access](../../philosophy/index.md)`
  - `[Browse agents directory for available options](../../philosophy/index.md)`
  - `[Access commands index for tool overview](../../philosophy/index.md)`

## Examples

### Correct Examples with Heading References
```markdown
[Apply workflow.md#clarification for request confirmation](workflow.md#1-clarification)
[Follow engineering.md#testing for validation standards](engineering.md#testing)
[Review fundamental.md#evidence for proof requirements](fundamental.md#evidence)
[Execute workflow.md#validation for verification](workflow.md#7-validation)
[Study organization.md#structure for content hierarchy](organization.md#structure)
```

### Correct Examples without Heading References
```markdown
[Read CLAUDE.md to initialize system](../../../../CLAUDE.md)
[Study PRINCIPLES.md for complete framework](principles/PRINCIPLES.md)
[Browse commands index for available tools](../../philosophy/index.md)
[Navigate to Documentation Hub for central access](../../philosophy/index.md)
[Deploy project-optimizer.md for comprehensive analysis](../../../../agents/project-management/coordination/project-optimizer.md)
```

### Incorrect Examples
```markdown
❌ [CLAUDE.md](../../../../CLAUDE.md) - Missing action and use case
❌ [Click here](../../../../CLAUDE.md) - Vague action, no use case
❌ [Documentation](../../philosophy/index.md) - No action or use case
❌ [See workflow](../../../principles/workflow.md) - Weak action, unclear purpose
❌ [More info](details.md) - Non-imperative, vague
```

[⬆ Return to top](#link-use-cases-component)

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../../philosophy/index.md)
- [Study link-format-standards.md for format rules](link-format-standards.md)
- [Apply link-action-verbs.md for action standards](link-action-verbs.md)
- [Follow link-validation-tools.md for testing](link-validation-tools.md)

### Related Principles
- [Apply communication.md for clarity requirements](../../../principles/communication.md)
- [Follow formatting.md for consistency standards](../../../principles/formatting.md)

[⬆ Return to top](#link-use-cases-component)
