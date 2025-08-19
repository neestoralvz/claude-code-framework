---
title: "System Analysis Assembly - Complete Analysis Workflows"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["../molecules/AnalysisMolecules.md", "../atoms/FileAtoms.md", "../atoms/ValidationAtoms.md"]
prerequisites: ["Molecular patterns understanding", "System analysis methodology"]
audience: "System architects, analysis specialists, command implementers"
purpose: "Complete system analysis workflows assembled from molecular patterns and atomic operations"
keywords: ["assembly", "system-analysis", "workflows", "molecular-composition", "complete"]
last_review: "2025-08-19"
architecture_type: "assembly-workflows"
execution_mode: "complete"
validation_level: "comprehensive"
---

[Previous: Molecular Components](../molecules/index.md) | [Return to Assemblies Index](index.md) | [Next: Task Management Assembly](TaskManagementAssembly.md)

# SYSTEM ANALYSIS ASSEMBLY - COMPLETE ANALYSIS WORKFLOWS

## Purpose

⏺ **Assembly Design**: Complete, end-to-end system analysis workflows that combine molecular patterns and atomic operations to deliver comprehensive analysis capabilities with integrated quality assurance.

## Core Analysis Assemblies

### 1. ComprehensiveSystemAuditAssembly
```yaml
assembly_definition:
  name: ComprehensiveSystemAuditAssembly
  responsibility: "Complete system audit with violation detection and remediation planning"
  molecular_composition:
    - SystemScanMolecule: "comprehensive_system_discovery"
    - QualityAssessmentMolecule: "quality_evaluation_and_scoring"
    - ComplianceAuditMolecule: "standards_compliance_verification"
    - SecurityAnalysisMolecule: "security_posture_assessment"
  atomic_foundation:
    - FileAtoms: "file_system_operations"
    - ValidationAtoms: "quality_assurance_operations"
    - DocAtoms: "documentation_management"
  input: "audit_specification: object"
  output: "comprehensive_audit_report: object | error"
  side_effects: "audit_documentation_creation"
  
assembly_workflow: |
  function ComprehensiveSystemAuditAssembly(audit_specification) {
    // Phase 1: System Discovery and Cataloging
    system_catalog = SystemScanMolecule({
      root_path: audit_specification.system_root,
      file_filters: audit_specification.inclusion_patterns,
      validation_rules: audit_specification.file_validation,
      content_patterns: audit_specification.analysis_patterns,
      indexing_criteria: audit_specification.catalog_organization
    })
    
    if (!system_catalog.success) {
      return error("System discovery failed", system_catalog.errors)
    }
    
    // Phase 2: Quality Assessment
    quality_assessment = QualityAssessmentMolecule(
      system_catalog.catalog,
      {
        format: audit_specification.format_requirements,
        compliance: audit_specification.quality_standards,
        integrity: audit_specification.integrity_checks,
        output: audit_specification.quality_criteria,
        weights: audit_specification.quality_weights
      }
    )
    
    // Phase 3: Compliance Verification
    compliance_audit = ComplianceAuditMolecule(
      system_catalog.catalog,
      {
        required_components: audit_specification.mandatory_components,
        compliance_rules: audit_specification.compliance_frameworks,
        format_requirements: audit_specification.format_standards,
        documentation_requirements: audit_specification.doc_standards,
        scoring_criteria: audit_specification.compliance_scoring
      }
    )
    
    // Phase 4: Security Analysis
    security_analysis = SecurityAnalysisMolecule(
      system_catalog.catalog,
      {
        vulnerability_patterns: audit_specification.security_patterns,
        permission_requirements: audit_specification.permission_standards,
        security_standards: audit_specification.security_frameworks,
        security_test_scenarios: audit_specification.security_tests
      }
    )
    
    // Phase 5: Results Integration and Analysis
    integrated_results = integrate_analysis_results([
      system_catalog,
      quality_assessment,
      compliance_audit,
      security_analysis
    ])
    
    // Phase 6: Violation Detection and Categorization
    violation_analysis = detect_and_categorize_violations(
      integrated_results,
      audit_specification.violation_criteria
    )
    
    // Phase 7: Remediation Planning
    remediation_plan = generate_remediation_plan(
      violation_analysis,
      audit_specification.remediation_strategies
    )
    
    // Phase 8: Report Generation and Documentation
    audit_report = generate_comprehensive_audit_report({
      system_overview: system_catalog,
      quality_results: quality_assessment,
      compliance_status: compliance_audit,
      security_posture: security_analysis,
      violations: violation_analysis,
      remediation: remediation_plan,
      executive_summary: generate_executive_summary(integrated_results)
    })
    
    return {
      audit_report: audit_report,
      system_catalog: system_catalog,
      violation_summary: violation_analysis.summary,
      remediation_plan: remediation_plan,
      compliance_score: compliance_audit.overall_compliance_score,
      quality_score: quality_assessment.overall_score,
      security_risk_level: security_analysis.risk_assessment.overall_risk
    }
  }
```

### 2. PerformanceAnalysisAssembly
```yaml
assembly_definition:
  name: PerformanceAnalysisAssembly
  responsibility: "Complete performance analysis with optimization recommendations"
  molecular_composition:
    - SystemScanMolecule: "performance_component_discovery"
    - PerformanceAnalysisMolecule: "detailed_performance_assessment"
    - DependencyAnalysisMolecule: "performance_dependency_mapping"
  atomic_foundation:
    - AgentAtoms: "performance_testing_coordination"
    - ValidationAtoms: "performance_criteria_validation"
    - FileAtoms: "performance_data_management"
  input: "performance_specification: object"
  output: "performance_analysis_report: object | error"
  side_effects: "performance_test_execution"
  
assembly_workflow: |
  function PerformanceAnalysisAssembly(performance_specification) {
    // Phase 1: Performance Component Discovery
    performance_components = SystemScanMolecule({
      root_path: performance_specification.analysis_scope,
      file_filters: performance_specification.performance_component_patterns,
      validation_rules: performance_specification.component_validation,
      content_patterns: performance_specification.performance_indicators,
      indexing_criteria: performance_specification.component_organization
    })
    
    // Phase 2: Dependency Mapping for Performance Impact
    dependency_analysis = DependencyAnalysisMolecule(
      performance_components.catalog.components,
      {
        dependency_patterns: performance_specification.performance_dependency_patterns,
        relationship_rules: performance_specification.performance_relationships,
        rules: performance_specification.performance_dependency_rules
      }
    )
    
    // Phase 3: Performance Testing and Analysis
    performance_results = PerformanceAnalysisMolecule(
      {
        components: performance_components.catalog,
        dependencies: dependency_analysis.dependency_graph
      },
      {
        test_scenarios: performance_specification.performance_tests,
        monitoring_configuration: performance_specification.monitoring_setup,
        result_validation: performance_specification.result_criteria,
        integrity_checks: performance_specification.measurement_validation,
        analysis_patterns: performance_specification.performance_patterns
      }
    )
    
    // Phase 4: Bottleneck Identification
    bottleneck_analysis = identify_performance_bottlenecks(
      performance_results,
      dependency_analysis.dependency_graph,
      performance_specification.bottleneck_criteria
    )
    
    // Phase 5: Optimization Recommendation Generation
    optimization_recommendations = generate_optimization_recommendations(
      performance_results,
      bottleneck_analysis,
      performance_specification.optimization_strategies
    )
    
    // Phase 6: Performance Report Generation
    performance_report = generate_performance_analysis_report({
      component_overview: performance_components,
      dependency_map: dependency_analysis,
      performance_metrics: performance_results,
      bottlenecks: bottleneck_analysis,
      optimizations: optimization_recommendations,
      baseline_comparison: compare_against_baseline(performance_results, performance_specification.baseline)
    })
    
    return {
      performance_report: performance_report,
      performance_metrics: performance_results.performance_metrics,
      bottlenecks: bottleneck_analysis,
      optimization_plan: optimization_recommendations,
      dependency_impact: dependency_analysis.coupling_metrics,
      performance_score: calculate_overall_performance_score(performance_results)
    }
  }
```

### 3. ArchitectureAnalysisAssembly
```yaml
assembly_definition:
  name: ArchitectureAnalysisAssembly
  responsibility: "Complete architecture analysis with design pattern assessment"
  molecular_composition:
    - SystemScanMolecule: "architecture_component_discovery"
    - DependencyAnalysisMolecule: "architecture_relationship_mapping"
    - ComplianceAuditMolecule: "architecture_pattern_compliance"
    - QualityAssessmentMolecule: "architecture_quality_evaluation"
  atomic_foundation:
    - FileAtoms: "architecture_artifact_management"
    - ValidationAtoms: "architecture_pattern_validation"
    - DocAtoms: "architecture_documentation_analysis"
  input: "architecture_specification: object"
  output: "architecture_analysis_report: object | error"
  side_effects: "architecture_documentation_updates"
  
assembly_workflow: |
  function ArchitectureAnalysisAssembly(architecture_specification) {
    // Phase 1: Architecture Component Discovery
    architecture_components = SystemScanMolecule({
      root_path: architecture_specification.architecture_scope,
      file_filters: architecture_specification.component_patterns,
      validation_rules: architecture_specification.component_validation,
      content_patterns: architecture_specification.architecture_patterns,
      indexing_criteria: architecture_specification.component_categorization
    })
    
    // Phase 2: Architecture Relationship Mapping
    architecture_dependencies = DependencyAnalysisMolecule(
      architecture_components.catalog.components,
      {
        dependency_patterns: architecture_specification.relationship_patterns,
        relationship_rules: architecture_specification.architecture_rules,
        rules: architecture_specification.dependency_constraints
      }
    )
    
    // Phase 3: Design Pattern Compliance Assessment
    pattern_compliance = ComplianceAuditMolecule(
      {
        components: architecture_components.catalog,
        relationships: architecture_dependencies.dependency_graph
      },
      {
        required_components: architecture_specification.required_patterns,
        compliance_rules: architecture_specification.design_pattern_rules,
        format_requirements: architecture_specification.architecture_standards,
        documentation_requirements: architecture_specification.documentation_standards,
        scoring_criteria: architecture_specification.pattern_scoring
      }
    )
    
    // Phase 4: Architecture Quality Assessment
    architecture_quality = QualityAssessmentMolecule(
      {
        components: architecture_components.catalog,
        relationships: architecture_dependencies.dependency_graph,
        patterns: pattern_compliance.compliance_status
      },
      {
        format: architecture_specification.quality_format_criteria,
        compliance: architecture_specification.quality_compliance_criteria,
        integrity: architecture_specification.architecture_integrity_checks,
        output: architecture_specification.quality_output_criteria,
        weights: architecture_specification.quality_weights
      }
    )
    
    // Phase 5: Architecture Pattern Analysis
    pattern_analysis = analyze_architecture_patterns(
      architecture_components,
      architecture_dependencies,
      architecture_specification.pattern_detection_rules
    )
    
    // Phase 6: SOLID Principles Assessment
    solid_assessment = assess_solid_principles(
      architecture_components,
      architecture_dependencies,
      architecture_specification.solid_criteria
    )
    
    // Phase 7: Architecture Improvement Recommendations
    improvement_recommendations = generate_architecture_improvements({
      quality_assessment: architecture_quality,
      pattern_compliance: pattern_compliance,
      dependency_analysis: architecture_dependencies,
      solid_assessment: solid_assessment,
      improvement_strategies: architecture_specification.improvement_strategies
    })
    
    // Phase 8: Architecture Report Generation
    architecture_report = generate_architecture_analysis_report({
      component_overview: architecture_components,
      dependency_architecture: architecture_dependencies,
      pattern_analysis: pattern_analysis,
      quality_assessment: architecture_quality,
      solid_compliance: solid_assessment,
      improvements: improvement_recommendations,
      architecture_summary: generate_architecture_summary(architecture_components, architecture_dependencies)
    })
    
    return {
      architecture_report: architecture_report,
      component_map: architecture_components.catalog,
      dependency_graph: architecture_dependencies.dependency_graph,
      pattern_compliance: pattern_compliance.overall_compliance_score,
      quality_score: architecture_quality.overall_score,
      solid_score: solid_assessment.overall_solid_score,
      improvement_plan: improvement_recommendations
    }
  }
```

## Assembly Composition Patterns

### Layered Analysis Pattern
```yaml
composition_pattern:
  name: LayeredAnalysisPattern
  description: "Execute assemblies in layers with increasing depth and specificity"
  assemblies: [ComprehensiveSystemAuditAssembly, PerformanceAnalysisAssembly, ArchitectureAnalysisAssembly]
  flow: |
    # Layer 1: Comprehensive Overview
    system_audit = ComprehensiveSystemAuditAssembly(base_audit_specification)
    
    # Layer 2: Performance Deep Dive (if performance issues detected)
    if system_audit.quality_score < performance_threshold:
      performance_analysis = PerformanceAnalysisAssembly(
        derive_performance_specification(system_audit)
      )
    
    # Layer 3: Architecture Analysis (if structural issues detected)
    if system_audit.compliance_score < architecture_threshold:
      architecture_analysis = ArchitectureAnalysisAssembly(
        derive_architecture_specification(system_audit)
      )
    
    return integrate_layered_analysis_results([
      system_audit,
      performance_analysis,
      architecture_analysis
    ])
  
  benefits: ["progressive_depth", "adaptive_analysis_scope", "integrated_insights"]
```

### Parallel Analysis Pattern
```yaml
composition_pattern:
  name: ParallelAnalysisPattern
  description: "Execute multiple assemblies in parallel for comprehensive coverage"
  assemblies: [ComprehensiveSystemAuditAssembly, PerformanceAnalysisAssembly, ArchitectureAnalysisAssembly]
  flow: |
    parallel_results = parallel_execute([
      ComprehensiveSystemAuditAssembly(audit_specification),
      PerformanceAnalysisAssembly(performance_specification),
      ArchitectureAnalysisAssembly(architecture_specification)
    ])
    
    cross_analysis_insights = identify_cross_analysis_patterns(parallel_results)
    integrated_recommendations = synthesize_recommendations(parallel_results)
    
    return {
      individual_analyses: parallel_results,
      cross_analysis_insights: cross_analysis_insights,
      integrated_recommendations: integrated_recommendations,
      overall_system_health: calculate_overall_health_score(parallel_results)
    }
  
  benefits: ["comprehensive_coverage", "parallel_efficiency", "cross_domain_insights"]
```

### Focused Analysis Pattern
```yaml
composition_pattern:
  name: FocusedAnalysisPattern
  description: "Select and execute specific assemblies based on analysis requirements"
  assemblies: ["conditional_assembly_selection"]
  flow: |
    analysis_requirements = assess_analysis_requirements(input_specification)
    
    selected_assemblies = select_optimal_assemblies(
      analysis_requirements,
      available_assemblies,
      resource_constraints
    )
    
    focused_results = execute_selected_assemblies(
      selected_assemblies,
      analysis_requirements
    )
    
    return {
      selected_analyses: selected_assemblies,
      focused_results: focused_results,
      analysis_efficiency: calculate_analysis_efficiency(focused_results),
      coverage_assessment: assess_analysis_coverage(focused_results, analysis_requirements)
    }
  
  benefits: ["resource_optimization", "targeted_analysis", "efficient_execution"]
```

## Assembly Performance Characteristics

### Execution Metrics
```yaml
performance_characteristics:
  ComprehensiveSystemAuditAssembly:
    typical_execution_time: "5-30 minutes depending on system size"
    memory_usage: "moderate - scales with system complexity"
    io_operations: "intensive - scans entire system"
    parallelization: "high - most operations can run in parallel"
  
  PerformanceAnalysisAssembly:
    typical_execution_time: "10-60 minutes depending on test scenarios"
    memory_usage: "high - performance data collection and analysis"
    io_operations: "intensive - performance testing and monitoring"
    parallelization: "moderate - some sequential dependencies"
  
  ArchitectureAnalysisAssembly:
    typical_execution_time: "3-20 minutes depending on architecture complexity"
    memory_usage: "moderate - architecture model construction"
    io_operations: "moderate - architecture artifact analysis"
    parallelization: "high - most analysis can run in parallel"
```

### Scalability Strategies
```yaml
scalability_approaches:
  horizontal_scaling:
    - assembly_distribution: "distribute assemblies across multiple execution nodes"
    - molecular_parallelization: "parallelize molecular operations within assemblies"
    - result_aggregation: "efficiently aggregate distributed assembly results"
  
  vertical_scaling:
    - resource_optimization: "optimize resource usage within individual assemblies"
    - caching_strategies: "cache expensive assembly operations and results"
    - incremental_execution: "support incremental assembly execution for large systems"
  
  adaptive_scaling:
    - dynamic_assembly_selection: "select assemblies based on system characteristics"
    - load_balancing: "balance assembly execution load across available resources"
    - intelligent_caching: "cache assembly results based on change detection"
```

## Cross-References

### Molecular Components
- [AnalysisMolecules.md](../molecules/AnalysisMolecules.md) - Analysis patterns used in assemblies
- [QualityMolecules.md](../molecules/QualityMolecules.md) - Quality assurance patterns

### Atomic Foundation
- [FileAtoms.md](../atoms/FileAtoms.md) - File operation building blocks
- [ValidationAtoms.md](../atoms/ValidationAtoms.md) - Validation building blocks
- [AgentAtoms.md](../atoms/AgentAtoms.md) - Agent operation building blocks

### Command Integration
- [system-audit.md](../../commands-docs/analysis/system-audit.md) - System audit command using assemblies
- [analyze-dependencies.md](../../commands-docs/analysis/analyze-dependencies.md) - Dependency analysis command

### Framework Integration
- [Analysis Framework](../../docs/architecture/analysis-framework.md) - Analysis architecture patterns
- [Quality Framework](../../docs/principles/validation.md) - Quality assurance principles
- [System Architecture](../../docs/architecture/system-architecture-overview.md) - Framework architecture

[⬆ Return to top](#system-analysis-assembly---complete-analysis-workflows)