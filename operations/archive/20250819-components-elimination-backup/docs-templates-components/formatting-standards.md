
[Previous: category-header-templates.md](category-header-templates.md) | [Next: imperative-tone-patterns.md](imperative-tone-patterns.md)

# FORMATTING STANDARDS COMPONENT

⏺ **Principle**: This component implements [formatting.md](../../principles/formatting.md) consistency philosophy through specific formatting rules and patterns.

## Document Structure Standards

### Header Hierarchy
```markdown
# Document Title (H1 - Title case, document level)
## Section Title (H2 - Title case, main sections)
### Subsection Title (H3 - Title case, subsections)
#### Detail Header (H4 - Title case, specific details)
```

### Text Formatting Rules
- Use **bold** for emphasis and key terms
- Use *italics* sparingly for subtle emphasis
- Use UPPERCASE for system directives and constants
- Use symbols (→, •, ✓) for visual hierarchy
- Use `code formatting` for technical terms and values

### List Structure Standards
```markdown
# Numbered Lists (Sequential processes)
1. First step description
2. Second step description
3. Third step description

# Bullet Lists (Related items)
- First item description
- Second item description
- Third item description

# Sublists (Hierarchical content)
- Main category
  - Subcategory item
  - Subcategory item
    - Detail level item
```

## Naming Conventions Implementation

### File Naming Patterns
- **Documents**: `{TOPIC}-{subtopic}.md` (CAPS for main topics)
- **Agents**: `{name}-{type}.md` (all kebab-case)
- **Commands**: `{action}-{object}.md` (all kebab-case)
- **Components**: `{feature}-{type}.md` (all kebab-case)

### Case Format Standards
- **kebab-case**: Files, directories, URLs
- **camelCase**: JavaScript variables and functions
- **PascalCase**: Classes, components, types
- **snake_case**: Python variables and functions
- **SCREAMING_SNAKE_CASE**: Constants and environment variables

## Link Format Implementation

### Mandatory Link Structure
Every link MUST include:
1. **Action verb** - What to do
2. **Use case** - Why to click
3. **Clear path** - Where it leads
4. **Heading anchor** - Direct section reference when applicable

**Format**: `[ACTION VERB + USE CASE](path#heading-anchor)`

### Action Verb Vocabulary
- **Read**: For understanding concepts or reviewing content
- **Study**: For deep learning and comprehension
- **Apply**: For implementing patterns or procedures
- **Execute**: For running commands or processes
- **Deploy**: For activating tools or components
- **Follow**: For step-by-step procedures
- **Review**: For examining existing content
- **Browse**: For exploring collections or indexes
- **Navigate**: For moving between locations

## Navigation Standards

### Document Navigation Patterns
```markdown
# Breadcrumb Navigation (Top of document)
[Previous: document-name.md](path/to/previous.md) | [Return to hub](../philosophy/index.md) | [Next: document-name.md](path/to/next.md)

# Section Navigation (After major sections)
[⬆ Return to top](#document-title)

# Table of Contents (Long documents)
## Table of Contents
- [Purpose](#purpose)
- [Architecture](#architecture)
- [Available Components](#available-components)
- [Usage Guidelines](#usage-guidelines)
- [Implementation Guide](#implementation-guide)
- [Benefits](#benefits)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Code Block Standards

### Documentation Block Types
```markdown
# Bash blocks (executable scripts only)
```bash
#!/bin/bash
executable-command
```

# Language blocks (actual code)
```javascript
function exampleCode() {
  return "actual implementation";
}
```

# Markdown blocks (documentation examples)
```markdown
# Example Documentation Structure
## Section Header
- List item example
```

### Documentation Standards
- **NEVER** use bash code blocks for documentation content
- **ALWAYS** use markdown code blocks for documentation examples
- **Bash blocks**: Only for executable scripts
- **Language blocks**: For actual code in that language
- **Markdown blocks**: For documentation formatting examples

## Metadata Standards

**[Apply organization.md for comprehensive metadata standards](../principles/organization.md#documentation-metadata-standards)**

All document metadata standards, field requirements, validation rules, and YAML templates are now consolidated in the organization principle for systematic metadata structure.

## Principle Reference Implementation

### Component-Principle Relationship Format
```markdown
⏺ **Principle**: This component implements [principle-name.md](../principles/principle-name.md) by [specific implementation description].
```

### Relationship Documentation Requirements
- Clearly state which principle is being applied
- Explain how the component implements the principle
- Specify why this principle is relevant to the component
- Use explicit language patterns:
  - "This component follows [principle] by..."
  - "In accordance with [principle], this..."
  - "Applying [principle] to achieve..."

## Cross-References
- [Use action-header-templates.md for action sections](action-header-templates.md)
- [Apply category-header-templates.md for reference sections](category-header-templates.md)
- [Follow imperative-tone-patterns.md for language](imperative-tone-patterns.md)
- [Apply link-standards.md for comprehensive link formatting](formatting/link-standards.md)
- [Use naming-conventions.md for comprehensive naming standards](formatting/naming-conventions.md)
- [Follow code-block-standards.md for comprehensive formatting rules](formatting/code-block-standards.md)
