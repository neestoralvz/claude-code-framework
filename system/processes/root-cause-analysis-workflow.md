[🏠 System Hub](../INDEX.md) | [📁 Processes](../PROCESSES.md) | [📖 Current Process](#)

---

# Root Cause Analysis Workflow

**Context**: Systematic investigation and elimination of underlying issues using evidence-based methodologies

**Purpose**: Identify and address fundamental causes rather than symptoms through structured analysis techniques

---

## Process Overview

Systematic investigation of problems to identify underlying causes and develop lasting solutions that eliminate issues at their source.

## Analysis Methodology Selection

### Complexity-Based Approach

**Simple Issues** - 5 Whys Technique:
- Linear cause-effect relationships
- Single domain problems
- Clear symptom presentation
- Rapid analysis required

**Moderate Complexity** - Fishbone Diagram:
- Multiple contributing factors
- Cross-functional impact
- Category-based analysis needed
- Team collaboration beneficial

**High Complexity** - Fault Tree Analysis:
- Complex system interactions
- Multiple failure modes
- Safety-critical implications
- Comprehensive investigation required

## Workflow Phases

### Phase 1: Problem Definition and Scope (10-20 minutes)

**Objectives**:
- Define problem clearly and specifically
- Establish analysis scope and boundaries
- Identify immediate impacts and symptoms
- Select appropriate analysis methodology

**Activities**:
1. **Problem Statement Development**
   - Specific issue description
   - Quantifiable impact assessment
   - Timeline and frequency analysis
   - Affected stakeholder identification

2. **Scope Definition**
   - System boundary establishment
   - Analysis depth determination
   - Resource allocation planning
   - Timeline setting

3. **Methodology Selection**
   - Complexity assessment
   - Technique selection rationale
   - Tool and resource requirements
   - Team composition planning

**Deliverables**:
- Clear problem statement
- Analysis scope document
- Methodology selection rationale
- Investigation plan

### Phase 2: Data Collection and Evidence Gathering (20-45 minutes)

**Objectives**:
- Gather comprehensive factual evidence
- Document symptoms and manifestations
- Collect stakeholder perspectives
- Establish timeline and sequence

**Activities**:
1. **Symptom Documentation**
   - Observable manifestations
   - Quantifiable metrics
   - Occurrence patterns
   - Impact measurement

2. **Stakeholder Input Collection**
   - Direct observation reports
   - Experience documentation
   - Perspective gathering
   - Expert consultation

3. **Historical Analysis**
   - Previous occurrence review
   - Pattern identification
   - Trend analysis
   - Baseline establishment

**Deliverables**:
- Evidence collection report
- Stakeholder input summary
- Historical analysis findings
- Data validation results

### Phase 3: Root Cause Investigation (30-90 minutes)

**Objectives**:
- Apply selected analysis technique
- Identify underlying causes systematically
- Validate cause-effect relationships
- Prioritize root causes by impact

#### 5 Whys Technique (Simple Issues)

**Process**:
1. Start with problem statement
2. Ask "Why does this happen?" and document answer
3. For each answer, ask "Why?" again
4. Continue until root cause identified (typically 5 iterations)
5. Validate root cause through evidence

**Example Structure**:
```
Problem: Website loading slowly
Why 1: Database queries taking too long
Why 2: Query optimization not implemented
Why 3: Performance monitoring not in place
Why 4: Development process lacks performance review
Why 5: No performance standards established
Root Cause: Missing performance standards and review process
```

#### Fishbone Diagram (Moderate Complexity)

**Categories for Analysis**:
- **People**: Human factors, skills, training
- **Process**: Procedures, workflows, methods
- **Materials**: Resources, inputs, supplies
- **Machines**: Equipment, tools, technology
- **Environment**: Conditions, context, external factors
- **Measurement**: Metrics, monitoring, feedback

**Process**:
1. Define problem as fish head
2. Create category branches (fishbones)
3. Brainstorm causes within each category
4. Analyze relationships between causes
5. Identify primary root causes
6. Validate through evidence

#### Fault Tree Analysis (High Complexity)

**Process**:
1. Define top-level failure event
2. Identify immediate causes using logic gates
3. Decompose each cause into sub-causes
4. Continue until basic events identified
5. Analyze failure paths and probabilities
6. Identify critical failure points

**Logic Gates**:
- **AND**: All inputs must occur for output
- **OR**: Any input can cause output
- **Priority AND**: Inputs must occur in sequence
- **Inhibit**: Input occurs only if condition met

### Phase 4: Cause Validation and Prioritization (20-40 minutes)

**Objectives**:
- Validate identified root causes with evidence
- Assess impact and probability of each cause
- Prioritize causes for solution development
- Document validation rationale

**Activities**:
1. **Evidence-Based Validation**
   - Supporting data collection
   - Expert review and confirmation
   - Historical correlation analysis
   - Statistical validation where applicable

2. **Impact Assessment**
   - Severity rating
   - Frequency evaluation
   - Cost impact analysis
   - Risk level determination

3. **Prioritization Matrix**
   - Impact vs. effort analysis
   - Risk vs. probability assessment
   - Strategic importance weighting
   - Resource requirement consideration

**Deliverables**:
- Validated root cause list
- Impact assessment matrix
- Prioritized cause ranking
- Validation evidence documentation

### Phase 5: Solution Development (30-60 minutes)

**Objectives**:
- Develop targeted solutions for root causes
- Design preventive measures
- Create implementation plan
- Establish monitoring system

**Activities**:
1. **Root Cause Solution Design**
   - Direct cause elimination strategies
   - Preventive measure development
   - System improvement recommendations
   - Process redesign proposals

2. **Solution Validation**
   - Effectiveness assessment
   - Feasibility evaluation
   - Cost-benefit analysis
   - Risk evaluation

3. **Implementation Planning**
   - Solution prioritization
   - Resource allocation
   - Timeline development
   - Success metrics definition

**Deliverables**:
- Solution design specifications
- Implementation plan
- Resource requirements
- Success measurement framework

### Phase 6: Implementation and Monitoring (Ongoing)

**Objectives**:
- Execute solutions systematically
- Monitor effectiveness continuously
- Validate root cause elimination
- Prevent recurrence

**Activities**:
1. **Solution Implementation**
   - Phased execution
   - Change management
   - Training and communication
   - Progress monitoring

2. **Effectiveness Monitoring**
   - Success metrics tracking
   - Problem recurrence monitoring
   - Impact measurement
   - Stakeholder feedback collection

3. **Continuous Improvement**
   - Solution optimization
   - Process refinement
   - Learning integration
   - Prevention enhancement

**Deliverables**:
- Implementation progress reports
- Effectiveness measurement results
- Optimization recommendations
- Prevention system documentation

## Integration with Framework

### Tool Integration
- **TodoWrite**: Track analysis phases and action items
- **WebSearch**: Research best practices and methodologies
- **Progressive Thinking**: Structure complex analysis
- **Parallel Execution**: Coordinate multi-team investigations

### Quality Standards
- Evidence-based validation for all identified causes
- Multi-source verification of root causes
- Quantifiable impact assessment
- Stakeholder validation of findings

### Process Dependencies
- **Prerequisites**: Problem identification and initial assessment
- **Inputs**: Problem description, impact data, stakeholder context
- **Outputs**: Validated root causes with solution recommendations
- **Follow-up**: Solution implementation and monitoring

## Success Criteria

### Analysis Quality
- Root causes validated with evidence
- Complete cause identification (no major causes missed)
- Stakeholder agreement on findings
- Clear cause-effect relationships established

### Solution Effectiveness
- Problem recurrence elimination >90%
- Stakeholder satisfaction with solutions >85%
- Implementation within planned timeline
- Cost-effective solution deployment

## Common Analysis Patterns

### Technology Issues
- **Common Root Causes**: Inadequate testing, insufficient monitoring, lack of standards
- **Prevention Focus**: Process improvement, automation, quality gates

### Process Problems
- **Common Root Causes**: Unclear procedures, insufficient training, lack of accountability
- **Prevention Focus**: Documentation, training systems, feedback mechanisms

### Communication Failures
- **Common Root Causes**: Unclear channels, information overload, missing stakeholders
- **Prevention Focus**: Communication standards, regular updates, stakeholder mapping

### Resource Constraints
- **Common Root Causes**: Poor planning, unrealistic expectations, inadequate allocation
- **Prevention Focus**: Capacity planning, realistic scoping, resource monitoring

## Risk Management

### Analysis Risks
- **Symptom Focus**: Ensure investigation goes beyond surface symptoms
- **Bias Confirmation**: Use multiple perspectives and evidence sources
- **Scope Creep**: Maintain focus on specific problem being analyzed
- **Analysis Paralysis**: Set time limits and decision points

### Solution Risks
- **Over-Engineering**: Match solution complexity to root cause complexity
- **Incomplete Implementation**: Ensure all root causes addressed
- **Resistance to Change**: Include change management in solution design
- **Monitoring Gaps**: Establish comprehensive monitoring and feedback systems

---

**Navigation:** [↑ Processes](../PROCESSES.md) | [🏠 System Hub](../INDEX.md)