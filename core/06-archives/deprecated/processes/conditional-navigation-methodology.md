
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Conditional Navigation Methodology

**Context**: Playbook-style decision trees for just-in-time context loading to optimize CLAUDE.md performance

---

## Overview

Transform CLAUDE.md from an auto-loading monolith into a lean entry point with conditional navigation to specialized contexts. This methodology reduces context bloat while maintaining comprehensive coverage through guided decision trees.

## Core Principle

**CLAUDE.md = Essential + Conditional Instructions**

Instead of loading all possible contexts automatically, provide decision trees that guide context loading based on:
- Conversation type
- Problem complexity
- Domain specificity
- Project phase

## Process Steps

### 1. **Context Classification**
Categorize all current CLAUDE.md content into:
- **Core Essential**: Tools, basic preferences, quality promise (always loaded)
- **Conditional**: Specialized workflows, advanced patterns, domain-specific knowledge
- **Situational**: Project-specific, experimental, or rarely-used preferences

### 2. **Decision Tree Design**
Structure conditional instructions using IF-THEN patterns:

```
IF conversation involves framework maintenance
  → READ system/PRINCIPLES.md for architectural decisions
  → READ system/STANDARDS.md for consistency guidelines

IF creating or modifying agents
  → READ work/agent-template-creation/ for templates
  → READ agents/registry/ for existing patterns

IF evaluating framework effectiveness  
  → READ work/claude-md-evaluation/ for methodology
  → READ system/tools/ for available scripts
```

### 3. **Playbook Structure Implementation**
Create navigational logic that:
- Starts with conversation analysis
- Provides clear READ instructions
- Chains related contexts logically
- Avoids auto-loading everything

### 4. **Just-in-Time Loading**
Replace static preferences with precision-targeted guidance:
- **Before**: All agent creation details in CLAUDE.md
- **After**: "For agent work, READ system/processes/agent-creation-workflow.md#agent-creation-process"
- **Section Targeting**: Use #section links for precise context loading
- **Directory Loading**: Use @directory/ syntax only when comprehensive context needed
- **Precision Strategy**: Target exact information needed rather than loading entire files

### 5. **Performance Optimization**
Monitor and adjust:
- Track which conditionals are frequently triggered
- Identify patterns that could be promoted to core
- Remove unused decision branches
- Optimize file organization for common paths

## Decision Tree Templates

### Framework Maintenance
```
IF maintaining .claude framework
  → READ system/PRINCIPLES.md#work-approach for core philosophy
  → IF structure changes: READ system/STANDARDS.md#file-and-organization-standards
  → IF evaluation needed: READ system/processes/framework-evaluation-workflow.md#evaluation-schedule
```

### Development Work
```
IF implementing new features
  → READ system/STANDARDS.md#technical-standards for coding conventions
  → IF testing required: READ system/processes/test-driven-development-workflow.md#tdd-implementation
  → IF complex analysis: READ system/processes/progressive-thinking.md#breakdown-methodology
```

### Agent Coordination
```
IF deploying agents
  → READ system/processes/strategic-orchestration-workflow.md#strategic-orchestrator-role
  → IF creating agents: READ system/processes/agent-creation-workflow.md#agent-creation-process
  → IF parallel coordination: READ system/processes/parallel-agent-coordination-workflow.md#coordination-protocol
```

### Historical Context & Insights
```
IF need strategic patterns
  → READ work/[specific-analysis]/#key-findings
  → IF evaluation metrics: READ work/claude-md-evaluation/#success-metrics
  → IF session patterns: READ work/[timestamp-folder]/#strategic-insights
```

### Section-Specific Loading Strategy
```
system/PRINCIPLES.md#work-approach        → Core working principles
system/STANDARDS.md#technical-standards   → Code quality requirements  
system/PROCESSES.md#thinking-processes    → Analysis methodologies
system/EXAMPLES.md#[category]             → Specific implementation patterns
work/[folder]/#[insight-section]    → Targeted historical context
```

## Implementation Guidelines

### CLAUDE.md Structure
```markdown
## Mandatory Tools Usage
[Essential tools that apply to every conversation]

## Core User Preferences  
[Basic working patterns needed universally]

## Conditional Navigation
[Decision trees for specialized contexts]

## Quality Promise
[What user expects from every interaction]
```

### Conditional Instruction Format
- **Clear triggers**: "IF conversation involves X"
- **Precision targeting**: "READ exact-file-path.md#specific-section" for surgical context loading
- **Fallback options**: Use full file or @directory/ only when section targeting insufficient
- **Section hierarchy**: Target most specific section first, broader context as needed
- **Logical chaining**: Guide through related contexts progressively
- **Purpose clarity**: Explain why each section matters for the specific scenario

## Benefits

### Performance
- **Surgical precision**: Section-specific loading eliminates irrelevant context
- **Minimal overhead**: Load only the exact information needed for the scenario
- **Faster conversation starts**: Lean CLAUDE.md loads quickly
- **Targeted expertise**: Access precise knowledge sections when relevant
- **Reduced parsing**: Less content to process and understand

### Maintainability  
- **Modular organization**: Specialized knowledge in dedicated files
- **Easier updates**: Change specific domains without affecting core
- **Clear separation**: Core vs. conditional preferences

### User Experience
- **Responsive behavior**: Context matches conversation needs
- **Comprehensive coverage**: All knowledge remains accessible
- **Intelligent navigation**: Guided path to relevant information

## Success Metrics

- CLAUDE.md line count reduction without functionality loss
- Faster initial response times
- Maintained or improved task completion quality
- User satisfaction with context relevance

## Related Processes

- **[Progressive Thinking](progressive-thinking.md)** - Breaking down complex navigation decisions
- **[Research and Document](research-and-document.md)** - Finding and organizing conditional contexts
- **[Complete Workflow](complete-workflow.md)** - Integration with main process flow

---

