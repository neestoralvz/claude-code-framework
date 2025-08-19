---
title: "Analysis Molecules - Atomic Analysis Patterns"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["../atoms/FileAtoms.md", "../atoms/ValidationAtoms.md", "../atoms/AgentAtoms.md", "../atoms/GitAtoms.md"]
prerequisites: ["Atomic operations understanding", "Analysis methodology knowledge"]
audience: "System developers, analysis specialists, command builders"
purpose: "Molecular patterns combining atomic operations for comprehensive analysis workflows"
keywords: ["molecular", "analysis", "patterns", "atomic-composition", "systematic"]
last_review: "2025-08-19"
architecture_type: "molecular-patterns"
execution_mode: "composable"
validation_level: "comprehensive"
---

[Previous: Atomic Operations](../atoms/index.md) | [Return to Molecules Index](index.md) | [Next: Management Molecules](ManagementMolecules.md)

# ANALYSIS MOLECULES - ATOMIC ANALYSIS PATTERNS

## Purpose

⏺ **Molecular Design**: Analysis patterns that combine multiple atomic operations to create reusable, higher-level analysis capabilities while maintaining composability and single responsibility.

## Core Analysis Molecules

### 1. SystemScanMolecule
```yaml
molecule_definition:
  name: SystemScanMolecule
  responsibility: "Comprehensive system scanning and cataloging"
  atomic_composition:
    - ScanDirectoryAtom: "discover_all_system_files"
    - ValidateFileAtom: "verify_file_accessibility"
    - SearchFileAtom: "extract_content_patterns"
    - IndexContentAtom: "catalog_discovered_content"
  input: "scan_specification: object"
  output: "system_catalog: object | error"
  side_effects: "index_file_creation"
  
composition_logic: |
  function SystemScanMolecule(scan_specification) {
    // Phase 1: Discovery
    discovered_files = ScanDirectoryAtom(
      scan_specification.root_path,
      scan_specification.file_filters
    )
    
    // Phase 2: Validation
    validated_files = parallel_map(
      discovered_files,
      file => ValidateFileAtom(file, scan_specification.validation_rules)
    )
    
    // Phase 3: Content Extraction
    content_patterns = parallel_map(
      validated_files.accessible,
      file => SearchFileAtom(file, scan_specification.content_patterns)
    )
    
    // Phase 4: Cataloging
    system_catalog = IndexContentAtom(
      {files: validated_files, patterns: content_patterns},
      scan_specification.indexing_criteria
    )
    
    return {
      catalog: system_catalog,
      statistics: generate_scan_statistics(validated_files, content_patterns),
      recommendations: generate_improvement_recommendations(system_catalog)
    }
  }
```

### 2. QualityAssessmentMolecule
```yaml
molecule_definition:
  name: QualityAssessmentMolecule
  responsibility: "Comprehensive quality assessment and scoring"
  atomic_composition:
    - ValidateFormatAtom: "assess_structural_quality"
    - CheckComplianceAtom: "verify_standards_adherence"
    - VerifyIntegrityAtom: "validate_data_consistency"
    - ValidateOutputAtom: "assess_deliverable_quality"
  input: "assessment_target: object, quality_criteria: object"
  output: "quality_assessment: object | error"
  side_effects: "none"
  
composition_logic: |
  function QualityAssessmentMolecule(assessment_target, quality_criteria) {
    // Parallel quality assessments
    quality_results = parallel_execute([
      ValidateFormatAtom(assessment_target, quality_criteria.format),
      CheckComplianceAtom(assessment_target, quality_criteria.compliance),
      VerifyIntegrityAtom(assessment_target, quality_criteria.integrity),
      ValidateOutputAtom(assessment_target, quality_criteria.output)
    ])
    
    // Aggregate quality scores
    aggregated_score = calculate_weighted_quality_score(
      quality_results,
      quality_criteria.weights
    )
    
    // Generate improvement recommendations
    improvement_plan = generate_improvement_plan(
      quality_results.violations,
      quality_criteria.improvement_strategies
    )
    
    return {
      overall_score: aggregated_score,
      detailed_results: quality_results,
      improvement_plan: improvement_plan,
      compliance_status: assess_compliance_status(quality_results)
    }
  }
```

### 3. DependencyAnalysisMolecule
```yaml
molecule_definition:
  name: DependencyAnalysisMolecule
  responsibility: "Analyze dependencies and relationships between components"
  atomic_composition:
    - ReadFileAtom: "read_component_definitions"
    - SearchFileAtom: "extract_dependency_references"
    - ValidateDocumentAtom: "verify_dependency_documentation"
    - CrossReferenceAtom: "map_dependency_relationships"
  input: "component_collection: array, analysis_criteria: object"
  output: "dependency_analysis: object | error"
  side_effects: "dependency_map_creation"
  
composition_logic: |
  function DependencyAnalysisMolecule(component_collection, analysis_criteria) {
    // Extract dependency information
    dependency_data = parallel_map(
      component_collection,
      component => {
        content = ReadFileAtom(component.path)
        dependencies = SearchFileAtom(content, analysis_criteria.dependency_patterns)
        documentation = ValidateDocumentAtom(component.path, analysis_criteria.doc_requirements)
        return {component, dependencies, documentation}
      }
    )
    
    // Build dependency graph
    dependency_graph = build_dependency_graph(
      dependency_data,
      analysis_criteria.relationship_rules
    )
    
    // Analyze dependency patterns
    analysis_results = {
      circular_dependencies: detect_circular_dependencies(dependency_graph),
      missing_dependencies: identify_missing_dependencies(dependency_data),
      unused_components: find_unused_components(dependency_graph),
      coupling_metrics: calculate_coupling_metrics(dependency_graph),
      dependency_violations: check_dependency_rules(dependency_graph, analysis_criteria.rules)
    }
    
    // Generate cross-references
    cross_references = parallel_map(
      analysis_results.valid_dependencies,
      dep => CrossReferenceAtom(dep.source, dep.target, dep.type)
    )
    
    return {
      dependency_graph: dependency_graph,
      analysis_results: analysis_results,
      recommendations: generate_dependency_recommendations(analysis_results),
      cross_references: cross_references
    }
  }
```

### 4. PerformanceAnalysisMolecule
```yaml
molecule_definition:
  name: PerformanceAnalysisMolecule
  responsibility: "Analyze system performance characteristics and bottlenecks"
  atomic_composition:
    - TestFunctionalityAtom: "execute_performance_tests"
    - MonitorAgentAtom: "monitor_system_metrics"
    - ValidateOutputAtom: "validate_performance_results"
    - VerifyIntegrityAtom: "verify_measurement_accuracy"
  input: "performance_target: object, performance_criteria: object"
  output: "performance_analysis: object | error"
  side_effects: "performance_test_execution"
  
composition_logic: |
  function PerformanceAnalysisMolecule(performance_target, performance_criteria) {
    // Execute performance tests
    performance_tests = parallel_map(
      performance_criteria.test_scenarios,
      scenario => TestFunctionalityAtom(performance_target, scenario)
    )
    
    // Monitor system metrics during tests
    monitoring_data = MonitorAgentAtom(
      performance_target,
      performance_criteria.monitoring_configuration
    )
    
    // Validate test results
    result_validation = ValidateOutputAtom(
      performance_tests,
      performance_criteria.result_validation
    )
    
    // Verify measurement integrity
    measurement_integrity = VerifyIntegrityAtom(
      {tests: performance_tests, monitoring: monitoring_data},
      performance_criteria.integrity_checks
    )
    
    // Analyze performance patterns
    performance_patterns = analyze_performance_patterns(
      performance_tests,
      monitoring_data,
      performance_criteria.analysis_patterns
    )
    
    return {
      test_results: performance_tests,
      monitoring_data: monitoring_data,
      performance_metrics: extract_performance_metrics(performance_tests),
      bottlenecks: identify_performance_bottlenecks(performance_patterns),
      recommendations: generate_performance_recommendations(performance_patterns)
    }
  }
```

### 5. ComplianceAuditMolecule
```yaml
molecule_definition:
  name: ComplianceAuditMolecule
  responsibility: "Comprehensive compliance auditing against standards"
  atomic_composition:
    - CheckComplianceAtom: "verify_rule_adherence"
    - ValidateFormatAtom: "check_format_compliance"
    - VerifyExistenceAtom: "verify_required_components"
    - ValidateDocumentAtom: "audit_documentation_compliance"
  input: "audit_target: object, compliance_framework: object"
  output: "compliance_audit: object | error"
  side_effects: "audit_report_generation"
  
composition_logic: |
  function ComplianceAuditMolecule(audit_target, compliance_framework) {
    // Verify required components exist
    existence_audit = parallel_map(
      compliance_framework.required_components,
      component => VerifyExistenceAtom(component.path, component.type)
    )
    
    // Check compliance against rules
    compliance_audit = parallel_map(
      compliance_framework.compliance_rules,
      rule_set => CheckComplianceAtom(audit_target, rule_set)
    )
    
    // Validate format compliance
    format_audit = parallel_map(
      compliance_framework.format_requirements,
      format_spec => ValidateFormatAtom(audit_target, format_spec)
    )
    
    // Audit documentation compliance
    documentation_audit = parallel_map(
      compliance_framework.documentation_requirements,
      doc_spec => ValidateDocumentAtom(audit_target, doc_spec)
    )
    
    // Aggregate audit results
    audit_results = aggregate_audit_results([
      existence_audit,
      compliance_audit,
      format_audit,
      documentation_audit
    ])
    
    // Calculate compliance score
    compliance_score = calculate_compliance_score(
      audit_results,
      compliance_framework.scoring_criteria
    )
    
    return {
      overall_compliance_score: compliance_score,
      detailed_audit_results: audit_results,
      violations: extract_compliance_violations(audit_results),
      remediation_plan: generate_remediation_plan(audit_results.violations),
      certification_status: assess_certification_eligibility(compliance_score)
    }
  }
```

### 6. SecurityAnalysisMolecule
```yaml
molecule_definition:
  name: SecurityAnalysisMolecule
  responsibility: "Comprehensive security analysis and vulnerability assessment"
  atomic_composition:
    - SearchFileAtom: "scan_for_security_patterns"
    - ValidateFileAtom: "verify_file_permissions"
    - CheckComplianceAtom: "verify_security_compliance"
    - TestFunctionalityAtom: "execute_security_tests"
  input: "security_target: object, security_criteria: object"
  output: "security_analysis: object | error"
  side_effects: "security_test_execution"
  
composition_logic: |
  function SecurityAnalysisMolecule(security_target, security_criteria) {
    // Scan for security vulnerabilities
    vulnerability_scan = parallel_map(
      security_criteria.vulnerability_patterns,
      pattern => SearchFileAtom(security_target, pattern)
    )
    
    // Verify file permissions and access controls
    permission_audit = parallel_map(
      security_target.file_collection,
      file => ValidateFileAtom(file, security_criteria.permission_requirements)
    )
    
    // Check security compliance
    security_compliance = CheckComplianceAtom(
      security_target,
      security_criteria.security_standards
    )
    
    // Execute security tests
    security_tests = parallel_map(
      security_criteria.security_test_scenarios,
      test => TestFunctionalityAtom(security_target, test)
    )
    
    // Analyze security posture
    security_posture = analyze_security_posture(
      vulnerability_scan,
      permission_audit,
      security_compliance,
      security_tests
    )
    
    return {
      vulnerability_assessment: vulnerability_scan,
      permission_audit: permission_audit,
      compliance_status: security_compliance,
      security_test_results: security_tests,
      risk_assessment: calculate_security_risk(security_posture),
      mitigation_plan: generate_security_mitigation_plan(security_posture)
    }
  }
```

## Molecular Composition Patterns

### Sequential Analysis Pattern
```yaml
composition_pattern:
  name: SequentialAnalysisPattern
  description: "Execute analysis molecules in sequence with dependency management"
  molecules: [SystemScanMolecule, QualityAssessmentMolecule, ComplianceAuditMolecule]
  flow: |
    1. system_catalog = SystemScanMolecule(scan_specification)
    2. quality_results = QualityAssessmentMolecule(system_catalog, quality_criteria)
    3. compliance_audit = ComplianceAuditMolecule(system_catalog, compliance_framework)
    
    return {
      system_overview: system_catalog,
      quality_assessment: quality_results,
      compliance_status: compliance_audit,
      integrated_recommendations: synthesize_recommendations([quality_results, compliance_audit])
    }
  
  benefits: ["comprehensive_analysis", "dependency_aware_execution", "integrated_results"]
```

### Parallel Analysis Pattern
```yaml
composition_pattern:
  name: ParallelAnalysisPattern
  description: "Execute independent analysis molecules in parallel for efficiency"
  molecules: [PerformanceAnalysisMolecule, SecurityAnalysisMolecule, DependencyAnalysisMolecule]
  flow: |
    parallel_results = parallel_execute([
      PerformanceAnalysisMolecule(target, performance_criteria),
      SecurityAnalysisMolecule(target, security_criteria),
      DependencyAnalysisMolecule(target, dependency_criteria)
    ])
    
    return {
      performance_analysis: parallel_results[0],
      security_analysis: parallel_results[1],
      dependency_analysis: parallel_results[2],
      cross_analysis_insights: identify_cross_analysis_patterns(parallel_results)
    }
  
  benefits: ["improved_performance", "independent_execution", "comprehensive_coverage"]
```

### Adaptive Analysis Pattern
```yaml
composition_pattern:
  name: AdaptiveAnalysisPattern
  description: "Adapt analysis approach based on initial findings"
  molecules: [SystemScanMolecule, QualityAssessmentMolecule, "conditional_molecules"]
  flow: |
    initial_scan = SystemScanMolecule(initial_scan_specification)
    
    if initial_scan.complexity > threshold.high:
      detailed_analysis = parallel_execute([
        PerformanceAnalysisMolecule(initial_scan, performance_criteria),
        SecurityAnalysisMolecule(initial_scan, security_criteria),
        DependencyAnalysisMolecule(initial_scan, dependency_criteria)
      ])
    else:
      focused_analysis = QualityAssessmentMolecule(initial_scan, quality_criteria)
    
    return adaptive_analysis_results
  
  benefits: ["context_aware_analysis", "resource_optimization", "scalable_approach"]
```

## Molecular Interface Specification

### Standard Molecular Input Format
```yaml
molecular_input_format:
  target_specification:
    target_type: "system|component|document|service"
    target_path: "file_system_path_or_url"
    target_scope: "minimal|comprehensive|custom"
    target_filters: "inclusion_and_exclusion_criteria"
  
  analysis_criteria:
    quality_thresholds: "minimum_acceptable_quality_levels"
    compliance_frameworks: "applicable_standards_and_regulations"
    performance_requirements: "expected_performance_characteristics"
    security_requirements: "security_standards_and_threat_models"
  
  execution_options:
    parallel_execution: "enable_parallel_processing"
    caching_strategy: "result_caching_preferences"
    output_format: "detailed|summary|json|custom"
    monitoring_level: "execution_monitoring_verbosity"
```

### Standard Molecular Output Format
```yaml
molecular_output_format:
  analysis_metadata:
    execution_timestamp: "iso_format_timestamp"
    execution_duration: "milliseconds"
    molecular_composition: "list_of_atomic_operations_executed"
    resource_usage: "computational_and_memory_metrics"
  
  analysis_results:
    primary_findings: "main_analysis_discoveries"
    detailed_metrics: "comprehensive_measurement_data"
    compliance_status: "adherence_to_standards_and_criteria"
    quality_scores: "quantitative_quality_assessments"
  
  recommendations:
    immediate_actions: "urgent_remediation_items"
    improvement_opportunities: "optimization_suggestions"
    long_term_strategies: "strategic_improvement_plans"
    risk_mitigation: "risk_reduction_recommendations"
```

## Performance and Optimization

### Molecular Performance Characteristics
```yaml
performance_optimization:
  parallel_execution:
    strategy: "execute_independent_atoms_concurrently"
    coordination: "minimal_synchronization_overhead"
    resource_management: "efficient_resource_allocation"
  
  caching_strategies:
    atomic_result_caching: "cache_expensive_atomic_operations"
    molecular_result_caching: "cache_complete_molecular_results"
    partial_result_caching: "cache_intermediate_molecular_states"
  
  resource_optimization:
    memory_efficiency: "stream_large_datasets_through_molecules"
    cpu_optimization: "optimize_computational_complexity"
    io_optimization: "batch_file_operations_within_molecules"
```

### Scalability Patterns
```yaml
scalability_approaches:
  horizontal_scaling:
    - molecular_distribution: "distribute_molecules_across_multiple_nodes"
    - atomic_parallelization: "parallelize_atomic_operations_within_molecules"
    - result_aggregation: "efficiently_aggregate_distributed_results"
  
  vertical_scaling:
    - resource_pooling: "share_resources_across_molecular_executions"
    - execution_optimization: "optimize_molecular_execution_paths"
    - memory_management: "efficient_memory_usage_patterns"
  
  adaptive_scaling:
    - load_based_scaling: "scale_based_on_analysis_complexity"
    - dynamic_composition: "adjust_molecular_composition_based_on_requirements"
    - intelligent_caching: "adaptive_caching_based_on_usage_patterns"
```

## Cross-References

### Related Atomic Operations
- [FileAtoms.md](../atoms/FileAtoms.md) - File operation building blocks
- [ValidationAtoms.md](../atoms/ValidationAtoms.md) - Validation building blocks
- [AgentAtoms.md](../atoms/AgentAtoms.md) - Agent operation building blocks
- [WorkflowAtoms.md](../atoms/WorkflowAtoms.md) - Workflow building blocks
- [DocAtoms.md](../atoms/DocAtoms.md) - Documentation building blocks

### Related Molecular Patterns
- [ManagementMolecules.md](ManagementMolecules.md) - Management workflow patterns
- [WorkflowMolecules.md](WorkflowMolecules.md) - Workflow orchestration patterns
- [QualityMolecules.md](QualityMolecules.md) - Quality assurance patterns

### Assembly Integration
- [SystemAnalysisAssembly.md](../assemblies/SystemAnalysisAssembly.md) - Complete system analysis workflows
- [QualityAssuranceAssembly.md](../assemblies/QualityAssuranceAssembly.md) - Comprehensive quality workflows

### Framework Integration
- [Analysis Commands](../../commands-docs/analysis/) - Command implementations using analysis molecules
- [System Architecture](../../docs/architecture/system-architecture-overview.md) - Framework architecture patterns
- [Quality Framework](../../docs/principles/validation.md) - Quality assurance principles

[⬆ Return to top](#analysis-molecules---atomic-analysis-patterns)