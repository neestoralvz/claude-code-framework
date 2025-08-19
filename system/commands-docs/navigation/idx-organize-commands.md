
[Previous: Navigate to documentation hub](../index.md) | [Return to hub for navigation](../index.md) | [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md) | [Next: Browse project-optimizer for analysis](../../agents/project-management/coordination/project-optimizer.md)

# COMMANDS INDEX

## Table of Contents
  - [Available Commands](#available-commands)
- [Task Management](#task-management)
- [Code Refactoring](#code-refactoring)
- [System Quality (Core Command)](#system-quality-core-command-)
  - [Command Categories](#command-categories)
  - [Usage Guidelines](#usage-guidelines)
- [Execution Pattern](#execution-pattern)
- [Common Parameters](#common-parameters)
  - [Creating New Commands](#creating-new-commands)
- [Development Process](#development-process)
- [Required Components](#required-components)
  - [Standards and Requirements](#standards-and-requirements)
- [Compliance Requirements](#compliance-requirements)
- [Quality Assurance](#quality-assurance)
  - [Workflow Integration](#workflow-integration)
- [Phase Standardization](#phase-standardization)
- [Command-Specific Adaptations](#command-specific-adaptations)
  - [Principle References](#principle-references)
  - [Cross-References](#cross-references)
- [Primary Navigation](#primary-navigation)
- [Related Documentation](#related-documentation)
- [Command Files](#command-files)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Available Commands


### Task Management
- **[Deploy create-ticket.md for systematic tracking](../../commands/domains/management/commands/create-ticket.md)**
  Generate standardized tickets from pending tasks, requirements, or identified issues with complete metadata and dependency management.

- **[Execute review-tickets.md for priority-based execution](../../commands/domains/management/commands/review-tickets.md)**
  Review pending tickets by priority, assess execution readiness, and systematically execute the highest priority task using workflow methodology.

### Code Refactoring
- **[Apply modularize.md for component extraction](../../commands/compositions/solutions/modularize.md)**
  Refactor code into modular, reusable components while identifying duplication patterns and optimization opportunities.

### System Quality (Core Command)
- **[Execute system-audit.md for comprehensive analysis](../../commands/domains/analysis/workflows/system-audit.md)**
  Perform hiperagresivo system audit detecting all anomalies, inconsistencies, contradictions with automatic ticket generation and principle compliance validation.



[⬆ Return to top](#commands-index)

## Command Categories

- **Task Management**: create-ticket, review-tickets
- **Code Refactoring**: modularize  
- **System Quality**: system-audit

## Usage Guidelines

⏺ **Principle**:  All commands implement [workflow.md systematic execution](../docs/principles/workflow.md#execution-phases) ensuring consistent, thorough, and verifiable results through structured phase progression.

### Execution Pattern
1. **Command Selection**: Choose appropriate command for task requirements
2. **Parameter Configuration**: Define scope, output format, and options
3. **Phase Execution**: Follow [workflow.md for standard methodology](../docs/principles/workflow.md#eight-phase-methodology)
4. **Result Validation**: Verify success criteria and completeness
5. **Documentation**: Update relevant documentation and registries

### Common Parameters
- `--scope [minimal|comprehensive]`: Analysis depth control
- `--output [summary|detailed|json]`: Result format specification
- `--priority [HIGH|MEDIUM|LOW]`: Importance classification
- `--category [type]`: Classification for organization

## Creating New Commands

### Development Process
1. **Study command standards**: [Apply COMMANDS.md for standards](COMMANDS.md)
2. **Define workflow phases**: [Reference workflow.md for methodology](../docs/principles/workflow.md#eight-phase-methodology)
3. **Implement principle alignment**: [Follow PRINCIPLES.md for compliance](../docs/PRINCIPLES.md)
4. **Test execution patterns**: Verify all phases function correctly
5. **Document thoroughly**: Include all required metadata and cross-references

### Required Components
- Complete metadata header with all fields
- Proper navigation breadcrumbs
- Comprehensive table of contents
- Explicit principle relationship statements
- Command-specific workflow adaptations
- Success criteria and validation methods
- Usage examples and parameter documentation

[⬆ Return to top](#commands-index)

## Standards and Requirements

### Compliance Requirements
All commands must adhere to:
- **[Study COMMANDS.md for creation standards](COMMANDS.md)**: Command structure and documentation requirements
- **[Apply PRINCIPLES.md for systematic operation](../docs/PRINCIPLES.md)**: Framework compliance and principle alignment
- **[Follow formatting.md for document structure](../principles/formatting.md)**: Formatting standards and link requirements

### Quality Assurance
- **Workflow Integration**: All commands implement eight-phase methodology
- **Principle Alignment**: Explicit principle relationship statements required
- **Documentation Standards**: Complete metadata and cross-reference sections
- **Link Requirements**: Action verbs and use cases mandatory for all links
- **Validation Methods**: Success criteria and verification procedures

## Workflow Integration

### Phase Standardization
Commands reference [workflow.md for consistent execution](../docs/principles/workflow.md#eight-phase-methodology) instead of duplicating phase definitions, ensuring:
- **Consistency**: Single source of workflow truth
- **Maintenance**: Updates propagate to all commands
- **Clarity**: Command-specific adaptations clearly documented
- **Efficiency**: Elimination of redundant phase descriptions

### Command-Specific Adaptations
Each command defines specific phase implementations while maintaining core workflow structure:
- **analyze-file**: Standard workflow for file analysis
- **create-ticket**: Standard workflow for ticket generation
- **modularize**: Standard workflow for component extraction
- **optimize**: Standard workflow for performance enhancement
- **update-docs**: Standard workflow for documentation maintenance

[⬆ Return to top](#commands-index)

## Principle References

⏺ **Relationship**: This index operationalizes multiple principles through command organization and accessibility:
- **[workflow.md](../principles/workflow.md)**: Ensures all commands implement systematic eight-phase methodology
- **[organization.md](../principles/organization.md)**: Provides structural principles for command categorization and navigation
- **[communication.md](../principles/communication.md)**: Informs clear, actionable command descriptions and usage guidelines

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../index.md)
- [Study COMMANDS.md for command standards](COMMANDS.md)
- [Review PRINCIPLES.md for framework](../docs/PRINCIPLES.md)
- [Deploy project-optimizer for complex analysis](../../agents/project-management/coordination/project-optimizer.md)

### Related Documentation
- [Learn workflow.md for execution methodology](../principles/workflow.md)
- [Apply formatting.md for documentation standards](../principles/formatting.md)
- [Use command-template.md for new command creation](../templates/command-template.md)

### Command Files
- [Deploy create-ticket.md for task tracking](../../commands/domains/management/commands/create-ticket.md)
- [Execute review-tickets.md for priority-based execution](../../commands/domains/management/commands/review-tickets.md)
- [Apply modularize.md for component extraction](../../commands/compositions/solutions/modularize.md)
- [Execute system-audit.md for comprehensive analysis](../../commands/domains/analysis/workflows/system-audit.md)

