---
title: "Claude Code Framework Playbook"
author: "Claude Code System"
date: "2025-08-19"
version: "2.0.0"
purpose: "MANDATORY execution interface for Claude Code Framework - ALL CONTENT IS ESSENTIAL"
dependencies: ["commands/index.md", "docs/principles/workflow.md"]
---

[🏠 Framework Hub](docs/index.md) | [⚡ Commands](commands/index.md) | [🔄 Workflow](docs/principles/workflow.md) | [📋 Success Criteria](docs/components/success-criteria-template.md)

# CLAUDE CODE FRAMEWORK PLAYBOOK

## ⚡ MANDATORY EXECUTION ON EVERY REQUEST

**OBLIGATORY FLOW**: Request → Task + subagent_type + Command → 9-Phase Automatic → Validation → Response

### 1. EXECUTE COMMAND SELECTION IMMEDIATELY

- **ANALYZE REQUEST IMMEDIATELY**: Evaluate context, complexity, domain, requirements
- **CONSULT COMMAND INDEX**: READ [commands/index.md](commands/index.md) for available options
- **USE INTELLIGENT SELECTION**: APPLY [Command Reference Matrix](commands/COMMAND_REFERENCE_MATRIX.md) for:
  - Task complexity assessment (simple/moderate/complex)
  - Execution time estimation (1-5min/5-20min/20+min) 
  - Resource requirements (low/moderate/high)
  - Validation level needs (basic/comprehensive/enterprise)
- **DETERMINE OPTIMAL AGENT**: USE [Agent Workflow Mapping](commands/AGENT_WORKFLOW_MAPPING.md) for:
  - Phase-specific agent selection (9-phase workflow mapping)
  - Specialization matching (domain expertise alignment)
  - Coordination pattern selection (sequential/parallel/hierarchical)

### 2. EXECUTE TASK TOOLS WITH ORCHESTRATOR STRUCTURE

**MANDATORY PRIORITY**: ANALYZE task dependencies and EXECUTE multiple Task tools in the same message when possible.

#### Single Task Execution
```markdown
Task(
  subagent_type: "{agent-determined-dynamically}",
  description: "{specific-description-linked-to-prompt}",
  prompt: "I am the orchestrator and you are the {determined-agent} agent. 
          Search for relevant files in commands/ and docs/ for your execution.
          {specific-context-of-request}
          Execute the slash command /{selected-command} or complete instruction: {detailed-instruction}"
)
```

#### Parallel Task Execution (MANDATORY WHEN POSSIBLE)
```markdown
Task(
  subagent_type: "workflow-coordinator",
  description: "Coordinate parallel execution of {task-1}",
  prompt: "I am the orchestrator and you are the workflow-coordinator agent..."
)

Task(
  subagent_type: "exploration-analyst", 
  description: "Analyze system state for {task-2}",
  prompt: "I am the orchestrator and you are the exploration-analyst agent..."
)
```

#### Multiple Agent Deployment (MANDATORY FOR INDEPENDENT FILES)
```markdown
Task(
  subagent_type: "component-architect",
  description: "Create component A independently",
  prompt: "I am the orchestrator and you are the component-architect agent..."
)

Task(
  subagent_type: "component-architect",
  description: "Create component B independently", 
  prompt: "I am the orchestrator and you are the component-architect agent..."
)
```
**MANDATORY NOTE**: DEPLOY same agent multiple times for independent file operations.

### 3. APPLY PROGRESSIVE THINKING AND SYSTEM PRINCIPLES

**MANDATORY PROGRESSIVE THINKING LEVELS**:
- **Think**: Basic analysis and solution identification
- **Think Hard**: Deep analysis with multiple perspectives and edge cases
- **Think Harder**: Complex systems thinking with interdependencies and implications
- **UltraThink**: Comprehensive analysis with long-term consequences and framework evolution

**MANDATORY SYSTEM PRINCIPLES**: ALWAYS FOLLOW [Framework Principles](docs/principles/index.md) → **READ IMMEDIATELY WHEN**: You need authority chain, execution priorities, integration patterns, or principle conflicts. START WITH [directive.md](docs/principles/directive.md) for framework authority and [workflow.md](docs/principles/workflow.md) for systematic execution.

### 4. AUTOMATIC 9-PHASE WORKFLOW EXECUTION

**Commands EXECUTE complete 9-Phase methodology automatically with TodoWrite tracking, progressive thinking integration, and modern research capabilities.**

---

## 🔄 MANDATORY 9-PHASE WORKFLOW

**Commands EXECUTE complete 9-Phase methodology automatically with TodoWrite tracking, progressive thinking integration, and modern research capabilities including WebSearch and Context7.**

### PHASE 1: CLARIFICATION
**ESTABLISH complete request understanding and success criteria**
- **CONFIRM** specific target or aspect
- **VERIFY** scope and parameters  
- **VALIDATE** input criteria
- **Git Operations**: `git status`, `git branch -v`, verify clean working directory
- **COMPLETE WHEN**: Requirements clear, success criteria defined, stakeholder alignment confirmed
- **DETAILED GUIDANCE**: READ [Phase 1 Clarification](docs/principles/workflow.md#1-clarification)

### PHASE 2: EXPLORATION  
**DISCOVER and gather comprehensive contextual information**
- **SEARCH** relevant files and patterns
- **READ** necessary content
- **MAP** dependencies and relationships
- **Git Operations**: `git log --oneline -10`, `git diff HEAD~1`, examine repository context
- **COMPLETE WHEN**: Context mapped, information gathered, dependencies identified
- **DETAILED GUIDANCE**: READ [Phase 2 Exploration](docs/principles/workflow.md#2-exploration)

### PHASE 3: RESEARCH
**EXECUTE modern online research with current information as of 2025-08-19**
- **RESEARCH** current best practices using WebSearch tool for up-to-date information
- **QUERY** Context7 for latest library documentation and API references
- **VALIDATE** external resources for accuracy and relevance to current date
- **SYNTHESIZE** online findings with local context discoveries
- **CROSS-REFERENCE** current industry standards and emerging patterns
- **MANDATORY TOOLS**: 
  - WebSearch for current trends, solutions, and documentation (2025)
  - mcp__context7__resolve-library-id + mcp__context7__get-library-docs for library research
  - WebFetch for specific documentation validation
- **Git Operations**: Document research findings in temporary notes or comments
- **COMPLETE WHEN**: Current information gathered, external validation complete, synthesis ready
- **DETAILED GUIDANCE**: READ [Phase 3 Research](docs/principles/workflow.md#3-research)

### PHASE 4: ANALYSIS
**EXAMINE and understand findings to generate actionable solutions**
- **EXAMINE** discovered information from local context and research
- **SYNTHESIZE** local findings with current online research
- **IDENTIFY** patterns, issues, and current best practices
- **DOCUMENT** key findings with modern context
- **Git Operations**: `git diff --cached`, `git log --graph --oneline`, assess change impact  
- **COMPLETE WHEN**: Patterns found, solutions generated, feasibility assessed with current standards
- **DETAILED GUIDANCE**: READ [Phase 4 Analysis](docs/principles/workflow.md#4-analysis)

### PHASE 5: SOLUTION PRESENTATION
**ENABLE informed decision-making through structured dialogue**
- **PRESENT** solution alternatives with current industry context
- **FACILITATE** stakeholder dialogue
- **CONFIRM** selected approach
- **Git Operations**: Confirm branching strategy, validate merge approach
- **COMPLETE WHEN**: Decision made, solution selected, approach agreed
- **DETAILED GUIDANCE**: READ [Phase 5 Solution Presentation](docs/principles/workflow.md#5-solution-presentation)

### PHASE 6: PLANNING
**DESIGN atomic, hierarchical implementation approach**
- **DESIGN** implementation strategy incorporating research findings
- **STRUCTURE** execution steps
- **DEFINE** success criteria
- **Git Operations**: `git checkout -b feature/task-description`, `git push -u origin feature/task-description`
- **COMPLETE WHEN**: Tasks defined, agents assigned, dependencies mapped
- **DETAILED GUIDANCE**: READ [Phase 6 Planning](docs/principles/workflow.md#6-planning)

### PHASE 7: IMPLEMENTATION
**EXECUTE planned solution through specialized agents**
- **EXECUTE** designed solution with current best practices
- **APPLY** changes systematically
- **FOLLOW** established principles and modern standards
- **Git Operations**: `git add [files]`, `git commit -m "type(scope): description"`, `git push origin feature/task-description`
- **COMPLETE WHEN**: Implementation complete, quality verified, integration tested
- **DETAILED GUIDANCE**: READ [Phase 7 Implementation](docs/principles/workflow.md#7-implementation)

### PHASE 8: RIPPLE EFFECT
**MANAGE implementation consequences and dependencies**
- **HANDLE** cross-references
- **UPDATE** dependent elements
- **MAINTAIN** system integrity
- **Git Operations**: `git fetch origin`, `git rebase origin/main`, `git push --force-with-lease`
- **COMPLETE WHEN**: Dependencies updated, system stable, documentation synced
- **DETAILED GUIDANCE**: READ [Phase 8 Ripple Effect](docs/principles/workflow.md#8-ripple-effect)

### PHASE 9: VALIDATION
**VERIFY success and completeness using systematic validation methodology**
- **LOAD** Phase 1 success criteria for verification
- **EXECUTE** systematic validation using [validation.md comprehensive methodology](docs/principles/validation.md)
- **VALIDATE** against current standards and best practices from research phase
- **GENERATE** evidence and measure quantifiable outcomes
- **APPLY** appropriate quality gates and verification procedures
- **DOCUMENT** validation results and evidence collection
- **Git Operations**: `gh pr create --title "Title" --body "Description"`, `git diff main..HEAD`, verify CI/CD success
- **COMPLETE WHEN**: Criteria satisfied, quality confirmed, stakeholders satisfied, current standards met
- **DETAILED GUIDANCE**: READ [Phase 9 Validation](docs/principles/workflow.md#9-validation)

### WORKFLOW SUPPORT OPERATIONS

#### DEBUG OPERATION - Troubleshoot and resolve workflow issues
- **EXECUTE** systematic issue diagnosis for workflow execution problems
- **IDENTIFY** blockages, quality problems, and coordination failures
- **GENERATE** resolution strategies and recovery procedures
- **RESUME** workflow execution from stable points
- **DETAILED GUIDANCE**: READ [Debug Operation](docs/principles/workflow.md#debug-operation)

#### RECURSIVE OPERATION - Execute iterative improvement cycles
- **EXECUTE** intelligent workflow repetition for quality enhancement
- **ANALYZE** validation gaps and enhancement opportunities
- **PLAN** optimal recursion strategy and entry points
- **ACHIEVE** higher quality through systematic iteration
- **DETAILED GUIDANCE**: READ [Recursive Operation](docs/principles/workflow.md#recursive-operation)

---

## 🔧 MANDATORY TASK TOOL STRUCTURE

**FOR COMPLETE Task tool syntax**: READ [Task Tool Syntax Principles](docs/principles/task-tool-syntax.md) for:
- Task tool invocation framework and parameters
- Orchestrator-agent communication patterns  
- Dynamic parameter construction guidelines
- Error handling and validation protocols

**MANDATORY STRUCTURE**:
```markdown
Task(
  subagent_type: "{agent-from-AGENT_WORKFLOW_MAPPING}",
  description: "{action-specific-to-request}",
  prompt: "I am orchestrator, you are {agent}. Context: {context}. Execute: {instruction}"
)
```

---

## ⚡ MANDATORY PARALLEL EXECUTION & DEPENDENCY ANALYSIS

### DEPENDENCY ANALYSIS FRAMEWORK

**ALWAYS ANALYZE task dependencies before execution:**

1. **Independent Tasks** → EXECUTE in parallel (same message)
2. **Sequential Dependencies** → EXECUTE in order with handoff
3. **Partial Dependencies** → EXECUTE parallel for independent components
4. **Resource Conflicts** → SERIALIZE conflicting operations

### MANDATORY PARALLEL EXECUTION PATTERNS

#### Pattern 1: Independent File Operations (MANDATORY APPROACH)
```markdown
Task(subagent_type: "component-architect", description: "Create auth.js")
Task(subagent_type: "component-architect", description: "Create payment.js") 
Task(subagent_type: "component-architect", description: "Create validation.js")
```

#### Pattern 2: Multi-Perspective Analysis (MANDATORY APPROACH)
```markdown
Task(subagent_type: "security-analyst", description: "Security assessment")
Task(subagent_type: "performance-optimizer", description: "Performance analysis")
Task(subagent_type: "code-quality-auditor", description: "Quality evaluation")
```

### MANDATORY PROGRESSIVE THINKING INTEGRATION

**APPLY thinking levels based on task complexity:**

- **Think** → Simple, straightforward tasks (file creation, basic analysis)
- **Think Hard** → Moderate complexity (system integration, security considerations)
- **Think Harder** → Complex systems (architectural decisions, interdependencies)
- **UltraThink** → Framework evolution (long-term implications, strategic changes)

---

## 📋 MANDATORY OPERATIONAL RULES

### 🎯 COMMUNICATION REQUIREMENTS
1. **MAXIMUM 4 LINES** response to user
2. **NO UNNECESSARY EXPLANATIONS** - Avoid preambles and summaries
3. **DIRECT RESPONSE ONLY** - Address only what is requested

### 📁 FILE MANAGEMENT REQUIREMENTS
4. **NO UNNECESSARY FILES** - Only when absolutely required
5. **PREFER Edit OVER Write** - Always modify existing files when possible
6. **NO PROACTIVE DOCUMENTATION** - Don't create READMEs or .md documentation without explicit request

### 🔄 MANDATORY FRAMEWORK FLOW
7. **NEVER BYPASS**: Task + subagent_type + Command is MANDATORY for ALL actions
8. **PRIORITIZE PARALLEL EXECUTION**: Analyze dependencies and execute multiple Task tools in same message when possible
9. **DEPLOY SAME AGENT MULTIPLE TIMES**: For independent file operations
10. **APPLY PROGRESSIVE THINKING**: Use Think → Think Hard → Think Harder → UltraThink levels based on complexity
11. **FOLLOW SYSTEM PRINCIPLES**: Always adhere to [Framework Principles](docs/principles/index.md) authority chain
12. **AUTOMATIC 9-PHASE**: Commands execute complete workflow dynamically with integrated research
13. **INTEGRATED TodoWrite**: For visible workflow progress tracking
14. **AUTOMATIC VALIDATION**: Tests/build/lint included in workflow
15. **ONLY COMMIT IF EXPLICITLY REQUESTED**

---

## 📚 MANDATORY DOCUMENTATION ACCESS

### ⚡ CORE EXECUTION RESOURCES (READ WHEN NEEDED)
- **[Commands Index](commands/index.md)** → Browse complete command directory
- **[9-Phase Workflow](docs/principles/workflow.md#nine-phase-methodology)** → Understand systematic methodology with research integration
- **[System Architecture](docs/architecture/system-architecture-overview.md)** → Understand framework structure

### 🤖 INTELLIGENT SELECTION MATRICES (MANDATORY USAGE)
- **[Command Reference Matrix](commands/COMMAND_REFERENCE_MATRIX.md#command-selection-matrix)** → USE for intelligent command selection
- **[Agent Workflow Mapping](commands/AGENT_WORKFLOW_MAPPING.md#agent-specialization-matrix)** → USE for optimal agent deployment

### 🔄 COMMAND SELECTION (MANDATORY PROCESS)

**FOR INTELLIGENT COMMAND SELECTION**: USE [Command Reference Matrix](commands/COMMAND_REFERENCE_MATRIX.md#command-selection-decision-tree)
**FOR OPTIMAL AGENT SELECTION**: USE [Agent Workflow Mapping](commands/AGENT_WORKFLOW_MAPPING.md#agent-selection-algorithms)

**MANDATORY SELECTION PROCESS**:
1. ANALYZE request → 2. [Command Matrix](commands/COMMAND_REFERENCE_MATRIX.md) → 3. [Agent Mapping](commands/AGENT_WORKFLOW_MAPPING.md) → 4. EXECUTE Task + Command

**NEVER BYPASS FRAMEWORK**: Task + subagent + Command is MANDATORY for ALL actions

---

## 📚 MANDATORY CROSS-REFERENCES

### Primary Navigation (ACCESS WHEN REQUIRED)
- **[Framework Hub](docs/index.md)** → Access complete framework documentation when need comprehensive understanding
- **[Commands Index](commands/index.md)** → Navigate complete command directory for command selection
- **[9-Phase Workflow](docs/principles/workflow.md)** → Understand detailed methodology phases and operations with research integration

### Dynamic Selection Matrices (MANDATORY USAGE FOR INTELLIGENT SELECTION)
- **[Command Reference Matrix](commands/COMMAND_REFERENCE_MATRIX.md)** → **MANDATORY USE**: For intelligent command selection based on complexity, time, resource requirements
- **[Agent Workflow Mapping](commands/AGENT_WORKFLOW_MAPPING.md)** → **MANDATORY USE**: For optimal agent selection and multi-agent coordination

### Framework Authority (READ WHEN CONFLICTS OR QUESTIONS)
- **[Framework Principles Hub](docs/principles/index.md)** → **READ WHEN**: Need comprehensive system principles, authority chains, execution priorities
- **[Directive Authority](docs/principles/directive.md)** → **READ WHEN**: Need framework hierarchy, decision-making authority, conflict resolution
- **[Task Orchestration](docs/principles/task-orchestration.md)** → **READ WHEN**: Need multi-agent coordination, parallel execution patterns, task distribution
- **[Validation Principles](docs/principles/validation.md)** → **READ WHEN**: Need comprehensive validation, quality gates, evidence-based verification
- **[Engineering Standards](docs/principles/engineering.md)** → **READ WHEN**: Need technical standards, quality patterns, framework compliance
- **[Simplicity Enforcement](docs/principles/simplicity.md)** → **READ WHEN**: Need complexity reduction, over-engineering elimination, SIMPLE framework principles

### Emergency Access (READ WHEN PROBLEMS OCCUR)
- **[Emergency Procedures](playbook/quick-reference/emergency-procedures.md#recovery-protocols)** → **READ WHEN**: System failures or rapid problem resolution needed
- **[Quick Reference](playbook/quick-reference/immediate-access.md#navigation-shortcuts)** → **READ WHEN**: Need immediate access to key framework components

[⬆ Return to top](#claude-code-framework-playbook)