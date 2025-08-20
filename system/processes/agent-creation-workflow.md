# Agent Creation Workflow
**Context**: Systematic process for creating, deploying, and managing specialized agents within the framework
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


## When To Use
- Creating new specialized agents
- Need tactical expertise for specific domains
- Standardizing agent deployment patterns
- Building reusable agent capabilities

## Agent Creation Framework
Complete template and deployment guidelines available in operations/20250819-192114-agent-template-creation/ - includes standardized YAML frontmatter, operational phases, quality assurance, and registry integration.

**Color Categories**: Red, Blue, Green, Yellow, Purple, Orange, Pink, Cyan

## Proactive Agent Creation
When deploying an agent that doesn't exist yet, create it using our agent creation framework so it's available for future use.

## Agent Creation Process

### 1. Identify Need
- Define specific tactical domain requiring expertise
- Determine if existing agents can handle the requirement
- Assess complexity and specialization level needed

### 2. Design Agent
- READ operations/20250819-192114-agent-template-creation/ for complete template
- Define agent purpose, tools, and operational phases
- Establish quality assurance criteria
- Choose appropriate color category

### 3. Create Agent File
- Use standardized YAML frontmatter format
- Include operational phases and quality criteria
- Document agent capabilities and limitations
- Add to appropriate agents/ subdirectory by category

### 4. Registry Integration
- Add agent to agents/registry/ for discovery
- Include agent capabilities and use cases
- Document strategic integration patterns

### 5. Test Deployment
- Deploy agent in controlled scenario
- Validate agent performance against criteria
- Refine agent based on initial results

### 6. Documentation
- Update agent registry with lessons learned
- Document successful deployment patterns
- Add to framework knowledge base

## Agent Standards
Agents must follow:
- **Directory Purity**: Only agent files in /agents/ directory, no INDEX.md files
- **Category Organization**: Organized in subdirectories by specialization
- **Registry Discovery**: Discoverable through system navigation and registries
- **Strategic Reporting**: Provide executive summaries for orchestrator consumption

## Related Documentation
When creating agents, READ these files:
- **Template Guidelines**: READ operations/20250819-192114-agent-template-creation/ for complete creation framework
- **Agent Registry**: READ agents/registry/ to avoid duplication and understand patterns
