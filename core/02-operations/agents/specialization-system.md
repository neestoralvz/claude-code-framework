# Specialized Agents System Documentation

**Context**: Framework implementation of specialized agents for targeted expertise domains
**Created**: 2025-08-20

---

## Overview

The .claude framework now includes 5 core specialized agents deployed in `~/.claude/agents/` for global access. Each agent provides deep expertise in specific domains while maintaining framework integration and evidence-based validation.

## Deployed Agents

### 1. Testing Specialist (`testing-specialist`)
- **Color**: Orange  
- **Model**: Sonnet
- **Domain**: TDD/BDD methodologies, Jest configuration, coverage analysis
- **Use Cases**: Complete testing framework setup, coverage improvement, test modernization
- **Tools**: Full testing and development toolkit

### 2. Documentation Curator (`documentation-curator`)  
- **Color**: Green
- **Model**: Sonnet
- **Domain**: Markdown optimization, README creation, knowledge organization
- **Use Cases**: API documentation, technical writing, documentation system design
- **Tools**: Content management and development toolkit

### 3. Security Validator (`security-validator`)
- **Color**: Red
- **Model**: Sonnet  
- **Domain**: Permission auditing, vulnerability assessment, defensive security
- **Use Cases**: Security audits, secure coding implementation, compliance validation
- **Tools**: Security analysis and development toolkit
- **Note**: Defensive security only - refuses malicious code creation

### 4. Performance Optimizer (`performance-optimizer`)
- **Color**: Yellow
- **Model**: Sonnet
- **Domain**: Node.js performance analysis, bottleneck identification, optimization
- **Use Cases**: Performance profiling, caching strategies, scalability improvements  
- **Tools**: Performance analysis and development toolkit

### 5. Integration Specialist (`integration-specialist`)
- **Color**: Blue
- **Model**: Sonnet
- **Domain**: API integration, service orchestration, system connectivity
- **Use Cases**: Third-party API integration, microservice communication, data pipelines
- **Tools**: Integration development and testing toolkit

## Agent Architecture

### YAML Frontmatter Structure
```yaml
---
name: agent-name
description: Detailed description with examples
tools: [tool1, tool2, tool3]
model: opus|sonnet|haiku
color: colorname
---
```

### Common Agent Components
- **Core Expertise**: Specific domain knowledge and capabilities
- **Operational Approach**: 3-phase methodology (Assessment, Implementation, Validation)
- **Quality Assurance Criteria**: Evidence-based success metrics
- **Specialized Capabilities**: Advanced domain-specific features
- **Framework Integration**: Alignment with Simple and Easy Framework principles

## Usage Patterns

### Agent Invocation
Use the Task tool to invoke specialized agents:
```markdown
Task tool with subagent_type: "testing-specialist"
```

### When to Use Specialized Agents
- **Complex Domain Work**: Multi-step processes requiring deep expertise
- **Quality Requirements**: Need for evidence-based validation and documentation
- **Framework Compliance**: Work requiring alignment with system standards
- **Scalable Solutions**: Implementations requiring long-term maintainability

### Model Selection Criteria
- **opus**: Most complex reasoning, advanced architectural analysis, novel problem solving
- **sonnet**: Standard development tasks, strategic planning, multi-step workflows (most agents)
- **haiku**: Fast validation, simple checks, maintenance operations

### Agent Selection Guidelines
- **testing-specialist**: Test frameworks, TDD/BDD, coverage analysis
- **documentation-curator**: Technical writing, README creation, knowledge systems
- **security-validator**: Security audits, vulnerability assessment, compliance
- **performance-optimizer**: Performance analysis, optimization, scalability
- **integration-specialist**: API integration, service connectivity, data pipelines

## Quality Standards

### Evidence-Based Validation
Every agent provides:
- **Measurable Results**: Quantified outcomes with before/after metrics
- **Working Examples**: Functional demonstrations of implemented solutions
- **Comprehensive Documentation**: Clear maintenance and usage procedures
- **Testing Validation**: Proof that implementations work correctly
- **Framework Compliance**: Adherence to Simple and Easy Framework principles

### Operational Excellence
- **3-Phase Methodology**: Assessment → Implementation → Validation
- **Quality Gates**: Clear success criteria for each implementation
- **Continuous Improvement**: Feedback loops and optimization cycles
- **Integration Focus**: Seamless integration with existing systems

## Framework Integration

### Alignment with Core Principles
- **Simple**: Clear, understandable implementations
- **Easy**: Accessible solutions with minimal complexity
- **Evidence-Based**: All claims supported by verifiable results
- **Systematic**: Consistent approaches across all agents

### Workflow Integration
- Compatible with existing TDD/BDD workflows
- Supports validation and demonstration requirements  
- Integrates with framework hooks and automation
- Maintains consistency with system organization patterns

## Deployment and Maintenance

### Agent Locations
- **Global Agents**: `~/.claude/agents/` for system-wide access
- **Project Agents**: `.claude/agents/` for project-specific specialists

### Agent Testing
Use Task tool to test agent functionality:
- Deploy agent with specific task description
- Validate agent response and capabilities
- Verify framework compliance and quality

### Future Expansion
- Additional agents can be created following established patterns
- Agent registry system for discovery and management
- Integration with Claude Code subagent creation workflows
- Continuous optimization based on usage patterns

---

**Implementation Status**: ✅ Complete - 5 specialized agents deployed and ready for use
**Framework Integration**: ✅ Complete - Full alignment with Simple and Easy Framework
**Quality Validation**: ✅ Complete - Evidence-based validation patterns implemented