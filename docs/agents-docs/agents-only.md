---
title: "AGENTS ONLY - Critical Directory Rule"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../docs/PRINCIPLES.md"]
prerequisites: ["Understanding of agent system architecture"]
audience: "System architects and developers"
purpose: "Enforce strict agent-only directory rule and prevent documentation mixing"
keywords: ["agents", "directory", "enforcement", "separation", "rule"]
last_review: "2025-08-18"
priority: "CRITICAL"
---

[Previous: Navigate to docs hub](../index.md) | [Return to hub for navigation](../index.md) | [Review PRINCIPLES.md for framework](../principles/PRINCIPLES.md) | [Next: Browse agent documentation](readme.md)

# AGENTS ONLY DIRECTORY

## Table of Contents
- [Absolute Rule](#absolute-rule)
- [Allowed Files](#allowed-files)
- [Forbidden Files](#forbidden-files)
- [Where Non-Agent Files Go](#where-non-agent-files-go)
- [Enforcement](#enforcement)
- [Current Valid Agents](#current-valid-agents)
- [Violations](#violations)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Absolute Rule

⚠️ **CRITICAL**: The `/agents/` directory **MUST CONTAIN ONLY AGENT FILES**.

⏺ **Principle**:  This rule implements [organization.md](../docs/principles/organization.md) by maintaining strict separation between executable agents and their documentation through modular architecture standards.

## Allowed Files

✅ **ONLY** files that are actual agents:
- Files following the agent-architect.md structure
- Files with agent YAML frontmatter (name, description, tools, model, color)
- Files that define AI agent behavior and capabilities

[⬆ Return to top](#agents-only-directory)

## Forbidden Files

❌ **NEVER** place these in `/agents/`:
- Documentation files (README.md, DEFINITION.md, etc.)
- Template files (AGENT_TEMPLATE.md, etc.)
- Component files (templates, snippets, etc.)
- Status files (STRUCTURE_STATUS.md, etc.)
- Configuration files
- Any non-agent file

[⬆ Return to top](#agents-only-directory)

## Where Non-Agent Files Go

All agent-related documentation, templates, and components **MUST** be placed in:

📁 `/docs/agents-documentation/`

This includes:
- [Review AGENT_DEFINITION.md for architecture](../docs/agents-documentation/AGENT_DEFINITION.md)
- [Apply AGENT_TEMPLATE.md to create agents](../docs/agents-documentation/AGENT_TEMPLATE.md)
- [Read README.md for documentation](../docs/agents-documentation/README.md)
- templates/components/
- Any documentation about agents
- Any templates for creating agents
- Any supporting files

[⬆ Return to top](#agents-only-directory)

## Enforcement

Before adding ANY file to `/agents/`:

1. ❓ **Ask**: Is this file an actual agent for invocation?
2. ✅ **If YES**: Place in `/agents/`
3. ❌ **If NO**: Place in `/docs/agents-documentation/`

[⬆ Return to top](#agents-only-directory)

## Current Valid Agents

As of 2025-08-18, the following are the ONLY valid files in `/agents/`:
- [Deploy agent-architect.md for agent creation](agent-architect.md) (Gold standard agent)
- [Use agent-creator.md to create new agents](agent-creator.md) (Creates new agents)
- [Consult delegation-advisor.md for routing](delegation-advisor.md) (Advises on delegation)
- [Execute migration-specialist.md for system migrations](migration-specialist.md) (Handles safe systematic migrations)
- [Execute project-optimizer.md for optimization](project-optimizer.md) (Optimizes projects)
- [Execute ticket-executor.md for ticket execution](ticket-executor.md) (Executes tickets systematically)
- [Follow AGENTS_ONLY.md for enforcement](AGENTS_ONLY.md) (This directive file)

## Agent Validation Requirements

⏺ **Principle**: All agents MUST implement validation protocols per [validation.md](../docs/principles/validation.md) comprehensive methodology for quality assurance.

### Required Agent Structure
✅ **ALL agents must include**:
- YAML frontmatter with name, description, tools, model, color
- Core Responsibilities section (minimum 5 areas)
- Operational Framework section
- **Validation Protocols section** (NEW REQUIREMENT)

### Validation Protocols Structure
**ALL agents must include these validation components**:
- **Pre-Execution Validation**: Input, resource, context, scope validation
- **Execution Validation**: Process compliance, quality standards, progress tracking
- **Post-Execution Validation**: Success criteria verification, quality gates, evidence collection
- **Completion Checklist**: Specific, measurable completion criteria

### Compliance Verification
- [ ] **All current agents updated** with validation protocols
- [ ] **New agents created** with validation requirements
- [ ] **Framework integration** verified and tested
- [ ] **Quality gates** applied consistently

[⬆ Return to top](#agents-only-directory)

## Violations

Any non-agent file found in `/agents/` is a **CRITICAL VIOLATION** and must be:
1. Immediately moved to `/docs/agents-documentation/`
2. All references updated
3. [Update PROJECT_STRUCTURE.md for file tracking](../PROJECT_STRUCTURE.md)

**THIS RULE IS ABSOLUTE AND NON-NEGOTIABLE**

[⬆ Return to top](#agents-only-directory)

## Principle References

⏺ **Relationship**: This enforcement rule operationalizes core principles:
- **[organization.md](../docs/principles/organization.md)**: Provides separation of concerns that this rule enforces
- **[fundamental.md](../docs/principles/fundamental.md)**: Supplies clarity principles that guide directory purpose
- **[files.md](../docs/principles/files.md)**: Informs file placement and naming conventions

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../docs/index.md)
- [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md)
- [Browse agents documentation](../docs/agents-documentation/README.md)
- [Review PROJECT_STRUCTURE.md for organization](../PROJECT_STRUCTURE.md)

### Related Documentation
- [Study organization.md for separation principles](../docs/principles/organization.md)
- [Follow files.md for naming conventions](../docs/principles/files.md)
- [Apply fundamental.md for clarity](../docs/principles/fundamental.md)

### Agent Resources
- [Review agent documentation guide](../docs/agents-documentation/README.md)
- [Apply AGENT_TEMPLATE.md to create agents](../docs/agents-documentation/AGENT_TEMPLATE.md)
- [Study AGENT_DEFINITION.md for architecture](../docs/agents-documentation/AGENT_DEFINITION.md)

