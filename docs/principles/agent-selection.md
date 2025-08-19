---
title: "Agent Selection Principles"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["context-efficiency.md", "workflow.md", "engineering.md"]
prerequisites: ["Understanding of agent catalog", "Multi-perspective analysis methodology"]
audience: "Main Claude Code instance for agent deployment decisions"
purpose: "Define systematic methodology for optimal agent selection and creation"
keywords: ["agent-selection", "analysis", "optimization", "agent-catalog", "multi-perspective"]
last_review: "2025-08-18"
---

[Previous: Study context-efficiency.md for delegation](context-efficiency.md) | [Return to documentation hub for navigation](../index.md) | [Study PRINCIPLES.md for framework](../PRINCIPLES.md) | [Next: Study communication.md for imperative tone](communication.md)

# AGENT SELECTION

⏺ **Principle**: ALL tasks MUST use agents from /agents/ folder. When no suitable agent exists, MANDATORY ticket generation ensures agent creation or conversation termination with tracking.

## Table of Contents
- [Core Philosophy](#core-philosophy)
- [Fundamental Concepts](#fundamental-concepts)
- [Implementation Framework](#implementation-framework)
- [Standards Guidelines](#standards-guidelines)
- [Validation](#validation)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Mandatory Agent Usage

⏺ **Principle**: This mandate implements [directive.md execution requirements](directive.md) by ensuring ALL tasks execute through specialized agents from /agents/ folder exclusively.

### Core Requirements
- **NO DIRECT EXECUTION** - Main instance MUST NOT perform tasks directly when agents exist
- **AGENT-FIRST APPROACH** - Always check /agents/ folder before any task execution
- **MANDATORY DELEGATION** - Use Task Tool to deploy appropriate agents for all operations
- **ZERO EXCEPTIONS** - No task exemptions from agent delegation requirement

### Enforcement Protocol
1. **Task receipt** - Analyze incoming request for agent requirements
2. **Agent catalog scan** - Search /agents/ folder for suitable specialist
3. **Deployment decision** - Either deploy existing agent or generate creation ticket
4. **Execution restriction** - NEVER proceed with direct execution when agents available

### Quality Benefits
- **Specialized expertise** - Agents provide deeper domain knowledge
- **Consistent quality** - Standardized approach across all task types
- **Context preservation** - Main instance maintains high-level coordination
- **Framework integrity** - Systematic adherence to delegation principles

[⬆ Return to top](#agent-selection)

## Selection Methodology

⏺ **Principle**: This methodology implements [context-efficiency.md delegation framework](context-efficiency.md#agent-delegation-framework) through systematic agent matching analysis.

### Core Process
1. **Analyze task requirements** from multiple perspectives
2. **Evaluate existing agent catalog** for capability matches
3. **Assess agent scope alignment** with task specifics
4. **Determine creation necessity** if no optimal match exists
5. **Deploy selected or created agent** via Task Tool

### Decision Framework
- **Task complexity analysis** - Determine specialization requirements
- **Scope precision matching** - Align agent expertise with task needs
- **Performance optimization** - Select most effective agent for outcome
- **Resource efficiency** - Balance capability with task requirements

[⬆ Return to top](#agent-selection)

## Multi-Perspective Analysis

⏺ **Principle**: This analysis implements [workflow.md systematic phases](workflow.md) by examining tasks from all relevant angles for optimal agent matching.

### Analysis Perspectives

#### Technical Perspective
- **Implementation complexity** - Code, system, or tool requirements
- **Domain expertise needed** - Language, framework, or technology specifics
- **Integration requirements** - Compatibility with existing systems
- **Quality standards** - Technical excellence requirements

#### Functional Perspective
- **Task category** - Analysis, creation, optimization, or maintenance
- **Output requirements** - Documentation, code, reports, or decisions
- **Success criteria** - Measurable outcomes and validation needs
- **Workflow integration** - Fit within broader task sequences

#### Strategic Perspective
- **User goals alignment** - Primary objective fulfillment
- **Context preservation** - Main instance efficiency maintenance
- **Long-term value** - Reusability and framework enhancement
- **Risk mitigation** - Quality assurance and error prevention

[⬆ Return to top](#agent-selection)

## Agent Catalog Assessment

⏺ **Principle**: Catalog assessment implements [engineering.md modular design](engineering.md) by evaluating existing agents against task requirements.

### Current Agent Catalog
- **project-optimizer** - Complex analysis and optimization tasks
- **agent-creator** - Building specialized tools and new agents
- **delegation-advisor** - Task routing and distribution planning
- **agent-architect** - Gold standard agent structure and design
- **monitoring-specialist** - Real-time operational monitoring and alerting
- **system-auditor** - Static analysis and compliance validation
- **validation-engineer** - Quality methodology and evidence-based verification

**For complete agent capabilities and selection guidance, refer to [agent-capability-matrix.md](../agent-capability-matrix.md)**

### Evaluation Criteria
- **Scope alignment** - Direct match between agent expertise and task needs
- **Capability coverage** - Complete task fulfillment potential
- **Quality track record** - Historical performance and reliability
- **Resource efficiency** - Optimal capability-to-task ratio

### Selection Rules
- **Highest specialization priority** - ALWAYS select agent with deepest domain expertise (doctorate-level knowledge)
- **Exact match priority** - Select agent with precise scope alignment over generalist approaches
- **Capability superset** - Choose agent whose capabilities encompass task requirements completely
- **Avoid scope overlap** - Prevent using general-purpose when specialist exists
- **Never force fit** - Create new agent rather than misalign existing one
- **Expertise hierarchy** - Prefer specialist > expert > generalist for optimal task fulfillment

[⬆ Return to top](#agent-selection)

## Agent Creation Decision

⏺ **Principle**: Creation decisions implement [context-efficiency.md quality control](context-efficiency.md#quality-control) by ensuring optimal agent availability for all task types.

### Creation Triggers
- **No suitable agent exists** in current catalog
- **Scope mismatch** - Available agents lack required specialization
- **Quality requirements** - Existing agents insufficient for task complexity
- **Future reusability** - Task type likely to recur frequently

### Creation Process
1. **Deploy agent-creator** for new agent development
2. **Define precise agent scope** per expert specialization requirements
3. **Validate agent effectiveness** through test deployment
4. **Integrate into catalog** for future reference

### Quality Standards
- **Expert-level specialization** - Deep capability in target domain
- **Precise scope definition** - Clear boundaries and responsibilities
- **Framework compliance** - Adherence to all system principles
- **Documented capabilities** - Clear usage guidelines and limitations

[⬆ Return to top](#agent-selection)

## Ticket Generation Requirements

⏺ **Principle**: This requirement implements [TICKET_METHODOLOGY.md systematic tracking](../planning/TICKET_METHODOLOGY.md) by ensuring ALL missing agent scenarios generate continuation tickets before conversation termination.

### Mandatory Ticket Scenarios

#### Missing Agent Discovery
- **IMMEDIATE TICKET GENERATION** when no suitable agent exists in /agents/ folder
- **CONVERSATION TERMINATION** after ticket creation to prevent direct execution
- **CLEAR TRACKING** of required agent specifications and timeline
- **PRIORITY CLASSIFICATION** based on task urgency and system impact

#### Planning Phase Agent Identification
- **PROACTIVE TICKET CREATION** during planning when multiple agents needed
- **FUTURE AGENT REQUIREMENTS** documented for systematic development
- **WORKFLOW CONTINUITY** ensured through ticket-based agent creation tracking
- **RESOURCE ALLOCATION** planning for agent development priorities

### Ticket Generation Protocol

#### Required Ticket Content
1. **Agent specification** - Precise scope and capability requirements
2. **Task context** - Original request and execution requirements
3. **Priority level** - Urgency classification for development scheduling
4. **Dependencies** - Related agents or framework components needed
5. **Success criteria** - Validation requirements for completed agent

#### Ticket Integration Process
1. **Generate ticket** using [TICKET_REGISTRY.md methodology](../planning/TICKET_REGISTRY.md)
2. **Classify priority** based on framework impact and user urgency
3. **Document context** with sufficient detail for future agent creation
4. **Terminate conversation** with clear user notification of ticket creation
5. **Schedule follow-up** for agent creation and task completion

### Quality Assurance
- **NO WORKAROUNDS** - Never proceed without appropriate agent
- **COMPLETE DOCUMENTATION** - All ticket content requirements fulfilled
- **SYSTEMATIC TRACKING** - Integration with existing ticket management
- **USER TRANSPARENCY** - Clear communication of process and timeline

[⬆ Return to top](#agent-selection)

## Deployment Validation

⏺ **Principle**: Deployment validation implements [workflow.md validation phase](workflow.md#7-validation) by ensuring selected agents fulfill task requirements effectively.

### Pre-Deployment Checks
- **Scope-task alignment verified** - Agent capabilities match task requirements
- **Success criteria defined** - Clear validation standards established
- **Context handoff prepared** - Relevant information extracted for agent
- **Integration path planned** - Result incorporation strategy ready

### Post-Deployment Validation
- **Output quality assessment** - Technical and functional excellence verification
- **Requirement fulfillment** - Complete task completion validation
- **Framework compliance** - Adherence to all system principles
- **Context integration** - Seamless incorporation into main instance workflow

[⬆ Return to top](#agent-selection)

## Principle References

### Applied Principles
- [Study context-efficiency.md for delegation methodology](context-efficiency.md)
- [Study workflow.md for systematic phases](workflow.md)
- [Study directive.md for execution requirements](directive.md)
- [Study engineering.md for modular design](engineering.md)

### Quality Standards
- [Study files.md for efficient management](files.md)
- [Study simplicity.md for essential focus](simplicity.md)
- [Study formatting.md for consistency](formatting.md)

[⬆ Return to top](#agent-selection)

## Cross-References

### Primary Navigation
- [Return to documentation hub for navigation](../index.md)
- [Study PRINCIPLES.md for framework](../PRINCIPLES.md)
- [Browse agents directory for catalog](../agents/)

### Related Principles
- [Study context-efficiency.md for delegation](context-efficiency.md)
- [Study workflow.md for systematic execution](workflow.md)
- [Study engineering.md for technical standards](engineering.md)
- [Study directive.md for primary guidance](directive.md)

### Related Agents
- [Deploy project-optimizer.md for complex analysis](../agents/project-optimizer.md)
- [Use agent-creator.md for new agent development](../agents/agent-creator.md)
- [Apply delegation-advisor.md for task routing](../agents/delegation-advisor.md)
- [Reference agent-architect.md for gold standard](../agents/agent-architect.md)

### Related Components
- [Apply workflow.md for systematic execution phases](workflow.md)
- [Use navigation.md for consistent links](../components/navigation.md)

[⬆ Return to top](#agent-selection)