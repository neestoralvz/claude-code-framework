---
title: Extract Workflow Phase Structure
ticket_id: MOD-003
priority: HIGH
status: resolved
created: 2025-01-18
category: modularization
estimated_effort: 3 hours
resolved: 2025-01-18
---

# Ticket: Extract Workflow Phase Structure

## Problem
Eight-phase workflow structure duplicated across all 5 command files with 95% identical content.

## Impact
- **Lines affected**: ~200 lines
- **Files affected**: 5 command files
- **Duplication rate**: 95%

## Current Pattern
```markdown
## Execution Phases

### 1. Clarification
- Confirm specific aspect
- Verify parameter
- Validate target

### 2. Exploration
- Search action
- Read action
- Map action

### 3. Analysis
[continues through 8 phases]

### 8. Recursion
- Validate changes
- Fix issues
- Return to clarification if needed
```

## Solution
Create centralized workflow phase module with command-specific customization.

## Implementation Steps
1. Create `/docs/components/workflow-phases.md`
2. Define standard 8-phase structure:
   - Clarification
   - Exploration
   - Analysis
   - Planning
   - Implementation
   - Ripple Effect
   - Validation
   - Recursion
3. Create parameterized phase descriptions
4. Add command-specific workflow variants
5. Update command files to reference workflow module
6. Remove duplicated phase definitions

## Expected Benefits
- Eliminate 200 lines of duplication
- Ensure workflow consistency
- Enable single-point workflow updates
- Standardize command execution

## Acceptance Criteria
- [x] Workflow module created
- [x] All 8 phases defined
- [x] Command variants documented
- [x] Command files updated
- [x] Phase references work correctly

## Dependencies
- Requires coordination with command files
- Must maintain backward compatibility

## Notes
Critical for command consistency and major duplication elimination.