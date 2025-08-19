---
title: "Situation Assessment Decision Tree"
author: "Claude Code Framework Playbook"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["../procedures/", "../../docs/principles/directive.md"]
prerequisites: ["Understanding of framework procedures", "Basic situation analysis capability"]
audience: "AI assistants needing to route to appropriate procedures"
purpose: "Systematic situation assessment and procedure routing decision tree"
keywords: ["situation-assessment", "decision-tree", "procedure-routing", "task-analysis"]
last_review: "2025-08-19"
authority_scope: "Situation analysis and procedure routing decisions"
---

[🏠 Playbook Home](../../CLAUDE.md) | [🌳 All Decision Trees](./README.md) | [🎯 Next: Command Selection](./command-selection.md) | [🆘 Emergency](../quick-reference/emergency-procedures.md)

# 🌳 SITUATION ASSESSMENT DECISION TREE

## 🎯 DECISION OVERVIEW

**⚡ USE WHEN**: 
- Unclear which procedure to follow
- Need systematic routing to appropriate action
- Multiple options available and need guidance
- Want to verify optimal path selection

**🎯 OBJECTIVE**: Route to the most appropriate procedure based on current situation

**⏱️ DECISION TIME**: 30 seconds - 2 minutes

---

## 🌳 DECISION TREE

```
🎯 CURRENT SITUATION ANALYSIS
│
├─── 📊 SYSTEM STATUS: New session or context lost?
│    ├─── ✅ YES → 📋 [System Initialization Procedure](../procedures/system-initialization.md)
│    │              REASON: Framework understanding and readiness required
│    │
│    └─── ❌ NO → Continue to TASK STATUS
│
├─── 📥 TASK STATUS: Received specific task from user?
│    ├─── ✅ YES → Analyze TASK COMPLEXITY
│    │    │
│    │    ├─── 🟢 SIMPLE: Single action or straightforward request
│    │    │    └─── ⚡ [Task Execution Procedure](../procedures/task-execution.md)
│    │    │         REASON: Direct task completion with quality validation
│    │    │
│    │    ├─── 🟡 MULTI-STEP: Systematic workflow needed
│    │    │    └─── ⚡ [Task Execution Procedure](../procedures/task-execution.md)
│    │    │         → USE: [Workflow Commands](../../commands/workflow/)
│    │    │         REASON: Systematic phase-by-phase execution required
│    │    │
│    │    └─── 🔴 COMPLEX: Multi-perspective or extensive analysis
│    │         └─── ⚡ [Task Execution Procedure](../procedures/task-execution.md)
│    │              → USE: [Orchestration Commands](../../commands/orchestration/)
│    │              REASON: Complex analysis with multiple expert perspectives
│    │
│    └─── ❌ NO → Continue to INTEGRATION STATUS
│
├─── 🔗 INTEGRATION STATUS: Need framework integration or automation?
│    ├─── ✅ YES → 🔗 [Framework Integration Procedure](../procedures/framework-integration.md)
│    │              REASON: External system integration and automation setup needed
│    │
│    └─── ❌ NO → Continue to SESSION STATUS
│
├─── 🎛️ SESSION STATUS: Need session setup or context management?
│    ├─── ✅ YES → 🎛️ [Session Management Procedure](../procedures/session-management.md)
│    │              REASON: Session configuration and context optimization needed
│    │
│    └─── ❌ NO → Continue to COMMAND STATUS
│
├─── 🎯 COMMAND STATUS: Unclear which command to use?
│    ├─── ✅ YES → 🎯 [Command Selection Tree](./command-selection.md)
│    │              REASON: Need systematic command selection guidance
│    │
│    └─── ❌ NO → Continue to VALIDATION STATUS
│
├─── ✅ VALIDATION STATUS: Need to verify task completion?
│    ├─── ✅ YES → ✅ [Validation Checkpoint Tree](./validation-checkpoints.md)
│    │              REASON: Quality verification and completion confirmation needed
│    │
│    └─── ❌ NO → Continue to EMERGENCY STATUS
│
└─── 🆘 EMERGENCY STATUS: Experiencing problems or errors?
     ├─── ✅ YES → 🆘 [Emergency Procedures](../quick-reference/emergency-procedures.md)
     │              REASON: Problem resolution and recovery protocols needed
     │
     └─── ❌ NO → 🎯 [Return to Main Playbook](../../CLAUDE.md)
                   REASON: Ready for new task - return to central navigation
```

---

## 🎯 DECISION CRITERIA

### 📊 SYSTEM STATUS EVALUATION
**🔍 CHECK FOR**:
- [ ] New session started?
- [ ] Context lost or unclear?
- [ ] Framework understanding needed?
- [ ] System readiness uncertain?

**➡️ IF ANY YES**: Use [📋 System Initialization](../procedures/system-initialization.md)

### 📥 TASK COMPLEXITY ANALYSIS
**🔍 SIMPLE TASKS**:
- Single action required
- Clear scope and boundaries
- Straightforward execution path
- Minimal dependencies

**🔍 MULTI-STEP TASKS**:
- Multiple phases needed
- Systematic workflow beneficial
- Clear sequence required
- Intermediate validation needed

**🔍 COMPLEX TASKS**:
- Multiple perspectives required
- Extensive analysis needed
- Cross-domain expertise required
- Comprehensive investigation needed

### 🔗 INTEGRATION ASSESSMENT
**🔍 CHECK FOR**:
- [ ] External system connection needed?
- [ ] Automation setup required?
- [ ] Claude Code integration needed?
- [ ] Workflow automation desired?

**➡️ IF ANY YES**: Use [🔗 Framework Integration](../procedures/framework-integration.md)

### 🎛️ SESSION EVALUATION
**🔍 CHECK FOR**:
- [ ] Session configuration needed?
- [ ] Context optimization required?
- [ ] Navigation patterns needed?
- [ ] Framework access setup needed?

**➡️ IF ANY YES**: Use [🎛️ Session Management](../procedures/session-management.md)

---

## 📋 QUICK DECISION GUIDE

### ⚡ FAST ROUTING
```
🆘 LOST/CONFUSED?     → Emergency Procedures
📊 NEW SESSION?       → System Initialization  
📥 GOT TASK?          → Task Execution
🔗 NEED INTEGRATION?  → Framework Integration
🎛️ SETUP NEEDED?     → Session Management
🎯 UNCLEAR COMMAND?   → Command Selection Tree
✅ VERIFY DONE?       → Validation Checkpoints
🔄 READY FOR NEXT?    → Return to Main Playbook
```

### 🎯 CONFIDENCE CHECK
**HIGH CONFIDENCE**: Situation clearly matches one category
- **ACTION**: Proceed directly to indicated procedure

**MEDIUM CONFIDENCE**: Multiple categories might apply
- **ACTION**: Use most specific/urgent category first

**LOW CONFIDENCE**: Unclear which category applies
- **ACTION**: Start with [📋 System Initialization](../procedures/system-initialization.md)

---

## 🚀 NEXT STEPS

### 📍 AFTER DECISION MADE
1. **📋 FOLLOW** the indicated procedure completely
2. **✅ VERIFY** procedure completion 
3. **🔄 RETURN** to [🏠 Main Playbook](../../CLAUDE.md) for next task
4. **📊 REASSESS** situation if new factors emerge

### 🆘 IF DECISION UNCLEAR
- **OPTION 1**: Default to [📋 System Initialization](../procedures/system-initialization.md)
- **OPTION 2**: Use [🆘 Emergency Procedures](../quick-reference/emergency-procedures.md)
- **OPTION 3**: Consult [🚀 Immediate Access Paths](../quick-reference/immediate-access.md)

---

## 📚 RELATED DECISION TREES

### 🌳 SPECIALIZED DECISION TREES
- [🎯 Command Selection Tree](./command-selection.md) - Choose optimal command for task execution
- [✅ Validation Checkpoint Tree](./validation-checkpoints.md) - Verify completion and quality

### 🔧 PROCEDURES
- [📋 System Initialization](../procedures/system-initialization.md) - Framework setup and readiness
- [⚡ Task Execution](../procedures/task-execution.md) - Systematic task completion
- [🔗 Framework Integration](../procedures/framework-integration.md) - External system integration
- [🎛️ Session Management](../procedures/session-management.md) - Session and context management

### ⚡ QUICK REFERENCE
- [🆘 Emergency Procedures](../quick-reference/emergency-procedures.md) - Problem resolution protocols
- [🚀 Immediate Access](../quick-reference/immediate-access.md) - Direct navigation paths
- [✅ Success Verification](../quick-reference/success-verification.md) - Completion checklists

---

[🔄 Return to Main Playbook](../../CLAUDE.md)

*This decision tree provides systematic situation assessment and optimal procedure routing for efficient framework navigation and task execution.*