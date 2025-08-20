# Parallel Conversation Coordination Workflow

## Overview
Methodology for coordinating multiple Claude conversations to execute complex, multi-faceted projects simultaneously while maintaining system coherence.

## When to Use
- **Complex projects** with independent work streams
- **Multiple specialized domains** requiring focused attention
- **Large scope** that would overwhelm single conversation
- **Parallel execution** opportunities identified

## Workflow Structure

### 1. Strategic Assessment
**Coordinator conversation identifies:**
- Independent work streams
- Specialized domains requiring focus
- Deliverables and dependencies
- Integration points

### 2. Ticket Generation
**Create structured tickets for each parallel work stream:**

**Ticket Structure:**
```yaml
---
ticket_id: PARALLEL-[domain]-[number]
domain: [DOMAIN_NAME]
priority: high|medium|low
estimated_effort: [hours/complexity]
dependencies: [list of other ticket IDs]
assigned_agents: [list of required specialized agents]
---

# [DOMAIN] Implementation Ticket

## Context
[Current system state and relevant background]

## Objectives
- [ ] [Specific deliverable 1]
- [ ] [Specific deliverable 2] 
- [ ] [Integration requirement]

## Deliverables
### Files
- **Path**: `[absolute/path/to/file1.ext]`
  - **Purpose**: [What this file accomplishes]
  - **Size Estimate**: [Expected file size or complexity]
- **Path**: `[absolute/path/to/file2.ext]`
  - **Purpose**: [What this file accomplishes]
  - **Size Estimate**: [Expected file size or complexity]

### Documentation
- **Path**: `[absolute/path/to/docs/file.md]`
  - **Content**: [Required documentation sections]
  - **Format**: [Markdown/README/API docs/etc]

### Testing
- **Path**: `[absolute/path/to/tests/file.test.ext]`
  - **Coverage**: [Expected test coverage percentage]
  - **Types**: [Unit/Integration/E2E tests required]

## Agent Requirements
- **Required Agents**: [List of specialized agents to deploy]
- **Concurrent Deployment**: Use Task tool with multiple agents (MAX 10)
- **Models**: [Recommended model types: haiku/sonnet/opus]

## Integration Points
- **Dependencies**: [List of prerequisite tickets with specific deliverable paths]
- **Provides**: [Files/APIs/data this ticket delivers to dependent tickets]
- **Interfaces**: [Specific integration contracts and API formats]

## Success Criteria
### Functional Requirements
- [ ] All deliverable files created at specified paths
- [ ] All functionality implemented and working
- [ ] Integration points verified and tested
- [ ] Documentation complete and accurate

### Quality Requirements  
- [ ] Code follows established patterns and conventions
- [ ] All tests passing with required coverage
- [ ] No security vulnerabilities introduced
- [ ] Performance meets specified benchmarks

### Process Requirements
- [ ] Required agents deployed and utilized properly
- [ ] Ticket progress updated throughout development
- [ ] Integration dependencies satisfied
- [ ] Evidence provided for all success metrics

## Success Metrics
### Quantitative Metrics
- **Test Coverage**: [X%] minimum coverage required
- **Performance**: [Specific performance benchmarks]
- **File Count**: [Expected number of files to be created]
- **Documentation Pages**: [Number of documentation sections/pages]

### Qualitative Metrics
- **Code Quality**: Follows established patterns, readable, maintainable
- **Integration Success**: Seamless integration with dependent tickets
- **Agent Utilization**: Proper specialized agent deployment verified
- **Framework Compliance**: Adheres to Simple & Easy Framework principles
```

**Ticket File Location:**
`work/[timestamp]-parallel-[project]/tickets/[ticket-id].md`

### 3. Ticket Distribution & Coordination
**Primary conversation becomes ticket coordinator:**

**Ticket Distribution:**
- Create `work/[timestamp]-parallel-[project]/` directory
- Generate individual ticket files in `tickets/` subdirectory
- Create `coordination-dashboard.md` for tracking progress
- Provide ticket URLs/paths for parallel conversations

**Coordination Role:**
- **Monitor**: Track ticket completion status via file system
- **Validate**: Ensure deliverables match ticket requirements
- **Agent Oversight**: Verify parallel conversations deployed specified agents
- **Integration**: Coordinate dependencies between tickets
- **Progress Tracking**: Update dashboard with completion status
- **Document**: Capture patterns and lessons learned

### 4. Progress Tracking
**Dashboard-based monitoring:**

**Coordination Dashboard Structure:**
```markdown
# Parallel Coordination Dashboard
## Project: [project-name]
## Created: [timestamp]

### Ticket Status
| Ticket ID | Domain | Status | Assignee | Completion |
|-----------|---------|---------|----------|------------|
| PARALLEL-API-001 | API Development | ✅ Complete | Conversation-2 | 100% |
| PARALLEL-UI-002 | Frontend | 🔄 In Progress | Conversation-3 | 60% |
| PARALLEL-DB-003 | Database | ⏳ Pending | Conversation-4 | 0% |

### Integration Status
- [ ] API-UI integration ready
- [ ] Database schema deployed
- [x] Authentication flow complete

### Agent Utilization Verification
- Conversation-2: ✅ Used api-design-specialist + testing-strategy-specialist
- Conversation-3: 🔄 Pending verification
- Conversation-4: ⏳ Not started
```

**Monitor via file system:**
- Ticket completion status in dashboard
- New deliverable files appearing
- Documentation updates
- Integration readiness indicators

### 5. Quality Gates
**Validation checkpoints:**
- Framework coherence maintained
- Standards compliance verified
- **Agent utilization verified**: All parallel conversations used appropriate agents
- **No direct implementation**: Work delegated properly to specialized agents
- No conflicts between parallel work
- Integration successful

## Implementation Pattern

### Ticket-Based Coordinator Setup
```bash
# Create project structure
mkdir -p work/[timestamp]-parallel-[project]/tickets/
mkdir -p work/[timestamp]-parallel-[project]/deliverables/

# Create coordination dashboard
touch work/[timestamp]-parallel-[project]/coordination-dashboard.md

# Generate tickets for each work stream
# (Coordinator creates individual ticket files)

# Monitor project progress
ls work/[timestamp]-parallel-[project]/tickets/     # Track ticket files
ls work/[timestamp]-parallel-[project]/deliverables/  # Monitor outputs
```

### Ticket Assignment Instructions
**Template for parallel conversation assignment:**

```
# Ticket Assignment: [TICKET-ID]

You are assigned to complete the following ticket from our parallel coordination project:

## Ticket Details
📋 **Ticket File**: `work/[timestamp]-parallel-[project]/tickets/[ticket-id].md`
🎯 **Your Assignment**: Read the complete ticket and execute all requirements

## Framework Requirements
- Read the ticket file thoroughly before starting
- Follow all agent deployment requirements specified in ticket
- Update ticket progress by checking off completed objectives
- Create all deliverables in specified locations
- Provide evidence of agent utilization

## Completion Process
1. **Read Ticket**: Use Read tool on the ticket file path provided
2. **Deploy Agents**: Use Task tool with agents specified in ticket
3. **Execute Work**: Complete all objectives and deliverables
4. **Update Progress**: Check off completed items in ticket file
5. **Report Completion**: Update coordinator when ticket is complete

## Coordination
- **Coordinator**: Main conversation monitors via dashboard
- **Integration**: Follow integration points specified in ticket
- **Dependencies**: Respect dependency order with other tickets

Start by reading your assigned ticket file and confirming your understanding before beginning work.
```

### Agent Utilization Requirements

**MANDATORY for ALL parallel conversations:**

#### Agent Deployment Rules
- **Every conversation MUST deploy agents**: No direct implementation allowed
- **Use Task tool immediately**: Deploy specialized agents before starting work
- **Concurrent deployment preferred**: Use multiple agents in single message (MAX 10)
- **Agent specialization required**: Match agent expertise to task domain

#### Agent Selection Guidelines
```
Domain Examples:
- API Development → api-design-specialist + testing-strategy-specialist
- Documentation → documentation-specialist + quality-assurance-specialist  
- System Architecture → system-architecture-specialist + integration-specialist
- Code Refactoring → code-analysis-specialist + refactoring-specialist
- Testing → testing-strategy-specialist + automation-specialist
```

#### Agent Configuration
- **Model Selection**: Use `sonnet` for most agents (balanced performance)
- **Color Coding**: Choose colors by function (blue=analysis, green=implementation, orange=testing)
- **Concurrent Limits**: Maximum 10 agents per message for optimal performance

#### Validation Requirements
- **Agent Evidence**: Must provide proof of agent deployment and utilization
- **No Bypassing**: Direct implementation without agents is framework violation
- **Specialization Check**: Agents must match task complexity and domain

### Integration Process
1. **Monitor Dashboard**: Check ticket completion status and integration readiness
2. **Validate Deliverables**: Ensure files created match ticket specifications
3. **Verify Agent Usage**: Confirm parallel conversations deployed required agents
4. **Check Dependencies**: Ensure prerequisite tickets completed before dependent ones
5. **Test Integration**: Verify no conflicts between parallel work streams
6. **Update Documentation**: Reflect new capabilities and patterns discovered
7. **Commit Changes**: Preserve all work with proper attribution to parallel conversations

## Benefits

### Efficiency
- **True parallelism**: Multiple work streams simultaneously
- **Specialization**: Each conversation focused on domain expertise
- **Reduced context switching**: Coordinator maintains big picture

### Quality
- **Centralized oversight**: Ensures coherence
- **Specialized focus**: Deep domain attention
- **Integration validation**: Prevents conflicts

### Scalability
- **Easy expansion**: Add more parallel conversations
- **Clear boundaries**: Each conversation has defined scope
- **Coordinated completion**: All work integrates cleanly

## Success Criteria
- ✅ All parallel deliverables completed
- ✅ **Agent deployment verified**: Every parallel conversation used appropriate specialized agents
- ✅ **No direct implementation**: All work properly delegated to agents
- ✅ **Agent specialization confirmed**: Agents matched task domains appropriately
- ✅ Framework coherence maintained
- ✅ No integration conflicts
- ✅ Documentation updated appropriately
- ✅ Methodology documented for reuse

## Patterns to Capture
- **Instruction clarity**: How to write effective parallel prompts
- **Monitoring cadence**: When and what to check
- **Integration timing**: How to coordinate completion
- **Quality validation**: What standards to enforce

---
*Workflow designed from successful parallel coordination experience*