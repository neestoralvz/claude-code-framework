[🏠 System Hub](../INDEX.md) | [📁 Standards](../STANDARDS.md) | [📖 Current Standard](#)

---

# Evidence-Based Validation

**Context**: Multi-source evidence requirements for strategic decisions and recommendations

**Purpose**: Ensure reliability and credibility through systematic evidence validation for all strategic choices

---

## Validation Requirements

### Mandatory Evidence Standards

**All Strategic Decisions Must Include**:
- Minimum 2 independent sources for simple decisions
- Minimum 3 independent sources for moderate complexity decisions  
- Minimum 4+ independent sources for high complexity decisions
- Source credibility assessment and documentation
- Evidence quality evaluation and confidence rating

### Source Credibility Criteria

**High Credibility Sources**:
- Peer-reviewed academic research
- Industry-leading organizations and recognized authorities
- Government agencies and regulatory bodies
- Direct measurements and quantifiable data
- Recent information (within 2 years for rapidly changing fields)

**Medium Credibility Sources**:
- Established industry publications and reports
- Professional associations and standards bodies
- Expert opinions from recognized practitioners
- Case studies from reputable organizations
- Historical data with continued relevance

**Low Credibility Sources** (require additional validation):
- Single-source claims without corroboration
- Anonymous or unverified information
- Outdated information beyond relevance timeframe
- Sources with apparent conflicts of interest
- Unsubstantiated opinions or speculation

### Evidence Documentation Format

**Required Documentation Structure**:
```markdown
## Evidence Summary

**Decision/Recommendation**: [Clear statement]

**Evidence Sources**:
1. **[Source Name]** - [Credibility Level: High/Medium/Low]
   - **Date**: [Publication/Collection Date]
   - **Relevance**: [How it supports the decision]
   - **Key Finding**: [Specific information used]
   - **Limitations**: [Known constraints or biases]

2. **[Source Name]** - [Credibility Level]
   - [Same format as above]

**Cross-Validation Summary**:
- **Convergent Evidence**: [Areas where sources agree]
- **Divergent Evidence**: [Areas of disagreement or uncertainty]
- **Evidence Gaps**: [Areas needing additional validation]

**Overall Confidence Level**: [High/Medium/Low]
**Rationale**: [Explanation of confidence rating]

**Validation Date**: [When evidence was collected and assessed]
**Review Required**: [When evidence should be reassessed]
```

## Validation Process

### Evidence Collection Phase

**Step 1: Source Identification**
- Identify relevant domains and expertise areas
- Search authoritative sources within each domain
- Prioritize recent, high-credibility sources
- Document search methodology and coverage

**Step 2: Initial Quality Assessment**
- Evaluate source credibility using established criteria
- Assess information recency and continued relevance
- Identify potential biases or conflicts of interest
- Rate initial evidence quality

**Step 3: Evidence Extraction**
- Extract specific information relevant to decision
- Document key findings and supporting data
- Note limitations and caveats
- Preserve links to original sources

### Cross-Validation Phase

**Step 4: Convergence Analysis**
- Compare findings across independent sources
- Identify areas of agreement and consensus
- Document consistent patterns and conclusions
- Assess strength of convergent evidence

**Step 5: Divergence Investigation**
- Analyze areas where sources disagree
- Investigate reasons for discrepancies
- Seek additional sources to resolve conflicts
- Document unresolved uncertainties

**Step 6: Gap Assessment**
- Identify areas with insufficient evidence
- Determine if additional research is needed
- Assess whether decisions can proceed with current evidence
- Plan for evidence updates when new information becomes available

### Confidence Rating Phase

**Step 7: Quality Integration**
- Synthesize evidence quality across all sources
- Weight evidence based on credibility and relevance
- Consider evidence quantity and diversity
- Assess overall evidence robustness

**Step 8: Confidence Determination**
```yaml
confidence_levels:
  high_confidence:
    criteria:
      - multiple_high_credibility_sources_agree
      - recent_and_relevant_information
      - minimal_evidence_gaps
      - strong_convergent_evidence
    threshold: ">85% confidence in decision accuracy"
    
  medium_confidence:
    criteria:
      - mixed_credibility_sources_with_general_agreement
      - some_information_gaps_present
      - moderate_convergent_evidence
      - manageable_uncertainties
    threshold: "65-85% confidence in decision accuracy"
    
  low_confidence:
    criteria:
      - limited_sources_or_credibility_concerns
      - significant_information_gaps
      - substantial_uncertainties
      - weak_or_conflicting_evidence
    threshold: "<65% confidence in decision accuracy"
```

## Quality Assurance Requirements

### Mandatory Quality Gates

**Pre-Decision Quality Gate**:
- Evidence documentation complete and properly formatted
- Minimum source requirements met for decision complexity level
- Source credibility assessment completed
- Cross-validation analysis performed
- Confidence rating assigned with rationale

**Decision Documentation Quality Gate**:
- Evidence summary clearly linked to decision rationale
- Limitations and uncertainties explicitly acknowledged
- Confidence level appropriately reflects evidence quality
- Review and update schedule established

**Post-Decision Quality Gate**:
- Decision outcomes tracked against evidence predictions
- Evidence accuracy validated through results
- Lessons learned captured for future evidence assessment
- Framework improvements identified and implemented

### Validation Checklist

**Evidence Collection Validation**:
- [ ] Minimum source requirements met for complexity level
- [ ] All sources assessed for credibility using standard criteria
- [ ] Source bias and limitations identified and documented
- [ ] Evidence extraction methodology clearly documented
- [ ] Search coverage and methodology recorded

**Cross-Validation Completion**:
- [ ] Convergent evidence identified and documented
- [ ] Divergent evidence investigated and explained
- [ ] Evidence gaps assessed and addressed
- [ ] Additional research needs identified
- [ ] Integration synthesis completed

**Documentation Standards**:
- [ ] Evidence summary follows required format
- [ ] All sources properly cited and linked
- [ ] Confidence rating assigned with clear rationale
- [ ] Review schedule established
- [ ] Decision traceability maintained

## Integration Requirements

### Framework Integration

**Tool Integration**:
- **WebSearch**: Current information and trend research
- **Context7**: Technical documentation and implementation evidence
- **Research and Document**: Systematic evidence collection and preservation
- **TodoWrite**: Track evidence collection phases and validation checkpoints

**Process Integration**:
- Evidence collection integrated into all strategic decision processes
- Validation requirements built into workflow checkpoints
- Quality gates enforce evidence standards before decision approval
- Continuous evidence updating as part of decision monitoring

### Stakeholder Integration

**Evidence Presentation Standards**:
- Clear summary of evidence sources and quality
- Explicit confidence ratings for all recommendations
- Transparent discussion of limitations and uncertainties
- Evidence trail available for stakeholder review

**Decision Communication Requirements**:
- Evidence summary included in all decision documentation
- Confidence levels clearly communicated to stakeholders
- Limitations and risks discussed transparently
- Evidence update schedule shared with relevant stakeholders

## Success Metrics

### Evidence Quality Metrics
- **Source Credibility**: >80% high-credibility sources for strategic decisions
- **Evidence Coverage**: >90% of decision factors supported by evidence
- **Cross-Validation**: 100% convergence analysis completed
- **Documentation Compliance**: 100% adherence to documentation standards

### Decision Quality Metrics
- **Prediction Accuracy**: Evidence-based decisions show >85% accuracy
- **Stakeholder Confidence**: >90% stakeholder trust in decision rationale
- **Decision Stability**: <10% decision reversals due to inadequate evidence
- **Learning Integration**: Continuous improvement in evidence assessment quality

### Process Efficiency Metrics
- **Evidence Collection Time**: Appropriate to decision complexity and timeline
- **Quality Gate Success**: >95% first-pass quality gate approval
- **Review Timeliness**: Evidence reviews completed within scheduled timeframes
- **Framework Adherence**: 100% compliance with evidence validation requirements

## Common Challenges and Solutions

### Time Constraints
- **Challenge**: Insufficient time for thorough evidence collection
- **Solution**: Pre-established evidence collection templates and rapid assessment protocols
- **Prevention**: Build evidence collection time into project planning

### Conflicting Evidence
- **Challenge**: Sources provide contradictory information
- **Solution**: Seek additional authoritative sources and expert consultation
- **Prevention**: Always collect multiple independent sources initially

### Evidence Gaps
- **Challenge**: Insufficient evidence available for key decision factors
- **Solution**: Acknowledge limitations explicitly and plan for evidence updates
- **Prevention**: Identify evidence requirements early in decision process

### Stakeholder Pressure
- **Challenge**: Pressure to make decisions without adequate evidence
- **Solution**: Clearly communicate evidence requirements and confidence levels
- **Prevention**: Establish evidence standards as non-negotiable quality requirements

This standard ensures all strategic decisions are grounded in validated, high-quality evidence while maintaining transparency about confidence levels and limitations.

---

**Navigation:** [↑ Standards](../STANDARDS.md) | [🏠 System Hub](../INDEX.md)