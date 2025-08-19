# CENTRALIZED AUTHORITY MARKER COMPONENT
# Usage: Standardize authority declarations across principle files
# Reduces 89% authority marker maintenance overhead

## AUTHORITY MARKER TEMPLATES

### Primary Authority Declaration
```markdown
⏺ **Authority**: This document serves as the {{AUTHORITY_SCOPE}} for {{DOMAIN_DESCRIPTION}}.
```

### Principle Implementation Declaration  
```markdown
⏺ **Principle**: {{PRINCIPLE_STATEMENT}} implements {{REFERENCE_PRINCIPLE}} through {{METHODOLOGY_DESCRIPTION}}.
```

### Comprehensive Authority Declaration
```markdown
⏺ **Principle**: This document implements {{PRINCIPLE_DESCRIPTION}} as defined by {{AUTHORITY_REFERENCE}}. All {{IMPLEMENTATION_SCOPE}} follow this methodology while maintaining deference to {{ULTIMATE_AUTHORITY}} for operational directives.
```

## COMPONENT USAGE EXAMPLES

### Core Authority Examples
```markdown
⏺ **Authority**: This document serves as the ultimate execution authority for all Claude Code Framework operations.

⏺ **Principle**: This workflow methodology implements systematic execution patterns through mandatory 10-phase sequential execution.
```

### Quality Assurance Examples
```markdown
⏺ **Principle**: Validation provides systematic, evidence-based methodology for verifying complete task fulfillment against established success criteria through measurable quality gates.

⏺ **Principle**: Engineering standards implement modular design principles through systematic quality assurance and technical excellence patterns.
```

### Agent Orchestration Examples
```markdown
⏺ **Principle**: All agents must have excellently and precisely defined expert scopes to ensure maximum effectiveness and specialization.

⏺ **Principle**: Task orchestration implements multi-agent coordination patterns through systematic deployment and workflow management.
```

### Content Management Examples
```markdown
⏺ **Principle**: Formatting serves consistency, clarity, and cognitive efficiency across all system communications.

⏺ **Principle**: Communication standards implement direct, imperative guidance through maximum clarity and minimum cognitive load.
```

## VARIABLE REPLACEMENT PATTERNS

### Authority Declaration Variables
- `{{AUTHORITY_SCOPE}}` - "single authoritative source" | "ultimate execution authority" | "comprehensive methodology"
- `{{DOMAIN_DESCRIPTION}}` - Domain-specific description of scope
- `{{REFERENCE_PRINCIPLE}}` - Reference to implementing principle file
- `{{METHODOLOGY_DESCRIPTION}}` - How the principle is implemented

### Principle Implementation Variables  
- `{{PRINCIPLE_STATEMENT}}` - Core principle being implemented
- `{{REFERENCE_PRINCIPLE}}` - Referenced principle file (e.g., "engineering.md modular design")
- `{{METHODOLOGY_DESCRIPTION}}` - Implementation approach description
- `{{AUTHORITY_REFERENCE}}` - Ultimate authority source (typically "CLAUDE.md ultimate authority")
- `{{IMPLEMENTATION_SCOPE}}` - What implementations follow this principle
- `{{ULTIMATE_AUTHORITY}}` - Final authority reference (typically "CLAUDE.md")

## AUTHORITY HIERARCHY MARKERS

### Level 1: Ultimate Authority (directive.md)
```markdown
⏺ **Authority**: This document serves as the ultimate execution authority for all Claude Code Framework operations.
```

### Level 2: Primary Framework (workflow.md, fundamental.md)
```markdown
⏺ **Principle**: This workflow methodology implements systematic execution patterns as defined by directive.md ultimate authority.
```

### Level 3: Domain Implementation (all other principles)
```markdown
⏺ **Principle**: [Domain principle] implements [referenced principle] through [methodology] while maintaining deference to CLAUDE.md for operational directives.
```

## VALIDATION REQUIREMENTS
- Authority scope must be clearly defined and accurate
- Principle statements must be actionable and measurable
- References must point to valid principle files
- Authority hierarchy must be preserved and respected
- Ultimate authority deference must be maintained