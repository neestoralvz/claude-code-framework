---
title: "Analysis Commands Guide"
author: "Claude Code Framework Playbook"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["../../commands/analysis/", "../procedures/task-execution.md"]
prerequisites: ["Framework command understanding", "Analysis needs identification"]
audience: "AI assistants executing system examination and optimization commands"
purpose: "Comprehensive guide to analysis commands with usage contexts, timing, and execution patterns"
keywords: ["analysis-commands", "system-examination", "optimization", "investigation"]
last_review: "2025-08-19"
authority_scope: "Analysis command documentation and execution guidance"
---

[🏠 Playbook Home](../../CLAUDE.md) | [📖 All Command Guides](./README.md) | [🔄 Next: Workflow Commands](./workflow-commands.md) | [⚡ Commands Hub](../../commands/)

# 🔍 ANALYSIS COMMANDS GUIDE

## 🎯 ANALYSIS COMMAND OVERVIEW

**⚡ PURPOSE**: Provide comprehensive examination and optimization commands for systematic investigation, code organization, and system understanding.

**🌍 SCOPE**: All analysis commands with detailed usage contexts, timing guidelines, and execution patterns for optimal system examination.

**⏱️ COMMAND DURATION RANGE**: 3-15 minutes depending on complexity and scope

---

## 📊 SYSTEM AUDIT COMMAND

### 🎯 [system-audit.md](../../commands/analysis/system-audit.md)
**⚡ COMMAND PURPOSE**: Complete system examination with comprehensive analysis and auto-ticket generation

**📋 USAGE CONTEXTS**:
- **System Optimization**: Need comprehensive system analysis and improvement recommendations
- **Architecture Review**: Require complete framework compliance assessment
- **Problem Investigation**: Need systematic examination when issues are unclear
- **Quality Assessment**: Want comprehensive quality and performance evaluation
- **Project Planning**: Need complete system understanding for major changes

**⏱️ EXECUTION TIMING**:
- **Duration**: 10-15 minutes for complete execution
- **Preparation**: 1-2 minutes for scope definition
- **Analysis Phase**: 8-12 minutes for comprehensive examination
- **Output Generation**: 1-2 minutes for results and auto-tickets

**🎯 EXECUTION PATTERNS**:
```
WHEN TO USE:
✅ Starting major project or optimization initiative
✅ System health check or comprehensive review needed
✅ Multiple problems detected requiring systematic analysis
✅ Architecture compliance assessment required
✅ Complete system understanding needed

AVOID WHEN:
❌ Single file or component needs analysis (use analyze-file.md)
❌ Quick problem resolution needed (use debug.md)
❌ Specific dependency issue identified (use analyze-dependencies.md)
❌ Time constraints under 10 minutes
```

**📋 SUCCESS INDICATORS**:
- [ ] Complete system overview generated
- [ ] Auto-tickets created for all identified issues
- [ ] Architecture compliance assessment completed
- [ ] Optimization recommendations provided
- [ ] Priority-based action plan established

**🔗 COMMON SEQUENCES**:
- `system-audit.md` → `review-tickets.md` → Implementation sequence
- `system-audit.md` → `modularize.md` → Architecture improvement
- `system-audit.md` → `multi-analysis-execution.md` → Deep investigation

---

## 🧩 MODULARIZATION COMMAND

### 🎯 [modularize.md](../../commands/analysis/modularize.md)
**⚡ COMMAND PURPOSE**: Code organization and component extraction for SOLID compliance and maintainability

**📋 USAGE CONTEXTS**:
- **Code Organization**: Large files need breaking down into manageable components
- **SOLID Compliance**: Architecture patterns need implementation and enforcement
- **Maintainability**: Code complexity reduction and readability improvement needed
- **Reusability**: Component extraction for reuse across framework
- **Architecture Improvement**: System design enhancement and pattern implementation

**⏱️ EXECUTION TIMING**:
- **Duration**: 5-10 minutes per component being extracted
- **Analysis Phase**: 2-3 minutes for complexity assessment
- **Extraction Phase**: 3-5 minutes for component creation
- **Integration Phase**: 1-2 minutes for dependency management

**🎯 EXECUTION PATTERNS**:
```
WHEN TO USE:
✅ Files exceed framework complexity thresholds
✅ Code duplication detected across components
✅ SOLID principle violations identified
✅ Component reusability opportunities exist
✅ Architecture patterns need implementation

AVOID WHEN:
❌ Files already meet complexity standards
❌ Components are already well-modularized
❌ Dependencies would become more complex
❌ Time constraints don't allow thorough testing
```

**📋 SUCCESS INDICATORS**:
- [ ] File complexity reduced below thresholds
- [ ] SOLID principles compliance achieved
- [ ] Component interfaces clearly defined
- [ ] Dependencies properly managed
- [ ] Reusability opportunities maximized

**🔗 COMMON SEQUENCES**:
- `system-audit.md` → `modularize.md` → `validate.md`
- `analyze-file.md` → `modularize.md` → `ripple-effect.md`
- `modularize.md` → `analyze-dependencies.md` → Integration testing

---

## 🔗 DEPENDENCY ANALYSIS COMMAND

### 🎯 [analyze-dependencies.md](../../commands/analysis/analyze-dependencies.md)
**⚡ COMMAND PURPOSE**: System relationship mapping and dependency conflict resolution

**📋 USAGE CONTEXTS**:
- **Integration Planning**: Need understanding of system relationships before changes
- **Dependency Conflicts**: Issues with component interactions and dependencies
- **Architecture Mapping**: Require complete system relationship documentation
- **Impact Analysis**: Need to understand change implications across system
- **Refactoring Preparation**: Planning major architectural changes

**⏱️ EXECUTION TIMING**:
- **Duration**: 5-8 minutes for complete analysis
- **Discovery Phase**: 2-3 minutes for dependency mapping
- **Analysis Phase**: 2-3 minutes for conflict identification
- **Resolution Phase**: 1-2 minutes for recommendations

**🎯 EXECUTION PATTERNS**:
```
WHEN TO USE:
✅ Planning major system changes or refactoring
✅ Dependency conflicts or circular dependencies detected
✅ Integration issues between components
✅ Architecture documentation needs updating
✅ Component removal or replacement planned

AVOID WHEN:
❌ Dependencies are simple and well-understood
❌ No integration or architectural changes planned
❌ System is already well-documented
❌ Quick fixes needed without architectural impact
```

**📋 SUCCESS INDICATORS**:
- [ ] Complete dependency map generated
- [ ] Conflicts and circular dependencies identified
- [ ] Resolution strategies provided
- [ ] Impact analysis completed
- [ ] Integration plan established

**🔗 COMMON SEQUENCES**:
- `modularize.md` → `analyze-dependencies.md` → Integration
- `system-audit.md` → `analyze-dependencies.md` → Architecture planning
- `analyze-dependencies.md` → `ripple-effect.md` → Change implementation

---

## 📁 FILE ANALYSIS COMMAND

### 🎯 [analyze-file.md](../../commands/analysis/analyze-file.md)
**⚡ COMMAND PURPOSE**: Individual file examination and optimization for targeted improvements

**📋 USAGE CONTEXTS**:
- **Targeted Analysis**: Specific file needs examination and optimization
- **Quality Assessment**: Individual component quality evaluation required
- **Performance Issues**: File-specific performance problems identified
- **Code Review**: Detailed examination of implementation patterns
- **Documentation Needs**: Specific file documentation and clarity improvement

**⏱️ EXECUTION TIMING**:
- **Duration**: 3-5 minutes per file
- **Analysis Phase**: 2-3 minutes for detailed examination
- **Recommendations**: 1-2 minutes for optimization suggestions

**🎯 EXECUTION PATTERNS**:
```
WHEN TO USE:
✅ Specific file has known issues or needs optimization
✅ Targeted code review and improvement needed
✅ Individual component performance problems
✅ File-specific documentation needs identified
✅ Quality assessment for specific implementation

AVOID WHEN:
❌ System-wide analysis needed (use system-audit.md)
❌ Multiple files need examination simultaneously
❌ Architecture-level issues identified
❌ Dependency relationships are the primary concern
```

**📋 SUCCESS INDICATORS**:
- [ ] File quality assessment completed
- [ ] Optimization opportunities identified
- [ ] Implementation improvements suggested
- [ ] Documentation needs addressed
- [ ] Performance enhancement recommendations provided

**🔗 COMMON SEQUENCES**:
- `analyze-file.md` → `modularize.md` → Component improvement
- `analyze-file.md` → `implement.md` → Direct optimization
- `system-audit.md` → `analyze-file.md` → Targeted improvements

---

## 🎯 INTELLIGENT COMMAND SELECTION

### 🎯 [intelligent-command-selection.md](../../commands/analysis/intelligent-command-selection.md)
**⚡ COMMAND PURPOSE**: Meta-analysis for optimal command choice and workflow optimization

**📋 USAGE CONTEXTS**:
- **Command Optimization**: Need to improve command selection accuracy
- **Workflow Efficiency**: Want to optimize execution patterns and timing
- **Decision Support**: Require systematic approach to command choice
- **Framework Improvement**: Need analysis of command usage patterns
- **Execution Analysis**: Want to understand optimal workflow sequences

**⏱️ EXECUTION TIMING**:
- **Duration**: 3-5 minutes for analysis
- **Pattern Analysis**: 2-3 minutes for usage pattern examination
- **Optimization**: 1-2 minutes for improvement recommendations

**🎯 EXECUTION PATTERNS**:
```
WHEN TO USE:
✅ Command selection decisions frequently unclear
✅ Workflow efficiency needs improvement
✅ Meta-analysis of framework usage needed
✅ Optimization of execution patterns desired
✅ Decision-making support for complex scenarios

AVOID WHEN:
❌ Command choice is clear and straightforward
❌ Standard workflows are functioning optimally
❌ Time constraints don't allow meta-analysis
❌ Immediate task execution is priority
```

**📋 SUCCESS INDICATORS**:
- [ ] Command selection patterns analyzed
- [ ] Optimization opportunities identified
- [ ] Decision support improvements recommended
- [ ] Workflow efficiency enhanced
- [ ] Framework utilization optimized

**🔗 COMMON SEQUENCES**:
- `intelligent-command-selection.md` → Improved workflow execution
- `system-audit.md` → `intelligent-command-selection.md` → Framework optimization
- `intelligent-command-selection.md` → `recurse.md` → Continuous improvement

---

## 📋 ANALYSIS COMMAND SELECTION GUIDE

### 🚀 QUICK SELECTION MATRIX
```
📊 COMPREHENSIVE ANALYSIS NEEDED?     → system-audit.md
🧩 CODE ORGANIZATION REQUIRED?        → modularize.md
🔗 DEPENDENCY ISSUES DETECTED?        → analyze-dependencies.md
📁 SPECIFIC FILE NEEDS ATTENTION?     → analyze-file.md
🎯 COMMAND CHOICE OPTIMIZATION?       → intelligent-command-selection.md
```

### ⏱️ BY TIME AVAILABILITY
**QUICK ANALYSIS** (3-5 minutes):
- analyze-file.md for targeted examination
- intelligent-command-selection.md for decision support

**STANDARD ANALYSIS** (5-10 minutes):
- modularize.md for code organization
- analyze-dependencies.md for relationship mapping

**COMPREHENSIVE ANALYSIS** (10-15 minutes):
- system-audit.md for complete examination

### 🎯 BY ANALYSIS SCOPE
**TARGETED SCOPE**:
- analyze-file.md: Single file focus
- intelligent-command-selection.md: Command optimization focus

**COMPONENT SCOPE**:
- modularize.md: Component organization focus
- analyze-dependencies.md: Relationship mapping focus

**SYSTEM SCOPE**:
- system-audit.md: Complete system focus

---

## 🔄 INTEGRATION WITH FRAMEWORK

### 📋 WORKFLOW INTEGRATION
- **Analysis Phase**: Integrate with [🧠 3-analyze.md](../../commands/workflow/3-analyze.md)
- **Planning Phase**: Connect with [📋 5-plan.md](../../commands/workflow/5-plan.md)
- **Validation Phase**: Link with [✅ 8-validate.md](../../commands/workflow/8-validate.md)

### 🎯 DECISION SUPPORT
- **Command Selection**: Use with [🎯 Command Selection Tree](../decision-trees/command-selection.md)
- **Task Execution**: Integrate with [⚡ Task Execution](../procedures/task-execution.md)
- **Validation**: Connect with [✅ Validation Checkpoints](../decision-trees/validation-checkpoints.md)

### 🎫 MANAGEMENT INTEGRATION
- **Auto-Tickets**: system-audit.md generates tickets for [📊 review-tickets.md](../../commands/management/review-tickets.md)
- **Project Planning**: Analysis results feed into [🎫 create-ticket.md](../../commands/management/create-ticket.md)
- **Documentation**: Results integrate with [📚 update-docs.md](../../commands/management/update-docs.md)

---

[🔄 Return to Command Guides](./README.md)

*Analysis commands provide systematic examination and optimization capabilities with comprehensive usage guidance for optimal framework utilization and system understanding.*