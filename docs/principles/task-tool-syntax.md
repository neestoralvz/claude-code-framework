---
title: "Task Tool Syntax and Deployment Framework"
principle_type: "operational"
version: "1.0.0"
dependencies: ["task-orchestration.md", "agent-selection.md", "context-efficiency.md"]
last_updated: "2025-08-18"
purpose: "Define complete Task Tool invocation syntax and structured prompt framework"
keywords: ["Task Tool", "agent deployment", "syntax", "prompt structure", "parallel execution"]
---

[Previous: task-orchestration.md](task-orchestration.md) | [Return to PRINCIPLES.md](principles/PRINCIPLES.md) | [Next: agent-definition.md](agent-definition.md)

# TASK TOOL SYNTAX AND DEPLOYMENT FRAMEWORK

## Table of Contents
- [Core Philosophy](#core-philosophy)
- [Fundamental Concepts](#fundamental-concepts)
- [Implementation Framework](#implementation-framework)
- [Standards Guidelines](#standards-guidelines)
- [Validation](#validation)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Complete Task Tool Invocation Syntax

### XML Structure Pattern
```
&lt;function_calls&gt;
&lt;invoke name="Task"&gt;
&lt;parameter name="subagent_type"&gt;[AGENT_TYPE]&lt;/parameter&gt;
&lt;parameter name="description"&gt;[3-5 WORD SUMMARY]&lt;/parameter&gt;
&lt;parameter name="prompt"&gt;CONTEXT:
[Project background and current situation]

TASK:
[Specific assignment with clear scope]

REQUIREMENTS:
- [Deliverable requirement 1]
- [Quality standard requirement 2]
- [Framework compliance requirement 3]

OUTPUT FORMAT:
[Expected deliverable format specification]

INTEGRATION:
[Result usage and validation criteria]&lt;/parameter&gt;
&lt;/invoke&gt;
&lt;/function_calls&gt;
```

### Critical Syntax Requirements
- **Exact XML formatting** - Must use precise `function_calls` and `invoke` structure
- **Parameter order consistency** - Always: subagent_type, description, prompt
- **Proper parameter naming** - Exact parameter names without variations
- **Complete closure tags** - All XML elements properly closed

## Parameter Specifications

### subagent_type Parameter

⏺ **Principle**: The subagent_type parameter identifies the specific agent from the available catalog for deployment.

#### Available Agent Types
- general-purpose      # Comprehensive research and multi-step tasks
- project-optimizer    # Complex analysis and optimization tasks
- delegation-advisor   # Task routing and distribution planning
- agent-creator        # Building specialized tools and new agents
- agent-architect      # Gold standard agent structure and design
- ticket-executor      # Ticket lifecycle management and execution
- statusline-setup     # Claude Code status line configuration
- output-style-setup   # Claude Code output style creation

#### Syntax Pattern
```
&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
```

### description Parameter

⏺ **Principle**: The description parameter provides a concise task identifier for tracking and coordination purposes.

#### Requirements
- **Length**: Exactly 3-5 words
- **Clarity**: Clear task identification
- **Uniqueness**: Distinguishable from parallel tasks
- **Action-oriented**: Begin with action verb when possible

#### Syntax Pattern
```
&lt;parameter name="description"&gt;Optimize database performance&lt;/parameter&gt;
```

#### Examples
✓ "Analyze frontend architecture"
✓ "Create user authentication system"
✓ "Optimize API endpoints"
✓ "Review security implementation"

✗ "Do stuff" (too vague)
✗ "Comprehensively analyze and optimize the entire frontend architecture including performance monitoring" (too long)

### prompt Parameter

⏺ **Principle**: The prompt parameter contains comprehensive task instructions following the structured prompt framework for optimal agent execution.

#### Syntax Pattern
```
&lt;parameter name="prompt"&gt;
CONTEXT:
[Project background and current situation]

TASK:
[Specific assignment with clear scope]

REQUIREMENTS:
- [Deliverable requirement 1]
- [Quality standard requirement 2]
- [Framework compliance requirement 3]

OUTPUT FORMAT:
[Expected deliverable format specification]

INTEGRATION:
[Result usage and validation criteria]
&lt;/parameter&gt;
```

## Structured Prompt Framework

### Required Prompt Sections

#### CONTEXT Section
```
CONTEXT:
[Background information including:]
- Current project state
- User requirements and goals
- Technical constraints
- Timeline considerations
- Relevant environment details
```

#### TASK Section
```
TASK:
[Clear, specific description including:]
- Precise assignment scope
- Expected outcomes
- Boundaries and limitations
- Success criteria definition
```

#### REQUIREMENTS Section
```
REQUIREMENTS:
- [Functional deliverable 1]
- [Quality standard 2]
- [Framework compliance 3]
- [Integration requirement 4]
- [Validation criteria 5]
```

#### OUTPUT FORMAT Section
```
OUTPUT FORMAT:
[Specification including:]
- Expected deliverable type (code, analysis, recommendations)
- Formatting standards
- Documentation requirements
- Structure expectations
```

#### INTEGRATION Section
```
INTEGRATION:
[Instructions including:]
- How results will be used
- Handoff requirements
- Validation methodology
- Quality assurance criteria
```

## Deployment Patterns

### Single Agent Deployment

```
&lt;function_calls&gt;
&lt;invoke name="Task"&gt;
&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
&lt;parameter name="description"&gt;Analyze application architecture&lt;/parameter&gt;
&lt;parameter name="prompt"&gt;
CONTEXT:
Legacy application requiring modernization assessment. Current stack includes outdated dependencies and performance bottlenecks. User needs comprehensive analysis for modernization planning.

TASK:
Perform comprehensive architecture analysis including dependency review, performance assessment, and modernization recommendations.

REQUIREMENTS:
- Complete dependency audit with version analysis
- Performance bottleneck identification and impact assessment
- Modernization roadmap with priority recommendations
- Framework compliance per engineering standards
- Actionable implementation strategy

OUTPUT FORMAT:
Structured analysis report with:
1. Current state assessment
2. Identified issues with severity ratings
3. Modernization recommendations with timelines
4. Implementation strategy with phases

INTEGRATION:
Analysis will guide modernization planning and resource allocation decisions. Results must be validated against technical feasibility and business constraints.
&lt;/parameter&gt;
&lt;/invoke&gt;
&lt;/function_calls&gt;
```

### Parallel Agent Deployment

```
&lt;function_calls&gt;
&lt;invoke name="Task"&gt;
&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
&lt;parameter name="description"&gt;Analyze frontend performance&lt;/parameter&gt;
&lt;parameter name="prompt"&gt;
CONTEXT:
Web application experiencing frontend performance issues affecting user experience. Need specialized frontend analysis for optimization strategy.

TASK:
Conduct comprehensive frontend performance analysis and optimization recommendations.

REQUIREMENTS:
- Bundle size analysis and optimization opportunities
- Rendering performance assessment
- User interaction optimization recommendations
- Framework compliance standards

OUTPUT FORMAT:
Frontend optimization report with actionable recommendations and implementation priorities.

INTEGRATION:
Results will be combined with backend and database analysis for comprehensive performance optimization strategy.
&lt;/parameter&gt;
&lt;/invoke&gt;
&lt;invoke name="Task"&gt;
&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
&lt;parameter name="description"&gt;Analyze backend performance&lt;/parameter&gt;
&lt;parameter name="prompt"&gt;
CONTEXT:
Web application experiencing backend performance bottlenecks. Need specialized backend analysis for optimization strategy.

TASK:
Conduct comprehensive backend performance analysis including API response times, database queries, and server resource utilization.

REQUIREMENTS:
- API endpoint performance analysis
- Database query optimization recommendations
- Server resource utilization assessment
- Caching strategy recommendations

OUTPUT FORMAT:
Backend optimization report with specific performance improvements and implementation timelines.

INTEGRATION:
Results will be combined with frontend and database analysis for comprehensive performance optimization strategy.
&lt;/parameter&gt;
&lt;/invoke&gt;
&lt;invoke name="Task"&gt;
&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
&lt;parameter name="description"&gt;Analyze database performance&lt;/parameter&gt;
&lt;parameter name="prompt"&gt;
CONTEXT:
Database queries showing performance degradation affecting overall application performance. Need specialized database analysis.

TASK:
Conduct comprehensive database performance analysis including query optimization, indexing strategy, and data structure assessment.

REQUIREMENTS:
- Query performance analysis with bottleneck identification
- Index optimization recommendations
- Data structure efficiency assessment
- Scaling strategy recommendations

OUTPUT FORMAT:
Database optimization report with query improvements and structural recommendations.

INTEGRATION:
Results will be combined with frontend and backend analysis for comprehensive performance optimization strategy.
&lt;/parameter&gt;
&lt;/invoke&gt;
&lt;/function_calls&gt;
```

### Wave-Based Deployment

#### Wave 1: Analysis Phase
```
&lt;function_calls&gt;
&lt;invoke name="Task"&gt;
&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
&lt;parameter name="description"&gt;Analyze system architecture&lt;/parameter&gt;
&lt;parameter name="prompt"&gt;[Analysis task prompt]&lt;/parameter&gt;
&lt;/invoke&gt;
&lt;invoke name="Task"&gt;
&lt;parameter name="subagent_type"&gt;delegation-advisor&lt;/parameter&gt;
&lt;parameter name="description"&gt;Identify optimization opportunities&lt;/parameter&gt;
&lt;parameter name="prompt"&gt;[Opportunity identification prompt]&lt;/parameter&gt;
&lt;/invoke&gt;
&lt;/function_calls&gt;
```

#### Wave 2: Planning Phase (Based on Wave 1 Results)
```
&lt;function_calls&gt;
&lt;invoke name="Task"&gt;
&lt;parameter name="subagent_type"&gt;agent-creator&lt;/parameter&gt;
&lt;parameter name="description"&gt;Design implementation strategy&lt;/parameter&gt;
&lt;parameter name="prompt"&gt;[Strategy design using analysis results]&lt;/parameter&gt;
&lt;/invoke&gt;
&lt;/function_calls&gt;
```

#### Wave 3: Implementation Phase (Based on Waves 1-2)
```
&lt;function_calls&gt;
&lt;invoke name="Task"&gt;
&lt;parameter name="subagent_type"&gt;general-purpose&lt;/parameter&gt;
&lt;parameter name="description"&gt;Execute optimization plan&lt;/parameter&gt;
&lt;parameter name="prompt"&gt;[Implementation using strategy and analysis]&lt;/parameter&gt;
&lt;/invoke&gt;
&lt;/function_calls&gt;
```

## Quality Assurance Framework

### Pre-Deployment Validation
- **Agent Availability** - Verify subagent_type exists in available catalog
- **Task Completeness** - Ensure all required prompt sections included
- **Syntax Accuracy** - Validate XML structure and parameter naming
- **Dependency Analysis** - Confirm task independence for parallel deployment

### Post-Deployment Monitoring
- **Agent Response Tracking** - Monitor deployment success and execution progress
- **Result Integration** - Coordinate output combination from parallel agents
- **Quality Validation** - Verify outputs meet framework standards
- **Error Recovery** - Handle deployment failures and retry strategies

## Framework Integration

### Related Principles
- [task-orchestration.md](task-orchestration.md) - Systematic coordination principles
- [agent-selection.md](agent-selection.md) - Agent deployment decision framework
- [context-efficiency.md](context-efficiency.md) - Optimization standards

### Implementation Guidance
- Apply systematic Task Tool deployment for all agent operations
- Follow structured prompt framework for consistent agent communication
- Use parallel deployment patterns for efficiency optimization
- Maintain quality assurance standards throughout deployment lifecycle

[⬆ Return to top](#task-tool-syntax-and-deployment-framework)