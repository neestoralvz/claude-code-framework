# Project Documentation Workflow

_Complete workflow for capturing and managing project documentation_

## Overview

This workflow ensures comprehensive project documentation from initiation through completion, providing structured guidance for capturing objectives, challenges, success criteria, and metrics.

## When to Use This Workflow

- **Starting any new project** (automatic via CLAUDE.md system commands)
- **User invokes `PROJECT` command** 
- **Project scope changes significantly**
- **Need to refocus or realign project goals**
- **Stakeholder alignment sessions**

## Workflow Steps

### Step 1: Project Documentation Capture

#### Interactive Information Gathering
1. **Project Identification**
   - Prompt for project name and description
   - Establish project timeline and key dates
   - Identify key stakeholders

2. **Objective Definition**
   - Guide user through overall objective articulation
   - Help define 3-5 specific, measurable objectives  
   - Prioritize objectives by importance and urgency
   - Identify dependencies between objectives

3. **Challenge Analysis**
   - Define the problem being solved
   - Quantify impact of current problem
   - Identify constraints and limitations
   - Determine why this needs to be solved now

4. **Success Criteria Establishment**
   - Define completion criteria for each deliverable
   - Set quality standards and acceptance criteria
   - Establish "definition of done"

5. **Metrics Definition**
   - Identify quantitative success metrics
   - Define qualitative measures
   - Set target values and baselines
   - Establish measurement methods

### Step 2: Documentation Generation

#### File Creation Process
1. **Generate Project Document**
   - Use [Project Documentation Template](../PROJECT-DOCUMENTATION-TEMPLATE.md)
   - Create file with naming convention: `PROJECT-[name]-[YYYYMMDD].md`
   - Store in appropriate location (`docs/` or project-specific directory)

2. **Populate Template**
   - Fill all required sections with gathered information
   - Customize template based on project type
   - Add project-specific sections as needed
   - Include relevant examples and context

3. **Validation Check**
   - Ensure all sections are complete
   - Verify metrics are measurable
   - Confirm objectives are SMART
   - Check that success criteria are clear

### Step 3: Integration and Setup

#### System Integration
1. **Link to Main Documentation**
   - Add reference in project README or main docs
   - Create quick-access link in CLAUDE.md if needed
   - Ensure documentation is discoverable

2. **Tracking Setup**
   - Create TodoWrite tasks for major objectives
   - Set up progress tracking mechanisms
   - Establish review schedule
   - Configure metric measurement tools

3. **Stakeholder Communication**
   - Share documentation with relevant stakeholders
   - Get approval/alignment on objectives and criteria
   - Schedule regular review meetings
   - Establish change management process

### Step 4: Ongoing Management

#### Regular Reviews
1. **Progress Tracking**
   - Weekly/monthly metric reviews
   - Objective completion status updates
   - Challenge resolution progress
   - Success criteria validation

2. **Documentation Maintenance**
   - Update metrics and progress
   - Revise objectives when scope changes
   - Document lessons learned
   - Archive completed sections

3. **Stakeholder Updates**
   - Regular status reports using documented metrics
   - Scope change communications
   - Success milestone celebrations
   - Final project completion documentation

## Command Integration

### `PROJECT` Command Usage

The `PROJECT` command initiates this workflow interactively:

```
PROJECT [project-name]
```

#### Command Behavior
1. **Information Gathering Phase**
   - Prompts user for all required project information
   - Guides through each section systematically
   - Provides examples and clarification as needed
   - Validates completeness before proceeding

2. **Documentation Generation Phase**
   - Creates project documentation file automatically
   - Populates template with gathered information
   - Stores file in appropriate location
   - Links to existing documentation structure

3. **Setup Phase**
   - Creates TodoWrite tasks for major objectives
   - Sets up tracking mechanisms
   - Provides next steps and recommendations
   - Schedules follow-up reviews

## Interactive Prompts

### Overall Objective Prompts
- "What is the main goal you want to achieve with this project?"
- "In 1-2 sentences, describe what success looks like."
- "What value will this project deliver when complete?"

### Specific Objectives Prompts  
- "What are 3-5 concrete, measurable goals for this project?"
- "How will you know when each objective is complete?"
- "Which objectives are most critical to project success?"
- "Are there dependencies between any objectives?"

### Challenge Definition Prompts
- "What specific problem does this project solve?"
- "Why does this problem need to be solved now?"
- "Who is affected by this problem?"
- "What constraints or limitations do you need to work within?"

### Success Criteria Prompts
- "What specific deliverables will this project produce?"
- "What quality standards must each deliverable meet?"
- "How will you measure whether the project is truly complete?"

### Success Metrics Prompts
- "How will you measure the success of this project?"
- "What numbers/data will show whether you've succeeded?"
- "What is the current baseline for these metrics?"
- "How often will you measure progress?"

## Quality Standards

### Documentation Requirements
- **Completeness**: All template sections filled with relevant information
- **Clarity**: Objectives and criteria are clear and unambiguous  
- **Measurability**: Success criteria include quantifiable metrics
- **Specificity**: Objectives follow SMART criteria
- **Actionability**: Next steps are clearly defined

### Validation Checklist
- [ ] Overall objective clearly stated
- [ ] 3-5 specific objectives defined
- [ ] Objectives are SMART (Specific, Measurable, Achievable, Relevant, Time-bound)
- [ ] Challenge/problem clearly articulated
- [ ] Success criteria are measurable
- [ ] Metrics have baseline and target values
- [ ] Timeline and key dates identified
- [ ] Stakeholders identified
- [ ] Next steps defined

## Success Metrics for This Workflow

### Efficiency Metrics
- **Setup Time**: Complete project documentation in < 30 minutes
- **Completion Rate**: 100% of required sections filled
- **Usage Rate**: PROJECT command used for all new projects

### Quality Metrics  
- **Clarity Score**: Objectives pass SMART criteria validation
- **Measurability**: All success criteria have quantifiable metrics
- **Stakeholder Alignment**: 100% stakeholder approval on documentation

### Outcome Metrics
- **Project Success Rate**: Projects with complete documentation have higher success rates
- **Scope Management**: Fewer scope changes on well-documented projects
- **Time to Completion**: Better project completion times with clear objectives

## Tools and Resources

### Required Tools
- [Project Documentation Template](../PROJECT-DOCUMENTATION-TEMPLATE.md)
- TodoWrite for task tracking
- File system access for documentation storage

### Optional Enhancements
- Stakeholder review templates
- Progress tracking dashboards  
- Automated metric collection tools
- Project timeline visualization

## Troubleshooting

### Common Issues
- **Vague Objectives**: Guide user to make objectives more specific and measurable
- **Missing Metrics**: Help identify quantifiable success measures
- **Unclear Timeline**: Work with user to establish realistic dates
- **Stakeholder Confusion**: Facilitate alignment sessions

### Resolution Strategies
- Use examples from template to clarify requirements
- Break down complex objectives into smaller, measurable parts
- Provide guidance on metric selection and measurement
- Offer to facilitate stakeholder alignment discussions

---

**This workflow ensures every project starts with clear objectives, measurable success criteria, and comprehensive documentation that supports project success.**