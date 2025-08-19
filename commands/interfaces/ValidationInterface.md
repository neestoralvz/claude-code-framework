---
title: "ValidationInterface - Validation Contract"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["CommandInterface.md"]
prerequisites: ["Validation pattern understanding", "Interface design principles"]
audience: "Developers, architects, validation implementers"
purpose: "Focused validation interface defining validation contract"
keywords: ["validation", "interface", "contract", "segregated", "focused"]
last_review: "2025-08-19"
architecture_type: "SOLID-compliant"
---

[Previous: CommandInterface](CommandInterface.md) | [Return to Commands Hub](../../index.md) | [Next: AgentInterface](AgentInterface.md)

# VALIDATION INTERFACE - VALIDATION CONTRACT

## Purpose

⏺ **Interface Segregation**: This interface defines only validation-related operations, adhering to the Interface Segregation Principle by separating validation concerns from execution concerns.

## Core Validation Contract

```yaml
ValidationInterface:
  essential_methods:
    validate(context: ValidationContext): ValidationResult
    get_validation_rules(): ValidationRule[]
    is_valid_context(context: ValidationContext): boolean
  
  validation_types:
    prerequisites: "Check command readiness"
    input_parameters: "Validate input data"
    system_state: "Verify system conditions"
    post_execution: "Validate execution results"
```

## Validation Method Definitions

### 1. Core Validation
```yaml
validate_method:
  signature: "validate(context: ValidationContext): ValidationResult"
  responsibility: "Perform comprehensive validation"
  parameters:
    context:
      type: "ValidationContext"
      contains: ["input_data", "system_state", "execution_environment"]
  returns:
    type: "ValidationResult"
    contains: ["is_valid", "violations", "warnings", "recommendations"]
```

### 2. Rules Definition
```yaml
rules_method:
  signature: "get_validation_rules(): ValidationRule[]"
  responsibility: "Provide validation rules for inspection"
  returns:
    type: "ValidationRule[]"
    description: "Array of validation rules with metadata"
```

### 3. Quick Check
```yaml
quick_check_method:
  signature: "is_valid_context(context: ValidationContext): boolean"
  responsibility: "Fast validation check for readiness"
  returns:
    type: "boolean"
    description: "True if context passes basic validation"
```

## Supporting Data Structures

### ValidationContext
```yaml
ValidationContext:
  input_data: Map<string, any>
  system_state: SystemState
  execution_environment: EnvironmentInfo
  validation_scope: ValidationScope
  custom_rules?: ValidationRule[]
```

### ValidationResult
```yaml
ValidationResult:
  is_valid: boolean
  violations: ValidationViolation[]
  warnings: ValidationWarning[]
  recommendations: string[]
  execution_time: number
```

### ValidationRule
```yaml
ValidationRule:
  id: string
  name: string
  description: string
  severity: "ERROR" | "WARNING" | "INFO"
  category: ValidationCategory
  validator_function: Function
```

### ValidationViolation
```yaml
ValidationViolation:
  rule_id: string
  message: string
  severity: "ERROR" | "WARNING"
  location?: string
  suggested_fix?: string
```

## Validation Categories

### 1. Input Validation
```yaml
input_validation:
  parameter_presence: "Required parameters exist"
  parameter_types: "Correct data types"
  parameter_ranges: "Values within acceptable ranges"
  parameter_formats: "Proper format compliance"
```

### 2. System Validation
```yaml
system_validation:
  dependency_availability: "Required dependencies present"
  resource_availability: "Sufficient system resources"
  permission_checks: "Adequate permissions"
  configuration_validity: "Valid configuration settings"
```

### 3. Context Validation
```yaml
context_validation:
  environment_compatibility: "Compatible execution environment"
  state_consistency: "Consistent system state"
  prerequisite_completion: "Prerequisites satisfied"
  conflict_detection: "No conflicting operations"
```

## Validation Strategies

### 1. Fail-Fast Validation
```yaml
fail_fast:
  approach: "Stop on first critical error"
  use_cases: ["Prerequisites", "Critical dependencies"]
  benefits: ["Quick feedback", "Prevents cascading failures"]
```

### 2. Comprehensive Validation
```yaml
comprehensive:
  approach: "Collect all validation issues"
  use_cases: ["Input analysis", "System health checks"]
  benefits: ["Complete picture", "Better user guidance"]
```

### 3. Incremental Validation
```yaml
incremental:
  approach: "Validate in phases"
  use_cases: ["Complex workflows", "Long-running operations"]
  benefits: ["Early detection", "Progressive validation"]
```

## Implementation Patterns

### 1. Rule-Based Validator
```yaml
rule_based:
  pattern: "Define rules, apply to context"
  implementation:
    - Define validation rules as functions
    - Apply rules to validation context
    - Collect and format results
  
  example:
    class: RuleBasedValidator
    implements: ValidationInterface
    rules: ["ParameterPresenceRule", "TypeValidationRule"]
```

### 2. Schema Validator
```yaml
schema_based:
  pattern: "Validate against predefined schema"
  implementation:
    - Define JSON/YAML schemas
    - Validate input against schema
    - Generate validation results
  
  example:
    class: SchemaValidator
    implements: ValidationInterface
    schema: "command-input-schema.json"
```

### 3. Custom Logic Validator
```yaml
custom_logic:
  pattern: "Implement custom validation logic"
  implementation:
    - Define validation algorithms
    - Implement business rules
    - Return structured results
  
  example:
    class: BusinessRuleValidator
    implements: ValidationInterface
    logic: "Custom business validation rules"
```

## SOLID Compliance Benefits

### Interface Segregation
- Focused solely on validation concerns
- No mixing with execution or coordination logic
- Clients use only validation methods they need

### Single Responsibility
- Interface responsible only for validation
- Clear separation from other concerns
- Cohesive validation operations

### Dependency Inversion
- Commands depend on validation abstraction
- Concrete validators implement interface
- Validation logic is pluggable

### Open/Closed
- Interface stable for existing implementations
- Open for new validation strategies
- Extensible without modification

## Composition with Commands

### Dependency Injection
```yaml
command_composition:
  class: AuditCommand
  implements: CommandInterface
  
  dependencies:
    validator: ValidationInterface
  
  execute_method:
    - validation_result = validator.validate(context)
    - if (!validation_result.is_valid) return error
    - proceed with execution
```

### Multiple Validators
```yaml
multiple_validators:
  class: ComplexCommand
  implements: CommandInterface
  
  dependencies:
    input_validator: ValidationInterface
    system_validator: ValidationInterface
    output_validator: ValidationInterface
  
  validation_chain:
    - Input validation before execution
    - System validation during execution
    - Output validation after execution
```

## Cross-References

### Related Interfaces
- [CommandInterface.md](CommandInterface.md) - Core command contract
- [AgentInterface.md](AgentInterface.md) - Agent coordination contract
- [WorkflowInterface.md](WorkflowInterface.md) - Workflow execution contract

### Core Components
- [ValidationFramework.md](../core/ValidationFramework.md) - Concrete validation implementation
- [BaseCommand.md](../core/BaseCommand.md) - Abstract command with validation

### Implementation Examples
- [AuditValidator.md](../examples/AuditValidator.md) - System audit validation
- [TicketValidator.md](../examples/TicketValidator.md) - Ticket creation validation

[⬆ Return to top](#validation-interface---validation-contract)