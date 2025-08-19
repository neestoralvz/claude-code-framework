---
title: "Explore Command"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["workflow.md", "fundamental.md", "context-efficiency.md"]
prerequisites: ["Completed clarification phase", "Defined success criteria"]
audience: "System operators and information gatherers"
purpose: "Execute Phase 2 workflow: Gather comprehensive contextual information"
keywords: ["exploration", "workflow", "phase2", "context", "information-gathering"]
last_review: "2025-08-18"
---

[Previous: Deploy Clarify Command](clarify.md) | [Return to Documentation Hub for navigation](../docs/index.md) | [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md) | [Next: Deploy Analysis Command](analyze.md)

# EXPLORE COMMAND

## Purpose

⏺ **Principle**: This command implements [Apply workflow.md Phase 2 context gathering](../../docs/principles/workflow.md#2-exploration) by gathering comprehensive contextual information, and applies [Apply fundamental.md context methods](../../docs/principles/fundamental.md#context-requirements) through systematic discovery.

Execute comprehensive exploration of codebase, documentation, and relevant context to build complete understanding foundation for informed analysis.

## Command Syntax

```bash
# Basic usage - comprehensive exploration
explore

# With specific scope
explore --scope [codebase|documentation|dependencies|architecture]

# With targeted search
explore --target "search-pattern" --depth [shallow|deep|comprehensive]
```

## Execution Workflow

### Phase 1: Context Mapping
- Identify relevant file structures and directories
- Map existing documentation and specifications
- Catalog related systems and dependencies
- Document current state baseline

### Phase 2: Information Discovery
- Search codebase for relevant patterns and implementations
- Read key documentation and configuration files
- Analyze existing solutions and approaches
- Gather stakeholder requirements and constraints

### Phase 3: Relationship Analysis
- Map dependencies between components
- Identify integration points and interfaces
- Document data flows and interactions
- Catalog potential impact areas

### Phase 4: Context Synthesis
- Consolidate findings into coherent context map
- Identify knowledge gaps requiring additional research
- Prepare contextual foundation for analysis phase
- Document exploration results for team reference

## Parameters

### Required Parameters
None - command uses clarification outputs as starting point

### Optional Parameters
- **--scope**: Focus exploration on specific area (codebase|documentation|dependencies|architecture)
- **--target**: Specific search pattern or component to investigate
- **--depth**: Exploration thoroughness (shallow|deep|comprehensive)
- **--output-format**: Result format (summary|detailed|technical-report)

## Expected Output

```bash
EXPLORATION RESULTS
===================

Context Map:
├── Codebase Structure
│   ├── [Key directories and files]
│   └── [Implementation patterns found]
├── Documentation
│   ├── [Relevant docs discovered]
│   └── [Specification details]
└── Dependencies
    ├── [External dependencies]
    └── [Internal relationships]

Key Findings:
- [Critical discovery 1]
- [Critical discovery 2]
- [Critical discovery 3]

Knowledge Gaps:
- [Area requiring further investigation]
- [Missing information needed]

Ready for Analysis:
✓ Context foundation established
✓ Key information gathered
✓ Dependencies mapped
✓ Ready to proceed to analysis phase
```

## Integration Points

### Workflow Integration
- Consumes clarification outputs as starting point
- Feeds comprehensive context into analysis phase
- Establishes information baseline for solution development

### Agent Integration
- Deploys exploration-specialist agent when available
- Coordinates with general-purpose agent for broad searches
- Integrates with project-optimizer for architectural exploration

## Success Criteria

- [ ] Comprehensive context map created
- [ ] All relevant information sources identified and analyzed
- [ ] Dependencies and relationships documented
- [ ] Knowledge gaps identified for targeted research
- [ ] Contextual foundation ready for analysis phase

## Usage Examples

### Comprehensive Exploration
```bash
explore
# Expected result: Complete contextual analysis of all relevant areas
```

### Focused Codebase Exploration
```bash
explore --scope codebase --depth deep
# Expected result: Detailed analysis of code structure and patterns
```

### Targeted Component Investigation
```bash
explore --target "authentication" --depth comprehensive
# Expected result: Thorough exploration of authentication-related components
```

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../docs/index.md)
- [Browse commands index](index.md)
- [Study PRINCIPLES.md](../docs/PRINCIPLES.md)

### Related Commands
- [Clarify command](clarify.md) - Previous workflow phase
- [Analysis command](analyze.md) - Next workflow phase
- [System audit command](system-audit.md) - Complementary exploration tool

### Principle References
- [Apply workflow.md for systematic execution](../docs/principles/workflow.md)
- [Use fundamental.md for context methods](../docs/principles/fundamental.md)
- [Follow context-efficiency.md for information gathering](../docs/principles/context-efficiency.md)

[⬆ Return to top](#explore-command)