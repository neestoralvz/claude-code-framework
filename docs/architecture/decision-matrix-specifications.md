---
title: "Decision Matrix Specifications"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["command-consolidation-architecture.md", "command-enhancement-patterns.md", "../principles/agent-selection.md"]
prerequisites: ["Understanding of agent capabilities", "Command consolidation architecture knowledge"]
audience: "Command developers and system orchestrators"
purpose: "Define comprehensive decision matrices for agent selection vs creation within command consolidation framework"
keywords: ["decision-matrix", "agent-selection", "agent-creation", "command-orchestration", "decision-trees"]
last_review: "2025-08-19"
---

[Previous: Study enhancement patterns](command-enhancement-patterns.md) | [Return to Documentation Hub for navigation](../index.md) | [Study PRINCIPLES.md for framework](principles/PRINCIPLES.md) | [Next: Apply agent orchestration](agent-orchestration-framework.md)

# DECISION MATRIX SPECIFICATIONS

⏺ **Principle**: These specifications implement [agent-selection.md systematic methodology](../principles/agent-selection.md) through comprehensive decision frameworks that guide commands in optimal agent deployment versus creation decisions.

## Table of Contents
  - [Decision Framework Overview](#decision-framework-overview)
- [Core Decision Points](#core-decision-points)
- [Decision Hierarchy](#decision-hierarchy)
  - [Agent Selection Decision Matrix](#agent-selection-decision-matrix)
- [Primary Selection Matrix](#primary-selection-matrix)
- [Capability Matching Algorithm](#capability-matching-algorithm)
- [Scoring Criteria](#scoring-criteria)
  - [Agent Creation Decision Matrix](#agent-creation-decision-matrix)
- [Creation Justification Matrix](#creation-justification-matrix)
- [Creation Decision Algorithm](#creation-decision-algorithm)
- [Gap Analysis Framework](#gap-analysis-framework)
  - [Command-Specific Decision Trees](#command-specific-decision-trees)
- [Analysis Command Decision Tree](#analysis-command-decision-tree)
- [Implementation Command Decision Tree](#implementation-command-decision-tree)
- [Management Command Decision Tree](#management-command-decision-tree)
  - [Context-Based Decision Logic](#context-based-decision-logic)
- [Context Factors](#context-factors)
- [Context-Driven Decision Adjustment](#context-driven-decision-adjustment)
  - [Multi-Agent Coordination Decisions](#multi-agent-coordination-decisions)
- [Coordination Decision Matrix](#coordination-decision-matrix)
- [Coordination Patterns](#coordination-patterns)
  - [Quality Validation Decisions](#quality-validation-decisions)
- [Validation Strategy Matrix](#validation-strategy-matrix)
- [Validation Decision Algorithm](#validation-decision-algorithm)
  - [Implementation Guidelines](#implementation-guidelines)
- [Command Integration Pattern](#command-integration-pattern)
  - [Agent Decision Integration (in command files)](#agent-decision-integration-in-command-files-)
- [Decision Point 1: Initial Agent Assessment](#decision-point-1-initial-agent-assessment)
- [Decision Point 2: Deployment vs Creation](#decision-point-2-deployment-vs-creation)
- [Decision Point 3: Coordination Strategy](#decision-point-3-coordination-strategy)
- [Decision Logging Framework](#decision-logging-framework)
  - [Decision Audit Framework](#decision-audit-framework)
- [Audit Categories](#audit-categories)
- [Audit Metrics](#audit-metrics)
- [Continuous Improvement Process](#continuous-improvement-process)
  - [Cross-References](#cross-references)
- [Primary Navigation](#primary-navigation)
- [Related Principles](#related-principles)
- [Related Architecture](#related-architecture)
- [Implementation Resources](#implementation-resources)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Decision Framework Overview

### Core Decision Points
Every command must systematically evaluate:
1. **Agent Capability Assessment**: Can existing agents handle the task?
2. **Complexity Analysis**: Does task complexity match agent sophistication?
3. **Domain Coverage**: Do agents cover required expertise domains?
4. **Integration Requirements**: Can agents coordinate effectively?
5. **Quality Standards**: Do agents meet required quality levels?

### Decision Hierarchy
```
Task Request
├─ Immediate Agent Availability
│  ├─ Perfect Match → Deploy Existing Agent
│  ├─ Partial Match → Evaluate Enhancement vs Creation
│  └─ No Match → Proceed to Creation Analysis
├─ Agent Creation Analysis
│  ├─ Justified Need → Generate Creation Ticket
│  ├─ Marginal Benefit → Use Best Available Agent
│  └─ Uncertain Value → Request Clarification
└─ Execution Strategy
   ├─ Single Agent Deployment
   ├─ Multi-Agent Coordination
   └─ Phased Agent Introduction
```

## Agent Selection Decision Matrix

⏺ **Principle**: This matrix implements [command-consolidation-architecture.md](command-consolidation-architecture.md) agent orchestration patterns through systematic capability matching.

### Primary Selection Matrix

| Task Characteristics | Agent Requirements | Available Agents | Decision | Confidence |
|---------------------|-------------------|------------------|----------|------------|
| **Simple Analysis** | Basic examination | system-audit | ✅ Deploy | High |
| **Complex Analysis** | Multi-perspective | project-optimizer | ✅ Deploy | High |
| **Code Optimization** | Performance focus | code-optimizer | ❌ Missing | Create Ticket |
| **Security Audit** | Security expertise | security-specialist | ❌ Missing | Create Ticket |
| **Documentation** | Technical writing | doc-generator | ❌ Missing | Create Ticket |
| **Testing Strategy** | QA methodology | test-coordinator | ❌ Missing | Create Ticket |

### Capability Matching Algorithm

```bash
# Agent Selection Algorithm
select_agent(task_requirements) {
    available_agents = scan_agents_directory()
    
    for agent in available_agents {
        capability_score = calculate_capability_match(agent, task_requirements)
        domain_score = calculate_domain_coverage(agent, task_requirements)
        complexity_score = calculate_complexity_alignment(agent, task_requirements)
        
        total_score = (capability_score * 0.4) + (domain_score * 0.3) + (complexity_score * 0.3)
        
        if (total_score >= 0.8) {
            return deploy_agent(agent)
        } elif (total_score >= 0.6) {
            return evaluate_enhancement_vs_creation(agent, task_requirements)
        }
    }
    
    return initiate_creation_process(task_requirements)
}
```

### Scoring Criteria

#### Capability Score (0.0 - 1.0)
- **1.0**: Perfect capability match - agent designed for this exact task type
- **0.8**: Strong capability match - agent covers 80%+ of required capabilities
- **0.6**: Moderate capability match - agent covers core requirements
- **0.4**: Weak capability match - agent covers basic requirements only
- **0.2**: Minimal capability match - agent peripherally related
- **0.0**: No capability match - agent unrelated to task

#### Domain Score (0.0 - 1.0)
- **1.0**: Complete domain coverage - agent expert in all required domains
- **0.8**: Strong domain coverage - agent covers primary domains
- **0.6**: Moderate domain coverage - agent covers most domains
- **0.4**: Weak domain coverage - agent covers some domains
- **0.2**: Minimal domain coverage - agent covers few domains
- **0.0**: No domain coverage - agent outside required domains

#### Complexity Score (0.0 - 1.0)
- **1.0**: Perfect complexity match - agent designed for this complexity level
- **0.8**: Strong complexity match - agent handles higher complexity well
- **0.6**: Moderate complexity match - agent adequate for complexity
- **0.4**: Weak complexity match - agent may struggle with complexity
- **0.2**: Minimal complexity match - agent likely insufficient
- **0.0**: No complexity match - agent inadequate for complexity

## Agent Creation Decision Matrix

⏺ **Principle**: This matrix implements [directive.md execution requirements](../principles/directive.md) by ensuring agent creation decisions are systematic and justified.

### Creation Justification Matrix

| Justification Level | Criteria | Required Evidence | Action |
|-------------------|----------|-------------------|---------|
| **MANDATORY** | Critical capability gap | No existing coverage + high impact | ✅ Create Immediately |
| **STRONG** | Significant improvement | >50% capability enhancement | ✅ Create with Planning |
| **MODERATE** | Meaningful benefit | 25-50% improvement | 🤔 Evaluate Cost/Benefit |
| **WEAK** | Marginal benefit | 10-25% improvement | ❌ Use Existing Agent |
| **NONE** | No clear benefit | <10% improvement | ❌ Reject Creation |

### Creation Decision Algorithm

```bash
# Agent Creation Decision Algorithm
evaluate_creation_need(task_requirements, best_existing_agent) {
    gap_analysis = analyze_capability_gaps(task_requirements, best_existing_agent)
    impact_assessment = calculate_potential_impact(gap_analysis)
    resource_cost = estimate_creation_effort(task_requirements)
    
    # Calculate justification score
    justification_score = (impact_assessment * 0.5) + (gap_severity * 0.3) + (reusability * 0.2)
    
    if (justification_score >= 0.8) {
        return create_agent_ticket("MANDATORY", detailed_specifications)
    } elif (justification_score >= 0.6) {
        return create_agent_ticket("STRONG", detailed_specifications)
    } elif (justification_score >= 0.4) {
        return evaluate_cost_benefit(resource_cost, expected_benefit)
    } else {
        return use_best_existing_agent()
    }
}
```

### Gap Analysis Framework

#### Capability Gap Types
1. **Functional Gap**: Missing required functionality
2. **Quality Gap**: Insufficient quality standards
3. **Performance Gap**: Inadequate performance characteristics
4. **Integration Gap**: Poor integration capabilities
5. **Specialization Gap**: Lack of domain expertise

#### Gap Severity Levels
- **CRITICAL**: Task cannot be completed without new agent
- **HIGH**: Task completion significantly compromised
- **MEDIUM**: Task completion moderately affected
- **LOW**: Task completion minimally affected
- **NONE**: No meaningful impact on task completion

## Command-Specific Decision Trees

### Analysis Command Decision Tree
```
Analysis Task Request
├─ Simple Analysis (audit, review)
│  ├─ system-audit available? → Deploy system-audit
│  └─ No suitable agent → Create basic-analyzer ticket
├─ Complex Analysis (multi-domain, optimization)
│  ├─ project-optimizer available? → Deploy project-optimizer
│  └─ No suitable agent → Create domain-specialist ticket
└─ Specialized Analysis (security, performance)
   ├─ Domain specialist available? → Deploy specialist
   └─ No specialist → Create specialist ticket
```

### Implementation Command Decision Tree
```
Implementation Task Request
├─ Standard Implementation
│  ├─ code-implementer available? → Deploy code-implementer
│  └─ No implementer → Create implementation-specialist ticket
├─ Architecture Changes
│  ├─ architecture-specialist available? → Deploy specialist
│  └─ No specialist → Create architecture-agent ticket
└─ Complex Integration
   ├─ integration-coordinator available? → Deploy coordinator
   └─ No coordinator → Create integration-specialist ticket
```

### Management Command Decision Tree
```
Management Task Request
├─ Ticket Management
│  ├─ ticket-manager available? → Deploy ticket-manager
│  └─ No manager → Create ticket-specialist ticket
├─ Project Coordination
│  ├─ project-coordinator available? → Deploy coordinator
│  └─ No coordinator → Create coordination-agent ticket
└─ Quality Assurance
   ├─ qa-specialist available? → Deploy specialist
   └─ No specialist → Create qa-agent ticket
```

## Context-Based Decision Logic

### Context Factors
Commands must consider these contextual factors:

#### Project Context
- **Project Size**: Small/Medium/Large/Enterprise
- **Project Type**: Greenfield/Legacy/Migration/Maintenance
- **Team Size**: Solo/Small Team/Large Team/Multi-team
- **Time Constraints**: Urgent/Normal/Flexible

#### Technical Context
- **Technology Stack**: Languages, frameworks, platforms
- **Architecture Complexity**: Simple/Moderate/Complex/Enterprise
- **Integration Requirements**: Standalone/Few Dependencies/Highly Integrated
- **Performance Requirements**: Basic/Standard/High Performance/Critical

#### Quality Context
- **Quality Standards**: Basic/Standard/High/Critical
- **Testing Requirements**: Unit/Integration/System/Full Suite
- **Documentation Level**: Minimal/Standard/Comprehensive/Enterprise
- **Compliance Requirements**: None/Basic/Regulatory/Critical

### Context-Driven Decision Adjustment

```bash
# Context-Adjusted Decision Algorithm
adjust_decision_for_context(base_decision, context) {
    if (context.time_constraints == "urgent") {
        bias_toward_existing_agents(base_decision)
    }
    
    if (context.quality_standards == "critical") {
        increase_agent_creation_threshold(base_decision)
    }
    
    if (context.project_size == "enterprise") {
        favor_specialized_agents(base_decision)
    }
    
    if (context.team_size == "solo") {
        prefer_comprehensive_agents(base_decision)
    }
    
    return adjusted_decision
}
```

## Multi-Agent Coordination Decisions

### Coordination Decision Matrix

| Task Complexity | Domain Spread | Agent Strategy | Coordination Pattern |
|-----------------|---------------|----------------|---------------------|
| **High** | Multi-domain | Multiple Specialists | Hierarchical Coordination |
| **High** | Single-domain | Single Expert | Direct Deployment |
| **Medium** | Multi-domain | Generalist + Specialists | Collaborative Coordination |
| **Medium** | Single-domain | Single Generalist | Direct Deployment |
| **Low** | Any | Single Agent | Direct Deployment |

### Coordination Patterns

#### Pattern 1: Hierarchical Coordination
**Usage**: Complex multi-domain tasks requiring specialist coordination

```bash
hierarchical_coordination() {
    primary_agent = deploy_coordinator("project-coordinator")
    specialists = primary_agent.identify_required_specialists()
    
    for specialist in specialists {
        if (specialist.available()) {
            primary_agent.coordinate_with(specialist)
        } else {
            create_specialist_ticket(specialist.requirements)
        }
    }
    
    return primary_agent.execute_coordinated_plan()
}
```

#### Pattern 2: Collaborative Coordination
**Usage**: Medium complexity tasks with interdependent requirements

```bash
collaborative_coordination() {
    agents = identify_required_agents()
    coordination_protocol = establish_communication_protocol(agents)
    
    parallel_execute(agents, coordination_protocol)
    integrate_results(agents.outputs)
    
    return validated_integrated_result
}
```

#### Pattern 3: Sequential Coordination
**Usage**: Tasks with clear dependency chains

```bash
sequential_coordination() {
    agent_pipeline = design_execution_pipeline()
    
    for stage in agent_pipeline {
        stage_result = execute_stage(stage.agent, stage.requirements)
        validate_stage_output(stage_result)
        prepare_next_stage_input(stage_result)
    }
    
    return pipeline_final_result
}
```

## Quality Validation Decisions

### Validation Strategy Matrix

| Output Quality | Validation Approach | Agent Requirements | Decision Logic |
|---------------|-------------------|-------------------|----------------|
| **Critical** | Multi-stage validation | Quality specialists | Deploy validation agents |
| **High** | Comprehensive validation | Standard validation | Use existing validators |
| **Standard** | Standard validation | Basic validation | Built-in validation |
| **Basic** | Minimal validation | Self-validation | Agent self-validation |

### Validation Decision Algorithm

```bash
# Validation Strategy Selection
select_validation_strategy(task_output, quality_requirements) {
    if (quality_requirements.level == "critical") {
        return deploy_multiple_validation_agents()
    } elif (quality_requirements.level == "high") {
        return deploy_specialized_validator()
    } elif (quality_requirements.level == "standard") {
        return use_standard_validation()
    } else {
        return use_built_in_validation()
    }
}
```

## Implementation Guidelines

### Command Integration Pattern

```markdown
## Agent Decision Integration (in command files)

### Decision Point 1: Initial Agent Assessment
```bash
# Assess available agents for task requirements
available_agents = scan_agents_directory()
task_match_scores = evaluate_agent_capabilities(available_agents, task_requirements)
best_match = find_highest_scoring_agent(task_match_scores)
```

### Decision Point 2: Deployment vs Creation
```bash
# Apply decision matrix
if (best_match.score >= DEPLOYMENT_THRESHOLD) {
    selected_agent = deploy_agent(best_match.agent)
} else {
    creation_justification = evaluate_creation_need(task_requirements)
    if (creation_justification.level >= "STRONG") {
        create_agent_ticket(creation_justification)
        terminate_with_tracking()
    } else {
        selected_agent = deploy_agent(best_match.agent)
    }
}
```

### Decision Point 3: Coordination Strategy
```bash
# Determine coordination approach
if (task_requirements.complexity == "high" && task_requirements.domains > 1) {
    coordination_strategy = select_coordination_pattern(task_requirements)
    execute_coordinated_deployment(selected_agents, coordination_strategy)
} else {
    execute_single_agent_deployment(selected_agent)
}
```
```

### Decision Logging Framework

```bash
# Decision Audit Trail
log_agent_decision(decision_point, decision_rationale, alternatives_considered) {
    decision_log = {
        timestamp: current_timestamp(),
        command: current_command,
        decision_point: decision_point,
        decision_made: decision_rationale.decision,
        rationale: decision_rationale.reasoning,
        alternatives: alternatives_considered,
        scores: capability_scores,
        context: current_context
    }
    
    append_to_decision_log(decision_log)
}
```

## Decision Audit Framework

### Audit Categories
1. **Decision Accuracy**: Were decisions optimal for outcomes?
2. **Decision Consistency**: Are similar tasks handled consistently?
3. **Decision Efficiency**: Are decisions made efficiently?
4. **Decision Quality**: Do decisions lead to quality outcomes?

### Audit Metrics
- **Agent Utilization Rate**: Percentage of optimal agent deployments
- **Creation Success Rate**: Percentage of created agents that prove valuable
- **Decision Reversal Rate**: Percentage of decisions requiring reversal
- **Outcome Quality Score**: Quality of results from decision-driven deployments

### Continuous Improvement Process
```bash
# Decision Framework Improvement
improve_decision_framework() {
    audit_results = analyze_decision_outcomes()
    improvement_areas = identify_decision_gaps(audit_results)
    
    for area in improvement_areas {
        enhanced_logic = develop_improved_logic(area)
        test_enhanced_logic(enhanced_logic)
        deploy_improved_framework(enhanced_logic)
    }
    
    validate_framework_improvement()
}
```

## Cross-References

### Primary Navigation
- [Return to Documentation Hub](../index.md)
- [Study consolidation architecture](command-consolidation-architecture.md)
- [Apply enhancement patterns](command-enhancement-patterns.md)

### Related Principles
- [Study agent-selection.md for systematic methodology](../principles/agent-selection.md)
- [Apply task-orchestration.md for coordination patterns](../principles/task-orchestration.md)
- [Use directive.md for execution requirements](../principles/directive.md)

### Related Architecture
- [Apply agent orchestration framework](agent-orchestration-framework.md)
- [Use command templates](../templates/enhanced-command-template.md)
- [Study validation framework](../templates/templates/components/validation-framework.md)

### Implementation Resources
- [Browse existing agents](../../agents/)
- [Review ticket registry](../planning/TICKET_REGISTRY.md)
- [Study workflow phases](../templates/templates/components/workflow-phases.md)

[⬆ Return to top](#decision-matrix-specifications)