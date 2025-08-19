
[Previous: 10-phase-detailed-methodology.md](10-phase-detailed-methodology.md) | [Return to CLAUDE.md](../../CLAUDE.md) | [Next: engineering.md](../quality-assurance/engineering.md)

# PRINCIPLE VALIDATION CHECKPOINTS

## Purpose

⏺ **Validation Gateway**: Mandatory principle validation procedures that must be executed during Phase 6 Planning before proceeding to implementation. This checkpoint prevents over-engineering and ensures framework compliance.


## TASK 1: SIMPLICITY ENFORCEMENT VALIDATION

### Agent Deployment
```markdown
Task(
  subagent_type: "simplicity-enforcer",
  description: "Validate SIMPLE framework compliance",
  prompt: "I am the orchestrator and you are the simplicity-enforcer agent.
          Search for relevant files in commands/ and docs/ for your execution.
          Context: Planning phase requires validation against over-engineering.
          Execute validation of current implementation plan against SIMPLE framework:
          Simple, Incremental, Maintainable, Purposeful, Lean, Effective principles.
          Identify complexity violations and provide simplification recommendations.
          
          PROGRESSIVE THINKING MANDATORY: Apply Think→Think Hard→Think Harder→UltraThink
          - Analyze task complexity and apply appropriate thinking levels
          - Document thinking progression in your analysis
          
          DELIVERABLES REQUIRED:
          - Output Format: JSON validation report
          - File Location: operations/{conversation-id}/simplicity-validation-{timestamp}.json
          - Agent Results: operations/{conversation-id}/simplicity-enforcer-analysis.json
          - Content Requirements: SIMPLE framework compliance score, root cause analysis, integral solutions
          - Quality Standards: Root problem identification, lasting solution recommendations
          - Progressive Thinking Evidence: Document thinking level applied and rationale"
)
```

### Validation Criteria
- **Simple**: Solution complexity appropriate to problem scope
- **Incremental**: Implementation can be developed in stages
- **Maintainable**: Code and architecture sustainable long-term
- **Purposeful**: Every component serves clear business purpose
- **Lean**: No unnecessary abstractions or over-engineering
- **Effective**: Solution efficiently achieves stated objectives

### Expected Deliverables
- SIMPLE framework compliance score (0-100)
- Specific violation identification with severity ratings
- Simplification recommendations with implementation guidance
- Root cause analysis of complexity sources


## TASK 3: COMPLIANCE AUDITING

### Agent Deployment
```markdown
Task(
  subagent_type: "compliance-auditor",
  description: "Verify framework principles adherence",
  prompt: "I am the orchestrator and you are the compliance-auditor agent.
          Search for relevant files in commands/ and docs/ for your execution.
          Context: Mandatory checkpoint before implementation phase.
          Verify implementation plan compliance with engineering standards,
          framework principles, and quality patterns. Validate resource
          allocation appropriateness and scope alignment with requirements.
          
          PROGRESSIVE THINKING MANDATORY: Apply Think→Think Hard→Think Harder→UltraThink
          - Analyze task complexity and apply appropriate thinking levels
          - Document thinking progression in your analysis
          
          DELIVERABLES REQUIRED:
          - Output Format: JSON compliance report
          - File Location: operations/{conversation-id}/compliance-audit-{timestamp}.json
          - Agent Results: operations/{conversation-id}/compliance-auditor-analysis.json
          - Content Requirements: Comprehensive compliance analysis, root problem identification, integral remediation plan
          - Quality Standards: Atomic task assignments, specialized agent deployment, lasting compliance solutions
          - Progressive Thinking Evidence: Document thinking level applied and rationale"
)
```

### Compliance Areas
- **Engineering Standards**: Code quality, architecture patterns, technical debt
- **Framework Principles**: Adherence to directive, workflow, validation principles
- **Quality Patterns**: Testing strategies, documentation standards, maintainability
- **Resource Allocation**: Budget, timeline, team capacity appropriateness
- **Scope Alignment**: Requirements traceability, feature justification

### Expected Deliverables
- Comprehensive compliance score across all areas
- Specific violation identification with remediation requirements
- Resource allocation assessment with optimization recommendations
- Risk analysis with mitigation strategies
- Compliance certification status


## Integration with Framework

### Related Principles
- **[Simplicity Enforcement](simplicity.md)** → SIMPLE framework methodology
- **[Engineering Standards](../quality-assurance/engineering.md)** → Technical quality standards
- **[Validation Principles](validation.md)** → Comprehensive validation methodology

### Workflow Integration
- **[10-Phase Methodology](10-phase-detailed-methodology.md)** → Phase 6 Planning details
- **[CLAUDE.md](../../CLAUDE.md)** → Primary execution interface
- **[Workflow Principles](../core-authority/workflow.md)** → Core workflow philosophy

[⬆ Return to top](#principle-validation-checkpoints)