---
title: "Frontmatter Examples"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["frontmatter-usage-patterns.md", "frontmatter-template.yaml"]
prerequisites: ["Understanding of document types", "Knowledge of YAML syntax"]
audience: "Content creators, developers, and documentation maintainers"
purpose: "Provide complete frontmatter examples for all document types"
keywords: ["frontmatter", "examples", "templates", "document-types", "YAML"]
last_review: "2025-08-18"
---

[Previous: Usage patterns](frontmatter-usage-patterns.md) | [Return to Components](README.md) | [Master PRINCIPLES.md](../PRINCIPLES.md) | [Next: Validation](frontmatter-validation.md)

# Frontmatter Examples

## Migration Notice

**⚠️ MIGRATION COMPLETE**: This component has been consolidated into [organization.md](../principles/organization.md#documentation-metadata-standards) as part of the documentation standards migration. **Use the organization principle for current metadata standards.** This component is maintained for historical reference only.

**Current Location**: [Apply organization.md for comprehensive metadata standards](../principles/organization.md#documentation-metadata-standards)

## Purpose

This component provides complete, real-world examples of frontmatter for each document type in the Claude Code framework, demonstrating proper field usage and formatting.

⏺ **Principle**: Demonstrates [formatting.md](../principles/formatting.md) standards and [organization.md](../principles/organization.md) patterns through concrete examples.

## Document Type Examples

### Agent Documents
```yaml
---
name: agent-name                         # Kebab-case identifier
description: "Comprehensive agent description with capabilities"
tools: Bash, Read, Write, Edit           # Available tools list
model: sonnet                           # Model specification
color: green                            # UI color designation
---
```

### Index/Hub Documents
```yaml
---
title: "Index Title"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
audience: "All users"
purpose: "Provide navigation and overview of section"
keywords: ["index", "navigation", "hub", "overview"]
last_review: "2025-08-18"
---
```

### Template Documents
```yaml
---
title: "Template Name"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["related-component.md"]
audience: "Template users and developers"
purpose: "Provide reusable structure for specific use case"
keywords: ["template", "reusable", "structure", "pattern"]
category: "template"
type: "component-template"
last_review: "2025-08-18"
---
```

## Complete Real Examples

### Principle Document
```yaml
---
title: "Dynamic Adaptation"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["workflow.md", "fundamental.md"]
prerequisites: ["Understanding of workflow phases"]
audience: "System operators and developers"
purpose: "Enable adaptive behavior based on context and constraints"
keywords: ["adaptation", "context", "flexibility", "dynamic"]
last_review: "2025-08-18"
---
```

### Component Document
```yaml
---
title: "Cross-Reference Link Standards"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../principles/organization.md"]
prerequisites: ["Understanding of navigation patterns"]
audience: "Content creators and developers"
purpose: "Standardize cross-reference linking patterns"
keywords: ["cross-reference", "links", "navigation", "standards"]
last_review: "2025-08-18"
---
```

### Command Document
```yaml
---
title: "System Audit"
author: "Claude Code System"
date: "2025-08-18"
version: "2.0.0"
dependencies: ["../docs/principles/workflow.md"]
prerequisites: ["Understanding of command execution"]
audience: "System operators and developers"
purpose: "Execute comprehensive system analysis"
keywords: ["audit", "analysis", "system", "validation"]
last_review: "2025-08-18"
---
```

## Special Case Examples

### Ticket Document Example
```yaml
---
title: "Fix Component Complexity Violations"
ticket_id: "SYS-013"
priority: "MEDIUM"
status: "pending"
created: "2025-08-18"
category: "system"
estimated_effort: "5 hours"
dependencies: []
affected_files: 15
similarity_score: "N/A"
---
```

### Planning Document Example
```yaml
---
title: "Ticket Registry"
author: "Claude Code System"
date: "2025-08-18"
version: "2.0.0"
dependencies: ["../principles/workflow.md"]
audience: "Project managers and developers"
purpose: "Central registry for tracking all project tickets and their status"
keywords: ["tickets", "registry", "tracking", "project", "management"]
last_review: "2025-08-18"
---
```

## Field Variation Examples

### Minimal Required Fields
```yaml
---
title: "Simple Document"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
---
```

### Maximum Fields (Documentation)
```yaml
---
title: "Comprehensive Guide"
author: "Claude Code System"
date: "2025-08-18"
version: "2.1.0"
dependencies: ["principle1.md", "principle2.md", "component.md"]
prerequisites: ["Advanced system knowledge", "Completion of basic training"]
audience: "Expert developers and system architects"
purpose: "Provide comprehensive guidance for complex system implementation"
keywords: ["comprehensive", "advanced", "implementation", "system", "architecture"]
category: "guide"
type: "advanced-documentation"
last_review: "2025-08-18"
---
```

## Cross-References

### Current Standards (Post-Migration)
- [Apply organization.md metadata standards](../principles/organization.md#documentation-metadata-standards) - **CURRENT AUTHORITY**
- [Review document type patterns](../principles/organization.md#document-type-patterns) - Type-specific combinations
- [Study field format examples](../principles/organization.md#field-format-examples) - Validation examples
- [Reference YAML template](../principles/organization.md#complete-yaml-template-reference) - Complete template

### Legacy Components (Historical Reference)
- [Review core fields](frontmatter-core-fields.md) - Field definitions and requirements
- [Study usage patterns](frontmatter-usage-patterns.md) - Type-specific combinations
- [Apply validation rules](frontmatter-validation.md) - Example validation

### Template Resources
- [Use frontmatter-template.yaml](frontmatter-template.yaml) - Complete field reference
- [Follow formatting-standards.md](formatting-standards.md) - Formatting guidelines

### Navigation
- [Return to Frontmatter Hub](frontmatter-template-usage.md)
- [Browse Components Index](README.md)
- [Study Framework Principles](../PRINCIPLES.md)