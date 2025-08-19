
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

⏺ **Principle**:  This rule implements [organization.md](../principles/organization.md) by maintaining strict separation between executable agents and their documentation through modular architecture standards.

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
- [Read README.md for documentation](../commands-docs/README.md)
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
- [Deploy agent-architect.md for agent creation](../../agents/development/architecture/agent-architect.md) (Gold standard agent)
- [Use agent-creator.md to create new agents](../../agents/development/architecture/agent-creator.md) (Creates new agents)
- [Consult delegation-advisor.md for routing](../../agents/project-management/coordination/delegation-advisor.md) (Advises on delegation)
- [Execute migration-specialist.md for system migrations](../../agents/operations/infrastructure/migration-specialist.md) (Handles safe systematic migrations)
- [Execute project-optimizer.md for optimization](../../agents/project-management/coordination/project-optimizer.md) (Optimizes projects)
- [Execute ticket-executor.md for ticket execution](ticket-executor.md) (Executes tickets systematically)
- [Follow AGENTS_ONLY.md for enforcement](AGENTS_ONLY.md) (This directive file)

## Agent Validation Requirements

⏺ **Principle**: All agents MUST implement validation protocols per [validation.md](../principles/validation.md) comprehensive methodology for quality assurance.

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
3. [Update PROJECT_STRUCTURE.md for file tracking](../../PROJECT_STRUCTURE.md)

**THIS RULE IS ABSOLUTE AND NON-NEGOTIABLE**

[⬆ Return to top](#agents-only-directory)

## Principle References

⏺ **Relationship**: This enforcement rule operationalizes core principles:
- **[organization.md](../principles/organization.md)**: Provides separation of concerns that this rule enforces
- **[fundamental.md](../principles/fundamental.md)**: Supplies clarity principles that guide directory purpose
- **[files.md](../principles/files.md)**: Informs file placement and naming conventions

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](index.md)
- [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md)
- [Browse agents documentation](../commands-docs/README.md)
- [Review PROJECT_STRUCTURE.md for organization](../../PROJECT_STRUCTURE.md)

### Related Documentation
- [Study organization.md for separation principles](../principles/organization.md)
- [Follow files.md for naming conventions](../principles/files.md)
- [Apply fundamental.md for clarity](../principles/fundamental.md)

### Agent Resources
- [Review agent documentation guide](../commands-docs/README.md)
- [Apply AGENT_TEMPLATE.md to create agents](../docs/agents-documentation/AGENT_TEMPLATE.md)
- [Study AGENT_DEFINITION.md for architecture](../docs/agents-documentation/AGENT_DEFINITION.md)

