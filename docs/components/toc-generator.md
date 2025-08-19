---
title: "Table of Contents Generator Component"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../principles/formatting.md", "../principles/organization.md"]
prerequisites: ["Understanding of document structure", "Knowledge of markdown formatting"]
audience: "Documentation creators and maintainers"
purpose: "Provide standardized Table of Contents patterns for consistent document navigation"
keywords: ["toc", "table-of-contents", "navigation", "structure", "component"]
last_review: "2025-08-18"
---

[Previous: Apply directive-implementation.md for load order](directive-implementation.md) | [Return to Documentation Hub for navigation](../index.md) | [Master PRINCIPLES.md for framework](../PRINCIPLES.md) | [Next: Study footer.md for navigation termination](footer.md)

# TABLE OF CONTENTS GENERATOR COMPONENT

## Table of Contents
- [Purpose](#purpose)
- [Architecture](#architecture)
- [Available Components](#available-components)
- [Usage Guidelines](#usage-guidelines)
- [Implementation Guide](#implementation-guide)
- [Benefits](#benefits)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Purpose
Standardize Table of Contents structure across all documentation types, eliminating duplication and ensuring consistent navigation patterns.

⏺ **Principle**: This component implements [organization.md](../principles/organization.md) by providing systematic TOC patterns that ensure logical content flow and user-friendly navigation through hierarchical structure standards.

[⬆ Return to top](#table-of-contents-generator-component)

## TOC Patterns

### Standard Pattern (Most Common)
```markdown
## Table of Contents
- [Core Section 1](#core-section-1)
- [Core Section 2](#core-section-2)
- [Implementation](#implementation)
- [Guidelines/Standards](#guidelines-standards)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)
```

### Extended Pattern (Complex Documents)
```markdown
## Table of Contents
- [Overview/Purpose](#overview-purpose)
- [Main Content Sections](#main-content-sections)
  - [Subsection A](#subsection-a)
  - [Subsection B](#subsection-b)
- [Implementation/Usage](#implementation-usage)
- [Examples](#examples)
- [Validation/Criteria](#validation-criteria)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)
```

### Minimal Pattern (Simple Documents)
```markdown
## Table of Contents
- [Core Content](#core-content)
- [Implementation](#implementation)
- [Cross-References](#cross-references)
```

[⬆ Return to top](#table-of-contents-generator-component)

## Document Types

### Command Documents
**Pattern**: Extended with execution focus
```markdown
## Table of Contents
- [Definition](#definition)
- [Structure](#structure)
- [Execution Phases](#execution-phases)
- [Parameters](#parameters)
- [Success Criteria](#success-criteria)
- [Usage Examples](#usage-examples)
- [Implementation Template](#implementation-template)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)
```

### Principle Documents
**Pattern**: Standard with philosophy focus
```markdown
## Table of Contents
- [Core Principle/Definition](#core-principle-definition)
- [Standards/Guidelines](#standards-guidelines)
- [Implementation](#implementation)
- [Validation](#validation)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)
```

### Component Documents
**Pattern**: Standard with architecture focus
```markdown
## Table of Contents
- [Purpose](#purpose)
- [Architecture/Structure](#architecture-structure)
- [Available Components](#available-components)
- [Usage Guidelines](#usage-guidelines)
- [Benefits](#benefits)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)
```

### Agent Documents
**Pattern**: Minimal (agents use YAML only)
```markdown
# No TOC required - agents use minimal YAML frontmatter only
```

[⬆ Return to top](#table-of-contents-generator-component)

## Generation Rules

### Required Sections (All Documents)
1. **Principle References** - Always include
2. **Cross-References** - Always include
3. **Return to top links** - After each major section

### Optional Sections (Context-Dependent)
- **Overview/Purpose** - For complex documents
- **Examples** - When examples add clarity
- **Validation/Criteria** - For implementation documents
- **Architecture** - For structural documents

### Formatting Standards
- Use sentence case for headers
- Maximum 2 nesting levels
- Anchor links use kebab-case
- Include "Return to top" after major sections

### Content Organization Priority
1. **Introduction/Overview** (if needed)
2. **Core Content** (main sections)
3. **Implementation/Usage**
4. **Examples** (if helpful)
5. **References** (always last two sections)

[⬆ Return to top](#table-of-contents-generator-component)

## Implementation Guide

### Step 1: Identify Document Type
- Command: Use extended pattern with execution focus
- Principle: Use standard pattern with guidelines focus  
- Component: Use standard pattern with architecture focus
- Documentation: Use pattern based on complexity

### Step 2: Select Core Sections
- Minimum 3 sections (content + 2 references)
- Maximum 8 sections (prevents overwhelming users)
- Group related subsections under main headings

### Step 3: Apply Formatting Rules
```markdown
## Table of Contents
- [Section Name](#section-name)
  - [Subsection](#subsection) 
- [Another Section](#another-section)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)
```

### Step 4: Add Navigation Links
- Include after each major section: `[⬆ Return to top](#document-title)`
- Ensure all anchor links work correctly
- Test navigation flow

[⬆ Return to top](#table-of-contents-generator-component)

## Principle References

⏺ **Relationship**: This component operationalizes multiple principles through systematic TOC generation:
- **[organization.md](../principles/organization.md)**: Provides structural principles for logical content flow and navigation hierarchy
- **[formatting.md](../principles/formatting.md)**: Supplies formatting standards for consistent TOC presentation and link structures
- **[communication.md](../principles/communication.md)**: Informs clear, actionable section naming conventions

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../index.md)
- [Study PRINCIPLES.md for framework](../PRINCIPLES.md)
- [Learn COMMANDS.md for implementation](../COMMANDS.md)
- [Return to components README.md for architecture](README.md)

### Related Principles
- [Apply organization.md for structure](../principles/organization.md)
- [Follow formatting.md for standards](../principles/formatting.md)
- [Use communication.md for clarity](../principles/communication.md)

### Related Components
- [Study navigation.md for link patterns](navigation.md)
- [Apply workflow-phases.md for execution](workflow-phases.md)
- [Use footer.md for document termination](footer.md)

[⬆ Return to top](#table-of-contents-generator-component)