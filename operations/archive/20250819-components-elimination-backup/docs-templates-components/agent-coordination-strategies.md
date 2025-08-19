
[Previous: Study task analysis framework](task-analysis-framework.md) | [Return to components index](README.md) | [Study component usage](../../components/COMPONENT_USAGE.md) | [Next: Review orchestration protocols](orchestration-protocols.md)

# AGENT COORDINATION STRATEGIES

⏺ **Principle**: This coordination methodology implements [context-efficiency.md multi-agent coordination](../principles/context-efficiency.md#context-handoff-protocol) through systematic execution pattern optimization.

## Parallel Execution Strategy

⏺ **Principle**: Parallel execution maximizes efficiency through concurrent Task Tool deployment within single responses, enabling simultaneous agent operations across multiple specialized domains.

### When to Use Parallel Execution
- **Independent subtasks** with no shared dependencies
- **Time optimization critical** for user experience
- **Resource capacity available** for concurrent operations
- **Results can be integrated** without conflicts
- **Same agent type needed** for multiple similar operations

### Concurrent Task Tool Deployment Framework

#### Single Response Multi-Agent Deployment
- **Launch multiple Task Tool calls simultaneously** within one response message
- **Deploy up to 10 instances** of the same agent type for parallel operations
- **Execute different agent types concurrently** for diverse task components
- **Maintain coordination** without inter-agent communication

#### Wave-Based Deployment Strategy
```
WAVE 1: Deploy initial parallel agents (up to 10 concurrent)
WAIT: Collect all Wave 1 results
WAVE 2: Deploy follow-up agents using Wave 1 outputs
WAVE 3: Continue pattern based on dependency requirements
```

### Parallel Deployment Method
1. **Verify task independence** - Confirm no shared resources or dependencies
2. **Prepare parallel contexts** - Extract relevant information for each agent
3. **Deploy simultaneously** - Launch multiple Task Tool calls in single response
4. **Monitor coordination** - Track progress without interference
5. **Execute wave strategy** - Deploy subsequent waves based on results
6. **Integrate results** - Combine outputs systematically

### Parallel Execution Examples

#### Multi-Domain Analysis
```
USER REQUEST: "Analyze the frontend, backend, and database components"
PARALLEL STRATEGY:
- Deploy frontend-analyzer agent
- Deploy backend-analyzer agent  
- Deploy database-analyzer agent
- Integrate all analysis results
```

#### Same-Agent Multi-Instance
```
USER REQUEST: "Optimize all service modules individually"
PARALLEL STRATEGY:
- Deploy service-optimizer agent for auth-service
- Deploy service-optimizer agent for user-service
- Deploy service-optimizer agent for payment-service
- Deploy service-optimizer agent for notification-service
- Integrate optimization recommendations
```

#### Wave-Based Complex Operations
```
USER REQUEST: "Comprehensive application modernization"
WAVE 1 (Parallel Analysis):
- Deploy legacy-analyzer agent
- Deploy dependency-analyzer agent
- Deploy performance-analyzer agent

WAVE 2 (Based on Wave 1):
- Deploy modernization-planner using all analysis results

WAVE 3 (Parallel Implementation):
- Deploy frontend-modernizer agent
- Deploy backend-modernizer agent
- Deploy infrastructure-modernizer agent
```

## Sequential Execution Strategy

### When to Use Sequential Execution
- **Strict dependencies exist** between task components
- **Later tasks require prior results** as input
- **Resource conflicts prevent** concurrent execution
- **Quality gates must be enforced** at each stage

### Sequential Deployment Method
1. **Map dependency chain** - Identify execution order requirements
2. **Deploy first agent** - Execute initial task completely
3. **Validate intermediate results** - Ensure quality before proceeding
4. **Pass context forward** - Provide results to next agent
5. **Continue chain** - Repeat until completion

### Sequential Execution Examples
```
USER REQUEST: "Research the problem, analyze solutions, implement the best one"
SEQUENTIAL STRATEGY:
1. Deploy research-agent → gather information
2. Deploy analysis-agent → evaluate options using research results
3. Deploy implementation-agent → build solution using analysis conclusions
```

## Hybrid Coordination Strategy

### When to Use Hybrid Coordination
- **Mixed dependency patterns** exist within the task
- **Some operations parallelize** while others require sequence
- **Optimization opportunities** exist at different levels
- **Complex workflows** benefit from staged approaches

### Hybrid Deployment Examples
```
USER REQUEST: "Optimize the entire application"
HYBRID STRATEGY:
1. PARALLEL: Deploy [frontend-optimizer, backend-optimizer, database-optimizer]
2. SEQUENTIAL: Wait for all parallel results → Deploy integration-optimizer
3. PARALLEL: Deploy [testing-agent, documentation-agent] using integration results
```

## Task Tool Usage Methodology

⏺ **Principle**: Task Tool deployment follows structured patterns for optimal agent coordination and result integration.

**Complete syntax documentation**: [Task Tool Syntax and Deployment Framework](../../principles/task-tool-syntax.md)

### Task Tool Invocation Parameters
- **subagent_type**: Specific agent identifier from available agent catalog
- **description**: Concise 3-5 word task summary for identification
- **prompt**: Comprehensive task instructions with complete context and requirements

### Required Task Tool Invocation Elements
1. **Contextual Background** - Provide complete task context in prompt parameter
2. **Specific Instructions** - Define exact deliverables and success criteria
3. **Framework Compliance** - Ensure agent follows all applicable principles
4. **Output Specifications** - Clarify expected format and integration requirements

### Task Tool Deployment Patterns

#### Single Agent Deployment
```
WHEN: Atomic tasks requiring specialized expertise
METHOD: Deploy single agent with comprehensive context
RESULT: Focused expert output for direct integration
```

#### Parallel Multi-Agent Deployment
```
WHEN: Independent subtasks can execute concurrently
METHOD: Launch multiple Task Tool calls simultaneously within single response
CAPABILITIES: 
- Up to 10 concurrent instances of same agent type
- Multiple different agent types in parallel
- Wave-based deployment for complex dependencies
RESULT: Coordinated parallel execution for maximum efficiency
```

#### Sequential Agent Chain
```
WHEN: Dependencies require ordered execution
METHOD: Deploy agents in dependency sequence
RESULT: Systematic workflow with validated handoffs
```

### Agent Communication Constraints
- **No inter-agent communication** - Each agent operates in isolation
- **No user interaction** - Agents receive context only through Task Tool
- **Single output delivery** - Agents return results once to main instance
- **No state persistence** - Each deployment is stateless and independent

## Coordination Protocols

### Pre-Deployment Coordination
- **Extract delegation context** - Prepare comprehensive agent briefing
- **Define success criteria** - Establish clear validation requirements
- **Prepare integration strategy** - Plan result incorporation methodology
- **Set quality expectations** - Communicate framework compliance requirements

### Multi-Agent Coordination
- **Sequential deployment** - Chain dependent tasks through multiple agents
- **Parallel execution** - Coordinate independent tasks simultaneously
- **Result integration** - Combine outputs from multiple specialized agents
- **Cross-agent validation** - Use multiple perspectives for quality assurance

### Post-Deployment Integration
- **Validate agent deliverables** - Verify quality and completeness
- **Integrate with main context** - Seamlessly incorporate results
- **Present coherent results** - Maintain user communication quality
- **Track completion status** - Update workflow progression

## Cross-References

### Primary Navigation
- [Return to components index](README.md)
- [Review component usage guidelines](../../components/COMPONENT_USAGE.md)
- [Study task analysis framework](task-analysis-framework.md)

### Related Components
- [Study task analysis framework](task-analysis-framework.md)
- [Review orchestration protocols](orchestration-protocols.md)
- [Apply workflow phases](workflow-phases.md)

### Framework References
- [Study context efficiency principles](../../principles/context-efficiency.md)
- [Apply agent selection methodology](../../principles/agent-selection.md)
- [Follow workflow principles](../../principles/workflow.md)

[⬆ Return to top](#agent-coordination-strategies)
