---
title: "Clarify Command"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["workflow.md", "directive.md", "fundamental.md"]
prerequisites: ["Understanding of workflow phases", "Basic request analysis"]
audience: "System operators and task coordinators"
purpose: "Execute Phase 1 workflow: Establish complete request understanding and success criteria"
keywords: ["clarification", "workflow", "phase1", "understanding", "success-criteria"]
last_review: "2025-08-18"
---

[Previous: Navigate to Commands Index](index.md) | [Return to Documentation Hub for navigation](../docs/index.md) | [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md) | [Next: Deploy Exploration Command](explore.md)

# CLARIFY COMMAND

## Purpose

⏺ **Principle**: This command implements [Apply workflow.md Phase 1 requirements understanding](../../docs/principles/workflow.md#1-clarification) by establishing complete request understanding and success criteria, and applies [Follow directive.md systematic requirement validation](../../docs/principles/directive.md#command-adherence) through systematic requirement validation.

Execute systematic clarification of user requests to transform ambiguous requirements into actionable specifications with measurable success criteria.

## Command Syntax

```bash
# Basic usage - clarify current request
clarify

# With specific focus area
clarify --focus [scope|requirements|constraints|success-criteria]

# With validation mode
clarify --validate-understanding
```

## Execution Workflow

### Phase 1: Request Analysis
- Parse user request for explicit requirements
- Identify implicit assumptions and unstated needs
- Catalog ambiguous terms and undefined scope
- Document initial interpretation

### Phase 2: Gap Identification
- Identify missing requirement specifications
- Detect unclear success criteria
- Find undefined constraints and boundaries
- Map stakeholder assumptions

### Phase 3: Structured Inquiry
- Generate targeted clarification questions
- Prioritize questions by impact on execution
- Structure questions for efficient dialogue
- Prepare validation checkpoints

### Phase 4: Understanding Validation
- Confirm interpretation accuracy with user
- Establish measurable success criteria
- Validate scope boundaries and constraints
- Document final requirement specification

## Parameters

### Required Parameters
None - command analyzes current conversation context

### Optional Parameters
- **--focus**: Target specific clarification area (scope|requirements|constraints|success-criteria)
- **--validate-understanding**: Run validation mode to confirm current understanding
- **--output-format**: Specify output format (summary|detailed|checklist)

## Expected Output

```bash
CLARIFICATION ANALYSIS
======================

Current Understanding:
- [Interpreted requirement 1]
- [Interpreted requirement 2]
- [Interpreted requirement 3]

Clarification Questions:
1. [Targeted question about scope]
2. [Targeted question about requirements]
3. [Targeted question about success criteria]

Success Criteria (Draft):
- [ ] [Measurable criterion 1]
- [ ] [Measurable criterion 2]
- [ ] [Measurable criterion 3]

Next Steps:
- Await user responses to clarification questions
- Finalize success criteria based on responses
- Proceed to exploration phase when complete
```

## Integration Points

### Workflow Integration
- Initiates 8-phase workflow execution
- Outputs feed directly into exploration phase
- Establishes baseline for validation phase

### Agent Integration
- Deploys clarification-specialist agent when available
- Coordinates with project-optimizer for complex requests
- Integrates with task-orchestration for multi-phase planning

## Success Criteria

- [ ] All ambiguous terms defined and documented
- [ ] Measurable success criteria established
- [ ] Scope boundaries clearly delineated
- [ ] User confirms understanding accuracy
- [ ] Ready to proceed to exploration phase

## Usage Examples

### Basic Clarification
```bash
clarify
# Expected result: Complete analysis of current request with clarification questions
```

### Focused Clarification
```bash
clarify --focus success-criteria
# Expected result: Targeted analysis focusing on success criteria definition
```

### Understanding Validation
```bash
clarify --validate-understanding
# Expected result: Validation summary of current interpretation
```

## Situational Guidance

### When to Use This Command
- ✅ **Starting new work** - Requirements unclear or ambiguous
- ✅ **Scope disputes** - Stakeholders have different interpretations  
- ✅ **Success criteria missing** - No clear definition of completion
- ✅ **Complex requests** - Multiple components or unclear priorities
- ✅ **Requirement evolution** - Original requirements have changed

### When NOT to Use This Command
- ❌ **Requirements crystal clear** - Skip to exploration phase
- ❌ **Routine maintenance** - Standard procedures apply
- ❌ **Emergency fixes** - Time-critical situations need immediate action
- ❌ **Well-defined scope** - Proceed directly to exploration

### Problem-Specific Actions
| Problem | Specific Command | Expected Outcome |
|---------|------------------|------------------|
| **Vague requirements** | `clarify --focus requirements --output-format detailed` | Clear requirement specification |
| **No success criteria** | `clarify --focus success-criteria --validate-understanding` | Measurable completion criteria |
| **Scope creep risk** | `clarify --focus scope --output-format summary` | Defined boundaries |
| **Stakeholder conflict** | `clarify --validate-understanding` | Aligned understanding |
| **Time pressure** | `clarify --output-format summary` | Quick consensus |

### Next Phase Preparation
**Ready for exploration when**:
- ✅ All stakeholders agree on requirements
- ✅ Success criteria are measurable and clear
- ✅ Scope boundaries are well-defined
- ✅ Assumptions are documented and validated

**If not ready**: Use [Apply workflow operational guidance alternative paths](../../docs/principles/workflow.md#quick-decision-navigation) for alternative paths.

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../docs/index.md)
- [Browse commands index](index.md)
- [Study PRINCIPLES.md](../docs/PRINCIPLES.md)

### Operational Guidance
- [Use workflow operational guidance decision trees](../../docs/principles/workflow.md#operational-guidance) - All decision trees and phase-specific actions
- [Follow workflow phases execution methodology](../../docs/components/workflow-phases.md#1-clarification)

### Related Commands
- [Execute 2-explore.md next workflow phase](2-explore.md) - Next workflow phase
- [Execute 9-debug.md clarification issues](9-debug.md) - If clarification issues occur
- [Execute 10-recurse.md requirements change](10-recurse.md) - If requirements significantly change

### Principle References
- [Apply workflow.md systematic execution](../../docs/principles/workflow.md#execution-phases)
- [Follow directive.md command adherence](../../docs/principles/directive.md#command-adherence)
- [Use fundamental.md evidence-based approach](../../docs/principles/fundamental.md#evidence-requirements)

[⬆ Return to top](#clarify-command)