# Medical Agent Templates - Deployment Guidelines

**Project:** Picadura de Alacrán Bibliography Verification System  
**Created:** 2025-08-20  
**Agent Count:** 5 specialized medical agents  

## Agent Template Overview

### 1. medical-bibliography-verifier (opus, red)
- **Purpose:** Verifies medical references for accuracy, authenticity, and credibility
- **Model:** opus (most capable for complex medical verification)
- **Color:** red (critical verification function)
- **Tools:** WebSearch, WebFetch, Grep, Read, Write

### 2. medical-literature-researcher (opus, blue)
- **Purpose:** Conducts comprehensive medical literature searches and analysis
- **Model:** opus (advanced reasoning for research synthesis)
- **Color:** blue (research and analysis function)
- **Tools:** WebSearch, WebFetch, Grep, Read, Write, Glob

### 3. bibliography-link-tester (sonnet, green)
- **Purpose:** Tests and validates bibliography links for accessibility
- **Model:** sonnet (balanced for technical testing tasks)
- **Color:** green (system validation and health checks)
- **Tools:** WebFetch, Bash, Grep, Read, Write

### 4. medical-reference-consolidator (sonnet, purple)
- **Purpose:** Consolidates and organizes medical references
- **Model:** sonnet (efficient for organizational tasks)
- **Color:** purple (data integration and consolidation)
- **Tools:** Read, Write, Grep, Glob, Edit, MultiEdit

### 5. presentation-bibliography-formatter (sonnet, orange)
- **Purpose:** Formats bibliographies for presentations
- **Model:** sonnet (adequate for formatting tasks)
- **Color:** orange (creative formatting and presentation)
- **Tools:** Read, Write, Edit, MultiEdit, Grep

## Deployment Instructions

### Step 1: Create Medical Agent Directory
```bash
mkdir -p ~/.claude/agents/medical
```

### Step 2: Deploy Agent Templates
Copy each template file to the agents directory:
```bash
cp medical-bibliography-verifier.md ~/.claude/agents/medical/
cp medical-literature-researcher.md ~/.claude/agents/medical/
cp bibliography-link-tester.md ~/.claude/agents/medical/
cp medical-reference-consolidator.md ~/.claude/agents/medical/
cp presentation-bibliography-formatter.md ~/.claude/agents/medical/
```

### Step 3: Verify YAML Frontmatter
Each agent template contains proper YAML frontmatter:
```yaml
---
name: agent-name
description: When this agent should be invoked
tools: tool1, tool2, tool3
model: sonnet|opus
color: blue|green|orange|pink|purple|yellow|red|cyan
---
```

### Step 4: Test Agent Deployment
Use the `/agents` command to verify agents are available:
```
/agents list
```

## Validation Requirements

### Pre-Deployment Validation Checklist

#### Technical Requirements
- [ ] YAML frontmatter syntax is valid
- [ ] All specified tools exist in Claude Code system
- [ ] Model specification is correct (haiku/sonnet/opus)
- [ ] Color specification is valid
- [ ] Agent name follows kebab-case convention
- [ ] Description clearly defines agent purpose

#### Content Requirements
- [ ] Agent specialization is clearly defined
- [ ] Medical domain expertise is documented
- [ ] Operational protocols are specified
- [ ] Quality standards are established
- [ ] Integration points are identified
- [ ] Escalation criteria are defined

#### Medical Accuracy Standards
- [ ] Medical terminology is accurate and current
- [ ] Scorpion sting (Picadura de Alacrán) focus is maintained
- [ ] Evidence-based practices are emphasized
- [ ] Clinical safety considerations are included
- [ ] Regional medical context (Mexico/Latin America) is addressed

### Post-Deployment Validation

#### Agent Functionality Testing
1. **Agent Availability Test**
   ```
   /agents list | grep medical
   ```

2. **Agent Invocation Test**
   ```
   Use Task tool with each agent to verify proper initialization
   ```

3. **Tool Access Verification**
   ```
   Verify each agent can access specified tools
   ```

#### Medical Domain Validation
1. **Specialization Verification**
   - Test agent responses align with medical domain
   - Verify scorpion sting expertise is demonstrated
   - Confirm appropriate medical terminology usage

2. **Quality Standards Compliance**
   - Validate evidence-based approach adherence
   - Verify medical accuracy requirements are met
   - Confirm safety and ethics considerations

3. **Integration Testing**
   - Test agent collaboration workflows
   - Verify data passing between agents
   - Confirm output format compatibility

## Evidence-Based Validation Protocol

### Validation Metrics
- **Agent Response Accuracy:** 95% medical fact accuracy rate
- **Domain Expertise:** Appropriate use of medical terminology
- **Task Completion:** 100% completion rate for assigned functions
- **Integration Success:** Seamless data flow between agents
- **Quality Compliance:** Adherence to evidence-based standards

### Validation Documentation
- Agent response quality assessments
- Medical accuracy verification reports
- Integration testing results
- Performance benchmark comparisons
- Compliance audit documentation

### Restart Criteria
Restart deployment if any validation fails:
- YAML syntax errors in frontmatter
- Tool access failures
- Medical accuracy below 95% threshold
- Integration workflow failures
- Quality standard non-compliance

## Operational Integration

### Team Workflow
1. **medical-literature-researcher** → Initial comprehensive research
2. **medical-bibliography-verifier** → Accuracy and credibility verification
3. **bibliography-link-tester** → Link accessibility validation
4. **medical-reference-consolidator** → Organization and integration
5. **presentation-bibliography-formatter** → Final presentation formatting

### Quality Assurance
- Continuous medical accuracy monitoring
- Regular agent performance evaluation
- Evidence-based methodology compliance
- Integration workflow optimization
- User feedback incorporation

### Maintenance Protocol
- Monthly agent performance review
- Quarterly medical knowledge updates
- Annual template revision and enhancement
- Continuous integration testing
- Documentation maintenance and updates

## Success Metrics

### Deployment Success Indicators
- All 5 agents successfully deployed and accessible
- 100% YAML frontmatter validation
- Complete tool access verification
- Medical domain expertise demonstration
- Successful integration workflow testing

### Operational Success Metrics
- Bibliography verification accuracy > 95%
- Literature search comprehensiveness
- Link accessibility validation completion
- Reference consolidation efficiency
- Presentation formatting quality

This deployment framework ensures systematic, evidence-based deployment of specialized medical agents for the Picadura de Alacrán bibliography verification project, maintaining the highest standards of medical accuracy and operational excellence.