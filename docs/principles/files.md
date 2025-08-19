---
title: "File Management Principles"
author: "Claude Code System"
date: "2025-08-18"
version: "2.0.0"
dependencies: ["directive.md", "workflow.md"]
prerequisites: ["Understanding of core system principles"]
audience: "System architects and principle implementers"
purpose: "Define fundamental file management philosophy for controlled resource operations"
keywords: ["files", "management", "philosophy", "constraints"]
last_review: "2025-08-18"
---

[Previous: Study formatting.md for standards](formatting.md) | [Return to documentation hub for navigation](../index.md) | [Study PRINCIPLES.md for framework](principles/PRINCIPLES.md) | [Next: Study forbidden.md for restrictions](forbidden.md)

# FILES

## Core Philosophy

⏺ **Principle**: File management serves controlled resource creation and modification within defined system boundaries.

**Why**: Uncontrolled file creation leads to system sprawl, maintenance burden, and unclear information architecture.

**What**: A constraint-based approach to file operations that prioritizes editing existing resources and minimizes unnecessary file proliferation.

## Fundamental Concepts

### Conservation Philosophy
- Prefer editing existing files over creating new ones
- Create new files only when explicitly required
- Maintain minimal file system footprint

### Constraint Philosophy
- Operate within clearly defined scope boundaries
- Follow established workflow validation patterns
- Preserve existing system structure and relationships

### Purpose-Driven Philosophy
- Create documentation only when specifically requested
- Ensure every file serves a clear, defined purpose
- Avoid speculative or "just in case" file creation

## Implementation Framework

**[Apply files-management.md for detailed implementation](../templates/templates/components/files-management.md)**

All specific file operation procedures, validation rules, and management practices are provided through the file management component.

## Principle References

⏺ **Relationship**: This file management principle controls resource creation across all operations:
- **[directive.md](directive.md)**: Provides scope boundaries for file operations
- **[workflow.md](workflow.md)**: Supplies validation requirements for file changes
- **[forbidden.md](forbidden.md)**: Defines restrictions on file creation patterns

## Cross-References

### Primary Navigation
- [Navigate to documentation hub](../index.md)
- [Study Principles for framework](principles/PRINCIPLES.md)
- [Return to formatting.md for standards](formatting.md)
- [Continue to forbidden.md for restrictions](forbidden.md)

### Implementation Resources
- **[Apply files-management.md for specific procedures](../templates/templates/components/files-management.md)**
- **[Follow workflow.md for validation requirements](workflow.md)**
- **[Check forbidden.md for constraint guidelines](forbidden.md)**

[⬆ Return to top](#files)