---
title: "WorkflowCommand - Workflow-Specific Command Base Class"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["AbstractCommand.md"]
prerequisites: ["AbstractCommand understanding", "Workflow domain knowledge"]
audience: "Workflow specialists, command developers, system architects"
purpose: "Specialized base class for workflow commands with phase execution and systematic methodology patterns"
keywords: ["workflow", "command", "inheritance", "phases", "methodology"]
last_review: "2025-08-19"
architecture_type: "specialized-base-class"
execution_mode: "framework"
validation_level: "comprehensive"
---

[Previous: OrchestrationCommand](OrchestrationCommand.md) | [Return to Hierarchy Overview](README.md) | [Next: Interfaces and Contracts](interfaces/)

# WORKFLOWCOMMAND - WORKFLOW-SPECIFIC COMMAND BASE CLASS

⏺ **Workflow Specialization**: WorkflowCommand extends AbstractCommand with workflow-specific patterns, phase execution management, and systematic methodology implementation, providing specialized functionality for structured workflow processes while leveraging inheritance benefits.

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

## Workflow Command Specialization

⏺ **Specialized Workflow Base**: WorkflowCommand provides workflow-specific implementations while inheriting foundational command functionality from AbstractCommand.

### Workflow Command Structure
```yaml
workflow_command_definition:
  class_name: WorkflowCommand
  extends: AbstractCommand
  responsibility: "Structured workflow execution and phase management"
  
  inherited_capabilities:
    - lifecycle_management
    - error_handling
    - logging_system
    - progress_tracking
    - quality_gates
    - validation_framework
    
  specialized_capabilities:
    - phase_execution_management
    - systematic_methodology_implementation
    - workflow_state_management
    - phase_transition_coordination
    - workflow_progress_tracking
    - adaptive_workflow_execution
    
  workflow_categories:
    - linear_workflow: "Sequential phase execution with dependencies"
    - parallel_workflow: "Concurrent phase execution with synchronization"
    - conditional_workflow: "Context-aware phase selection and execution"
    - iterative_workflow: "Repeating phase cycles with refinement"
    - adaptive_workflow: "Dynamic workflow adjustment based on outcomes"
    - recursive_workflow: "Self-referencing workflow patterns with recursion"
```

### Workflow-Specific Abstract Interface
```yaml
workflow_interface:
  required_implementations:
    define_workflow_phases():
      responsibility: "Define workflow phases and their dependencies"
      returns: "workflow_phases: WorkflowPhases"
      
    execute_workflow_phase():
      responsibility: "Execute individual workflow phase with validation"
      parameters: "phase_context: PhaseContext"
      returns: "phase_results: PhaseResults"
      
    manage_phase_transitions():
      responsibility: "Coordinate transitions between workflow phases"
      parameters: "transition_context: TransitionContext"
      returns: "transition_results: TransitionResults"
      
    validate_workflow_completion():
      responsibility: "Validate overall workflow completion and success"
      parameters: "workflow_context: WorkflowContext"
      returns: "completion_validation: CompletionValidation"
  
  optional_overrides:
    customize_phase_execution():
      purpose: "Custom phase execution logic and patterns"
      default_behavior: "standard_phase_execution"
      
    customize_progress_tracking():
      purpose: "Custom workflow progress tracking and reporting"
      default_behavior: "standard_progress_tracking"
      
    customize_error_recovery():
      purpose: "Custom workflow error recovery and rollback"
      default_behavior: "standard_error_recovery"
```

## Workflow-Specific Lifecycle

⏺ **Workflow Execution**: WorkflowCommand implements a specialized lifecycle optimized for structured workflow execution while maintaining base command lifecycle compatibility.

### Enhanced Workflow Lifecycle
```yaml
workflow_lifecycle:
  phase_1_workflow_initialization:
    purpose: "Initialize workflow context and prepare phase execution"
    workflow_activities:
      - workflow_definition_loading
      - phase_dependency_analysis
      - execution_context_preparation
      - workflow_state_initialization
    inherited_behaviors:
      - initialization
      - context_creation
      - dependency_injection
    
  phase_2_workflow_validation:
    purpose: "Validate workflow requirements and phase readiness"
    workflow_activities:
      - workflow_definition_validation
      - phase_dependency_verification
      - resource_availability_confirmation
      - execution_capability_assessment
    inherited_behaviors:
      - parameter_validation
      - capability_verification
      - security_clearance
    
  phase_3_phase_preparation:
    purpose: "Prepare individual phases for execution"
    workflow_activities:
      - phase_context_initialization
      - phase_resource_allocation
      - phase_dependency_resolution
      - phase_monitoring_setup
    inherited_behaviors:
      - workspace_setup
      - dependency_resolution
      - monitoring_initialization
    
  phase_4_workflow_execution:
    purpose: "Execute workflow phases with coordination and monitoring"
    workflow_activities:
      - phase_by_phase_execution
      - phase_transition_management
      - workflow_progress_monitoring
      - phase_outcome_validation
    inherited_behaviors:
      - progress_tracking
      - error_monitoring
      - performance_measurement
    
  phase_5_workflow_completion:
    purpose: "Complete workflow and validate overall success"
    workflow_activities:
      - workflow_outcome_aggregation
      - completion_criteria_validation
      - workflow_result_documentation
      - success_criteria_verification
    inherited_behaviors:
      - result_processing
      - output_generation
      - documentation_updates
    
  phase_6_workflow_cleanup:
    purpose: "Clean up workflow resources and finalize state"
    workflow_activities:
      - workflow_state_finalization
      - phase_resource_cleanup
      - workflow_metric_collection
      - workflow_artifact_archival
    inherited_behaviors:
      - resource_deallocation
      - state_persistence
```

## Phase Execution Framework

⏺ **Phase Management**: WorkflowCommand provides comprehensive phase execution capabilities for structured workflow implementation.

### Standard Workflow Phases
```yaml
standard_workflow_phases:
  phase_1_clarify:
    purpose: "Clarify requirements and establish clear objectives"
    activities:
      - requirement_analysis: "Analyze and document requirements"
      - scope_definition: "Define clear scope boundaries"
      - success_criteria: "Establish measurable success criteria"
      - constraint_identification: "Identify constraints and limitations"
    validation_criteria:
      - requirement_completeness: "All requirements clearly defined"
      - scope_clarity: "Scope boundaries well-defined"
      - criteria_measurability: "Success criteria are measurable"
    
  phase_2_explore:
    purpose: "Explore context and gather necessary information"
    activities:
      - context_analysis: "Analyze relevant context and environment"
      - information_gathering: "Collect necessary information and data"
      - stakeholder_identification: "Identify key stakeholders"
      - constraint_analysis: "Analyze constraints and dependencies"
    validation_criteria:
      - context_understanding: "Context thoroughly understood"
      - information_adequacy: "Sufficient information gathered"
      - stakeholder_coverage: "All relevant stakeholders identified"
    
  phase_3_analyze:
    purpose: "Analyze information and develop solution approaches"
    activities:
      - problem_analysis: "Analyze core problems and challenges"
      - solution_design: "Design potential solution approaches"
      - risk_assessment: "Assess risks and mitigation strategies"
      - feasibility_analysis: "Analyze solution feasibility"
    validation_criteria:
      - problem_understanding: "Problems clearly understood"
      - solution_viability: "Solutions are viable and realistic"
      - risk_awareness: "Risks identified and addressed"
    
  phase_4_present:
    purpose: "Present solutions and facilitate decision making"
    activities:
      - solution_presentation: "Present solution options clearly"
      - decision_facilitation: "Facilitate decision-making process"
      - recommendation_provision: "Provide clear recommendations"
      - stakeholder_alignment: "Ensure stakeholder alignment"
    validation_criteria:
      - presentation_clarity: "Solutions presented clearly"
      - decision_support: "Adequate decision support provided"
      - stakeholder_buy_in: "Stakeholders aligned on approach"
    
  phase_5_plan:
    purpose: "Plan implementation approach and resource allocation"
    activities:
      - implementation_planning: "Create detailed implementation plan"
      - resource_allocation: "Allocate necessary resources"
      - timeline_development: "Develop realistic timeline"
      - risk_mitigation: "Plan risk mitigation strategies"
    validation_criteria:
      - plan_completeness: "Implementation plan is complete"
      - resource_adequacy: "Resources adequately allocated"
      - timeline_realism: "Timeline is realistic and achievable"
    
  phase_6_implement:
    purpose: "Execute implementation plan and deliver solutions"
    activities:
      - solution_implementation: "Implement planned solutions"
      - progress_monitoring: "Monitor implementation progress"
      - quality_assurance: "Ensure quality standards"
      - issue_resolution: "Resolve implementation issues"
    validation_criteria:
      - implementation_quality: "Implementation meets quality standards"
      - progress_tracking: "Progress adequately tracked"
      - issue_resolution: "Issues promptly resolved"
    
  phase_7_ripple:
    purpose: "Manage ripple effects and update related systems"
    activities:
      - impact_analysis: "Analyze implementation impacts"
      - system_updates: "Update related systems and processes"
      - documentation_updates: "Update relevant documentation"
      - stakeholder_notification: "Notify affected stakeholders"
    validation_criteria:
      - impact_management: "Impacts properly managed"
      - system_consistency: "Systems remain consistent"
      - documentation_currency: "Documentation is current"
    
  phase_8_validate:
    purpose: "Validate completion and ensure success criteria met"
    activities:
      - outcome_validation: "Validate implementation outcomes"
      - success_measurement: "Measure against success criteria"
      - quality_verification: "Verify quality standards met"
      - completion_confirmation: "Confirm complete task completion"
    validation_criteria:
      - success_achievement: "Success criteria achieved"
      - quality_compliance: "Quality standards met"
      - completion_verification: "Task completion verified"
```

### Phase Execution Patterns
```yaml
phase_execution_patterns:
  sequential_execution:
    description: "Execute phases in strict sequential order"
    implementation: |
      1. Validate phase dependencies and prerequisites
      2. Execute current phase with full completion
      3. Validate phase completion before transition
      4. Transition to next phase with context handoff
      5. Repeat until workflow completion
    use_cases: ["dependency_heavy_workflows", "linear_processes", "waterfall_methodologies"]
    
  parallel_execution:
    description: "Execute independent phases concurrently"
    implementation: |
      1. Identify parallelizable phase clusters
      2. Execute parallel phases with coordination
      3. Monitor parallel execution progress
      4. Synchronize parallel phase completion
      5. Aggregate parallel phase results
    use_cases: ["independent_activities", "time_optimization", "resource_utilization"]
    
  conditional_execution:
    description: "Execute phases based on runtime conditions"
    implementation: |
      1. Evaluate phase execution conditions
      2. Select appropriate phases for execution
      3. Execute selected phases with validation
      4. Handle condition changes during execution
      5. Adapt workflow based on outcomes
    use_cases: ["adaptive_workflows", "context_dependent_processing", "dynamic_requirements"]
    
  iterative_execution:
    description: "Repeat phase cycles with refinement"
    implementation: |
      1. Execute initial phase cycle
      2. Evaluate cycle outcomes and learning
      3. Refine approach based on feedback
      4. Execute subsequent improved cycles
      5. Converge to optimal solution
    use_cases: ["agile_methodologies", "continuous_improvement", "experimental_approaches"]
```

## Systematic Methodology Implementation

⏺ **Methodology Framework**: WorkflowCommand implements systematic methodologies for consistent and predictable workflow execution.

### Methodology Patterns
```yaml
methodology_patterns:
  waterfall_methodology:
    characteristics:
      - sequential_phases: "Phases executed in predetermined order"
      - phase_gates: "Gates between phases with validation"
      - documentation_heavy: "Comprehensive documentation at each phase"
      - change_control: "Formal change control processes"
    implementation:
      phase_sequence: ["requirements", "design", "implementation", "testing", "deployment", "maintenance"]
      gate_criteria: "formal_phase_completion_criteria"
      change_management: "change_control_board_approval"
    
  agile_methodology:
    characteristics:
      - iterative_cycles: "Short iterative development cycles"
      - adaptive_planning: "Adaptive planning based on feedback"
      - collaboration_focused: "Heavy stakeholder collaboration"
      - responding_to_change: "Quick response to changing requirements"
    implementation:
      cycle_structure: ["sprint_planning", "daily_standups", "development", "review", "retrospective"]
      adaptation_mechanisms: "feedback_based_adjustment"
      collaboration_patterns: "continuous_stakeholder_engagement"
    
  lean_methodology:
    characteristics:
      - waste_elimination: "Focus on eliminating waste and inefficiency"
      - value_optimization: "Maximize value delivery"
      - continuous_improvement: "Ongoing process improvement"
      - flow_optimization: "Optimize workflow flow and throughput"
    implementation:
      value_stream_mapping: "end_to_end_value_flow_analysis"
      waste_identification: "systematic_waste_elimination"
      improvement_cycles: "continuous_kaizen_cycles"
    
  design_thinking_methodology:
    characteristics:
      - human_centered: "Focus on human needs and experiences"
      - empathy_driven: "Deep empathy for user problems"
      - iterative_design: "Iterative design and testing cycles"
      - collaborative_approach: "Cross-functional collaboration"
    implementation:
      phase_structure: ["empathize", "define", "ideate", "prototype", "test"]
      iteration_cycles: "rapid_prototyping_and_testing"
      collaboration_methods: "design_thinking_workshops"
```

### Methodology Adaptation Framework
```yaml
methodology_adaptation:
  context_assessment:
    project_characteristics:
      - complexity_level: "assess_project_complexity_and_uncertainty"
      - team_size: "evaluate_team_size_and_distribution"
      - timeline_constraints: "analyze_timeline_and_deadline_pressures"
      - stakeholder_involvement: "assess_stakeholder_engagement_levels"
      
    organizational_factors:
      - culture_alignment: "assess_organizational_culture_compatibility"
      - process_maturity: "evaluate_process_maturity_levels"
      - change_tolerance: "assess_tolerance_for_change_and_adaptation"
      - resource_availability: "evaluate_resource_constraints_and_availability"
  
  adaptation_strategies:
    methodology_hybridization:
      approach: "combine_elements_from_multiple_methodologies"
      implementation: "selective_practice_adoption_based_on_context"
      validation: "measure_effectiveness_and_adjust_combination"
      
    scaling_strategies:
      approach: "scale_methodology_based_on_project_size_and_complexity"
      implementation: "lightweight_vs_heavyweight_process_selection"
      validation: "monitor_overhead_vs_value_delivered"
      
    continuous_adaptation:
      approach: "continuously_adapt_methodology_based_on_feedback"
      implementation: "retrospectives_and_process_improvement_cycles"
      validation: "measure_process_effectiveness_and_team_satisfaction"
```

## Progress Tracking and Validation

⏺ **Progress Management**: WorkflowCommand provides sophisticated progress tracking and validation capabilities for workflow execution monitoring.

### Progress Tracking Framework
```yaml
progress_tracking_framework:
  tracking_dimensions:
    phase_progress:
      metrics:
        - phase_completion_percentage: "Percentage of current phase completed"
        - phase_milestone_achievement: "Key milestone completion status"
        - phase_quality_metrics: "Quality indicators for current phase"
        - phase_timeline_adherence: "Actual vs planned phase timeline"
      
    workflow_progress:
      metrics:
        - overall_completion_percentage: "Overall workflow progress"
        - completed_phases: "Number of phases successfully completed"
        - remaining_phases: "Number of phases remaining"
        - workflow_velocity: "Rate of workflow progress"
      
    quality_progress:
      metrics:
        - validation_gate_passage: "Success rate at validation gates"
        - quality_criterion_achievement: "Quality criteria met"
        - defect_identification_rate: "Rate of defect detection and resolution"
        - stakeholder_satisfaction: "Stakeholder satisfaction metrics"
      
    resource_progress:
      metrics:
        - resource_utilization_efficiency: "Efficiency of resource usage"
        - budget_vs_actual_spending: "Budget adherence metrics"
        - team_productivity_metrics: "Team performance indicators"
        - timeline_vs_actual_progress: "Schedule adherence metrics"
  
  tracking_methods:
    real_time_tracking:
      approach: "continuous_progress_monitoring_with_live_updates"
      implementation: "automated_progress_capture_with_dashboards"
      reporting: "real_time_progress_dashboards_and_alerts"
      
    milestone_tracking:
      approach: "milestone_based_progress_assessment"
      implementation: "formal_milestone_review_and_validation"
      reporting: "milestone_completion_reports_and_analysis"
      
    retrospective_tracking:
      approach: "periodic_progress_review_and_analysis"
      implementation: "scheduled_retrospective_sessions"
      reporting: "retrospective_insights_and_improvement_plans"
```

### Validation Framework Integration
```yaml
validation_integration:
  phase_validation:
    entry_criteria:
      - prerequisite_completion: "Previous phase successfully completed"
      - resource_availability: "Required resources available for phase"
      - stakeholder_readiness: "Stakeholders ready for phase execution"
      
    execution_validation:
      - progress_checkpoints: "Regular progress validation during phase"
      - quality_checks: "Ongoing quality validation"
      - stakeholder_feedback: "Continuous stakeholder input and validation"
      
    exit_criteria:
      - deliverable_completion: "Phase deliverables completed and validated"
      - quality_standards: "Quality standards met and verified"
      - stakeholder_acceptance: "Stakeholder acceptance of phase outcomes"
  
  workflow_validation:
    overall_coherence:
      - phase_integration: "Phases integrate coherently"
      - workflow_consistency: "Consistent execution across phases"
      - objective_alignment: "Phases align with overall objectives"
      
    success_criteria:
      - objective_achievement: "Primary objectives achieved"
      - quality_compliance: "Quality standards met throughout"
      - stakeholder_satisfaction: "Stakeholders satisfied with outcomes"
```

## Workflow State Management

⏺ **State Coordination**: WorkflowCommand provides comprehensive state management for workflow execution tracking and coordination.

### Workflow State Model
```yaml
workflow_state_model:
  state_hierarchy:
    workflow_states:
      - initialized: "Workflow context and phases prepared"
      - executing: "Workflow phases being executed"
      - suspended: "Workflow execution temporarily paused"
      - completed: "Workflow successfully completed"
      - failed: "Workflow execution failed"
      - cancelled: "Workflow execution cancelled"
      
    phase_states:
      - pending: "Phase waiting to be executed"
      - executing: "Phase currently being executed"
      - completed: "Phase successfully completed"
      - failed: "Phase execution failed"
      - skipped: "Phase skipped based on conditions"
      - rollback: "Phase being rolled back"
  
  state_transitions:
    workflow_transitions:
      initialized_to_executing: "Start workflow execution"
      executing_to_suspended: "Pause workflow execution"
      suspended_to_executing: "Resume workflow execution"
      executing_to_completed: "Complete workflow successfully"
      executing_to_failed: "Workflow execution failed"
      any_to_cancelled: "Cancel workflow execution"
      
    phase_transitions:
      pending_to_executing: "Start phase execution"
      executing_to_completed: "Complete phase successfully"
      executing_to_failed: "Phase execution failed"
      executing_to_skipped: "Skip phase based on conditions"
      failed_to_rollback: "Rollback failed phase"
      rollback_to_pending: "Return phase to pending after rollback"
  
  state_persistence:
    checkpoint_strategy:
      - phase_completion_checkpoints: "Save state after each phase"
      - milestone_checkpoints: "Save state at key milestones"
      - error_checkpoints: "Save state before risky operations"
      
    recovery_strategy:
      - state_restoration: "Restore workflow from last checkpoint"
      - partial_replay: "Replay workflow from specific checkpoint"
      - manual_recovery: "Manual intervention for complex recovery scenarios"
```

### Context Management
```yaml
context_management:
  workflow_context:
    execution_context:
      - workflow_definition: "Complete workflow specification"
      - execution_parameters: "Runtime execution parameters"
      - resource_allocation: "Allocated resources and capabilities"
      - stakeholder_information: "Stakeholder roles and contacts"
      
    progress_context:
      - current_phase: "Currently executing phase"
      - completed_phases: "List of completed phases with outcomes"
      - phase_dependencies: "Phase dependency relationships"
      - progress_metrics: "Current progress measurements"
      
    quality_context:
      - validation_results: "Results from validation gates"
      - quality_metrics: "Quality measurements and trends"
      - stakeholder_feedback: "Feedback from stakeholders"
      - improvement_actions: "Identified improvement actions"
  
  context_sharing:
    inter_phase_communication:
      - phase_handoff_protocols: "Standard phase transition procedures"
      - context_transfer_mechanisms: "Context information transfer methods"
      - dependency_resolution: "Phase dependency resolution mechanisms"
      
    stakeholder_communication:
      - status_reporting: "Regular status updates to stakeholders"
      - feedback_collection: "Stakeholder feedback collection mechanisms"
      - decision_points: "Key decision points requiring stakeholder input"
```

## Adaptive Workflow Patterns

⏺ **Adaptive Execution**: WorkflowCommand provides adaptive workflow patterns for dynamic adjustment based on execution outcomes and changing conditions.

### Adaptation Mechanisms
```yaml
adaptation_mechanisms:
  condition_based_adaptation:
    trigger_conditions:
      - performance_thresholds: "Performance below acceptable levels"
      - quality_issues: "Quality metrics indicate problems"
      - resource_constraints: "Resource availability changes"
      - timeline_pressures: "Schedule pressures require adjustment"
      
    adaptation_strategies:
      - phase_reordering: "Adjust phase execution order"
      - resource_reallocation: "Reallocate resources to critical phases"
      - scope_adjustment: "Adjust phase scope or requirements"
      - methodology_switching: "Switch to different methodology"
  
  feedback_based_adaptation:
    feedback_sources:
      - stakeholder_feedback: "Direct feedback from stakeholders"
      - quality_metrics: "Quantitative quality measurements"
      - performance_indicators: "Performance and productivity metrics"
      - retrospective_insights: "Insights from retrospective sessions"
      
    adaptation_responses:
      - process_refinement: "Refine workflow processes based on feedback"
      - tool_adjustment: "Adjust tools and techniques used"
      - communication_enhancement: "Improve communication patterns"
      - skill_development: "Address skill gaps identified"
  
  predictive_adaptation:
    prediction_models:
      - risk_prediction: "Predict potential risks and issues"
      - performance_forecasting: "Forecast performance trends"
      - resource_demand_prediction: "Predict future resource needs"
      - timeline_projection: "Project completion timelines"
      
    proactive_adjustments:
      - preventive_actions: "Take action to prevent predicted issues"
      - capacity_planning: "Adjust capacity based on predictions"
      - risk_mitigation: "Implement risk mitigation strategies"
      - timeline_buffer: "Add timeline buffers for predicted delays"
```

### Learning and Improvement
```yaml
learning_framework:
  knowledge_capture:
    execution_patterns:
      - successful_patterns: "Document patterns that lead to success"
      - failure_patterns: "Analyze patterns that lead to failure"
      - efficiency_patterns: "Identify patterns that improve efficiency"
      - quality_patterns: "Document patterns that ensure quality"
      
    organizational_learning:
      - best_practices: "Capture and share best practices"
      - lessons_learned: "Document lessons learned from each workflow"
      - process_improvements: "Identify and implement process improvements"
      - knowledge_sharing: "Share knowledge across teams and projects"
  
  continuous_improvement:
    improvement_cycles:
      - plan_do_check_act: "PDCA cycles for continuous improvement"
      - kaizen_events: "Focused improvement events and workshops"
      - retrospective_driven: "Improvement driven by retrospective insights"
      - metrics_driven: "Data-driven improvement based on metrics"
      
    innovation_integration:
      - experimental_approaches: "Test new approaches and methodologies"
      - technology_adoption: "Integrate new tools and technologies"
      - methodology_evolution: "Evolve methodologies based on learning"
      - practice_innovation: "Innovate practices and techniques"
```

## Cross-References

### Concrete Workflow Commands
- [ClarifyCommand.md](../examples/ClarifyCommand.md) - Phase 1 clarification implementation
- [ExploreCommand.md](../examples/ExploreCommand.md) - Phase 2 exploration implementation
- [AnalyzeCommand.md](../examples/AnalyzeCommand.md) - Phase 3 analysis implementation
- [ValidateCommand.md](../examples/ValidateCommand.md) - Phase 8 validation implementation
- [DebugCommand.md](../examples/DebugCommand.md) - Phase 9 debugging implementation
- [RecurseCommand.md](../examples/RecurseCommand.md) - Phase 10 recursion implementation

### Framework Integration
- [AbstractCommand.md](AbstractCommand.md) - Base command functionality
- [Workflow Molecules](../molecules/WorkflowMolecules.md) - Workflow pattern implementations
- [Workflow Assemblies](../assemblies/WorkflowAssembly.md) - Complete workflow orchestration

### Supporting Components
- [Validation Framework](../shared/ValidationEngine.md) - Workflow validation patterns
- [Workflow Phases](../shared/WorkflowPhases.md) - Phase implementation library
- [Progress Tracker](../shared/ProgressTracker.md) - Workflow progress monitoring
- [State Manager](../shared/StateManager.md) - Workflow state management

[⬆ Return to top](#workflowcommand---workflow-specific-command-base-class)