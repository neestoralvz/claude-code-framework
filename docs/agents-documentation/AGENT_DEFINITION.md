---
title: Agent Definition and Architecture
author: System
date: 2025-08-18
version: 3.0.0
purpose: "Define agent architecture and composition standards"
keywords: ["agent", "architecture", "definition", "composition", "standards"]
dependencies: ["components/", "AGENT_TEMPLATE.md", "../PRINCIPLES.md", "../../agents/agent-architect.md"]
location: /docs/agents-documentation/
---

# Agent Definition and Architecture

## What is an Agent?

⏺ **Principle**: This definition implements [engineering.md](../principles/engineering.md) by providing standardized agent architecture and applies [organization.md](../principles/organization.md) through systematic composition structure.

An agent is a specialized AI entity with focused expertise, designed to extend system capabilities dynamically.

## Core Characteristics

1. **Focused Expertise**: Narrow, deep expertise over broad capabilities
2. **Clear Triggers**: Unambiguous activation conditions
3. **Tool Precision**: Minimal necessary tools matched to responsibilities
4. **System Integration**: Seamless interaction with orchestrator
5. **Unique Value**: Each agent adds distinct capability

## Agent Composition

### 1. YAML Frontmatter
```yaml
---
name: agent-name
description: Comprehensive description with examples
tools: [Required tools list]
model: sonnet
color: green/blue/yellow/red/purple
---
```

**Required Elements**:
- **name**: Kebab-case identifier
- **description**: Usage scenarios with `<example>` blocks
- **tools**: Specific required tools
- **model**: AI model (typically `sonnet`)
- **color**: Visual identifier

### 2. Agent Identity
```markdown
You are an [Expert Title], expert in [domain]. Your expertise spans [areas].

**Your Mission**: You [primary objective] that [value proposition].
```

### 3. Core Capabilities
List specific functions and expertise areas the agent provides.

### 4. Tool Requirements
Specify exact tools needed for agent functionality.

### 5. Integration Points
Define how agent interacts with system and other agents.

## Creation Process

### Use Agent-Architect
```bash
# Deploy agent-architect for new agent creation
Task: agent-architect --create-agent [domain] [capabilities]
```

### Standard Template
1. Copy from AGENT_TEMPLATE.md
2. Customize for specific domain
3. Define tool requirements
4. Create usage examples
5. Test integration

## Validation Criteria

### Architecture Requirements
- [ ] Clear domain focus
- [ ] Minimal tool set
- [ ] Unambiguous triggers
- [ ] System integration defined
- [ ] Unique value proposition

### Documentation Standards
- [ ] Complete YAML frontmatter
- [ ] Usage examples provided
- [ ] Tool justification included
- [ ] Integration points defined

## Agent Categories

### Operational Agents
- **project-optimizer**: Project analysis and improvement
- **agent-architect**: Agent creation and design
- **delegation-advisor**: Task routing guidance

### Specialized Agents
- **agent-creator**: Automated agent generation
- **general-purpose**: Multi-domain capability

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../index.md)
- [Browse agent templates](AGENT_TEMPLATE.md)
- [Study system principles](../PRINCIPLES.md)

### Agent Examples
- [Reference agent-architect for gold standard](../../agents/agent-architect.md)
- [Use agent-creator for automation](../../agents/agent-creator.md)
- [Deploy project-optimizer for improvements](../../agents/project-optimizer.md)

### Related Documentation
- [Apply agent creation methodology](README.md)
- [Use component templates](components/README.md)
- [Follow separation guidelines](SEPARATION_COMPLETE.md)

[⬆ Return to top](#agent-definition-and-architecture)