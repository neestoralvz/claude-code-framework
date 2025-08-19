
# Principle Reference Template

## Purpose
This template provides standardized patterns for principle references across the Claude Code System. All principle references use these consistent formats to maintain system-wide coherence and navigation clarity.

## Reference Types

### 1. Principle Implementation Reference
**Format**: `⏺ **Principle**: This [section/approach/phase] implements [principle-file.md] by [specific implementation explanation].`

**Usage**: Use when describing how a current section implements or applies another principle.

**Example**:
```markdown
⏺ **Principle**: This clarification phase implements [directive.md](../../principles/directive.md) by establishing complete request understanding before proceeding to subsequent workflow phases.
```

### 2. Authority Declaration Reference
**Format**: `⏺ **Authority**: [Authority statement with link to referenced validation section].`

**Usage**: Use when establishing authoritative standards or criteria that other sections must reference.

**Example**:
```markdown
⏺ **Authority**: Success criteria established in clarification phase serve as authoritative validation standards for [workflow.md#8-validation](#8-validation).
```

### 3. Relationship Mapping Reference
**Format**: `⏺ **Relationship**: This [principle/component] [relationship type] [description]:`

**Usage**: Use when mapping how current principle relates to other principles in the system.

**Example**:
```markdown
⏺ **Relationship**: This directive principle provides the core command framework that governs all other principles:
- **[workflow.md](../../principles/workflow.md)**: Provides systematic execution phases to implement core command
- **[fundamental.md](../../principles/fundamental.md)**: Supplies evidence requirements for verification
```

### 4. Implementation Guidance Reference
**Format**: `⏺ **Implementation**: [Implementation instruction] [principle-file.md link] for [specific guidance area].`

**Usage**: Use when providing specific implementation instructions that reference other principles.

**Example**:
```markdown
⏺ **Implementation**: Apply [engineering.md simplicity principles](../../principles/engineering.md) to avoid over-engineering while seeking integral solutions that solve requests from the root.
```

## Template Variables

### Required Elements
- **Relationship Type**: `Principle`, `Authority`, `Relationship`, `Implementation`
- **Reference Target**: Link to principle file and optional section anchor
- **Context Description**: Explanation of how/why the reference applies
- **Implementation Detail**: Specific guidance on application

### Optional Elements
- **Section Anchor**: `#section-name` for specific principle sections
- **List Format**: Bullet points for multiple related principles
- **Cross-Reference**: Bidirectional linking for navigation

## Usage Guidelines

### Consistency Requirements
- All principle references must use the ⏺ symbol as prefix
- Bold formatting required for relationship type: `**Principle**`, `**Authority**`, etc.
- Links must use markdown format: `[display-text](file-path)`
- Maintain parallel structure within related references

### Navigation Standards
- Include section anchors when referencing specific principle sections
- Provide bidirectional links between related principles
- Use descriptive link text that explains the relationship
- Maintain consistent file naming convention: `principle-name.md`

### Content Standards
- Explain the specific relationship, not just general connection
- Use active voice for implementation descriptions
- Provide actionable guidance in implementation references
- Link to concrete validation methods in authority references

## Implementation Checklist

When updating files to use this template:
- [ ] Identify all existing principle reference patterns
- [ ] Map each reference to appropriate template type
- [ ] Update reference format to match template specification
- [ ] Verify all links point to valid principle files and sections  
- [ ] Ensure bidirectional navigation between related principles
- [ ] Test link functionality and section anchors
- [ ] Validate consistent formatting across all references

## Cross-References

### Documentation Components
- [Return to Documentation Hub](../philosophy/index.md)
- [Review PRINCIPLES.md for framework](principles/PRINCIPLES.md)
- [Follow workflow.md for systematic execution](../../principles/workflow.md)

### Related Templates
- Template directory: `/docs/templates/templates/components/`
- Component creation guidelines: Follow this template structure for new components
- Maintenance standards: Update all references when principle files change

[⬆ Return to top](#principle-reference-template)
