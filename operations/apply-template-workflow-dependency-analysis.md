# Apply Template Workflow Dependencies Analysis

## Progressive Thinking Application: Think Hard → Think Harder

**Complexity Assessment**: Moderate task requiring systematic document mapping and dependency analysis across multiple workflow components and integration points.

## Executive Summary

The Apply Template workflow (`tpl-create-workflows.md`) requires a comprehensive dependency tree spanning workflow modules, architecture documentation, agent coordination patterns, and quality validation frameworks. This analysis maps 15+ critical documents across 5 execution phases.

## Complete Dependency Mapping

### Phase 1: Foundation Documents (MANDATORY READ FIRST)

#### Core Workflow Infrastructure
1. **`/system/workflows/modules/idx-catalog-workflows.md`** - Universal Workflows Index
   - **Purpose**: Primary workflow catalog and integration architecture
   - **Contains**: Universal workflow components, integration patterns, complexity matrices
   - **Dependencies**: References all 5 universal workflow modules

2. **`/system/templates/tpl-create-workflows.md`** - Apply Template Core
   - **Purpose**: Primary workflow template being analyzed
   - **Contains**: 10-phase composite workflow methodology
   - **Dependencies**: References all universal workflow modules

### Phase 2: Universal Workflow Modules (SEQUENTIAL EXECUTION ORDER)

#### Planning Foundation
3. **`/system/workflows/modules/wfl-plan-execution.md`** - Universal Planning Workflow
   - **Purpose**: 3-step systematic planning methodology
   - **Execution Order**: Phase 5 - Create Implementation Plan
   - **Dependencies**: References SOLID principles

#### Deployment Coordination  
4. **`/system/workflows/modules/wfl-deploy-exploration-agents.md`** - Universal Exploration Deployment
   - **Purpose**: Multi-agent system exploration methodology
   - **Execution Order**: Phase 2 - Deploy Multi-System Exploration Agents
   - **Dependencies**: Agent coordination patterns

#### Implementation Engine
5. **`/system/workflows/modules/wfl-execute-plans.md`** - Universal Execution Workflow
   - **Purpose**: 4-pattern execution methodology (Linear, Parallel, Iterative, Agile)
   - **Execution Order**: Phase 6 - Deploy Multi-Agent Orchestration
   - **Dependencies**: Resource management, quality integration

#### Quality Assurance
6. **`/system/workflows/modules/wfl-validate-success.md`** - Universal Validation Workflow
   - **Purpose**: 4-stage success validation framework
   - **Execution Order**: Phase 7 - Validate Complete Success
   - **Dependencies**: Mathematical success criteria, evidence collection

#### Continuous Improvement
7. **`/system/workflows/modules/wfl-recurse-improvement.md`** - Universal Recursion Workflow
   - **Purpose**: 3-type iterative improvement methodology (Corrective, Optimization, Preventive)
   - **Execution Order**: Phase 8 - Iterate Until Perfect Results
   - **Dependencies**: Learning integration, termination criteria

#### Impact Management
8. **`/system/workflows/modules/wfl-manage-effects.md`** - Universal Ripple Effect Workflow
   - **Purpose**: 4-scale impact management (Local → Domain → System → Enterprise)
   - **Execution Order**: Phase 9 - Manage System-Wide Impact
   - **Dependencies**: Cross-system coordination, automated triggers

### Phase 3: Architecture & Quality Standards (MANDATORY COMPLIANCE)

#### Engineering Standards
9. **`/system/commands-docs/principles/gui-apply-solid.md`** - SOLID Principles for Documentation
   - **Purpose**: Natural language documentation quality standards
   - **Referenced By**: ALL workflow modules for quality compliance
   - **Contains**: SRP, OCP, LSP, ISP, DIP principles for documentation
   - **Dependencies**: Template hierarchy, abstraction patterns

### Phase 4: Implementation Dependencies (RUNTIME REQUIREMENTS)

#### Template System Requirements
10. **Document Template Dependencies** (Referenced but not yet located):
    - `../docs/document-1.md` - Core concepts understanding
    - `../docs/document-2.md` - System requirements verification  
    - `../docs/document-3.md` - Implementation patterns learning

#### Workflow Connection Requirements
11. **Related Workflow Dependencies** (Referenced but not yet located):
    - `prerequisite-workflow.md` - Execute before this workflow
    - `parallel-workflow.md` - Execute simultaneously  
    - `follow-up-workflow.md` - Execute after this workflow
    - `alternative-workflow.md` - Execute instead of this workflow

### Phase 5: Success Criteria & Validation (COMPLETION REQUIREMENTS)

#### Template Integration Components
12. **Success Criteria Templates** (Referenced throughout):
    - Success measurements and calculations
    - Efficiency, Quality, Completeness metrics
    - Mathematical validation formulas
    - Evidence collection frameworks

#### Agent Coordination Requirements
13. **Agent Deployment Dependencies**:
    - Specialized agent roles and capabilities
    - Multi-agent coordination protocols
    - Parallel deployment strategies
    - Result integration methodologies

## Execution Order Dependencies

### Sequential Execution Requirements
```yaml
mandatory_sequence:
  phase_1_foundation:
    - idx-catalog-workflows.md
    - tpl-create-workflows.md
  
  phase_2_workflow_modules:
    - wfl-plan-execution.md (Phase 5)
    - wfl-deploy-exploration-agents.md (Phase 2)  
    - wfl-execute-plans.md (Phase 6)
    - wfl-validate-success.md (Phase 7)
    - wfl-recurse-improvement.md (Phase 8)
    - wfl-manage-effects.md (Phase 9)
  
  phase_3_quality_standards:
    - gui-apply-solid.md (Quality compliance)
  
  phase_4_implementation:
    - document-1.md (Core concepts)
    - document-2.md (System requirements)
    - document-3.md (Implementation patterns)
  
  phase_5_completion:
    - success-criteria-template.md
    - validation-frameworks.md
```

### Parallel Execution Opportunities
```yaml
parallel_execution:
  workflow_modules:
    - All universal workflow modules can be read in parallel
    - Quality standards can be read parallel to workflow modules
  
  implementation_docs:
    - Document-1, document-2, document-3 can be read in parallel
    - Success criteria templates can be prepared in parallel
```

## Critical Integration Points

### Template Composition Architecture
- **Base Template**: `tpl-create-workflows.md` provides structure
- **Universal Modules**: 6 workflow modules provide methodology  
- **Quality Framework**: SOLID principles ensure compliance
- **Agent Coordination**: Multi-agent deployment patterns

### Dependency Risk Assessment
```yaml
high_risk_dependencies:
  - Universal workflow modules (workflow breaks without these)
  - SOLID principles (quality violations without compliance)
  - Agent coordination patterns (deployment failures without protocols)

medium_risk_dependencies:
  - Implementation documents (reduced effectiveness without context)
  - Success criteria templates (manual validation required without automation)

low_risk_dependencies:
  - Related workflow connections (workflow can execute independently)
```

## Document Reading Strategy

### Pre-Execution Reading (MANDATORY)
1. **Foundation Documents**: idx-catalog-workflows.md, tpl-create-workflows.md
2. **Universal Workflow Modules**: All 6 modules for complete methodology
3. **Quality Standards**: gui-apply-solid.md for compliance requirements

### Runtime Reading (AS-NEEDED)
1. **Implementation Context**: document-1/2/3.md when implementing specific domains
2. **Success Validation**: Success criteria templates during validation phases
3. **Related Workflows**: Prerequisite/parallel/follow-up workflows for integration

### Progressive Reading Pattern
```yaml
complexity_based_reading:
  simple_workflows:
    - Foundation documents + 2-3 universal modules
    - Basic quality compliance
  
  moderate_workflows:
    - Foundation + all universal modules
    - Full quality standards
    - Implementation documents
  
  complex_workflows:
    - Complete dependency tree
    - Advanced agent coordination
    - Full validation frameworks
    - Related workflow integration
```

## Recommendations

### Immediate Actions Required
1. **Locate Missing Documents**: Find document-1/2/3.md and related workflow files
2. **Validate Document Paths**: Verify all referenced paths are accessible
3. **Create Dependency Registry**: Maintain centralized dependency tracking

### Framework Enhancement Opportunities
1. **Dependency Validation**: Automated dependency checking before workflow execution
2. **Reading Order Optimization**: Intelligent document sequencing based on complexity
3. **Missing Document Handling**: Graceful degradation when optional documents unavailable

## Conclusion

The Apply Template workflow requires a minimum of **9 mandatory documents** for basic execution and up to **15+ documents** for comprehensive implementation. The dependency tree spans workflow methodology, quality standards, agent coordination, and validation frameworks, requiring systematic reading order and progressive complexity management.

**Total Dependencies Identified**: 15+ documents across 5 execution phases
**Critical Path**: 9 mandatory documents for basic functionality  
**Complexity Management**: Progressive reading strategy based on workflow complexity level