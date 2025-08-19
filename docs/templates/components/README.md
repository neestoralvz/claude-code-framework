---
title: "Components Documentation"
author: "Claude Code System"
date: "2025-08-18"
version: "1.1.0"
dependencies: ["../principles/fundamental.md"]
audience: "System architects and developers"
purpose: "Reusable implementation modules for principles"
keywords: ["components", "principles", "implementation"]
---

[Previous: ../index.md](../index.md) | [Hub](../index.md) | [Next: workflow-phases.md](workflow-phases.md)

# COMPONENTS

Components are reusable implementation modules that operationalize principles for specific use cases.

⏺ **Principle**: Follows [fundamental.md](../principles/fundamental.md) by separating philosophical guidance from practical implementation.

## Architecture

### Principles vs Components
- **Principles** (`/docs/principles/`): Define "WHY" and "WHAT" (philosophy)
- **Components** (`/docs/templates/templates/components/`): Define "HOW" (implementation)

### Relationship
```
PRINCIPLES → COMPONENTS → COMMANDS/AGENTS
```

### Key Differences
- **Authority**: Principles are philosophical; components are practical
- **Scope**: Principles are universal; components are specific
- **Change**: Principles stable; components evolve

## Available Components

### Core Implementation Components
- **workflow-phases.md**: Eight-phase execution for commands
- Navigation standards migrated to **../principles/organization.md**
- **engineering-standards.md**: Development and quality standards
- **directive-implementation.md**: Initialization and load order
- **footer.md**: Standardized footer navigation
- **toc-generator.md**: Table of Contents patterns

### Component Hubs
- **claude-md-templates.md**: CLAUDE.md template hub
- **organization-hub.md**: Organization structure hub
- **section-templates-hub.md**: Section template hub
- **files-management.md**: File operation patterns
- **engineering-standards.md**: Quality engineering standards

## Usage Guidelines

### Create Components When
1. Multiple files implement same principle
2. Pattern used across contexts
3. Changes require multiple updates
4. Separation improves clarity

### Component Requirements
1. Reference implementing principle
2. Define scope and use cases
3. Maintain consistency
4. Document variations

## Benefits
- **DRY**: Eliminate redundant implementations
- **Consistency**: Uniform behavior across system
- **Maintainability**: Single-point updates
- **Clarity**: Separate philosophy from practice
- **Scalability**: Easy to extend with new implementations

## Cross-References
- [Hub](../index.md) | [PRINCIPLES.md](principles/PRINCIPLES.md) | [COMMANDS.md](../COMMANDS.md)
- [fundamental.md](../principles/fundamental.md) | [organization.md](../principles/organization.md) | [workflow.md](../principles/workflow.md)

### Implementation Status
✅ **Complete Coverage**: All principles have corresponding components