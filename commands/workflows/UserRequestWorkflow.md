---
title: "User Request Workflow - Primary User Request Processing"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["CoreWorkflow.md", "QualityWorkflow.md", "DebuggingWorkflow.md"]
prerequisites: ["Core workflow understanding", "User interaction patterns"]
audience: "User interaction specialists, request processors, primary workflow coordinators"
purpose: "Primary workflow for processing user requests with intelligent workflow selection and execution"
keywords: ["user-request", "primary-workflow", "intelligent-selection", "user-interaction"]
last_review: "2025-08-19"
architecture_type: "master-workflow"
execution_mode: "user-centric"
validation_level: "comprehensive"
---

[Previous: Orchestration Workflow](OrchestrationWorkflow.md) | [Return to Workflows Index](index.md) | [Next: System Maintenance Workflow](SystemMaintenanceWorkflow.md)

# USER REQUEST WORKFLOW - PRIMARY USER REQUEST PROCESSING

## Purpose

⏺ **Primary Interface**: Master workflow serving as the primary interface for user request processing with intelligent workflow selection, adaptive execution, and comprehensive user experience optimization.

## Master Workflow Architecture

### Request Processing Composition
```yaml
workflow_definition:
  name: UserRequestWorkflow
  responsibility: "Primary user request processing with intelligent workflow orchestration"
  workflow_integration:
    - CoreWorkflow: "standard_8_phase_execution"
    - QualityWorkflow: "quality_assurance_and_validation"
    - DebuggingWorkflow: "issue_resolution_and_troubleshooting"
    - OptimizationWorkflow: "performance_and_efficiency_optimization"
    - OrchestrationWorkflow: "multi_system_coordination_when_needed"
  atomic_foundation:
    - all_workflow_atoms: "comprehensive_atomic_operation_support"
  molecular_integration:
    - all_workflow_molecules: "complete_molecular_pattern_support"
  assembly_coordination:
    - all_workflow_assemblies: "full_assembly_workflow_support"
  input: "user_request: object"
  output: "user_response: object | error"
  side_effects: "comprehensive_user_request_fulfillment"
```

## User Request Workflow Implementation

```yaml
user_request_workflow_execution: |
  function UserRequestWorkflow(user_request) {
    // Initialize user request processing state
    request_state = ManageWorkflowStateAtom(
      "initialize",
      null,
      {
        request_id: generate_request_id(),
        user_request: user_request,
        processing_context: initialize_processing_context(),
        user_preferences: extract_user_preferences(user_request),
        execution_tracking: setup_execution_tracking()
      }
    )
    
    try {
      // PHASE 1: REQUEST ANALYSIS AND CLASSIFICATION
      analysis_result = ExecutePhaseAtom(
        {
          phase_id: "analyze_request",
          phase_name: "Request Analysis and Classification",
          prerequisites: {
            user_input: user_request.content,
            user_context: user_request.context,
            user_preferences: extract_user_preferences(user_request)
          },
          logic: analyze_user_request_logic,
          success_criteria: {
            request_understood: true,
            intent_classified: true,
            complexity_assessed: true,
            workflow_strategy_selected: true
          },
          environment: {
            agents: ["request-analyzer", "intent-classifier"],
            resources: ["nlp-tools", "classification-models"],
            validation: "analysis_validation"
          }
        },
        request_state.processing_context
      )
      
      // PHASE 2: WORKFLOW SELECTION AND CONFIGURATION
      workflow_selection_result = ExecutePhaseAtom(
        {
          phase_id: "select_workflow",
          phase_name: "Intelligent Workflow Selection",
          prerequisites: {
            request_classification: analysis_result.classification,
            complexity_assessment: analysis_result.complexity,
            user_preferences: request_state.user_preferences
          },
          logic: select_optimal_workflow_logic,
          success_criteria: {
            workflow_selected: true,
            configuration_determined: true,
            execution_parameters_set: true,
            quality_requirements_defined: true
          },
          environment: {
            agents: ["workflow-selector", "configuration-optimizer"],
            resources: ["workflow-registry", "optimization-patterns"],
            validation: "selection_validation"
          }
        },
        request_state.processing_context
      )
      
      // PHASE 3: PRIMARY WORKFLOW EXECUTION
      primary_execution_result = execute_selected_workflow(
        workflow_selection_result.selected_workflow,
        {
          user_request: user_request,
          configuration: workflow_selection_result.configuration,
          quality_requirements: workflow_selection_result.quality_requirements,
          execution_context: request_state.processing_context
        }
      )
      
      // PHASE 4: EXECUTION MONITORING AND ADAPTATION
      monitoring_result = ExecutePhaseAtom(
        {
          phase_id: "monitor_execution",
          phase_name: "Execution Monitoring and Adaptive Management",
          prerequisites: {
            primary_execution: primary_execution_result,
            execution_metrics: collect_execution_metrics(request_state),
            user_expectations: analysis_result.expectations
          },
          logic: monitor_and_adapt_execution_logic,
          success_criteria: {
            execution_monitored: true,
            issues_detected_and_resolved: true,
            performance_optimized: true,
            user_satisfaction_maintained: true
          },
          environment: {
            agents: ["execution-monitor", "adaptive-coordinator"],
            resources: ["monitoring-systems", "adaptation-frameworks"],
            validation: "monitoring_validation"
          }
        },
        request_state.processing_context
      )
      
      // PHASE 5: QUALITY VALIDATION AND ASSURANCE
      quality_validation_result = ExecutePhaseAtom(
        {
          phase_id: "validate_quality",
          phase_name: "Comprehensive Quality Validation",
          prerequisites: {
            execution_results: primary_execution_result,
            monitoring_data: monitoring_result.monitoring_data,
            quality_requirements: workflow_selection_result.quality_requirements
          },
          logic: validate_execution_quality_logic,
          success_criteria: {
            quality_validated: true,
            user_requirements_met: true,
            standards_complied: true,
            satisfaction_confirmed: true
          },
          environment: {
            agents: ["quality-validator", "satisfaction-assessor"],
            resources: ["quality-frameworks", "validation-tools"],
            validation: "quality_validation"
          }
        },
        request_state.processing_context
      )
      
      // PHASE 6: RESPONSE GENERATION AND FORMATTING
      response_generation_result = ExecutePhaseAtom(
        {
          phase_id: "generate_response",
          phase_name: "User Response Generation and Formatting",
          prerequisites: {
            validated_results: quality_validation_result.results,
            user_preferences: request_state.user_preferences,
            execution_summary: generate_execution_summary(request_state)
          },
          logic: generate_user_response_logic,
          success_criteria: {
            response_generated: true,
            format_optimized: true,
            user_experience_enhanced: true,
            actionable_content_provided: true
          },
          environment: {
            agents: ["response-generator", "ux-optimizer"],
            resources: ["response-templates", "formatting-tools"],
            validation: "response_validation"
          }
        },
        request_state.processing_context
      )
      
      // PHASE 7: USER FEEDBACK INTEGRATION
      feedback_result = ExecutePhaseAtom(
        {
          phase_id: "integrate_feedback",
          phase_name: "User Feedback Integration and Learning",
          prerequisites: {
            generated_response: response_generation_result.response,
            execution_metrics: collect_final_metrics(request_state),
            user_interaction_data: extract_interaction_data(request_state)
          },
          logic: integrate_user_feedback_logic,
          success_criteria: {
            feedback_collected: true,
            learning_captured: true,
            improvements_identified: true,
            knowledge_base_updated: true
          },
          environment: {
            agents: ["feedback-collector", "learning-integrator"],
            resources: ["feedback-systems", "knowledge-bases"],
            validation: "feedback_validation"
          }
        },
        request_state.processing_context
      )
      
      // User Request Completion Assessment
      completion_assessment = ValidateProgressAtom(
        request_state.processing_context,
        {
          request_fulfillment: assess_request_fulfillment(request_state),
          user_satisfaction: validate_user_satisfaction(response_generation_result),
          quality_achievement: validate_quality_standards(quality_validation_result),
          learning_integration: validate_learning_capture(feedback_result)
        }
      )
      
      return {
        request_status: "completed",
        user_response: response_generation_result.response,
        execution_summary: {
          analysis: analysis_result,
          workflow_selection: workflow_selection_result,
          primary_execution: primary_execution_result,
          monitoring: monitoring_result,
          quality_validation: quality_validation_result,
          response_generation: response_generation_result,
          feedback: feedback_result
        },
        satisfaction_metrics: calculate_satisfaction_metrics(request_state),
        learning_outcomes: feedback_result.learning_outcomes,
        recommendations: generate_user_recommendations(request_state)
      }
      
    } catch (request_error) {
      return HandleWorkflowErrorAtom(
        request_error,
        request_state.processing_context,
        {
          recovery_strategies: ["alternative_workflow", "simplified_execution", "manual_assistance"],
          escalation_procedures: ["user_support_escalation", "expert_consultation"],
          documentation_requirements: ["error_explanation_for_user", "technical_error_documentation"]
        }
      )
    }
  }
```

## Master Workflow Logic Implementation

### Request Analysis Logic
```yaml
analyze_user_request_logic: |
  function analyze_user_request_logic(prerequisites, environment) {
    // Parse and understand user input
    parsed_request = parse_user_input(
      prerequisites.user_input,
      environment.resources.nlp_tools
    )
    
    // Classify user intent
    intent_classification = classify_user_intent(
      parsed_request,
      prerequisites.user_context,
      environment.resources.classification_models
    )
    
    // Assess request complexity
    complexity_assessment = assess_request_complexity(
      intent_classification,
      parsed_request,
      environment.agents.request_analyzer
    )
    
    // Extract user expectations
    user_expectations = extract_user_expectations(
      parsed_request,
      prerequisites.user_preferences,
      environment.agents.intent_classifier
    )
    
    return {
      parsed_input: parsed_request,
      classification: intent_classification,
      complexity: complexity_assessment,
      expectations: user_expectations,
      analysis_summary: generate_analysis_summary(parsed_request, intent_classification, complexity_assessment)
    }
  }
```

### Workflow Selection Logic
```yaml
select_optimal_workflow_logic: |
  function select_optimal_workflow_logic(prerequisites, environment) {
    // Evaluate available workflows
    available_workflows = evaluate_available_workflows(
      prerequisites.request_classification,
      environment.resources.workflow_registry
    )
    
    // Score workflow suitability
    workflow_scores = score_workflow_suitability(
      available_workflows,
      prerequisites.complexity_assessment,
      environment.agents.workflow_selector
    )
    
    // Select optimal workflow
    selected_workflow = select_optimal_workflow(
      workflow_scores,
      prerequisites.user_preferences,
      environment.resources.optimization_patterns
    )
    
    // Configure workflow execution
    workflow_configuration = configure_workflow_execution(
      selected_workflow,
      prerequisites.complexity_assessment,
      environment.agents.configuration_optimizer
    )
    
    return {
      available_options: available_workflows,
      suitability_scores: workflow_scores,
      selected_workflow: selected_workflow,
      configuration: workflow_configuration,
      quality_requirements: derive_quality_requirements(selected_workflow, prerequisites.user_preferences)
    }
  }
```

### Workflow Execution Coordination
```yaml
execute_selected_workflow: |
  function execute_selected_workflow(workflow_type, execution_parameters) {
    switch (workflow_type) {
      case "core_workflow":
        return CoreWorkflow({
          request: execution_parameters.user_request.content,
          context: execution_parameters.execution_context,
          quality_requirements: execution_parameters.quality_requirements
        })
      
      case "quality_focused_workflow":
        return QualityWorkflow({
          deliverables: extract_deliverables(execution_parameters.user_request),
          standards: execution_parameters.quality_requirements.standards,
          compliance: execution_parameters.quality_requirements.compliance
        })
      
      case "debugging_workflow":
        return DebuggingWorkflow({
          description: execution_parameters.user_request.content,
          symptoms: extract_symptoms(execution_parameters.user_request),
          context: execution_parameters.execution_context
        })
      
      case "optimization_workflow":
        return OptimizationWorkflow({
          target: extract_optimization_target(execution_parameters.user_request),
          criteria: execution_parameters.quality_requirements.performance,
          goals: extract_optimization_goals(execution_parameters.user_request)
        })
      
      case "orchestration_workflow":
        return OrchestrationWorkflow({
          systems: extract_target_systems(execution_parameters.user_request),
          coordination: execution_parameters.configuration.coordination,
          constraints: execution_parameters.configuration.constraints
        })
      
      case "hybrid_workflow":
        return execute_hybrid_workflow(execution_parameters)
      
      default:
        return CoreWorkflow(execution_parameters)
    }
  }
```

## Intelligent Workflow Selection Framework

### Request Classification System
```yaml
request_classification:
  task_categories:
    - development_tasks: "code_creation_modification_and_optimization"
    - analysis_tasks: "system_analysis_investigation_and_assessment"
    - debugging_tasks: "problem_identification_and_resolution"
    - optimization_tasks: "performance_and_efficiency_improvement"
    - integration_tasks: "system_coordination_and_integration"
    - documentation_tasks: "documentation_creation_and_maintenance"
    - quality_assurance_tasks: "validation_testing_and_compliance"
    - maintenance_tasks: "system_maintenance_and_monitoring"
  
  complexity_levels:
    - simple: "straightforward_single_step_tasks"
    - moderate: "multi_step_tasks_with_limited_dependencies"
    - complex: "multi_phase_tasks_with_significant_dependencies"
    - advanced: "highly_complex_tasks_requiring_specialized_coordination"
  
  urgency_classifications:
    - immediate: "requires_immediate_attention_and_response"
    - high: "important_tasks_with_tight_timelines"
    - normal: "standard_priority_tasks_with_reasonable_timelines"
    - low: "lower_priority_tasks_with_flexible_timelines"
```

### Workflow Selection Criteria
```yaml
workflow_selection_criteria:
  core_workflow_indicators:
    - standard_development_request: "typical_development_or_modification_task"
    - clear_requirements: "well_defined_requirements_and_success_criteria"
    - moderate_complexity: "manageable_complexity_within_standard_workflow"
    - quality_standard_requirements: "standard_quality_and_validation_needs"
  
  quality_workflow_indicators:
    - quality_focus_request: "primary_focus_on_quality_assurance_or_validation"
    - compliance_requirements: "specific_compliance_or_standards_requirements"
    - high_quality_standards: "exceptionally_high_quality_expectations"
    - validation_intensive_tasks: "tasks_requiring_extensive_validation"
  
  debugging_workflow_indicators:
    - problem_reports: "user_reports_issues_or_problems"
    - error_descriptions: "descriptions_of_errors_or_unexpected_behavior"
    - troubleshooting_requests: "explicit_requests_for_troubleshooting"
    - system_malfunction_indicators: "indicators_of_system_malfunction"
  
  optimization_workflow_indicators:
    - performance_concerns: "performance_or_efficiency_improvement_requests"
    - resource_optimization_needs: "resource_utilization_optimization"
    - scalability_requirements: "scalability_or_capacity_improvement_needs"
    - iterative_improvement_requests: "requests_for_incremental_improvement"
  
  orchestration_workflow_indicators:
    - multi_system_tasks: "tasks_involving_multiple_systems_or_components"
    - integration_requirements: "system_integration_or_coordination_needs"
    - distributed_processing_needs: "tasks_requiring_distributed_processing"
    - complex_coordination_requirements: "complex_multi_agent_coordination_needs"
```

## User Experience Optimization

### Response Generation Framework
```yaml
response_optimization:
  content_adaptation:
    - technical_level_matching: "match_response_technical_level_to_user_expertise"
    - format_preferences: "adapt_response_format_to_user_preferences"
    - detail_level_optimization: "optimize_detail_level_based_on_user_needs"
    - context_aware_responses: "generate_contextually_appropriate_responses"
  
  presentation_optimization:
    - visual_formatting: "optimize_visual_presentation_for_readability"
    - structured_information: "structure_information_for_easy_consumption"
    - actionable_guidance: "provide_clear_actionable_guidance"
    - follow_up_suggestions: "suggest_relevant_follow_up_actions"
  
  interaction_enhancement:
    - clarification_handling: "handle_requests_for_clarification_gracefully"
    - progressive_disclosure: "reveal_information_progressively_as_needed"
    - feedback_integration: "integrate_user_feedback_into_response_improvement"
    - personalization: "personalize_responses_based_on_user_history_and_preferences"
```

### Learning and Adaptation
```yaml
learning_integration:
  user_preference_learning:
    - interaction_pattern_analysis: "analyze_user_interaction_patterns"
    - preference_extraction: "extract_user_preferences_from_behavior"
    - customization_recommendations: "recommend_customizations_based_on_preferences"
    - adaptive_interface_optimization: "optimize_interface_based_on_user_behavior"
  
  workflow_effectiveness_learning:
    - workflow_performance_tracking: "track_workflow_performance_for_different_request_types"
    - success_rate_analysis: "analyze_success_rates_of_different_workflow_selections"
    - user_satisfaction_correlation: "correlate_workflow_choices_with_user_satisfaction"
    - selection_algorithm_improvement: "improve_workflow_selection_algorithms_based_on_outcomes"
  
  continuous_improvement:
    - feedback_loop_optimization: "optimize_feedback_loops_for_maximum_learning"
    - knowledge_base_enhancement: "enhance_knowledge_base_with_learned_insights"
    - process_refinement: "refine_processes_based_on_accumulated_learning"
    - predictive_capability_development: "develop_predictive_capabilities_for_user_needs"
```

## Error Handling and User Support

### User-Centric Error Handling
```yaml
user_error_handling:
  error_communication:
    - user_friendly_explanations: "provide_clear_non_technical_error_explanations"
    - recovery_guidance: "guide_users_through_error_recovery_processes"
    - alternative_suggestions: "suggest_alternative_approaches_when_errors_occur"
    - escalation_options: "provide_clear_escalation_options_for_unresolved_issues"
  
  graceful_degradation:
    - partial_fulfillment: "provide_partial_fulfillment_when_complete_fulfillment_fails"
    - simplified_alternatives: "offer_simplified_alternatives_for_complex_failed_requests"
    - manual_assistance_integration: "seamlessly_integrate_manual_assistance_when_needed"
    - transparent_limitation_communication: "transparently_communicate_system_limitations"
  
  proactive_support:
    - error_prediction: "predict_potential_errors_and_provide_preventive_guidance"
    - context_aware_help: "provide_context_aware_help_and_assistance"
    - intelligent_suggestions: "provide_intelligent_suggestions_for_error_resolution"
    - learning_from_errors: "learn_from_errors_to_prevent_future_occurrences"
```

## Performance and Monitoring

### User Request Performance
```yaml
performance_monitoring:
  response_time_optimization:
    - request_processing_speed: "optimize_request_processing_speed"
    - workflow_execution_efficiency: "optimize_workflow_execution_efficiency"
    - response_generation_speed: "optimize_response_generation_speed"
    - end_to_end_latency: "minimize_end_to_end_request_response_latency"
  
  user_satisfaction_metrics:
    - satisfaction_scoring: "track_user_satisfaction_scores"
    - task_completion_rates: "monitor_task_completion_rates"
    - user_engagement_metrics: "track_user_engagement_and_interaction_quality"
    - retention_and_return_usage: "monitor_user_retention_and_return_usage_patterns"
  
  system_efficiency_metrics:
    - resource_utilization_efficiency: "monitor_resource_utilization_efficiency"
    - workflow_selection_accuracy: "track_workflow_selection_accuracy"
    - error_rates_and_recovery: "monitor_error_rates_and_recovery_effectiveness"
    - learning_effectiveness: "measure_learning_and_improvement_effectiveness"
```

## Usage Examples

### Standard User Request Processing
```bash
# Process typical user development request
UserRequestWorkflow({
  content: "Create a user authentication system with JWT tokens",
  context: {project_type: "web_application", framework: "React"},
  user_preferences: {detail_level: "comprehensive", format: "step_by_step"}
})
```

### Complex Multi-System Request
```bash
# Process complex integration request
UserRequestWorkflow({
  content: "Integrate payment processing with inventory management and user notifications",
  context: {system_type: "e_commerce", scale: "enterprise"},
  user_preferences: {quality_focus: "high", documentation: "extensive"}
})
```

### Problem-Solving Request
```bash
# Process debugging and problem resolution request
UserRequestWorkflow({
  content: "Database queries are running slowly and causing timeouts",
  context: {urgency: "high", impact: "production_users"},
  user_preferences: {response_style: "actionable", technical_level: "expert"}
})
```

## Cross-References

### Orchestrated Workflows
- [CoreWorkflow.md](CoreWorkflow.md) - Standard 8-phase workflow execution
- [QualityWorkflow.md](QualityWorkflow.md) - Quality-focused execution
- [DebuggingWorkflow.md](DebuggingWorkflow.md) - Problem resolution workflow
- [OptimizationWorkflow.md](OptimizationWorkflow.md) - Performance optimization workflow
- [OrchestrationWorkflow.md](OrchestrationWorkflow.md) - Multi-system coordination workflow

### Foundation Components
- All Atomic Operations - Complete atomic operation support
- All Molecular Patterns - Full molecular pattern integration
- All Assembly Workflows - Comprehensive assembly workflow support

### Framework Integration
- [User Experience](../../docs/principles/user-experience.md) - User experience optimization principles
- [Adaptive Systems](../../docs/components/adaptive-systems.md) - Adaptive system behavior
- [Learning Integration](../../docs/components/learning-integration.md) - Learning and improvement systems

[⬆ Return to top](#user-request-workflow---primary-user-request-processing)