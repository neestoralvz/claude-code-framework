# Agent Deployment Guidelines

## Overview

These guidelines ensure consistent, efficient agent creation that integrates seamlessly with our orchestration framework and maintains evidence-based validation standards.

## Pre-Deployment Checklist

### 1. Requirements Analysis
Before creating an agent, validate:
- [ ] **Clear need identification**: Specific gap in current agent capabilities
- [ ] **Domain boundaries**: Well-defined scope that doesn't overlap existing agents
- [ ] **Use case validation**: 2+ distinct scenarios requiring this specialization
- [ ] **Integration points**: Clear touchpoints with existing workflow systems

### 2. Design Planning
- [ ] **Tool requirements**: Specific tools needed for agent function
- [ ] **Model selection**: Complexity assessment determines sonnet/haiku/opus
- [ ] **Color availability**: Check agents.json for unused colors
- [ ] **Category placement**: Determine appropriate directory structure

### 3. Template Preparation
- [ ] **Template customization**: Agent Creation Template fully populated
- [ ] **Example scenarios**: 2 examples with context, user request, response, commentary
- [ ] **Operational phases**: 4-6 phases covering complete workflow
- [ ] **Success criteria**: Evidence-based, measurable outcomes defined

## Deployment Process

### Step 1: Agent File Creation
1. **File naming**: Use kebab-case matching the name field
2. **Directory placement**: Place in appropriate category directory
3. **Content structure**: Follow Agent Creation Template exactly
4. **Validation**: Run through validation checklist

### Step 2: Registry Integration
1. **Update agents.json**: Add complete registry entry
2. **Category management**: Update category arrays if needed
3. **Statistics update**: Increment totals and category counts
4. **Validation**: Verify JSON syntax and completeness

### Step 3: Integration Testing
1. **Framework compatibility**: Test with existing orchestration
2. **Tool validation**: Verify all specified tools are available
3. **Example validation**: Ensure examples accurately represent capabilities
4. **Quality assurance**: Run through quality framework

### Step 4: Documentation Updates
1. **System references**: Update any system documentation as needed
2. **Cross-references**: Create appropriate links to related components
3. **Usage guidelines**: Document deployment and usage patterns
4. **Maintenance notes**: Record any special requirements

## Quality Standards

### Technical Requirements
- **YAML validity**: Frontmatter must parse correctly
- **Tool accuracy**: All listed tools must be available and appropriate
- **Model selection**: Must match complexity requirements
- **Integration compliance**: Must work with existing orchestration

### Content Standards
- **Clarity**: Instructions must be unambiguous and actionable
- **Completeness**: All required sections present and populated
- **Consistency**: Format and style consistent with existing agents
- **Evidence-based**: Success criteria must be measurable and verifiable

### Framework Alignment
- **CLAUDE.md compliance**: Follows Simple and Easy Framework principles
- **Standards adherence**: Meets all system standards requirements
- **Process integration**: Compatible with existing workflow processes
- **Quality assurance**: Includes restart protocols for non-compliance

## Model Selection Guidelines

### Sonnet (Recommended for most agents)
**Use for**:
- Complex analysis and architecture tasks
- Multi-phase operational workflows
- System integration requirements
- Template and framework creation

**Examples**: agent-template-architect, validation-engineer, infrastructure-architect

### Haiku
**Use for**:
- Simple execution tasks
- Straightforward validation
- Basic automation workflows
- Limited scope operations

**Examples**: Simple validators, basic executors, status reporters

### Opus
**Use for**:
- Highly complex reasoning
- Strategic planning tasks
- Advanced architectural decisions
- Critical system design

**Examples**: Strategic architects, complex system analyzers

## Tool Selection Guidelines

### Analysis Tools
- **Grep**: Pattern searching and content analysis
- **Glob**: File pattern matching and discovery
- **LS**: Directory structure analysis
- **Read**: Content examination and analysis

### Creation Tools
- **Edit**: Single file modifications
- **MultiEdit**: Batch file operations
- **Write**: New file creation
- **NotebookEdit**: Jupyter notebook operations

### Execution Tools
- **Bash**: System operations and automation
- **BashOutput**: Background process monitoring
- **KillBash**: Process management

### Research Tools
- **WebFetch**: URL content retrieval
- **WebSearch**: Real-time information gathering
- **Context7 tools**: Library documentation access

### Management Tools
- **TodoWrite**: Task management and progress tracking

## Color Assignment Strategy

### Available Colors
- red, blue, green, yellow, purple, orange, pink, diane

### Assignment Principles
- **Consistency**: Related agents should use similar colors when possible
- **Availability**: Check agents.json for current assignments
- **Meaning**: Consider color psychology for agent function
- **Uniqueness**: Each agent must have a unique color

### Current Assignments (as of analysis)
Check `/Users/nalve/.claude/scripts/registries/agents.json` for current color usage before assignment.

## Category Management

### Existing Categories
- `core-system`: System integrity & enforcement agents
- `development-architecture`: System & component architecture specialists  
- `development-backend`: Backend development & architecture specialists
- `development-quality`: Quality assurance & complexity management specialists
- `database`: Database design, optimization & management specialists
- `operations-infrastructure`: Infrastructure & deployment specialists
- `operations-monitoring`: Monitoring & analytics specialists
- `operations-cloud`: Cloud platform expertise specialists
- `operations-orchestration`: Container & orchestration specialists
- `research`: Research & information retrieval specialists

### Creating New Categories
When existing categories don't fit:
1. **Justify need**: Clear distinction from existing categories
2. **Define scope**: Specific domain boundaries
3. **Plan structure**: Directory organization and naming
4. **Update registry**: Add to categories section with description

## Validation Protocols

### Pre-Deployment Validation
1. **Template compliance**: All required sections present
2. **Technical accuracy**: Tools, model, color properly specified
3. **Content quality**: Clear, actionable, evidence-based
4. **Integration testing**: Compatible with orchestration framework

### Post-Deployment Validation
1. **Functional testing**: Agent performs as specified
2. **Integration verification**: Works within existing workflows
3. **Quality metrics**: Meets defined success criteria
4. **Documentation accuracy**: Examples and guidelines correct

### Ongoing Maintenance
1. **Performance monitoring**: Track agent effectiveness
2. **Update management**: Keep capabilities current
3. **Integration maintenance**: Ensure continued compatibility
4. **Quality evolution**: Improve based on usage patterns

## Troubleshooting

### Common Issues
1. **YAML parsing errors**: Check frontmatter syntax
2. **Tool compatibility**: Verify all tools are available
3. **Integration failures**: Review orchestration compatibility
4. **Quality compliance**: Ensure evidence-based criteria

### Resolution Process
1. **Identify issue**: Systematic problem analysis
2. **Apply fix**: Use appropriate resolution method
3. **Validate solution**: Verify issue resolution
4. **Update documentation**: Record lessons learned

## Success Metrics

### Deployment Success
- Agent deploys without errors
- Integration tests pass
- Quality criteria met
- Documentation complete

### Operational Success
- Agent performs specified functions
- Evidence-based outcomes achieved
- Framework compatibility maintained
- Quality standards sustained

### Framework Impact
- Cognitive load reduction achieved
- Efficiency improvements measured
- Quality enhancement verified
- System integration improved

This systematic approach ensures every agent deployment contributes effectively to our orchestration framework while maintaining the Simple and Easy Framework principles.