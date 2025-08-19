
# Ticket: Extract Metadata Header Templates

## Problem
YAML frontmatter headers duplicated across all 23 documentation files with 95% similarity.

## Impact
- **Lines affected**: ~220 lines
- **Files affected**: 23 files (100% coverage)
- **Duplication rate**: 95%

## Current Pattern
```yaml
title: "Document Title"
author: "System/Claude Code System"
date: "2025-01-18"
version: "1.0.0"
dependencies: [various]
audience: [various]
purpose: [specific]
keywords: [list]
last_review: [date]
```

## Solution
Create modular metadata templates with type-specific variants.

## Implementation Steps
1. Create `/docs/templates/metadata-template.yaml` base template
2. Create `/docs/templates/metadata-variants/` directory
3. Add variant templates:
   - `principle-metadata.yaml`
   - `command-metadata.yaml`
   - `agent-metadata.yaml`
   - `documentation-metadata.yaml`
4. Update all files to reference templates
5. Remove duplicated metadata blocks

## Expected Benefits
- Eliminate 220 lines of duplication
- Ensure metadata consistency
- Enable single-point updates
- Reduce maintenance overhead by 60%

## Acceptance Criteria
- [x] Base template created
- [x] All variants defined
- [ ] Files updated to use templates
- [ ] No metadata duplication remains
- [ ] All files validate correctly

## Implementation Notes
- Created base template at `/docs/templates/metadata-template.yaml`
- Created variant templates in `/docs/templates/metadata-variants/`:
  - `principle-metadata.yaml`
  - `command-metadata.yaml`
  - `agent-metadata.yaml`
  - `documentation-metadata.yaml`
- Templates ready for use in file updates

## Dependencies
None - can be implemented immediately

## Notes
First priority extraction due to universal benefit and zero risk.
