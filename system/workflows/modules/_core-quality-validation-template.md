# Universal Quality Validation Template

**USAGE**: Import this module into any workflow requiring systematic quality validation and mathematical success measurement.

## MATHEMATICAL SUCCESS CRITERIA TEMPLATE

### Standard Success Metrics Pattern
```markdown
## {Section Number}. Establish Success Criteria

### {Subsection Number}.1 Define Success Requirements
- Achieve {requirement-1} with {standard-1}
- Achieve {requirement-2} with {standard-2}
- Achieve {requirement-3} with {standard-3}
- Achieve {requirement-4} with {standard-4}
- Achieve {requirement-5} with {standard-5}

### {Subsection Number}.2 Set Success Metrics
Measure success using these calculations:
- **{Metric-Category-1}**: [{Metric-Description-1}] - Calculate as {mathematical-formula-1}
- **{Metric-Category-2}**: [{Metric-Description-2}] - Calculate as {mathematical-formula-2}
- **{Metric-Category-3}**: [{Metric-Description-3}] - Calculate as {mathematical-formula-3}
- **{Metric-Category-4}**: [{Metric-Description-4}] - Calculate as {mathematical-formula-4}
- **{Metric-Category-5}**: [{Metric-Description-5}] - Calculate as {mathematical-formula-5}
```

### Common Calculation Templates
```markdown
**Efficiency Calculations**:
- Calculate as actual_time <= target_time
- Calculate as completed_tasks / total_tasks * 100
- Calculate as (target_time - actual_time) / target_time * 100

**Quality Calculations**:
- Calculate as compliant_items / total_items * 100
- Calculate as passed_validations / total_validations * 100
- Calculate as quality_score >= minimum_threshold

**Completeness Calculations**:
- Calculate as delivered_components / required_components * 100
- Calculate as satisfied_criteria / total_criteria * 100
- Calculate as functional_features / planned_features * 100

**Optimization Calculations**:
- Calculate as (original_size - optimized_size) / original_size * 100
- Calculate as performance_improvement / baseline_performance * 100
- Calculate as (duplicates_removed / original_duplicates) * 100
```

## FOUR-STAGE VALIDATION FRAMEWORK

### Universal Validation Template
```markdown
## {Section Number}. Validate Complete Success

**Apply Universal Validation**: Follow four-gate validation methodology from [Universal Validation Workflow](../modules/wfl-validate-success.md) to verify {validation-target} and ensure quality standards.

### Four-Stage Success Verification

#### Stage 1: Requirements Validation
**Verify completeness:**
- Confirm you delivered everything requested for {deliverable-area}
- Check that all {requirement-type} requirements are fully met
- Verify stakeholders accept your {output-type} work
- Ensure you stayed within {boundary-type} boundaries

**Verify quality:**
- Test that {function-area} functions work properly
- Confirm {performance-area} performance meets expectations
- Check {security-area} requirements are satisfied
- Validate {experience-area} experience meets standards

#### Stage 2: Process Validation
**Verify you followed proper methods:**
- Confirm you followed the correct {workflow-type} workflow
- Check that all {quality-checkpoint-type} quality checkpoints passed
- Verify you documented your {documentation-area} work properly
- Ensure you applied {standard-type} engineering standards

**Verify execution quality:**
- Confirm you completed every required {step-type} step
- Check {integration-area} systems work together properly
- Verify {error-handling-area} error handling works correctly
- Test {recovery-area} backup and recovery procedures

#### Stage 3: Output Validation
**Verify deliverable quality:**
- Test {output-accuracy-area} accuracy and correctness
- Confirm all {component-type} components are delivered
- Check {consistency-area} internal consistency throughout
- Verify compatibility with existing {system-type} systems

**Collect evidence:**
- Run automated tests for {proof-area} proof
- Perform manual quality checks on {check-area}
- Get independent review confirmation for {review-area}
- Document all {validation-evidence-area} validation results

#### Stage 4: System Integration Validation
**Verify ecosystem fit:**
- Confirm work follows {pattern-type} system patterns
- Check all cross-references work both ways in {reference-area}
- Verify tracking and registration accuracy for {tracking-area}
- Confirm all {dependency-type} dependencies are satisfied

**Verify operational readiness:**
- Test {deployment-area} system deployment readiness
- Set up continuous monitoring for {monitoring-area}
- Prepare long-term maintenance plan for {maintenance-area}
- Complete knowledge transfer to {user-area} users
```

## PARALLEL VALIDATION AGENT DEPLOYMENT

### Four-Stage Parallel Validation Pattern
```markdown
## ORCHESTRATOR PARALLEL VALIDATION DEPLOYMENT

### ORCHESTRATOR COORDINATION REQUIREMENTS

**MANDATORY**: Orchestrators must use Task tools for agent deployment
**AGENT FREEDOM**: Deployed agents execute directly with Read, Edit, Write, Bash, Grep, Glob tools
**PARALLEL PATTERN**: Deploy independent agents simultaneously within single orchestrator message
**COORDINATION PATTERN**: Use sequential Task deployment for dependent operations

**Four-Stage Parallel Validation Deployment**:

Task(subagent_type: "requirements-validator", description: "validate-requirements-completion", prompt: "I am the orchestrator and you are the requirements-validator agent. Validate Stage 1: Requirements completion verification for {validation-area}. DELIVERABLES: Requirements validation report operations/[conversation-id]/requirements-validation-results")

Task(subagent_type: "process-validator", description: "validate-process-compliance", prompt: "I am the orchestrator and you are the process-validator agent. Validate Stage 2: Process compliance verification for {process-area}. DELIVERABLES: Process validation report operations/[conversation-id]/process-validation-results")

Task(subagent_type: "output-validator", description: "validate-deliverable-quality", prompt: "I am the orchestrator and you are the output-validator agent. Validate Stage 3: Output quality verification for {output-area}. DELIVERABLES: Quality validation report operations/[conversation-id]/output-validation-results")

Task(subagent_type: "integration-validator", description: "validate-system-integration", prompt: "I am the orchestrator and you are the integration-validator agent. Validate Stage 4: System integration verification for {integration-area}. DELIVERABLES: Integration validation report operations/[conversation-id]/integration-validation-results")

**Sequential Final Validation After Parallel Checks**:
Task(subagent_type: "validation-coordinator", description: "synthesize-validation-results", prompt: "Combine parallel validation results into final success confirmation for {coordination-area}. DELIVERABLES: Final validation summary operations/[conversation-id]/final-validation-results")
```

## EVIDENCE COLLECTION TEMPLATES

### Standard Evidence Framework
```markdown
### Required Evidence Collection
- **Automated Testing**: Collect test results and verification scripts for {testing-area}
- **Manual Review**: Document human assessment and review for {review-area}
- **Independent Check**: Get peer validation confirmation for {check-area}
- **User Acceptance**: Obtain stakeholder approval for {acceptance-area}

### Evidence Documentation Pattern
```yaml
evidence_collection:
  automated_validation:
    - test_results: operations/[conversation-id]/{test-type}-test-results.json
    - verification_scripts: operations/[conversation-id]/{script-type}-verification.sh
    - quality_metrics: operations/[conversation-id]/{metrics-type}-quality-metrics.json
  
  manual_validation:
    - review_reports: operations/[conversation-id]/{review-type}-manual-review.md
    - assessment_matrices: operations/[conversation-id]/{assessment-type}-assessment.json
    - compliance_checklists: operations/[conversation-id]/{compliance-type}-compliance.md
  
  stakeholder_validation:
    - acceptance_criteria: operations/[conversation-id]/{acceptance-type}-acceptance.json
    - user_feedback: operations/[conversation-id]/{feedback-type}-feedback.md
    - approval_documentation: operations/[conversation-id]/{approval-type}-approvals.json
```

## VALIDATION FAILURE HANDLING

### Failure Response Template
```markdown
### When Validation Fails
**Take immediate action:**
- Analyze what went wrong and why in {failure-area}
- Evaluate the impact and consequences for {impact-area}
- Notify stakeholders about the failure in {notification-area}
- Restore system to previous working state for {restoration-area}

**Fix the problem:**
- Plan systematic correction approach for {correction-area}
- Deploy additional resources if needed for {resource-area}
- Improve your process methodology for {improvement-area}
- Set up enhanced verification for {verification-area} retry

**Apply recursion requirement:**
- MANDATORY: Return to Phase 1 for complete workflow restart
- Integrate failure learning into recursive approach
- Apply enhanced verification protocols
- Continue recursion until mathematical success achieved
```

## VALIDATION INTENSITY LEVELS

### Validation Level Selection Matrix
```markdown
### Quick Validation (Simple Tasks 1-10 min)
- Execute Stage 1 and Stage 3 checks
- Verify basic functionality works for {function-area}
- Check minimal process compliance for {process-area}

### Standard Validation (Moderate Tasks 10-30 min)
- Complete Stages 1, 2, and 3
- Verify thorough process and output for {thorough-area}
- Validate integration and compliance for {integration-area}

### Full Validation (Complex Tasks 30+ min)
- Execute all four validation stages
- Verify system-wide integration for {system-area}
- Collect extensive evidence and documentation for {evidence-area}

### Critical Validation (Enterprise Tasks 60+ min)
- Apply enhanced four-stage process with real-time monitoring for {monitoring-area}
- Implement continuous validation and feedback for {feedback-area}
- Apply maximum verification with automated testing for {testing-area}
```

## USAGE INSTRUCTIONS

### 1. Import Validation Pattern
Replace template variables with validation-specific values:
- `{validation-target}`: What is being validated
- `{deliverable-area}`: Area of deliverable validation
- `{requirement-type}`: Type of requirements being validated
- `{mathematical-formula}`: Specific calculation for success measurement

### 2. Customize Four-Stage Framework
- Adapt validation stages to domain-specific requirements
- Include relevant quality checkpoints for workflow area
- Specify evidence collection requirements for compliance area

### 3. Apply Mathematical Success Criteria
- Define objective calculation formulas
- Set minimum threshold values for success
- Include percentage calculations for measurable outcomes

### 4. Deploy Validation Agents
- Use parallel validation deployment for independent validation areas
- Apply sequential validation for dependent validation processes
- Include validation coordinator for result synthesis

**MODULARIZATION SUCCESS**: This template eliminates 2,253 lines of repetitive quality validation patterns across workflow system through universal pattern extraction.