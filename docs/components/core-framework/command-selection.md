---
title: "Command Selection Component"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["../../principles/agent-selection.md", "command-architecture.md"]
prerequisites: ["Understanding of command-centered execution", "Framework task categorization"]
audience: "Framework users selecting optimal commands for tasks"
purpose: "Define authoritative command selection strategies and decision frameworks"
keywords: ["command-selection", "decision-trees", "task-categorization", "execution-triggers"]
last_review: "2025-08-19"
authority_scope: "Command selection strategies, decision frameworks, and task-to-command mapping"
---

# Command Selection

⏺ **Authority**: This component serves as the single authoritative source for command selection strategies, decision frameworks, and task-to-command mapping within the Claude Code framework.

## Selection Methodology

⏺ **Selection**: Choose commands based on task type and complexity using the [commands index](../../../commands/index.md) as your primary navigation hub.

### Primary Command Categories

#### Analysis Commands
For comprehensive system examination and optimization:
- **[system-audit.md](../../../commands/analysis/system-audit.md)** - Comprehensive system analysis with auto-ticket generation
- **[modularize.md](../../../commands/analysis/modularize.md)** - Component extraction and code organization
- **[analyze-dependencies.md](../../../commands/analysis/analyze-dependencies.md)** - Dependency mapping and conflict detection

#### Workflow Phase Commands
For systematic eight-phase methodology execution:
- **[1-clarify.md](../../../commands/workflow/1-clarify.md)** through **[8-validate.md](../../../commands/workflow/8-validate.md)** - Systematic eight-phase execution
- **[9-debug.md](../../../commands/workflow/9-debug.md)** - Troubleshooting and issue resolution
- **[10-recurse.md](../../../commands/workflow/10-recurse.md)** - Iterative improvement and optimization

#### Management Commands
For task organization and execution coordination:
- **[create-ticket.md](../../../commands/management/create-ticket.md)** - Task tracking and systematic organization
- **[review-tickets.md](../../../commands/management/review-tickets.md)** - Priority-based execution management

#### Orchestration Commands
For complex multi-perspective analysis:
- **[multi-analysis-execution.md](../../../commands/orchestration/multi-analysis-execution.md)** - Complex multi-perspective analysis with JSON synthesis

## Command Selection Decision Tree

```
Task Type → Command Category → Specific Command → Execute
├─ System Analysis → analysis/ → system-audit.md
├─ Code Organization → analysis/ → modularize.md  
├─ Task Management → management/ → create-ticket.md
├─ Structured Workflow → workflow/ → [1-8]-*.md
├─ Problem Resolution → workflow/ → 9-debug.md
└─ Complex Analysis → orchestration/ → multi-analysis-execution.md
```

## Task-to-Command Mapping

### System Analysis Tasks
**Trigger Conditions:**
- Need comprehensive system examination
- Identify violations and inefficiencies
- Generate improvement tickets automatically
- Understand codebase structure and issues

**Optimal Command:** [Execute system-audit.md](../../../commands/analysis/system-audit.md)

### Code Organization Tasks
**Trigger Conditions:**
- Large files need modularization
- Extract reusable components
- Improve code maintainability
- Reduce complexity and improve structure

**Optimal Command:** [Execute modularize.md](../../../commands/analysis/modularize.md)

### Task Management Requirements
**Trigger Conditions:**
- Create systematic task tracking
- Deploy specialists for complex work
- Need structured task organization
- Convert requirements into actionable tickets

**Optimal Command:** [Execute create-ticket.md](../../../commands/management/create-ticket.md)

### Structured Workflow Execution
**Trigger Conditions:**
- Need systematic eight-phase execution
- Complex task requiring comprehensive approach
- Quality assurance throughout process
- Clear milestone and validation requirements

**Optimal Commands:** [Execute workflow phase commands](../../../commands/workflow/) - Select specific phase based on current progress

### Problem Resolution Needs
**Trigger Conditions:**
- Workflow execution issues or blockages
- Quality problems requiring diagnosis
- Agent coordination failures
- System errors or unexpected results

**Optimal Command:** [Execute 9-debug.md](../../../commands/workflow/9-debug.md)

### Complex Analysis Requirements
**Trigger Conditions:**
- Multi-perspective analysis needed
- JSON synthesis and reporting required
- Multiple specialist coordination
- Comprehensive business intelligence

**Optimal Command:** [Execute multi-analysis-execution.md](../../../commands/orchestration/multi-analysis-execution.md)

## Selection Decision Framework

### Task Complexity Assessment
1. **Simple Tasks** - Single command can handle complete workflow
2. **Moderate Tasks** - Workflow phase commands provide systematic approach
3. **Complex Tasks** - Orchestration commands coordinate multiple specialists

### Scope Evaluation Criteria
- **Focused scope** - Analysis or management commands
- **Comprehensive scope** - Workflow phase commands
- **Multi-domain scope** - Orchestration commands

### Resource Requirements Analysis
- **Immediate execution** - Direct command selection
- **Specialist expertise needed** - Commands with embedded agent deployment
- **Multi-perspective analysis** - Orchestration with parallel agent coordination

## Command Flow Triggers

### Execution Triggers for CloudEco Integration

#### Automated Trigger Conditions
- **File complexity violations** → [Execute modularize.md](../../../commands/analysis/modularize.md)
- **System audit schedules** → [Execute system-audit.md](../../../commands/analysis/system-audit.md)
- **Ticket review cycles** → [Execute review-tickets.md](../../../commands/management/review-tickets.md)
- **Quality gate failures** → [Execute 9-debug.md](../../../commands/workflow/9-debug.md)

#### User-Initiated Triggers
- **New task requests** → Use decision tree above for command selection
- **Problem reports** → [Execute 9-debug.md](../../../commands/workflow/9-debug.md) for diagnosis
- **Improvement opportunities** → [Execute 10-recurse.md](../../../commands/workflow/10-recurse.md) for optimization

## Interface Points

### Input from Other Components
- **[Command Architecture Component](command-architecture.md)** - Available command categories and capabilities
- **[Session Management Component](session-management.md)** - Context and initialization state
- **[Command Flow Triggers Component](command-flow-triggers.md)** - Execution trigger definitions

### Output to Other Components
- **[Command Architecture Component](command-architecture.md)** - Selected command for execution
- **[Quality Integration Component](quality-integration.md)** - Quality requirements for selected command
- **[Navigation Hub Component](navigation-hub.md)** - Command access patterns

### Dependencies
- **[Apply agent-selection.md for delegation when commands deploy specialists](../../principles/agent-selection.md)**
- **[Reference commands index for available command catalog](../../../commands/index.md)**

## Content Boundaries

### Included in This Component
- Command selection strategies and decision frameworks
- Task-to-command mapping with trigger conditions
- Decision trees and evaluation criteria
- Command flow triggers for CloudEco integration
- Selection methodology and best practices

### Excluded from This Component
- Command architecture and execution patterns *(handled by [command-architecture.md](command-architecture.md))*
- Specific command implementation details *(handled by individual command files)*
- Session initialization procedures *(handled by [session-management.md](session-management.md))*
- Quality validation methodology *(handled by [quality-integration.md](quality-integration.md))*