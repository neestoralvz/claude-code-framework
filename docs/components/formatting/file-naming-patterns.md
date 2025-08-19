---
title: "File Naming Patterns Component"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../../../principles/formatting.md"]
purpose: "Define specific file naming patterns for different file types"
---

[Previous: Study naming-conventions.md for overview](naming-conventions.md) | [Return to hub for navigation](../../index.md)

# FILE NAMING PATTERNS COMPONENT

⏺ **Principle**: This component implements [formatting.md](../../principles/formatting.md) file naming standards for specific file types.

## Documents
- **Pattern**: `{TOPIC}-{subtopic}.md`
- **Rule**: CAPS for main topics, kebab-case for subtopics
- **Examples**:
  - `AGENT_DEFINITION.md` (main topic)
  - `transcription-superwhisper.md` (topic-subtopic)
  - `workflow-phases.md` (component)

## Agents
- **Pattern**: `{name}-{type}.md`
- **Rule**: All kebab-case
- **Examples**:
  - `agent-architect.md`
  - `project-optimizer.md` 
  - `delegation-advisor.md`

## Commands
- **Pattern**: `{action}-{object}.md`
- **Rule**: All kebab-case
- **Examples**:
  - `create-ticket.md`
  - `analyze-file.md`
  - `system-audit.md`

## Tickets
- **Pattern**: `{CODE}-{###}-{title-slug}.md`
- **Rule**: Prefix-number-title
- **Examples**:
  - `AUD-001-system-audit-foundation.md`
  - `DEV-042-agent-integration.md`
  - `DOC-015-principle-validation.md`

## Scripts
- **Pattern**: `{purpose}-{tool}.{ext}`
- **Rule**: Purpose-tool with appropriate extension
- **Examples**:
  - `backup-system.sh`
  - `validate-links.py`
  - `deploy-agents.js`

[Return to naming-conventions.md](naming-conventions.md)