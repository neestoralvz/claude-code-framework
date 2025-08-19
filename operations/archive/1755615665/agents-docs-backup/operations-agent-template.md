# OPERATIONS AGENT TEMPLATE

**Component Type**: Operations Category Agent Template  
**Version**: 1.0.0  
**Purpose**: Specialized template for operations-category agents  
**Extends**: agent-base-structure.md  
**Category**: operations-*  

## Operations-Specific Components

### Infrastructure Management Component
```markdown
### Infrastructure Management
- **{{ deployment_strategies }}**: {{ deployment_implementation }}
- **{{ configuration_management }}**: {{ configuration_approach }}
- **{{ environment_provisioning }}**: {{ provisioning_methodology }}
- **{{ resource_allocation_optimization }}**: {{ resource_management }}
- **{{ infrastructure_as_code_patterns }}**: {{ iac_implementation }}
```

#### Infrastructure Variables
- **deployment_strategies**: Deployment approaches (e.g., "blue-green", "canary", "rolling")
- **deployment_implementation**: How deployments are implemented
- **configuration_management**: Configuration management approach
- **configuration_approach**: Methodology for configuration handling
- **environment_provisioning**: How environments are provisioned
- **provisioning_methodology**: Systematic provisioning approach
- **resource_allocation_optimization**: Resource optimization strategies
- **resource_management**: How resources are managed
- **infrastructure_as_code_patterns**: IaC patterns and practices
- **iac_implementation**: How Infrastructure as Code is implemented

### Monitoring Integration Component
```markdown
### Monitoring Integration
- **{{ monitoring_protocols }}**: {{ monitoring_implementation }}
- **{{ alerting_strategies }}**: {{ alert_management }}
- **{{ performance_metrics_collection }}**: {{ metrics_approach }}
- **{{ log_management_frameworks }}**: {{ logging_strategy }}
- **{{ observability_implementation }}**: {{ observability_approach }}
```

#### Monitoring Variables
- **monitoring_protocols**: Monitoring methodologies and protocols
- **monitoring_implementation**: How monitoring is implemented
- **alerting_strategies**: Alerting and notification strategies
- **alert_management**: How alerts are managed and responded to
- **performance_metrics_collection**: Performance metrics collection approach
- **metrics_approach**: Methodology for metrics handling
- **log_management_frameworks**: Log management and analysis frameworks
- **logging_strategy**: Strategy for log collection and analysis
- **observability_implementation**: Observability implementation approach
- **observability_approach**: Systematic observability methodology

### Security Compliance Component
```markdown
### Security Compliance
- **{{ security_frameworks }}**: {{ security_implementation }}
- **{{ compliance_protocols }}**: {{ compliance_approach }}
- **{{ access_control_management }}**: {{ access_methodology }}
- **{{ vulnerability_assessment_strategies }}**: {{ vulnerability_approach }}
- **{{ incident_response_protocols }}**: {{ incident_management }}
```

#### Security Variables
- **security_frameworks**: Security frameworks and standards used
- **security_implementation**: How security is implemented
- **compliance_protocols**: Compliance requirements and protocols
- **compliance_approach**: Approach to compliance management
- **access_control_management**: Access control strategies
- **access_methodology**: Methodology for access management
- **vulnerability_assessment_strategies**: Vulnerability assessment approach
- **vulnerability_approach**: How vulnerabilities are handled
- **incident_response_protocols**: Incident response procedures
- **incident_management**: How incidents are managed

### Scalability Design Component
```markdown
### Scalability Design
- **{{ scalability_patterns }}**: {{ scalability_implementation }}
- **{{ load_balancing_strategies }}**: {{ load_balancing_approach }}
- **{{ auto_scaling_methodologies }}**: {{ auto_scaling_implementation }}
- **{{ capacity_planning_frameworks }}**: {{ capacity_approach }}
- **{{ distributed_systems_optimization }}**: {{ distributed_optimization }}
```

#### Scalability Variables
- **scalability_patterns**: Scalability design patterns used
- **scalability_implementation**: How scalability is implemented
- **load_balancing_strategies**: Load balancing approaches
- **load_balancing_approach**: Methodology for load balancing
- **auto_scaling_methodologies**: Auto-scaling strategies
- **auto_scaling_implementation**: How auto-scaling is implemented
- **capacity_planning_frameworks**: Capacity planning approach
- **capacity_approach**: Methodology for capacity management
- **distributed_systems_optimization**: Distributed system optimization
- **distributed_optimization**: How distributed systems are optimized

## Operations Agent Specializations

### Cloud Operations Specialization
```markdown
### Cloud Operations Expertise
- **{{ cloud_architecture_patterns }}**: {{ cloud_implementation }}
- **{{ multi_cloud_strategies }}**: {{ multi_cloud_approach }}
- **{{ cloud_cost_optimization }}**: {{ cost_management }}
- **{{ cloud_security_protocols }}**: {{ cloud_security }}
- **{{ disaster_recovery_planning }}**: {{ disaster_recovery }}
```

### Container Orchestration Specialization
```markdown
### Container Orchestration Expertise
- **{{ kubernetes_management_patterns }}**: {{ k8s_implementation }}
- **{{ docker_optimization_strategies }}**: {{ docker_approach }}
- **{{ service_mesh_integration }}**: {{ service_mesh_implementation }}
- **{{ container_security_protocols }}**: {{ container_security }}
- **{{ orchestration_automation }}**: {{ orchestration_approach }}
```

### Infrastructure Automation Specialization
```markdown
### Infrastructure Automation Expertise
- **{{ automation_pipeline_patterns }}**: {{ automation_implementation }}
- **{{ ci_cd_integration_strategies }}**: {{ cicd_approach }}
- **{{ infrastructure_testing_methodologies }}**: {{ infra_testing }}
- **{{ configuration_drift_management }}**: {{ drift_management }}
- **{{ automated_recovery_protocols }}**: {{ recovery_automation }}
```

## Operations-Specific Validation Protocols

### Infrastructure Validation
```markdown
#### Infrastructure Validation
- [ ] **Deployment Success Verification**: {{ deployment_validation }}
- [ ] **Configuration Consistency**: {{ configuration_validation }}
- [ ] **Resource Utilization Optimization**: {{ resource_validation }}
- [ ] **Security Posture Assessment**: {{ security_validation }}
```

### Performance Validation
```markdown
#### Performance Validation
- [ ] **Load Testing Results**: {{ load_test_validation }}
- [ ] **Scalability Verification**: {{ scalability_validation }}
- [ ] **Monitoring System Functionality**: {{ monitoring_validation }}
- [ ] **Alert System Responsiveness**: {{ alert_validation }}
```

### Compliance Validation
```markdown
#### Compliance Validation
- [ ] **Security Framework Adherence**: {{ security_framework_validation }}
- [ ] **Regulatory Compliance**: {{ regulatory_validation }}
- [ ] **Access Control Verification**: {{ access_control_validation }}
- [ ] **Audit Trail Completeness**: {{ audit_validation }}
```

## Operations Agent Decision Principles

```markdown
## Operations Decision Principles

- Prioritize {{ operations_principle_1 }} over {{ alternative_approach_1 }}
- Balance {{ operations_principle_2 }} with {{ cost_optimization_1 }}
- Optimize for {{ operations_principle_3 }} while maintaining {{ reliability_standard_1 }}
- Design for {{ operations_principle_4 }} without compromising {{ security_standard_1 }}
- Implement {{ operations_principle_5 }} through {{ automation_approach_1 }}
- Maintain {{ operations_principle_6 }} across {{ scalability_requirement_1 }}
```

### Operations Principle Variables
- **operations_principle_N**: Core operations principles (e.g., "system reliability", "automated recovery")
- **alternative_approach_N**: Alternative approaches that are deprioritized
- **cost_optimization_N**: Cost optimization considerations
- **reliability_standard_N**: Reliability standards that must be maintained
- **security_standard_N**: Security standards
- **automation_approach_N**: Automation methodologies
- **scalability_requirement_N**: Scalability requirements

## Operations-Specific Integration Points

```markdown
## Operations Integration Points

- **{{ integration_with_development }}**: {{ dev_coordination }}
- **{{ integration_with_security }}**: {{ security_coordination }}
- **{{ integration_with_monitoring }}**: {{ monitoring_coordination }}
- **{{ integration_with_business }}**: {{ business_coordination }}
```

### Operations Integration Variables
- **integration_with_N**: Integration point with other disciplines
- **N_coordination**: How coordination with that discipline works

## Edge Case Handling for Operations

```markdown
## Operations Edge Case Handling

- **{{ disaster_scenario_1 }}**: {{ disaster_handling_1 }}
- **{{ performance_degradation_scenario }}**: {{ performance_handling }}
- **{{ security_breach_scenario }}**: {{ security_handling }}
- **{{ capacity_overflow_scenario }}**: {{ capacity_handling }}
- **{{ service_dependency_failure }}**: {{ dependency_handling }}
```

### Operations Edge Case Variables
- **disaster_scenario_N**: Specific disaster scenarios
- **disaster_handling_N**: How disasters are handled
- **performance_degradation_scenario**: Performance issues
- **performance_handling**: How performance issues are handled
- **security_breach_scenario**: Security incident scenarios
- **security_handling**: How security incidents are handled
- **capacity_overflow_scenario**: Capacity overflow situations
- **capacity_handling**: How capacity issues are handled
- **service_dependency_failure**: Service dependency failures
- **dependency_handling**: How dependency failures are managed

## Usage Examples

### Cloud Operations Agent Example
```yaml
expertise_domain: "Cloud Operations"
core_capabilities: "multi-cloud architecture, cost optimization, and automated scaling"
deployment_strategies: "Blue-green deployments with automated rollback capabilities"
monitoring_protocols: "Comprehensive observability with real-time alerting"
security_frameworks: "Zero-trust architecture with continuous compliance monitoring"
scalability_patterns: "Auto-scaling with predictive capacity planning"
```

### Container Orchestration Agent Example
```yaml
expertise_domain: "Container Orchestration"
core_capabilities: "Kubernetes management, Docker optimization, and service mesh integration"
deployment_strategies: "GitOps-based continuous deployment with Kubernetes"
monitoring_protocols: "Container-native monitoring with distributed tracing"
security_frameworks: "Pod security policies with network segmentation"
scalability_patterns: "Horizontal pod autoscaling with cluster auto-scaling"
```

### Infrastructure Automation Agent Example
```yaml
expertise_domain: "Infrastructure Automation"
core_capabilities: "Infrastructure as Code, CI/CD integration, and automated testing"
deployment_strategies: "Terraform-based infrastructure provisioning with validation"
monitoring_protocols: "Infrastructure drift detection with automated remediation"
security_frameworks: "Security-as-code with automated compliance checking"
scalability_patterns: "Elastic infrastructure with demand-based provisioning"
```

This template provides specialized components for operations agents while maintaining consistency with the base agent structure and development patterns.