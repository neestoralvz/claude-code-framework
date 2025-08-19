---
title: "Analyze Command"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["workflow.md", "fundamental.md", "engineering.md"]
prerequisites: ["Completed exploration phase", "Comprehensive context available"]
audience: "System architects and solution designers"
purpose: "Execute Phase 3 workflow: Transform findings into actionable solution frameworks"
keywords: ["analysis", "workflow", "phase3", "solution-frameworks", "findings"]
last_review: "2025-08-18"
---

[Previous: Deploy Explore Command](explore.md) | [Return to Documentation Hub for navigation](../docs/index.md) | [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md) | [Next: Deploy Present Solutions Command](present-solutions.md)

# ANALYZE COMMAND

## Purpose

⏺ **Principle**: This command implements [workflow.md Phase 3](../docs/principles/workflow.md) by transforming exploration findings into actionable solution frameworks, and applies [fundamental.md evidence approach](../docs/principles/fundamental.md) through systematic analysis.

Execute comprehensive analysis of gathered information to identify patterns, constraints, and opportunities, generating structured solution frameworks.

## Command Syntax

```bash
# Basic usage - comprehensive analysis
analyze

# With specific focus
analyze --focus [patterns|constraints|opportunities|risks]

# With analysis depth
analyze --depth [surface|detailed|comprehensive] --methodology [comparative|root-cause|impact]
```

## Execution Workflow

### Phase 1: Information Processing
- Review and categorize exploration findings
- Identify key patterns and relationships
- Extract actionable insights from context
- Document analysis baseline

### Phase 2: Constraint Identification
- Map technical limitations and dependencies
- Identify resource and timeline constraints
- Catalog organizational and policy restrictions
- Document risk factors and mitigation needs

### Phase 3: Opportunity Discovery
- Identify potential solution approaches
- Map optimization and improvement opportunities
- Discover reusable components and patterns
- Catalog innovation and enhancement possibilities

### Phase 4: Framework Generation
- Synthesize findings into solution frameworks
- Structure approaches by feasibility and impact
- Prepare foundation for solution presentation
- Document analysis results for decision-making

## Parameters

### Required Parameters
None - command processes exploration outputs automatically

### Optional Parameters
- **--focus**: Target specific analysis area (patterns|constraints|opportunities|risks)
- **--depth**: Analysis thoroughness (surface|detailed|comprehensive)
- **--methodology**: Analysis approach (comparative|root-cause|impact|feasibility)
- **--output-format**: Result format (executive|technical|framework-oriented)

## Expected Output

```bash
ANALYSIS RESULTS
================

Key Patterns Identified:
├── Technical Patterns
│   ├── [Pattern 1: Description and implications]
│   └── [Pattern 2: Description and implications]
├── Architectural Patterns
│   ├── [Pattern A: Current state and recommendations]
│   └── [Pattern B: Current state and recommendations]
└── Process Patterns
    ├── [Process 1: Efficiency opportunities]
    └── [Process 2: Optimization potential]

Constraints Analysis:
- Technical: [Critical technical limitations]
- Resource: [Time, budget, and skill constraints]
- Organizational: [Policy and process restrictions]

Solution Frameworks:
1. **[Framework 1]**: [Approach summary]
   - Strengths: [Key advantages]
   - Constraints: [Limitations to consider]
   - Feasibility: [Implementation assessment]

2. **[Framework 2]**: [Approach summary]
   - Strengths: [Key advantages]
   - Constraints: [Limitations to consider]
   - Feasibility: [Implementation assessment]

Recommendations:
- [High-priority recommendation 1]
- [High-priority recommendation 2]
- [High-priority recommendation 3]

Ready for Solution Presentation Phase
```

## Integration Points

### Workflow Integration
- Processes exploration phase outputs systematically
- Generates frameworks for solution presentation phase
- Establishes analytical foundation for planning phase

### Agent Integration
- Deploys analysis-specialist agent when available
- Coordinates with project-optimizer for complex analysis
- Integrates with engineering agents for technical assessment

## Success Criteria

- [ ] All exploration findings analyzed and categorized
- [ ] Key patterns and constraints identified
- [ ] Solution frameworks generated and documented
- [ ] Feasibility assessments completed
- [ ] Ready to proceed to solution presentation phase

## Usage Examples

### Comprehensive Analysis
```bash
analyze
# Expected result: Complete analysis of all exploration findings with solution frameworks
```

### Pattern-Focused Analysis
```bash
analyze --focus patterns --depth comprehensive
# Expected result: Deep analysis of patterns with detailed implications
```

### Comparative Methodology
```bash
analyze --methodology comparative --output-format framework-oriented
# Expected result: Comparative analysis structured for solution framework development
```

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../docs/index.md)
- [Browse commands index](index.md)
- [Study PRINCIPLES.md](../docs/PRINCIPLES.md)

### Related Commands
- [Explore command](explore.md) - Previous workflow phase
- [Present solutions command](present-solutions.md) - Next workflow phase
- [Analyze file command](analyze-file.md) - Complementary analysis tool

### Principle References
- [Apply workflow.md for systematic execution](../docs/principles/workflow.md)
- [Use fundamental.md for evidence-based analysis](../docs/principles/fundamental.md)
- [Follow engineering.md for technical standards](../docs/principles/engineering.md)

[⬆ Return to top](#analyze-command)