# Evidence-Based Decision Workflow

## Overview

This workflow ensures all decisions are backed by verifiable evidence and validated through systematic testing. Every decision must have measurable criteria and validation mechanisms before implementation.

## Core Principles

- **Evidence First**: No decisions without supporting data
- **Validation Required**: All decisions must be testable
- **Documentation Mandatory**: Evidence must be preserved
- **Reversibility**: Decisions must include rollback criteria

## Workflow Structure

### Phase 1: Evidence Collection (RED)

**Given** a decision needs to be made  
**When** collecting evidence  
**Then** gather quantifiable data using these criteria:

1. **Data Requirements**
   - Quantitative metrics (numbers, percentages, timestamps)
   - Qualitative observations (user feedback, system behavior)
   - Comparative analysis (before/after, alternative options)
   - Risk assessment (probability, impact, mitigation)

2. **Evidence Sources**
   - System metrics and logs
   - User behavior data
   - Performance benchmarks
   - Error rates and patterns
   - Resource utilization
   - Time-to-completion metrics

3. **Quality Gates**
   - Minimum 3 independent data sources
   - Data must be recent (< 30 days unless specified)
   - Statistical significance where applicable
   - Bias identification and mitigation

### Phase 2: Decision Validation (GREEN)

**Given** sufficient evidence is collected  
**When** making the decision  
**Then** validate through structured analysis:

1. **Decision Framework**
   ```
   DECISION: [Clear statement of the decision]
   
   EVIDENCE:
   - Source 1: [Data point + verification method]
   - Source 2: [Data point + verification method]
   - Source 3: [Data point + verification method]
   
   CRITERIA:
   - Success metric: [Measurable outcome]
   - Failure threshold: [Point to reverse decision]
   - Timeline: [When to evaluate]
   
   ALTERNATIVES CONSIDERED:
   - Option A: [Why rejected]
   - Option B: [Why rejected]
   
   RISKS:
   - Risk 1: [Probability + Impact + Mitigation]
   - Risk 2: [Probability + Impact + Mitigation]
   
   ROLLBACK PLAN:
   - Trigger conditions: [When to rollback]
   - Steps: [How to rollback]
   - Recovery time: [Expected duration]
   ```

2. **Validation Tests**
   - Hypothesis: "If we implement X, then Y will improve by Z%"
   - Measurement plan: How success will be measured
   - Timeline: When measurements will be taken
   - Success criteria: Specific thresholds for success

### Phase 3: Implementation Monitoring (REFACTOR)

**Given** a decision is implemented  
**When** monitoring results  
**Then** continuously validate against evidence:

1. **Continuous Monitoring**
   - Track all success metrics defined in Phase 2
   - Monitor for unexpected side effects
   - Document actual vs predicted outcomes
   - Alert when failure thresholds are approached

2. **Evidence Update Cycle**
   - Weekly metric reviews for first month
   - Monthly reviews thereafter
   - Immediate review if failure threshold hit
   - Annual comprehensive review

3. **Decision Refinement**
   - Update decision based on new evidence
   - Adjust success criteria if justified
   - Document lessons learned
   - Feed insights into future decisions

## Implementation Scenarios

### Scenario 1: Technical Architecture Decision

**Given** we need to choose between two database solutions  
**When** applying evidence-based decision workflow  
**Then** we gather:

- Performance benchmarks under expected load
- Cost analysis over 2-year period
- Team expertise assessment
- Migration complexity analysis
- Vendor support quality metrics

**Validation**: Load test with realistic data, cost projection review, team skill gap analysis

### Scenario 2: Process Optimization Decision

**Given** current workflow has efficiency issues  
**When** deciding on optimization approach  
**Then** we collect:

- Time-motion studies of current process
- Error rate analysis
- User satisfaction scores
- Resource utilization metrics
- Alternative process benchmarks

**Validation**: Pilot test with subset of users, A/B comparison, ROI calculation

### Scenario 3: Feature Prioritization Decision

**Given** multiple features competing for development time  
**When** prioritizing features  
**Then** we analyze:

- User request frequency and intensity
- Business impact projections
- Development effort estimates
- Technical debt implications
- Competitive landscape analysis

**Validation**: User story validation, business case review, technical feasibility confirmation

## Quality Assurance

### Evidence Quality Checklist

- [ ] Data is from reliable, verifiable sources
- [ ] Sample size is statistically significant
- [ ] Bias sources identified and mitigated
- [ ] Data freshness meets requirements
- [ ] Multiple independent sources confirm findings

### Decision Quality Checklist

- [ ] Clear success/failure criteria defined
- [ ] Rollback plan documented and tested
- [ ] Alternative options evaluated
- [ ] Risk mitigation strategies in place
- [ ] Monitoring plan established

### Implementation Quality Checklist

- [ ] Baseline metrics captured before implementation
- [ ] Monitoring systems configured
- [ ] Review schedule established
- [ ] Stakeholder communication plan active
- [ ] Rollback procedures tested

## Integration Points

### With Other Workflows

- **Strategic Orchestration**: Provides evidence for strategic decisions
- **Development Workflow**: Ensures technical decisions are evidence-based
- **Framework Evaluation**: Uses this process for framework changes
- **Session Conclusion**: Documents decision outcomes for future reference

### Tool Integration

- **WebSearch/WebFetch**: For external evidence gathering
- **Context7**: For industry best practices
- **Bash**: For system metric collection
- **Git**: For decision and evidence documentation

## Emergency Procedures

### When Evidence is Insufficient

1. **Acknowledge the gap**: Document what evidence is missing
2. **Risk assessment**: Evaluate cost of delay vs. risk of proceeding
3. **Minimal viable evidence**: Identify absolute minimum evidence needed
4. **Time-boxed collection**: Set strict deadline for evidence gathering
5. **Contingency planning**: Prepare for both success and failure scenarios

### When Decisions Must Be Reversed

1. **Trigger recognition**: Monitor failure thresholds continuously
2. **Immediate assessment**: Confirm reversal is necessary
3. **Rollback execution**: Follow predetermined rollback plan
4. **Post-mortem analysis**: Understand why decision failed
5. **Process improvement**: Update workflow based on learnings

## Success Metrics

- **Decision Quality**: % of decisions that meet success criteria
- **Evidence Completeness**: % of decisions with full evidence documentation
- **Reversal Rate**: % of decisions that require rollback
- **Time to Evidence**: Average time to collect sufficient evidence
- **Outcome Accuracy**: % of predicted outcomes that materialize

---

**Remember**: Every decision is a hypothesis. Evidence is the experiment. Validation is the proof.