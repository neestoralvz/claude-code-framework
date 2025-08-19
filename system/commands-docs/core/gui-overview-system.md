
# COMMANDS FOLDER STRUCTURE

## Overview

This folder contains atomic commands organized according to **[command-workflow-principles.md](../docs/principles/command-workflow-principles.md)** for systematic task execution and composition.

## Folder Organization

```
commands/
├── README.md                    # This file - structure and usage guide
├── index.md                     # Command navigation hub and catalog
│
├── workflow/                    # 8-Phase Workflow Commands
│   ├── 1-clarify.md            # Phase 1: Requirement understanding
│   ├── 2-explore.md            # Phase 2: Context gathering  
│   ├── 3-analyze.md            # Phase 3: Solution frameworks
│   ├── 4-present-solutions.md  # Phase 4: Decision facilitation
│   ├── 5-plan.md               # Phase 5: Implementation design
│   ├── 6-implement.md          # Phase 6: Agent-based execution
│   ├── 7-ripple-effect.md      # Phase 7: Consequence management
│   ├── 8-validate.md           # Phase 8: Completion verification
│   ├── 9-debug.md              # Support: Troubleshooting
│   └── 10-recurse.md           # Support: Iterative improvement
│
├── analysis/                   # Analysis and Discovery Commands
│   ├── system-audit.md         # Comprehensive system analysis
│   ├── analyze-dependencies.md # Dependency analysis and mapping
│   ├── modularize.md           # Pattern discovery and extraction
│   └── system-evolve.md        # Evolutionary coherence and alignment analysis
│
├── execution/                  # Task Execution Commands
│   ├── execute-ticket.md       # Single ticket execution
│   ├── execute-parallel-plan.md # Coordinated parallel execution
│   └── monitor-execution.md    # Real-time execution monitoring
│
├── management/                 # Task Management Commands
│   ├── create-ticket.md        # Ticket generation from requirements
│   └── review-tickets.md       # Priority-based ticket execution
│
└── composition/                # Command Composition Examples
    ├── complete-analysis.md    # Full analysis workflow composition
    ├── optimization-cycle.md   # Iterative improvement composition
    └── parallel-development.md # Coordinated parallel workflow
```

## Command Categories

### 1. Workflow Commands (`workflow/`)
Implementation of the 8-phase workflow methodology:
- **Sequential**: Execute phases 1-8 in order for complete workflows
- **Targeted**: Execute specific phases based on current workflow state
- **Support**: Debug and recursive improvement capabilities

### 2. Analysis Commands (`analysis/`)
Specialized analysis and discovery operations:
- **System Analysis**: Comprehensive codebase examination
- **Dependency Analysis**: Relationship mapping and conflict detection
- **Pattern Analysis**: Duplication discovery and modularization opportunities
- **Evolutionary Analysis**: System-wide coherence and alignment assessment

### 3. Execution Commands (`execution/`)
Task execution and coordination:
- **Single Execution**: Individual ticket completion with validation
- **Parallel Execution**: Coordinated multi-ticket execution
- **Monitoring**: Real-time execution oversight and intervention

### 4. Management Commands (`management/`)
Task lifecycle management:
- **Ticket Creation**: Systematic ticket generation from requirements
- **Ticket Review**: Priority-based execution planning

### 5. Composition Commands (`composition/`)
Pre-built command chains for common workflows:
- **Complete Workflows**: End-to-end process automation
- **Optimization Cycles**: Iterative improvement patterns
- **Development Workflows**: Common development task sequences

## Usage Patterns

### Sequential Execution
```bash
# Complete workflow execution
1-clarify | 2-explore | 3-analyze | 4-present-solutions | 5-plan | 6-implement | 7-ripple-effect | 8-validate

# Targeted phase execution
2-explore --scope comprehensive | 3-analyze --methodology systematic
```

### Conditional Execution
```bash
# Analysis-driven workflow
system-audit | [if violations_found] create-ticket | execute-ticket

# Quality-driven iteration
8-validate | [if criteria_not_met] 10-recurse | repeat_workflow
```

### Parallel Execution
```bash
# Independent analysis
(system-audit & analyze-dependencies) | merge-results

# Coordinated execution
execute-parallel-plan & monitor-execution
```

### Composition Execution
```bash
# Pre-built workflows
complete-analysis --scope comprehensive
optimization-cycle --iterations 3
```

## Command Standards

All commands implement [Apply command-workflow-principles.md standards](../docs/principles/command-workflow-principles.md) standards:

### Interface Compliance
- **Standardized Parameters**: `--scope`, `--output`, `--validation`
- **Consistent Input/Output**: JSON-structured data contracts
- **Error Handling**: Standardized error codes and recovery

### Documentation Requirements
- **Complete Metadata**: Frontmatter with dependencies and audience
- **Navigation Breadcrumbs**: Consistent cross-reference patterns
- **Success Criteria**: Measurable completion standards
- **Usage Examples**: Practical implementation guidance

### Quality Assurance
- **Principle Alignment**: Explicit principle relationship statements
- **Workflow Integration**: 8-phase methodology compliance
- **Concatenation Support**: Interface contracts for command chaining

## Concatenation Support

Commands support [Apply command-concatenation.md patterns](../docs/templates/components/command-concatenation.md) patterns:

### Data Flow
- **Input Interface**: Standardized parameter and context structure
- **Output Interface**: Consistent result format with next command suggestions
- **State Management**: Persistent workflow state across command chains

### Orchestration
- **Flow Control**: Conditional execution based on results
- **Error Handling**: Standardized failure recovery and rollback
- **Performance**: Parallel execution capabilities where applicable

## Development Guidelines

### Adding New Commands
1. **Study Existing Patterns**: Review similar commands for consistency
2. **Apply Command Principles**: Follow [Apply command-workflow-principles.md standards](../docs/principles/command-workflow-principles.md)
3. **Implement Interface**: Ensure concatenation compatibility
4. **Document Thoroughly**: Include all required metadata and examples
5. **Update Index**: Add to [Update index.md categorization](index.md) with proper categorization

### Modifying Existing Commands
1. **Maintain Backward Compatibility**: Preserve existing interfaces
2. **Update Documentation**: Synchronize all cross-references
3. **Test Concatenation**: Verify command chain functionality
4. **Version Appropriately**: Use semantic versioning for changes

## Cross-References

### Primary Navigation
- [Browse command index navigation](index.md)
- [Study command-workflow-principles.md methodology](../docs/principles/command-workflow-principles.md)
- [Learn command-concatenation.md chaining patterns](../docs/templates/components/command-concatenation.md)
- [Return to Documentation Hub navigation](../docs/index.md)

### Framework Integration
- [Apply PRINCIPLES.md framework compliance](../docs/PRINCIPLES.md)
- [Follow workflow.md execution methodology](../docs/principles/workflow.md)
- [Use engineering.md quality standards](../docs/principles/engineering.md)

### Development Resources
- [Use command-template.md creation guide](../docs/templates/command-template.md)
- [Apply COMMANDS.md creation standards](../docs/commands-docs/COMMANDS.md)
- [Reference formatting.md document structure](../docs/principles/formatting.md)