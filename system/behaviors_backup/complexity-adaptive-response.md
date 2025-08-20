
---

**IF reading individually** → READ [BEHAVIORS.md](../BEHAVIORS.md#communication-style) for context, THEN navigate to this specific behavior


# Complexity-Adaptive Response

**Context**: Scale approach sophistication to match problem complexity using tiered methodologies

**Purpose**: Optimize resource allocation and solution effectiveness by matching response complexity to problem complexity

---

## Core Principle

Use systematic complexity assessment to select appropriate methodologies, avoiding over-engineering simple problems while ensuring adequate sophistication for complex challenges.

## Complexity Assessment Framework

### Problem Complexity Indicators

**Simple Complexity Indicators**:
- Single domain impact
- Limited stakeholder involvement (1-3 people)
- Well-understood requirements
- Established solution patterns exist
- Low interdependency with other systems
- Minimal risk if solution fails

**Moderate Complexity Indicators**:
- Multi-domain interactions
- Multiple stakeholder groups (4-10 people)
- Some unknown requirements
- Coordination requirements between teams
- Moderate interdependency
- Medium risk and recovery requirements

**High Complexity Indicators**:
- Systems-level impact across domains
- Complex stakeholder networks (10+ people)
- Significant unknowns and uncertainties
- Strategic implications for organization
- High interdependency and cascading effects
- High risk and difficult recovery

### Complexity Assessment Process

**Initial Triage (5 minutes)**:
1. **Scope Assessment**: How many domains, systems, or areas affected?
2. **Stakeholder Count**: How many people directly involved or impacted?
3. **Uncertainty Level**: How much is unknown about requirements or solution?
4. **Risk Level**: What happens if the solution fails or is delayed?
5. **Timeline Pressure**: How urgent is the need for resolution?

**Complexity Scoring**:
```yaml
complexity_assessment:
  scope: [1-3: single domain, 4-6: multi-domain, 7-10: systems-wide]
  stakeholders: [1-3: few, 4-6: multiple groups, 7-10: complex network]
  uncertainty: [1-3: well-understood, 4-6: some unknowns, 7-10: high uncertainty]
  risk: [1-3: low impact, 4-6: moderate risk, 7-10: high risk]
  urgency: [1-3: flexible, 4-6: time-sensitive, 7-10: critical timeline]
  
total_score: [5-15: Simple, 16-35: Moderate, 36-50: High Complexity]
```

## Adaptive Response Strategies

### Simple Complexity Response (Score 5-15)

**Methodology Selection**:
- 5 Whys for root cause analysis
- Basic evidence validation
- Direct implementation approach
- Single-agent execution

**Resource Allocation**:
- Minimal upfront analysis (15-30 minutes)
- Direct execution focus
- Basic documentation
- Simple validation and testing

**Quality Standards**:
- Essential quality checks only
- Basic stakeholder confirmation
- Functional validation
- Simple success metrics

**Example Approach**:
```yaml
simple_response:
  analysis_time: 15-30 minutes
  methodology: five_whys_analysis
  execution: direct_implementation
  validation: basic_functional_testing
  documentation: essential_only
  success_criteria: functional_and_stakeholder_approved
```

### Moderate Complexity Response (Score 16-35)

**Methodology Selection**:
- Fishbone diagram for multi-factor analysis
- Design thinking approach for user-centric solutions
- Multi-agent coordination
- Stakeholder integration process

**Resource Allocation**:
- Structured analysis phase (1-2 hours)
- Coordinated implementation
- Comprehensive documentation
- Multi-level validation

**Quality Standards**:
- Evidence-based validation
- Stakeholder feedback integration
- Performance and quality testing
- Success metrics with benchmarks

**Example Approach**:
```yaml
moderate_response:
  analysis_time: 1-2 hours
  methodology: fishbone_analysis_plus_design_thinking
  execution: coordinated_multi_agent
  validation: multi_level_testing_and_stakeholder_review
  documentation: comprehensive_with_examples
  success_criteria: measurable_outcomes_with_stakeholder_satisfaction
```

### High Complexity Response (Score 36-50)

**Methodology Selection**:
- Fault tree analysis for systems thinking
- Military Decision-Making Process (MDMP) adaptation
- Full parallel agent coordination
- Comprehensive evidence framework
- Sustainability impact assessment

**Resource Allocation**:
- Extensive analysis and planning (2-4 hours)
- Strategic parallel execution
- Complete documentation and knowledge base
- Comprehensive validation and testing

**Quality Standards**:
- Multi-source evidence validation
- Comprehensive stakeholder integration
- Systems-level testing and validation
- Long-term success and sustainability metrics

**Example Approach**:
```yaml
high_complexity_response:
  analysis_time: 2-4 hours
  methodology: fault_tree_analysis_plus_mdmp_adaptation
  execution: strategic_parallel_agent_coordination
  validation: comprehensive_systems_testing_and_validation
  documentation: complete_knowledge_base_with_maintenance_guide
  success_criteria: strategic_objectives_with_sustainability_measures
```

## Response Escalation Protocols

### Complexity Reassessment Triggers

**Escalation Indicators**:
- Initial approach proves insufficient
- New stakeholders or requirements emerge
- Risk level increases during execution
- Timeline pressure intensifies
- Integration challenges exceed expectations

**Reassessment Process**:
1. **Pause and Evaluate**: Stop current approach and assess new complexity factors
2. **Rescope Analysis**: Update complexity assessment with new information
3. **Upgrade Methodology**: Select more sophisticated approach if warranted
4. **Resource Reallocation**: Adjust time, people, and tool usage accordingly
5. **Stakeholder Communication**: Inform stakeholders of approach changes and rationale

### De-escalation Opportunities

**Simplification Indicators**:
- Problem scope narrows during analysis
- Stakeholder alignment achieved quickly
- Solution patterns become clear
- Risk level decreases with better understanding

**De-escalation Process**:
1. **Opportunity Recognition**: Identify when simpler approach sufficient
2. **Resource Optimization**: Reallocate excess resources to other priorities
3. **Methodology Adjustment**: Simplify approach while maintaining quality
4. **Timeline Acceleration**: Take advantage of reduced complexity for faster delivery

## Implementation Guidelines

### Method Selection Decision Tree

```
Problem Identified
    ↓
Complexity Assessment (5 min)
    ↓
Score: 5-15        Score: 16-35        Score: 36-50
    ↓                   ↓                   ↓
Simple Response    Moderate Response    High Complexity
    ↓                   ↓                   ↓
5 Whys            Fishbone +           Fault Tree +
Direct Exec       Design Thinking      MDMP Adaptation
    ↓                   ↓                   ↓
Basic Validation  Multi-level Valid    Comprehensive Valid
    ↓                   ↓                   ↓
Delivery          Delivery             Delivery
```

### Quality Assurance by Complexity

**Simple Complexity QA**:
- Functional testing only
- Single stakeholder approval
- Basic documentation
- Simple success confirmation

**Moderate Complexity QA**:
- Functional and integration testing
- Multi-stakeholder validation
- User documentation and guides
- Performance and satisfaction metrics

**High Complexity QA**:
- Comprehensive systems testing
- Full stakeholder ecosystem validation
- Complete documentation and knowledge base
- Strategic success and sustainability metrics

## Success Patterns

### Efficiency Gains
- **Appropriate Resourcing**: No over-engineering of simple problems
- **Adequate Sophistication**: Complex problems receive appropriate analysis depth
- **Resource Optimization**: Team effort matches problem requirements
- **Timeline Efficiency**: Faster delivery through appropriate methodology selection

### Quality Improvements
- **Solution Appropriateness**: Solutions match problem complexity and context
- **Stakeholder Satisfaction**: Response sophistication meets stakeholder expectations
- **Risk Management**: Risk mitigation appropriate to actual risk level
- **Sustainability**: Long-term success through appropriate depth of solution

### Learning and Adaptation
- **Pattern Recognition**: Improved ability to assess complexity quickly
- **Methodology Mastery**: Better understanding of when to use different approaches
- **Resource Calibration**: More accurate estimation of effort required
- **Stakeholder Alignment**: Better communication about approach rationale

## Integration with Framework

### Tool Integration
- **Progressive Thinking**: Structure complexity assessment and methodology selection
- **TodoWrite**: Track complexity-appropriate phases and deliverables
- **Evidence-Based Interaction**: Scale evidence requirements to complexity level
- **Strategic Orchestration**: Deploy agents appropriate to complexity assessment

### Framework Compatibility
- **Simple and Easy**: Maintain simplicity by avoiding unnecessary complexity
- **Evidence-Based**: Scale evidence requirements appropriately
- **Quality Focus**: Apply quality standards appropriate to risk and complexity
- **Continuous Improvement**: Learn from complexity assessment accuracy

### Process Dependencies
- **Prerequisites**: Problem identification and initial scope understanding
- **Inputs**: Problem description, stakeholder context, timeline constraints
- **Outputs**: Appropriately sophisticated solution with matching quality standards
- **Follow-up**: Complexity assessment validation and methodology effectiveness review

## Common Pitfalls and Solutions

### Over-Engineering (Using High Complexity for Simple Problems)
- **Symptoms**: Excessive analysis, stakeholder frustration, delayed delivery
- **Solution**: Regular complexity reassessment, simplification opportunities
- **Prevention**: Discipline in complexity assessment and methodology selection

### Under-Engineering (Using Simple Response for Complex Problems)
- **Symptoms**: Solution failures, stakeholder dissatisfaction, recurring problems
- **Solution**: Escalation protocols and complexity reassessment
- **Prevention**: Conservative complexity assessment, escalation trigger awareness

### Analysis Paralysis (Spending Too Much Time on Complexity Assessment)
- **Symptoms**: Extended assessment phase, delayed execution start
- **Solution**: Time-boxed assessment with default escalation
- **Prevention**: Clear assessment timeframes and decision criteria

### Methodology Switching Mid-Process
- **Symptoms**: Team confusion, resource waste, timeline delays
- **Solution**: Clear escalation criteria and transition protocols
- **Prevention**: Thorough initial assessment with reassessment checkpoints

This behavior ensures optimal resource allocation and solution effectiveness by systematically matching response sophistication to actual problem complexity, avoiding both over-engineering and under-engineering while maintaining high quality standards.

---

