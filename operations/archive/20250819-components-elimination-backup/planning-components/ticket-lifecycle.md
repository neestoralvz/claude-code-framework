
# Ticket Lifecycle Management

⏺ **Principle**: Implements [workflow.md](../../docs/principles/workflow.md) through systematic phase progression and state management for lifecycle control.

## Overview

The ticket lifecycle defines four distinct phases that every ticket progresses through, from creation to archival.

## Phase 1: Creation
```
pending/ → New ticket created with metadata
```

**Required Fields**:
- `ticket_id`: Unique identifier (e.g., MOD-001)
- `title`: Descriptive title (60 chars max)
- `priority`: HIGH | MEDIUM | LOW
- `status`: pending (initial)
- `created`: Creation date (YYYY-MM-DD)
- `category`: Classification (e.g., modularization, feature, bug)
- `estimated_effort`: Time estimate

**Required Sections**:
- Problem statement
- Impact analysis
- Solution approach
- Implementation steps
- Acceptance criteria
- Dependencies

## Phase 2: Activation
```
pending/ → in-progress/ (Status: in-progress)
```

**Triggers**:
- Work begins on ticket
- Resources allocated
- Developer assigned

**Actions**:
1. Update status to `in-progress`
2. Add `started` timestamp
3. Move file to `in-progress/` directory
4. Update registry

## Phase 3: Completion
```
in-progress/ → completed/ (Status: completed)
```

**Requirements**:
- All acceptance criteria met
- Implementation verified
- Documentation updated
- Tests passing (if applicable)

**Actions**:
1. Update status to `completed`
2. Add `completed` timestamp
3. Move file to `completed/` directory
4. Document implementation notes
5. Update registry

## Phase 4: Archival
```
completed/ → archived/ (After 30 days)
```

**Process**:
- Automated monthly archival
- Maintains historical record
- Reduces active registry size

[Return to TICKET_METHODOLOGY.md](../TICKET_METHODOLOGY.md)
