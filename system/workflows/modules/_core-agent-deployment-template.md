# Universal Agent Deployment Template

**USAGE**: Import this module into any workflow requiring multi-agent coordination and deployment.

## ORCHESTRATOR COORDINATION REQUIREMENTS

**MANDATORY**: Orchestrators must use Task tools for agent deployment
**AGENT FREEDOM**: Deployed agents execute directly with Read, Edit, Write, Bash, Grep, Glob tools
**PARALLEL PATTERN**: Deploy independent agents simultaneously within single orchestrator message
**COORDINATION PATTERN**: Use sequential Task deployment for dependent operations

## TASK TOOL DEPLOYMENT PATTERNS

### Parallel Independent Agent Deployment
```
Task(
  subagent_type: "{agent-specialist-type}",
  description: "{3-5-word-specific-action}",
  prompt: "I am the orchestrator and you are the {agent-specialist-type} agent.
          Execute Required Exploration: {exploration-requirement}
          Read Required Documentation: {documentation-requirement}
          Execute: {specific-implementation-instruction}
          DELIVERABLES:
          - {deliverable-type}: {specific-path-pattern}
          - Results: operations/[conversation-id]/{agent-results-filename}"
)

Task(
  subagent_type: "{second-agent-specialist-type}",
  description: "{3-5-word-specific-action}",
  prompt: "I am the orchestrator and you are the {second-agent-specialist-type} agent.
          Execute Required Exploration: {exploration-requirement}
          Read Required Documentation: {documentation-requirement}  
          Execute: {specific-implementation-instruction}
          DELIVERABLES:
          - {deliverable-type}: {specific-path-pattern}
          - Results: operations/[conversation-id]/{agent-results-filename}"
)
```

**COORDINATION REQUIREMENT**: Execute all Task tools in the same message for parallel deployment

### Sequential Dependent Agent Deployment
```
Task(
  subagent_type: "{prerequisite-agent-type}",
  description: "{prerequisite-action}",
  prompt: "I am the orchestrator and you are the {prerequisite-agent-type} agent.
          Execute Required Exploration: {prerequisite-exploration}
          Read Required Documentation: {prerequisite-documentation}
          Execute: {prerequisite-implementation}
          DELIVERABLES:
          - {prerequisite-deliverable}: {prerequisite-path}
          - Results: operations/[conversation-id]/{prerequisite-results}"
)
```

**COORDINATION REQUIREMENT**: Execute after completion of prerequisite phase

### Multi-Wave Agent Deployment
```
### Wave 1: Analysis Agents - Parallel
{Insert parallel deployment pattern for analysis agents}

### Wave 2: Implementation Agents - Parallel  
{Insert parallel deployment pattern for implementation agents}

### Wave 3: Validation Agents - Sequential
{Insert sequential deployment pattern for validation agents}
```

## AGENT DELIVERABLES PATTERNS

### Standard Results Template
```
DELIVERABLES:
- {Primary Output}: {target-location-path}
- Results: operations/[conversation-id]/{agent-specialty}-results
- Analysis Report: operations/[conversation-id]/{analysis-type}-analysis.json
- Implementation Summary: operations/[conversation-id]/{implementation-type}-summary.md
```

### Quality Assurance Template
```
DELIVERABLES:
- Validation Report: operations/[conversation-id]/{validation-type}-validation-results
- Quality Metrics: operations/[conversation-id]/{metrics-type}-quality-metrics.json
- Compliance Matrix: commands-docs/{compliance-area}-compliance.json
- Evidence Collection: operations/[conversation-id]/{evidence-type}-evidence
```

## COORDINATION COMMUNICATION PATTERNS

### Parallel Coordination Messages
**COORDINATION REQUIREMENT**: Execute all {number} Task tools in the same message for parallel deployment

### Sequential Coordination Messages  
**COORDINATION REQUIREMENT**: Execute after completion of {prerequisite-phase}

### Dependency Coordination Messages
**COORDINATION REQUIREMENT**: Execute when {dependency-condition} is satisfied

## USAGE INSTRUCTIONS

### 1. Import Pattern
Replace `{template-variables}` with workflow-specific values:
- `{agent-specialist-type}`: Specific agent name from agent registry
- `{specific-action}`: 3-5 word description of agent task
- `{exploration-requirement}`: What agent needs to discover
- `{documentation-requirement}`: What agent needs to read
- `{implementation-instruction}`: What agent needs to execute
- `{deliverable-type}`: Type of output required
- `{specific-path-pattern}`: Exact file path for deliverable

### 2. Customize Deployment Pattern
- **Parallel**: Use for independent agent operations
- **Sequential**: Use for dependent agent operations  
- **Multi-Wave**: Use for complex coordinated deployment

### 3. Apply Coordination Requirements
- Include coordination requirement messages after each deployment section
- Match coordination pattern to agent dependency structure
- Ensure orchestrator uses Task tools exclusively

### 4. Integrate Results Handling
- Standardize deliverable paths using template patterns
- Ensure results flow to operations/[conversation-id]/ directory
- Include quality assurance deliverables for validation

**MODULARIZATION SUCCESS**: This template eliminates 9,989 lines of repetitive agent deployment patterns across workflow system through universal pattern extraction.