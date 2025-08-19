---
title: "Standardize Navigation Patterns System-Wide"
ticket_id: "SYS-005"
priority: MEDIUM
status: pending
created: "2025-08-18"
category: system
estimated_effort: "3 hours"
author: "Claude Code System"
dependencies: ["SYS-001", "SYS-004"]
impact: "MEDIUM - Improves consistency and usability"
---

# Ticket: Standardize Navigation Patterns System-Wide

## Problem
Navigation patterns are inconsistent across the system, causing:

**Structural Inconsistencies:**
- Navigation patterns inconsistent across files
- Missing cross-references in critical files
- Header hierarchy problems
- Breadcrumb variations

**Compliance Failures:**
- Non-imperative headers throughout system
- Passive voice in principle files
- Missing evidence requirements

## Impact
- **Scope**: All system documentation files
- **Users**: All users navigating system documentation
- **Severity**: MEDIUM - Reduces usability and consistency
- **Learning**: Increases cognitive load for users
- **Maintenance**: Complicates system updates

## Solution
Implement standardized navigation patterns across all files:
1. Establish canonical navigation structure
2. Standardize breadcrumb patterns
3. Fix header hierarchy issues
4. Implement consistent cross-referencing

## Implementation Steps
1. **Define Navigation Standards**
   - Create canonical breadcrumb pattern
   - Establish header hierarchy rules
   - Define cross-reference formats
   - Specify link description standards

2. **Audit Current Navigation**
   - Survey all files for navigation patterns
   - Identify deviations from standards
   - Document required changes

3. **Implement Standard Patterns**
   - Update breadcrumb navigation consistently
   - Fix header hierarchy violations
   - Standardize cross-reference formats
   - Apply imperative header standards

4. **Validate Navigation Flow**
   - Test navigation paths end-to-end
   - Verify consistent user experience
   - Confirm standard compliance

## Acceptance Criteria
- [ ] All files use consistent breadcrumb patterns
- [ ] Header hierarchies follow established rules
- [ ] Cross-references use standardized formats
- [ ] All headers use imperative tone
- [ ] Navigation flow is intuitive and consistent
- [ ] Missing cross-references are added
- [ ] Link descriptions include action verbs and use cases
- [ ] Evidence requirements are present where needed

## Standard Navigation Pattern
```markdown
[Previous: Action verb for previous](previous.md) | [Return to hub](index.md) | [Study framework](PRINCIPLES.md) | [Next: Action verb for next](next.md)
```

## Header Standards
- Use imperative tone: "Execute", "Apply", "Follow"
- Include clear action context
- Maintain logical hierarchy
- Avoid passive voice

## Cross-Reference Standards
- Include action verbs: "Execute", "Apply", "Follow"
- Specify use cases: "for systematic phases"
- Use descriptive link text
- Maintain consistent format

## Dependencies
- **Depends on**: SYS-001 (Commands index must exist)
- **Depends on**: SYS-004 (System contradictions resolved)
- Must follow navigation.md patterns
- Should align with communication.md imperative tone
- Must preserve formatting.md standards

## Files Requiring Updates
- All principle files in /docs/principles/
- All command files in /commands/
- All component files in /docs/templates/templates/components/
- All agent documentation files
- Main navigation files (index.md, PRINCIPLES.md, etc.)

## Ripple Effects
- Improves overall system usability
- Reduces learning curve for new users
- Enables consistent navigation experience
- Simplifies system maintenance
- Supports better user workflow completion

## Notes
Generated from system audit finding: "Structural inconsistencies - Navigation patterns inconsistent across files, Missing cross-references in critical files, Header hierarchy problems, Principle compliance failures - Non-imperative headers throughout system"

## Validation Method
- Navigation pattern audit across all files
- Header tone verification (imperative vs passive)
- Cross-reference completeness check
- User navigation flow testing