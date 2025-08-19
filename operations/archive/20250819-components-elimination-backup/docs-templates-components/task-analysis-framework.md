
[Previous: Review monitoring reports](execution-monitoring-reports.md) | [Return to components index](README.md) | [Study component usage](../../components/COMPONENT_USAGE.md) | [Next: Study agent coordination](agent-coordination-strategies.md)

# TASK ANALYSIS FRAMEWORK

⏺ **Principle**: This framework implements [agent-selection.md multi-perspective analysis](../principles/agent-selection.md#multi-perspective-analysis) by systematically analyzing task characteristics to determine optimal agent deployment strategies.

## Task Decomposition Process

### Core Analysis Steps
1. **Analyze task complexity** - Determine if task is atomic, composite, or distributed
2. **Map dependencies** - Identify sequential requirements vs parallel opportunities  
3. **Assess domain requirements** - Single domain vs cross-domain expertise needed
4. **Evaluate resource needs** - Computational, integration, or quality assurance requirements

### Task Classification Matrix

#### By Complexity Level
- **Atomic Tasks**: Single operation, one agent, direct execution
  - *Examples*: File analysis, simple code generation, documentation update
  - *Agent Strategy*: Deploy single specialized agent
  
- **Composite Tasks**: Multiple operations, coordinated single agent
  - *Examples*: Feature implementation, system optimization, comprehensive analysis
  - *Agent Strategy*: Deploy complex specialist agent (project-optimizer, etc.)
  
- **Distributed Tasks**: Multiple operations, multiple agents required
  - *Examples*: Full system architecture, multi-component development, comprehensive testing
  - *Agent Strategy*: Multi-agent coordination required

#### By Dependency Type
- **Independent Operations**: No interdependencies → **Parallel Execution**
- **Sequential Dependencies**: Must execute in order → **Sequential Execution**  
- **Conditional Dependencies**: Execution based on results → **Hybrid Coordination**
- **Resource Dependencies**: Shared resources → **Managed Sequential**

## Agent Selection Algorithm

### Selection Decision Process

#### Step 1: Task Scope Analysis
```
ANALYZE task requirements:
  IF exploratory/research → general-purpose agent
  IF specific domain expertise → specialist agent (existing or create)
  IF multi-domain → multi-agent coordination
  IF unknown complexity → delegation-advisor first
```

#### Step 2: Agent Catalog Assessment  
```
CHECK existing agents:
  IF exact match exists → deploy existing specialist
  IF partial match → evaluate suitability vs creation
  IF no match → deploy agent-creator
  IF uncertain → deploy delegation-advisor for guidance
```

#### Step 3: Execution Pattern Determination
```
DETERMINE coordination pattern:
  IF independent subtasks → parallel deployment
  IF sequential dependencies → sequential deployment  
  IF mixed dependencies → hybrid coordination
  IF complex orchestration → project-optimizer coordination
```

## Task Tool Usage Framework

### Deployment Categories

#### Immediate Task Tool Deployment
- **Complex analysis requirements** - Deploy project-optimizer or analytical agents
- **Code generation tasks** - Use specialized development agents
- **Multi-file operations** - Delegate to appropriate technical agents
- **System optimization** - Deploy optimization and architectural agents

#### Conditional Task Tool Deployment
- **Simple single-file operations** - Use direct tools (Read, Write, Edit)
- **Basic information queries** - Direct tool usage sufficient
- **Immediate validation needs** - Quick verification via direct tools
- **Context preservation critical** - Maintain main instance control

### Task Tool Selection Process
1. **Evaluate task complexity** - Determine specialization requirements
2. **Assess agent catalog** - Match existing agents to task needs
3. **Consider creation necessity** - Deploy agent-creator if no suitable match
4. **Execute deployment** - Launch Task Tool with optimal agent selection

## Delegation Decision Matrix

### Always Delegate Via Task Tool
- **Multi-step complex tasks** - Require specialized workflow management
- **Code architecture analysis** - Need expert analytical perspective
- **System optimization projects** - Require comprehensive technical expertise
- **Agent creation requests** - Deploy agent-creator for specialized development

### Strategic Delegation Considerations
- **File count > 3** - Multi-file operations benefit from agent coordination
- **Cross-domain expertise** - Tasks requiring multiple technical specializations
- **Quality critical operations** - High-stakes implementations requiring expert validation
- **Pattern recognition needs** - Complex analysis requiring specialized algorithms

### Direct Tool Usage Appropriate
- **Single file reads** - Simple information gathering
- **Basic file modifications** - Straightforward edits with clear scope
- **Directory listings** - Basic filesystem navigation
- **Simple command execution** - Standard operations without complexity

## Cross-References

### Primary Navigation
- [Return to components index](README.md)
- [Review component usage guidelines](../../components/COMPONENT_USAGE.md)
- [Study agent coordination strategies](agent-coordination-strategies.md)

### Related Components
- [Study agent coordination strategies](agent-coordination-strategies.md)
- [Review orchestration protocols](orchestration-protocols.md)
- [Apply workflow phases](workflow-phases.md)

### Framework References
- [Apply agent selection principles](../../principles/agent-selection.md)
- [Follow workflow methodology](../../principles/workflow.md)
- [Study context efficiency](../../principles/context-efficiency.md)

[⬆ Return to top](#task-analysis-framework)
