# Maintain System Configuration Workflow

**Integrate Universal Workflows**: Use all workflow modules from the [Universal Workflows Index](../modules/idx-catalog-workflows.md) for complete systematic configuration maintenance.

## 1. Define Configuration Maintenance Goals

### 1.1 State Primary Objective
Maintain and update the CLAUDE.md system configuration file to reflect current directory structure, development commands, and organizational changes.

### 1.2 List Specific Objectives
- Deploy content analysis agents to analyze CLAUDE.md for configuration gaps and outdated references
- Deploy path correction specialists to update file references and command paths
- Deploy documentation refresh agents to align configuration with current directory structure
- Deploy validation agents to verify configuration accuracy and functionality

## 2. Deploy Multi-System Exploration Agents

**Apply Universal Exploration Deployment**: Follow systematic exploration methodology from [Universal Exploration Deployment Workflow](../modules/wfl-deploy-exploration-agents.md) to deploy specialized agents across system configuration files and documentation requirements.

## 3. Read Essential Documentation

Read these documents before executing:
- Read [CLAUDE.md](../../../CLAUDE.md) to understand current system configuration
- Read [index.md](../../../index.md) to verify navigation references and structure
- Read [wfl-organize-structure.md](wfl-organize-structure.md) to learn recent organizational changes

## 4. Establish Success Criteria

### 4.1 Define Success Requirements
- Achieve 100% accurate file paths and command references in CLAUDE.md
- Achieve complete documentation of current directory structure and organization
- Achieve consistent navigation references across all configuration sections

### 4.2 Set Success Metrics
Measure success using these calculations:
- **Efficiency**: [CLAUDE.md maintenance completed in under 20 minutes] - Calculate as actual_time <= 20_minutes
- **Quality**: [100% functional file paths and navigation references] - Calculate as functional_paths / total_paths * 100
- **Completeness**: [All significant directories and organizational changes documented] - Calculate as documented_changes / total_changes * 100

## 5. Create Implementation Plan

**Apply Universal Planning**: Follow systematic planning methodology from [Universal Planning Workflow](../modules/wfl-plan-execution.md) to design complete configuration maintenance strategy and multi-agent deployment plan.

## 6. Deploy Multi-Agent Orchestration

**Apply Universal Execution**: Follow systematic implementation methodology from [Universal Execution Workflow](../modules/wfl-execute-plans.md) to deliver configuration maintenance through coordinated multi-agent deployment.

### 6.1 Backup and Analysis - Sequential
Deploy configuration management agents via Task tools:

Task(
  subagent_type: "configuration-management-specialist",
  description: "Backup and analyze CLAUDE.md state",
  prompt: "Execute Required Exploration: Analyze current CLAUDE.md structure and content
          Read Required Documentation: Review organizational changes and requirements
          Execute: Create backup and identify outdated sections and incorrect paths
          DELIVERABLES:
          - Backup file: commands-docs/CLAUDE.md.backup
          - Results: operations/[conversation-id]/claude-md-analysis-results"
)
**COORDINATION**: Sequential execution

### 6.2 Directory Structure Updates - Parallel
Deploy documentation update agents via Task tools:

Task(
  subagent_type: "documentation-update-specialist",
  description: "Update directory structure documentation",
  prompt: "Execute Required Exploration: Review new directory hierarchy and organization
          Read Required Documentation: Compare current vs required structure documentation
          Execute: Update file path references and organizational pattern documentation
          DELIVERABLES:
          - Updated structure: commands-docs/CLAUDE.md
          - Results: operations/[conversation-id]/structure-update-results"
)
**COORDINATION**: Parallel execution

### 6.3 Command Reference Updates - Parallel
Deploy command reference management agents via Task tools:

Task(
  subagent_type: "command-reference-specialist",
  description: "Update command paths and references",
  prompt: "Execute Required Exploration: Validate existing command paths and workflows
          Read Required Documentation: Review command execution patterns and examples
          Execute: Correct command paths, update development workflows, verify examples
          DELIVERABLES:
          - Updated commands: commands-docs/CLAUDE.md
          - Results: operations/[conversation-id]/command-update-results"
)
**COORDINATION**: Parallel execution

### 6.4 Configuration Validation - Sequential
Deploy configuration validation agents via Task tools:

Task(
  subagent_type: "configuration-validation-specialist",
  description: "Validate configuration accuracy",
  prompt: "Execute Required Exploration: Systematically verify all file references
          Read Required Documentation: Test navigation links and check consistency
          Execute: Comprehensive accuracy validation against actual system organization
          DELIVERABLES:
          - Validation report: commands-docs/claude-md-validation-report.json
          - Results: operations/[conversation-id]/configuration-validation-results"
)
**COORDINATION**: Sequential execution

## 7. Validate Complete Success

**Apply Universal Validation**: Follow four-gate validation methodology from [Universal Validation Workflow](../modules/wfl-validate-success.md) to verify configuration maintenance success and ensure quality standards.

## 8. Iterate Until Perfect Results

**Apply Universal Recursion**: Follow systematic iteration methodology from [Universal Recursion Workflow](../modules/wfl-recurse-improvement.md) to achieve continuous improvement and complete configuration maintenance success.

## 9. Manage System-Wide Impact

**Apply Universal Ripple Effect**: Follow systematic impact management from [Universal Ripple Effect Workflow](../modules/wfl-manage-effects.md) to coordinate cross-system changes and configuration dependencies.

## 10. Connect Related Workflows

Present these workflow connections:
- **Prerequisite**: [wfl-organize-structure.md](wfl-organize-structure.md) - Execute before this workflow to establish directory organization
- **Parallel**: [validate-navigation.md](../validate-navigation.md) - Execute simultaneously with this workflow to verify navigation integrity
- **Follow-up**: [update-documentation.md](../update-documentation.md) - Execute after this workflow to maintain documentation consistency
- **Alternative**: [system-configuration-audit.md](../system-configuration-audit.md) - Execute instead of this workflow for comprehensive configuration review