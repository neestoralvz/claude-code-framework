# Agent-Based Evidence Collection Templates

**Context**: Comprehensive templates for systematic evidence collection from specialized agents in TDD/BDD workflows with multi-agent coordination

**Purpose**: Standardize evidence collection, validation, and integration across all agent specializations and coordination scenarios

---

## Evidence Collection Framework

### Evidence Types and Categories

**TDD Evidence Categories:**
```yaml
tdd_evidence_categories:
  red_phase_evidence:
    - failing_tests_documentation: "Screenshots and logs of failing tests"
    - test_design_rationale: "Explanation of test design decisions"
    - test_coverage_baseline: "Initial test coverage measurements"
    - failure_analysis: "Analysis of why tests fail (expected behavior)"
    
  green_phase_evidence:
    - passing_tests_documentation: "Screenshots and logs of passing tests"
    - minimal_implementation: "Code written to make tests pass"
    - implementation_rationale: "Explanation of implementation decisions"
    - test_coverage_achievement: "Final test coverage measurements"
    
  refactor_phase_evidence:
    - code_improvements: "Documentation of code quality improvements"
    - maintained_test_results: "Evidence that tests still pass after refactoring"
    - refactoring_rationale: "Explanation of refactoring decisions"
    - quality_metrics_improvement: "Measurable quality improvements"
```

**BDD Evidence Categories:**
```yaml
bdd_evidence_categories:
  scenario_definition_evidence:
    - written_scenarios: "Complete BDD scenarios in Gherkin format"
    - stakeholder_validation: "Stakeholder review and approval of scenarios"
    - acceptance_criteria_mapping: "Clear mapping to acceptance criteria"
    - scenario_completeness_validation: "Evidence scenarios cover all requirements"
    
  behavior_implementation_evidence:
    - working_behavior_demonstration: "Video or detailed screenshots of behavior"
    - scenario_execution_results: "Evidence of successful scenario execution"
    - user_value_demonstration: "Proof of user value delivery"
    - integration_behavior_evidence: "Evidence of behavior in integrated context"
    
  behavior_validation_evidence:
    - stakeholder_acceptance: "Stakeholder validation of implemented behavior"
    - user_acceptance_testing: "User acceptance test results"
    - regression_testing_results: "Evidence existing behavior is preserved"
    - behavior_consistency_validation: "Evidence behavior is consistent across contexts"
```

**Quality Assurance Evidence Categories:**
```yaml
quality_evidence_categories:
  domain_quality_evidence:
    - expert_validation: "Domain expert review and approval"
    - industry_standard_compliance: "Compliance with industry standards"
    - best_practice_adherence: "Evidence of best practice implementation"
    - quality_metrics_achievement: "Measurable quality metrics"
    
  integration_quality_evidence:
    - compatibility_validation: "Evidence of compatibility with other components"
    - interface_compliance: "Evidence of proper interface implementation"
    - data_integrity_validation: "Evidence of data integrity maintenance"
    - performance_impact_assessment: "Evidence of acceptable performance impact"
    
  system_quality_evidence:
    - end_to_end_functionality: "Evidence of complete system functionality"
    - user_experience_validation: "Evidence of acceptable user experience"
    - reliability_demonstration: "Evidence of system reliability"
    - maintainability_assessment: "Evidence of system maintainability"
```

## Agent-Specific Evidence Collection Templates

### Technical Specialist Evidence Templates

#### Architecture Agent Evidence Collection
```yaml
architecture_agent_evidence:
  agent_identification:
    agent_type: "Architecture Agent"
    specialization: "System Architecture and Design"
    task_context: "[Specific architectural task context]"
    evidence_collection_timestamp: "[YYYY-MM-DD HH:MM:SS]"
    
  tdd_evidence_package:
    red_phase_evidence:
      architectural_decision_tests:
        file_path: "[path_to_architecture_tests]"
        description: "Tests validating architectural decisions"
        test_scenarios:
          - scenario: "[architectural decision test scenario]"
            rationale: "[why this test validates the architecture]"
            failure_evidence: "[path to failing test evidence]"
      scalability_requirement_tests:
        file_path: "[path_to_scalability_tests]"
        description: "Tests validating scalability requirements"
        performance_thresholds:
          - requirement: "[scalability requirement]"
            test_method: "[how scalability is tested]"
            baseline_measurement: "[current performance baseline]"
      integration_point_tests:
        file_path: "[path_to_integration_tests]"
        description: "Tests validating system integration points"
        integration_scenarios:
          - integration_type: "[type of integration being tested]"
            validation_method: "[how integration is validated]"
            failure_analysis: "[analysis of integration test failures]"
            
    green_phase_evidence:
      architectural_pattern_implementation:
        file_path: "[path_to_implementation]"
        description: "Minimal implementation of architectural patterns"
        patterns_implemented:
          - pattern_name: "[design pattern name]"
            implementation_rationale: "[why this pattern was chosen]"
            minimal_implementation_scope: "[what was implemented minimally]"
      integration_interface_implementation:
        file_path: "[path_to_interfaces]"
        description: "Minimal integration interface implementation"
        interfaces_created:
          - interface_name: "[integration interface name]"
            purpose: "[what this interface enables]"
            minimal_functionality: "[essential functionality implemented]"
      scalability_foundation:
        file_path: "[path_to_scalability_implementation]"
        description: "Basic scalability structure implementation"
        scalability_mechanisms:
          - mechanism: "[scalability mechanism implemented]"
            implementation_scope: "[what was implemented for scalability]"
            validation_evidence: "[evidence mechanism works]"
            
    refactor_phase_evidence:
      architectural_optimization:
        file_path: "[path_to_optimized_architecture]"
        description: "Optimized architectural decisions and implementations"
        optimizations_made:
          - optimization_type: "[type of architectural optimization]"
            improvement_rationale: "[why this optimization was made]"
            impact_measurement: "[measurable impact of optimization]"
      design_pattern_refinement:
        file_path: "[path_to_refined_patterns]"
        description: "Refined and improved design pattern implementations"
        refinements_made:
          - pattern_name: "[pattern that was refined]"
            refinement_description: "[what was improved]"
            quality_improvement: "[measurable quality improvement]"
      architectural_documentation_enhancement:
        file_path: "[path_to_enhanced_documentation]"
        description: "Improved architectural documentation and ADRs"
        documentation_improvements:
          - document_type: "[type of documentation improved]"
            improvement_description: "[what was enhanced]"
            clarity_improvement: "[how clarity was improved]"
            
  bdd_evidence_package:
    architectural_behavior_scenarios:
      system_scalability_behavior:
        scenario_definition: |
          Given system needs to scale to [X] concurrent users
          When load increases beyond current capacity
          Then system should scale automatically without performance degradation
          And user experience should remain consistent
        implementation_evidence:
          file_path: "[path_to_scalability_demonstration]"
          description: "Evidence of working scalability behavior"
          demonstration_method: "[how scalability was demonstrated]"
        validation_evidence:
          stakeholder_validation: "[evidence of stakeholder approval]"
          performance_validation: "[evidence of performance under load]"
          scalability_testing_results: "[evidence of successful scaling]"
          
      system_integration_behavior:
        scenario_definition: |
          Given multiple systems need to integrate seamlessly
          When integration points are established and utilized
          Then data should flow correctly between all systems
          And no data integrity issues should occur
        implementation_evidence:
          file_path: "[path_to_integration_demonstration]"
          description: "Evidence of working integration behavior"
          integration_testing_results: "[evidence of successful integration]"
        validation_evidence:
          data_integrity_validation: "[evidence of maintained data integrity]"
          integration_performance_validation: "[evidence of acceptable performance]"
          error_handling_validation: "[evidence of proper error handling]"
          
  domain_specific_evidence:
    architectural_decision_records:
      file_path: "[path_to_ADRs]"
      description: "Comprehensive architectural decision records"
      decisions_documented:
        - decision_title: "[architectural decision title]"
          rationale: "[detailed rationale for decision]"
          alternatives_considered: "[alternative approaches considered]"
          trade_offs_analysis: "[analysis of trade-offs]"
          validation_evidence: "[evidence supporting decision]"
    scalability_validation:
      file_path: "[path_to_scalability_validation]"
      description: "Evidence of scalability capabilities"
      scalability_testing:
        - test_scenario: "[scalability test scenario]"
          baseline_performance: "[performance before scaling]"
          scaled_performance: "[performance after scaling]"
          scalability_factor: "[achieved scalability factor]"
    integration_validation:
      file_path: "[path_to_integration_validation]"
      description: "Evidence of successful system integrations"
      integration_testing:
        - integration_name: "[name of integration tested]"
          integration_method: "[how integration was implemented]"
          validation_results: "[results of integration testing]"
          performance_impact: "[measured performance impact]"
```

#### Implementation Agent Evidence Collection
```yaml
implementation_agent_evidence:
  agent_identification:
    agent_type: "Implementation Agent"
    specialization: "Feature Implementation and Development"
    task_context: "[Specific implementation task context]"
    evidence_collection_timestamp: "[YYYY-MM-DD HH:MM:SS]"
    
  tdd_evidence_package:
    red_phase_evidence:
      comprehensive_unit_tests:
        file_path: "[path_to_unit_tests]"
        description: "Comprehensive unit tests for all functions"
        test_coverage:
          - function_name: "[function being tested]"
            test_scenarios: "[list of test scenarios]"
            edge_cases_covered: "[edge cases included in tests]"
            failure_evidence: "[path to failing test results]"
      integration_tests:
        file_path: "[path_to_integration_tests]"
        description: "Integration tests for component interactions"
        integration_scenarios:
          - component_a: "[first component in integration]"
            component_b: "[second component in integration]"
            interaction_tested: "[specific interaction being tested]"
            failure_analysis: "[analysis of integration test failures]"
      error_handling_tests:
        file_path: "[path_to_error_tests]"
        description: "Tests for error scenarios and exception handling"
        error_scenarios:
          - error_type: "[type of error being tested]"
            error_trigger: "[what triggers this error]"
            expected_behavior: "[expected error handling behavior]"
            test_failure_evidence: "[evidence of failing error tests]"
            
    green_phase_evidence:
      minimal_function_implementation:
        file_path: "[path_to_implementation]"
        description: "Minimal working implementation of required functions"
        functions_implemented:
          - function_name: "[name of implemented function]"
            functionality_scope: "[what functionality was implemented]"
            test_passing_evidence: "[evidence tests now pass]"
            implementation_approach: "[approach taken for minimal implementation]"
      error_handling_implementation:
        file_path: "[path_to_error_handling]"
        description: "Basic error handling implementation"
        error_handling_mechanisms:
          - error_type: "[type of error being handled]"
            handling_approach: "[how error is handled]"
            user_experience_impact: "[impact on user experience]"
      integration_code_implementation:
        file_path: "[path_to_integration_code]"
        description: "Minimal integration code implementation"
        integrations_implemented:
          - integration_type: "[type of integration implemented]"
            integration_scope: "[scope of integration functionality]"
            compatibility_validation: "[evidence of integration compatibility]"
            
    refactor_phase_evidence:
      code_quality_improvements:
        file_path: "[path_to_improved_code]"
        description: "Code quality improvements for maintainability and readability"
        improvements_made:
          - improvement_type: "[type of code quality improvement]"
            before_metrics: "[code quality metrics before improvement]"
            after_metrics: "[code quality metrics after improvement]"
            improvement_rationale: "[rationale for specific improvements]"
      performance_optimizations:
        file_path: "[path_to_optimized_code]"
        description: "Performance optimizations where needed"
        optimizations_implemented:
          - optimization_type: "[type of performance optimization]"
            performance_before: "[performance metrics before optimization]"
            performance_after: "[performance metrics after optimization]"
            optimization_approach: "[approach taken for optimization]"
      design_pattern_applications:
        file_path: "[path_to_pattern_implementations]"
        description: "Appropriate design pattern applications"
        patterns_applied:
          - pattern_name: "[design pattern applied]"
            application_context: "[where and why pattern was applied]"
            benefit_achieved: "[benefit gained from pattern application]"
            
  bdd_evidence_package:
    feature_functionality_scenarios:
      user_feature_behavior:
        scenario_definition: |
          Given user needs to accomplish [specific task]
          When user accesses and uses the implemented feature
          Then feature should work exactly as specified
          And user should successfully achieve their intended goal
        implementation_evidence:
          file_path: "[path_to_feature_demonstration]"
          description: "Evidence of working feature behavior"
          demonstration_method: "[how feature behavior was demonstrated]"
        validation_evidence:
          user_testing_results: "[evidence of user testing]"
          acceptance_criteria_satisfaction: "[evidence criteria are met]"
          integration_behavior_validation: "[evidence feature works in context]"
          
      error_handling_scenarios:
        error_recovery_behavior:
        scenario_definition: |
          Given system encounters various error conditions during operation
          When errors occur in different contexts and scenarios
          Then system should handle all errors gracefully and appropriately
          And users should receive helpful feedback and recovery options
        implementation_evidence:
          file_path: "[path_to_error_handling_demonstration]"
          description: "Evidence of working error handling behavior"
          error_scenarios_tested:
            - error_scenario: "[specific error scenario]"
              handling_demonstration: "[how error handling was demonstrated]"
              user_experience_evidence: "[evidence of good user experience]"
        validation_evidence:
          error_recovery_validation: "[evidence of successful error recovery]"
          user_feedback_quality: "[evidence of helpful user feedback]"
          system_stability_validation: "[evidence system remains stable]"
          
  domain_specific_evidence:
    code_quality_metrics:
      file_path: "[path_to_quality_metrics]"
      description: "Comprehensive code quality measurements"
      metrics_achieved:
        - metric_name: "Cyclomatic Complexity"
          target_value: "[target complexity value]"
          achieved_value: "[actual complexity value]"
          assessment: "[met/exceeded/below target]"
        - metric_name: "Maintainability Index"
          target_value: "[target maintainability score]"
          achieved_value: "[actual maintainability score]"
          assessment: "[met/exceeded/below target]"
        - metric_name: "Code Coverage"
          target_value: "[target coverage percentage]"
          achieved_value: "[actual coverage percentage]"
          assessment: "[met/exceeded/below target]"
    functional_testing_validation:
      file_path: "[path_to_functional_tests]"
      description: "Evidence of correct functionality implementation"
      testing_results:
        - test_category: "[category of functional test]"
          tests_executed: "[number of tests in category]"
          tests_passed: "[number of tests that passed]"
          pass_rate: "[percentage pass rate]"
          critical_functionality_validation: "[evidence critical functions work]"
    performance_profiling:
      file_path: "[path_to_performance_analysis]"
      description: "Performance analysis and optimization evidence"
      performance_measurements:
        - performance_metric: "[specific performance metric]"
          baseline_measurement: "[performance before optimization]"
          optimized_measurement: "[performance after optimization]"
          improvement_percentage: "[percentage improvement achieved]"
          performance_target_met: "[whether performance target was achieved]"
```

#### Database Agent Evidence Collection
```yaml
database_agent_evidence:
  agent_identification:
    agent_type: "Database Agent"
    specialization: "Database Design, Optimization, and Management"
    task_context: "[Specific database task context]"
    evidence_collection_timestamp: "[YYYY-MM-DD HH:MM:SS]"
    
  tdd_evidence_package:
    red_phase_evidence:
      schema_validation_tests:
        file_path: "[path_to_schema_tests]"
        description: "Tests validating database schema correctness"
        schema_tests:
          - table_name: "[database table being tested]"
            validation_criteria: "[what is being validated about schema]"
            test_failure_evidence: "[evidence of failing schema tests]"
            constraint_validation: "[tests for database constraints]"
      data_integrity_tests:
        file_path: "[path_to_integrity_tests]"
        description: "Tests for referential integrity and data consistency"
        integrity_tests:
          - integrity_type: "[type of integrity being tested (referential, domain, etc.)]"
            test_scenario: "[specific integrity scenario being tested]"
            failure_evidence: "[evidence of failing integrity tests]"
            constraint_enforcement: "[evidence constraints are enforced]"
      performance_query_tests:
        file_path: "[path_to_performance_tests]"
        description: "Tests for database query performance requirements"
        performance_tests:
          - query_type: "[type of query being performance tested]"
            performance_requirement: "[required performance threshold]"
            baseline_performance: "[current performance measurement]"
            test_failure_evidence: "[evidence performance requirements not met]"
            
    green_phase_evidence:
      minimal_schema_implementation:
        file_path: "[path_to_schema_implementation]"
        description: "Basic database schema implementation"
        schema_elements:
          - element_type: "[table/index/constraint/etc.]"
            element_name: "[name of schema element]"
            implementation_scope: "[what was implemented minimally]"
            validation_evidence: "[evidence element works correctly]"
      basic_query_implementation:
        file_path: "[path_to_query_implementation]"
        description: "Simple query implementations for essential functionality"
        queries_implemented:
          - query_purpose: "[purpose of implemented query]"
            query_complexity: "[complexity level of query]"
            performance_achievement: "[evidence query meets performance requirements]"
            correctness_validation: "[evidence query produces correct results]"
      migration_script_implementation:
        file_path: "[path_to_migration_scripts]"
        description: "Core database migration functionality"
        migrations_implemented:
          - migration_type: "[type of migration (schema, data, etc.)]"
            migration_scope: "[what the migration accomplishes]"
            safety_measures: "[safety measures implemented in migration]"
            validation_evidence: "[evidence migration works correctly]"
            
    refactor_phase_evidence:
      query_optimization:
        file_path: "[path_to_optimized_queries]"
        description: "Optimized database queries for improved performance"
        optimizations_made:
          - query_name: "[query that was optimized]"
            optimization_technique: "[technique used for optimization]"
            performance_before: "[performance before optimization]"
            performance_after: "[performance after optimization]"
            optimization_rationale: "[rationale for optimization approach]"
      schema_normalization:
        file_path: "[path_to_normalized_schema]"
        description: "Improved database design through normalization"
        normalization_improvements:
          - normalization_level: "[level of normalization achieved]"
            design_improvement: "[specific design improvement made]"
            benefit_achieved: "[benefit gained from normalization]"
            impact_on_performance: "[impact on query performance]"
      index_optimization:
        file_path: "[path_to_index_strategy]"
        description: "Optimized database indexes for improved performance"
        index_optimizations:
          - index_name: "[name of optimized index]"
            optimization_type: "[type of index optimization]"
            performance_improvement: "[measured performance improvement]"
            space_impact: "[impact on database storage space]"
            
  bdd_evidence_package:
    data_persistence_scenarios:
      data_storage_behavior:
        scenario_definition: |
          Given application needs to store critical business data
          When data is saved through the application interface
          Then data should persist correctly in the database
          And data integrity should be maintained across all operations
        implementation_evidence:
          file_path: "[path_to_persistence_demonstration]"
          description: "Evidence of working data persistence behavior"
          persistence_validation:
            - data_type: "[type of data being persisted]"
              persistence_method: "[how data persistence was demonstrated]"
              integrity_validation: "[evidence of maintained data integrity]"
        validation_evidence:
          data_consistency_validation: "[evidence of data consistency]"
          transaction_integrity_validation: "[evidence of transaction integrity]"
          recovery_capability_validation: "[evidence of data recovery capability]"
          
      query_performance_scenarios:
        performance_behavior:
        scenario_definition: |
          Given system has performance requirements for database operations
          When complex queries are executed under normal and peak load
          Then response times should consistently meet performance requirements
          And resource usage should remain within acceptable limits
        implementation_evidence:
          file_path: "[path_to_performance_demonstration]"
          description: "Evidence of acceptable query performance behavior"
          performance_demonstrations:
            - query_scenario: "[specific query performance scenario]"
              load_condition: "[load condition during testing]"
              performance_measurement: "[measured performance results]"
              requirement_satisfaction: "[evidence requirements are met]"
        validation_evidence:
          performance_consistency_validation: "[evidence of consistent performance]"
          scalability_validation: "[evidence of performance under scale]"
          resource_usage_validation: "[evidence of acceptable resource usage]"
          
  domain_specific_evidence:
    schema_validation_results:
      file_path: "[path_to_schema_validation]"
      description: "Database schema correctness and design validation"
      validation_results:
        - validation_type: "[type of schema validation performed]"
          validation_method: "[method used for validation]"
          validation_result: "[result of validation]"
          issues_identified: "[any issues found and resolved]"
          design_quality_assessment: "[assessment of schema design quality]"
    performance_benchmarking:
      file_path: "[path_to_performance_benchmarks]"
      description: "Comprehensive database performance testing results"
      benchmark_results:
        - benchmark_type: "[type of performance benchmark]"
          test_conditions: "[conditions under which benchmark was run]"
          baseline_performance: "[baseline performance measurement]"
          achieved_performance: "[actual performance achieved]"
          performance_target_met: "[whether performance targets were met]"
    data_integrity_verification:
      file_path: "[path_to_integrity_verification]"
      description: "Comprehensive data integrity and consistency validation"
      integrity_validations:
        - integrity_aspect: "[aspect of data integrity tested]"
          validation_method: "[method used to validate integrity]"
          validation_result: "[result of integrity validation]"
          constraint_effectiveness: "[effectiveness of integrity constraints]"
```

### Cross-Agent Evidence Integration Templates

#### Multi-Agent Evidence Correlation Template
```yaml
multi_agent_evidence_correlation:
  coordination_session_info:
    coordination_timestamp: "[YYYY-MM-DD HH:MM:SS]"
    participating_agents: "[list of all agents that participated]"
    coordination_objective: "[overall objective of multi-agent coordination]"
    evidence_correlation_method: "[method used to correlate evidence across agents]"
    
  individual_agent_evidence_summary:
    - agent_id: "[agent identifier]"
      agent_specialization: "[agent's domain of expertise]"
      evidence_package_location: "[path to agent's complete evidence package]"
      evidence_quality_score: "[assessed quality score for agent's evidence]"
      tdd_compliance_score: "[TDD compliance assessment score]"
      bdd_compliance_score: "[BDD compliance assessment score]"
      domain_expertise_score: "[domain-specific quality assessment score]"
      evidence_completeness: "[completeness assessment of agent's evidence]"
      
  cross_agent_evidence_validation:
    compatibility_evidence:
      - evidence_correlation: "[description of evidence correlation between agents]"
        consistency_validation: "[evidence that agent outputs are consistent]"
        compatibility_test_results: "[results of compatibility testing]"
        integration_evidence: "[evidence of successful agent integration]"
        conflict_resolution_evidence: "[evidence of resolution of any conflicts]"
    
    quality_consistency_evidence:
      - quality_standard_alignment: "[evidence quality standards are consistent]"
        evidence_format_consistency: "[evidence formats are compatible]"
        validation_rigor_consistency: "[validation approaches are equally rigorous]"
        documentation_standard_compliance: "[documentation follows same standards]"
        
    integration_success_evidence:
      - system_level_functionality: "[evidence integrated system works correctly]"
        end_to_end_behavior: "[evidence of complete system behavior]"
        user_value_delivery: "[evidence user value is delivered by integrated system]"
        performance_integration_impact: "[evidence of acceptable performance impact]"
        
  comprehensive_evidence_package:
    aggregated_tdd_evidence:
      - red_phase_aggregation: "[summary of red phase evidence across all agents]"
        green_phase_aggregation: "[summary of green phase evidence across all agents]"
        refactor_phase_aggregation: "[summary of refactor phase evidence across all agents]"
        tdd_cycle_completeness: "[evidence all agents completed TDD cycles]"
        
    aggregated_bdd_evidence:
      - scenario_coverage_completeness: "[evidence all BDD scenarios are covered]"
        behavior_demonstration_completeness: "[evidence all behaviors are demonstrated]"
        stakeholder_validation_completeness: "[evidence all stakeholder validations complete]"
        user_value_delivery_evidence: "[evidence complete user value is delivered]"
        
    aggregated_quality_evidence:
      - domain_expertise_validation: "[aggregated evidence of domain expertise quality]"
        integration_quality_validation: "[aggregated evidence of integration quality]"
        system_quality_validation: "[aggregated evidence of overall system quality]"
        compliance_validation: "[aggregated evidence of standards compliance]"
        
  evidence_traceability_matrix:
    requirement_to_evidence_mapping:
      - requirement_id: "[unique requirement identifier]"
        requirement_description: "[description of requirement]"
        responsible_agents: "[agents responsible for this requirement]"
        evidence_locations: "[where evidence for this requirement can be found]"
        validation_status: "[whether requirement is fully validated]"
        traceability_completeness: "[completeness of evidence traceability]"
        
    agent_contribution_mapping:
      - agent_id: "[agent identifier]"
        contribution_description: "[agent's contribution to overall solution]"
        evidence_provided: "[evidence provided by this agent]"
        integration_points: "[how agent's work integrates with others]"
        value_delivered: "[specific value delivered by this agent]"
        
  validation_completeness_assessment:
    evidence_completeness_checklist:
      - evidence_category: "[category of evidence]"
        required_evidence_items: "[list of required evidence items in category]"
        provided_evidence_items: "[list of evidence items actually provided]"
        completeness_percentage: "[percentage of required evidence provided]"
        gaps_identified: "[any gaps in evidence provision]"
        gap_resolution_plan: "[plan to resolve evidence gaps]"
        
    validation_thoroughness_assessment:
      - validation_aspect: "[aspect of validation being assessed]"
        validation_methods_used: "[methods used for validation]"
        validation_rigor_level: "[assessed rigor level of validation]"
        validation_coverage: "[coverage of validation activities]"
        validation_quality_score: "[quality score for validation activities]"
```

#### System-Level Evidence Integration Template
```yaml
system_level_evidence_integration:
  system_identification:
    system_name: "[name of complete integrated system]"
    system_description: "[description of system functionality]"
    integration_timestamp: "[when system integration was completed]"
    evidence_integration_timestamp: "[when evidence integration was completed]"
    
  integrated_system_evidence:
    end_to_end_functionality_evidence:
      - functionality_name: "[name of end-to-end functionality]"
        functionality_description: "[description of functionality]"
        agents_involved: "[agents that contribute to this functionality]"
        demonstration_evidence: "[evidence of working end-to-end functionality]"
        user_value_evidence: "[evidence of user value delivery]"
        performance_evidence: "[evidence of acceptable performance]"
        
    system_behavior_evidence:
      - behavior_scenario: "[description of system behavior scenario]"
        bdd_scenario_reference: "[reference to specific BDD scenarios]"
        behavior_demonstration: "[evidence of system behavior working correctly]"
        stakeholder_validation: "[evidence of stakeholder approval of behavior]"
        integration_quality: "[evidence of quality in integrated behavior]"
        
    system_quality_evidence:
      - quality_aspect: "[aspect of system quality]"
        quality_measurement: "[how quality was measured]"
        quality_standard: "[standard against which quality was measured]"
        quality_achievement: "[evidence quality standard was met]"
        quality_consistency: "[evidence quality is consistent across system]"
        
  regression_protection_evidence:
    existing_functionality_preservation:
      - existing_function: "[description of existing functionality]"
        preservation_method: "[method used to preserve functionality]"
        regression_test_results: "[results of regression testing]"
        functionality_validation: "[evidence functionality still works correctly]"
        performance_impact_assessment: "[assessment of any performance impact]"
        
    backward_compatibility_evidence:
      - compatibility_aspect: "[aspect of backward compatibility]"
        compatibility_testing_method: "[method used to test compatibility]"
        compatibility_test_results: "[results of compatibility testing]"
        compatibility_validation: "[evidence of maintained compatibility]"
        migration_path_evidence: "[evidence of clear migration path if needed]"
        
  comprehensive_validation_summary:
    overall_validation_status:
      - validation_category: "[category of validation]"
        validation_completeness: "[completeness percentage]"
        validation_quality: "[quality assessment]"
        validation_evidence_location: "[where validation evidence can be found]"
        outstanding_issues: "[any outstanding validation issues]"
        resolution_timeline: "[timeline for resolving outstanding issues]"
        
    success_criteria_achievement:
      - success_criterion: "[specific success criterion]"
        achievement_method: "[how achievement was measured]"
        achievement_evidence: "[evidence criterion was achieved]"
        achievement_quality: "[quality of criterion achievement]"
        stakeholder_validation: "[stakeholder validation of criterion achievement]"
        
    recommendation_summary:
      - recommendation_category: "[category of recommendation]"
        recommendation_description: "[specific recommendation]"
        evidence_supporting_recommendation: "[evidence supporting the recommendation]"
        implementation_priority: "[priority level for recommendation implementation]"
        implementation_timeline: "[recommended timeline for implementation]"
```

## Evidence Quality Assurance Framework

### Evidence Validation Checklist
```yaml
evidence_validation_checklist:
  evidence_completeness_validation:
    - evidence_category: "[TDD/BDD/Quality/Integration evidence]"
      required_components:
        - component: "[specific required evidence component]"
          provided: "[yes/no - was this component provided]"
          quality_level: "[high/medium/low quality assessment]"
          accessibility: "[easy/medium/difficult to access and understand]"
          completeness: "[complete/partial/incomplete]"
          
  evidence_quality_validation:
    - quality_aspect: "[aspect of evidence quality being assessed]"
      assessment_criteria: "[criteria used for quality assessment]"
      assessment_method: "[method used to assess quality]"
      quality_score: "[numerical or categorical quality score]"
      improvement_recommendations: "[recommendations for quality improvement]"
      
  evidence_accessibility_validation:
    - accessibility_aspect: "[aspect of evidence accessibility]"
      accessibility_standard: "[standard used for accessibility assessment]"
      accessibility_test_method: "[method used to test accessibility]"
      accessibility_result: "[result of accessibility testing]"
      accessibility_improvements: "[improvements made to enhance accessibility]"
      
  evidence_traceability_validation:
    - traceability_requirement: "[requirement for evidence traceability]"
      traceability_method: "[method used to establish traceability]"
      traceability_completeness: "[completeness of traceability]"
      traceability_quality: "[quality of traceability links]"
      traceability_maintenance: "[plan for maintaining traceability]"
```

### Evidence Storage and Organization Standards
```yaml
evidence_storage_standards:
  directory_structure:
    base_evidence_directory: "/path/to/evidence/collection/"
    agent_specific_directories: "[base]/agents/[agent_id]/"
    cross_agent_directories: "[base]/cross_agent_validation/"
    system_level_directories: "[base]/system_integration/"
    
  file_naming_conventions:
    tdd_evidence_files:
      - red_phase: "[agent_id]_red_phase_[timestamp]_[description].[ext]"
      - green_phase: "[agent_id]_green_phase_[timestamp]_[description].[ext]"
      - refactor_phase: "[agent_id]_refactor_phase_[timestamp]_[description].[ext]"
    bdd_evidence_files:
      - scenarios: "[agent_id]_bdd_scenarios_[timestamp].[ext]"
      - demonstrations: "[agent_id]_behavior_demo_[timestamp].[ext]"
      - validations: "[agent_id]_behavior_validation_[timestamp].[ext]"
    integration_evidence_files:
      - compatibility: "compatibility_[agent_a]_[agent_b]_[timestamp].[ext]"
      - integration: "integration_test_[timestamp]_[description].[ext]"
      - system_level: "system_[functionality]_[timestamp].[ext]"
      
  metadata_requirements:
    - evidence_metadata:
        creation_timestamp: "[when evidence was created]"
        creator_identification: "[who or what created the evidence]"
        evidence_type: "[TDD/BDD/Quality/Integration]"
        evidence_category: "[specific category within type]"
        related_requirements: "[requirements this evidence supports]"
        quality_assessment: "[assessed quality level]"
        accessibility_level: "[accessibility assessment]"
        validation_status: "[whether evidence has been validated]"
        integration_references: "[references to related evidence]"
```

## Usage Guidelines

### Template Selection Guide
```yaml
template_selection_guide:
  agent_type_mapping:
    - agent_type: "Technical Specialists (Architecture, Implementation, Database, Security, Performance)"
      recommended_templates:
        - primary_template: "[Agent Type] Evidence Collection Template"
        - supporting_templates: "Multi-Agent Evidence Correlation Template"
        - integration_templates: "System-Level Evidence Integration Template"
    - agent_type: "Process Specialists (Quality, Documentation, Integration, Deployment)"
      recommended_templates:
        - primary_template: "[Agent Type] Evidence Collection Template"
        - supporting_templates: "Cross-Agent Evidence Integration Template"
        - validation_templates: "Evidence Quality Assurance Framework"
    - agent_type: "Strategic Specialists (Analysis, Design, Validation, Coordination)"
      recommended_templates:
        - primary_template: "[Agent Type] Evidence Collection Template"
        - supporting_templates: "System-Level Evidence Integration Template"
        - coordination_templates: "Multi-Agent Evidence Correlation Template"
        
  evidence_collection_workflow:
    phase_1_individual_collection:
      - step: "Select appropriate agent-specific evidence template"
      - step: "Customize template for specific task context"
      - step: "Collect evidence during TDD/BDD execution"
      - step: "Validate evidence completeness and quality"
    phase_2_cross_agent_integration:
      - step: "Apply Multi-Agent Evidence Correlation Template"
      - step: "Validate evidence compatibility and consistency"
      - step: "Resolve any evidence conflicts or gaps"
      - step: "Create integrated evidence package"
    phase_3_system_level_integration:
      - step: "Apply System-Level Evidence Integration Template"
      - step: "Validate end-to-end system evidence"
      - step: "Create comprehensive system evidence package"
      - step: "Validate evidence package completeness and quality"
```

### Quality Assurance Guidelines
```yaml
quality_assurance_guidelines:
  evidence_quality_standards:
    minimum_quality_thresholds:
      - evidence_completeness: "95% - must provide 95% of required evidence"
      - evidence_accuracy: "90% - evidence must be 90% accurate"
      - evidence_accessibility: "100% - evidence must be fully accessible"
      - evidence_traceability: "100% - full traceability must be maintained"
    quality_improvement_process:
      - step: "Assess current evidence quality against standards"
      - step: "Identify specific quality gaps or deficiencies"
      - step: "Implement quality improvement measures"
      - step: "Re-validate evidence quality after improvements"
      - step: "Document quality improvement actions taken"
      
  evidence_validation_process:
    validation_phases:
      - phase: "Individual Evidence Validation"
        activities: "Validate each piece of evidence independently"
        criteria: "Completeness, accuracy, accessibility, format compliance"
      - phase: "Cross-Evidence Validation"
        activities: "Validate evidence consistency and compatibility"
        criteria: "Consistency, integration, traceability, correlation quality"
      - phase: "System-Level Evidence Validation"  
        activities: "Validate complete evidence package"
        criteria: "Completeness, system coverage, stakeholder satisfaction"
```

---

**Template Version**: 1.0  
**Last Updated**: 2025-08-20  
**Compatibility**: Integrates with Agent Coordination TDD Workflow, Parallel Agent Execution Templates, and Agent Specialization TDD Compliance Framework