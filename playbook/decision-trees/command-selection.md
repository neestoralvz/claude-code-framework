---
title: "Command Selection Decision Tree"
author: "Claude Code Framework Playbook"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["../../commands/index.md", "../procedures/task-execution.md"]
prerequisites: ["Task analysis completed", "Framework commands understanding"]
audience: "AI assistants selecting optimal commands for task execution"
purpose: "Systematic command selection decision tree with usage contexts and timing"
keywords: ["command-selection", "decision-tree", "task-mapping", "execution-optimization"]
last_review: "2025-08-19"
authority_scope: "Command selection decisions and task-to-command mapping"
---

[🏠 Playbook Home](../../CLAUDE.md) | [🌳 All Decision Trees](./README.md) | [🌳 Previous: Situation Assessment](./situation-assessment.md) | [✅ Next: Validation Checkpoints](./validation-checkpoints.md)

# 🎯 COMMAND SELECTION DECISION TREE

## 🎯 DECISION OVERVIEW

**⚡ USE WHEN**: 
- Task analyzed and need optimal command selection
- Multiple command options available
- Want to ensure most efficient execution path
- Need guidance on command usage context and timing

**🎯 OBJECTIVE**: Select the most appropriate command for optimal task execution

**⏱️ DECISION TIME**: 1-3 minutes

**📋 PREREQUISITE**: Task requirements analysis completed (from [⚡ Task Execution Step 1](../procedures/task-execution.md))

---

## 🌳 COMMAND SELECTION TREE

```
🎯 TASK TYPE ANALYSIS
│
├─── 🔍 ANALYSIS TASKS: System examination, optimization, investigation
│    │
│    ├─── 📊 COMPREHENSIVE SYSTEM ANALYSIS needed?
│    │    ├─── ✅ YES → [system-audit.md](../../commands/analysis/system-audit.md)
│    │    │              ⏱️ DURATION: 10-15 minutes
│    │    │              📋 USE WHEN: Complete system examination with auto-tickets
│    │    │              🎯 CONTEXT: System optimization, comprehensive auditing
│    │    │
│    │    └─── ❌ NO → Continue to MODULARIZATION
│    │
│    ├─── 🧩 CODE ORGANIZATION/MODULARIZATION needed?
│    │    ├─── ✅ YES → [modularize.md](../../commands/analysis/modularize.md)
│    │    │              ⏱️ DURATION: 5-10 minutes per component
│    │    │              📋 USE WHEN: File complexity reduction, component extraction
│    │    │              🎯 CONTEXT: SOLID compliance, modular architecture
│    │    │
│    │    └─── ❌ NO → Continue to DEPENDENCY ANALYSIS
│    │
│    ├─── 🔗 DEPENDENCY MAPPING needed?
│    │    ├─── ✅ YES → [analyze-dependencies.md](../../commands/analysis/analyze-dependencies.md)
│    │    │              ⏱️ DURATION: 5-8 minutes
│    │    │              📋 USE WHEN: Dependency conflicts, integration planning
│    │    │              🎯 CONTEXT: Architecture analysis, integration preparation
│    │    │
│    │    └─── ❌ NO → Continue to WORKFLOW TASKS
│    │
│    └─── 🎯 COMMAND SELECTION OPTIMIZATION needed?
│         └─── ✅ YES → [intelligent-command-selection.md](../../commands/analysis/intelligent-command-selection.md)
│                      ⏱️ DURATION: 3-5 minutes
│                      📋 USE WHEN: Meta-analysis of command optimization
│                      🎯 CONTEXT: Command selection improvement, execution analysis
│
├─── 🔄 WORKFLOW TASKS: Systematic methodology, phase-by-phase execution
│    │
│    ├─── 📋 SINGLE WORKFLOW PHASE needed?
│    │    ├─── ✅ YES → Select specific phase:
│    │    │    ├─── 🎯 [1-clarify.md](../../commands/workflow/1-clarify.md) - Requirements clarification
│    │    │    ├─── 🔍 [2-explore.md](../../commands/workflow/2-explore.md) - Information gathering
│    │    │    ├─── 🧠 [3-analyze.md](../../commands/workflow/3-analyze.md) - Analysis and understanding
│    │    │    ├─── 🎯 [4-present-solutions.md](../../commands/workflow/4-present-solutions.md) - Solution presentation
│    │    │    ├─── 📋 [5-plan.md](../../commands/workflow/5-plan.md) - Implementation planning
│    │    │    ├─── ⚡ [6-implement.md](../../commands/workflow/6-implement.md) - Solution execution
│    │    │    ├─── 🔄 [7-ripple-effect.md](../../commands/workflow/7-ripple-effect.md) - Consequence management
│    │    │    └─── ✅ [8-validate.md](../../commands/workflow/8-validate.md) - Completion verification
│    │    │         ⏱️ DURATION: 2-5 minutes per phase
│    │    │         📋 USE WHEN: Specific workflow phase needed
│    │    │         🎯 CONTEXT: Systematic task completion, quality assurance
│    │    │
│    │    └─── ❌ NO → Continue to COMPLETE WORKFLOW
│    │
│    ├─── 🔄 COMPLETE WORKFLOW SEQUENCE needed?
│    │    ├─── ✅ YES → Execute phases 1-8 in sequence
│    │    │              ⏱️ DURATION: 15-30 minutes for complete workflow
│    │    │              📋 USE WHEN: Complex tasks requiring systematic execution
│    │    │              🎯 CONTEXT: Multi-step workflows, comprehensive completion
│    │    │
│    │    └─── ❌ NO → Continue to DEBUG/RECURSE
│    │
│    ├─── 🐛 PROBLEM RESOLUTION needed?
│    │    ├─── ✅ YES → [9-debug.md](../../commands/workflow/9-debug.md)
│    │    │              ⏱️ DURATION: 5-15 minutes depending on complexity
│    │    │              📋 USE WHEN: Workflow issues, execution problems, errors
│    │    │              🎯 CONTEXT: Troubleshooting, blockage removal, recovery
│    │    │
│    │    └─── ❌ NO → Continue to OPTIMIZATION
│    │
│    └─── 🔁 ITERATIVE IMPROVEMENT needed?
│         └─── ✅ YES → [10-recurse.md](../../commands/workflow/10-recurse.md)
│                      ⏱️ DURATION: 10-20 minutes for improvement cycle
│                      📋 USE WHEN: Quality enhancement, optimization needed
│                      🎯 CONTEXT: Continuous improvement, performance optimization
│
├─── 📋 MANAGEMENT TASKS: Organization, coordination, tracking
│    │
│    ├─── 🎫 TASK TRACKING/ORGANIZATION needed?
│    │    ├─── ✅ YES → [create-ticket.md](../../commands/management/create-ticket.md)
│    │    │              ⏱️ DURATION: 2-5 minutes per ticket
│    │    │              📋 USE WHEN: Task organization, systematic planning
│    │    │              🎯 CONTEXT: Project management, progress tracking
│    │    │
│    │    └─── ❌ NO → Continue to TICKET REVIEW
│    │
│    ├─── 📊 TICKET REVIEW/EXECUTION needed?
│    │    ├─── ✅ YES → [review-tickets.md](../../commands/management/review-tickets.md)
│    │    │              ⏱️ DURATION: 5-10 minutes for review and execution
│    │    │              📋 USE WHEN: Priority-based execution management
│    │    │              🎯 CONTEXT: Systematic task completion, workflow management
│    │    │
│    │    └─── ❌ NO → Continue to SYSTEM INITIALIZATION
│    │
│    └─── 🚀 SYSTEM SETUP/INITIALIZATION needed?
│         └─── ✅ YES → [system-initialization.md](../../commands/management/system-initialization.md)
│                      ⏱️ DURATION: 3-5 minutes
│                      📋 USE WHEN: Framework startup, configuration setup
│                      🎯 CONTEXT: System readiness, environment preparation
│
└─── 🎼 ORCHESTRATION TASKS: Complex analysis, multi-perspective, coordination
     │
     ├─── 🔍 MULTI-PERSPECTIVE ANALYSIS needed?
     │    ├─── ✅ YES → [multi-analysis-execution.md](../../commands/orchestration/multi-analysis-execution.md)
     │    │              ⏱️ DURATION: 20-45 minutes for complete analysis
     │    │              📋 USE WHEN: Complex analysis requiring multiple experts
     │    │              🎯 CONTEXT: Comprehensive examination, multi-domain analysis
     │    │
     │    └─── ❌ NO → Continue to PARALLEL ANALYSIS
     │
     ├─── ⚡ CONCURRENT ANALYSIS PATTERNS needed?
     │    ├─── ✅ YES → [parallel-intent-analysis.md](../../commands/orchestration/parallel-intent-analysis.md)
     │    │              ⏱️ DURATION: 15-25 minutes
     │    │              📋 USE WHEN: Parallel analysis execution patterns
     │    │              🎯 CONTEXT: Concurrent processing, efficiency optimization
     │    │
     │    └─── ❌ NO → Continue to AUTOMATION
     │
     └─── 🤖 AUTOMATION/TRIGGER SYSTEM needed?
          └─── ✅ YES → [automatic-trigger-system.md](../../commands/orchestration/automatic-trigger-system.md)
                       ⏱️ DURATION: 10-20 minutes for setup
                       📋 USE WHEN: Event-driven automation, trigger management
                       🎯 CONTEXT: Workflow automation, system integration
```

---

## 🎯 SELECTION CRITERIA

### 🔍 TASK TYPE IDENTIFICATION
**ANALYSIS TASKS**:
- System examination required
- Optimization opportunities needed
- Investigation or audit required
- Code organization needed

**WORKFLOW TASKS**:
- Systematic methodology beneficial
- Phase-by-phase execution appropriate
- Quality assurance important
- Structured approach needed

**MANAGEMENT TASKS**:
- Organization and coordination required
- Task tracking beneficial
- Project management needed
- Progress monitoring important

**ORCHESTRATION TASKS**:
- Complex analysis required
- Multiple perspectives needed
- Coordination of multiple components
- Advanced automation required

### ⏱️ TIMING CONSIDERATIONS
**SHORT DURATION (2-5 minutes)**:
- Single workflow phases
- Ticket creation
- Quick analysis tasks

**MEDIUM DURATION (5-15 minutes)**:
- Modularization tasks
- Debugging operations
- System audits

**LONG DURATION (15+ minutes)**:
- Complete workflow sequences
- Multi-analysis execution
- Comprehensive system examinations

### 🎯 CONTEXT ASSESSMENT
**SIMPLE CONTEXTS**:
- Clear requirements
- Single domain focus
- Straightforward execution

**COMPLEX CONTEXTS**:
- Multiple domains involved
- Cross-cutting concerns
- Advanced coordination needed

---

## 📋 QUICK SELECTION GUIDE

### ⚡ FAST COMMAND MAPPING
```
📊 SYSTEM ANALYSIS?        → system-audit.md
🧩 CODE ORGANIZATION?      → modularize.md
🔗 DEPENDENCY ISSUES?      → analyze-dependencies.md
📋 NEED SYSTEMATIC WORK?   → workflow commands (1-8)
🐛 PROBLEMS/ERRORS?        → 9-debug.md
🔁 WANT IMPROVEMENT?       → 10-recurse.md
🎫 TASK MANAGEMENT?        → create-ticket.md
📊 REVIEW TASKS?           → review-tickets.md
🔍 COMPLEX ANALYSIS?       → multi-analysis-execution.md
🤖 AUTOMATION SETUP?       → automatic-trigger-system.md
```

### 🎯 CONFIDENCE CHECK
**HIGH CONFIDENCE**: Task clearly maps to one command
- **ACTION**: Proceed with selected command

**MEDIUM CONFIDENCE**: Multiple commands could apply
- **ACTION**: Choose most specific command for current need

**LOW CONFIDENCE**: Unclear which command applies
- **ACTION**: Use [system-audit.md](../../commands/analysis/system-audit.md) for comprehensive analysis

---

## 🚀 NEXT STEPS

### 📍 AFTER COMMAND SELECTED
1. **📋 NAVIGATE** to selected command file
2. **⚡ EXECUTE** command following embedded procedures
3. **✅ VALIDATE** completion using [Validation Checkpoints](./validation-checkpoints.md)
4. **🔄 RETURN** to [🏠 Main Playbook](../../CLAUDE.md) when complete

### 🆘 IF SELECTION UNCLEAR
- **OPTION 1**: Use [system-audit.md](../../commands/analysis/system-audit.md) for comprehensive analysis
- **OPTION 2**: Return to [⚡ Task Execution](../procedures/task-execution.md) Step 1 for better analysis
- **OPTION 3**: Consult [🆘 Emergency Procedures](../quick-reference/emergency-procedures.md)

---

## 📚 RELATED DECISION TREES

### 🌳 DECISION SUPPORT
- [🌳 Situation Assessment](./situation-assessment.md) - Route to appropriate procedure
- [✅ Validation Checkpoints](./validation-checkpoints.md) - Verify completion and quality

### 🔧 PROCEDURES
- [⚡ Task Execution](../procedures/task-execution.md) - Systematic task completion workflow
- [📋 System Initialization](../procedures/system-initialization.md) - Framework setup and readiness

### ⚡ QUICK REFERENCE
- [🚀 Immediate Access](../quick-reference/immediate-access.md) - Direct navigation to commands
- [✅ Success Verification](../quick-reference/success-verification.md) - Command completion checklists

---

[🔄 Return to Main Playbook](../../CLAUDE.md)

*This decision tree provides systematic command selection with usage contexts, timing guidelines, and optimization criteria for efficient task execution within the Claude Code Framework.*