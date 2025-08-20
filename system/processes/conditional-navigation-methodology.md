[🏠 System Hub](../INDEX.md) | [📁 Processes](../PROCESSES.md) | [📖 Current Section](#)

---

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
  → READ operations/agent-template-creation/ for templates
  → READ agents/registry/ for existing patterns

IF evaluating framework effectiveness  
  → READ operations/claude-md-evaluation/ for methodology
  → READ system/tools/ for available scripts
```

### 3. **Playbook Structure Implementation**
Create navigational logic that:
- Starts with conversation analysis
- Provides clear READ instructions
- Chains related contexts logically
- Avoids auto-loading everything

### 4. **Just-in-Time Loading**
Replace static preferences with dynamic guidance:
- **Before**: All agent creation details in CLAUDE.md
- **After**: "For agent work, READ operations/agent-template-creation/"

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
  → READ system/PRINCIPLES.md for core philosophy
  → IF structure changes needed: READ system/STANDARDS.md
  → IF process updates needed: READ system/PROCESSES.md
  → IF validation needed: READ operations/claude-md-evaluation/
```

### Development Work
```
IF implementing new features
  → READ system/STANDARDS.md for coding conventions
  → IF testing required: READ processes/test-driven-development-workflow.md
  → IF complex analysis: READ processes/progressive-thinking.md
```

### Agent Coordination
```
IF deploying agents
  → READ operations/agent-template-creation/ for templates
  → IF specialized agents: READ agents/ subdirectories by category
  → IF parallel coordination: READ processes/parallel-agent-coordination-workflow.md
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
- **Specific actions**: "READ exact-file-path.md"
- **Logical chaining**: Guide through related contexts
- **Purpose clarity**: Explain why each context matters

## Benefits

### Performance
- **Reduced context bloat**: Only load what's needed
- **Faster conversation starts**: Lean CLAUDE.md loads quickly
- **Targeted expertise**: Access deep knowledge when relevant

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

**Navigation:** [↑ Processes](../PROCESSES.md) | [🏠 System Home](../INDEX.md)