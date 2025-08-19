---
title: "Frontmatter Template Usage Hub"
author: "Claude Code System"
date: "2025-08-18"
version: "2.0.0"
dependencies: ["frontmatter-template.yaml"]
prerequisites: ["Understanding of YAML syntax", "Knowledge of Markdown frontmatter"]
audience: "Content creators, developers, and documentation maintainers"
purpose: "Central hub for frontmatter template guidance and focused component access"
keywords: ["frontmatter", "YAML", "metadata", "template", "hub", "navigation"]
last_review: "2025-08-18"
---

[Previous: Browse components index](README.md) | [Return to Documentation Hub](../index.md) | [Master PRINCIPLES.md](principles/PRINCIPLES.md) | [Next: Apply formatting standards](formatting-standards.md)

# Frontmatter Template Usage Hub

## Overview

This hub provides centralized access to frontmatter template guidance through focused, specialized components. The standardized frontmatter template ensures consistent metadata structure across all 72+ markdown files in the Claude Code framework.

⏺ **Principle**: This hub follows [organization.md](../principles/organization.md) by providing systematic metadata structure and [formatting.md](../principles/formatting.md) by ensuring consistent field formatting through focused components.

## Template Location

**Primary Template**: [`docs/templates/components/frontmatter-template.yaml`](frontmatter-template.yaml)

The template serves as the authoritative source for all YAML frontmatter fields, including field definitions, usage guidelines, document type requirements, and validation criteria.

## Component Navigation

### Core Components

#### [Core Fields Reference - Now in Organization Principle](../principles/organization.md#documentation-metadata-standards)
**Essential metadata definitions and document classification**
- Required fields for all documents (title, author, date, version)
- Content classification fields (dependencies, prerequisites, audience)
- Ticket-specific fields (ticket_id, priority, status, category)
- Review and maintenance fields (last_review)
- **[Legacy component available](frontmatter-core-fields.md)** for historical reference

#### [Usage Patterns Guide - Now in Organization Principle](../principles/organization.md#document-type-patterns)
**Field combinations by document type**
- Principle document patterns
- Component document patterns
- Command document patterns
- Ticket document patterns
- Pattern selection criteria and guidelines
- **[Legacy component available](frontmatter-usage-patterns.md)** for historical reference

#### [Complete Examples - Now in Organization Principle](../principles/organization.md#field-format-examples)
**Real-world frontmatter implementations**
- Agent document examples
- Index/hub document examples
- Template document examples
- Complete real examples from framework files
- Special case and variation examples
- **[Legacy component available](frontmatter-examples.md)** for historical reference

#### [Validation & Best Practices - Now in Organization Principle](../principles/organization.md#validation-requirements)
**Quality assurance and validation rules**
- Required field validation checklists
- Content type validation criteria
- Ticket-specific validation requirements
- Best practices and common error prevention
- Automated validation approaches
- **[Legacy component available](frontmatter-validation.md)** for historical reference

## Quick Reference

### Standard Documentation Pattern
```yaml
---
title: "[Document Title]"
author: "Claude Code System"
date: "YYYY-MM-DD"
version: "X.Y.Z"
dependencies: ["related-file.md"]
prerequisites: ["Required knowledge"]
audience: "Target users"
purpose: "Document purpose statement"
keywords: ["relevant", "search", "terms"]
last_review: "YYYY-MM-DD"
---
```

### Document Type Quick Links
- **Principles**: Use [core fields in organization.md](../principles/organization.md#document-type-patterns) + methodology focus
- **Components**: Use [usage patterns in organization.md](../principles/organization.md#document-type-patterns) + reusability emphasis
- **Commands**: Use [examples in organization.md](../principles/organization.md#field-format-examples) + execution focus
- **Tickets**: Use [validation in organization.md](../principles/organization.md#validation-requirements) + status tracking

## Implementation Workflow

### For New Documents
1. **Identify Type**: Determine document category (principle, component, command, etc.)
2. **Select Pattern**: Use [usage patterns in organization.md](../principles/organization.md#document-type-patterns) for type-specific fields
3. **Reference Examples**: Review [complete examples in organization.md](../principles/organization.md#field-format-examples) for proper formatting
4. **Validate Implementation**: Apply [validation rules in organization.md](../principles/organization.md#validation-requirements) before publication

### For Existing Documents
1. **Assess Current State**: Compare against [core fields in organization.md](../principles/organization.md#core-metadata-requirements) requirements
2. **Update Pattern**: Align with [usage patterns in organization.md](../principles/organization.md#document-type-patterns) for document type
3. **Validate Changes**: Use [validation checklists in organization.md](../principles/organization.md#validation-requirements) for quality assurance
4. **Maintain Consistency**: Follow [examples in organization.md](../principles/organization.md#field-format-examples) for formatting standards

## Cross-References

### Template Resources
- [Study frontmatter-template.yaml](frontmatter-template.yaml) - Complete field definitions
- [Apply formatting-standards.md](formatting-standards.md) - General formatting rules
- [Use validation-templates.md](../principles/validation.md#template-integration) - Systematic validation approaches

### Related Principles
- [Follow organization.md](../principles/organization.md) - Systematic metadata structure
- [Apply formatting.md](../principles/formatting.md) - Consistent field formatting
- [Use files.md](../principles/files.md) - File management standards

### Navigation
- [Return to Components Hub](README.md)
- [Navigate to Documentation Hub](../index.md)
- [Study Framework Principles](principles/PRINCIPLES.md)

---

**Component Status**: This hub component replaces the previous 259-line frontmatter-template-usage.md file with focused, specialized components for improved maintainability and reduced complexity per ticket SYS-013.