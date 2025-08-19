
# SUCCESS CRITERIA TEMPLATE COMPONENT

⏺ **Authority**: This is the **centralized success criteria pattern** eliminating duplication across the Claude Code Framework. All validation patterns must reference this component.

## Pre-Execution Validation
- [ ] **Input Validation**: {{input_requirements|"Requirements clearly defined with scope boundaries established"}}
- [ ] **Resource Validation**: {{resource_requirements|"Tools, capabilities, and systems verified and available"}}
- [ ] **Context Validation**: {{context_requirements|"Framework constraints understood with integration requirements analyzed"}}
- [ ] **Scope Definition**: {{scope_definition|"Boundaries clearly defined with stakeholder alignment achieved"}}

## Execution Validation
- [ ] **Process Compliance**: {{process_requirements|"Eight-phase workflow methodology applied to all execution processes"}}
- [ ] **Quality Standards**: {{quality_requirements|"Engineering principles enforced throughout implementation"}}
- [ ] **Framework Adherence**: {{framework_requirements|"Framework best practices followed with validation protocol compliance"}}
- [ ] **Integration Planning**: {{integration_requirements|"Integration points verified for seamless framework compatibility"}}

## Post-Execution Validation
- [ ] **Success Criteria Verification**: {{success_verification|"All specified requirements met with comprehensive validation"}}
- [ ] **Quality Gate Compliance**: {{quality_gates|"Four-gate validation (Requirements, Process, Output, System) passed with evidence collection"}}
- [ ] **Evidence Collection**: {{evidence_requirements|"Deliverables verified for completeness with systematic quality measurement"}}
- [ ] **{{validation_context|"Framework Integration"}}**: {{domain_requirements|"Component integrated with framework architecture and validation protocols"}}

## Completion Checklist
- [ ] **{{primary_deliverable|"Delivery Completeness"}}**: {{primary_completion_criteria|"All specified deliverables completed successfully with functional verification"}}
- [ ] **{{secondary_deliverable|"Quality Achievement"}}**: {{secondary_completion_criteria|"Quality standards met with systematic validation evidence"}}
- [ ] **Documentation Accuracy**: {{documentation_requirements|"Documentation complete with accurate references and comprehensive coverage"}}
- [ ] **Quality Assurance**: {{qa_requirements|"Quality assurance protocols followed with validation-engineer compliance"}}


## Usage Instructions

### Standard Agent Implementation
```markdown
{% include docs/templates/components/success-criteria-template.md 
   validation_context="Agent Deployment"
   domain_requirements="Agent deployment verified and operational with framework integration"
   primary_deliverable="Agent Functionality"
   primary_completion_criteria="Agent operational with verified capabilities and integration protocols" %}
```

### Command Implementation
```markdown
{% include docs/templates/components/success-criteria-template.md 
   validation_context="Command Execution"
   domain_requirements="Command execution successful with systematic validation"
   input_requirements="Command parameters validated with execution context established"
   quality_requirements="Command execution follows eight-phase methodology" %}
```

### Framework Component Implementation
```markdown
{% include docs/templates/components/success-criteria-template.md 
   validation_context="Component Integration"
   domain_requirements="Component integrated with framework architecture successfully"
   quality_gates="Component quality gates passed with architectural compliance verified" %}
```

### Ticket/Project Implementation
```markdown
{% include docs/templates/components/success-criteria-template.md 
   validation_context="Project Completion"
   domain_requirements="Project deliverables completed with stakeholder acceptance"
   success_verification="Project success criteria met with measurable outcomes achieved" %}
```


## Parameterization Guide

### Required Parameters
- **validation_context**: Domain-specific validation label (e.g., "Agent Deployment", "Command Execution")
- **domain_requirements**: Context-specific requirements for the validation area

### Optional Parameters
- **input_requirements**: Custom input validation criteria
- **resource_requirements**: Custom resource validation needs
- **context_requirements**: Custom context validation parameters
- **scope_definition**: Custom scope boundary definition
- **process_requirements**: Custom process compliance criteria
- **quality_requirements**: Custom quality standards
- **framework_requirements**: Custom framework adherence criteria
- **integration_requirements**: Custom integration planning needs
- **success_verification**: Custom success verification criteria
- **quality_gates**: Custom quality gate requirements
- **evidence_requirements**: Custom evidence collection needs
- **primary_deliverable**: Custom primary deliverable label
- **primary_completion_criteria**: Custom primary completion criteria
- **secondary_deliverable**: Custom secondary deliverable label
- **secondary_completion_criteria**: Custom secondary completion criteria
- **documentation_requirements**: Custom documentation standards
- **qa_requirements**: Custom quality assurance protocols

### Default Values
All parameters include intelligent defaults. When not specified, the component uses framework-standard validation criteria appropriate for general use cases.


## Migration Notes

### Files Updated
This component centralizes success criteria patterns from:
- 33 agent files in `/agents/`
- 15+ command files in `/commands/`
- 25+ documentation files in `/docs/`
- Template and pattern generator files

### Backward Compatibility
Existing success criteria patterns remain functional during migration. Component references should be implemented systematically across all framework files.

### Validation Integration
This component integrates with:
- `validation-engineer.md` protocols
- Four-gate validation methodology
- Eight-phase workflow requirements
- Engineering principles compliance
- Framework architecture standards
