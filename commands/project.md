---

**IF executing this command** → READ [CLAUDE.md](../CLAUDE.md#framework-overview), THEN execute this command

# Project Command

**Context**: Interactive slash command to capture comprehensive project documentation

---

## Usage

```
/project [project-name]
```

## What It Does

Launches the [Project Documentation Workflow](../core/02-operations/processes/project-documentation-workflow.md) to capture comprehensive project information:

1. **Interactive Information Gathering** - Guided prompts for all project elements
2. **Objective Definition** - Overall and specific measurable objectives
3. **Challenge Analysis** - Problem definition and impact quantification  
4. **Success Criteria** - Completion criteria and quality standards
5. **Metrics Definition** - Quantitative and qualitative success measures
6. **Documentation Generation** - Creates complete project documentation
7. **Task Setup** - TodoWrite tasks and progress tracking
8. **System Integration** - Links documentation and sets up monitoring

## Examples

**Basic Project Setup:**
```
/project user-dashboard-enhancement
```

**Research Project:**
```
/project market-analysis-q3
```

**Development Initiative:**
```
/project api-performance-optimization
```

## Interactive Prompts

The command guides you through comprehensive information capture:

### Overall Objective
- "What is the main goal you want to achieve with this project?"
- "In 1-2 sentences, describe what success looks like."
- "What value will this project deliver when complete?"

### Specific Objectives  
- "What are 3-5 concrete, measurable goals for this project?"
- "How will you know when each objective is complete?"
- "Which objectives are most critical to project success?"
- "Are there dependencies between any objectives?"

### Challenge Definition
- "What specific problem does this project solve?"
- "Why does this problem need to be solved now?"
- "Who is affected by this problem?"
- "What constraints or limitations do you need to work within?"

### Success Criteria
- "What specific deliverables will this project produce?"
- "What quality standards must each deliverable meet?"
- "How will you measure whether the project is truly complete?"

### Success Metrics
- "How will you measure the success of this project?"
- "What numbers/data will show whether you've succeeded?"
- "What is the current baseline for these metrics?"
- "How often will you measure progress?"

## Generated Outputs

### Project Documentation File
- **Location**: `docs/PROJECT-[name]-[YYYYMMDD].md`
- **Content**: Complete project documentation using structured template
- **Sections**: Objectives, challenges, success criteria, metrics, timeline

### TodoWrite Tasks
- Major objectives broken into actionable tasks
- Prioritized by importance and dependencies
- Linked to success criteria and metrics
- Set up for progress tracking

### System Integration
- Documentation linked in project README
- Progress tracking mechanisms configured
- Stakeholder communication plan established
- Review schedule and milestone tracking

## Quality Standards

### Documentation Requirements
- **Completeness**: All template sections filled with relevant information
- **Clarity**: Objectives and criteria are clear and unambiguous  
- **Measurability**: Success criteria include quantifiable metrics
- **Specificity**: Objectives follow SMART criteria (Specific, Measurable, Achievable, Relevant, Time-bound)
- **Actionability**: Next steps are clearly defined

### Validation Checklist
- [ ] Overall objective clearly stated
- [ ] 3-5 specific objectives defined with SMART criteria
- [ ] Challenge/problem clearly articulated with quantified impact
- [ ] Success criteria are measurable and specific
- [ ] Metrics have baseline and target values
- [ ] Timeline and key dates identified
- [ ] Stakeholders identified
- [ ] Next steps defined with TodoWrite tasks

## Expected Results

- **Complete Project Documentation** - Comprehensive project overview with all critical elements
- **Actionable Task List** - TodoWrite tasks ready for immediate execution
- **Success Measurement Framework** - Clear metrics and tracking mechanisms
- **Stakeholder Alignment** - Documentation suitable for team/stakeholder review
- **Progress Tracking Setup** - Systems configured for ongoing project monitoring

## Integration

- **Process Reference**: [Project Documentation Workflow](../core/02-operations/processes/project-documentation-workflow.md)
- **Template**: [Project Documentation Template](../core/04-templates/project-templates/project-documentation.md)
- **System Commands**: Referenced in [CLAUDE.md](../CLAUDE.md#project-documentation-commands)
- **Framework Alignment**: Follows "Simple and Easy" principles through structured guidance

## Workflow Automation

### Automatic Actions
- Creates timestamped project documentation file
- Populates template with gathered information
- Sets up TodoWrite tasks for major objectives
- Links documentation to project structure
- Configures progress tracking mechanisms

### Manual Follow-ups
- Stakeholder review and approval
- Resource allocation and team assignment
- Timeline refinement based on dependencies
- Risk assessment and mitigation planning
- Regular progress review scheduling

---

**This slash command ensures comprehensive project planning with structured documentation from project initiation.**