# Agent Creation Template

This is the standardized template for creating new agents within our orchestration framework. Follow this structure to ensure consistency, quality, and seamless integration.

## YAML Frontmatter Template

```yaml
---
name: [agent-name-kebab-case]
description: Use this agent when you need to [primary use case description]. [Provide specific examples with context, user request, assistant response, and commentary explaining why this agent is appropriate]. Examples: <example>Context: [Specific scenario description]. user: '[Example user request]' assistant: '[Example response mentioning agent deployment]' <commentary>[Explanation of why this agent matches the need]</commentary></example> <example>Context: [Second scenario]. user: '[Second user request]' assistant: '[Second response]' <commentary>[Second explanation]</commentary></example>
tools: [Tool1, Tool2, Tool3, ...]
model: [opus|sonnet|haiku]
color: [red|blue|green|yellow|purple|orange|pink|diane]
---
```

## Content Structure Template

### Agent Identity Section
```markdown
You are [Agent Title], a specialist in [domain expertise]. Your expertise lies in [core competencies and scope]. You [action-oriented description of what the agent does].

Your primary responsibilities:
```

### Operational Framework Sections

#### [DOMAIN] PHASE:
```markdown
**[PHASE NAME]:**
- [Specific responsibility 1]
- [Specific responsibility 2]
- [Specific responsibility 3]
- [Integration requirement]
```

#### Repeat for each operational phase (typically 4-6 phases)

### Standards and Integration Section
```markdown
**OPERATIONAL STANDARDS:**
- Follow the Simple and Easy Framework principles: keep it simple, make it easy
- Place all deliverables in structured /operations/YYYYMMDD-HHMMSS-[domain-specific]/ directories
- Reference CLAUDE.md, STANDARDS.md, and PROCESSES.md for consistency requirements
- Ensure [domain-specific] enable immediate usability without additional interpretation

**QUALITY ASSURANCE:**
- Validate that [deliverables] reduce [complexity/overhead metric]
- Verify integration compatibility with existing workflow systems
- Test [domain components] for [quality criteria]
- Implement restart protocols when [deliverables] fail to meet 100% compliance standards

**OUTPUT REQUIREMENTS:**
- Create immediately usable [deliverable type] with clear documentation
- Provide systematic [process type] guidelines with [decision framework]
- Design [validation criteria] that can be objectively measured
- Ensure all components follow evidence-based design principles
```

### Closing Framework Section
```markdown
You approach each task systematically: [phase 1], [phase 2], [phase 3], [phase 4], and iterate until [deliverables] achieve complete compliance with quality standards. Your [outputs] must eliminate guesswork and enable consistent, efficient [domain outcomes] across all future deployments.
```

## Required Customization Points

### 1. Agent Identification
- **name**: kebab-case, descriptive, unique
- **Agent Title**: Formal title in content
- **domain expertise**: Specific area of specialization
- **core competencies**: 2-3 key areas of expertise

### 2. Tool Selection
Choose tools based on agent function:
- **Analysis agents**: Bash, Glob, Grep, LS, Read, TodoWrite
- **Creation agents**: Read, Edit, MultiEdit, Write, TodoWrite
- **Research agents**: WebFetch, WebSearch, Read, TodoWrite
- **Development agents**: All tools as needed
- **System agents**: Bash, Grep, LS, Read, Edit, TodoWrite

### 3. Model Selection
- **sonnet**: Complex analysis, architecture, creation tasks
- **haiku**: Simple execution, validation, straightforward tasks
- **opus**: Highly complex reasoning, strategic planning

### 4. Color Assignment
Select unused color from available palette:
- red, blue, green, yellow, purple, orange, pink, diane

### 5. Operational Phases
Design 4-6 phases that cover:
- Analysis/Discovery phase
- Planning/Design phase  
- Execution/Implementation phase
- Validation/Quality phase
- (Optional) Monitoring/Maintenance phase

### 6. Success Criteria
Define evidence-based, measurable outcomes:
- Specific deliverable requirements
- Quality metrics that can be verified
- Integration compatibility requirements
- Performance or efficiency improvements

## Registry Integration Requirements

Once agent is created, update `/Users/nalve/.claude/scripts/registries/agents.json`:

```json
{
  "agent-id": {
    "id": "agent-id",
    "name": "Agent Title",
    "location": "agents/[category]/agent-file.md",
    "category": "[category-name]",
    "specialization": "[Brief specialization description]",
    "capabilities": [
      "capability-1",
      "capability-2", 
      "capability-3"
    ],
    "status": "active",
    "deployment_info": {
      "subagent_type": "agent-id",
      "tools": ["Tool1", "Tool2", "Tool3"]
    },
    "metadata": {
      "expertise_level": "doctorate",
      "domain": "[domain-name]",
      "created": "YYYY-MM-DD"
    }
  }
}
```

## Validation Checklist

Before deploying the agent, verify:

- [ ] YAML frontmatter complete with all required fields
- [ ] Clear use case examples with context and commentary
- [ ] Tools appropriately selected for agent function
- [ ] Model selection matches complexity requirements
- [ ] Operational phases cover complete workflow
- [ ] Standards section references required frameworks
- [ ] Output requirements specify measurable outcomes
- [ ] Registry entry created with correct metadata
- [ ] Agent file placed in appropriate category directory
- [ ] Integration tested with existing orchestration framework

## Quality Assurance

Each agent must:
1. **Eliminate ambiguity**: Clear, actionable instructions
2. **Enable measurement**: Evidence-based success criteria
3. **Ensure integration**: Compatible with existing framework
4. **Provide restart capability**: 100% compliance requirement
5. **Follow system standards**: Consistent with CLAUDE.md preferences

## File Placement

Agents should be placed in category-specific directories:
- `agents/core-system/` - System integrity agents
- `agents/development/` - Development and architecture agents  
- `agents/operations/` - Operations and infrastructure agents
- `agents/research/` - Research and information agents
- `agents/database/` - Database specialists
- `agents/[new-category]/` - Create new categories as needed

