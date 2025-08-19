
# Ticket: Fix Non-Imperative Communication Violations (25+ Instances)

## Problem

Extensive use of non-imperative communication throughout system documentation violates communication.md principles and creates weak, passive guidance instead of direct commands.

**Non-Imperative Patterns Identified**:

1. **Conditional Language** (should, would, could, might, may):
   - "should evolve with project requirements" → "evolve with project requirements"
   - "You should run tests" → "Run tests"
   - "Tests should be run" → "Run tests"
   - "You might want to" → "Execute"

2. **Passive Voice Constructions**:
   - "can be used" → "use"
   - "will be provided" → "provides"
   - "is recommended" → "recommend" or imperative alternative
   - "it is advisable" → direct imperative

3. **Weak Suggestion Language**:
   - "this allows" → "use to"
   - "this provides" → direct action
   - "this enables" → direct capability statement
   - "there are options" → "choose from"

4. **Question-Based Guidance**:
   - "Why should I click?" → imperative alternative
   - Rhetorical questions instead of direct statements

## Impact

- **Scope**: System-wide communication effectiveness and user guidance clarity
- **Users**: All developers and system operators following documentation
- **Severity**: HIGH - Undermines authoritative guidance and creates hesitant, unclear instructions

**Specific Issues**:
1. **Weakened Authority**: Non-imperative language reduces documentation authority
2. **User Confusion**: Conditional language creates uncertainty about required vs. optional actions
3. **Principle Violation**: Directly contradicts communication.md imperative standards
4. **Inconsistent Tone**: Mixes imperative and non-imperative styles

## Solution

Systematically convert all non-imperative language to imperative commands throughout documentation:

1. **Replace Conditional Verbs**: Convert should/would/could/might to direct imperatives
2. **Eliminate Passive Voice**: Convert passive constructions to active imperatives
3. **Strengthen Weak Language**: Replace suggestion language with commands
4. **Standardize Tone**: Ensure consistent imperative communication

## Implementation Steps

1. **Comprehensive Pattern Search**
   - Search all documentation files for non-imperative patterns
   - Document specific instances by file and line number
   - Categorize violations by type (conditional, passive, weak, etc.)

2. **Create Conversion Rules**
   - "should X" → "X" (remove conditional)
   - "can be used" → "use"
   - "it is recommended" → "recommended:" or direct imperative
   - "this allows you to" → "use to" or direct capability

3. **Systematic File Updates**
   - **docs/principles/formatting.md**: Fix "Why should I click?" and related
   - **docs/principles/claude-md.md**: Fix multiple should/would instances
   - **docs/templates/components/**: Review all component files for violations
   - **docs/agents-documentation/**: Fix passive language in agent guidance

4. **Validate Imperative Compliance**
   - Verify all commands are direct and actionable
   - Ensure consistent authoritative tone
   - Check for remaining conditional language

5. **Update Style Guidelines**
   - Strengthen communication.md with specific examples
   - Add validation tests for imperative compliance
   - Create clear conversion examples

## Acceptance Criteria

- [ ] Zero instances of "should", "would", "could", "might", "may" in directive contexts
- [ ] No passive voice constructions in instructional content
- [ ] All guidance uses direct imperative commands
- [ ] Consistent authoritative tone throughout documentation
- [ ] User instructions are clear and unambiguous
- [ ] Communication.md standards fully implemented
- [ ] All files pass imperative communication validation
- [ ] Examples demonstrate proper imperative style

## Dependencies

None - this is a content revision task that can be completed independently.

## Notes

Generated from high-priority system audit finding. Imperative communication is fundamental to authoritative documentation.

**Common Conversion Patterns**:
- "You should run X" → "Run X"
- "Tests should be executed" → "Execute tests"
- "This can be used to" → "Use to"
- "It is recommended to" → "Recommended:"
- "You might want to consider" → "Consider"
- "This allows you to" → "Use to"

**Files Requiring Major Updates**:
- `docs/principles/formatting.md` - Link guidance and structure rules
- `docs/principles/claude-md.md` - Multiple instruction examples
- `docs/templates/components/communication-templates.md` - Template language
- `docs/agents-documentation/AGENTS_ONLY.md` - Directory enforcement

**Validation Tests**:
1. Search for remaining conditional verbs
2. Check for passive voice patterns
3. Verify all instructions are actionable commands
4. Confirm consistent imperative tone

**Principle Violations**:
- Violates [communication.md] by using non-imperative language
- Violates [directive.md] by providing weak instead of authoritative guidance
- Violates [fundamental.md] by creating ambiguous instead of clear instructions
