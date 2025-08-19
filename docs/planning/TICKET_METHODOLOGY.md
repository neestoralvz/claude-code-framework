---
title: "Ticket Management Methodology"
author: "Claude Code System"
date: "2025-08-18"
version: "2.0.0"
dependencies: ["principles/PRINCIPLES.md", "TICKET_REGISTRY.md"]
prerequisites: ["Understanding of project structure", "Familiarity with ticket lifecycle"]
audience: "Project managers, developers, and system administrators"
purpose: "Define standardized methodology for creating, managing, and tracking tickets throughout their lifecycle"
keywords: ["tickets", "methodology", "workflow", "management", "tracking", "lifecycle", "status"]
last_review: "2025-08-18"
---

[Previous: Study index.md for navigation](../index.md) | [Return to hub for navigation](../index.md) | [Review PRINCIPLES.md for framework](principles/PRINCIPLES.md) | [Next: Access TICKET_REGISTRY.md for dashboard](TICKET_REGISTRY.md)

# TICKET MANAGEMENT METHODOLOGY

## Table of Contents
  - [Purpose](#purpose)
  - [Core Principles](#core-principles)
- [1. Single Source of Truth](#1-single-source-of-truth)
- [2. Clear Lifecycle](#2-clear-lifecycle)
- [3. Actionable Definition](#3-actionable-definition)
  - [Ticket Lifecycle](#ticket-lifecycle)
  - [Ticket Structure](#ticket-structure)
- [Standard Template](#standard-template)
  - [Problem](#problem)
  - [Impact](#impact)
  - [Solution](#solution)
  - [Implementation Steps](#implementation-steps)
  - [Acceptance Criteria](#acceptance-criteria)
  - [Dependencies](#dependencies)
  - [Notes](#notes)
  - [Priority and Classification](#priority-and-classification)
  - [Status Management](#status-management)
- [Status Transitions](#status-transitions)
- [Status Commands](#status-commands)
  - [Workflow Integration](#workflow-integration)
- [Daily Workflow](#daily-workflow)
- [Weekly Review](#weekly-review)
  - [Automation Tools](#automation-tools)
- [Registry Update](#registry-update)
- [Bulk Operations](#bulk-operations)
- [Status Monitoring](#status-monitoring)
  - [Best Practices](#best-practices)
- [DO](#do)
- [DON'T](#don-t)
  - [Metrics and Reporting](#metrics-and-reporting)
- [Key Metrics](#key-metrics)
- [Reports](#reports)
  - [Integration and Support](#integration-and-support)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Purpose

⏺ **Principle**: This methodology implements [organization.md](../principles/organization.md) by providing systematic structure for ticket management and applies [workflow.md](../principles/workflow.md) through defined lifecycle phases.

Define standardized methodology for creating, managing, and tracking tickets throughout their lifecycle, ensuring consistent project execution and progress tracking.

## Core Principles

### 1. Single Source of Truth
⏺ **Principle**: Follows [fundamental.md](../principles/fundamental.md) by maintaining one authoritative location for all ticket information through centralized registry patterns.
- All tickets stored in `/docs/planning/tickets/`
- Registry dashboard provides unified view
- Status changes reflected immediately

### 2. Clear Lifecycle
⏺ **Principle**: Implements [workflow.md](../principles/workflow.md) through systematic phase progression and state management for lifecycle control.
- **Pending** → **In Progress** → **Completed**
- Alternative paths: **Blocked**, **Cancelled**
- Each transition documented with timestamps

### 3. Actionable Definition
⏺ **Principle**: Applies [communication.md](../principles/communication.md) by requiring clear, measurable, and implementable ticket definitions through imperative specifications.
- Every ticket must have clear acceptance criteria
- Measurable outcomes required
- Implementation steps defined

## Ticket Lifecycle

⏺ **Principle**: Implements [workflow.md](../principles/workflow.md) through systematic phase progression for structured execution.

Tickets progress through four phases: **Creation** → **Activation** → **Completion** → **Archival**

**📋 [View complete lifecycle documentation](templates/components/ticket-lifecycle.md)**

## Ticket Structure

### Standard Template
```markdown
---
title: [Clear, Actionable Title]
ticket_id: [CATEGORY-###]
priority: [HIGH|MEDIUM|LOW]
status: [pending|in-progress|completed|blocked]
created: YYYY-MM-DD
category: [classification]
estimated_effort: [time estimate]
---

# Ticket: [Full Title]

## Problem
[Clear problem statement]

## Impact
- **Scope**: [What's affected]
- **Users**: [Who's impacted]
- **Severity**: [Critical|Major|Minor]

## Solution
[Proposed solution approach]

## Implementation Steps
1. [Step 1]
2. [Step 2]
3. [Step n]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion n

## Dependencies
- [List dependencies or "None"]

## Notes
[Additional context]
```

## Priority and Classification

⏺ **Principle**: Follows [organization.md](../principles/organization.md) for systematic classification through hierarchical structure patterns.

Priority levels: **HIGH** (critical impact) | **MEDIUM** (important functionality) | **LOW** (nice-to-have)

Core categories: bug, feature, enhancement, refactor, documentation, performance, security, modularization

**📊 [View complete classification guide](templates/components/ticket-classification.md)**

[⬆ Return to top](#ticket-management-methodology)

## Status Management

### Status Transitions
```
pending ──────→ in-progress ──────→ completed
   ↓                 ↓                    ↓
blocked ←────────────┘                archived
   ↓
cancelled
```

### Status Commands
```bash
# Update ticket status
./scripts/manage-ticket-status.sh [TICKET-ID] [NEW-STATUS]

# Examples
./scripts/manage-ticket-status.sh MOD-001 in-progress
./scripts/manage-ticket-status.sh MOD-001 completed
./scripts/manage-ticket-status.sh MOD-002 blocked
```

## Workflow Integration

⏺ **Principle**: Integrates [workflow.md](../principles/workflow.md) by embedding ticket management into daily and weekly operational rhythms through systematic execution patterns.

### Daily Workflow
1. **Morning Review**
   - Check registry dashboard
   - Review in-progress tickets
   - Identify blockers

2. **Work Session**
   - Select ticket from pending
   - Update status to in-progress
   - Implement solution
   - Update progress notes

3. **End of Session**
   - Update ticket status
   - Document progress
   - Update registry

### Weekly Review
- Analyze velocity metrics
- Review blocked tickets
- Prioritize upcoming work
- Archive completed tickets

[⬆ Return to top](#ticket-management-methodology)

## Automation Tools

### Registry Update
```bash
# Automatic registry synchronization
./scripts/update-ticket-registry.sh
```

### Bulk Operations
```bash
# Move all completed tickets older than 30 days
./scripts/archive-old-tickets.sh

# Generate status report
./scripts/generate-ticket-report.sh weekly
```

### Status Monitoring
```bash
# Check for stale in-progress tickets
./scripts/check-stale-tickets.sh

# Alert on blocked tickets
./scripts/monitor-blocked.sh
```

## Best Practices

⏺ **Principle**: These practices implement [engineering.md](../principles/engineering.md) through systematic quality control and [communication.md](../principles/communication.md) via clear documentation requirements.

### DO
- ✅ Create tickets for all non-trivial work
- ✅ Update status immediately when changing
- ✅ Include clear acceptance criteria
- ✅ Document blockers and dependencies
- ✅ Link related tickets
- ✅ Add implementation notes when completing

### DON'T
- ❌ Leave tickets in progress indefinitely
- ❌ Create duplicate tickets
- ❌ Skip status updates
- ❌ Ignore dependencies
- ❌ Complete without verification
- ❌ Delete tickets (archive instead)

[⬆ Return to top](#ticket-management-methodology)

## Metrics and Reporting

### Key Metrics
- **Velocity**: Tickets completed per week
- **Cycle Time**: Average time from start to completion
- **Blocked Rate**: Percentage of blocked tickets
- **Priority Distribution**: Breakdown by priority
- **Category Distribution**: Breakdown by type

### Reports
- Daily status summary
- Weekly velocity report
- Monthly trend analysis
- Quarterly retrospective

## Integration and Support

Integration with documentation, version control, and CI/CD systems ensures seamless workflow.

**🔗 [View complete integration guide](templates/components/ticket-integration.md)**

[⬆ Return to top](#ticket-management-methodology)