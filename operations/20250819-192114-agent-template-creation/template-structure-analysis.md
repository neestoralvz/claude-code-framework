# Agent Template Structure Analysis

## Analysis Overview

Based on examination of the `agent-template-architect.md` file, agent registry, and related documentation, I've identified the essential structural components that make agents effective within our orchestration framework.

## Core Template Components

### 1. YAML Frontmatter Structure
```yaml
---
name: agent-template-architect
description: Use this agent when you need to create standardized agent templates, analyze existing agent structures for pattern extraction, design reusable agent creation frameworks, or establish systematic agent deployment processes. Examples: <example>Context: User wants to create a consistent framework for deploying new agents across their system. user: 'I need to standardize how we create agents so they all follow the same patterns and integrate properly with our workflow' assistant: 'I'll use the agent-template-architect to analyze our existing agents and create a standardized template framework' <commentary>The user needs systematic agent creation patterns, which is exactly what this agent specializes in.</commentary></example> <example>Context: User has multiple agents but wants to ensure they all follow evidence-based design patterns. user: 'Our agents work but they're inconsistent - some follow different patterns and it's getting hard to manage' assistant: 'Let me engage the agent-template-architect to extract the best patterns from our existing agents and create a unified template structure' <commentary>This requires analyzing existing structures and creating standardized patterns, which is this agent's core expertise.</commentary></example>
tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, NotebookEdit, WebFetch, TodoWrite, WebSearch, BashOutput, KillBash
model: sonnet
color: pink
---
```

### 2. Agent Identity Section
- Clear role definition and specialization
- Domain expertise and scope
- Primary responsibilities categorized by function

### 3. Operational Framework
- Analysis Phase components
- Template Creation methodology
- Framework Development process
- Operational Standards alignment
- Quality Assurance protocols
- Output Requirements specification

### 4. Integration Requirements
- Reference to CLAUDE.md, STANDARDS.md, PROCESSES.md
- Operations directory structure (/operations/YYYYMMDD-HHMMSS-*)
- Evidence-based validation approach
- Restart criteria for 100% compliance

## Essential Patterns Identified

### Agent Definition Pattern
1. **Specialized Role**: Clear domain expertise and boundaries
2. **Systematic Approach**: Structured methodology with phases
3. **Quality Integration**: Built-in validation and compliance
4. **Evidence-Based**: Verifiable outcomes and metrics
5. **Framework Alignment**: Consistent with CLAUDE.md preferences

### Registry Integration Pattern
From agents.json analysis:
- Unique ID and name
- Category classification
- Specialization description
- Capabilities array
- Status tracking
- Deployment configuration
- Metadata (expertise level, domain, creation date)

### Quality Assurance Pattern
- Evidence-based design principles
- Restart protocols for non-compliance
- Integration with validation frameworks
- Structured deliverables and success criteria

## Integration Touchpoints

### 1. CLAUDE.md Alignment
- Simple and Easy Framework principles
- Orchestrator role deployment
- Agent deployment protocol
- Evidence-based success criteria
- Operations folder structure

### 2. System Standards
- File organization standards
- Content approach consistency
- Markdown formatting requirements
- Link file standards

### 3. Process Integration
- Complete workflow alignment
- Thinking processes for complexity
- Error handling workflow
- Parallel execution workflow

## Success Factors

### 1. Immediate Usability
- Clear deployment configuration
- Complete tool specification
- Executable without additional interpretation

### 2. Framework Consistency
- Alignment with existing orchestration
- Integration with validation systems
- Evidence-based outcomes

### 3. Quality Assurance
- Built-in compliance mechanisms
- Restart criteria for failures
- Systematic validation integration

## Template Requirements

Based on this analysis, the reusable template must include:

1. **Structured YAML frontmatter** with all required fields
2. **Modular content sections** that can be customized per domain
3. **Integration specifications** for orchestration framework
4. **Quality assurance protocols** with validation requirements
5. **Evidence-based success criteria** that are verifiable
