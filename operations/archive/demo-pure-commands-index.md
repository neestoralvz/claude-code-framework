
[⬆ Documentation Hub](../docs/index.md) | [🏗 Architecture](../docs/templates/components/core-framework/command-architecture.md) | [📋 Standards](../docs/commands-docs/COMMANDS.md)

# COMMANDS INDEX

## Core Commands

### Analysis Commands
- **[Execute system-audit](../commands/domains/analysis/workflows/system-audit.md)** - Comprehensive system analysis
- **[Execute audit-commands](../commands/domains/analysis/workflows/audit-commands.md)** - Command structure analysis  
- **[Execute analyze-dependencies](../commands/domains/analysis/workflows/analyze-dependencies.md)** - Dependency mapping
- **[Execute system-evolve](../commands/domains/analysis/workflows/system-evolve.md)** - System coherence analysis

### Workflow Commands
- **[Execute 1-clarify](../commands/domains/workflow/phases/1-clarify.md)** - Requirement understanding
- **[Execute 2-explore](../commands/domains/workflow/phases/2-explore.md)** - Context gathering
- **[Execute 3-analyze](../commands/domains/workflow/phases/3-analyze.md)** - Solution frameworks
- **[Execute 4-present-solutions](../commands/domains/workflow/phases/4-present-solutions.md)** - Decision facilitation
- **[Execute 5-plan](../commands/domains/workflow/phases/5-plan.md)** - Implementation design
- **[Execute 6-implement](../commands/domains/workflow/phases/6-implement.md)** - Agent-based execution
- **[Execute 7-ripple-effect](../commands/domains/workflow/phases/7-ripple-effect.md)** - Consequence management
- **[Execute 8-validate](../commands/domains/workflow/phases/8-validate.md)** - Completion verification

### Execution Commands
- **[Execute execute-ticket](../commands/domains/execution/commands/execute-ticket.md)** - Specific ticket completion
- **[Execute execute-parallel-plan](../commands/domains/execution/commands/execute-parallel-plan.md)** - Coordinated execution
- **[Execute monitor-execution](../commands/domains/execution/commands/monitor-execution.md)** - Real-time oversight

### Management Commands
- **[Execute create-ticket](../commands/domains/management/commands/create-ticket.md)** - Ticket generation
- **[Execute review-tickets](../commands/domains/management/commands/review-tickets.md)** - Priority-based execution
- **[Execute init-claude-md](../commands/domains/management/commands/init-claude-md.md)** - Project setup

### Orchestration Commands
- **[Execute parallel-intent-analysis](../commands/domains/analysis/workflows/parallel-intent-analysis.md)** - Multi-perspective analysis
- **[Execute multi-analysis-execution](../commands/domains/analysis/workflows/multi-analysis-execution.md)** - Comprehensive analysis with synthesis
- **[Execute modularize](../commands/compositions/solutions/modularize.md)** - Component extraction

### Composition Commands
- **[Execute complete-analysis](../commands/domains/analysis/workflows/complete-analysis.md)** - End-to-end analysis workflow
- **[Execute optimization-cycle](../commands/domains/execution/workflows/optimization-cycle.md)** - Iterative improvement
- **[Execute parallel-development](../commands/domains/execution/workflows/parallel-development.md)** - Coordinated development

## Command Syntax

### Basic Pattern
```bash
/command [target] [parameters]
```

### Common Parameters
- `--scope [minimal|comprehensive]` - Analysis depth
- `--output [summary|detailed|json]` - Result format
- `--priority [HIGH|MEDIUM|LOW]` - Importance level

## Quick Reference

| Command Category | Primary Use | Key Commands |
|-----------------|-------------|-------------|
| **Analysis** | System examination | system-audit, analyze-dependencies |
| **Workflow** | 8-phase execution | 1-clarify through 8-validate |
| **Execution** | Task completion | execute-ticket, execute-parallel-plan |
| **Management** | Task organization | create-ticket, review-tickets |
| **Orchestration** | Multi-agent coordination | parallel-intent-analysis |

## Architecture Documentation
Detailed architecture, patterns, and implementation guidance: [Command Architecture Documentation](../docs/templates/components/core-framework/command-architecture.md)

[⬆ Return to top](#commands-index)
