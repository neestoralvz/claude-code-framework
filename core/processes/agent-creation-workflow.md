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

### Model Selection Guidelines

**Available Models:**
- `opus` - Most capable model for complex reasoning, advanced development, sophisticated analysis (highest complexity)
- `sonnet` - Balanced model for standard development tasks, strategic planning, multi-step workflows (most common)
- `haiku` - Fast model for validation, system maintenance, simple checks (lowest complexity, highest speed)

**Model Selection Criteria:**
- Use `opus` for: Most complex reasoning tasks, advanced architectural decisions, sophisticated code analysis, complex multi-agent coordination, novel problem solving
- Use `sonnet` for: Standard development, strategic planning, multi-step workflows, code generation, integration work, most agent tasks
- Use `haiku` for: Fast validation, simple checks, maintenance operations, status reporting, basic automation

### Color Selection Guidelines

**Evidence-Based Color Categories** (from agent analysis):
- `cyan` - System/strategic agents (most common: 5 agents)
- `orange` - Operations/testing agents (3 agents)
- `blue` - Architecture/implementation agents (3 agents)
- `purple` - Integration/creation agents (2 agents)
- `green` - Design/interface agents (2 agents)
- `red` - Quality/testing agents (1 agent)
- `yellow` - Performance/analysis agents (2 agents)
- `pink` - Template/pattern agents (2 agents)
- `diane` - Maintenance/validation agents (1 agent)

**Color Usage Patterns:**
- Use consistent colors within functional categories
- Consider terminal visibility and distinction
- Both lowercase and capitalized forms are accepted (`cyan`/`Cyan`)

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
- **Select model**: Choose `opus` for most complex reasoning, `sonnet` for standard tasks, `haiku` for simple validation
- **Select color**: Use evidence-based color categories aligned with agent function
- Validate model/color choices against existing agent patterns

### 3. Create Agent File
- Use standardized YAML frontmatter format with model and color specifications
- Include operational phases and quality criteria
- Document agent capabilities and limitations
- Add to appropriate agents/ subdirectory by category
- **Required header format:**
  ```yaml
  ---
  name: agent-name
  description: Agent description with examples
  tools: [list of tools]
  model: opus|sonnet|haiku
  color: colorname
  ---
  ```

### 4. Registry Integration
- Add agent to agents/registry/ for discovery
- Include agent capabilities and use cases
- Document strategic integration patterns

### 5. Test Deployment with TDD/BDD Validation
- Deploy agent in controlled scenario with TDD/BDD requirements
- Validate agent TDD cycle compliance (red-green-refactor evidence)
- Validate agent BDD scenario implementation (behavior demonstration)
- Test agent evidence collection capabilities
- Validate cross-agent compatibility (if applicable)
- Refine agent based on TDD/BDD compliance results

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
- **TDD/BDD Compliance**: Must demonstrate TDD/BDD capability and evidence collection
- **Cross-Agent Compatibility**: Must be able to integrate with other agents
- **Quality Standards**: Must meet consistent quality and evidence requirements

## Related Documentation
When creating agents, READ these files:
- **Template Guidelines**: READ operations/20250819-192114-agent-template-creation/ for complete creation framework
- **Model/Color Analysis**: READ operations/20250820-061303-agent-model-color-documentation/agent-options-analysis.md for evidence-based model and color selection guidance
- **Agent Registry**: READ agents/registry/ to avoid duplication and understand patterns
- **TDD/BDD Compliance**: READ operations/20250820-155000-agent-coordination-templates/agent-specialization-tdd-compliance.md for agent TDD/BDD requirements
- **Agent Coordination**: READ [agent-coordination-tdd-workflow.md](agent-coordination-tdd-workflow.md) for multi-agent coordination patterns
