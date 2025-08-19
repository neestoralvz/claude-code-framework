
# COMMAND SELECTION PLAYBOOK

## ASSISTANT OPERATIONAL GUIDE

⏺ **Authority**: This playbook provides **exact navigation paths** and **sequential action steps** for systematic command selection. Follow these procedures precisely for consistent, optimal command execution.

## OPERATIONAL PROCEDURES

### PROCEDURE A: COMMAND ANALYSIS AND SELECTION
**TRIGGER**: Task received requiring command selection for optimal execution
**EXECUTION SEQUENCE**:
```
STEP 1: ANALYZE → Task characteristics
        OBJECTIVE: Categorize task type and complexity
        ACTION: Examine task for type, scope, dependencies, complexity
        VERIFICATION: Task clearly categorized and requirements understood

STEP 2: NAVIGATE → [commands/index.md](../../philosophy/index.md)
        OBJECTIVE: Access primary command navigation hub
        ACTION: Browse command categories and available options
        VERIFICATION: Command categories reviewed and options identified

STEP 3: APPLY → Decision tree selection
        OBJECTIVE: Use systematic selection criteria
        ACTION: Follow COMMAND SELECTION TREE below
        VERIFICATION: Single optimal command identified with justification

STEP 4: EXECUTE → Selected command
        OBJECTIVE: Run chosen command with proper parameters
        ACTION: Navigate to specific command file and execute
        VERIFICATION: Command execution initiated successfully
```

### PROCEDURE B: COMMAND VERIFICATION
**TRIGGER**: Need to verify command selection before execution
**EXECUTION SEQUENCE**:
```
STEP 1: VERIFY → Selection criteria match
        OBJECTIVE: Confirm command matches task requirements
        ACTION: Cross-check task type with command capabilities
        VERIFICATION: Perfect alignment between task and command

STEP 2: CHECK → Command availability and readiness
        OBJECTIVE: Ensure command is operational and accessible
        ACTION: Verify command file exists and is current
        VERIFICATION: Command accessible and properly documented

STEP 3: CONFIRM → Execution prerequisites
        OBJECTIVE: Verify all prerequisites are met
        ACTION: Check dependencies, context, and system readiness
        VERIFICATION: All prerequisites satisfied for execution

STEP 4: APPROVE → Command execution
        OBJECTIVE: Final approval before execution
        ACTION: Confirm optimal selection and authorize execution
        VERIFICATION: Command approved and ready for execution
```

## COMMAND CATEGORIES

### ANALYSIS COMMANDS (`commands/analysis/`)
```
system-audit.md          → Comprehensive system examination with auto-tickets
modularize.md           → Component extraction and code organization  
analyze-dependencies.md → Dependency mapping and conflict detection
intelligent-command-selection.md → Command optimization analysis
```

### WORKFLOW COMMANDS (`commands/workflow/`)
```
1-clarify.md → 8-validate.md → Systematic eight-phase execution
9-debug.md                   → Troubleshooting and issue resolution
10-recurse.md               → Iterative improvement and optimization
```

### MANAGEMENT COMMANDS (`commands/management/`)
```
create-ticket.md    → Task tracking and systematic organization
review-tickets.md   → Priority-based execution management
system-initialization.md → Framework startup and configuration
```

### ORCHESTRATION COMMANDS (`commands/orchestration/`)
```
multi-analysis-execution.md → Complex multi-perspective analysis with JSON synthesis
parallel-intent-analysis.md → Concurrent analysis pattern execution
automatic-trigger-system.md → Event-driven automation management
```

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

**Optimal Command:** [Execute system-audit.md](../../../../commands/domains/analysis/workflows/system-audit.md)

### Code Organization Tasks
**Trigger Conditions:**
- Large files need modularization
- Extract reusable components
- Improve code maintainability
- Reduce complexity and improve structure

**Optimal Command:** [Execute modularize.md](../../../../commands/compositions/solutions/modularize.md)

### Task Management Requirements
**Trigger Conditions:**
- Create systematic task tracking
- Deploy specialists for complex work
- Need structured task organization
- Convert requirements into actionable tickets

**Optimal Command:** [Execute create-ticket.md](../../../../commands/domains/management/commands/create-ticket.md)

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

**Optimal Command:** [Execute 9-debug.md](../../../../commands/domains/workflow/phases/9-debug.md)

### Complex Analysis Requirements
**Trigger Conditions:**
- Multi-perspective analysis needed
- JSON synthesis and reporting required
- Multiple specialist coordination
- Comprehensive business intelligence

**Optimal Command:** [Execute multi-analysis-execution.md](../../../../commands/domains/analysis/workflows/multi-analysis-execution.md)

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

### Execution Triggers for Claude Code Integration

#### Automated Trigger Conditions
- **File complexity violations** → [Execute modularize.md](../../../../commands/compositions/solutions/modularize.md)
- **System audit schedules** → [Execute system-audit.md](../../../../commands/domains/analysis/workflows/system-audit.md)
- **Ticket review cycles** → [Execute review-tickets.md](../../../../commands/domains/management/commands/review-tickets.md)
- **Quality gate failures** → [Execute 9-debug.md](../../../../commands/domains/workflow/phases/9-debug.md)

#### User-Initiated Triggers
- **New task requests** → Use decision tree above for command selection
- **Problem reports** → [Execute 9-debug.md](../../../../commands/domains/workflow/phases/9-debug.md) for diagnosis
- **Improvement opportunities** → [Execute 10-recurse.md](../../../../commands/domains/workflow/phases/10-recurse.md) for optimization

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
- **[Apply agent-selection.md for delegation when commands deploy specialists](../../../principles/agent-selection.md)**
- **[Reference commands index for available command catalog](../../philosophy/index.md)**

## Content Boundaries

### Included in This Component
- Command selection strategies and decision frameworks
- Task-to-command mapping with trigger conditions
- Decision trees and evaluation criteria
- Command flow triggers for Claude Code integration
- Selection methodology and best practices

### Excluded from This Component
- Command architecture and execution patterns *(handled by [command-architecture.md](command-architecture.md))*
- Specific command implementation details *(handled by individual command files)*
- Session initialization procedures *(handled by [session-management.md](session-management.md))*
- Quality validation methodology *(handled by [quality-integration.md](quality-integration.md))*
