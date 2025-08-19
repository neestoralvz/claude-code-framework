---
title: "Naming Conventions Component"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../../principles/formatting.md", "../../principles/communication.md"]
purpose: "Define comprehensive naming conventions for files, directories, and entities across platforms"
---

[Previous: Study formatting.md for overview](../../principles/formatting.md) | [Return to hub for navigation](../../index.md) | [Review PRINCIPLES.md for framework](../../PRINCIPLES.md) | [Next: Apply link-standards.md for connections](link-standards.md)

# NAMING CONVENTIONS COMPONENT

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

⏺ **Principle**: This component implements [formatting.md](../../principles/formatting.md) naming standards to ensure clarity, maintainability, and cross-platform compatibility throughout the system.

Define comprehensive naming conventions that ensure consistent, clear, and maintainable file and entity naming across all system components.

## File Naming Patterns

⏺ **Detailed Patterns**: [Read file-naming-patterns.md for specific type rules](file-naming-patterns.md)

Essential patterns overview:
- **Documents**: `{TOPIC}-{subtopic}.md` - CAPS for main topics, kebab-case for subtopics
- **Agents**: `{name}-{type}.md` - All kebab-case
- **Commands**: `{action}-{object}.md` - All kebab-case
- **Tickets**: `{CODE}-{###}-{title-slug}.md` - Prefix-number-title

## Case Conventions by Context

⏺ **Detailed Conventions**: [Read case-conventions.md for specific context rules](case-conventions.md)

Essential conventions overview:
- **kebab-case**: File names, agent names, URLs (`lowercase-with-hyphens`)
- **camelCase**: JavaScript functions, variables (`firstWordLowercaseRestCapitalized`)
- **PascalCase**: Classes, Components (`EachWordCapitalized`)
- **snake_case**: Python variables, database fields (`lowercase_with_underscores`)
- **SCREAMING_SNAKE_CASE**: Constants, environment variables (`UPPERCASE_WITH_UNDERSCORES`)

## Directory Naming

### System Directories
- **Pattern**: `{function}/` 
- **Rule**: Single word describing function
- **Examples**: `docs/`, `agents/`, `commands/`, `scripts/`

### Subdirectories
- **Pattern**: `{category}/`
- **Rule**: Descriptive category in kebab-case if multi-word
- **Examples**: `components/`, `formatting/`, `ticket-status/`

## Special Cases

### CLAUDE.md Files
- **Pattern**: `CLAUDE.md`
- **Rule**: Always uppercase, exact name
- **Purpose**: Global configuration authority

### System Files
- **Pattern**: `{SYSTEM_NAME}.md`
- **Rule**: CAPS for system-level importance
- **Examples**: `PRINCIPLES.md`, `PROJECT_STRUCTURE.md`

## Validation Rules

### Pre-Naming Checklist
1. **Character check**: Only use safe cross-platform characters
2. **Length check**: Keep under 100 characters
3. **Convention check**: Follow appropriate case convention
4. **Uniqueness check**: No name conflicts in directory

## Cross-Platform Compatibility

⏺ **Detailed Compatibility**: [Read cross-platform-compatibility.md for specific rules](cross-platform-compatibility.md)

Essential compatibility rules:
- **Avoid**: Special characters that break on any platform
- **Prefer**: ASCII letters, numbers, hyphens, underscores, dots
- **Limit**: Keep filenames under 100 characters
- **Consistency**: Treat all systems as case-sensitive

## Cross-References

### Primary Navigation
- [Return to formatting.md](../../principles/formatting.md)
- [Browse hub for overview](../../index.md)
- [Review PRINCIPLES.md for framework](../../PRINCIPLES.md)

### Related Principles
- [Apply communication.md for clarity](../../principles/communication.md)
- [Follow engineering.md for standards](../../principles/engineering.md)

### Related Components
- [Study link-standards.md for connections](link-standards.md)
- [Apply code-block-standards.md for examples](code-block-standards.md)

[⬆ Return to top](#naming-conventions-component)