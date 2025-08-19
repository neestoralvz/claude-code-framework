
# Ticket MOD-002: Extract Principle Reference Pattern

## Problem
Principle reference patterns (⏺ **Principle**:) are duplicated across 39 files with 95% structural similarity, creating maintenance burden and potential inconsistencies.

## Impact
- **Scope**: 39 files across commands/, docs/, and agents/ directories
- **Users**: Documentation maintainers and principle implementers
- **Severity**: HIGH - Principle relationships are core to system architecture

## Solution
Extract principle reference pattern to reusable template component for consistent principle relationship statements.

## Implementation Steps
1. Catalog all existing principle reference patterns across 39 files
2. Create standardized principle reference template in docs/templates/components/
3. Define template variables for principle file, section, and relationship type
4. Update all affected files to use consistent pattern
5. Validate principle reference accuracy and completeness

## Acceptance Criteria
- [x] Template created for principle reference patterns
- [x] All 39 files use consistent principle reference format
- [x] Template supports different relationship types (implements, applies, follows)
- [x] All principle references link to valid principle files
- [x] Pattern is documented for future use

## Files Affected
- Commands: index.md, create-ticket.md, modularize.md, review-tickets.md
- Docs: Various component and principle files (35 additional files)
- Target template: docs/templates/components/principle-reference-template.md

## Notes
Generated from modularization analysis: "Extract duplicate principle reference patterns"
