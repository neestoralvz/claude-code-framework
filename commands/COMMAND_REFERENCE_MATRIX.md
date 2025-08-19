---
title: "Command Reference Matrix"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["index.md", "workflows/index.md", "AGENT_WORKFLOW_MAPPING.md"]
prerequisites: ["Command architecture understanding", "Workflow methodology knowledge"]
audience: "System operators, workflow coordinators, command architects"
purpose: "Comprehensive command selection and execution reference matrix"
keywords: ["commands", "reference", "matrix", "selection", "execution"]
last_review: "2025-08-19"
architecture_type: "command-reference"
execution_mode: "selection-guidance"
validation_level: "comprehensive"
---

[Previous: Agent Workflow Mapping](AGENT_WORKFLOW_MAPPING.md) | [Return to Commands Index](index.md) | [Next: Core Workflow Definition](workflows/CoreWorkflow.md)

# COMMAND REFERENCE MATRIX

## Purpose

⏺ **Selection Guide**: Comprehensive command selection matrix providing intelligent guidance for optimal command selection based on task characteristics, complexity, context, and desired outcomes.

## Command Selection Decision Tree

### Primary Command Categories

#### 1. Workflow Orchestration Commands

##### Core 9-Phase Workflow
```yaml
CoreWorkflow:
  file: "workflows/CoreWorkflow.md"
  purpose: "Standard systematic task execution through proven 9-phase methodology with research integration"
  use_cases:
    - "standard_development_tasks"
    - "systematic_implementation_projects"
    - "quality_focused_delivery"
    - "structured_problem_solving"
    - "research_driven_development"
  complexity: "moderate_to_high"
  duration: "5-35_minutes"
  agents: "phase_specific_agent_deployment_with_research"
  validation: "comprehensive_9_phase_validation_with_current_standards"
```

##### Specialized Workflows
```yaml
DebuggingWorkflow:
  file: "workflows/DebuggingWorkflow.md"
  purpose: "Comprehensive problem diagnosis and resolution"
  use_cases:
    - "system_troubleshooting"
    - "error_resolution"
    - "performance_issues"
    - "diagnostic_analysis"
  complexity: "moderate_to_high"
  duration: "10-60_minutes"
  agents: "diagnostic_and_analysis_specialists"
  validation: "problem_resolution_verification"

OptimizationWorkflow:
  file: "workflows/OptimizationWorkflow.md"
  purpose: "Iterative improvement and recursive enhancement"
  use_cases:
    - "performance_optimization"
    - "system_improvement"
    - "efficiency_enhancement"
    - "recursive_refinement"
  complexity: "moderate_to_high"
  duration: "15-45_minutes"
  agents: "optimization_and_performance_specialists"
  validation: "improvement_measurement_and_verification"

QualityWorkflow:
  file: "workflows/QualityWorkflow.md"
  purpose: "Comprehensive quality assurance and validation"
  use_cases:
    - "quality_focused_delivery"
    - "compliance_verification"
    - "standards_validation"
    - "certification_requirements"
  complexity: "moderate_to_high"
  duration: "15-45_minutes"
  agents: "quality_and_validation_specialists"
  validation: "multi_gate_quality_validation"
```

#### 2. Analysis and Audit Commands

##### System Analysis
```yaml
system-audit:
  file: "system-audit.md"
  purpose: "Comprehensive system analysis with auto-ticket generation"
  use_cases:
    - "system_health_assessment"
    - "violation_detection"
    - "improvement_identification"
    - "automated_ticket_generation"
  complexity: "high"
  duration: "10-30_minutes"
  agents: "system_auditor_exploration_analyst"
  validation: "comprehensive_analysis_validation"

system-evolve:
  file: "system-evolve.md"
  purpose: "Evolutionary coherence and system-wide alignment"
  use_cases:
    - "system_inconsistency_resolution"
    - "component_alignment"
    - "evolutionary_improvement"
    - "coherence_maintenance"
  complexity: "high"
  duration: "15-45_minutes"
  agents: "system_evolution_specialists"
  validation: "coherence_verification"
```

##### Specialized Analysis
```yaml
analyze-dependencies:
  file: "analysis/analyze-dependencies.md"
  purpose: "Intelligent dependency analysis and planning"
  use_cases:
    - "dependency_mapping"
    - "conflict_detection"
    - "parallel_execution_planning"
    - "optimization_planning"
  complexity: "moderate"
  duration: "5-15_minutes"
  agents: "dependency_analysis_specialist"
  validation: "dependency_accuracy_verification"

modularize:
  file: "modularize.md"
  purpose: "Component extraction and modularization"
  use_cases:
    - "code_modularization"
    - "component_extraction"
    - "reusability_improvement"
    - "architecture_optimization"
  complexity: "moderate_to_high"
  duration: "10-30_minutes"
  agents: "component_architecture_specialist"
  validation: "modularization_quality_verification"
```

#### 3. Execution and Management Commands

##### Task Execution
```yaml
execute-ticket:
  file: "execution/execute-ticket.md"
  purpose: "Specific ticket execution with 100% completion validation"
  use_cases:
    - "individual_ticket_completion"
    - "specific_task_execution"
    - "validated_delivery"
    - "registry_updates"
  complexity: "variable"
  duration: "variable_based_on_ticket"
  agents: "ticket_executor_agent_plus_specialists"
  validation: "100_percent_completion_validation"

execute-parallel-plan:
  file: "execution/execute-parallel-plan.md"
  purpose: "Coordinated parallel ticket execution"
  use_cases:
    - "multiple_ticket_coordination"
    - "parallel_execution"
    - "dependency_management"
    - "conflict_resolution"
  complexity: "high"
  duration: "20-60_minutes"
  agents: "coordination_specialists_multiple_executors"
  validation: "parallel_execution_validation"
```

##### Management Operations
```yaml
create-ticket:
  file: "management/create-ticket.md"
  purpose: "Systematic ticket generation and tracking"
  use_cases:
    - "task_tracking_creation"
    - "requirement_capture"
    - "issue_documentation"
    - "workflow_integration"
  complexity: "low_to_moderate"
  duration: "2-10_minutes"
  agents: "ticket_automation_orchestrator"
  validation: "ticket_quality_validation"

review-tickets:
  file: "management/review-tickets.md"
  purpose: "Priority-based ticket execution and planning"
  use_cases:
    - "ticket_prioritization"
    - "execution_planning"
    - "resource_allocation"
    - "systematic_execution"
  complexity: "moderate"
  duration: "10-30_minutes"
  agents: "project_optimizer_business_analyst"
  validation: "prioritization_accuracy_validation"
```

#### 4. Orchestration and Coordination Commands

##### Multi-Analysis Orchestration
```yaml
multi-analysis-execution:
  file: "orchestration/multi-analysis-execution.md"
  purpose: "Comprehensive multi-perspective analysis with JSON synthesis"
  use_cases:
    - "complex_analysis_requirements"
    - "multi_perspective_evaluation"
    - "comprehensive_reporting"
    - "decision_support"
  complexity: "high"
  duration: "20-60_minutes"
  agents: "multiple_analysis_specialists"
  validation: "comprehensive_analysis_validation"

parallel-intent-analysis:
  file: "orchestration/parallel-intent-analysis.md"
  purpose: "Multi-perspective request analysis with parallel deployment"
  use_cases:
    - "complex_request_analysis"
    - "intent_disambiguation"
    - "comprehensive_understanding"
    - "multi_agent_coordination"
  complexity: "moderate_to_high"
  duration: "10-30_minutes"
  agents: "multiple_analysis_agents"
  validation: "intent_analysis_validation"
```

##### Enforcement and Boundaries
```yaml
enforce-agent-boundaries:
  file: "enforcement/enforce-agent-boundaries.md"
  purpose: "Agent boundary enforcement and validation"
  use_cases:
    - "agent_compliance_verification"
    - "boundary_violation_detection"
    - "system_integrity_maintenance"
    - "governance_enforcement"
  complexity: "moderate"
  duration: "5-20_minutes"
  agents: "enforcement_monitor_validation_engineer"
  validation: "boundary_compliance_verification"

enforcement-gap-analysis:
  file: "enforcement-gap-analysis.md"
  purpose: "Enforcement system gap identification and resolution"
  use_cases:
    - "compliance_gap_detection"
    - "enforcement_improvement"
    - "system_hardening"
    - "governance_optimization"
  complexity: "moderate_to_high"
  duration: "15-30_minutes"
  agents: "compliance_auditor_system_auditor"
  validation: "gap_analysis_verification"
```

## Command Selection Matrix

### By Task Complexity

#### Simple Tasks (1-10 minutes)
```yaml
simple_task_commands:
  single_file_operations:
    - create-ticket: "individual_task_documentation"
    - analyze-dependencies: "simple_dependency_mapping"
  
  basic_analysis:
    - audit-commands: "command_structure_analysis"
    - monitor-execution: "real_time_monitoring"
  
  validation_operations:
    - enforce-agent-boundaries: "boundary_compliance_check"
```

#### Moderate Tasks (10-30 minutes)
```yaml
moderate_task_commands:
  system_operations:
    - system-audit: "comprehensive_system_analysis"
    - modularize: "component_extraction_and_optimization"
    - review-tickets: "priority_based_ticket_execution"
  
  coordination_tasks:
    - parallel-intent-analysis: "multi_perspective_request_analysis"
    - execute-ticket: "specific_ticket_completion"
  
  specialized_analysis:
    - enforcement-gap-analysis: "compliance_gap_identification"
```

#### Complex Tasks (30+ minutes)
```yaml
complex_task_commands:
  comprehensive_workflows:
    - CoreWorkflow: "complete_8_phase_execution"
    - QualityWorkflow: "comprehensive_quality_assurance"
    - OptimizationWorkflow: "iterative_system_improvement"
  
  multi_system_operations:
    - OrchestrationWorkflow: "multi_system_coordination"
    - ProjectDeliveryWorkflow: "end_to_end_project_delivery"
    - multi-analysis-execution: "comprehensive_multi_perspective_analysis"
  
  system_wide_operations:
    - system-evolve: "evolutionary_system_alignment"
    - execute-parallel-plan: "coordinated_parallel_execution"
```

### By Use Case Category

#### Development Tasks
```yaml
development_commands:
  code_quality:
    - CoreWorkflow: "systematic_development_execution"
    - QualityWorkflow: "quality_focused_development"
    - modularize: "code_structure_optimization"
  
  debugging_optimization:
    - DebuggingWorkflow: "systematic_problem_resolution"
    - OptimizationWorkflow: "performance_improvement"
    - system-audit: "development_environment_analysis"
```

#### Operations and Maintenance
```yaml
operations_commands:
  system_maintenance:
    - SystemMaintenanceWorkflow: "automated_system_maintenance"
    - system-audit: "system_health_assessment"
    - monitor-execution: "operational_monitoring"
  
  compliance_governance:
    - enforce-agent-boundaries: "compliance_enforcement"
    - enforcement-gap-analysis: "governance_gap_analysis"
    - QualityWorkflow: "compliance_validation"
```

#### Project Management
```yaml
project_management_commands:
  task_coordination:
    - create-ticket: "task_documentation_and_tracking"
    - review-tickets: "priority_based_execution"
    - execute-parallel-plan: "coordinated_task_execution"
  
  project_delivery:
    - ProjectDeliveryWorkflow: "complete_project_lifecycle"
    - CoreWorkflow: "systematic_project_execution"
    - multi-analysis-execution: "comprehensive_project_analysis"
```

#### Analysis and Research
```yaml
analysis_commands:
  system_analysis:
    - system-audit: "comprehensive_system_examination"
    - system-evolve: "evolutionary_analysis"
    - analyze-dependencies: "dependency_analysis"
  
  multi_perspective_analysis:
    - multi-analysis-execution: "comprehensive_multi_perspective_evaluation"
    - parallel-intent-analysis: "multi_agent_request_analysis"
    - UserRequestWorkflow: "intelligent_request_processing"
```

## Command Combination Patterns

### Sequential Command Execution

#### Analysis → Implementation Pattern
```yaml
analysis_implementation_sequence:
  pattern: "system-audit → review-tickets → execute-ticket → QualityWorkflow"
  purpose: "comprehensive_analysis_followed_by_quality_implementation"
  use_cases:
    - "system_improvement_projects"
    - "quality_focused_development"
    - "systematic_problem_resolution"
  duration: "30-90_minutes"
  complexity: "high"
```

#### Planning → Execution Pattern
```yaml
planning_execution_sequence:
  pattern: "analyze-dependencies → create-ticket → execute-parallel-plan → OptimizationWorkflow"
  purpose: "systematic_planning_followed_by_optimized_execution"
  use_cases:
    - "complex_project_delivery"
    - "coordinated_development_efforts"
    - "resource_optimized_execution"
  duration: "45-120_minutes"
  complexity: "high"
```

### Parallel Command Execution

#### Multi-Perspective Analysis Pattern
```yaml
parallel_analysis_pattern:
  pattern: "parallel(system-audit, multi-analysis-execution, analyze-dependencies)"
  purpose: "comprehensive_system_understanding_through_parallel_analysis"
  use_cases:
    - "complex_system_assessment"
    - "comprehensive_evaluation"
    - "multi_dimensional_analysis"
  duration: "20-45_minutes"
  complexity: "high"
```

#### Quality Assurance Pattern
```yaml
parallel_quality_pattern:
  pattern: "parallel(QualityWorkflow, enforce-agent-boundaries, enforcement-gap-analysis)"
  purpose: "comprehensive_quality_and_compliance_validation"
  use_cases:
    - "quality_certification"
    - "compliance_verification"
    - "system_validation"
  duration: "25-60_minutes"
  complexity: "moderate_to_high"
```

### Adaptive Command Selection

#### Context-Based Selection
```yaml
adaptive_selection_patterns:
  user_request_processing:
    primary: "UserRequestWorkflow"
    adaptive_selection: "intelligent_workflow_routing_based_on_request_analysis"
    fallback: "CoreWorkflow"
  
  system_maintenance:
    primary: "SystemMaintenanceWorkflow"
    adaptive_triggers: "automated_maintenance_based_on_system_health"
    escalation: "DebuggingWorkflow_for_detected_issues"
  
  project_delivery:
    primary: "ProjectDeliveryWorkflow"
    adaptive_coordination: "dynamic_workflow_orchestration_based_on_project_complexity"
    optimization: "OptimizationWorkflow_for_performance_requirements"
```

## Command Performance Characteristics

### Execution Time Patterns

#### Fast Execution Commands (1-5 minutes)
```yaml
fast_commands:
  documentation_operations:
    - create-ticket: "1-3_minutes"
    - monitor-execution: "1-2_minutes"
  
  simple_validation:
    - enforce-agent-boundaries: "2-5_minutes"
    - analyze-dependencies: "2-5_minutes"
```

#### Standard Execution Commands (5-20 minutes)
```yaml
standard_commands:
  analysis_operations:
    - system-audit: "10-20_minutes"
    - modularize: "8-15_minutes"
    - review-tickets: "5-15_minutes"
  
  coordination_operations:
    - execute-ticket: "5-20_minutes_variable"
    - parallel-intent-analysis: "10-20_minutes"
```

#### Extended Execution Commands (20+ minutes)
```yaml
extended_commands:
  comprehensive_workflows:
    - CoreWorkflow: "20-45_minutes"
    - QualityWorkflow: "25-60_minutes"
    - OptimizationWorkflow: "20-90_minutes"
  
  complex_coordination:
    - OrchestrationWorkflow: "30-120_minutes"
    - ProjectDeliveryWorkflow: "45-180_minutes"
    - execute-parallel-plan: "20-60_minutes"
```

### Resource Utilization Patterns

#### Low Resource Commands
```yaml
low_resource_commands:
  characteristics:
    - "minimal_memory_usage"
    - "single_agent_deployment"
    - "simple_file_operations"
  commands:
    - create-ticket
    - monitor-execution
    - enforce-agent-boundaries
```

#### Moderate Resource Commands
```yaml
moderate_resource_commands:
  characteristics:
    - "moderate_memory_usage"
    - "multiple_agent_coordination"
    - "system_analysis_operations"
  commands:
    - system-audit
    - modularize
    - analyze-dependencies
    - execute-ticket
```

#### High Resource Commands
```yaml
high_resource_commands:
  characteristics:
    - "significant_memory_usage"
    - "multi_agent_orchestration"
    - "comprehensive_system_operations"
  commands:
    - CoreWorkflow
    - QualityWorkflow
    - OrchestrationWorkflow
    - multi-analysis-execution
    - execute-parallel-plan
```

## Command Quality Gates

### Validation Requirements

#### Basic Validation Commands
```yaml
basic_validation:
  requirements:
    - "output_format_validation"
    - "completion_verification"
    - "basic_error_checking"
  commands:
    - create-ticket
    - monitor-execution
    - analyze-dependencies
```

#### Comprehensive Validation Commands
```yaml
comprehensive_validation:
  requirements:
    - "multi_gate_quality_validation"
    - "stakeholder_approval"
    - "compliance_verification"
    - "integration_testing"
  commands:
    - CoreWorkflow
    - QualityWorkflow
    - system-audit
    - execute-parallel-plan
```

#### Enterprise Validation Commands
```yaml
enterprise_validation:
  requirements:
    - "complete_audit_trail"
    - "regulatory_compliance"
    - "security_validation"
    - "performance_certification"
  commands:
    - ProjectDeliveryWorkflow
    - OrchestrationWorkflow
    - SystemMaintenanceWorkflow
    - multi-analysis-execution
```

## Usage Recommendations

### Command Selection Decision Framework

#### Step 1: Task Characterization
```yaml
task_characterization:
  complexity_assessment:
    - simple: "single_file_or_straightforward_operation"
    - moderate: "multi_file_or_coordination_required"
    - complex: "system_wide_or_multi_agent_coordination"
  
  domain_identification:
    - development: "code_quality_architecture_implementation"
    - operations: "system_maintenance_monitoring_compliance"
    - analysis: "research_evaluation_assessment"
    - coordination: "project_management_resource_allocation"
```

#### Step 2: Context Evaluation
```yaml
context_evaluation:
  timeline_constraints:
    - urgent: "fast_execution_commands_with_basic_validation"
    - standard: "standard_execution_commands_with_comprehensive_validation"
    - flexible: "extended_execution_commands_with_enterprise_validation"
  
  quality_requirements:
    - basic: "output_focused_commands_with_minimal_validation"
    - standard: "quality_focused_commands_with_multi_gate_validation"
    - enterprise: "comprehensive_commands_with_audit_trail"
```

#### Step 3: Command Selection
```yaml
command_selection:
  primary_selection:
    - "match_command_capabilities_to_task_requirements"
    - "consider_complexity_and_resource_constraints"
    - "evaluate_validation_requirements"
  
  secondary_consideration:
    - "assess_agent_availability_and_capabilities"
    - "consider_integration_with_existing_workflows"
    - "evaluate_performance_and_efficiency_requirements"
```

### Best Practices

#### Command Execution Best Practices
```yaml
execution_best_practices:
  preparation:
    - "validate_prerequisites_before_command_execution"
    - "ensure_agent_availability_and_readiness"
    - "verify_system_state_and_resource_availability"
  
  execution:
    - "monitor_command_progress_and_performance"
    - "handle_errors_and_exceptions_gracefully"
    - "maintain_clear_audit_trail_and_documentation"
  
  completion:
    - "verify_command_completion_and_output_quality"
    - "update_relevant_registries_and_documentation"
    - "capture_lessons_learned_and_improvement_opportunities"
```

#### Quality Assurance Best Practices
```yaml
quality_best_practices:
  validation_integration:
    - "integrate_appropriate_validation_gates_for_command_type"
    - "ensure_comprehensive_quality_checking_throughout_execution"
    - "implement_stakeholder_approval_processes_where_required"
  
  continuous_improvement:
    - "monitor_command_performance_and_effectiveness"
    - "collect_feedback_and_lessons_learned"
    - "optimize_command_usage_patterns_based_on_experience"
```

## Cross-References

### Framework Integration
- [Commands Index](index.md) - Complete command directory
- [Workflows Directory](workflows/index.md) - Consolidated orchestration workflows
- [Agent Workflow Mapping](AGENT_WORKFLOW_MAPPING.md) - Agent deployment guidance
- [Atomic Operations](atoms/index.md) - Foundational building blocks

### Methodology Integration
- [Workflow Methodology](../docs/principles/workflow.md) - 8-phase methodology principles
- [Command Workflow Principles](../docs/principles/command-workflow-principles.md) - Command execution principles
- [Task Orchestration](../docs/principles/task-orchestration.md) - Orchestration principles
- [Quality Framework](../docs/principles/validation.md) - Quality assurance principles

### Architecture Integration
- [System Architecture](../docs/architecture/system-architecture-overview.md) - Framework architecture
- [Command Architecture](../docs/architecture/command-consolidation-architecture.md) - Command design patterns
- [Agent Orchestration](../docs/architecture/agent-orchestration-framework.md) - Agent coordination patterns

[⬆ Return to top](#command-reference-matrix)