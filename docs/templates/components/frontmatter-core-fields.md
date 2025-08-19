---
title: "Frontmatter Core Fields"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["frontmatter-template.yaml"]
prerequisites: ["Understanding of YAML syntax", "Knowledge of Markdown frontmatter"]
audience: "Content creators, developers, and documentation maintainers"
purpose: "Define core metadata fields and document classification for standardized frontmatter"
keywords: ["frontmatter", "YAML", "metadata", "fields", "classification"]
last_review: "2025-08-18"
---

[Previous: Frontmatter hub](frontmatter-template-usage.md) | [Return to Components](README.md) | [Master PRINCIPLES.md](principles/PRINCIPLES.md) | [Next: Usage patterns](frontmatter-usage-patterns.md)

# Frontmatter Core Fields

## Migration Notice

**⚠️ MIGRATION COMPLETE**: This component has been consolidated into [organization.md](../principles/organization.md#documentation-metadata-standards) as part of the documentation standards migration. **Use the organization principle for current metadata standards.** This component is maintained for historical reference only.

**Current Location**: [Apply organization.md for comprehensive metadata standards](../principles/organization.md#documentation-metadata-standards)

## Purpose

This component defines the core metadata fields and document classification structure for the standardized YAML frontmatter template, ensuring consistent metadata across all 72+ markdown files in the Claude Code framework.

⏺ **Principle**: This follows [organization.md](../principles/organization.md) by providing systematic metadata structure and [formatting.md](../principles/formatting.md) by ensuring consistent field formatting.

## Core Metadata (Required for All Documents)

### Essential Fields
```yaml
title: "Document Title"                    # Always use quotes, descriptive format
author: "Claude Code System"               # Standard author attribution
date: "2025-08-18"                        # ISO format (YYYY-MM-DD)
version: "1.0.0"                          # Semantic versioning (major.minor.patch)
```

### Field Requirements
- **title**: Descriptive, quoted string with consistent capitalization
- **author**: Standard "Claude Code System" attribution for framework files
- **date**: ISO format (YYYY-MM-DD) for creation or major revision date
- **version**: Semantic versioning following major.minor.patch format

## Content Classification (Document Type Specific)

### Documentation Fields
```yaml
dependencies: ["workflow.md", "directive.md"]           # Related file array
prerequisites: ["System initialization", "Basic setup"] # Required knowledge array
audience: "System operators and developers"             # Target user group
purpose: "Brief description of document purpose"        # One-line statement
keywords: ["workflow", "execution", "phases"]           # Search terms array
```

### Ticket-Specific Fields
```yaml
ticket_id: "MOD-001"                     # Format: [Category]-[Number]
priority: "HIGH"                         # CRITICAL, HIGH, MEDIUM, LOW
status: "pending"                        # pending, in_progress, completed, resolved
category: "modularization"               # system, modularization, audit, documentation
estimated_effort: "4 hours"             # Time estimate with units
affected_files: 72                      # Number of files impacted
similarity_score: "98%"                 # For duplication analysis
```

### Review and Maintenance
```yaml
last_review: "2025-08-18"               # Date of last content review (ISO format)
```

## Classification Guidelines

### Document Types
- **Principles**: Core system principles and methodologies
- **Components**: Reusable implementation patterns
- **Commands**: Executable system operations
- **Agents**: Specialized workflow agents
- **Tickets**: Planning and tracking documents
- **Templates**: Reusable structural patterns

### Field Selection Criteria
1. **Required Fields**: Include title, author, date, version for all documents
2. **Type-Specific**: Add classification fields based on document purpose
3. **Maintenance**: Include last_review for content tracking
4. **Relationships**: Use dependencies for file relationships

## Cross-References

### Current Standards (Post-Migration)
- [Apply organization.md metadata standards](../principles/organization.md#documentation-metadata-standards) - **CURRENT AUTHORITY**
- [Review document type patterns](../principles/organization.md#document-type-patterns) - Type-specific field combinations
- [Study validation requirements](../principles/organization.md#validation-requirements) - Field validation rules
- [Reference YAML template](../principles/organization.md#complete-yaml-template-reference) - Complete template

### Legacy Components (Historical Reference)
- [Explore usage patterns](frontmatter-usage-patterns.md) - Type-specific field combinations
- [Review examples](frontmatter-examples.md) - Complete document examples
- [Validate implementation](frontmatter-validation.md) - Field validation rules

### Template Resources
- [Apply frontmatter-template.yaml](frontmatter-template.yaml) - Complete field definitions
- [Follow formatting-standards.md](formatting-standards.md) - General formatting rules

### Navigation
- [Return to Frontmatter Hub](frontmatter-template-usage.md)
- [Browse Components Index](README.md)
- [Study Framework Principles](principles/PRINCIPLES.md)