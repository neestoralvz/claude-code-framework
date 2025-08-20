
---

**IF reading individually** → READ [STANDARDS.md](../STANDARDS.md#technical-standards) for context, THEN navigate to this specific standard


# Complexity Assessment Standards

**Context**: Systematic evaluation criteria for problem complexity to ensure appropriate methodology selection

**Purpose**: Provide consistent, objective criteria for assessing problem complexity and selecting appropriate response strategies

---

## Assessment Framework

### Mandatory Assessment Dimensions

**All Problem Assessments Must Evaluate**:
1. **Scope Impact**: Number of domains, systems, or areas affected
2. **Stakeholder Complexity**: Number and diversity of people involved
3. **Uncertainty Level**: Degree of unknowns in requirements or solutions
4. **Risk Level**: Consequences of failure or suboptimal solutions
5. **Timeline Pressure**: Urgency and scheduling constraints

### Scoring Criteria

**Dimension 1: Scope Impact**
```yaml
scope_assessment:
  score_1_3_single_domain:
    criteria:
      - affects_one_functional_area
      - minimal_cross_system_dependencies
      - contained_within_single_team_responsibility
    examples: ["bug fix in single component", "update documentation section"]
    
  score_4_6_multi_domain:
    criteria:
      - affects_multiple_functional_areas
      - cross_system_dependencies_present
      - coordination_between_teams_required
    examples: ["feature requiring frontend and backend changes", "process improvement affecting multiple departments"]
    
  score_7_10_systems_wide:
    criteria:
      - affects_entire_organization_or_major_systems
      - extensive_interdependencies
      - architectural_or_strategic_implications
    examples: ["system architecture overhaul", "organizational structure changes"]
```

**Dimension 2: Stakeholder Complexity**
```yaml
stakeholder_assessment:
  score_1_3_limited:
    criteria:
      - 1_3_direct_stakeholders
      - homogeneous_stakeholder_group
      - aligned_interests_and_objectives
    examples: ["single team internal improvement", "individual user request"]
    
  score_4_6_multiple_groups:
    criteria:
      - 4_10_stakeholders_from_different_groups
      - some_conflicting_interests
      - coordination_required_between_groups
    examples: ["cross-departmental project", "customer-facing feature change"]
    
  score_7_10_complex_network:
    criteria:
      - 10_plus_stakeholders_across_organization
      - complex_stakeholder_relationships
      - significant_competing_interests
    examples: ["enterprise software rollout", "major policy changes"]
```

**Dimension 3: Uncertainty Level**
```yaml
uncertainty_assessment:
  score_1_3_well_understood:
    criteria:
      - clear_requirements_and_constraints
      - established_solution_patterns_exist
      - minimal_unknowns_in_implementation
    examples: ["implementing proven solution", "following established procedures"]
    
  score_4_6_moderate_unknowns:
    criteria:
      - some_requirement_ambiguity
      - solution_approach_needs_investigation
      - moderate_implementation_uncertainties
    examples: ["adapting solution to new context", "requirements need clarification"]
    
  score_7_10_high_uncertainty:
    criteria:
      - significant_requirement_unknowns
      - novel_solution_development_required
      - substantial_implementation_risks
    examples: ["research and development projects", "entering new problem domains"]
```

**Dimension 4: Risk Level**
```yaml
risk_assessment:
  score_1_3_low_impact:
    criteria:
      - failure_causes_minimal_disruption
      - easy_rollback_or_recovery_possible
      - limited_financial_or_operational_impact
    examples: ["internal tool improvements", "non-critical feature additions"]
    
  score_4_6_moderate_risk:
    criteria:
      - failure_causes_noticeable_impact
      - recovery_requires_planned_effort
      - moderate_financial_or_operational_consequences
    examples: ["customer-facing features", "process efficiency improvements"]
    
  score_7_10_high_risk:
    criteria:
      - failure_causes_severe_disruption
      - difficult_or_expensive_recovery
      - major_financial_operational_or_reputational_risk
    examples: ["payment system changes", "security infrastructure updates"]
```

**Dimension 5: Timeline Pressure**
```yaml
timeline_assessment:
  score_1_3_flexible:
    criteria:
      - no_fixed_deadlines
      - quality_prioritized_over_speed
      - time_available_for_thorough_approach
    examples: ["improvement projects", "research initiatives"]
    
  score_4_6_time_sensitive:
    criteria:
      - defined_deadlines_with_some_flexibility
      - balance_between_quality_and_timeline
      - reasonable_time_for_proper_execution
    examples: ["quarterly feature releases", "planned maintenance windows"]
    
  score_7_10_critical_timeline:
    criteria:
      - hard_non_negotiable_deadlines
      - time_constraints_affect_approach_options
      - speed_may_require_quality_trade_offs
    examples: ["emergency fixes", "regulatory compliance deadlines"]
```

## Assessment Process

### Step 1: Initial Scoring (5 minutes maximum)

**Assessment Protocol**:
1. **Rapid Evaluation**: Score each dimension independently
2. **Evidence Gathering**: Note specific factors supporting each score
3. **Dimension Totaling**: Sum scores across all five dimensions
4. **Complexity Classification**: Apply total score to complexity categories

**Scoring Documentation Format**:
```yaml
complexity_assessment:
  problem_statement: "[Clear description of the problem]"
  assessment_date: "[Date of assessment]"
  assessor: "[Person conducting assessment]"
  
  dimension_scores:
    scope_impact: [1-10]
    stakeholder_complexity: [1-10]
    uncertainty_level: [1-10]
    risk_level: [1-10]
    timeline_pressure: [1-10]
  
  evidence_summary:
    scope_impact: "[Specific factors supporting score]"
    stakeholder_complexity: "[Stakeholder details and complexities]"
    uncertainty_level: "[Known unknowns and ambiguities]"
    risk_level: "[Potential consequences and impacts]"
    timeline_pressure: "[Deadline and timing constraints]"
  
  total_score: [5-50]
  complexity_classification: "[Simple/Moderate/High]"
  methodology_recommendation: "[Suggested approach based on complexity]"
```

### Step 2: Classification Application

**Complexity Categories**:
```yaml
complexity_classification:
  simple_complexity:
    score_range: 5-15
    characteristics:
      - single_domain_impact
      - limited_stakeholder_involvement
      - well_understood_requirements
      - low_risk_consequences
      - flexible_timeline
    recommended_approach: "Direct implementation with basic analysis"
    
  moderate_complexity:
    score_range: 16-35
    characteristics:
      - multi_domain_interactions
      - multiple_stakeholder_groups
      - some_requirement_unknowns
      - moderate_risk_level
      - balanced_timeline_pressure
    recommended_approach: "Structured analysis with coordinated execution"
    
  high_complexity:
    score_range: 36-50
    characteristics:
      - systems_wide_impact
      - complex_stakeholder_networks
      - significant_uncertainties
      - high_risk_consequences
      - critical_timeline_constraints
    recommended_approach: "Comprehensive strategic analysis and coordination"
```

### Step 3: Methodology Selection

**Methodology Mapping**:
```yaml
methodology_selection:
  simple_complexity_methods:
    - five_whys_analysis
    - basic_evidence_validation
    - direct_implementation
    - single_agent_execution
    - minimal_documentation
    
  moderate_complexity_methods:
    - fishbone_diagram_analysis
    - design_thinking_approach
    - multi_stakeholder_coordination
    - evidence_based_validation
    - comprehensive_documentation
    
  high_complexity_methods:
    - fault_tree_analysis
    - mdmp_adaptation
    - parallel_agent_coordination
    - comprehensive_evidence_framework
    - strategic_planning_integration
```

## Quality Assurance Standards

### Assessment Validation Requirements

**Mandatory Validation Checks**:
- [ ] All five dimensions assessed and scored
- [ ] Evidence provided for each dimension score
- [ ] Total score calculated correctly
- [ ] Complexity classification matches score range
- [ ] Methodology recommendation aligns with complexity level

**Assessment Review Criteria**:
- **Consistency**: Scores align with provided evidence
- **Completeness**: All relevant factors considered
- **Objectivity**: Assessment free from bias or assumptions
- **Clarity**: Evidence clearly supports assigned scores
- **Accuracy**: Classification and methodology selection appropriate

### Reassessment Triggers

**Mandatory Reassessment Conditions**:
- New stakeholders or requirements emerge
- Risk level changes during execution
- Timeline pressure increases or decreases significantly
- Solution approach proves inadequate for complexity
- Scope expands or contracts substantially

**Reassessment Process**:
1. **Trigger Recognition**: Identify need for complexity reassessment
2. **Updated Assessment**: Re-score affected dimensions with new information
3. **Classification Review**: Determine if complexity category changes
4. **Methodology Adjustment**: Update approach if complexity category changes
5. **Stakeholder Communication**: Inform relevant parties of assessment changes

## Integration Requirements

### Framework Integration

**Process Integration**:
- Complexity assessment required before methodology selection
- Assessment documentation maintained throughout project lifecycle
- Reassessment checkpoints built into project milestones
- Assessment accuracy validated through project outcomes

**Tool Integration**:
- **Progressive Thinking**: Structure complexity assessment systematically
- **TodoWrite**: Track assessment completion and reassessment scheduling
- **Evidence-Based Interaction**: Ensure assessment based on validated information
- **Strategic Orchestration**: Use complexity assessment for agent deployment decisions

### Quality Gate Integration

**Pre-Project Quality Gate**:
- Complexity assessment completed and documented
- Methodology selection matches complexity classification
- Resource allocation appropriate for assessed complexity
- Timeline realistic for complexity level

**Mid-Project Quality Gate**:
- Complexity reassessment completed if triggers occurred
- Methodology adjustments implemented if needed
- Resource allocation updated for any complexity changes
- Timeline adjustments made for complexity evolution

## Success Metrics

### Assessment Accuracy
- **Classification Accuracy**: >90% of complexity assessments prove accurate
- **Methodology Effectiveness**: >85% success rate with complexity-matched methodologies
- **Reassessment Timeliness**: 100% of reassessment triggers result in updated assessment
- **Stakeholder Alignment**: >90% stakeholder agreement with complexity assessment

### Process Efficiency
- **Assessment Speed**: Complexity assessment completed within 5-minute standard
- **Documentation Quality**: 100% compliance with documentation requirements
- **Integration Success**: Assessment seamlessly integrated into decision processes
- **Learning Application**: Continuous improvement in assessment accuracy

### Resource Optimization
- **Resource Matching**: Resources allocated appropriate to assessed complexity
- **Effort Efficiency**: No over-engineering of simple problems
- **Quality Achievement**: Adequate sophistication for complex challenges
- **Timeline Alignment**: Realistic timelines based on complexity assessment

## Common Assessment Challenges

### Underestimation Risks
- **Indicators**: Stakeholder surprise, scope creep, resource shortages
- **Prevention**: Conservative assessment when uncertainty exists
- **Mitigation**: Regular reassessment and escalation protocols

### Overestimation Consequences
- **Indicators**: Resource waste, stakeholder frustration, delayed delivery
- **Prevention**: Objective evidence-based assessment
- **Mitigation**: De-escalation opportunities and resource reallocation

### Assessment Bias
- **Sources**: Personal experience, organizational culture, time pressure
- **Prevention**: Structured criteria and multiple perspective integration
- **Mitigation**: Peer review and assessment validation processes

### Dynamic Complexity
- **Challenge**: Complexity changes during project execution
- **Solution**: Reassessment triggers and adjustment protocols
- **Prevention**: Built-in reassessment checkpoints and stakeholder communication

This standard ensures consistent, objective complexity assessment that enables appropriate methodology selection and resource allocation while maintaining flexibility for evolving project requirements.

---

