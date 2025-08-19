---
title: "Frontmatter Usage Patterns"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["frontmatter-core-fields.md", "frontmatter-template.yaml"]
prerequisites: ["Understanding of YAML syntax", "Knowledge of document types"]
audience: "Content creators, developers, and documentation maintainers"
purpose: "Provide field combinations and patterns for different document types"
keywords: ["frontmatter", "patterns", "document-types", "templates", "usage"]
last_review: "2025-08-18"
---

[Previous: Core fields](frontmatter-core-fields.md) | [Return to Components](README.md) | [Master PRINCIPLES.md](principles/PRINCIPLES.md) | [Next: Examples](frontmatter-examples.md)

# Frontmatter Usage Patterns

## Migration Notice

**⚠️ MIGRATION COMPLETE**: This component has been consolidated into [organization.md](../principles/organization.md#documentation-metadata-standards) as part of the documentation standards migration. **Use the organization principle for current metadata standards.** This component is maintained for historical reference only.

**Current Location**: [Apply organization.md for comprehensive metadata standards](../principles/organization.md#documentation-metadata-standards)

## Purpose

This component provides standardized field combinations and patterns for different document types, ensuring consistent metadata structure across the Claude Code framework.

⏺ **Principle**: Follows [organization.md](../principles/organization.md) for systematic metadata patterns and [formatting.md](../principles/formatting.md) for consistent field arrangements.

## Document Type Patterns

### Principle Documents
```yaml
---
title: "Principle Name"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["prerequisite-principle.md"]
prerequisites: ["Understanding of system fundamentals"]
audience: "System operators and developers"
purpose: "Define core system principle and methodology"
keywords: ["principle", "methodology", "framework"]
last_review: "2025-08-18"
---
```

### Component Documents
```yaml
---
title: "Component Name"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../principles/related-principle.md"]
prerequisites: ["Knowledge of principle implementation"]
audience: "Developers and implementers"
purpose: "Provide reusable implementation of principle"
keywords: ["component", "implementation", "reusable"]
last_review: "2025-08-18"
---
```

### Command Documents
```yaml
---
title: "Command Name"
author: "Claude Code System"
date: "2025-08-18"
version: "2.0.0"
dependencies: ["../docs/principles/workflow.md"]
prerequisites: ["Understanding of command execution"]
audience: "System operators and developers"
purpose: "Execute specific system operation or task"
keywords: ["command", "execution", "operation"]
last_review: "2025-08-18"
---
```

### Ticket Documents
```yaml
---
title: "Ticket Description"
ticket_id: "MOD-001"
priority: "HIGH"
status: "pending"
created: "2025-08-18"
category: "modularization"
estimated_effort: "4 hours"
dependencies: []
affected_files: 72
similarity_score: "98%"
---
```

## Field Combination Guidelines

### Standard Documentation Pattern
All documentation follows this base pattern:
```yaml
title: "[Type] Name"
author: "Claude Code System"
date: "YYYY-MM-DD"
version: "X.Y.Z"
[type-specific fields]
last_review: "YYYY-MM-DD"
```

### Dependency Patterns
- **Same Directory**: `["related-file.md"]`
- **Parent Directory**: `["../principles/principle.md"]`
- **Multiple Dependencies**: Array format with logical order
- **No Dependencies**: Empty array `[]` for ticket documents

### Audience Specifications
- **System operators and developers**: For principles and commands
- **Developers and implementers**: For components and technical guides
- **Content creators**: For templates and formatting guides
- **All users**: For index and hub documents

## Pattern Selection Criteria

### By Document Location
- **`/docs/principles/`**: Use principle pattern
- **`/docs/templates/templates/components/`**: Use component pattern
- **`/commands/`**: Use command pattern
- **`/agents/`**: Use agent pattern (see examples)

### By Document Purpose
- **Framework Definition**: Principle pattern with methodology focus
- **Implementation Guide**: Component pattern with reusability emphasis
- **Operational Task**: Command pattern with execution focus
- **Project Tracking**: Ticket pattern with status tracking

## Cross-References

### Current Standards (Post-Migration)
- [Apply organization.md metadata standards](../principles/organization.md#documentation-metadata-standards) - **CURRENT AUTHORITY**
- [Review document type patterns](../principles/organization.md#document-type-patterns) - Type-specific patterns
- [Study validation requirements](../principles/organization.md#validation-requirements) - Pattern validation rules
- [Reference YAML template](../principles/organization.md#complete-yaml-template-reference) - Complete template

### Legacy Components (Historical Reference)
- [Study core fields](frontmatter-core-fields.md) - Field definitions and requirements
- [Review examples](frontmatter-examples.md) - Complete document demonstrations
- [Validate patterns](frontmatter-validation.md) - Pattern validation rules

### Template Resources
- [Apply frontmatter-template.yaml](frontmatter-template.yaml) - Complete field reference
- [Follow formatting-standards.md](formatting-standards.md) - Formatting consistency

### Navigation
- [Return to Frontmatter Hub](frontmatter-template-usage.md)
- [Browse Components Index](README.md)
- [Study Framework Principles](principles/PRINCIPLES.md)