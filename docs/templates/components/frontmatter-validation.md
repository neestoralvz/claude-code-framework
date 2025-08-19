---
title: "Frontmatter Validation"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["frontmatter-core-fields.md", "frontmatter-usage-patterns.md"]
prerequisites: ["Understanding of validation principles", "Knowledge of YAML syntax"]
audience: "Content creators, developers, and quality assurance teams"
purpose: "Provide validation rules and best practices for frontmatter implementation"
keywords: ["validation", "frontmatter", "quality", "standards", "verification"]
last_review: "2025-08-18"
---

[Previous: Examples](frontmatter-examples.md) | [Return to Components](README.md) | [Master PRINCIPLES.md](principles/PRINCIPLES.md) | [Next: Formatting standards](formatting-standards.md)

# Frontmatter Validation

## Migration Notice

**⚠️ MIGRATION COMPLETE**: This component has been consolidated into [organization.md](../principles/organization.md#documentation-metadata-standards) as part of the documentation standards migration. **Use the organization principle for current metadata standards.** This component is maintained for historical reference only.

**Current Location**: [Apply organization.md for comprehensive metadata standards](../principles/organization.md#documentation-metadata-standards)

## Purpose

This component provides comprehensive validation rules and best practices for frontmatter implementation, ensuring quality and consistency across all Claude Code framework documentation.

⏺ **Principle**: Implements [workflow.md](../principles/workflow.md) validation phase and supports [engineering.md](../principles/engineering.md) quality standards.

## Required Field Validation

### Core Fields Checklist
- [ ] `title` present and descriptive (not generic or placeholder)
- [ ] `author` follows standard format ("Claude Code System")
- [ ] `date` in ISO format (YYYY-MM-DD)
- [ ] `version` follows semantic versioning (X.Y.Z format)

### Field Format Validation
```yaml
# Correct formats
title: "Descriptive Document Title"        # ✅ Quoted, descriptive
author: "Claude Code System"               # ✅ Standard attribution
date: "2025-08-18"                        # ✅ ISO format
version: "1.0.0"                          # ✅ Semantic versioning

# Incorrect formats
title: Document Title                      # ❌ Missing quotes
author: Claude                            # ❌ Non-standard format
date: 2025-08-18                          # ❌ Missing quotes
version: v1.0                             # ❌ Non-semantic format
```

## Content Type Validation

### Documentation Fields
- [ ] Document type fields match content purpose
- [ ] Dependencies reference actual, existing files
- [ ] Keywords accurately describe content (3-6 relevant terms)
- [ ] Audience matches intended users
- [ ] Purpose provides clear, one-line description

### Dependency Validation
```yaml
# Valid dependency formats
dependencies: ["workflow.md"]                    # ✅ Same directory
dependencies: ["../principles/organization.md"]  # ✅ Relative path
dependencies: []                                 # ✅ Empty array for no deps

# Invalid dependency formats
dependencies: "workflow.md"                      # ❌ String instead of array
dependencies: ["nonexistent-file.md"]           # ❌ File doesn't exist
dependencies: ["workflow"]                      # ❌ Missing .md extension
```

## Ticket-Specific Validation

### Ticket Field Requirements
- [ ] `ticket_id` follows [CATEGORY]-[NUMBER] format (e.g., "SYS-013")
- [ ] `priority` uses standard values (CRITICAL, HIGH, MEDIUM, LOW)
- [ ] `status` reflects current state (pending, in_progress, completed, resolved)
- [ ] `category` aligns with ticket classification system

### Ticket Format Examples
```yaml
# Valid ticket formats
ticket_id: "MOD-001"                      # ✅ Category-Number format
priority: "HIGH"                          # ✅ Standard priority level
status: "pending"                         # ✅ Valid status value
category: "modularization"                # ✅ Recognized category

# Invalid ticket formats
ticket_id: "MOD001"                       # ❌ Missing hyphen
priority: "High"                          # ❌ Wrong capitalization
status: "todo"                            # ❌ Non-standard status
category: "mod"                           # ❌ Abbreviated category
```

## Best Practices Validation

### Field Selection Guidelines
1. **Required Fields**: Always include title, author, date, and version
2. **Relevant Optional Fields**: Include fields that provide value for the document type
3. **Consistent Values**: Follow established patterns for author, audience, and category values
4. **Array Format**: Use array format for dependencies, prerequisites, and keywords

### Content Quality Standards
- Use descriptive titles with consistent capitalization
- Always use ISO format (YYYY-MM-DD) for dates
- Follow semantic versioning principles
- Include 3-6 relevant terms for searchability

### Maintenance Requirements
- Update last_review field when content changes
- Increment version for significant changes
- Keep dependencies array current with actual relationships
- For tickets, maintain accurate status progression

## Validation Checklists

### Pre-Publication Checklist
- [ ] All required fields present and correctly formatted
- [ ] Dependencies reference existing files with correct paths
- [ ] Keywords accurately represent document content
- [ ] Audience specification matches document complexity
- [ ] Purpose statement is clear and concise
- [ ] Version number reflects content maturity
- [ ] Last review date is current

### Type-Specific Validation

#### Principle Documents
- [ ] Dependencies include prerequisite principles
- [ ] Purpose emphasizes principle definition
- [ ] Keywords include "principle" and methodology terms
- [ ] Audience targets system operators and developers

#### Component Documents
- [ ] Dependencies reference related principles
- [ ] Purpose emphasizes reusability and implementation
- [ ] Keywords include "component" and implementation terms
- [ ] Audience targets developers and implementers

#### Command Documents
- [ ] Dependencies include workflow.md
- [ ] Purpose describes operation performed
- [ ] Keywords include "command" and execution terms
- [ ] Version reflects command maturity (often 2.0.0+)

#### Ticket Documents
- [ ] Uses ticket-specific fields instead of documentation fields
- [ ] Status accurately reflects current ticket state
- [ ] Priority aligns with urgency and impact
- [ ] Category matches project classification system

## Common Validation Errors

### Frequent Mistakes
1. **Missing Quotes**: YAML strings should be quoted
2. **Wrong Date Format**: Use YYYY-MM-DD, not other formats
3. **Invalid Dependencies**: Reference non-existent files
4. **Generic Titles**: Use descriptive, specific titles
5. **Inconsistent Arrays**: Mix array and string formats

### Error Prevention
- Use frontmatter-template.yaml as reference
- Validate file references before publication
- Follow established patterns for field values
- Review examples for proper formatting

## Cross-References

### Current Standards (Post-Migration)
- [Apply organization.md metadata standards](../principles/organization.md#documentation-metadata-standards) - **CURRENT AUTHORITY**
- [Review validation requirements](../principles/organization.md#validation-requirements) - Comprehensive validation rules
- [Study implementation guidelines](../principles/organization.md#implementation-guidelines) - Quality standards
- [Reference YAML template](../principles/organization.md#complete-yaml-template-reference) - Complete template

### Legacy Components (Historical Reference)
- [Study core fields](frontmatter-core-fields.md) - Field definitions and requirements
- [Review usage patterns](frontmatter-usage-patterns.md) - Type-specific combinations
- [Examine examples](frontmatter-examples.md) - Correct implementation examples

### Template Resources
- [Use frontmatter-template.yaml](frontmatter-template.yaml) - Complete validation reference
- [Follow formatting-standards.md](formatting-standards.md) - General formatting rules
- [Apply validation-templates.md](../principles/validation.md#template-integration) - Systematic validation approaches

### Quality Standards
- [Follow engineering.md](../principles/engineering.md) - Quality engineering principles
- [Apply workflow.md validation](../principles/workflow.md) - Systematic validation phases

### Navigation
- [Return to Frontmatter Hub](frontmatter-template-usage.md)
- [Browse Components Index](README.md)
- [Study Framework Principles](principles/PRINCIPLES.md)