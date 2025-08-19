# Apply Template Format Workflow

**Integrate Universal Workflows**: Use all workflow modules from the [Universal Workflows Index](../modules/idx-catalog-workflows.md) for complete systematic template application.

## 1. Define Template Application Goals

### 1.1 State Primary Objective
Transform existing workflow files to conform to standardized template format with consistent structure and imperative tone.

### 1.2 List Specific Objectives
- Deploy content analysis agents to analyze target files for template application needs
- Deploy dependency analysis specialists to identify which documents the assistant must read to execute each workflow properly
- Deploy pattern detection specialists to identify repetitive content blocks across workflows
- Deploy template formatting agents to implement consistent structure and imperative tone
- Deploy modularization specialists to extract reusable workflow components
- Deploy validation agents to ensure complete template compliance and quality standards

### 1.3 Parallel Agent Deployment Requirement
**CRITICAL FRAMEWORK COMPLIANCE**: All agent deployments must use Task tools executed in parallel within the same message when operations are independent. This ensures optimal resource utilization and adherence to Claude Code Framework orchestrator requirements.

## 2. Deploy Multi-System Exploration Agents

**Apply Universal Exploration Deployment**: Follow systematic exploration methodology from [Universal Exploration Deployment Workflow](../modules/wfl-deploy-exploration-agents.md) to deploy specialized agents across target workflow files and template requirements.

## 3. Read Essential Documentation

### 3.1 Foundation Documents (MANDATORY READ FIRST)
**Execute these reads before any workflow operations**:
- Read [idx-catalog-workflows.md](../modules/idx-catalog-workflows.md) to understand universal workflow catalog and integration architecture
- Read [tpl-create-workflows.md](../templates/tpl-create-workflows.md) to understand master template structure and formatting
- Read target workflow files to analyze current content and organization

### 3.2 Universal Workflow Modules (SEQUENTIAL EXECUTION ORDER)
**Read modules in execution order for systematic methodology**:
- Read [wfl-deploy-exploration-agents.md](../modules/wfl-deploy-exploration-agents.md) for Phase 2 multi-agent system exploration methodology
- Read [wfl-plan-execution.md](../modules/wfl-plan-execution.md) for Phase 5 systematic planning methodology
- Read [wfl-execute-plans.md](../modules/wfl-execute-plans.md) for Phase 6 execution methodology with 4-pattern implementation
- Read [wfl-validate-success.md](../modules/wfl-validate-success.md) for Phase 7 four-stage success validation framework
- Read [wfl-recurse-improvement.md](../modules/wfl-recurse-improvement.md) for Phase 8 iterative improvement methodology
- Read [wfl-manage-effects.md](../modules/wfl-manage-effects.md) for Phase 9 impact management across system scales

### 3.3 Quality Standards & Architecture (MANDATORY COMPLIANCE)
**Read quality frameworks for template compliance**:
- Read [gui-apply-solid.md](../../commands-docs/principles/gui-apply-solid.md) to understand SOLID principles for natural language documentation quality standards

### 3.4 Runtime Dependencies (AS-NEEDED BASIS)
**Read implementation documents during execution phases**:
- Read implementation pattern documents for domain-specific template application
- Read success criteria templates during validation phases for mathematical success measurement
- Read related workflow documents for integration requirements when executing connected workflows

## 4. Establish Success Criteria

### 4.1 Define Success Requirements
- Achieve consistent template format application across all target workflow files
- Achieve imperative tone conversion for all action items and section headers
- Achieve conversion to clear, coherent, effective, specific, concise, and direct natural language commands
- Achieve universal module extraction for repetitive workflow phases with proper integration
- Achieve hierarchical numbering system implementation with logical section organization
- Achieve pattern analysis and modularization with elimination of duplicate content blocks
- Achieve reusable pattern module integration within workflow files for maintenance efficiency

### 4.2 Set Success Metrics
Measure success using these calculations:
- **Efficiency**: Template formatting completed in under 15 minutes per file - Calculate as actual_time <= 15_minutes
- **Quality**: 100% template structure compliance with consistent formatting - Calculate as compliant_sections / total_sections * 100
- **Language Clarity**: 100% instructions converted to imperative natural language - Calculate as imperative_instructions / total_instructions * 100
- **Module Extraction**: 100% repetitive phases extracted to universal modules - Calculate as extracted_phases / repetitive_phases * 100
- **Completeness**: All workflow sections formatted according to template standards - Calculate as formatted_sections / required_sections * 100
- **Pattern Optimization**: 90% reduction in duplicate content blocks - Calculate as (original_duplicates - remaining_duplicates) / original_duplicates * 100
- **Modularization**: 100% pattern modules integrated successfully - Calculate as integrated_modules / identified_patterns * 100

## 5. Create Implementation Plan

**Apply Universal Planning**: Follow systematic planning methodology from [Universal Planning Workflow](../modules/wfl-plan-execution.md) to design complete template application strategy and multi-agent deployment plan.

## 6. Deploy Multi-Agent Orchestration

**Apply Universal Execution**: Follow systematic implementation methodology from [Universal Execution Workflow](../modules/wfl-execute-plans.md) to deliver template application through coordinated multi-agent deployment.

### 6.1 Content Analysis and Dependencies - Parallel
Deploy analysis agents via Task tools in parallel execution:

Task(
  subagent_type: "content-analysis-specialist",
  description: "Analyze target workflow structure",
  prompt: "Execute Required Exploration: Scan target workflow files for template needs
          Read Required Documentation: Review template structure requirements
          Execute: Identify sections requiring template format conversion
          DELIVERABLES:
          - Analysis report: operations/[conversation-id]/content-analysis-results
          - File mapping: commands-docs/workflow-analysis.json"
)

Task(
  subagent_type: "dependency-analysis-specialist", 
  description: "Identify workflow documentation dependencies",
  prompt: "Execute Required Exploration: Map required reading patterns
          Read Required Documentation: Review workflow execution dependencies
          Execute: Create dependency matrix for proper workflow execution
          DELIVERABLES:
          - Dependency matrix: operations/[conversation-id]/dependency-analysis-results
          - Reading order: commands-docs/workflow-dependencies.json"
)

Task(
  subagent_type: "pattern-detection-specialist",
  description: "Detect repetitive content patterns", 
  prompt: "Execute Required Exploration: Identify duplicate content blocks
          Read Required Documentation: Review modularization requirements
          Execute: Map repetitive patterns for universal module extraction
          DELIVERABLES:
          - Pattern analysis: operations/[conversation-id]/pattern-detection-results
          - Module candidates: commands-docs/pattern-modules.json"
)

**COORDINATION REQUIREMENT**: Execute all three Task tools in the same message for parallel deployment

### 6.2 Template Application and Modularization - Parallel
Deploy transformation agents via Task tools in parallel execution:

Task(
  subagent_type: "template-formatting-specialist",
  description: "Apply template format to workflows",
  prompt: "Execute Required Exploration: Review template structure requirements
          Read Required Documentation: Analyze current workflow content organization
          Execute: Transform workflows to template format with imperative tone
          DELIVERABLES:
          - Formatted workflows: system/workflows/components/[updated-files]
          - Results: operations/[conversation-id]/template-formatting-results"
)

Task(
  subagent_type: "modularization-specialist",
  description: "Extract universal workflow modules",
  prompt: "Execute Required Exploration: Identify repetitive workflow phases
          Read Required Documentation: Review universal module architecture
          Execute: Extract reusable patterns to universal modules directory
          DELIVERABLES:
          - Universal modules: system/workflows/modules/[extracted-modules]
          - Results: operations/[conversation-id]/modularization-results"
)

**COORDINATION REQUIREMENT**: Execute both Task tools in the same message for parallel deployment

### 6.3 Quality Validation - Sequential
Deploy validation agents via Task tools:

Task(
  subagent_type: "template-validation-specialist",
  description: "Validate template compliance",
  prompt: "Execute Required Exploration: Verify template format compliance
          Read Required Documentation: Review quality standards and metrics
          Execute: Comprehensive validation against template requirements
          DELIVERABLES:
          - Validation report: operations/[conversation-id]/template-validation-results
          - Compliance matrix: commands-docs/template-compliance.json"
)

**COORDINATION REQUIREMENT**: Execute after completion of phases 6.1 and 6.2

## 7. Validate Complete Success

**Apply Universal Validation**: Follow four-gate validation methodology from [Universal Validation Workflow](../modules/wfl-validate-success.md) to verify template application success and ensure quality standards.

## 8. Iterate Until Perfect Results

**Apply Universal Recursion**: Follow systematic iteration methodology from [Universal Recursion Workflow](../modules/wfl-recurse-improvement.md) to achieve continuous improvement and complete template application success.

## 9. Manage System-Wide Impact

**Apply Universal Ripple Effect**: Follow systematic impact management from [Universal Ripple Effect Workflow](../modules/wfl-manage-effects.md) to coordinate cross-system changes and template application dependencies.

## 10. Connect Related Workflows

Present these workflow connections:
- **Prerequisite**: [wfl-organize-structure.md](wfl-organize-structure.md) - Execute before this workflow to establish proper directory organization
- **Parallel**: [wfl-maintain-system.md](wfl-maintain-system.md) - Execute simultaneously with this workflow to maintain system configuration
- **Follow-up**: [validate-workflow-integrity.md](validate-workflow-integrity.md) - Execute after this workflow to verify complete system integrity
- **Alternative**: [create-workflow-standards.md](create-workflow-standards.md) - Execute instead of this workflow for comprehensive workflow standardization approach

