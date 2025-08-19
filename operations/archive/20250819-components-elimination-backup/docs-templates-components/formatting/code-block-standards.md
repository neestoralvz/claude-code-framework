
[Previous: Study link-standards.md for connection formats](link-standards.md) | [Return to hub for navigation](../../philosophy/index.md) | [Review PRINCIPLES.md for framework](../principles/PRINCIPLES.md) | [Next: Browse formatting components index](../)

# CODE BLOCK STANDARDS COMPONENT

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

⏺ **Principle**: This component implements [formatting.md](../../../principles/formatting.md) documentation standards by defining clear distinctions between executable code and documentation examples to prevent confusion.

Establish clear standards for code block usage to distinguish between executable scripts, documentation examples, and language-specific code samples.

## Documentation Standards

### Critical Rule
- **NEVER use bash code blocks for documentation content**
- **ALWAYS use markdown code blocks for documentation examples**
- Bash blocks are reserved for executable scripts only
- Use `markdown` language specification for documentation examples

### Correct Documentation Examples
```markdown
# Use markdown blocks for documentation formatting examples
[Execute command.md for task completion](command.md)

## Section Headers
Use ## for main sections and ### for subsections
```

### Incorrect Documentation Examples
```bash
# WRONG: Never use bash blocks for documentation examples
[Navigate to file.md](file.md)
```

## Language-Specific Blocks

⏺ **Detailed Language Specs**: [Read language-specific-blocks.md for complete specifications](language-specific-blocks.md)

Essential block types:
- **Bash**: Executable commands and scripts only
- **Markdown**: Documentation format demonstrations
- **YAML**: Configuration files and metadata
- **JavaScript/Python**: Code implementations
- **JSON**: Data structures and API responses

## Usage Guidelines

⏺ **Detailed Usage Rules**: [Read block-usage-guidelines.md for selection criteria](block-usage-guidelines.md)

Key selection rules:
- **Commands to execute**: Use `bash` blocks
- **Documentation examples**: Use `markdown` blocks
- **Code implementations**: Use appropriate language blocks
- **Configuration files**: Use `yaml` or `json` blocks

## Validation Rules

### Pre-Publishing Checklist
1. **Block type matches content purpose**
2. **Language specification is accurate**
3. **No bash blocks used for documentation**
4. **All code blocks have proper syntax highlighting**

### Automated Validation
```bash
# Check for improper bash block usage in documentation
grep -n "```bash" docs/ | grep -v "executable"
```

## Common Patterns

### Template Documentation Pattern
```markdown
# Document structure example
[Action + purpose](path#section)
```

### Script Documentation Pattern
```bash
# Executable command example
find . -name "*.md" -exec wc -l {} \;
```

### Configuration Pattern
```yaml
# Configuration structure example
title: "Component Name"
dependencies: ["file1.md"]
```

## Cross-References

### Primary Navigation
- [Return to formatting.md](../../../principles/formatting.md)
- [Browse hub for overview](../../philosophy/index.md)
- [Review PRINCIPLES.md for framework](../principles/PRINCIPLES.md)

### Related Principles
- [Apply communication.md for clarity](../../../principles/communication.md)
- [Follow engineering.md for standards](../../../principles/engineering.md)

### Related Components
- [Study link-standards.md for connections](link-standards.md)
- [Apply naming-conventions.md for consistency](naming-conventions.md)

[⬆ Return to top](#code-block-standards-component)
