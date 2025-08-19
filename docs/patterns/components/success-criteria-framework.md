---
title: "Success Criteria Framework Component"
author: "Pattern Management Specialist"
date: "2025-08-19"
version: "1.0.0"
component_type: "reusable-pattern"
usage_count: 0
parameters: ["input_requirements", "resource_requirements", "context_requirements", "domain_specific_validation"]
---

# SUCCESS CRITERIA FRAMEWORK

⏺ **Pattern Component**: This is a reusable success criteria pattern eliminating duplication across commands, agents, and workflows.

## Pre-Execution Validation
- [ ] **Input Validation**: {{input_requirements}}
- [ ] **Resource Validation**: {{resource_requirements}}
- [ ] **Context Validation**: {{context_requirements}}
- [ ] **Scope Definition**: {{scope_definition}}

## Execution Validation
- [ ] **Process Compliance**: {{process_requirements}}
- [ ] **Quality Standards**: {{quality_requirements}}
- [ ] **Framework Adherence**: {{framework_requirements}}
- [ ] **Integration Planning**: {{integration_requirements}}

## Post-Execution Validation
- [ ] **Success Criteria Verification**: {{success_verification}}
- [ ] **Quality Gate Compliance**: {{quality_gates}}
- [ ] **Evidence Collection**: {{evidence_requirements}}
- [ ] **{{domain_specific_validation}}**: {{domain_requirements}}

## Completion Checklist
- [ ] **{{primary_deliverable}}**: {{primary_completion_criteria}}
- [ ] **{{secondary_deliverable}}**: {{secondary_completion_criteria}}
- [ ] **Documentation Accuracy**: {{documentation_requirements}}
- [ ] **Quality Assurance**: {{qa_requirements}}

## Usage Instructions

### Basic Implementation
```markdown
{% include success-criteria-framework.md 
   input_requirements="Task requirements clearly defined"
   quality_requirements="Engineering principles enforced" %}
```

### Parameterized Implementation
```markdown
{% include success-criteria-framework.md 
   input_requirements="{{CUSTOM_INPUT_REQUIREMENTS}}"
   resource_requirements="{{CUSTOM_RESOURCE_REQUIREMENTS}}"
   domain_specific_validation="{{DOMAIN_VALIDATION_NAME}}"
   domain_requirements="{{DOMAIN_VALIDATION_CRITERIA}}" %}
```

### Agent-Specific Usage
```markdown
{% include success-criteria-framework.md 
   input_requirements="Agent capabilities match task requirements"
   quality_requirements="Agent coordination protocols followed"
   domain_specific_validation="Agent Deployment Success"
   domain_requirements="Agent deployment verified and operational" %}
```