---
title: "Implement Command"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["workflow.md", "agent-selection.md", "engineering.md"]
prerequisites: ["Completed planning phase", "Implementation roadmap available"]
audience: "Implementation teams and specialized agents"
purpose: "Execute Phase 6 workflow: Execute planned solution through specialized agents"
keywords: ["implementation", "workflow", "phase6", "agent-execution", "specialized-agents"]
last_review: "2025-08-18"
---

[Previous: Deploy Plan Command](plan.md) | [Return to Documentation Hub for navigation](../docs/index.md) | [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md) | [Next: Deploy Ripple Effect Command](ripple-effect.md)

# IMPLEMENT COMMAND

## Purpose

⏺ **Principle**: This command implements [Apply workflow.md Phase 6 agent-based execution](../../docs/principles/workflow.md#6-implementation) by executing planned solutions through specialized agents, and applies [Apply agent-selection.md systematic agent deployment](../../docs/principles/agent-selection.md#selection-methodology) through systematic agent deployment.

Execute implementation roadmap by deploying specialized agents for each planned task while maintaining coordination and quality oversight.

## Command Syntax

```bash
# Basic usage - execute full implementation plan
implement

# With specific phase or component
implement --phase [phase-number|phase-name] --component [component-name]

# With execution mode and monitoring
implement --mode [sequential|parallel|hybrid] --monitor [progress|detailed|minimal]
```

## Execution Workflow

### Phase 1: Implementation Preparation
- Load implementation plan and task breakdown
- Verify agent availability and readiness
- Establish coordination and communication channels
- Initialize progress tracking and monitoring

### Phase 2: Agent Deployment
- Deploy specialized agents per task assignments
- Coordinate sequential and parallel executions
- Monitor agent progress and output quality
- Manage inter-agent communication and dependencies

### Phase 3: Quality Assurance
- Validate agent outputs against success criteria
- Verify integration points and component interactions
- Ensure adherence to engineering standards
- Coordinate quality gates and checkpoints

### Phase 4: Implementation Coordination
- Orchestrate overall implementation progress
- Handle exceptions and requirement changes
- Maintain stakeholder communication
- Prepare outputs for ripple effect analysis

## Parameters

### Required Parameters
None - command processes planning outputs automatically

### Optional Parameters
- **--phase**: Execute specific implementation phase (phase-number|phase-name)
- **--component**: Focus on specific component implementation
- **--mode**: Execution approach (sequential|parallel|hybrid)
- **--monitor**: Monitoring level (progress|detailed|minimal)

## Expected Output

```bash
IMPLEMENTATION EXECUTION
========================

Implementation Status:
┌─ Overall Progress: [X]% Complete
├─ Current Phase: [Phase Name]
├─ Active Agents: [N] deployed
└─ Quality Status: [Pass/Issues/Blocked]

Agent Deployment Summary:

🤖 AGENT: project-optimizer
├─ Task: [Assigned task description]
├─ Status: [In Progress/Completed/Blocked]
├─ Progress: [X]% complete
└─ Output: [Brief output summary]

🤖 AGENT: implementation-specialist  
├─ Task: [Assigned task description]
├─ Status: [In Progress/Completed/Blocked]
├─ Progress: [X]% complete
└─ Output: [Brief output summary]

Phase Completion Status:
✅ Phase 1: [Phase Name] - Completed
🔄 Phase 2: [Phase Name] - In Progress (X% complete)
⏳ Phase 3: [Phase Name] - Pending
⏳ Phase 4: [Phase Name] - Pending

Quality Gates:
✅ Engineering standards compliance verified
✅ Integration points tested and validated
🔄 Security requirements under review
⏳ Performance benchmarks pending

Next Steps:
- Continue Phase 2 implementation tasks
- Deploy additional agents for Phase 3 preparation
- Monitor quality gate completion
- Prepare for ripple effect analysis

Implementation Results Ready for Ripple Effect Phase
```

## Integration Points

### Workflow Integration
- Executes planning phase outputs through agent coordination
- Generates implementation results for ripple effect analysis
- Maintains quality standards throughout execution

### Agent Coordination
- Deploys multiple specialized agents per plan requirements
- Manages agent communication and dependency coordination
- Ensures quality oversight and validation throughout

## Success Criteria

- [ ] All planned tasks executed by appropriate specialized agents
- [ ] Quality gates passed and engineering standards maintained
- [ ] Integration points validated and tested
- [ ] Implementation outputs documented and verified
- [ ] Ready to proceed to ripple effect analysis

## Usage Examples

### Full Implementation
```bash
implement
# Expected result: Complete execution of implementation plan with agent coordination
```

### Phase-Specific Implementation
```bash
implement --phase 2 --monitor detailed
# Expected result: Detailed execution of Phase 2 with comprehensive monitoring
```

### Parallel Execution Mode
```bash
implement --mode parallel --component authentication
# Expected result: Parallel execution focusing on authentication component
```

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../docs/index.md)
- [Browse commands index](index.md)
- [Study PRINCIPLES.md](../docs/PRINCIPLES.md)

### Related Commands
- [Plan command](plan.md) - Previous workflow phase
- [Ripple effect command](ripple-effect.md) - Next workflow phase
- [Execute ticket command](execute-ticket.md) - For individual task execution

### Principle References
- [Apply workflow.md for systematic execution](../docs/principles/workflow.md)
- [Use agent-selection.md for specialized deployment](../docs/principles/agent-selection.md)
- [Follow engineering.md for quality standards](../docs/principles/engineering.md)

[⬆ Return to top](#implement-command)