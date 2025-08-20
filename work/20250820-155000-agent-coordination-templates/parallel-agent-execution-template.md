# Parallel Agent Execution Template with Evidence Collection

**Context**: Standardized template for coordinating multiple agents in parallel with comprehensive TDD/BDD validation and evidence collection

**Usage**: Use this template when deploying multiple specialized agents for complex tasks requiring coordination and validation

---

## Pre-Execution Planning Template

### Overall System BDD Scenario
```gherkin
Feature: [Feature Name] Multi-Agent Implementation
  As a [stakeholder]
  I want [overall system behavior]
  So that [business value is achieved]
  
Background:
  Given [system context and prerequisites]
  
Scenario: Multi-Agent Coordination Success
  Given complex task requiring multiple specializations
  When specialized agents coordinate execution
  Then integrated solution should work correctly
  And all quality standards should be met
  And comprehensive evidence should be provided
  
Scenario: Cross-Agent Validation Success
  Given multiple agents produce outputs
  When agents validate each other's work
  Then all outputs should be compatible
  And integration should be seamless
  And evidence should be comprehensive
```

### Agent Assignment Matrix Template
```yaml
agent_assignment_matrix:
  overall_objective: "[Clear description of what needs to be accomplished]"
  success_criteria: "[Specific, measurable outcomes that define success]"
  
  agents:
    - agent_id: "[unique_identifier]"
      specialization: "[domain expertise area]"
      task_assignment:
        primary_objective: "[specific goal for this agent]"
        deliverables:
          - "[specific output 1]"
          - "[specific output 2]"
        success_criteria:
          - "[measurable success criterion 1]"
          - "[measurable success criterion 2]"
        bdd_scenario: |
          Given [agent context]
          When [agent executes task]
          Then [expected agent behavior]
          And [quality criteria met]
        tdd_requirements:
          - must_write_tests_first: true
          - must_follow_red_green_refactor: true
          - must_provide_test_evidence: true
          - must_demonstrate_behavior: true
        evidence_requirements:
          - tdd_cycle_proof: "Screenshots of red-green-refactor cycle"
          - bdd_implementation_proof: "Working behavior demonstration"
          - quality_validation_proof: "Domain-specific quality evidence"
          - integration_readiness_proof: "Compatibility test results"
        coordination_requirements:
          - depends_on: "[list of agent dependencies]"
          - provides_input_to: "[list of agents that consume this agent's output]"
          - synchronization_points: "[list of coordination checkpoints]"
        
  cross_agent_validation:
    compatibility_tests:
      - test_name: "[compatibility test description]"
        agents_involved: "[list of agents]"
        validation_method: "[how compatibility will be verified]"
    integration_tests:
      - test_name: "[integration test description]"
        system_behavior: "[expected integrated behavior]"
        validation_method: "[how integration will be verified]"
```

## Agent Deployment Messages Template

### Standard Agent Deployment Message
```yaml
agent_deployment_message:
  agent_identification:
    agent_id: "[unique_agent_identifier]"
    specialization: "[domain_expertise_area]"
    deployment_timestamp: "[YYYY-MM-DD HH:MM:SS]"
    
  task_specification:
    primary_objective: "[clear, specific goal]"
    context: "[background information and constraints]"
    deliverables:
      - deliverable_1:
          description: "[what needs to be created/delivered]"
          format: "[expected format/structure]"
          quality_criteria: "[specific quality requirements]"
      - deliverable_2:
          description: "[second deliverable description]"
          format: "[expected format/structure]"
          quality_criteria: "[specific quality requirements]"
          
  tdd_bdd_requirements:
    bdd_scenario_requirement: |
      Given [your specific agent context]
      When [you execute your assigned task]
      Then [you must deliver the specified outcomes]
      And [meet all quality criteria]
      And [provide comprehensive evidence]
    tdd_cycle_requirement:
      red_phase: "Write failing tests first - provide screenshot evidence"
      green_phase: "Implement minimal code to pass tests - provide screenshot evidence"
      refactor_phase: "Improve code quality while maintaining tests - provide evidence"
    validation_requirements:
      - "All tests must pass with evidence"
      - "Behavior must be demonstrable"
      - "Quality gates must be satisfied"
      - "Integration compatibility must be verified"
      
  evidence_package_requirements:
    tdd_evidence:
      - failing_tests_screenshot: "Required - show red phase"
      - passing_tests_screenshot: "Required - show green phase"
      - refactored_code_evidence: "Required - show improvement phase"
      - test_coverage_report: "Required - demonstrate comprehensive testing"
    bdd_evidence:
      - scenario_implementation: "Required - show BDD scenario working"
      - behavior_demonstration: "Required - video or detailed screenshots"
      - acceptance_criteria_proof: "Required - show all criteria satisfied"
    quality_evidence:
      - domain_validation: "Required - show domain-specific quality measures"
      - integration_compatibility: "Required - show compatibility with other agents"
      - performance_validation: "Required - show performance meets requirements"
      
  coordination_instructions:
    synchronization_points:
      - checkpoint_1:
          description: "[what needs to be synchronized]"
          timing: "[when synchronization should occur]"
          validation_method: "[how to verify synchronization success]"
    dependencies:
      input_dependencies:
        - dependency_source: "[which agent provides input]"
          dependency_description: "[what input is needed]"
          delivery_format: "[expected input format]"
      output_consumers:
        - consumer_agent: "[which agent consumes your output]"
          output_description: "[what output they need]"
          delivery_format: "[required output format]"
    conflict_resolution:
      escalation_procedure: "[how to handle conflicts or blocking issues]"
      quality_dispute_resolution: "[how to resolve quality disagreements]"
      
  success_validation:
    completion_criteria:
      - "[specific criterion 1 - must be measurable]"
      - "[specific criterion 2 - must be measurable]"
    quality_gates:
      - gate_name: "[quality gate description]"
        validation_method: "[how quality will be measured]"
        pass_criteria: "[what constitutes passing this gate]"
    evidence_completeness_check:
      - "[evidence requirement 1]"
      - "[evidence requirement 2]"
      
  reporting_requirements:
    progress_updates:
      frequency: "[how often to provide updates]"
      format: "[expected update format]"
      content_requirements:
        - "Current phase status"
        - "Completed deliverables"
        - "Blocking issues (if any)"
        - "Evidence collection status"
        - "Next phase preview"
    final_report:
      evidence_package: "Complete evidence package as specified above"
      integration_status: "Confirmation of integration readiness"
      quality_validation: "Proof of quality gate compliance"
      lessons_learned: "Key insights and recommendations"
```

## Parallel Execution Monitoring Template

### Real-Time Status Tracking
```yaml
parallel_execution_status:
  overall_system_status:
    phase: "[current execution phase]"
    start_time: "[execution start timestamp]"
    estimated_completion: "[projected completion time]"
    overall_health: "[green/yellow/red status]"
    
  agent_status_matrix:
    - agent_id: "[agent_identifier]"
      current_phase: "[current_work_phase]"
      progress_percentage: "[0-100% completion]"
      tdd_phase_status:
        red_phase: "[complete/in_progress/not_started]"
        green_phase: "[complete/in_progress/not_started]"
        refactor_phase: "[complete/in_progress/not_started]"
      bdd_implementation_status:
        scenario_written: "[complete/in_progress/not_started]"
        scenario_implemented: "[complete/in_progress/not_started]"
        behavior_demonstrated: "[complete/in_progress/not_started]"
      evidence_collection_status:
        tdd_evidence: "[complete/partial/not_started]"
        bdd_evidence: "[complete/partial/not_started]"
        quality_evidence: "[complete/partial/not_started]"
      blocking_issues:
        - issue: "[description of blocking issue]"
          severity: "[high/medium/low]"
          estimated_resolution_time: "[time estimate]"
      quality_gate_status:
        - gate_name: "[quality gate name]"
          status: "[passed/failed/pending]"
          evidence_provided: "[yes/no/partial]"
          
  cross_agent_validation_status:
    compatibility_tests:
      - test_name: "[compatibility test name]"
        agents_involved: "[list of agents]"
        status: "[passed/failed/pending]"
        evidence_location: "[where evidence is stored]"
    integration_tests:
      - test_name: "[integration test name]"
        system_component: "[what system behavior is tested]"
        status: "[passed/failed/pending]"
        evidence_location: "[where evidence is stored]"
        
  system_level_validation:
    end_to_end_tests:
      - test_name: "[system test name]"
        behavior_tested: "[what system behavior is validated]"
        status: "[passed/failed/pending]"
        evidence_location: "[where evidence is stored]"
    regression_tests:
      - test_name: "[regression test name]"
        functionality_tested: "[what existing functionality is protected]"
        status: "[passed/failed/pending]"
        evidence_location: "[where evidence is stored]"
```

## Evidence Collection Templates

### Agent Evidence Package Template
```yaml
agent_evidence_package:
  agent_identification:
    agent_id: "[unique_identifier]"
    specialization: "[domain_area]"
    task_completion_timestamp: "[YYYY-MM-DD HH:MM:SS]"
    evidence_package_version: "[v1.0]"
    
  tdd_compliance_evidence:
    red_phase_evidence:
      failing_tests_screenshot:
        file_path: "[path_to_screenshot]"
        description: "Screenshot showing failing tests before implementation"
        timestamp: "[when screenshot was taken]"
      test_failure_log:
        file_path: "[path_to_log_file]"
        description: "Detailed log of test failures in red phase"
        test_count: "[number of failing tests]"
      test_coverage_report:
        file_path: "[path_to_coverage_report]"
        description: "Test coverage metrics before implementation"
        coverage_percentage: "[coverage percentage]"
        
    green_phase_evidence:
      passing_tests_screenshot:
        file_path: "[path_to_screenshot]"
        description: "Screenshot showing all tests passing after implementation"
        timestamp: "[when screenshot was taken]"
      implementation_code:
        file_path: "[path_to_implementation]"
        description: "Actual code implemented to make tests pass"
        lines_of_code: "[implementation size]"
      test_success_log:
        file_path: "[path_to_success_log]"
        description: "Detailed log of successful test execution"
        test_count: "[number of passing tests]"
        
    refactor_phase_evidence:
      refactored_code:
        file_path: "[path_to_refactored_code]"
        description: "Improved code after refactoring"
        improvements_made: "[list of specific improvements]"
      maintained_tests_proof:
        file_path: "[path_to_test_results]"
        description: "Proof that all tests still pass after refactoring"
        test_count: "[number of tests still passing]"
      quality_improvements:
        file_path: "[path_to_quality_metrics]"
        description: "Documentation of quality improvements made"
        metrics_improved: "[list of quality metrics that improved]"
        
  bdd_compliance_evidence:
    scenario_definition:
      bdd_scenarios_file:
        file_path: "[path_to_scenarios]"
        description: "Written BDD scenarios for agent task"
        scenario_count: "[number of scenarios]"
      scenario_validation:
        file_path: "[path_to_validation]"
        description: "Validation that scenarios are correct and complete"
        validation_method: "[how scenarios were validated]"
        
    behavior_demonstration:
      working_behavior_demo:
        file_path: "[path_to_demo_video_or_screenshots]"
        description: "Demonstration of working behavior matching BDD scenarios"
        demo_type: "[video/screenshots/interactive_demo]"
      acceptance_criteria_satisfaction:
        file_path: "[path_to_acceptance_proof]"
        description: "Proof that all acceptance criteria are satisfied"
        criteria_count: "[number of criteria satisfied]"
      user_story_satisfaction:
        file_path: "[path_to_user_story_proof]"
        description: "Evidence that user story requirements are met"
        story_validation_method: "[how user story satisfaction was verified]"
        
  quality_assurance_evidence:
    domain_specific_validation:
      expert_review:
        file_path: "[path_to_expert_review]"
        description: "Review by domain expert confirming quality"
        reviewer_qualifications: "[expert credentials]"
        review_date: "[when review was conducted]"
      quality_metrics:
        file_path: "[path_to_quality_report]"
        description: "Measurable quality metrics for agent output"
        metrics_achieved:
          - metric_name: "[quality metric name]"
            target_value: "[expected value]"
            actual_value: "[achieved value]"
            status: "[met/exceeded/failed]"
      standard_compliance:
        file_path: "[path_to_compliance_report]"
        description: "Verification of compliance with relevant standards"
        standards_checked:
          - standard_name: "[name of standard]"
            compliance_status: "[compliant/non_compliant]"
            evidence_location: "[where compliance evidence is stored]"
            
    integration_validation:
      compatibility_test_results:
        file_path: "[path_to_compatibility_results]"
        description: "Results of compatibility tests with other agents"
        tests_conducted:
          - test_name: "[compatibility test name]"
            other_agent: "[agent tested with]"
            result: "[passed/failed]"
            evidence_location: "[where test evidence is stored]"
      integration_success_proof:
        file_path: "[path_to_integration_proof]"
        description: "Evidence of successful integration with other agent outputs"
        integration_type: "[type of integration performed]"
        integration_validation_method: "[how integration was validated]"
      regression_protection:
        file_path: "[path_to_regression_results]"
        description: "Proof that existing functionality is not broken"
        regression_tests_count: "[number of regression tests run]"
        regression_test_results: "[all_passed/some_failed - with details]"
```

### Cross-Agent Validation Evidence Template
```yaml
cross_agent_validation_evidence:
  validation_session_info:
    validation_timestamp: "[YYYY-MM-DD HH:MM:SS]"
    agents_involved: "[list of all agents participating in validation]"
    validation_coordinator: "[who coordinated the cross-validation]"
    validation_type: "[compatibility/integration/quality_consistency]"
    
  compatibility_validation_evidence:
    interface_compatibility:
      - agent_pair: "[agent_a, agent_b]"
        compatibility_test_name: "[name of compatibility test]"
        test_result: "[passed/failed]"
        evidence_file: "[path to test evidence]"
        issues_identified: "[list of any compatibility issues]"
        resolution_actions: "[actions taken to resolve issues]"
        
    data_format_compatibility:
      - data_exchange: "[description of data being exchanged]"
        format_validation: "[validation that formats are compatible]"
        test_evidence: "[path to format compatibility evidence]"
        validation_method: "[how format compatibility was tested]"
        
    behavioral_compatibility:
      - behavior_tested: "[description of behavior being validated]"
        compatibility_result: "[compatible/incompatible]"
        evidence_location: "[where behavioral compatibility evidence is stored]"
        impact_assessment: "[assessment of any behavioral conflicts]"
        
  integration_validation_evidence:
    system_level_tests:
      - test_name: "[integration test name]"
        system_behavior_tested: "[what integrated behavior was tested]"
        test_result: "[passed/failed]"
        evidence_file: "[path to integration test evidence]"
        agents_involved: "[which agents participated in this integration]"
        
    end_to_end_validation:
      - scenario_tested: "[description of end-to-end scenario]"
        validation_result: "[successful/failed]"
        evidence_location: "[where end-to-end evidence is stored]"
        user_value_demonstrated: "[what user value was proven]"
        
  quality_consistency_evidence:
    quality_standard_alignment:
      - quality_metric: "[name of quality metric]"
        consistency_across_agents: "[consistent/inconsistent]"
        metric_values:
          - agent_id: "[agent identifier]"
            metric_value: "[measured value]"
            meets_standard: "[yes/no]"
        consistency_validation: "[how consistency was verified]"
        
    evidence_quality_validation:
      - evidence_type: "[type of evidence being validated]"
        quality_assessment: "[high/medium/low quality]"
        validation_criteria: "[criteria used to assess evidence quality]"
        improvement_recommendations: "[any recommendations for evidence improvement]"
```

## Success Validation Checklist Template

### Multi-Agent Success Validation
```yaml
success_validation_checklist:
  overall_system_validation:
    - criterion: "All BDD scenarios implemented and working"
      validation_method: "Execute all scenarios and verify behavior"
      evidence_required: "Working demonstration of all scenarios"
      status: "[passed/failed/pending]"
      evidence_location: "[where evidence is stored]"
      
    - criterion: "All agents completed TDD cycles with evidence"
      validation_method: "Review TDD evidence from each agent"
      evidence_required: "Red-green-refactor proof from all agents"
      status: "[passed/failed/pending]"
      evidence_location: "[where evidence is stored]"
      
    - criterion: "Cross-agent integration successful"
      validation_method: "Execute integration tests"
      evidence_required: "Integration test results and system demo"
      status: "[passed/failed/pending]"
      evidence_location: "[where evidence is stored]"
      
    - criterion: "Quality standards met across all agents"
      validation_method: "Quality assessment of all agent outputs"
      evidence_required: "Quality metrics and validation reports"
      status: "[passed/failed/pending]"
      evidence_location: "[where evidence is stored]"
      
  individual_agent_validation:
    - agent_id: "[agent_identifier]"
      validation_criteria:
        - criterion: "TDD cycle completed with evidence"
          status: "[passed/failed/pending]"
          evidence: "[evidence location]"
        - criterion: "BDD scenarios implemented correctly"
          status: "[passed/failed/pending]"
          evidence: "[evidence location]"
        - criterion: "Quality gates passed"
          status: "[passed/failed/pending]"
          evidence: "[evidence location]"
        - criterion: "Integration compatibility confirmed"
          status: "[passed/failed/pending]"
          evidence: "[evidence location]"
          
  cross_agent_validation:
    - validation_type: "Compatibility validation"
      agents_involved: "[list of agents]"
      validation_result: "[passed/failed/pending]"
      evidence_location: "[where validation evidence is stored]"
      
    - validation_type: "Quality consistency validation"
      consistency_result: "[consistent/inconsistent]"
      evidence_location: "[where consistency evidence is stored]"
      
  system_integration_validation:
    - integration_test: "End-to-end system functionality"
      test_result: "[passed/failed/pending]"
      evidence_location: "[where integration evidence is stored]"
      
    - regression_test: "Existing functionality preservation"
      test_result: "[passed/failed/pending]"
      evidence_location: "[where regression evidence is stored]"
      
  evidence_completeness_validation:
    - evidence_category: "TDD Evidence"
      completeness_status: "[complete/incomplete]"
      missing_elements: "[list any missing evidence]"
      
    - evidence_category: "BDD Evidence"
      completeness_status: "[complete/incomplete]"
      missing_elements: "[list any missing evidence]"
      
    - evidence_category: "Quality Evidence"
      completeness_status: "[complete/incomplete]"
      missing_elements: "[list any missing evidence]"
      
    - evidence_category: "Integration Evidence"
      completeness_status: "[complete/incomplete]"
      missing_elements: "[list any missing evidence]"
```

## Usage Instructions

### How to Use This Template

1. **Pre-Execution Planning**:
   - Fill out the BDD Scenario section with your specific system requirements
   - Complete the Agent Assignment Matrix with your specific agents and tasks
   - Customize the success criteria and evidence requirements

2. **Agent Deployment**:
   - Use the Standard Agent Deployment Message template for each agent
   - Customize the task specification, TDD/BDD requirements, and evidence requirements
   - Ensure coordination instructions are clear and specific

3. **Execution Monitoring**:
   - Use the Real-Time Status Tracking template to monitor progress
   - Update status regularly and track evidence collection
   - Monitor for blocking issues and quality gate compliance

4. **Evidence Collection**:
   - Use the Agent Evidence Package Template for each agent
   - Use the Cross-Agent Validation Evidence Template for integration validation
   - Ensure all evidence requirements are met before proceeding

5. **Success Validation**:
   - Use the Success Validation Checklist to verify complete system success
   - Validate all criteria are met before considering the task complete
   - Document any issues and their resolutions

### Customization Guidelines

- Replace all placeholder text in [brackets] with specific values for your use case
- Adjust quality criteria and evidence requirements based on your domain
- Modify the BDD scenarios to match your specific system behavior requirements
- Adapt the monitoring frequency and reporting requirements to your timeline
- Customize the success validation criteria to match your quality standards

---

**Template Version**: 1.0
**Last Updated**: 2025-08-20
**Compatibility**: Works with Agent Coordination TDD Workflow, Parallel Agent Coordination Workflow, and Strategic Orchestration Workflow