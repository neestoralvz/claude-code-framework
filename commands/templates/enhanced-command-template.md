---
title: "[Command Name] Command - Enhanced Architecture"
author: "Claude Code System"
date: "[YYYY-MM-DD]"
version: "3.0.0"
dependencies: ["../shared/EnhancedTemplate.md", "../shared/ValidationEngine.md", "../shared/WorkflowPhases.md", "../shared/AgentManager.md"]
prerequisites: ["Command-centered architecture understanding", "Shared components access"]
audience: "System operators, developers, and architectural implementers"
purpose: "Template for implementing commands using shared DRY components with embedded principles, automatic agent deployment, and built-in validation"
keywords: ["command", "enhanced", "architecture", "template", "shared", "DRY"]
last_review: "[YYYY-MM-DD]"
architecture_type: "command-template"
execution_mode: "template"
validation_level: "comprehensive"
---

[Previous: Navigate to related command](../related-command.md) | [Return to Commands Hub for navigation](../index.md) | [Study Shared Components](../shared/index.md) | [Next: Deploy enhanced command](../next-command.md)

# [COMMAND NAME] COMMAND - ENHANCED ARCHITECTURE

⏺ **DRY Implementation**: This template demonstrates how to implement commands using [shared components](../shared/index.md) to eliminate code duplication and ensure consistency.

## Table of Contents
- [Definition](#definition)
- [Structure](#structure)
- [Execution Phases](#execution-phases)
- [Parameters](#parameters)
- [Success Criteria](#success-criteria)
- [Usage Examples](#usage-examples)
- [Implementation Template](#implementation-template)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Shared Component Usage

⏺ **Template Purpose**: This template shows how to implement commands using the shared components from `/commands/shared/` to eliminate code duplication.

### Core Shared Components Integration

#### 1. Enhanced Template Integration
```markdown
⏺ **Enhanced Architecture**: This command implements the [shared EnhancedTemplate](../shared/EnhancedTemplate.md) for complete execution environment with embedded principles and automatic agent deployment.

**Reference Implementation**: See [EnhancedTemplate.md](../shared/EnhancedTemplate.md) for complete architectural framework.

**Command-Specific Adaptations**: [Describe how this command adapts the enhanced template]
```

#### 2. Validation Engine Integration
```markdown
⏺ **Quality Assurance**: This command uses the [shared ValidationEngine](../shared/ValidationEngine.md) for comprehensive four-gate validation, eliminating external quality control dependencies.

**Reference Implementation**: See [ValidationEngine.md](../shared/ValidationEngine.md) for complete validation framework.

**Specialized Validation**: [Choose appropriate validation pattern from ValidationEngine]
```

#### 3. Workflow Phases Integration
```markdown
⏺ **Workflow Authority**: This command uses the [shared WorkflowPhases](../shared/WorkflowPhases.md) for complete 8-phase workflow methodology implementation.

**Reference Implementation**: See [WorkflowPhases.md](../shared/WorkflowPhases.md) for complete workflow framework.

**Phase Specialization**: [Choose appropriate workflow pattern from WorkflowPhases]
```

#### 4. Agent Manager Integration
```markdown
⏺ **Agent Selection**: Automated agent deployment via [CentralizedAgentDeploymentFramework](../../docs/components/centralized-agent-deployment-framework.md)

**Reference**: See [Centralized Agent Deployment Framework](../../docs/components/centralized-agent-deployment-framework.md) for complete system.

**Specializations**: [Choose appropriate agent specialization based on command type]
```

## Command-Specific Implementation

⏺ **Implementation Guide**: After integrating shared components, implement command-specific logic and adaptations.

### 1. Command Purpose Definition
```markdown
### Command Purpose
[Brief description of command's specific role in command-centered architecture]

### Execution Authority
This command operates with FULL EXECUTION AUTHORITY per command-centered architecture:
- **Complete Workflow Ownership**: Manages entire [task type] lifecycle internally
- **Integrated Quality Assurance**: Built-in validation at every [task] phase
- **Automatic Resource Management**: Handles all dependencies and integrations
- **Self-Contained Results**: Delivers complete, validated [task] outcomes
```

### 2. Command-Specific Adaptations
```markdown
**[Command Type]-Specific Adaptations**:
- [Adaptation 1 specific to this command type]
- [Adaptation 2 specific to this command type]
- [Adaptation 3 specific to this command type]
- [Adaptation 4 specific to this command type]
```

## Template Usage Instructions

⏺ **Usage Guide**: Follow these steps to create a new command using this template.

### Step 1: Copy Template Structure
1. Copy this template file to your new command location
2. Update the YAML frontmatter with command-specific information
3. Replace `[COMMAND NAME]` with your actual command name
4. Update navigation breadcrumbs with correct file paths

### Step 2: Integrate Shared Components
1. **Choose Validation Pattern**: Select appropriate pattern from [ValidationEngine.md](../shared/ValidationEngine.md)
   - `system_analysis_validation` for analysis commands
   - `task_management_validation` for management commands
   - `code_organization_validation` for organization commands

2. **Choose Workflow Pattern**: Select appropriate pattern from [WorkflowPhases.md](../shared/WorkflowPhases.md)
   - `analysis_workflow_phases` for analysis commands
   - `management_workflow_phases` for management commands
   - `workflow_command_phases` for workflow commands

3. **Choose Agent Pattern**: Select appropriate pattern from [AgentManager.md](../shared/AgentManager.md)
   - `analysis_agent_deployment` for analysis commands
   - `management_agent_deployment` for management commands
   - `workflow_agent_deployment` for workflow commands

### Step 3: Implement Command-Specific Logic
1. Define command purpose and execution authority
2. Specify command-specific adaptations
3. Add custom functionality that extends shared components
4. Include command syntax and expected output sections

## Component Integration Examples

⏺ **Integration Examples**: Real examples of how to integrate shared components.

### Analysis Command Example
```markdown
## Built-in Validation Framework

⏺ **Quality Assurance**: This command implements [system_analysis_validation](../shared/ValidationEngine.md#system-analysis-commands) from the shared ValidationEngine for specialized analysis validation.

**Analysis Validation Gates**: Requirements → Process → Output → System validation with automatic compliance checking and comprehensive analysis validation.

**Reference Implementation**: See [ValidationEngine.md](../shared/ValidationEngine.md) for complete validation framework.
```

### Management Command Example
```markdown
## Complete Workflow Integration

⏺ **Workflow Authority**: This command implements [management_workflow_phases](../shared/WorkflowPhases.md#management-command-workflow) from the shared WorkflowPhases for specialized management execution.

**Management Phase Execution**: Clarify management requirements → Explore management context → Analyze management approach → Present management decision → Plan execution strategy → Implement management task → Ripple organizational impact → Validate management completion

**Reference Implementation**: See [WorkflowPhases.md](../shared/WorkflowPhases.md) for complete workflow framework.
```
    - integration_validation: tested
    - dependency_verification: confirmed
    - regression_prevention: assured
```

### Validation Implementation
- **Real-time Monitoring**: Continuous validation during execution
- **Automated Testing**: Built-in test procedures for each phase
- **Quality Metrics**: Quantitative assessment of deliverables
- **Failure Recovery**: Automatic rollback and retry mechanisms

## Complete Workflow Integration

⏺ **Workflow Authority**: This command implements the complete 8-phase workflow methodology with command-specific adaptations.

### Phase Implementation Matrix
```yaml
workflow_phases:
  phase_1_clarify:
    embedded_logic: requirement_analysis
    validation: completeness_check
    outputs: [scope_definition, success_criteria]
    
  phase_2_explore:
    embedded_logic: context_gathering
    validation: information_adequacy
    outputs: [context_map, dependency_analysis]
    
  phase_3_analyze:
    embedded_logic: solution_framework
    validation: feasibility_assessment
    outputs: [approach_options, risk_analysis]
    
  phase_4_present:
    embedded_logic: decision_facilitation
    validation: clarity_verification
    outputs: [recommendation, decision_matrix]
    
  phase_5_plan:
    embedded_logic: implementation_design
    validation: completeness_validation
    outputs: [execution_plan, resource_allocation]
    
  phase_6_implement:
    embedded_logic: execution_coordination
    validation: quality_assurance
    outputs: [deliverables, progress_tracking]
    
  phase_7_ripple:
    embedded_logic: impact_management
    validation: consistency_check
    outputs: [updates, dependency_resolution]
    
  phase_8_validate:
    embedded_logic: completion_verification
    validation: success_confirmation
    outputs: [validation_report, completion_certificate]
```

### Command-Specific Workflow Adaptations
[Describe how this specific command adapts the 8-phase workflow]

## Quality Gates and Success Criteria

⏺ **Success Validation**: This command includes built-in success criteria validation that automatically verifies completion against established requirements.

### Success Criteria Framework
```yaml
success_criteria:
  functional_requirements:
    - [ ] Core functionality delivered as specified
    - [ ] All acceptance criteria met completely
    - [ ] Integration points functioning correctly
    
  quality_requirements:
    - [ ] Engineering standards applied throughout
    - [ ] Validation gates passed successfully
    - [ ] Documentation updated appropriately
    
  architectural_requirements:
    - [ ] Command-centered execution maintained
    - [ ] Principle integration functioning properly
    - [ ] Agent deployment working correctly
    
  system_requirements:
    - [ ] No regressions introduced
    - [ ] Dependencies properly managed
    - [ ] Registry updates completed
```

### Automated Validation Procedures
1. **Pre-execution Validation**: Requirements completeness and feasibility
2. **Process Validation**: Workflow compliance and quality adherence
3. **Output Validation**: Deliverable quality and specification match
4. **Post-execution Validation**: System integration and impact assessment

## Architecture Integration Patterns

⏺ **Integration**: This command demonstrates complete integration of all architectural components for seamless operation.

### Component Integration Matrix
```yaml
architecture_integration:
  principle_embedding:
    method: direct_application
    validation: automatic
    enforcement: continuous
    
  agent_coordination:
    method: intelligent_deployment
    validation: capability_matching
    enforcement: resource_optimization
    
  workflow_integration:
    method: phase_based_execution
    validation: completeness_checking
    enforcement: quality_gating
    
  validation_framework:
    method: four_gate_system
    validation: comprehensive_testing
    enforcement: automatic_verification
```

### Integration Benefits
- **Simplified Execution**: Single command handles complete workflow
- **Consistent Quality**: Built-in standards ensure reliability
- **Reduced Coordination**: Eliminates external dependency management
- **Predictable Outcomes**: Integrated validation ensures success

## Command Syntax

```bash
# Enhanced command execution with integrated environment
[command-name] --execute [parameters]

# Execution modes
[command-name] --mode [comprehensive|focused|minimal]

# Validation levels
[command-name] --validation [standard|thorough|comprehensive]

# Agent deployment options
[command-name] --agents [auto|manual|specify:agent-name]

# Output formats
[command-name] --output [summary|detailed|complete]
```

## Implementation Examples

### Basic Enhanced Execution
```bash
[command-name] --execute --mode comprehensive
# Complete workflow with full validation and automatic agent deployment
```

### Focused Mode with Specific Validation
```bash
[command-name] --mode focused --validation thorough --output detailed
# Targeted execution with enhanced validation and detailed reporting
```

### Manual Agent Specification
```bash
[command-name] --agents specify:project-optimizer --validation comprehensive
# Execute with specific agent and maximum validation
```

## Cross-References

### Enhanced Architecture Navigation
- [Return to Commands Hub navigation](../index.md)
- [Study Command Architecture Patterns integration](../../docs/components/command-architecture-patterns.md)
- [Review Enhanced Commands Index comprehensive](../enhanced-commands-index.md)

### Related Enhanced Commands
- [Execute enhanced system-audit.md comprehensive analysis](../analysis/system-audit.md)
- [Deploy enhanced create-ticket.md ticket generation](../management/create-ticket.md)
- [Execute enhanced review-tickets.md priority processing](../management/review-tickets.md)
- [Apply enhanced modularize.md component extraction](../analysis/modularize.md)

### Architectural References
- [Study Command-Centered Architecture Guide implementation](../../docs/architecture/command-centered.md)
- [Apply Integration Patterns Documentation strategies](../../docs/patterns/integration.md)
- [Reference Validation Framework comprehensive testing](../../docs/components/validation-framework.md)

[⬆ Return to top](#command-name-command---enhanced-architecture)