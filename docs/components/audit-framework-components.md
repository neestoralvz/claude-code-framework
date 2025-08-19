# Audit Framework Components

Reusable audit framework components extracted from system-audit command for modular architecture compliance.

**Quick Links**: [System Audit Command](../../commands/analysis/system-audit.md) | [Commands Index](../../commands/index.md) | [Components Hub](./README.md)

## Built-in Validation Framework

⏺ **Quality Assurance**: This component includes comprehensive validation at every audit phase, eliminating external quality control dependencies.

### Four-Gate Validation System
```yaml
validation_gates:
  requirements_gate:
    - audit_scope_validation: defined_and_accessible
    - criteria_verification: comprehensive_coverage
    - success_metrics: established_and_measurable
    
  process_gate:
    - workflow_compliance: 8_phase_methodology
    - principle_adherence: embedded_enforcement
    - audit_phase_completion: validated_progression
    
  output_gate:
    - finding_quality: assessed_and_prioritized
    - ticket_completeness: comprehensive_specification
    - recommendation_clarity: actionable_and_specific
    
  system_gate:
    - registry_integration: seamless_update
    - dependency_verification: validated_connections
    - regression_prevention: system_integrity_maintained
```

### Audit Categories with Embedded Validation

#### Content Quality (Automatic Detection)
- **Simplicity Violations**: >500 lines, verbose text (embedded threshold enforcement)
- **Clarity Issues**: Ambiguous instructions, missing action verbs (NLP analysis)
- **Communication Compliance**: Non-imperative tone detection (automatic scanning)

#### Structural Issues (Built-in Validation)
- **Navigation Integrity**: Broken links detection (automated link checking)
- **Cross-Reference Validation**: Missing references (bidirectional verification)
- **File Orphan Detection**: Unreferenced files (dependency graph analysis)

#### Principle Violations (Embedded Enforcement)
- **Workflow Compliance**: Missing phases (8-phase methodology validation)
- **Success Criteria**: Validation framework presence (automatic verification)
- **Engineering Standards**: Quality gate implementation (built-in assessment)

#### System Contradictions (Intelligent Analysis)
- **Authority Conflicts**: Competing instruction sources (authority hierarchy validation)
- **Implementation Gaps**: Missing functionality (capability gap analysis)
- **Consistency Violations**: Conflicting information (semantic analysis)

#### Pattern Analysis & Duplication Detection (Advanced Analytics)
- **Content Fingerprinting**: Semantic similarity detection (>70% threshold)
- **Definition Consistency**: Concept alignment verification (terminology analysis)
- **Single Source Validation**: Authority source identification (hierarchy enforcement)
- **Consolidation Opportunities**: Scattered information detection (content clustering)

## Cross-References

### Related Components
- [Validation Framework Components](./validation-framework-components.md)
- [Agent Deployment Framework](./agent-deployment-framework.md)
- [Architecture Documentation Templates](./architecture-documentation-templates.md)

### Integration Points
- [System Audit Command](../../commands/analysis/system-audit.md)
- [Workflow Methodology](../principles/workflow.md)
- [Engineering Standards](../principles/engineering.md)

[⬆ Return to top](#audit-framework-components)