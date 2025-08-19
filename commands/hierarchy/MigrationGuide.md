---
title: "Command Hierarchy Migration Guide - Converting Existing Commands"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["README.md", "AbstractCommand.md"]
prerequisites: ["Hierarchy understanding", "Existing command knowledge"]
audience: "Developers, system architects, migration teams"
purpose: "Step-by-step guide for migrating existing commands to hierarchical inheritance structure"
keywords: ["migration", "hierarchy", "inheritance", "conversion", "refactoring"]
last_review: "2025-08-19"
architecture_type: "migration-guide"
execution_mode: "implementation"
validation_level: "comprehensive"
---

[Previous: Hierarchy Overview](README.md) | [Return to Commands Hub](../index.md) | [Next: Example Implementations](examples/)

# COMMAND HIERARCHY MIGRATION GUIDE

⏺ **Migration Strategy**: This guide provides step-by-step instructions for converting existing commands to use the hierarchical inheritance structure, demonstrating how to preserve all features while gaining the benefits of inheritance-based organization and reusability.

## Table of Contents
- [Definition](#definition)
- [Structure](#structure)
- [Execution Phases](#execution-phases)
- [Parameters](#parameters)
- [Success Criteria](#success-criteria)
- [Usage Examples](#usage-examples)
- [Implementation Template](#implementation-template)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Migration Overview

⏺ **Migration Philosophy**: The migration preserves all existing functionality while introducing inheritance benefits, ensuring no feature loss and improved maintainability.

### Migration Objectives
```yaml
migration_objectives:
  functionality_preservation:
    - complete_feature_retention: "All existing command features preserved"
    - behavior_consistency: "Command behavior remains identical"
    - interface_compatibility: "Existing interfaces maintained"
    - integration_continuity: "Existing integrations continue working"
    
  inheritance_benefits:
    - code_reusability: "Shared functionality through inheritance"
    - consistent_patterns: "Standardized command patterns"
    - maintenance_efficiency: "Centralized updates and improvements"
    - development_productivity: "Faster development of new commands"
    
  quality_improvements:
    - enhanced_validation: "Improved validation through inheritance"
    - better_error_handling: "Standardized error handling patterns"
    - consistent_logging: "Uniform logging across all commands"
    - quality_assurance: "Built-in quality gates and validation"
```

### Migration Strategy
```yaml
migration_strategy:
  incremental_approach:
    - phase_based_migration: "Migrate commands in logical phases"
    - risk_mitigation: "Minimize risk through incremental changes"
    - continuous_validation: "Validate functionality at each step"
    - rollback_capability: "Ability to rollback if issues arise"
    
  compatibility_maintenance:
    - backward_compatibility: "Maintain compatibility with existing code"
    - interface_preservation: "Preserve existing command interfaces"
    - integration_continuity: "Ensure continued integration functionality"
    - gradual_transition: "Allow gradual adoption of new patterns"
    
  validation_emphasis:
    - comprehensive_testing: "Thorough testing throughout migration"
    - behavior_verification: "Verify identical behavior pre/post migration"
    - performance_validation: "Ensure performance is maintained or improved"
    - integration_testing: "Test all integration points after migration"
```

## Pre-Migration Assessment

⏺ **Assessment Phase**: Thorough assessment of existing commands to plan effective migration strategy.

### Command Inventory and Analysis
```yaml
command_inventory:
  command_catalog:
    existing_commands:
      - system_audit_command: "Comprehensive system analysis functionality"
      - create_ticket_command: "Task creation and management functionality"
      - modularize_command: "Code organization and extraction functionality"
      - review_tickets_command: "Task review and prioritization functionality"
      - multi_analysis_execution: "Multi-perspective analysis coordination"
      
    functionality_analysis:
      - core_logic_identification: "Identify command-specific core logic"
      - shared_pattern_detection: "Detect patterns shared across commands"
      - dependency_mapping: "Map dependencies and integration points"
      - resource_usage_analysis: "Analyze resource usage patterns"
  
  pattern_identification:
    common_patterns:
      - validation_patterns: "Input and result validation patterns"
      - error_handling_patterns: "Error handling and recovery patterns"
      - logging_patterns: "Logging and monitoring patterns"
      - progress_tracking_patterns: "Progress reporting patterns"
      
    domain_specific_patterns:
      - analysis_patterns: "Data collection and analysis patterns"
      - management_patterns: "Resource and task coordination patterns"
      - execution_patterns: "Operation execution and monitoring patterns"
      - orchestration_patterns: "Multi-system coordination patterns"
      - workflow_patterns: "Phase-based execution patterns"
```

### Classification Framework
```yaml
classification_framework:
  classification_criteria:
    primary_responsibility:
      - analysis_focused: "Commands primarily performing analysis"
      - management_focused: "Commands primarily managing tasks/resources"
      - execution_focused: "Commands primarily executing operations"
      - orchestration_focused: "Commands primarily coordinating systems"
      - workflow_focused: "Commands following structured workflow phases"
      
    secondary_characteristics:
      - data_intensive: "Commands processing large amounts of data"
      - coordination_heavy: "Commands requiring significant coordination"
      - validation_critical: "Commands requiring extensive validation"
      - performance_sensitive: "Commands with performance requirements"
      - integration_complex: "Commands with complex integration needs"
  
  inheritance_mapping:
    classification_to_base_class:
      analysis_focused: "AnalysisCommand"
      management_focused: "ManagementCommand"
      execution_focused: "ExecutionCommand"
      orchestration_focused: "OrchestrationCommand"
      workflow_focused: "WorkflowCommand"
      
    multiple_characteristics_handling:
      - primary_classification: "Use primary responsibility for base class"
      - interface_composition: "Use interfaces for secondary characteristics"
      - delegation_patterns: "Delegate secondary concerns to composed objects"
```

## Step-by-Step Migration Process

⏺ **Migration Procedure**: Systematic step-by-step process for migrating individual commands to the hierarchy.

### Phase 1: Preparation and Setup
```yaml
phase_1_preparation:
  step_1_environment_setup:
    activities:
      - backup_creation: "Create backup of existing command implementations"
      - branch_creation: "Create migration branch for version control"
      - testing_framework_setup: "Setup testing framework for migration validation"
      - documentation_preparation: "Prepare migration documentation templates"
    
    validation_criteria:
      - backup_verified: "Backup successfully created and verified"
      - branch_isolated: "Migration branch properly isolated"
      - tests_baseline: "Baseline tests established and passing"
      - documentation_ready: "Documentation templates prepared"
  
  step_2_dependency_analysis:
    activities:
      - dependency_mapping: "Map all dependencies of command being migrated"
      - integration_point_identification: "Identify all integration points"
      - interface_analysis: "Analyze current interface contracts"
      - usage_pattern_analysis: "Analyze how command is currently used"
    
    validation_criteria:
      - dependencies_mapped: "All dependencies clearly mapped"
      - integrations_identified: "All integration points documented"
      - interfaces_analyzed: "Current interfaces thoroughly analyzed"
      - usage_understood: "Usage patterns clearly understood"
  
  step_3_classification_assignment:
    activities:
      - primary_responsibility_identification: "Identify command's primary responsibility"
      - base_class_selection: "Select appropriate base class for inheritance"
      - interface_requirements_analysis: "Determine which interfaces to implement"
      - customization_points_identification: "Identify required customization points"
    
    validation_criteria:
      - responsibility_clear: "Primary responsibility clearly identified"
      - base_class_selected: "Appropriate base class selected and justified"
      - interfaces_determined: "Required interfaces clearly determined"
      - customizations_identified: "Customization points clearly identified"
```

### Phase 2: Implementation Migration
```yaml
phase_2_implementation:
  step_4_class_structure_migration:
    activities:
      - inheritance_declaration: "Declare inheritance from selected base class"
      - interface_implementation: "Implement required interfaces"
      - abstract_method_implementation: "Implement abstract methods from base class"
      - constructor_migration: "Migrate constructor to use dependency injection"
    
    implementation_pattern: |
      // Before: Standalone command
      public class SystemAuditCommand {
          public ExecutionResult execute(ExecutionContext context) {
              // All logic implemented here
          }
      }
      
      // After: Inherits from AnalysisCommand
      public class SystemAuditCommand extends AnalysisCommand implements IValidatable {
          @Override
          protected ExecutionResult execute_core_logic(ExecutionContext context) {
              // Command-specific logic only
          }
          
          @Override
          protected AnalysisScope define_analysis_scope() {
              // Analysis scope definition
          }
      }
    
    validation_criteria:
      - inheritance_declared: "Inheritance properly declared and compiling"
      - interfaces_implemented: "All required interfaces properly implemented"
      - abstract_methods_complete: "All abstract methods implemented"
      - constructor_updated: "Constructor properly updated for dependency injection"
  
  step_5_functionality_migration:
    activities:
      - core_logic_extraction: "Extract command-specific logic to appropriate methods"
      - shared_functionality_removal: "Remove functionality now provided by base class"
      - customization_implementation: "Implement customizations through hook methods"
      - integration_preservation: "Ensure existing integrations continue working"
    
    migration_pattern: |
      // Extract command-specific logic
      @Override
      protected ExecutionResult execute_core_logic(ExecutionContext context) {
          // Move only command-specific logic here
          return performSystemAudit(context);
      }
      
      // Remove shared functionality (now inherited)
      // DELETE: Generic error handling, logging, progress tracking
      
      // Implement customizations
      @Override
      protected void customize_initialization() {
          // System audit specific initialization
      }
    
    validation_criteria:
      - logic_extracted: "Core logic properly extracted to appropriate methods"
      - shared_removed: "Shared functionality properly removed"
      - customizations_implemented: "Customizations properly implemented"
      - integrations_preserved: "Existing integrations continue working"
  
  step_6_interface_compliance:
    activities:
      - interface_method_implementation: "Implement all interface methods"
      - contract_compliance_verification: "Verify compliance with interface contracts"
      - behavior_consistency_validation: "Validate behavior consistency"
      - documentation_updates: "Update documentation for new interface contracts"
    
    validation_criteria:
      - methods_implemented: "All interface methods properly implemented"
      - contracts_compliant: "Interface contracts properly followed"
      - behavior_consistent: "Behavior consistent with interface expectations"
      - documentation_updated: "Documentation reflects new interface contracts"
```

### Phase 3: Validation and Integration
```yaml
phase_3_validation:
  step_7_functionality_testing:
    activities:
      - unit_testing: "Comprehensive unit testing of migrated command"
      - integration_testing: "Testing of all integration points"
      - behavior_comparison: "Compare behavior before and after migration"
      - performance_testing: "Validate performance is maintained or improved"
    
    testing_framework: |
      // Behavior comparison testing
      @Test
      public void testMigratedBehaviorConsistency() {
          ExecutionContext context = createTestContext();
          
          // Execute with original implementation (if preserved)
          ExecutionResult originalResult = originalImplementation.execute(context);
          
          // Execute with migrated implementation
          ExecutionResult migratedResult = migratedImplementation.execute(context);
          
          // Validate identical behavior
          assertResultsEquivalent(originalResult, migratedResult);
      }
    
    validation_criteria:
      - unit_tests_passing: "All unit tests passing"
      - integration_tests_passing: "All integration tests passing"
      - behavior_identical: "Behavior identical to pre-migration"
      - performance_maintained: "Performance maintained or improved"
  
  step_8_integration_validation:
    activities:
      - downstream_integration_testing: "Test all downstream integrations"
      - upstream_integration_testing: "Test all upstream integrations"
      - end_to_end_testing: "Complete end-to-end workflow testing"
      - compatibility_verification: "Verify backward compatibility"
    
    validation_criteria:
      - downstream_working: "All downstream integrations working"
      - upstream_working: "All upstream integrations working"
      - end_to_end_successful: "End-to-end workflows successful"
      - compatibility_maintained: "Backward compatibility maintained"
  
  step_9_documentation_and_finalization:
    activities:
      - documentation_updates: "Update all relevant documentation"
      - example_updates: "Update usage examples and guides"
      - migration_notes: "Document migration changes and rationale"
      - developer_guidance: "Provide guidance for future development"
    
    validation_criteria:
      - documentation_complete: "All documentation updated and complete"
      - examples_updated: "Usage examples updated and tested"
      - migration_documented: "Migration changes properly documented"
      - guidance_provided: "Clear guidance provided for developers"
```

## Command Classification Guidelines

⏺ **Classification Framework**: Guidelines for determining which base class each command should inherit from.

### Classification Decision Tree
```yaml
classification_decision_tree:
  primary_classification:
    question_1: "What is the command's primary responsibility?"
    
    analysis_path:
      condition: "Command primarily analyzes data, systems, or processes"
      base_class: "AnalysisCommand"
      characteristics:
        - data_collection_heavy: "Significant data gathering and processing"
        - insight_generation: "Generates insights from analysis"
        - pattern_detection: "Detects patterns in data or systems"
        - reporting_focused: "Produces analysis reports and findings"
      
    management_path:
      condition: "Command primarily manages tasks, resources, or coordination"
      base_class: "ManagementCommand"
      characteristics:
        - resource_coordination: "Coordinates resources and assignments"
        - task_lifecycle_management: "Manages task creation, tracking, completion"
        - stakeholder_communication: "Handles stakeholder interactions"
        - priority_management: "Manages priorities and scheduling"
      
    execution_path:
      condition: "Command primarily executes operations or processes"
      base_class: "ExecutionCommand"
      characteristics:
        - operation_coordination: "Coordinates execution of operations"
        - runtime_management: "Manages runtime environment and resources"
        - performance_monitoring: "Monitors execution performance"
        - error_recovery: "Handles execution errors and recovery"
      
    orchestration_path:
      condition: "Command primarily coordinates multiple systems or services"
      base_class: "OrchestrationCommand"
      characteristics:
        - multi_system_coordination: "Coordinates interactions between systems"
        - integration_management: "Manages system integration points"
        - event_driven_coordination: "Coordinates through events and messages"
        - state_synchronization: "Synchronizes state across systems"
      
    workflow_path:
      condition: "Command follows structured phases or systematic methodology"
      base_class: "WorkflowCommand"
      characteristics:
        - phase_based_execution: "Executes in structured phases"
        - systematic_methodology: "Follows established methodologies"
        - workflow_state_management: "Manages workflow state and transitions"
        - adaptive_execution: "Adapts execution based on outcomes"
  
  secondary_classification:
    interface_selection:
      validation_heavy: "IValidatable - for commands requiring extensive validation"
      composition_capable: "IComposable - for commands that can be composed with others"
      progress_trackable: "IMonitorable - for commands requiring progress tracking"
      
    delegation_patterns:
      cross_cutting_concerns: "Use composition for concerns spanning multiple domains"
      utility_functions: "Use utility classes for reusable helper functions"
      external_integrations: "Use adapters for external system integrations"
```

### Classification Examples
```yaml
classification_examples:
  system_audit_command:
    analysis: "Primary responsibility is analyzing system state and generating insights"
    classification: "AnalysisCommand"
    rationale: "Focuses on data collection, analysis, and insight generation"
    interfaces: ["IValidatable", "IMonitorable"]
    
  create_ticket_command:
    analysis: "Primary responsibility is managing task creation and lifecycle"
    classification: "ManagementCommand"
    rationale: "Focuses on resource coordination and task management"
    interfaces: ["IValidatable"]
    
  execute_parallel_plan_command:
    analysis: "Primary responsibility is executing operations in parallel"
    classification: "ExecutionCommand"
    rationale: "Focuses on operation coordination and runtime management"
    interfaces: ["IExecutable", "IMonitorable"]
    
  multi_analysis_execution_command:
    analysis: "Primary responsibility is coordinating multiple analysis systems"
    classification: "OrchestrationCommand"
    rationale: "Focuses on multi-system coordination and integration"
    interfaces: ["IComposable", "IMonitorable"]
    
  clarify_command:
    analysis: "Primary responsibility is executing clarification phase systematically"
    classification: "WorkflowCommand"
    rationale: "Follows structured workflow methodology"
    interfaces: ["IValidatable"]
```

## Concrete Migration Examples

⏺ **Real Examples**: Step-by-step migration examples showing how to convert specific existing commands.

### Example 1: SystemAuditCommand Migration
```yaml
system_audit_migration:
  before_migration:
    structure: |
      public class SystemAuditCommand {
          private ValidationFramework validator;
          private LoggingSystem logger;
          private ProgressTracker progressTracker;
          
          public ExecutionResult execute(ExecutionContext context) {
              try {
                  // Validation logic
                  if (!validateContext(context)) {
                      return ExecutionResult.failure("Validation failed");
                  }
                  
                  // Progress tracking setup
                  progressTracker.initialize();
                  
                  // Core audit logic
                  SystemCatalog catalog = scanSystem(context.getSystemRoot());
                  QualityAssessment quality = assessQuality(catalog);
                  ComplianceResults compliance = checkCompliance(catalog);
                  
                  // Result generation
                  AuditReport report = generateReport(catalog, quality, compliance);
                  
                  // Cleanup
                  progressTracker.finalize();
                  
                  return ExecutionResult.success(report);
              } catch (Exception e) {
                  logger.error("Audit failed", e);
                  return ExecutionResult.failure(e.getMessage());
              }
          }
          
          // Lots of boilerplate code for validation, logging, progress tracking...
      }
    
    characteristics:
      - code_duplication: "Validation, logging, progress tracking repeated"
      - mixed_concerns: "Infrastructure and business logic mixed"
      - inconsistent_patterns: "Patterns differ from other commands"
  
  after_migration:
    structure: |
      public class SystemAuditCommand extends AnalysisCommand implements IValidatable, IMonitorable {
          
          // Constructor with dependency injection
          public SystemAuditCommand(AuditValidationFramework validator,
                                   AuditAgentCoordinator agentCoordinator,
                                   AuditWorkflowEngine workflowEngine) {
              super(validator, agentCoordinator, workflowEngine);
          }
          
          // Required abstract method implementations
          @Override
          protected AnalysisScope define_analysis_scope() {
              return AnalysisScope.builder()
                  .systemRoot(getExecutionContext().getSystemRoot())
                  .inclusionPatterns(getExecutionContext().getInclusionPatterns())
                  .analysisDepth(AnalysisDepth.COMPREHENSIVE)
                  .build();
          }
          
          @Override
          protected AnalysisData collect_analysis_data() {
              SystemCatalog catalog = scanSystem(getAnalysisScope().getSystemRoot());
              return AnalysisData.builder()
                  .systemCatalog(catalog)
                  .timestamp(Instant.now())
                  .build();
          }
          
          @Override
          protected AnalysisResults process_analysis_data(AnalysisData data) {
              SystemCatalog catalog = data.getSystemCatalog();
              
              QualityAssessment quality = assessQuality(catalog);
              ComplianceResults compliance = checkCompliance(catalog);
              
              return AnalysisResults.builder()
                  .qualityAssessment(quality)
                  .complianceResults(compliance)
                  .build();
          }
          
          @Override
          protected SynthesisReport synthesize_findings(AnalysisResults results) {
              return generateAuditReport(
                  results.getQualityAssessment(),
                  results.getComplianceResults()
              );
          }
          
          // Optional customization
          @Override
          protected void customize_initialization() {
              // System audit specific initialization
              setupAuditSpecificMonitoring();
          }
          
          // Interface implementations
          @Override
          public ValidationResult validate() {
              return getValidationFramework().validateAuditContext(getExecutionContext());
          }
          
          @Override
          public ProgressInfo getProgress() {
              return getProgressTracker().getCurrentProgress();
          }
      }
    
    benefits:
      - reduced_code: "50% reduction in boilerplate code"
      - consistent_patterns: "Consistent with other analysis commands"
      - inherited_infrastructure: "Validation, logging, progress tracking inherited"
      - focused_logic: "Focus only on audit-specific logic"
```

### Example 2: CreateTicketCommand Migration
```yaml
create_ticket_migration:
  before_migration:
    structure: |
      public class CreateTicketCommand {
          public ExecutionResult execute(ExecutionContext context) {
              // Manual validation
              if (!isValidRequest(context)) {
                  return ExecutionResult.failure("Invalid request");
              }
              
              // Manual resource coordination
              if (!allocateResources(context)) {
                  return ExecutionResult.failure("Resource allocation failed");
              }
              
              // Core ticket creation logic
              Ticket ticket = createTicket(context.getTaskDescription());
              assignPriority(ticket, context);
              updateRegistry(ticket);
              
              // Manual cleanup
              deallocateResources();
              
              return ExecutionResult.success(ticket);
          }
      }
    
    issues:
      - manual_resource_management: "Manual resource allocation and cleanup"
      - inconsistent_validation: "Custom validation not aligned with standards"
      - no_progress_tracking: "No progress tracking or stakeholder communication"
  
  after_migration:
    structure: |
      public class CreateTicketCommand extends ManagementCommand implements IValidatable {
          
          @Override
          protected ManagementScope define_management_scope() {
              return ManagementScope.builder()
                  .taskType(getExecutionContext().getTaskType())
                  .resourceRequirements(determineResourceRequirements())
                  .stakeholders(identifyStakeholders())
                  .build();
          }
          
          @Override
          protected ResourceRequirements assess_resource_requirements() {
              return ResourceRequirements.builder()
                  .templateResources(getRequiredTemplates())
                  .validationResources(getValidationRequirements())
                  .integrationResources(getIntegrationRequirements())
                  .build();
          }
          
          @Override
          protected ExecutionCoordination coordinate_task_execution(TaskSpecification spec) {
              Ticket ticket = createTicket(spec.getTaskDescription());
              assignPriority(ticket, spec);
              updateRegistry(ticket);
              
              return ExecutionCoordination.builder()
                  .primaryDeliverable(ticket)
                  .coordinationStatus(CoordinationStatus.COMPLETED)
                  .build();
          }
          
          @Override
          protected CommunicationResults manage_stakeholder_communication(CommunicationContext context) {
              return notifyStakeholders(context.getTicket(), context.getStakeholders());
          }
          
          // Interface implementation
          @Override
          public ValidationResult validate() {
              return getValidationFramework().validateTicketCreationContext(getExecutionContext());
          }
      }
    
    benefits:
      - automatic_resource_management: "Resource allocation and cleanup inherited"
      - standardized_validation: "Consistent validation patterns"
      - built_in_progress_tracking: "Automatic progress tracking and stakeholder communication"
      - focused_business_logic: "Focus only on ticket creation business logic"
```

## Validation and Testing

⏺ **Validation Framework**: Comprehensive testing and validation approach for migration success.

### Testing Strategy
```yaml
testing_strategy:
  pre_migration_testing:
    baseline_establishment:
      - functional_tests: "Establish baseline functional test suite"
      - performance_tests: "Establish baseline performance metrics"
      - integration_tests: "Establish baseline integration test suite"
      - behavior_documentation: "Document current behavior patterns"
    
    test_automation:
      - automated_test_suite: "Automate all baseline tests"
      - regression_detection: "Setup regression detection mechanisms"
      - performance_monitoring: "Setup performance monitoring"
      - integration_monitoring: "Setup integration point monitoring"
  
  migration_testing:
    behavior_verification:
      - input_output_testing: "Verify identical input/output behavior"
      - edge_case_testing: "Test edge cases and error conditions"
      - performance_testing: "Verify performance is maintained or improved"
      - resource_usage_testing: "Verify resource usage patterns"
    
    integration_testing:
      - downstream_testing: "Test all downstream integrations"
      - upstream_testing: "Test all upstream integrations"
      - cross_system_testing: "Test cross-system interactions"
      - end_to_end_testing: "Complete workflow testing"
  
  post_migration_validation:
    comprehensive_testing:
      - full_regression_suite: "Run complete regression test suite"
      - stress_testing: "Perform stress and load testing"
      - compatibility_testing: "Verify backward compatibility"
      - user_acceptance_testing: "Validate user acceptance"
    
    monitoring_setup:
      - production_monitoring: "Setup production monitoring"
      - performance_monitoring: "Monitor performance metrics"
      - error_monitoring: "Monitor error rates and patterns"
      - usage_monitoring: "Monitor usage patterns and adoption"
```

### Validation Checklist
```yaml
validation_checklist:
  functionality_validation:
    - feature_completeness: "All original features present and working"
    - behavior_consistency: "Behavior identical to pre-migration"
    - error_handling: "Error handling working as expected"
    - edge_cases: "Edge cases handled correctly"
    
  performance_validation:
    - execution_time: "Execution time maintained or improved"
    - memory_usage: "Memory usage efficient and appropriate"
    - resource_utilization: "Resource utilization optimized"
    - scalability: "Scalability maintained or improved"
    
  integration_validation:
    - api_compatibility: "API compatibility maintained"
    - data_formats: "Data formats unchanged or backward compatible"
    - protocol_compliance: "Communication protocols working"
    - dependency_resolution: "All dependencies resolved correctly"
    
  quality_validation:
    - code_quality: "Code quality improved through inheritance"
    - maintainability: "Code more maintainable post-migration"
    - testability: "Code more testable with inheritance structure"
    - documentation: "Documentation complete and accurate"
```

## Common Migration Patterns

⏺ **Pattern Library**: Common patterns encountered during migration and their solutions.

### Pattern 1: Extracting Shared Logic
```yaml
shared_logic_extraction:
  pattern_description: "Move shared functionality from concrete commands to base classes"
  
  before_pattern: |
    // Duplicated across multiple commands
    public class Command1 {
        public ExecutionResult execute(ExecutionContext context) {
            // Validation logic (duplicated)
            if (!validate(context)) return failure();
            
            // Progress tracking setup (duplicated)
            progressTracker.start();
            
            // Command-specific logic
            Result result = doCommand1Work();
            
            // Cleanup (duplicated)
            progressTracker.stop();
            return success(result);
        }
    }
    
  after_pattern: |
    // Shared functionality in base class
    public abstract class AbstractCommand {
        public final ExecutionResult execute(ExecutionContext context) {
            if (!validate_prerequisites()) return failure();
            
            prepare_execution(context);
            ExecutionResult result = execute_core_logic(context);
            finalize_execution(result);
            
            return result;
        }
        
        protected abstract ExecutionResult execute_core_logic(ExecutionContext context);
    }
    
    // Command focuses only on specific logic
    public class Command1 extends AbstractCommand {
        @Override
        protected ExecutionResult execute_core_logic(ExecutionContext context) {
            return doCommand1Work();
        }
    }
  
  benefits:
    - elimination_of_duplication: "Shared logic implemented once"
    - consistent_behavior: "Consistent execution patterns"
    - easier_maintenance: "Updates to shared logic benefit all commands"
```

### Pattern 2: Interface Implementation
```yaml
interface_implementation_pattern:
  pattern_description: "Add interface implementations for specific capabilities"
  
  implementation_strategy: |
    // Determine which interfaces command should implement
    public class AnalysisCommand extends AbstractCommand 
        implements IValidatable, IMonitorable {
        
        // Implement validation interface
        @Override
        public ValidationResult validate() {
            return getValidationFramework().validate(getExecutionContext());
        }
        
        // Implement monitoring interface
        @Override
        public ProgressInfo getProgress() {
            return getProgressTracker().getCurrentProgress();
        }
    }
  
  interface_selection_guidelines:
    - IExecutable: "Always implemented (through AbstractCommand)"
    - IValidatable: "For commands requiring extensive validation"
    - IComposable: "For commands that can be composed with others"
    - IMonitorable: "For long-running commands requiring progress tracking"
```

### Pattern 3: Dependency Injection Migration
```yaml
dependency_injection_pattern:
  pattern_description: "Migrate from manual dependency management to injection"
  
  before_pattern: |
    public class Command {
        private ValidationFramework validator = new ValidationFramework();
        private LoggingSystem logger = LoggingSystem.getInstance();
        
        public ExecutionResult execute(ExecutionContext context) {
            // Direct dependency usage
        }
    }
  
  after_pattern: |
    public class Command extends AbstractCommand {
        // Dependencies injected through constructor
        public Command(ValidationFramework validator,
                      AgentCoordinator agentCoordinator,
                      WorkflowEngine workflowEngine) {
            super(validator, agentCoordinator, workflowEngine);
        }
        
        @Override
        protected ExecutionResult execute_core_logic(ExecutionContext context) {
            // Use inherited dependency access methods
            getValidationFramework().validate(context);
            getLogger().info("Executing command");
        }
    }
  
  benefits:
    - testability: "Dependencies can be mocked for testing"
    - flexibility: "Different implementations can be injected"
    - consistency: "Consistent dependency management across commands"
```

## Cross-References

### Migration Resources
- [Hierarchy Overview](README.md) - Complete hierarchy architecture
- [AbstractCommand](AbstractCommand.md) - Base class functionality
- [Interface Definitions](interfaces/) - Available interface contracts

### Example Implementations
- [Migrated SystemAuditCommand](examples/MigratedSystemAuditCommand.md) - Complete migration example
- [Migrated CreateTicketCommand](examples/MigratedCreateTicketCommand.md) - Management command example
- [Migration Testing Framework](examples/MigrationTestingFramework.md) - Testing approach

### Framework Integration
- [SOLID Architecture](../SOLID_ARCHITECTURE.md) - SOLID principles in hierarchy
- [Command Architecture](../../docs/components/command-architecture-patterns.md) - Architectural patterns
- [Quality Framework](../../docs/components/core-framework/quality-integration.md) - Quality assurance

[⬆ Return to top](#command-hierarchy-migration-guide)