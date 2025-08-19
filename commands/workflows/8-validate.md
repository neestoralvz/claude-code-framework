---
title: "Validate Command"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["workflow.md", "fundamental.md", "validation-methodology.md"]
prerequisites: ["Completed ripple effect phase", "System integrity verified"]
audience: "Quality assurance teams and validation specialists"
purpose: "Execute Phase 8 workflow: Verify completion against established success criteria"
keywords: ["validation", "workflow", "phase8", "success-criteria", "verification"]
last_review: "2025-08-18"
---

[Previous: Deploy Ripple Effect Command](ripple-effect.md) | [Return to Documentation Hub for navigation](../docs/index.md) | [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md) | [Next: Navigate to Commands Index](index.md)

# VALIDATE COMMAND

## Purpose

⏺ **Principle**: This command implements [workflow.md Phase 8](../docs/principles/workflow.md) by verifying completion against established success criteria, and applies [fundamental.md evidence approach](../docs/principles/fundamental.md) through systematic validation.

Execute comprehensive validation of implementation results against original success criteria, ensuring complete requirement fulfillment and quality standards.

## Command Syntax

```bash
# Basic usage - comprehensive validation against all criteria
validate

# With specific validation scope
validate --scope [functional|technical|quality|compliance]

# With validation depth and reporting
validate --depth [basic|thorough|comprehensive] --report [summary|detailed|evidence-based]
```

## Execution Workflow

### Phase 1: Criteria Loading
- Load original success criteria from clarification phase
- Review implementation outputs and deliverables
- Establish validation baseline and measurement framework
- Prepare validation test cases and verification procedures

### Phase 2: Systematic Verification
- Execute validation tests against each success criterion
- Measure implementation outcomes against defined metrics
- Verify functional requirements and technical specifications
- Assess quality standards and compliance requirements

### Phase 3: Evidence Collection
- Document validation results with supporting evidence
- Capture test outputs, measurements, and assessments
- Generate compliance reports and quality certifications
- Compile comprehensive validation documentation

### Phase 4: Completion Assessment
- Analyze validation results for complete requirement fulfillment
- Identify any gaps or deficiencies requiring attention
- Determine if recursive workflow iteration is needed
- Certify successful completion or recommend next steps

## Parameters

### Required Parameters
None - command loads success criteria from clarification phase automatically

### Optional Parameters
- **--scope**: Focus validation on specific area (functional|technical|quality|compliance)
- **--depth**: Validation thoroughness (basic|thorough|comprehensive)
- **--report**: Output format (summary|detailed|evidence-based)
- **--criteria**: Override or supplement original success criteria

## Expected Output

```bash
VALIDATION RESULTS
==================

Success Criteria Assessment:
┌─ Total Criteria: [N] success criteria evaluated
├─ Passed: [N] criteria fully satisfied
├─ Partial: [N] criteria partially satisfied
└─ Failed: [N] criteria not met

Detailed Validation Results:

✅ CRITERION 1: [Original success criterion description]
├─ Status: PASSED
├─ Evidence: [Supporting evidence and measurements]
├─ Quality: [Quality assessment]
└─ Notes: [Additional observations]

🔄 CRITERION 2: [Original success criterion description]
├─ Status: PARTIAL
├─ Evidence: [Current state and measurements]
├─ Gap: [What remains to be completed]
└─ Recommendation: [Suggested action]

❌ CRITERION 3: [Original success criterion description]
├─ Status: FAILED
├─ Issue: [Description of failure or deficiency]
├─ Impact: [Assessment of impact on overall success]
└─ Resolution: [Required remediation steps]

Quality Metrics:
├─ Functional Compliance: [X]% complete
├─ Technical Standards: [X]% compliant
├─ Documentation Quality: [X]% coverage
└─ System Integration: [X]% validated

Overall Assessment:
┌─ Implementation Status: [Complete/Needs Iteration/Failed]
├─ Success Rate: [X]% of criteria satisfied
├─ Quality Score: [Rating] out of [Scale]
└─ Recommendation: [Next steps or completion certification]

Evidence Documentation:
📁 Validation report generated: [filename]
📁 Test results archived: [location]
📁 Compliance documentation: [location]

VALIDATION COMPLETE - [Status Summary]
```

## Integration Points

### Workflow Integration
- Validates all previous workflow phases systematically
- Determines workflow completion or recursive iteration needs
- Provides final assessment of implementation success

### Quality Assurance Integration
- Applies systematic validation methodology from components
- Generates comprehensive evidence and documentation
- Ensures complete traceability from requirements to results

## Success Criteria

⏺ **Quality Assurance**: This command uses [standardized success criteria](../shared/SuccessCriteriaTemplate.md#workflow-commands) for consistent validation and measurement.

- [ ] All original success criteria evaluated systematically
- [ ] Validation evidence collected and documented
- [ ] Quality standards verified and certified
- [ ] Completion status determined with clear rationale
- [ ] Workflow completion certified or iteration plan established

## Usage Examples

### Comprehensive Validation
```bash
validate
# Expected result: Complete validation of all success criteria with detailed assessment
```

### Technical-Focused Validation
```bash
validate --scope technical --depth comprehensive
# Expected result: Thorough technical validation with detailed evidence collection
```

### Summary Validation Report
```bash
validate --report summary --depth basic
# Expected result: High-level validation summary for stakeholder communication
```

## Cross-References

⏺ **Navigation**: This command uses [automated cross-references](../shared/CrossReferenceEngine.md#workflow-cross-reference-pattern) for consistent navigation and framework integration.

### Primary Navigation
- [Navigate to Documentation Hub](../docs/index.md)
- [Browse commands index](index.md)
- [Study PRINCIPLES.md](../docs/PRINCIPLES.md)

### Related Commands
- [Ripple effect command](7-ripple-effect.md) - Previous workflow phase
- [Clarify command](1-clarify.md) - Source of success criteria
- [System audit command](system-audit.md) - For system-wide validation

### Principle References
- [Apply workflow.md for systematic execution](../docs/principles/workflow.md)
- [Use fundamental.md for evidence-based validation](../docs/principles/fundamental.md)
- [Follow validation-methodology.md for procedures](../docs/components/validation-methodology.md)

[⬆ Return to top](#validate-command)