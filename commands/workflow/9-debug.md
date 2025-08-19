---
title: "Debug Command"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["workflow.md", "fundamental.md", "validation-methodology.md"]
prerequisites: ["Active workflow execution", "Identified issues or blockages"]
audience: "Workflow troubleshooters and system diagnosticians"
purpose: "Diagnose and resolve workflow execution issues, blockages, and quality problems"
keywords: ["debug", "troubleshooting", "workflow", "diagnostics", "problem-resolution"]
last_review: "2025-08-18"
---

[Previous: Deploy Validate Command](validate.md) | [Return to Documentation Hub for navigation](../docs/index.md) | [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md) | [Next: Deploy Recurse Command](recurse.md)

# DEBUG COMMAND

## Purpose

⏺ **Principle**: This command implements [workflow.md diagnostic capability](../docs/principles/workflow.md) by providing systematic troubleshooting for workflow execution issues, and applies [fundamental.md evidence approach](../docs/principles/fundamental.md) through root cause analysis.

Execute comprehensive debugging of workflow phases, agent coordination, and execution barriers to identify and resolve systematic issues.

## Command Syntax

```bash
# Basic usage - comprehensive workflow debugging
debug

# With specific debugging scope
debug --scope [phase|agent|integration|validation]

# With diagnostic depth and focus
debug --depth [surface|detailed|root-cause] --focus [blockages|quality|performance]
```

## Execution Workflow

### Phase 1: Issue Discovery
- Analyze current workflow state and execution history
- Identify failed validations, blocked phases, and error patterns
- Map agent coordination issues and communication failures
- Document symptom patterns and impact assessment

### Phase 2: Root Cause Analysis
- Trace execution paths to identify failure origins
- Analyze agent outputs and coordination breakdowns
- Examine validation failures and quality issues
- Investigate dependency conflicts and resource constraints

### Phase 3: Solution Generation
- Design targeted fixes for identified root causes
- Generate recovery strategies and workaround procedures
- Plan agent redeployment and coordination improvements
- Develop validation enhancements and quality gates

### Phase 4: Resolution Implementation
- Execute fixes and recovery procedures systematically
- Redeploy agents with improved coordination
- Implement enhanced validation and monitoring
- Verify resolution effectiveness and document lessons learned

## Parameters

### Required Parameters
None - command analyzes current workflow state automatically

### Optional Parameters
- **--scope**: Focus debugging on specific area (phase|agent|integration|validation)
- **--depth**: Diagnostic thoroughness (surface|detailed|root-cause)
- **--focus**: Problem category priority (blockages|quality|performance)
- **--phase**: Target specific workflow phase for debugging

## Expected Output

```bash
WORKFLOW DEBUG ANALYSIS
=======================

Execution Status Overview:
┌─ Current Phase: [Phase Name] - [Status]
├─ Overall Progress: [X]% complete
├─ Active Issues: [N] problems identified
└─ System Health: [Healthy/Degraded/Critical]

Issue Identification:

🚨 CRITICAL ISSUES
├─ Issue 1: [Description of critical problem]
│   ├─ Phase: [Affected workflow phase]
│   ├─ Impact: [Severity and scope assessment]
│   ├─ Root Cause: [Underlying cause analysis]
│   └─ Resolution: [Recommended fix strategy]
└─ Issue 2: [Description of critical problem]
    └─ [Similar structure...]

⚠️  WARNING ISSUES
├─ Issue A: [Description of warning-level problem]
│   ├─ Potential Impact: [Risk assessment]
│   └─ Mitigation: [Prevention strategy]
└─ Issue B: [Description of warning-level problem]

Agent Coordination Analysis:
┌─ Active Agents: [N] deployed
├─ Communication Status: [Healthy/Issues/Failed]
├─ Dependency Conflicts: [N] conflicts detected
└─ Resource Utilization: [Efficiency metrics]

Phase-Specific Diagnostics:
✅ Phase 1 (Clarification): No issues detected
❌ Phase 2 (Exploration): Context gathering incomplete
🔄 Phase 3 (Analysis): Currently executing with delays
⏳ Phase 4 (Presentation): Pending Phase 3 completion

Recommended Actions:
1. **Immediate**: [High-priority action with timeline]
2. **Short-term**: [Medium-priority action with timeline]
3. **Long-term**: [Preventive measure for future]

Recovery Plan:
□ Execute critical issue resolutions
□ Restart failed agent deployments
□ Validate phase completion criteria
□ Resume workflow execution from stable point

DEBUG ANALYSIS COMPLETE - Resolution Plan Available
```

## Integration Points

### Workflow Integration
- Provides diagnostic capability for any workflow phase
- Enables recovery and continuation from failure points
- Integrates with validation systems for quality assurance

### Agent Integration
- Diagnoses agent coordination and communication issues
- Enables agent redeployment and configuration fixes
- Provides agent performance and efficiency analysis

## Success Criteria

- [ ] All workflow execution issues identified and categorized
- [ ] Root cause analysis completed for critical problems
- [ ] Resolution strategies developed and documented
- [ ] Recovery plan established with clear action items
- [ ] System ready for resumed or restarted execution

## Usage Examples

### Comprehensive Workflow Debug
```bash
debug
# Expected result: Complete diagnostic analysis of entire workflow execution
```

### Agent-Focused Debugging
```bash
debug --scope agent --depth root-cause
# Expected result: Deep analysis of agent coordination and communication issues
```

### Phase-Specific Troubleshooting
```bash
debug --phase 3 --focus blockages
# Expected result: Targeted debugging of Phase 3 execution blockages
```

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../docs/index.md)
- [Browse commands index](index.md)
- [Study PRINCIPLES.md](../docs/PRINCIPLES.md)

### Related Commands
- [Validate command](validate.md) - For validation debugging
- [Recurse command](recurse.md) - For workflow iteration after debugging
- [System audit command](system-audit.md) - For system-wide diagnostics

### Principle References
- [Apply workflow.md for systematic execution](../docs/principles/workflow.md)
- [Use fundamental.md for evidence-based analysis](../docs/principles/fundamental.md)
- [Follow validation-methodology.md for quality assurance](../docs/components/validation-methodology.md)

[⬆ Return to top](#debug-command)