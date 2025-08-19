---
title: "Complete Analysis Workflow"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../../docs/principles/command-workflow-principles.md", "../../docs/components/command-concatenation.md"]
prerequisites: ["Understanding of 8-phase workflow", "Knowledge of analysis commands"]
audience: "System operators and analysts"
purpose: "Pre-built command composition for comprehensive system analysis"
keywords: ["composition", "analysis", "workflow", "automation", "comprehensive"]
last_review: "2025-08-18"
---

[Previous: Browse commands index](../index.md) | [Return to Documentation Hub](../../docs/index.md) | [Study PRINCIPLES.md](../../docs/PRINCIPLES.md) | [Next: View optimization-cycle.md](optimization-cycle.md)

# COMPLETE ANALYSIS WORKFLOW

## Definition
Pre-built command composition that executes comprehensive system analysis through coordinated workflow phases and specialized analysis commands.

⏺ **Principle**: This composition implements [Apply command-workflow-principles.md systematic command concatenation](../../docs/principles/command-workflow-principles.md#command-composition) through systematic command concatenation for complete analytical coverage.

## Command Composition

### Basic Complete Analysis
```bash
# Sequential comprehensive analysis
1-clarify --scope comprehensive | 
2-explore --depth detailed | 
../analysis/system-audit --scope comprehensive | 
../analysis/analyze-dependencies --scope full | 
3-analyze --methodology systematic | 
4-present-solutions --format comprehensive | 
8-validate --depth thorough
```

### Parallel Analysis Variant
```bash
# Parallel analysis execution
1-clarify --scope comprehensive |
2-explore --depth detailed |
(../analysis/system-audit --scope comprehensive & ../analysis/analyze-dependencies --scope full) |
merge-analysis-results |
3-analyze --methodology comparative |
4-present-solutions --format decision-tree |
8-validate --depth comprehensive
```

### Ticket-Generating Analysis
```bash
# Analysis with automatic ticket generation
1-clarify --scope comprehensive |
2-explore --depth detailed |
../analysis/system-audit --scope comprehensive |
[if violations_found] ../management/create-ticket --priority HIGH |
../analysis/modularize --search |
[if patterns_found] ../management/create-ticket --category refactoring |
3-analyze --methodology systematic |
8-validate --criteria complete
```

## Configuration Options

### Scope Parameters
- `--scope minimal`: Basic analysis with essential checks
- `--scope standard`: Standard comprehensive analysis
- `--scope comprehensive`: Full detailed analysis with all checks

### Output Formats
- `--output summary`: High-level findings summary
- `--output detailed`: Complete analysis report
- `--output structured`: JSON-formatted results for further processing

### Analysis Depth
- `--depth surface`: Quick overview analysis
- `--depth standard`: Normal depth analysis
- `--depth comprehensive`: Deep analysis with detailed examination

## Success Criteria

### Analysis Completion
- [ ] All system components examined
- [ ] Dependencies mapped and analyzed
- [ ] Violations and issues identified
- [ ] Improvement opportunities documented
- [ ] Results validated and verified

### Quality Standards
- [ ] Analysis coverage meets scope requirements
- [ ] Findings are actionable and prioritized
- [ ] Dependencies are accurately mapped
- [ ] Generated tickets are properly categorized
- [ ] Validation criteria fully satisfied

## Usage Examples

### Standard Project Analysis
```bash
complete-analysis --scope standard --output detailed --validation thorough
```

### Quick Health Check
```bash
complete-analysis --scope minimal --output summary --depth surface
```

### Comprehensive System Review
```bash
complete-analysis --scope comprehensive --output structured --generate-tickets
```

## Integration Points

### Input Requirements
- Target system or project path
- Analysis scope specification
- Output format preferences

### Output Products
- Comprehensive analysis report
- Dependency maps and relationship diagrams
- Prioritized issue and improvement lists
- Generated tickets for identified opportunities
- Validation results and quality metrics

## Cross-References

### Primary Navigation
- [Return to commands index](../index.md)
- [Study command-workflow-principles.md composition methodology](../../docs/principles/command-workflow-principles.md)
- [Learn command-concatenation.md chaining patterns](../../docs/components/command-concatenation.md)

### Component Commands
- [Execute 1-clarify.md requirements understanding](../workflow/1-clarify.md)
- [Execute 2-explore.md context gathering](../workflow/2-explore.md)
- [Execute 3-analyze.md solution frameworks](../workflow/3-analyze.md)
- [Execute system-audit.md comprehensive examination](../analysis/system-audit.md)
- [Execute analyze-dependencies.md dependency mapping](../analysis/analyze-dependencies.md)

### Related Compositions
- [View optimization-cycle.md iterative improvement](optimization-cycle.md)
- [View parallel-development.md coordinated execution](parallel-development.md)

[⬆ Return to top](#complete-analysis-workflow)