
# Ticket: Extract Navigation Breadcrumb Patterns

## Problem
Navigation breadcrumbs repeated across 18 files with 90% structural similarity.

## Impact
- **Lines affected**: ~50 lines
- **Files affected**: 18 files
- **Duplication rate**: 90%

## Current Pattern
```markdown
## Navigation
[Documentation Hub](../../../docs/index.md) | [Principles](../docs/PRINCIPLES.md) | [Commands](../../../docs/index.md) | [Agents](../../../agents/project-management/coordination/project-optimizer.md)

[Previous: X](file.md) | [Index](../../../docs/index.md) | [Principles](principles/PRINCIPLES.md) | [Next: Y](file.md)
```

## Solution
Create centralized navigation component with variable substitution.

## Implementation Steps
1. Create `/docs/templates/templates/components/navigation.md`
2. Define navigation patterns with variables:
   - `{{prev}}` - previous document
   - `{{next}}` - next document
   - `{{current_section}}` - current section name
3. Create navigation variants:
   - Documentation navigation
   - Command navigation
   - Principle navigation
   - Agent navigation
4. Update all files to use navigation component
5. Remove hardcoded navigation sections

## Expected Benefits
- Eliminate 50 lines of duplication
- Ensure consistent navigation structure
- Enable dynamic navigation updates
- Improve user experience

## Acceptance Criteria
- [x] Navigation component created
- [x] Variables defined and documented
- [x] All variants implemented
- [x] Files updated to use component
- [x] Navigation works correctly

## Dependencies
None - can be implemented independently

## Notes
High visibility improvement affecting user navigation experience.
