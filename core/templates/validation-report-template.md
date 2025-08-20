---

**IF creating validation reports** → READ [evidence-patterns.md](../standards/evidence-patterns.md) for evidence collection standards, THEN use this template for systematic validation reporting


# Validation Report Template

**Context**: Standardized template for validation reporting with integrated TDD/BDD methodology and evidence-based validation

---

This template ensures consistent, comprehensive validation reporting that integrates Given-When-Then scenarios, Red-Green-Refactor cycles, and evidence-based quality validation.

## Report Metadata

```yaml
validation_report:
  report_id: "VR-YYYYMMDD-HHMMSS"
  work_type: [code|documentation|testing|research|integration]
  work_item_id: "[ticket/issue/feature identifier]"
  validator: "[name/role]"
  validation_date: "YYYY-MM-DD HH:MM:SS"
  validation_environment: "[development|staging|production]"
  framework_version: "[TDD/BDD framework version]"
  evidence_location: "[path to evidence directory]"
```

---

## Executive Summary

### Validation Outcome
- **Overall Status**: [PASS|FAIL|CONDITIONAL_PASS|BLOCKED]
- **Quality Gate Compliance**: [X/Y gates passed]
- **Critical Issues**: [count of blocking issues]
- **Recommendation**: [APPROVE|REJECT|REQUIRES_REWORK|CONDITIONAL_APPROVAL]

### Key Metrics Summary
```yaml
metrics_summary:
  test_coverage: "XX.X%"
  defect_density: "X.X defects/KLOC"
  performance_impact: "+/-X.X%"
  documentation_completeness: "XX.X%"
  quality_score: "XX.X/100"
```

---

## BDD Scenario Validation

### Primary Business Scenario
```gherkin
Feature: [Feature/Work Item Name]
  As a [user/role]
  I want [capability/feature]
  So that [business value/outcome]

Scenario: [Primary Success Scenario]
  Given [initial system state/context]
  When [user action/trigger event]
  Then [expected system behavior/outcome]
  And [additional success criteria]
  But [constraints/limitations]

Validation Result: [PASS|FAIL|PARTIAL]
Evidence: [link to supporting evidence]
Notes: [any relevant observations]
```

### Alternative Scenarios
```gherkin
Scenario Outline: [Edge Cases/Alternative Paths]
  Given [context with variables]
  When [action with <parameters>]
  Then [expected outcome with <results>]

Examples:
  | parameters | results   | validation_status |
  | value1     | result1   | PASS             |
  | value2     | result2   | PASS             |
  | value3     | result3   | FAIL             |
```

### Error Scenarios
```gherkin
Scenario: [Error Handling Validation]
  Given [system in error-prone state]
  When [error condition occurs]
  Then [system should handle error gracefully]
  And [user should receive appropriate feedback]
  And [system should recover/maintain stability]

Validation Result: [PASS|FAIL]
Evidence: [error logs, recovery evidence]
```

---

## TDD Cycle Validation

### Red Phase Validation
```yaml
red_phase:
  description: "Failing tests written before implementation"
  status: [COMPLETE|INCOMPLETE|NOT_APPLICABLE]
  evidence:
    - test_files: ["list of test files created"]
    - failing_test_output: "path/to/red-phase-results.log"
    - requirement_traceability: "mapping of tests to requirements"
  validation:
    tests_fail_as_expected: [true|false]
    tests_cover_acceptance_criteria: [true|false]
    test_design_quality: [good|adequate|poor]
  notes: "Observations about test design and failure modes"
```

### Green Phase Validation
```yaml
green_phase:
  description: "Implementation makes tests pass"
  status: [COMPLETE|INCOMPLETE|NOT_APPLICABLE]
  evidence:
    - implementation_files: ["list of implementation files"]
    - passing_test_output: "path/to/green-phase-results.log"
    - code_coverage_report: "path/to/coverage-report.html"
  validation:
    all_tests_pass: [true|false]
    implementation_minimal: [true|false]
    no_over_engineering: [true|false]
    coverage_targets_met: [true|false]
  metrics:
    test_coverage_percentage: "XX.X%"
    new_code_coverage: "XX.X%"
    regression_test_status: "PASS|FAIL"
  notes: "Implementation approach and design decisions"
```

### Refactor Phase Validation
```yaml
refactor_phase:
  description: "Code improvement while maintaining functionality"
  status: [COMPLETE|INCOMPLETE|NOT_APPLICABLE]
  evidence:
    - refactored_files: ["list of files modified during refactoring"]
    - code_quality_before: "path/to/pre-refactor-metrics.json"
    - code_quality_after: "path/to/post-refactor-metrics.json"
    - continuous_test_results: "path/to/refactor-test-validation.log"
  validation:
    all_tests_still_pass: [true|false]
    code_quality_improved: [true|false]
    performance_maintained_or_improved: [true|false]
    no_new_technical_debt: [true|false]
  metrics:
    cyclomatic_complexity_change: "+/-X.X"
    code_duplication_change: "+/-X.X%"
    maintainability_index_change: "+/-X.X"
    performance_impact: "+/-X.X%"
  notes: "Refactoring rationale and impact assessment"
```

---

## Quality Gate Validation

### Code Quality Gates
```yaml
code_quality:
  test_coverage:
    threshold: "90%"
    actual: "XX.X%"
    status: [PASS|FAIL]
    evidence: "path/to/coverage-report"
  
  code_complexity:
    threshold: "<10 cyclomatic complexity"
    violations: X
    status: [PASS|FAIL]
    evidence: "path/to/complexity-analysis"
  
  static_analysis:
    critical_issues: X
    major_issues: X
    status: [PASS|FAIL]
    evidence: "path/to/static-analysis-report"
  
  code_review:
    reviewer: "[reviewer name]"
    approval_status: [APPROVED|REJECTED|CONDITIONAL]
    evidence: "link/to/code-review"
```

### Process Quality Gates
```yaml
process_quality:
  documentation:
    completeness: "XX.X%"
    accuracy_verified: [true|false]
    status: [PASS|FAIL]
    evidence: "path/to/documentation-validation"
  
  workflow_compliance:
    tdd_process_followed: [true|false]
    bdd_scenarios_validated: [true|false]
    evidence_collected: [true|false]
    status: [PASS|FAIL]
  
  integration_testing:
    api_endpoints_tested: "XX/YY"
    integration_scenarios_passed: "XX/YY"
    status: [PASS|FAIL]
    evidence: "path/to/integration-test-results"
```

### Performance Quality Gates
```yaml
performance_quality:
  response_time:
    threshold: "<XXXms"
    actual: "XXXms"
    status: [PASS|FAIL]
    evidence: "path/to/performance-test-results"
  
  resource_usage:
    memory_threshold: "<XXX MB"
    actual_memory: "XXX MB"
    cpu_threshold: "<XX%"
    actual_cpu: "XX%"
    status: [PASS|FAIL]
    evidence: "path/to/resource-monitoring"
  
  scalability:
    concurrent_users_tested: X
    performance_degradation: "X.X%"
    status: [PASS|FAIL]
    evidence: "path/to/load-test-results"
```

---

## Evidence Summary

### Evidence Collection Status
```yaml
evidence_collection:
  total_evidence_items: X
  collected_items: X
  validated_items: X
  missing_items: X
  collection_completeness: "XX.X%"
  
evidence_types:
  - type: "test_execution_results"
    status: [COLLECTED|MISSING|INVALID]
    location: "path/to/evidence"
    validator: "[validator name]"
  
  - type: "code_coverage_reports"
    status: [COLLECTED|MISSING|INVALID]
    location: "path/to/evidence"
    validator: "[validator name]"
  
  - type: "performance_benchmarks"
    status: [COLLECTED|MISSING|INVALID]
    location: "path/to/evidence"
    validator: "[validator name]"
```

### Evidence Quality Assessment
```yaml
evidence_quality:
  completeness: "XX.X%"
  accuracy: "XX.X%"
  reproducibility: [VERIFIED|NOT_VERIFIED|FAILED]
  traceability: [COMPLETE|PARTIAL|MISSING]
  independence: [VERIFIED|SELF_VALIDATED|UNVERIFIED]
  
quality_issues:
  - issue: "Description of evidence quality issue"
    severity: [HIGH|MEDIUM|LOW]
    impact: "Impact on validation reliability"
    recommendation: "How to address the issue"
```

---

## Risk Assessment

### Technical Risks
```yaml
technical_risks:
  - risk: "[Risk description]"
    probability: [HIGH|MEDIUM|LOW]
    impact: [HIGH|MEDIUM|LOW]
    mitigation: "[Mitigation strategy]"
    status: [MITIGATED|ACCEPTED|MONITORING]
    evidence: "[Evidence of mitigation]"
```

### Process Risks
```yaml
process_risks:
  - risk: "[Process risk description]"
    probability: [HIGH|MEDIUM|LOW]
    impact: [HIGH|MEDIUM|LOW]
    mitigation: "[Mitigation approach]"
    status: [MITIGATED|ACCEPTED|MONITORING]
    evidence: "[Evidence of process controls]"
```

### Quality Risks
```yaml
quality_risks:
  - risk: "[Quality risk description]"
    probability: [HIGH|MEDIUM|LOW]
    impact: [HIGH|MEDIUM|LOW]
    mitigation: "[Quality assurance measures]"
    status: [MITIGATED|ACCEPTED|MONITORING]
    evidence: "[Evidence of quality controls]"
```

---

## Detailed Findings

### Successful Validations
```markdown
#### [Validation Category]
- **What was validated**: [Specific item validated]
- **Method**: [How validation was performed]
- **Result**: [Specific outcome]
- **Evidence**: [Location/link to supporting evidence]
- **Significance**: [Why this validation is important]

#### [Another Validation Category]
- **What was validated**: [Specific item validated]
- **Method**: [How validation was performed]
- **Result**: [Specific outcome]
- **Evidence**: [Location/link to supporting evidence]
- **Significance**: [Why this validation is important]
```

### Failed Validations
```markdown
#### [Failed Validation]
- **What failed**: [Specific failure]
- **Expected**: [What was expected]
- **Actual**: [What actually occurred]
- **Root cause**: [Analysis of why it failed]
- **Evidence**: [Location/link to failure evidence]
- **Impact**: [Effect on overall validation]
- **Remediation**: [Steps to address the failure]
```

### Conditional Passes
```markdown
#### [Conditional Pass]
- **What passed conditionally**: [Specific item]
- **Conditions**: [What conditions must be met]
- **Risk if conditions not met**: [Potential impact]
- **Monitoring required**: [What needs to be watched]
- **Evidence**: [Location/link to conditional evidence]
- **Timeline**: [When conditions must be resolved]
```

---

## Recommendations

### Immediate Actions Required
```yaml
immediate_actions:
  - action: "[Specific action needed]"
    priority: [CRITICAL|HIGH|MEDIUM]
    assignee: "[Who should do this]"
    deadline: "YYYY-MM-DD"
    success_criteria: "[How to know it's done]"
    
  - action: "[Another action needed]"
    priority: [CRITICAL|HIGH|MEDIUM]
    assignee: "[Who should do this]"
    deadline: "YYYY-MM-DD"
    success_criteria: "[How to know it's done]"
```

### Process Improvements
```yaml
process_improvements:
  - improvement: "[Process improvement suggestion]"
    rationale: "[Why this improvement is needed]"
    effort: [HIGH|MEDIUM|LOW]
    impact: [HIGH|MEDIUM|LOW]
    timeline: "[Suggested implementation timeline]"
    
  - improvement: "[Another improvement suggestion]"
    rationale: "[Why this improvement is needed]"
    effort: [HIGH|MEDIUM|LOW]
    impact: [HIGH|MEDIUM|LOW]
    timeline: "[Suggested implementation timeline]"
```

### Future Considerations
```yaml
future_considerations:
  - consideration: "[Long-term consideration]"
    description: "[Detailed description]"
    benefits: "[Expected benefits]"
    challenges: "[Potential challenges]"
    timeline: "[When to consider this]"
```

---

## Approval and Sign-off

### Validation Team Sign-off
```yaml
validation_team:
  - role: "Test Lead"
    name: "[Name]"
    status: [APPROVED|REJECTED|CONDITIONAL]
    date: "YYYY-MM-DD"
    comments: "[Any specific comments]"
    
  - role: "Technical Lead"
    name: "[Name]"
    status: [APPROVED|REJECTED|CONDITIONAL]
    date: "YYYY-MM-DD"
    comments: "[Any specific comments]"
    
  - role: "Quality Assurance"
    name: "[Name]"
    status: [APPROVED|REJECTED|CONDITIONAL]
    date: "YYYY-MM-DD"
    comments: "[Any specific comments]"
```

### Stakeholder Approval
```yaml
stakeholder_approval:
  - role: "Product Owner"
    name: "[Name]"
    status: [APPROVED|REJECTED|CONDITIONAL]
    date: "YYYY-MM-DD"
    comments: "[Business perspective comments]"
    
  - role: "Architecture Review"
    name: "[Name]"
    status: [APPROVED|REJECTED|CONDITIONAL]
    date: "YYYY-MM-DD"
    comments: "[Technical architecture comments]"
```

### Final Validation Decision
```yaml
final_decision:
  overall_status: [APPROVED|REJECTED|CONDITIONAL_APPROVAL]
  decision_date: "YYYY-MM-DD HH:MM:SS"
  decision_maker: "[Name/Role]"
  rationale: "[Key reasons for the decision]"
  conditions: "[Any conditions that must be met]"
  next_steps: "[What happens next]"
  
report_distribution:
  - "[Stakeholder 1]"
  - "[Stakeholder 2]"
  - "[Project archive location]"
```

---

## Appendices

### Appendix A: Evidence Inventory
```
evidence/
├── requirements/
│   ├── acceptance-criteria.md
│   └── success-metrics.yml
├── implementation/
│   ├── red-phase/
│   │   ├── failing-tests.log
│   │   └── test-coverage-baseline.html
│   ├── green-phase/
│   │   ├── passing-tests.log
│   │   ├── implementation.diff
│   │   └── coverage-improvement.html
│   └── refactor-phase/
│       ├── quality-metrics-before.json
│       ├── quality-metrics-after.json
│       └── refactor-validation.log
├── validation/
│   ├── test-results/
│   ├── quality-metrics/
│   └── integration-evidence/
└── documentation/
    ├── screenshots/
    ├── logs/
    └── reports/
```

### Appendix B: Tool and Environment Details
```yaml
validation_environment:
  operating_system: "[OS version]"
  testing_framework: "[Framework and version]"
  build_tools: ["tool1 v.x.x", "tool2 v.x.x"]
  ci_cd_pipeline: "[Pipeline identifier]"
  test_data: "[Test data source and version]"
  
validation_tools:
  - tool: "[Tool name]"
    version: "x.x.x"
    purpose: "[What it was used for]"
    configuration: "[Key configuration details]"
```

### Appendix C: References and Standards
```yaml
standards_compliance:
  - standard: "[Standard name]"
    version: "[Version]"
    compliance_level: [FULL|PARTIAL|NOT_APPLICABLE]
    deviations: "[Any deviations and justifications]"
    
references:
  - reference: "[Reference title]"
    source: "[Source/URL]"
    relevance: "[How it relates to this validation]"
```

---

**Validate systematically. Report comprehensively. Decide confidently.**