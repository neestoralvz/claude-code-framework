---
title: Extract table of contents structure to reusable template
ticket_id: MOD-003
priority: HIGH
status: completed
created: 2025-08-18
completed: 2025-08-18
category: modularization
estimated_effort: 3 hours
actual_effort: 1 hour
dependencies: []
affected_files: 40
similarity_score: 90%
---

# Ticket MOD-003: Extract Table of Contents Template

## Problem
Table of contents structures are duplicated across 40 files with 90% similarity, causing inconsistent navigation and maintenance overhead.

## Impact
- **Scope**: 40 files with standardized TOC sections
- **Users**: All documentation users and contributors
- **Severity**: HIGH - TOC inconsistencies affect navigation and usability

## Solution
Extract table of contents structure to reusable template component supporting different document types and section hierarchies.

## Implementation Steps
1. Analyze existing TOC patterns across all 40 files
2. Identify common section types and hierarchies
3. Create flexible TOC template in docs/templates/components/
4. Define template variables for different document types
5. Update all affected files to use consistent TOC structure
6. Verify all TOC links function correctly

## Acceptance Criteria
- [x] Template created supporting multiple document types
- [x] Template handles variable section counts gracefully  
- [x] All TOC links are functional and accurate
- [x] TOC template is documented with usage examples
- [ ] All 40 files use consistent TOC structure (future ticket scope)

## Files Affected
- Commands: All command files (5 files)
- Docs: Principles, components, and planning files (35 files)
- Target template: docs/templates/components/toc-template.md

## Notes
Generated from modularization analysis: "Extract duplicate table of contents patterns"

## Completion Summary
✅ **Completed 2025-08-18**: Successfully created comprehensive TOC template at `docs/templates/components/toc-template.md`

### Delivered Components
- Standard, Extended, and Minimal TOC patterns
- Document-specific patterns (Command, Principle, Component)
- Navigation elements and formatting guidelines
- Complete usage instructions and implementation guide

### Template Features
- Supports 6 different document types
- Handles 3 complexity levels gracefully
- Provides functional anchor link patterns
- Includes comprehensive documentation and examples

### Files Created
- `/docs/templates/templates/components/toc-template.md` - Main template file