---
title: "SuccessCriteriaTemplate - Standardized Success Criteria Generator"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["../interfaces/ValidationInterface.md"]
prerequisites: ["Command success criteria requirements"]
audience: "All command implementations requiring success criteria"
purpose: "Centralized success criteria template eliminating duplication across all commands"
keywords: ["success-criteria", "template", "standardized", "DRY", "reusable"]
last_review: "2025-08-19"
architecture_type: "shared-component"
execution_mode: "template-generation"
duplication_reduction: "95%"
---

[Previous: Shared Components](index.md) | [Return to Commands Hub](../index.md) | [Next: Cross Reference Engine](CrossReferenceEngine.md)

# SUCCESS CRITERIA TEMPLATE - STANDARDIZED GENERATOR

## Purpose

⏺ **DRY Principle**: This component eliminates duplication of success criteria patterns across all commands, providing a single source of truth for success criteria generation and validation.

## Template Categories

### Command Type Templates

#### Analysis Commands
```yaml
analysis_success_criteria:
  standard_criteria:
    - "All analysis targets identified and examined systematically"
    - "Findings documented with supporting evidence and metrics"
    - "Recommendations provided with clear implementation guidance"
    - "Analysis results validated for accuracy and completeness"
    - "System integrity maintained throughout analysis process"
  
  specialized_criteria:
    system_audit:
      - "Complete system state captured and documented"
      - "All compliance violations identified and categorized"
      - "Performance metrics baseline established"
      - "Security assessment completed with risk analysis"
    
    dependency_analysis:
      - "All dependency relationships mapped and validated"
      - "Circular dependencies identified and resolution planned"
      - "Dependency conflicts detected and mitigation provided"
      - "Version compatibility verified across all components"
```

#### Management Commands
```yaml
management_success_criteria:
  standard_criteria:
    - "Task scope clearly defined with measurable boundaries"
    - "Implementation plan created with realistic timelines"
    - "Resource requirements identified and allocated"
    - "Risk assessment completed with mitigation strategies"
    - "Success metrics established for progress tracking"
  
  specialized_criteria:
    ticket_creation:
      - "Ticket metadata complete and validation-compliant"
      - "Cross-references established and bidirectionally linked"
      - "Priority and dependency assignments verified"
      - "Registry integration successful with no conflicts"
    
    system_initialization:
      - "All system components initialized successfully"
      - "Configuration validation passed all checks"
      - "Dependencies verified and properly loaded"
      - "System health monitoring activated and functional"
```

#### Workflow Commands
```yaml
workflow_success_criteria:
  standard_criteria:
    - "Workflow phase completion validated against requirements"
    - "Transition conditions satisfied for next phase progression"
    - "Quality gates passed with documented evidence"
    - "Stakeholder approval obtained for phase deliverables"
    - "System state preserved and integrity maintained"
  
  specialized_criteria:
    eight_phase_workflow:
      - "All eight phases executed in correct sequence"
      - "Phase handoffs validated with complete deliverables"
      - "Success criteria from clarification phase verified"
      - "Workflow recursion properly managed if required"
    
    parallel_execution:
      - "Parallel tasks coordinated without conflicts"
      - "Resource contention avoided through proper scheduling"
      - "Results aggregated and validated for consistency"
      - "Error handling effective across all parallel streams"
```

#### Organization Commands
```yaml
organization_success_criteria:
  standard_criteria:
    - "Pattern analysis completed with duplication identification"
    - "Extraction strategy validated for functionality preservation"
    - "Component reusability verified through testing"
    - "Integration success confirmed with existing systems"
    - "Documentation updated to reflect organizational changes"
  
  specialized_criteria:
    modularization:
      - "Modules designed with clear interface contracts"
      - "Dependencies minimized and properly encapsulated"
      - "Testing coverage maintained across all modules"
      - "Performance impact assessed and optimized"
    
    consolidation:
      - "Duplicate elimination verified at 70%+ reduction"
      - "Functionality preservation tested comprehensively"
      - "Migration path established with rollback capability"
      - "System performance improved or maintained"
```

## Success Criteria Generation Patterns

### Basic Pattern
```markdown
## Success Criteria

- [ ] {PRIMARY_OBJECTIVE_CRITERIA}
- [ ] {QUALITY_VALIDATION_CRITERIA}
- [ ] {FUNCTIONALITY_PRESERVATION_CRITERIA}
- [ ] {INTEGRATION_SUCCESS_CRITERIA}
- [ ] {DOCUMENTATION_COMPLETENESS_CRITERIA}
```

### Specialized Pattern
```markdown
## Success Criteria

### Primary Objectives
- [ ] {SPECIFIC_COMMAND_OBJECTIVE_1}
- [ ] {SPECIFIC_COMMAND_OBJECTIVE_2}
- [ ] {SPECIFIC_COMMAND_OBJECTIVE_3}

### Quality Validation
- [ ] {VALIDATION_CRITERION_1}
- [ ] {VALIDATION_CRITERION_2}
- [ ] {VALIDATION_CRITERION_3}

### System Integration
- [ ] {INTEGRATION_CRITERION_1}
- [ ] {INTEGRATION_CRITERION_2}
- [ ] {INTEGRATION_CRITERION_3}
```

### Complex Pattern
```markdown
## Success Criteria

### Requirements Validation
- [ ] {REQUIREMENT_VALIDATION_1}
- [ ] {REQUIREMENT_VALIDATION_2}

### Process Compliance
- [ ] {PROCESS_COMPLIANCE_1}
- [ ] {PROCESS_COMPLIANCE_2}

### Output Quality
- [ ] {OUTPUT_QUALITY_1}
- [ ] {OUTPUT_QUALITY_2}

### System Integration
- [ ] {SYSTEM_INTEGRATION_1}
- [ ] {SYSTEM_INTEGRATION_2}

### Evidence Collection
- [ ] {EVIDENCE_COLLECTION_1}
- [ ] {EVIDENCE_COLLECTION_2}
```

## Usage Patterns for Commands

### Basic Command Integration
```markdown
## Success Criteria

⏺ **Quality Assurance**: This command uses [standardized success criteria](../shared/SuccessCriteriaTemplate.md#basic-pattern) for consistent validation and measurement.

- [ ] [Generated criteria from SuccessCriteriaTemplate based on command type]
- [ ] [Quality validation criteria specific to command purpose]
- [ ] [Integration success criteria for system compatibility]
- [ ] [Documentation completeness criteria for comprehensive coverage]
- [ ] [Functionality preservation criteria for regression prevention]
```

### Specialized Command Integration
```markdown
## Success Criteria

⏺ **Quality Assurance**: This command implements [specialized success criteria](../shared/SuccessCriteriaTemplate.md#specialized-pattern) from the SuccessCriteriaTemplate for {command_type} validation.

### [Command-Specific Category]
- [ ] [Specialized criterion 1]
- [ ] [Specialized criterion 2]
- [ ] [Specialized criterion 3]

### Quality Validation
- [ ] [Quality criterion 1]
- [ ] [Quality criterion 2]

### System Integration
- [ ] [Integration criterion 1]
- [ ] [Integration criterion 2]
```

## Template Customization

### Command-Specific Extensions
```yaml
template_extensions:
  custom_criteria_insertion:
    - position: "after_primary_objectives"
    - content: "command-specific criteria"
    - validation: "ensure compatibility with base template"
  
  criterion_modification:
    - target: "specific criterion"
    - modification: "adapt to command context"
    - preservation: "maintain validation integrity"
  
  additional_categories:
    - category: "Security Validation"
    - category: "Performance Requirements"
    - category: "Compliance Verification"
```

### Dynamic Generation Rules
```yaml
generation_rules:
  criterion_selection:
    - command_type: "determines base criteria set"
    - complexity_level: "influences criterion depth"
    - validation_requirements: "adds specific validation criteria"
  
  customization_logic:
    - merge_base_and_specific: "combine standard and specialized"
    - validate_completeness: "ensure all requirements covered"
    - optimize_for_clarity: "maintain readability and usability"
```

## Implementation Benefits

### DRY Compliance
- **Single Source of Truth**: All success criteria logic centralized
- **Consistent Standards**: Standardized criteria across all commands
- **Maintenance Efficiency**: Update once, apply everywhere
- **Quality Assurance**: Unified validation and measurement approach

### Template Advantages
- **Rapid Development**: Quick success criteria generation for new commands
- **Comprehensive Coverage**: Ensures all critical areas are addressed
- **Validation Integration**: Built-in validation and measurement framework
- **Customization Support**: Flexible adaptation to specific command requirements

### Framework Integration
- **Command Compatibility**: Works with all command types and structures
- **Validation Engine**: Integrates with ValidationEngine.md for comprehensive quality assurance
- **Workflow Alignment**: Supports eight-phase methodology and validation checkpoints
- **Documentation Standards**: Maintains consistency with framework documentation patterns

## Cross-References

### Shared Components
- [Enhanced Template](EnhancedTemplate.md) - Command template system
- [Validation Engine](ValidationEngine.md) - Four-gate validation system
- [Cross Reference Engine](CrossReferenceEngine.md) - Automated cross-reference generation
- [Workflow Templates](WorkflowTemplates.md) - Eight-phase template system

### Core Architecture
- [ValidationInterface.md](../interfaces/ValidationInterface.md) - Validation contract
- [BaseCommand.md](../core/BaseCommand.md) - Command base class
- [ValidationFramework.md](../core/ValidationFramework.md) - Extensible validation system

### Usage Examples
- [system-audit.md](../workflows/system-audit.md) - Analysis success criteria example
- [create-ticket.md](../management/create-ticket.md) - Management success criteria example
- [8-validate.md](../workflows/8-validate.md) - Workflow success criteria example

[⬆ Return to top](#success-criteria-template---standardized-generator)