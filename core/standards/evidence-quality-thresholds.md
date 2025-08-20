---

**IF setting evidence thresholds** → READ [quality-gates-metrics.md](quality-gates-metrics.md) for base quality gates, THEN apply these evidence-specific thresholds and Red-Green-Refactor validation patterns


# Evidence Quality Thresholds and TDD/BDD Integration

**Context**: Comprehensive evidence quality thresholds with Red-Green-Refactor patterns and BDD scenario validation requirements

---

These thresholds define minimum evidence quality standards that integrate with TDD/BDD workflows, ensuring systematic validation through Given-When-Then scenarios and Red-Green-Refactor cycles.

## Evidence Quality Gate Framework

### Core Evidence Quality Principles
- **Completeness Threshold**: 95% of required evidence types collected
- **Accuracy Threshold**: 98% of evidence independently verifiable
- **Traceability Threshold**: 100% evidence linked to requirements
- **Timeliness Threshold**: Evidence collected within 24 hours of activity
- **Consistency Threshold**: 90% adherence to formatting standards

### TDD Phase Evidence Requirements
```yaml
tdd_phase_evidence_gates:
  red_phase:
    minimum_evidence_types: 4
    required_evidence:
      - failing_test_output: "MANDATORY"
      - test_coverage_baseline: "MANDATORY"
      - requirement_traceability: "MANDATORY"
      - environment_configuration: "RECOMMENDED"
    quality_thresholds:
      evidence_completeness: 100%  # No exceptions for Red phase
      test_failure_clarity: 95%    # Test failures must be clear
      traceability_coverage: 100%  # All tests linked to requirements
    
  green_phase:
    minimum_evidence_types: 6
    required_evidence:
      - passing_test_output: "MANDATORY"
      - implementation_diff: "MANDATORY"
      - coverage_improvement: "MANDATORY"
      - performance_baseline: "RECOMMENDED"
      - integration_validation: "RECOMMENDED"
      - code_quality_metrics: "RECOMMENDED"
    quality_thresholds:
      evidence_completeness: 95%   # Allow minor gaps in Green phase
      test_pass_rate: 100%         # All tests must pass
      coverage_improvement: ">= 2%" # Must improve coverage
      implementation_minimality: 90% # Avoid over-engineering
    
  refactor_phase:
    minimum_evidence_types: 5
    required_evidence:
      - continuous_test_validation: "MANDATORY"
      - quality_metrics_comparison: "MANDATORY"
      - performance_impact_analysis: "MANDATORY"
      - refactoring_safety_evidence: "RECOMMENDED"
      - technical_debt_reduction: "RECOMMENDED"
    quality_thresholds:
      evidence_completeness: 90%   # Flexibility for refactoring
      test_stability: 100%         # No test failures during refactor
      quality_improvement: ">= 5%" # Measurable quality gains
      performance_maintenance: ">= 0%" # No performance regression
```

---

## BDD Evidence Quality Thresholds

### Scenario Evidence Requirements
```yaml
bdd_scenario_evidence_gates:
  scenario_definition:
    minimum_evidence_types: 3
    required_evidence:
      - given_when_then_structure: "MANDATORY"
      - acceptance_criteria_mapping: "MANDATORY"
      - stakeholder_validation: "MANDATORY"
    quality_thresholds:
      scenario_clarity_score: ">= 85%"
      stakeholder_comprehension: ">= 90%"
      technical_implementability: ">= 95%"
      
  scenario_execution:
    minimum_evidence_types: 4
    required_evidence:
      - execution_logs: "MANDATORY"
      - step_validation_results: "MANDATORY"
      - expected_vs_actual_comparison: "MANDATORY"
      - error_handling_evidence: "RECOMMENDED"
    quality_thresholds:
      execution_success_rate: ">= 95%"
      step_traceability: "100%"
      error_recovery_validation: ">= 80%"
      
  scenario_maintenance:
    minimum_evidence_types: 3
    required_evidence:
      - scenario_update_history: "MANDATORY"
      - regression_test_results: "MANDATORY"
      - impact_analysis: "RECOMMENDED"
    quality_thresholds:
      scenario_currency: "<= 30 days since last review"
      regression_pass_rate: "100%"
      change_impact_assessment: ">= 90%"
```

---

## Work Type Evidence Thresholds

### Code Implementation Evidence Thresholds
```yaml
code_implementation_evidence:
  red_phase_thresholds:
    test_failure_evidence:
      threshold: "100% of new functionality has failing tests"
      measurement: "Percentage of features with pre-written failing tests"
      quality_gate: "BLOCKING - Cannot proceed without failing tests"
      evidence_types:
        - test_execution_logs: "MANDATORY"
        - code_coverage_baseline: "MANDATORY"
        - test_case_traceability: "MANDATORY"
      
    requirement_validation:
      threshold: "100% of tests trace to specific requirements"
      measurement: "Percentage of tests with requirement linkage"
      quality_gate: "BLOCKING - Cannot proceed without traceability"
      evidence_types:
        - requirement_test_matrix: "MANDATORY"
        - acceptance_criteria_mapping: "MANDATORY"
        
  green_phase_thresholds:
    implementation_evidence:
      threshold: "100% of tests pass with minimal implementation"
      measurement: "Test pass rate and implementation complexity"
      quality_gate: "BLOCKING - All tests must pass"
      evidence_types:
        - test_execution_results: "MANDATORY"
        - code_diff_analysis: "MANDATORY"
        - implementation_review: "RECOMMENDED"
        
    coverage_improvement:
      threshold: "Coverage increases by >= 2% or reaches >= 90%"
      measurement: "Line and branch coverage percentage change"
      quality_gate: "WARNING - Should improve coverage"
      evidence_types:
        - coverage_reports_comparison: "MANDATORY"
        - uncovered_code_analysis: "RECOMMENDED"
        
  refactor_phase_thresholds:
    quality_improvement:
      threshold: "Code quality metrics improve by >= 5%"
      measurement: "Composite quality score improvement"
      quality_gate: "ADVISORY - Should show measurable improvement"
      evidence_types:
        - quality_metrics_before_after: "MANDATORY"
        - refactoring_impact_analysis: "MANDATORY"
        
    test_stability:
      threshold: "100% test pass rate maintained during refactoring"
      measurement: "Test execution success rate"
      quality_gate: "BLOCKING - Tests must remain stable"
      evidence_types:
        - continuous_test_execution: "MANDATORY"
        - regression_test_validation: "MANDATORY"
```

### Documentation Evidence Thresholds
```yaml
documentation_evidence:
  accuracy_validation:
    fresh_environment_testing:
      threshold: "100% of procedures work in clean environment"
      measurement: "Successful execution rate of documented procedures"
      quality_gate: "BLOCKING - Documentation must be executable"
      evidence_types:
        - clean_environment_test_log: "MANDATORY"
        - step_by_step_validation: "MANDATORY"
        - error_reproduction_testing: "RECOMMENDED"
        
    screenshot_validation:
      threshold: "95% of UI elements match current implementation"
      measurement: "Visual accuracy of screenshots vs current UI"
      quality_gate: "WARNING - Screenshots should be current"
      evidence_types:
        - current_vs_documented_comparison: "MANDATORY"
        - ui_change_impact_analysis: "RECOMMENDED"
        
  usability_validation:
    user_testing_evidence:
      threshold: "90% of users complete tasks successfully"
      measurement: "Task completion rate in user testing"
      quality_gate: "ADVISORY - Should validate with real users"
      evidence_types:
        - user_testing_session_logs: "MANDATORY"
        - task_completion_metrics: "MANDATORY"
        - user_feedback_analysis: "RECOMMENDED"
        
    completion_time_analysis:
      threshold: "Tasks completed within expected time + 25%"
      measurement: "Actual vs expected task completion time"
      quality_gate: "WARNING - Tasks should be reasonably efficient"
      evidence_types:
        - time_tracking_data: "MANDATORY"
        - efficiency_benchmark_comparison: "RECOMMENDED"
```

### Testing Evidence Thresholds
```yaml
testing_evidence:
  test_execution_evidence:
    pass_rate_threshold:
      threshold: "95% pass rate for automated tests"
      measurement: "Percentage of automated tests passing"
      quality_gate: "BLOCKING - High test pass rate required"
      evidence_types:
        - test_execution_reports: "MANDATORY"
        - failure_analysis_reports: "MANDATORY"
        - test_trend_analysis: "RECOMMENDED"
        
    coverage_validation:
      threshold: "90% code coverage for critical paths"
      measurement: "Code coverage percentage for business logic"
      quality_gate: "BLOCKING - Critical paths must be covered"
      evidence_types:
        - coverage_reports_detailed: "MANDATORY"
        - critical_path_analysis: "MANDATORY"
        - gap_analysis_report: "RECOMMENDED"
        
  performance_testing:
    response_time_validation:
      threshold: "95th percentile response time <= 200ms"
      measurement: "Response time distribution analysis"
      quality_gate: "WARNING - Performance requirements should be met"
      evidence_types:
        - performance_test_results: "MANDATORY"
        - load_testing_analysis: "MANDATORY"
        - scalability_assessment: "RECOMMENDED"
        
    resource_utilization:
      threshold: "Peak resource usage <= 80% of available capacity"
      measurement: "CPU, memory, and I/O utilization percentages"
      quality_gate: "ADVISORY - Should maintain resource headroom"
      evidence_types:
        - resource_monitoring_data: "MANDATORY"
        - capacity_planning_analysis: "RECOMMENDED"
```

### Research Evidence Thresholds
```yaml
research_evidence:
  source_validation:
    credibility_assessment:
      threshold: "80% of sources are authoritative (peer-reviewed, expert)"
      measurement: "Percentage of sources meeting credibility criteria"
      quality_gate: "WARNING - Sources should be credible"
      evidence_types:
        - source_credibility_matrix: "MANDATORY"
        - author_expertise_validation: "RECOMMENDED"
        
    currency_validation:
      threshold: "70% of sources published within last 2 years"
      measurement: "Percentage of recent sources in research"
      quality_gate: "ADVISORY - Should use current information"
      evidence_types:
        - source_publication_analysis: "MANDATORY"
        - technology_currency_assessment: "RECOMMENDED"
        
  validation_evidence:
    proof_of_concept:
      threshold: "Key recommendations validated through POC"
      measurement: "Percentage of recommendations with POC validation"
      quality_gate: "BLOCKING - Critical recommendations need validation"
      evidence_types:
        - poc_implementation_results: "MANDATORY"
        - feasibility_analysis: "MANDATORY"
        - risk_assessment: "RECOMMENDED"
        
    expert_consultation:
      threshold: "Major decisions validated by subject matter expert"
      measurement: "Percentage of critical decisions with expert input"
      quality_gate: "WARNING - Expert validation recommended"
      evidence_types:
        - expert_consultation_notes: "MANDATORY"
        - decision_validation_matrix: "RECOMMENDED"
```

---

## Evidence Collection Automation Thresholds

### Automation Coverage Requirements
```yaml
automation_thresholds:
  automated_evidence_collection:
    threshold: "80% of evidence collected through automated tools"
    measurement: "Percentage of evidence items with automated collection"
    quality_gate: "ADVISORY - Automation improves consistency"
    evidence_types:
      - automation_coverage_report: "MANDATORY"
      - manual_vs_automated_analysis: "RECOMMENDED"
      
  evidence_validation_automation:
    threshold: "70% of evidence validated through automated checks"
    measurement: "Percentage of evidence with automated validation"
    quality_gate: "ADVISORY - Automation reduces validation errors"
    evidence_types:
      - validation_automation_report: "MANDATORY"
      - validation_accuracy_metrics: "RECOMMENDED"
      
  continuous_monitoring:
    threshold: "90% of quality gates monitored continuously"
    measurement: "Percentage of gates with continuous monitoring"
    quality_gate: "WARNING - Continuous monitoring prevents issues"
    evidence_types:
      - monitoring_coverage_analysis: "MANDATORY"
      - alert_effectiveness_metrics: "RECOMMENDED"
```

---

## Quality Gate Enforcement Levels

### Evidence Quality Enforcement Matrix
```yaml
enforcement_levels:
  BLOCKING:
    description: "Work cannot proceed without meeting threshold"
    threshold_violations: "0 allowed"
    escalation: "Immediate stop-work until resolved"
    examples:
      - "100% test pass rate in Green phase"
      - "100% traceability in Red phase"
      - "100% critical path coverage"
      
  WARNING:
    description: "Work can proceed but requires explicit approval"
    threshold_violations: "<= 2 allowed with justification"
    escalation: "Requires lead approval and remediation plan"
    examples:
      - "95% documentation accuracy"
      - "90% user task completion rate"
      - "Performance requirements"
      
  ADVISORY:
    description: "Best practice recommendation, tracked but not enforced"
    threshold_violations: "Unlimited but tracked for trends"
    escalation: "Reported in quality dashboards"
    examples:
      - "80% automated evidence collection"
      - "Code quality improvement recommendations"
      - "Research source currency"
```

### Threshold Adjustment Criteria
```yaml
threshold_adjustment:
  criteria_for_raising_thresholds:
    - "Team consistently exceeds current thresholds by >= 10%"
    - "Industry best practices evolve beyond current thresholds"
    - "Risk profile of project increases significantly"
    - "Quality incidents indicate insufficient rigor"
    
  criteria_for_lowering_thresholds:
    - "Team consistently fails to meet thresholds despite effort"
    - "Technical constraints make thresholds impractical"
    - "Cost-benefit analysis shows diminishing returns"
    - "External dependencies limit achievable quality"
    
  adjustment_process:
    1. "Collect 30 days of baseline performance data"
    2. "Analyze threshold violation patterns and causes"
    3. "Propose threshold adjustments with justification"
    4. "Get stakeholder approval for threshold changes"
    5. "Implement gradual threshold transitions (10% per sprint)"
    6. "Monitor impact and adjust as needed"
```

---

## Red-Green-Refactor Quality Patterns

### TDD Cycle Quality Validation
```yaml
red_green_refactor_patterns:
  red_phase_quality_pattern:
    entry_criteria:
      - "Clear requirement or user story defined"
      - "Acceptance criteria documented"
      - "Test environment available and stable"
      
    quality_activities:
      - "Write failing test that captures requirement"
      - "Verify test fails for expected reason"
      - "Collect baseline coverage and quality metrics"
      - "Document test-to-requirement traceability"
      
    exit_criteria:
      - "Test fails with clear, expected error message"
      - "Test covers acceptance criteria completely"
      - "Test is isolated and deterministic"
      - "Evidence collected meets Red phase thresholds"
      
    evidence_quality_gates:
      - gate: "Test failure clarity"
        threshold: "95% of developers understand failure reason"
        evidence: "Test execution logs with clear error messages"
        
      - gate: "Requirement coverage"
        threshold: "100% of acceptance criteria covered by tests"
        evidence: "Traceability matrix linking tests to criteria"
        
  green_phase_quality_pattern:
    entry_criteria:
      - "Red phase completed with failing tests"
      - "Clear understanding of minimal implementation needed"
      - "Refactoring scope defined (if needed)"
      
    quality_activities:
      - "Implement minimal code to make tests pass"
      - "Verify all tests pass without modifying test code"
      - "Measure code coverage improvement"
      - "Validate integration with existing system"
      
    exit_criteria:
      - "100% of newly written tests pass"
      - "All existing tests continue to pass"
      - "Code coverage meets or exceeds targets"
      - "Implementation is minimal and focused"
      
    evidence_quality_gates:
      - gate: "Test pass rate"
        threshold: "100% of tests pass"
        evidence: "Test execution reports showing all green"
        
      - gate: "Implementation minimality"
        threshold: "No over-engineering detected in code review"
        evidence: "Code review comments and complexity analysis"
        
  refactor_phase_quality_pattern:
    entry_criteria:
      - "Green phase completed with passing tests"
      - "Code quality issues identified"
      - "Refactoring plan documented"
      
    quality_activities:
      - "Improve code structure while maintaining functionality"
      - "Run tests continuously during refactoring"
      - "Measure quality improvements"
      - "Validate performance impact"
      
    exit_criteria:
      - "All tests continue to pass"
      - "Code quality metrics improved measurably"
      - "No performance regression introduced"
      - "Technical debt reduced"
      
    evidence_quality_gates:
      - gate: "Test stability"
        threshold: "100% test pass rate maintained"
        evidence: "Continuous integration test results"
        
      - gate: "Quality improvement"
        threshold: "5% improvement in composite quality score"
        evidence: "Before/after quality metrics comparison"
```

---

## Evidence Threshold Monitoring and Reporting

### Continuous Threshold Monitoring
```yaml
monitoring_framework:
  real_time_monitoring:
    evidence_collection_rate:
      metric: "Evidence items collected per hour"
      threshold: ">= 80% of expected rate"
      alert: "Slack notification if rate drops below 60%"
      
    quality_gate_pass_rate:
      metric: "Percentage of quality gates passing"
      threshold: ">= 95% overall pass rate"
      alert: "Email notification if rate drops below 90%"
      
    evidence_validation_accuracy:
      metric: "Percentage of evidence passing validation"
      threshold: ">= 98% validation pass rate"
      alert: "Dashboard alert if rate drops below 95%"
      
  trend_analysis:
    quality_improvement_trend:
      metric: "Month-over-month quality score improvement"
      threshold: ">= 2% improvement per month"
      reporting: "Monthly quality report to stakeholders"
      
    automation_adoption_trend:
      metric: "Percentage of evidence collection automated"
      threshold: ">= 5% increase per quarter"
      reporting: "Quarterly automation report"
      
    threshold_violation_trend:
      metric: "Number of threshold violations per week"
      threshold: "<= 5 violations per week"
      reporting: "Weekly violation summary"
```

### Quality Dashboard Requirements
```yaml
dashboard_specifications:
  executive_dashboard:
    refresh_frequency: "Every 4 hours"
    key_metrics:
      - "Overall evidence quality score (0-100)"
      - "Quality gate pass rate percentage"
      - "Critical threshold violations count"
      - "TDD/BDD compliance percentage"
      - "Evidence automation coverage"
    
    alert_thresholds:
      - "Quality score drops below 80"
      - "Pass rate drops below 95%"
      - "Critical violations exceed 3"
      - "Compliance drops below 90%"
      
  operational_dashboard:
    refresh_frequency: "Every 15 minutes"
    detailed_metrics:
      - "Evidence collection status by type"
      - "TDD phase progression and quality"
      - "BDD scenario validation status"
      - "Real-time quality gate status"
      - "Evidence validation queue status"
    
    workflow_integration:
      - "Links to evidence repositories"
      - "Direct access to validation reports"
      - "Integration with CI/CD pipelines"
      - "Automated report generation"
```

---

**Measure systematically. Validate continuously. Improve relentlessly.**