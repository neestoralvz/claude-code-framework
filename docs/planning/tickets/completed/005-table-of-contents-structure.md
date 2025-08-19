---
title: Extract Table of Contents Structure
ticket_id: MOD-005
priority: HIGH
status: completed
created: 2025-01-18
completed: 2025-08-18
category: modularization
estimated_effort: 1.5 hours
actual_effort: 45 minutes
---

# Ticket: Extract Table of Contents Structure

## Problem
Table of contents patterns duplicated across 20 files with 80% structural similarity.

## Impact
- **Lines affected**: ~160 lines
- **Files affected**: 20 files
- **Duplication rate**: 80%

## Current Pattern
```markdown
## Table of Contents
  - [Problem](#problem)
  - [Impact](#impact)
  - [Current Pattern](#current-pattern)
  - [Solution](#solution)
  - [Implementation Steps](#implementation-steps)
  - [Expected Benefits](#expected-benefits)
  - [Acceptance Criteria](#acceptance-criteria)
  - [Dependencies](#dependencies)
  - [Notes](#notes)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Solution
Create standardized TOC generator and patterns.

## Implementation Steps
1. Create `/docs/templates/templates/components/toc-generator.md`
2. Define TOC patterns by document type:
   - Command TOC pattern
   - Principle TOC pattern
   - Agent TOC pattern
   - Documentation TOC pattern
3. Create auto-generation guidelines
4. Standardize TOC formatting rules
5. Update files to use TOC patterns

## Expected Benefits
- Eliminate 160 lines of duplication
- Standardize TOC format
- Reduce maintenance overhead
- Enable consistent navigation

## Acceptance Criteria
- [ ] TOC generator created
- [ ] Patterns defined for all types
- [ ] Guidelines documented
- [ ] Files updated to use patterns
- [ ] TOCs render correctly

## Dependencies
None - can be implemented independently

## Notes
Improves document navigation and maintenance.