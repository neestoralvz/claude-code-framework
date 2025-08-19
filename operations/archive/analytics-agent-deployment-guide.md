
[Previous: Task Tool Syntax](../docs/principles/task-tool-syntax.md) | [Return to Integration Hub](../docs/index.md) | [View Analytics Agents](../../agents/analytics/) | [Next: Multi-Analysis Workflows](multi-analysis-workflows.md)

# ANALYTICS AGENT DEPLOYMENT INTEGRATION GUIDE

## Table of Contents
  - [Integration Overview](#integration-overview)
- [Framework Design](#framework-design)
- [Available Analytics Agents](#available-analytics-agents)
  - [Deployment Methodology](#deployment-methodology)
- [Core Integration Pattern](#core-integration-pattern)
  - [Analytics Agent Templates](#analytics-agent-templates)
- [Exploration Analysis Template](#exploration-analysis-template)
- [Research Analysis Template](#research-analysis-template)
- [Sales Analysis Template](#sales-analysis-template)
  - [Multi-Analysis Coordination](#multi-analysis-coordination)
- [Parallel Analytics Deployment](#parallel-analytics-deployment)
- [Result Integration Strategy](#result-integration-strategy)
  - [Validation Framework](#validation-framework)
- [Agent Specification Compliance](#agent-specification-compliance)
- [Deployment Validation](#deployment-validation)
  - [Implementation Examples](#implementation-examples)
- [Single Analytics Agent Deployment](#single-analytics-agent-deployment)
- [Multi-Analysis Workflow](#multi-analysis-workflow)
- [Specialized Analysis Context](#specialized-analysis-context)
  - [Quality Assurance](#quality-assurance)
- [Pre-Deployment Validation](#pre-deployment-validation)
- [Post-Deployment Validation](#post-deployment-validation)
- [Framework Integration Assurance](#framework-integration-assurance)
  - [Usage Guidelines](#usage-guidelines)
- [When to Use Analytics Agents](#when-to-use-analytics-agents)
- [Best Practices](#best-practices)
- [Integration Standards](#integration-standards)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Integration Overview

⏺ **Principle**: Analytics agents are deployed through the existing Task tool framework using specialized prompt templates that reference the complete agent specifications while leveraging built-in agent types for execution.

### Framework Design
The Claude Code framework uses a layered approach for analytics agent deployment:

1. **Task Tool Layer**: Uses built-in agent types (`general-purpose`, `project-optimizer`)
2. **Prompt Template Layer**: References specific analytics agent capabilities and output schemas
3. **Agent Specification Layer**: Complete analytics agent definitions in `/agents/analytics/`

### Available Analytics Agents
- **exploration-analyst**: System exploration and pattern analysis specialist
- **research-analyst**: Research knowledge and synthesis specialist  
- **sales-analyst**: Sales business and market analysis specialist

## Deployment Methodology

### Core Integration Pattern
```xml
<function_calls>
<invoke name="Task">
<parameter name="subagent_type">general-purpose</parameter>
<parameter name="description">Execute [ANALYTICS_TYPE] analysis</parameter>
<parameter name="prompt">
AGENT SPECIFICATION: Follow the complete specification for [ANALYTICS_AGENT] located at /agents/analytics/[agent-file].md

CONTEXT:
[Project background and analysis requirements]

TASK:
Execute [ANALYTICS_TYPE] analysis following the [ANALYTICS_AGENT] specification including:
- Core competencies as defined in agent specification
- JSON output schema compliance
- Specialized analysis methodology
- Quality standards and validation requirements

REQUIREMENTS:
- Follow [ANALYTICS_AGENT] complete specification exactly
- Generate structured JSON output per agent schema
- Apply specialized analysis methodology from specification
- Maintain agent quality standards and validation criteria

OUTPUT FORMAT:
Structured JSON output following the exact schema defined in [ANALYTICS_AGENT] specification at /agents/analytics/[agent-file].md

INTEGRATION:
Results will be used for [specific usage context] and must comply with the complete agent specification for proper framework integration.
</parameter>
</invoke>
</function_calls>
```

## Analytics Agent Templates

### Exploration Analysis Template
```xml
<function_calls>
<invoke name="Task">
<parameter name="subagent_type">general-purpose</parameter>
<parameter name="description">Execute exploration analysis</parameter>
<parameter name="prompt">
AGENT SPECIFICATION: Follow the complete specification for exploration-analyst located at /agents/analytics/exploration-analyst.md

CONTEXT:
System requiring comprehensive exploration and pattern analysis. Need to identify recurring patterns, anti-patterns, and optimization opportunities through thorough discovery.

TASK:
Execute system exploration analysis following the exploration-analyst specification including:
- System discovery through comprehensive codebase exploration  
- Pattern recognition identifying recurring patterns and anti-patterns
- Opportunity mapping for improvements and enhancements
- Dependency analysis mapping relationships and integration points
- Innovation potential assessment

REQUIREMENTS:
- Follow exploration-analyst complete specification exactly
- Generate structured JSON output per exploration-analyst schema
- Apply comprehensive exploration methodology from specification
- Maintain exploration-analyst quality standards

OUTPUT FORMAT:
Structured JSON output following the exact schema defined in exploration-analyst specification including:
- analysis_metadata with agent_type: "exploration-analyst"
- system_landscape with architecture overview and component mapping
- pattern_analysis with recurring patterns and anti-patterns
- optimization_opportunities with improvement recommendations
- exploration_insights with discoveries and recommendations

INTEGRATION:
Results will be used for system optimization planning and architectural decision-making, requiring compliance with exploration-analyst specification.
</parameter>
</invoke>
</function_calls>
```

### Research Analysis Template
```xml
<function_calls>
<invoke name="Task">
<parameter name="subagent_type">general-purpose</parameter>
<parameter name="description">Execute research analysis</parameter>
<parameter name="prompt">
AGENT SPECIFICATION: Follow the complete specification for research-analyst located at /agents/analytics/research-analyst.md

CONTEXT:
Research requirements needing comprehensive knowledge synthesis and analysis. Require systematic investigation and evidence-based recommendations.

TASK:
Execute research analysis following the research-analyst specification including:
- Research methodology application for systematic investigation
- Knowledge synthesis from multiple sources and domains
- Evidence evaluation with credibility and relevance assessment
- Insight generation through pattern recognition and analysis
- Recommendation formulation based on research findings

REQUIREMENTS:
- Follow research-analyst complete specification exactly
- Generate structured JSON output per research-analyst schema
- Apply systematic research methodology from specification
- Maintain research-analyst quality and validation standards

OUTPUT FORMAT:
Structured JSON output following the exact schema defined in research-analyst specification including:
- analysis_metadata with agent_type: "research-analyst"
- research_scope with methodology and investigation parameters
- knowledge_synthesis with source analysis and insights
- evidence_evaluation with credibility assessments
- research_conclusions with findings and recommendations

INTEGRATION:
Results will be used for evidence-based decision making and strategic planning, requiring compliance with research-analyst specification.
</parameter>
</invoke>
</function_calls>
```

### Sales Analysis Template
```xml
<function_calls>
<invoke name="Task">
<parameter name="subagent_type">general-purpose</parameter>
<parameter name="description">Execute sales analysis</parameter>
<parameter name="prompt">
AGENT SPECIFICATION: Follow the complete specification for sales-analyst located at /agents/analytics/sales-analyst.md

CONTEXT:
Sales and business analysis requirements for market assessment, opportunity identification, and business strategy development.

TASK:
Execute sales analysis following the sales-analyst specification including:
- Market analysis with segmentation and opportunity assessment
- Business metrics evaluation and performance analysis
- Competitive landscape assessment and positioning analysis
- Customer behavior analysis and insights generation
- Sales strategy recommendations and optimization opportunities

REQUIREMENTS:
- Follow sales-analyst complete specification exactly
- Generate structured JSON output per sales-analyst schema
- Apply business analysis methodology from specification
- Maintain sales-analyst quality and validation standards

OUTPUT FORMAT:
Structured JSON output following the exact schema defined in sales-analyst specification including:
- analysis_metadata with agent_type: "sales-analyst"
- market_analysis with segmentation and opportunities
- business_metrics with performance evaluations
- competitive_analysis with landscape assessment
- sales_insights with findings and recommendations

INTEGRATION:
Results will be used for business strategy development and market positioning decisions, requiring compliance with sales-analyst specification.
</parameter>
</invoke>
</function_calls>
```

## Multi-Analysis Coordination

### Parallel Analytics Deployment
For comprehensive analysis requiring multiple analytics perspectives:

```xml
<function_calls>
<invoke name="Task">
<parameter name="subagent_type">general-purpose</parameter>
<parameter name="description">Execute exploration analysis</parameter>
<parameter name="prompt">[EXPLORATION_ANALYSIS_PROMPT]</parameter>
</invoke>
<invoke name="Task">
<parameter name="subagent_type">general-purpose</parameter>
<parameter name="description">Execute research analysis</parameter>
<parameter name="prompt">[RESEARCH_ANALYSIS_PROMPT]</parameter>
</invoke>
<invoke name="Task">
<parameter name="subagent_type">general-purpose</parameter>
<parameter name="description">Execute sales analysis</parameter>
<parameter name="prompt">[SALES_ANALYSIS_PROMPT]</parameter>
</invoke>
</function_calls>
```

### Result Integration Strategy
1. **Individual Analysis**: Each agent produces JSON output per specification
2. **Result Collection**: Collect all JSON outputs for integration
3. **Synthesis Process**: Combine insights across analysis types
4. **Consolidated Report**: Generate comprehensive analysis report

## Validation Framework

### Agent Specification Compliance
- **Complete Specification Following**: Agents must follow their complete specifications exactly
- **JSON Schema Validation**: Output must match the defined schema precisely
- **Quality Standards**: Analysis must meet the quality criteria from specifications
- **Integration Requirements**: Results must be suitable for framework integration

### Deployment Validation
- **Task Tool Integration**: Successful deployment through Task tool framework
- **Prompt Template Accuracy**: Templates correctly reference agent specifications
- **Output Format Compliance**: JSON output matches agent schema requirements
- **Multi-Analysis Coordination**: Parallel deployment functions correctly

## Implementation Examples

### Single Analytics Agent Deployment
```bash
# Deploy exploration analyst for system analysis
Use exploration analysis template with specific project context
Monitor execution and collect JSON output
Validate output against exploration-analyst schema
Integrate results into project planning
```

### Multi-Analysis Workflow
```bash
# Deploy all three analytics agents in parallel
Use parallel deployment template with coordinated contexts
Monitor all three executions simultaneously
Collect all JSON outputs for integration
Synthesize insights across all analysis types
Generate comprehensive multi-analysis report
```

### Specialized Analysis Context
```bash
# Deploy specific analytics agent for targeted analysis
Customize prompt template for specific requirements
Maintain agent specification compliance
Generate specialized JSON output
Integrate results into decision-making process
```

## Quality Assurance

### Pre-Deployment Validation
- **Agent Specification Review**: Verify complete specification understanding
- **Prompt Template Accuracy**: Ensure templates correctly reference specifications
- **Context Preparation**: Prepare appropriate analysis context
- **Integration Planning**: Plan for result usage and validation

### Post-Deployment Validation
- **Output Schema Compliance**: Verify JSON output matches agent specifications
- **Quality Standards Met**: Confirm analysis meets specification requirements
- **Integration Success**: Validate successful framework integration
- **Results Usability**: Ensure outputs suitable for intended usage

### Framework Integration Assurance
- **Task Tool Compatibility**: Confirm deployment works with existing framework
- **Agent Specification Adherence**: Verify complete specification following
- **Output Format Consistency**: Ensure JSON schema compliance
- **Multi-Analysis Coordination**: Validate parallel deployment functionality

## Usage Guidelines

### When to Use Analytics Agents
- **System Analysis**: Use exploration-analyst for comprehensive system discovery
- **Research Tasks**: Use research-analyst for evidence-based investigation
- **Business Analysis**: Use sales-analyst for market and business insights
- **Multi-Perspective Analysis**: Use parallel deployment for comprehensive insights

### Best Practices
- **Always reference complete agent specifications** in prompt templates
- **Maintain JSON schema compliance** for proper framework integration
- **Use appropriate Task tool agent types** (general-purpose recommended)
- **Validate outputs against agent specifications** before integration
- **Document analysis context** for result interpretation and usage

### Integration Standards
- **Follow existing Task tool framework patterns** for deployment
- **Reference agent specifications exactly** in prompt templates
- **Generate compliant JSON outputs** per agent schemas
- **Maintain framework quality standards** throughout analysis process

[⬆ Return to top](#analytics-agent-deployment-integration-guide)
