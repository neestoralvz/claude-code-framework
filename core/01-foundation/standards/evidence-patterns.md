---

**IF seeking evidence standards** → READ [STANDARDS.md](../STANDARDS.md#strategic-quality-standards) for framework overview, THEN navigate here for evidence pattern definitions


# Evidence Patterns and Validation Framework

**Context**: Comprehensive evidence collection and validation patterns for all work types using TDD/BDD methodology integration

---

Evidence patterns define systematic approaches to collecting, validating, and presenting proof of work completion across all development activities through BDD scenarios and TDD validation cycles.

## Core Evidence Principles

### Every Action Requires Evidence
- **No Exceptions**: All work must produce verifiable evidence
- **BDD Integration**: Evidence collection follows Given-When-Then scenarios
- **TDD Validation**: Evidence must pass Red-Green-Refactor validation cycles
- **Reproducible**: Evidence must be independently verifiable
- **Traceable**: Evidence must link to requirements and acceptance criteria

### Evidence Quality Standards
- **Specific**: Evidence addresses exact requirements
- **Measurable**: Evidence includes quantifiable metrics
- **Achievable**: Evidence can be collected consistently
- **Relevant**: Evidence directly validates success criteria
- **Time-bound**: Evidence collection has defined timeframes

---

## Code Implementation Evidence Patterns

### BDD Scenario for Code Evidence
```gherkin
Feature: Code Implementation Evidence Collection
  As a developer implementing code changes
  I want systematic evidence collection patterns
  So that I can prove my implementation meets requirements

Scenario: Collecting Code Implementation Evidence
  Given I am implementing code changes for [feature/fix]
  When I complete each implementation phase
  Then I must collect evidence that includes:
    - Pre-implementation baseline tests
    - Red phase failing test evidence
    - Green phase passing test evidence
    - Refactor phase improvement evidence
    - Integration test validation
    - Performance impact measurements
  And all evidence must be traceable to acceptance criteria
```

### Required Code Evidence Types

#### 1. Test-Driven Evidence
```yaml
Red Phase Evidence:
  - failing_test_output: "Test execution showing expected failures"
  - test_coverage_baseline: "Coverage report before implementation"
  - requirement_traceability: "Link between failing tests and requirements"
  
Green Phase Evidence:
  - passing_test_output: "Test execution showing all tests pass"
  - implementation_diff: "Code changes that make tests pass"
  - coverage_improvement: "Coverage report showing increased coverage"
  
Refactor Phase Evidence:
  - code_quality_metrics: "Before/after quality measurements"
  - performance_benchmarks: "Performance impact analysis"
  - refactoring_safety: "Test suite validation after refactoring"
```

#### 2. Integration Evidence
```yaml
Integration Validation:
  - api_test_results: "API endpoint testing with request/response examples"
  - database_migration_logs: "Schema changes and migration success"
  - dependency_validation: "External service integration testing"
  - end_to_end_scenarios: "Complete user workflow validation"
```

#### 3. Code Quality Evidence
```yaml
Quality Metrics:
  - static_analysis_results: "Linting, complexity, security scanning results"
  - code_review_evidence: "Peer review comments and resolutions"
  - documentation_updates: "Updated code comments and documentation"
  - style_compliance: "Code formatting and style guide adherence"
```

### Code Evidence Collection Workflow
```bash
# Evidence Collection Script Template
#!/bin/bash
echo "=== Code Implementation Evidence Collection ==="

# Phase 1: Pre-implementation baseline
echo "1. Collecting baseline evidence..."
npm test -- --coverage > evidence/baseline_tests.log
git diff --stat > evidence/baseline_changes.diff

# Phase 2: Red phase evidence
echo "2. Collecting Red phase evidence..."
npm test -- --testNamePattern="new feature" > evidence/red_phase_tests.log

# Phase 3: Green phase evidence  
echo "3. Collecting Green phase evidence..."
npm test -- --coverage > evidence/green_phase_tests.log
git diff --stat > evidence/implementation_changes.diff

# Phase 4: Refactor evidence
echo "4. Collecting Refactor phase evidence..."
npm run lint > evidence/code_quality.log
npm run test:integration > evidence/integration_tests.log

echo "Evidence collection complete. Review evidence/ directory."
```

---

## Documentation Evidence Patterns

### BDD Scenario for Documentation Evidence
```gherkin
Feature: Documentation Evidence Collection
  As a technical writer updating documentation
  I want systematic evidence that documentation is accurate and useful
  So that users can successfully follow documentation

Scenario: Validating Documentation Accuracy
  Given I have updated documentation for [feature/process]
  When I validate the documentation accuracy
  Then I must provide evidence that includes:
    - Fresh environment testing following the documentation
    - Screenshots of each documented step
    - Error handling and troubleshooting validation
    - User feedback and usability testing
    - Cross-reference validation with code implementation
  And documentation must enable successful task completion
```

### Required Documentation Evidence Types

#### 1. Accuracy Validation Evidence
```yaml
Accuracy Testing:
  - fresh_environment_test: "Clean environment following documentation exactly"
  - step_by_step_screenshots: "Visual proof of each documented step"
  - command_execution_logs: "Terminal output showing successful command execution"
  - expected_vs_actual: "Comparison of documented outcomes vs actual results"
```

#### 2. Usability Evidence
```yaml
Usability Validation:
  - user_testing_session: "Real user following documentation with observations"
  - completion_time_metrics: "Time to complete documented tasks"
  - error_recovery_testing: "Validation of troubleshooting instructions"
  - accessibility_compliance: "Documentation accessibility for different skill levels"
```

#### 3. Maintenance Evidence
```yaml
Maintenance Validation:
  - version_compatibility: "Documentation tested with current software versions"
  - link_validation: "All links tested and confirmed working"
  - code_sync_validation: "Documentation matches current code implementation"
  - update_tracking: "Change log showing what was updated and why"
```

---

## Testing Evidence Patterns

### BDD Scenario for Testing Evidence
```gherkin
Feature: Testing Evidence Collection
  As a QA engineer executing test plans
  I want comprehensive evidence of testing activities
  So that I can prove system quality and identify defects

Scenario: Comprehensive Testing Evidence Collection
  Given I am executing testing for [system/feature]
  When I complete testing activities
  Then I must collect evidence that includes:
    - Test plan execution results with pass/fail status
    - Defect discovery and resolution evidence
    - Test environment configuration details
    - Test data management and cleanup evidence
    - Performance and load testing metrics
    - Security testing validation results
  And all evidence must support quality gate decisions
```

### Required Testing Evidence Types

#### 1. Functional Testing Evidence
```yaml
Functional Validation:
  - test_execution_reports: "Detailed test case execution with results"
  - boundary_testing_results: "Edge case and limit testing evidence"
  - error_handling_validation: "Negative testing and error path verification"
  - user_acceptance_testing: "Stakeholder validation and sign-off"
```

#### 2. Non-Functional Testing Evidence
```yaml
Performance Evidence:
  - load_testing_results: "System performance under expected load"
  - stress_testing_metrics: "System behavior under extreme conditions"
  - scalability_analysis: "Performance scaling characteristics"
  - resource_utilization: "CPU, memory, and storage usage patterns"

Security Evidence:
  - vulnerability_scanning: "Automated security scan results"
  - penetration_testing: "Manual security testing evidence"
  - access_control_validation: "Authentication and authorization testing"
  - data_protection_compliance: "Privacy and data handling validation"
```

#### 3. Test Environment Evidence
```yaml
Environment Management:
  - configuration_documentation: "Test environment setup and configuration"
  - data_management_logs: "Test data creation, usage, and cleanup"
  - environment_isolation: "Evidence of proper test environment isolation"
  - reproducibility_validation: "Evidence that tests can be repeated consistently"
```

---

## Research Evidence Patterns

### BDD Scenario for Research Evidence
```gherkin
Feature: Research Evidence Collection
  As a researcher investigating technical solutions
  I want systematic evidence collection for research activities
  So that I can make informed decisions based on validated findings

Scenario: Technical Research Evidence Collection
  Given I am researching [technology/approach/solution]
  When I complete research activities
  Then I must collect evidence that includes:
    - Source credibility and currency validation
    - Comparative analysis with quantified trade-offs
    - Proof-of-concept implementation results
    - Expert consultation and peer review
    - Decision criteria and scoring methodology
    - Implementation feasibility assessment
  And research must lead to actionable recommendations
```

### Required Research Evidence Types

#### 1. Source Validation Evidence
```yaml
Source Credibility:
  - author_expertise_verification: "Author credentials and industry recognition"
  - publication_quality_assessment: "Peer review status and publication reputation"
  - currency_validation: "Publication date and relevance to current technology"
  - bias_analysis: "Assessment of potential conflicts of interest or bias"
```

#### 2. Comparative Analysis Evidence
```yaml
Comparative Research:
  - decision_matrix: "Quantified comparison of alternatives with weighted criteria"
  - trade_off_analysis: "Detailed pros/cons with impact assessment"
  - cost_benefit_calculation: "Financial and resource impact analysis"
  - risk_assessment: "Identification and mitigation of implementation risks"
```

#### 3. Validation Evidence
```yaml
Research Validation:
  - proof_of_concept: "Working prototype or demonstration"
  - expert_consultation: "Input from recognized subject matter experts"
  - peer_review: "Independent review of research methodology and findings"
  - pilot_implementation: "Small-scale implementation with measured results"
```

---

## Evidence Integration Patterns

### Cross-Workflow Evidence Requirements

Every workflow must integrate evidence collection following these patterns:

#### 1. Evidence Chain Validation
```yaml
Traceability Requirements:
  - requirement_to_evidence: "Direct link from requirements to evidence"
  - evidence_to_outcome: "Clear connection between evidence and results"
  - decision_justification: "Evidence-based reasoning for all decisions"
  - audit_trail: "Complete history of evidence collection and analysis"
```

#### 2. Quality Gate Integration
```yaml
Gate Validation:
  - threshold_compliance: "Evidence meets defined quality thresholds"
  - completeness_verification: "All required evidence types collected"
  - independence_validation: "Evidence verified by independent parties"
  - reproducibility_confirmation: "Evidence can be reproduced by others"
```

### Evidence Storage and Management

#### Directory Structure
```
evidence/
├── YYYYMMDD-HHMMSS-[work-type]/
│   ├── requirements/
│   │   ├── acceptance-criteria.md
│   │   └── success-metrics.yml
│   ├── implementation/
│   │   ├── red-phase/
│   │   ├── green-phase/
│   │   └── refactor-phase/
│   ├── validation/
│   │   ├── test-results/
│   │   ├── quality-metrics/
│   │   └── integration-evidence/
│   └── documentation/
│       ├── screenshots/
│       ├── logs/
│       └── reports/
```

#### Evidence Metadata Standard
```yaml
evidence_metadata:
  work_type: [code|documentation|testing|research]
  collection_date: "YYYY-MM-DD HH:MM:SS"
  collector: "[name/role]"
  validation_status: [collected|reviewed|validated|approved]
  traceability:
    requirements: ["req-001", "req-002"]
    acceptance_criteria: ["ac-001", "ac-002"]
    quality_gates: ["gate-001", "gate-002"]
  evidence_types:
    - type: "test_execution"
      format: "json"
      location: "validation/test-results/"
    - type: "code_coverage"
      format: "html"
      location: "validation/quality-metrics/"
```

---

## Evidence Validation Checklist

### Pre-Collection Validation
- [ ] Evidence requirements clearly defined
- [ ] Collection tools and environment prepared
- [ ] Success criteria and thresholds established
- [ ] Traceability links documented

### Collection Validation
- [ ] Evidence collected according to defined patterns
- [ ] All required evidence types captured
- [ ] Evidence quality meets defined standards
- [ ] Metadata properly documented

### Post-Collection Validation
- [ ] Evidence independently verified
- [ ] Quality gates passed
- [ ] Traceability confirmed
- [ ] Evidence properly stored and cataloged

### Continuous Validation
- [ ] Evidence patterns regularly reviewed and updated
- [ ] Collection processes optimized based on feedback
- [ ] Integration with workflows validated
- [ ] Training and guidance materials updated

---

**Execute systematically. Validate thoroughly. Evidence everything.**