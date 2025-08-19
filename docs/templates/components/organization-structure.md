---
title: "Organization Structure Component"
author: "Claude Code System"
date: "2025-08-18"
version: "2.0.0"
dependencies: ["../principles/organization.md"]
prerequisites: ["Understanding of organization principles"]
audience: "System architects and content organizers"
purpose: "Provide structural patterns for documentation metadata, navigation, and cross-references"
keywords: ["organization", "structure", "metadata", "navigation", "cross-references"]
last_review: "2025-08-18"
---

[Previous: communication-templates.md](communication-templates.md) | [Next: claude-md-templates.md](claude-md-templates.md)

# ORGANIZATION STRUCTURE COMPONENT

⏺ **Principle**: This component implements [organization.md](../principles/organization.md) structural patterns for documentation metadata, navigation standards, and cross-reference systems.

## Documentation Metadata Standards

### Core Metadata Requirements

All documentation files must include these essential fields:

```yaml
---
title: "Descriptive Document Title"        # Always quoted, descriptive format
author: "Claude Code System"              # Standard attribution for framework files
date: "2025-08-18"                       # ISO format (YYYY-MM-DD) creation/revision date
version: "1.0.0"                         # Semantic versioning (major.minor.patch)
---
```

### Document Classification Fields

For comprehensive documentation, include these classification fields:

```yaml
dependencies: ["workflow.md", "directive.md"]    # Related file references
prerequisites: ["System initialization"]           # Required knowledge array
audience: "System operators and developers"        # Target user specification
purpose: "Document purpose statement"              # One-line objective description
keywords: ["organization", "structure", "metadata"] # Search terms (3-6 relevant)
last_review: "2025-08-18"                        # Content review date (ISO format)
```

### Document Type Patterns

#### Principle Documents
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

#### Component Documents
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

## Navigation Standards

### Core Navigation Philosophy
- **Predictability**: Users expect consistent navigation patterns across all documentation
- **Clarity**: Every link should clearly indicate destination and purpose through action verbs
- **Efficiency**: Navigation should minimize cognitive load and enable quick content discovery
- **Context Awareness**: Navigation adapts to file type and location within system hierarchy

### Standard Navigation Patterns

#### Variable-Based Navigation Template
```markdown
[Previous: {{prev_title}}]({{prev}}) | [Hub]({{hub}}) | [Next: {{next_title}}]({{next}})
```

#### Documentation Hub Navigation
```markdown
[Hub]({{hub}}) | [Principles]({{principles}}) | [Commands]({{commands}})
```

### Action Verb Standards

#### Navigation Actions
- **Study**: Learning from principles/framework content
- **Navigate**: Moving to hub/index locations  
- **Return**: Going back to central locations
- **Browse**: Exploring catalogs/collections
- **Deploy**: Executing tools, commands, agents
- **Execute**: Running commands, tickets, processes
- **Apply**: Using templates, patterns, guidelines
- **Review**: Examining analysis, reports, documentation

## Breadcrumb Standards

### Standard Breadcrumb Structure

```markdown
[Previous: {action} {target}]({relative_path}) | [Return to {hub_type} for navigation]({hub_path}) | [Study PRINCIPLES.md for framework]({principles_path}) | [Next: {action} {target}]({relative_path})
```

### Path Resolution Rules

#### Hub Path Determination
- From `/docs/`: `index.md`
- From `/commands/`: `index.md` 
- From `/agents/`: `../docs/index.md`
- From `/docs/templates/templates/components/`: `README.md`
- From `/planning/`: `../index.md`

#### PRINCIPLES.md Path Calculation
- From `/docs/`: `PRINCIPLES.md`
- From `/commands/`: `../docs/PRINCIPLES.md`
- From `/agents/`: `../docs/PRINCIPLES.md`
- From `/docs/templates/templates/components/`: `principles/PRINCIPLES.md`
- From `/planning/`: `principles/PRINCIPLES.md`

## Cross-Reference Standards

### Standard Cross-Reference Section Template

```markdown
## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../index.md)
- [Browse commands index](../commands/index.md)
- [Study PRINCIPLES.md for framework](principles/PRINCIPLES.md)

### Related Components
- [Component 1 with action verb](component1.md)
- [Component 2 with action verb](component2.md)
- [Component 3 with action verb](component3.md)

### Framework References
- [Apply principle1.md for guidance](../principles/principle1.md)
- [Follow principle2.md for methodology](../principles/principle2.md)
- [Study principle3.md for context](../principles/principle3.md)

[⬆ Return to top](#section-title)
```

### Cross-Reference Categories

#### 1. Primary Navigation
**Purpose**: Essential framework navigation points
**Format**: `[Action verb to Location](relative-path)`

#### 2. Related Components
**Purpose**: Components within same category or workflow
**Format**: `[Action verb Component](component-name.md)`

#### 3. Framework References
**Purpose**: Principle and methodology references
**Format**: `[Action verb principle.md for context](../principles/principle.md)`

### Cross-Reference Section Order

1. **Primary Navigation** (Always first)
2. **Related Commands** (Commands only)
3. **Related Components** (Components and agents)
4. **Framework References** (Principles and methodology)
5. **Return to Top** (Always last)

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../index.md)
- [Study organization.md for principles](../principles/organization.md)
- [Browse components README.md](README.md)

### Related Components
- [Apply modular-design-patterns.md for atomic design](modular-design-patterns.md)
- [Follow hierarchical-structure-patterns.md for hierarchy](hierarchical-structure-patterns.md)
- [Use presentation-structure-patterns.md for delivery](presentation-structure-patterns.md)

### Framework References
- [Study organization.md for philosophy](../principles/organization.md)
- [Apply fundamental.md for simplicity](../principles/fundamental.md)
- [Follow communication.md for standards](../principles/communication.md)

[⬆ Return to top](#organization-structure-component)