
---

**IF reading individually** → READ [STANDARDS.md](../STANDARDS.md#technical-standards) for context, THEN navigate to this specific standard


# Navigation Standardization

**Context**: Universal navigation patterns ensuring consistent user experience across all framework files

---

## Standard Overview

All markdown files in the .claude framework MUST include standardized navigation elements to ensure seamless user experience and framework discoverability.

## Required Navigation Elements

### 1. Universal Navigation Header
Every markdown file must include this navigation bar at the top:

```markdown

---

# File Title

**Context**: [Brief explanation of file's purpose and role in framework]

---
```

### 2. Navigation Components

#### Emoji Icons
- 🏠 **System Hub** - Always links to system/INDEX.md
- 📁 **Parent Directory** - Links to parent directory index
- 📖 **Current Section** - Links to current file's table of contents

#### Context Statement
Every file must include a **Context** statement explaining:
- The file's purpose
- Its role within the framework
- How it relates to other components

### 3. Link Paths

#### Relative Paths
- Use relative paths (`../INDEX.md`) for maintainability
- Ensure links work regardless of deployment location
- Test all navigation links for accuracy

#### Consistent Targets
- System Hub always points to `/system/INDEX.md`
- Parent Directory points to containing folder's index
- Section links use anchor tags for internal navigation

## Implementation Requirements

### Mandatory for All Files
- System index files (INDEX.md)
- Category index files (PRINCIPLES.md, BEHAVIORS.md, etc.)
- Individual component files (principles/*.md, behaviors/*.md, etc.)
- Example and template files

### Quality Criteria
- ✅ Navigation header present at file top
- ✅ All three navigation components included
- ✅ Context statement explaining file purpose
- ✅ Functional links with correct paths
- ✅ Consistent emoji usage and formatting

## Validation Process

### Automated Checking
The framework includes validation scripts that verify:
- Navigation header presence
- Link functionality
- Context statement inclusion
- Consistent formatting

### Manual Review
- Visual consistency across files
- Logical navigation flow
- Clear context explanations
- User experience quality

## Benefits

### User Experience
- **Predictable Navigation** - Users know exactly where to find navigation
- **Clear Context** - Every file explains its purpose
- **Seamless Exploration** - Easy movement between framework components

### Maintenance
- **Consistent Patterns** - Reduces cognitive load for updates
- **Automated Validation** - Ensures ongoing compliance
- **Professional Presentation** - Framework appears cohesive and polished

## Examples

### Top-Level Index
```markdown

---

# System INDEX

**Context**: Central navigation hub for the complete .claude framework
```

### Category Index
```markdown

---

# Principles

**Context**: Core decision-making guidelines that drive framework behavior
```

### Individual Component
```markdown

---

# Simplicity First

**Context**: Primary principle ensuring all decisions prioritize simplicity and ease of use
```

## Success Metrics

- **100% Compliance** - All framework files include required navigation
- **Zero Broken Links** - All navigation links function correctly
- **User Satisfaction** - Framework feels cohesive and easy to navigate
- **Maintenance Efficiency** - Navigation updates are automated and reliable

---

