---
title: "Enforcement Gap Analysis Command"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["system-audit.md", "../workflow/1-clarify.md", "../../docs/PRINCIPLES.md"]
prerequisites: ["Understanding of CLAUDE.md framework", "Agent selection principles"]
audience: "System architects and enforcement analysts"
purpose: "Detect and analyze enforcement gaps where framework rules exist but aren't implemented"
keywords: ["enforcement", "gap-analysis", "compliance", "framework", "implementation"]
command_type: "analysis"
execution_agent: "system-auditor"
estimated_time: "15-30 minutes"
---

[Previous: Browse system-audit.md for methodology](system-audit.md) | [Return to commands hub](../index.md) | [Study PRINCIPLES.md for framework](../../docs/PRINCIPLES.md) | [Next: Apply system-evolve.md for improvements](system-evolve.md)

# ENFORCEMENT GAP ANALYSIS

⏺ **Principle**: This command implements [directive.md enforcement requirements](../../docs/principles/directive.md) by systematically detecting where framework rules exist but lack implementation mechanisms.

## Command Purpose

Identify critical gaps between defined framework rules and their actual enforcement in system operations.

## Input Parameters

- `--scope` (required): Analysis scope (workflow|agents|principles|tickets|all)
- `--depth` (optional): Analysis depth (surface|comprehensive|root-cause) [default: comprehensive]
- `--focus` (optional): Specific enforcement area to prioritize
- `--output` (optional): Output format (summary|detailed|actionable) [default: actionable]

## Execution Requirements

### Pre-Execution Validation
- [ ] **Authority Verification**: CLAUDE.md framework rules documented and accessible
- [ ] **Scope Definition**: Analysis scope clearly defined and bounded
- [ ] **Agent Availability**: system-auditor agent available for deployment
- [ ] **Context Access**: Full access to docs/, commands/, and agents/ directories

### Execution Methodology

#### Phase 1: Rule Discovery
1. **Scan CLAUDE.md** for explicit enforcement requirements
2. **Examine principle files** for mandatory implementation directives
3. **Review workflow phases** for enforcement checkpoints
4. **Catalog agent selection** rules and requirements

#### Phase 2: Implementation Analysis
1. **Workflow enforcement** - Check if workflow phases enforce rules
2. **Agent deployment** - Verify agent selection follows specialization requirements
3. **Ticket generation** - Validate missing capability detection and ticket creation
4. **Conversation termination** - Confirm enforcement triggers termination when required

#### Phase 3: Gap Identification
1. **Rule vs. Reality** - Compare defined rules with actual implementation
2. **Enforcement Mechanisms** - Identify missing enforcement automation
3. **Compliance Failures** - Document where rules are bypassed
4. **Implementation Blockers** - Analyze why enforcement isn't happening

#### Phase 4: Solution Design
1. **Enforcement Architecture** - Design implementation mechanisms
2. **Agent Requirements** - Identify missing enforcement agents
3. **Workflow Integration** - Plan enforcement checkpoints in workflow
4. **Automation Strategy** - Design systematic enforcement triggers

## Success Criteria

- [ ] **Complete Rule Inventory**: All framework enforcement requirements cataloged
- [ ] **Gap Documentation**: All implementation gaps identified and documented
- [ ] **Root Cause Analysis**: Underlying causes of enforcement failures analyzed
- [ ] **Implementation Plan**: Actionable plan for closing enforcement gaps
- [ ] **Agent Requirements**: Missing enforcement agents identified for creation
- [ ] **Priority Classification**: Gaps classified by severity and impact

## Output Structure

### Executive Summary
- Critical enforcement gaps count and severity
- Framework compliance percentage
- Implementation priority recommendations

### Detailed Analysis
1. **Rule Inventory** - Complete list of enforcement requirements
2. **Gap Matrix** - Rule vs. implementation status mapping
3. **Impact Assessment** - Risk analysis for each gap
4. **Implementation Roadmap** - Step-by-step closure plan

### Actionable Deliverables
- Immediate enforcement fixes (< 1 hour)
- Agent creation tickets for missing enforcement capabilities
- Workflow modification requirements
- Automation implementation tasks

## Integration Points

### Related Commands
- **[system-audit.md](system-audit.md)** - Broader system analysis
- **[1-clarify.md](../workflow/1-clarify.md)** - Workflow enforcement entry point
- **[create-ticket.md](../management/create-ticket.md)** - Generate enforcement agent tickets

### Related Agents
- **system-auditor** - Primary execution agent
- **agent-creator** - Create missing enforcement agents
- **validation-engineer** - Validate enforcement implementation

### Framework Integration
- **CLAUDE.md enforcement rules** - Source of truth for requirements
- **Agent selection principles** - Specialization enforcement requirements
- **Workflow methodology** - Enforcement checkpoint integration

## Validation Protocols

### Pre-Execution Validation
- [ ] **Input Validation**: Parameters valid and scope achievable
- [ ] **Resource Validation**: Required agents and commands accessible
- [ ] **Context Validation**: Framework documentation complete and current
- [ ] **Authority Validation**: CLAUDE.md enforcement rules accessible

### Execution Validation
- [ ] **Process Compliance**: Systematic gap analysis methodology followed
- [ ] **Coverage Validation**: All enforcement requirements analyzed
- [ ] **Quality Standards**: Root cause analysis completed for major gaps
- [ ] **Evidence Collection**: Implementation gaps documented with evidence

### Post-Execution Validation
- [ ] **Completeness Verification**: All scope areas analyzed thoroughly
- [ ] **Actionability Validation**: Deliverables provide clear implementation path
- [ ] **Priority Accuracy**: Gap severity classifications validated
- [ ] **Integration Readiness**: Output ready for workflow and agent integration

## Usage Examples

```bash
# Comprehensive workflow enforcement analysis
enforcement-gap-analysis --scope workflow --depth comprehensive

# Agent selection enforcement gaps
enforcement-gap-analysis --scope agents --focus specialization --output detailed

# Full framework enforcement audit
enforcement-gap-analysis --scope all --depth root-cause --output actionable

# Quick ticket generation enforcement check
enforcement-gap-analysis --scope tickets --depth surface --output summary
```

## Expected Outcomes

1. **Clear enforcement gaps** identified across framework components
2. **Missing agent requirements** documented for creation
3. **Workflow enhancement plan** for enforcement integration
4. **Automation roadmap** for systematic rule enforcement
5. **Compliance dashboard** showing framework adherence status

[⬆ Return to top](#enforcement-gap-analysis)