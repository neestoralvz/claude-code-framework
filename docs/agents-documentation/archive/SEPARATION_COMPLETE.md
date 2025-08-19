---
title: Agent/Documentation Separation Complete
date: 2025-01-18
version: 1.0.0
---

# ✅ Separation Complete: Agents vs Documentation

## Directory Structure Enforcement

### `/agents/` Directory (AGENTS ONLY)
**Current Contents:**
- `AGENTS_ONLY.md` - The critical rule file
- `agent-architect.md` - Gold standard agent
- `agent-creator.md` - Agent creation agent
- `delegation-advisor.md` - Delegation advisor agent
- `project-optimizer.md` - Project optimization agent

**Rule:** ONLY actual agent files that can be invoked

### `/docs/agents-documentation/` Directory (DOCUMENTATION ONLY)
**Current Contents:**
- `README.md` - Main documentation
- `AGENT_DEFINITION.md` - Architecture guide
- `AGENT_TEMPLATE.md` - Template for new agents
- `STRUCTURE_STATUS.md` - Structure tracking
- `SEPARATION_COMPLETE.md` - This file
- `components/` - Modular templates directory
  - Component templates based on agent-architect.md
  - Usage guide and all template files

**Rule:** ALL non-agent files (docs, templates, components)

## Key Changes Made

1. **Moved from `/agents/` to `/docs/agents-documentation/`:**
   - AGENT_DEFINITION.md
   - AGENT_TEMPLATE.md
   - README.md
   - STRUCTURE_STATUS.md
   - components/ (entire directory)

2. **Created enforcement file:**
   - AGENTS_ONLY.md in `/agents/` stating the absolute rule

3. **Updated all references:**
   - Fixed paths in moved files
   - Added warnings about the separation
   - Updated navigation links

## Enforcement Going Forward

### Before Adding to `/agents/`:
1. ❓ Is this an actual agent for invocation?
2. ✅ If YES → `/agents/`
3. ❌ If NO → `/docs/agents-documentation/`

### File Types:
| File Type | Location |
|-----------|----------|
| Agent files (.md with agent YAML) | `/agents/` |
| Documentation | `/docs/agents-documentation/` |
| Templates | `/docs/agents-documentation/` |
| Components | `/docs/agents-documentation/components/` |
| Guides | `/docs/agents-documentation/` |
| Status files | `/docs/agents-documentation/` |

## Verification

Run this to verify separation:
```bash
ls /Users/nalve/.claude/agents/
# Shows ONLY: agent files + AGENTS_ONLY.md

ls /Users/nalve/.claude/docs/agents-documentation/
# Shows: All documentation, templates, components
```

---
**This separation is PERMANENT and ABSOLUTE**