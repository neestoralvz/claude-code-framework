---
title: "Alert Blocks"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../principles/communication.md"]
audience: "Documentation creators"
purpose: "Standardized alert block templates"
keywords: ["alerts", "warnings", "notes", "blocks"]
---

[Previous: communication-templates.md](communication-templates.md) | [Hub](../index.md) | [Next: organization-structure.md](organization-structure.md)

# ALERT BLOCKS

⏺ **Principle**: Implements [communication.md](../principles/communication.md) through standardized visual hierarchy for critical information.

## Block Types

### Available Blocks
```markdown
⏺ **Principle**: Implements [principle.md](path) through [method].
⚠️ **WARNING**: [Critical information requiring immediate attention]
🔴 **IMPORTANT**: [Essential information that must be understood]
📋 **NOTE**: [Supplementary information that adds context]
💡 **TIP**: [Helpful suggestion or best practice]
✅ **STATUS**: [Current status or completion]
❌ **ERROR**: [Error description and resolution guidance]
```

## Usage Guidelines

### Selection Criteria
- **Principle**: First in major sections
- **Warning**: Risks, breaking changes, security
- **Important**: Requirements, prerequisites, critical steps
- **Note**: Context, clarifications, additional info
- **Tip**: Optimizations, shortcuts, best practices
- **Status**: Operation results, progress
- **Error**: Failures, problems, troubleshooting

### Placement Rules
1. Principle blocks → Start of major sections
2. Warning blocks → Before risky actions
3. Important blocks → Before critical steps
4. Note blocks → After explanations
5. Status/Error blocks → After operations

## Formatting Standards

### Structure
```markdown
[Emoji] **[TYPE]**: [Content with clear, actionable information]
```

### Content Guidelines
- **Concise**: Brief and focused
- **Actionable**: Clear next steps
- **Specific**: Concrete details
- **Imperative**: Command tone

### Visual Hierarchy
- **Principle**: ⏺ (foundational context)
- **Critical**: 🔴 ⚠️ ❌ (immediate attention)
- **Info**: 📋 💡 ✅ (supplementary)

## Examples

### Principle Reference
```markdown
⏺ **Principle**: Implements [workflow.md](../principles/workflow.md) through systematic phases.
```

### Warning
```markdown
⚠️ **WARNING**: This operation permanently deletes all tickets. Ensure backup first.
```

### Status
```markdown
✅ **STATUS**: Processed 12 tickets, completed 8, resolved 3, pending 1.
```

## Benefits
- **Consistency**: Standardized visual hierarchy
- **Communication**: Clear urgency levels
- **Maintenance**: Easy identification and updates

## Cross-References
- [Hub](../index.md) | [PRINCIPLES.md](principles/PRINCIPLES.md) | [README.md](README.md)
- [communication.md](../principles/communication.md) | [formatting.md](../principles/formatting.md)