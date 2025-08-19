---
title: "Present Solutions Command"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["workflow.md", "communication.md", "fundamental.md"]
prerequisites: ["Completed analysis phase", "Solution frameworks available"]
audience: "Decision makers and stakeholders"
purpose: "Execute Phase 4 workflow: Enable informed decision-making through structured dialogue"
keywords: ["solution-presentation", "workflow", "phase4", "decision-making", "structured-dialogue"]
last_review: "2025-08-18"
---

[Previous: Deploy Analyze Command](analyze.md) | [Return to Documentation Hub for navigation](../docs/index.md) | [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md) | [Next: Deploy Plan Command](plan.md)

# PRESENT SOLUTIONS COMMAND

## Purpose

⏺ **Principle**: This command implements [Apply workflow.md Phase 4 decision facilitation](../../docs/principles/workflow.md#4-present-solutions) by enabling informed decision-making through structured dialogue, and applies [Apply communication.md clear option presentation](../../docs/principles/communication.md#imperative-patterns) through clear option presentation.

Execute structured presentation of solution alternatives with comparative analysis to facilitate informed stakeholder decision-making.

## Command Syntax

```bash
# Basic usage - present all solution options
present-solutions

# With specific comparison focus
present-solutions --compare [feasibility|cost|risk|timeline|impact]

# With presentation format
present-solutions --format [executive|technical|comparative-matrix|decision-tree]
```

## Execution Workflow

### Phase 1: Solution Structuring
- Organize analysis frameworks into clear alternatives
- Define evaluation criteria and trade-offs
- Prepare comparative matrices and assessments
- Structure presentation for decision clarity

### Phase 2: Option Presentation
- Present each solution alternative systematically
- Highlight strengths, weaknesses, and implications
- Provide implementation effort and risk assessments
- Enable clear comparison between options

### Phase 3: Interactive Dialogue
- Facilitate stakeholder questions and clarifications
- Address concerns and explore modifications
- Gather preferences and constraint priorities
- Enable collaborative option refinement

### Phase 4: Decision Facilitation
- Summarize stakeholder inputs and preferences
- Recommend optimal solution based on criteria
- Document decision rationale and next steps
- Prepare selected solution for planning phase

## Parameters

### Required Parameters
None - command processes analysis outputs automatically

### Optional Parameters
- **--compare**: Focus comparison on specific dimension (feasibility|cost|risk|timeline|impact)
- **--format**: Presentation format (executive|technical|comparative-matrix|decision-tree)
- **--criteria**: Custom evaluation criteria for comparison
- **--stakeholders**: Target stakeholder group for presentation adaptation

## Expected Output

```bash
SOLUTION PRESENTATION
=====================

Executive Summary:
- Challenge: [Brief problem statement]
- Options: [Number] solution alternatives identified
- Recommendation: [Preferred solution with rationale]

Solution Alternatives:

┌─ OPTION 1: [Solution Name]
├─ Description: [Clear solution summary]
├─ Strengths:
│  ├─ [Key advantage 1]
│  ├─ [Key advantage 2]
│  └─ [Key advantage 3]
├─ Trade-offs:
│  ├─ [Constraint or limitation 1]
│  └─ [Constraint or limitation 2]
├─ Implementation:
│  ├─ Effort: [Time/resource estimate]
│  ├─ Risk: [Risk level and factors]
│  └─ Dependencies: [Key requirements]
└─ Impact: [Expected outcomes]

┌─ OPTION 2: [Solution Name]
├─ [Similar structure...]

Comparative Analysis:
                    Option 1    Option 2    Option 3
Feasibility         High        Medium      Low
Implementation Time 2 weeks     4 weeks     8 weeks
Risk Level          Low         Medium      High
Long-term Value     High        High        Medium

Decision Points:
1. [Key decision criterion 1]
2. [Key decision criterion 2]
3. [Key decision criterion 3]

Recommendation:
Based on [evaluation criteria], Option [X] is recommended because:
- [Primary reason]
- [Secondary reason]
- [Supporting factor]

Next Steps:
□ Stakeholder decision on preferred option
□ Proceed to planning phase with selected solution
□ Address any identified dependencies or prerequisites
```

## Integration Points

### Workflow Integration
- Transforms analysis outputs into decision-ready presentations
- Facilitates stakeholder input collection
- Prepares selected solution for planning phase

### Stakeholder Integration
- Adapts presentation style to audience needs
- Facilitates collaborative decision-making process
- Documents decisions for future reference

## Success Criteria

- [ ] All solution alternatives clearly presented
- [ ] Comparative analysis provided with objective criteria
- [ ] Stakeholder questions addressed and inputs gathered
- [ ] Decision made on preferred solution approach
- [ ] Selected solution documented and ready for planning

## Usage Examples

### Comprehensive Presentation
```bash
present-solutions
# Expected result: Complete presentation of all solutions with full comparative analysis
```

### Feasibility-Focused Comparison
```bash
present-solutions --compare feasibility --format comparative-matrix
# Expected result: Matrix comparing solutions primarily on feasibility factors
```

### Executive Format
```bash
present-solutions --format executive --stakeholders leadership
# Expected result: Executive summary format adapted for leadership decision-making
```

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../docs/index.md)
- [Browse commands index](index.md)
- [Study PRINCIPLES.md](../docs/PRINCIPLES.md)

### Related Commands
- [Analyze command](analyze.md) - Previous workflow phase
- [Plan command](plan.md) - Next workflow phase
- [Clarify command](clarify.md) - For decision criteria clarification

### Principle References
- [Apply workflow.md for systematic execution](../docs/principles/workflow.md)
- [Use communication.md for clear presentation](../docs/principles/communication.md)
- [Follow fundamental.md for evidence-based recommendations](../docs/principles/fundamental.md)

[⬆ Return to top](#present-solutions-command)