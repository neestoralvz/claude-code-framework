
# Ticket: Extract Agent Template Structure

## Problem
Agent template sections duplicated across 4 agent files with 90% structural similarity.

## Impact
- **Lines affected**: ~300 lines
- **Files affected**: 4 agent files
- **Duplication rate**: 90%

## Current Pattern
- Identical YAML frontmatter structure
- Repeated "Core Responsibilities" format (5 numbered items)
- Identical "Operational Framework" section structure
- Repeated "Quality Assurance Protocol" format
- Identical "Decision Principles" structure

## Solution
Create modular agent components for reusable sections.

## Implementation Steps
1. Create `/agents/templates/components/` directory
2. Extract common components:
   - `agent-frontmatter.yaml`
   - `core-responsibilities-template.md`
   - `operational-framework-template.md`
   - `qa-protocol-template.md`
   - `decision-principles-template.md`
3. Define agent-specific customization points
4. Update agent files to use components
5. Remove duplicated sections

## Expected Benefits
- Eliminate 300 lines of duplication
- Ensure agent consistency
- Standardize agent structure
- Simplify agent creation

## Acceptance Criteria
- [x] Components directory created
- [x] All templates extracted (8 component files)
- [x] Agent files maintain structure
- [x] No structural duplication remains
- [x] Agents function correctly

## Dependencies
- Coordinate with AGENT_TEMPLATE.md
- Maintain agent functionality

## Notes
Medium complexity extraction requiring careful parameterization.
