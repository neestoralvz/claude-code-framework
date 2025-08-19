# Principle Marker Template

## Standard Format

⏺ **Principle**: This [component/section] implements [principle-name.md](path/to/principle.md) by [specific application] and applies [secondary-principle.md](path/to/principle.md) through [method].

## Format Components

### Required Elements
1. **Marker Symbol**: ⏺ (Unicode: U+23FA)
2. **Label**: **Principle** (bold formatting)
3. **Colon**: : (space after colon)
4. **Implementation Statement**: This [component/section] implements [principle-name.md](path/to/principle.md)
5. **Application Method**: by [specific application]

### Optional Elements
6. **Secondary Reference**: and applies [secondary-principle.md](path/to/principle.md)
7. **Method Description**: through [method]

## Reference Format Standards

### Link Format
- Use markdown link format: `[principle-name.md](path/to/principle.md)`
- Include .md extension in link text
- Use relative paths from current file location
- Include anchor links for specific sections: `[principle-name.md#section](path/to/principle.md#section)`

### Path Standards
- Commands to principles: `../docs/principles/`
- Components to principles: `../principles/`
- Within principles directory: `./` or just filename
- Cross-component references: use relative paths

## Usage Examples

### Command Implementation
```markdown
⏺ **Principle**: This command implements [workflow.md](../docs/principles/workflow.md) through systematic execution phases and applies [engineering.md](../docs/principles/engineering.md) for quality validation.
```

### Component Implementation
```markdown
⏺ **Principle**: This component implements [organization.md](../principles/organization.md) by providing hierarchical structure patterns and applies [formatting.md](../principles/formatting.md) through consistent presentation standards.
```

### Single Principle Reference
```markdown
⏺ **Principle**: This section implements [fundamental.md](../principles/fundamental.md) by emphasizing simplicity and evidence-based approaches.
```

### Principle Cross-Reference
```markdown
⏺ **Principle**: These patterns implement [directive.md execution rules](../principles/directive.md#execution-rules) for systematic principle application.
```

## Validation Rules

### Required Checks
- [ ] Marker symbol ⏺ present
- [ ] "**Principle**:" format correct
- [ ] At least one principle reference present
- [ ] All links use proper markdown format
- [ ] Relative paths correct from file location
- [ ] Implementation description specific and actionable

### Quality Standards
- [ ] Describes HOW the principle is implemented
- [ ] Links to specific principle sections when relevant
- [ ] Uses active voice ("implements", "applies", "follows")
- [ ] Maintains consistency with principle intent
- [ ] Provides clear connection between content and principle

## Common Patterns

### Authority References
```markdown
⏺ **Principle**: Load order per [CLAUDE.md authoritative sequence](../../CLAUDE.md#phase-2-apply-principles-in-load-order)
```

### Methodology Implementation
```markdown
⏺ **Principle**: This methodology implements [workflow.md systematic phases](../principles/workflow.md) by providing structured execution patterns.
```

### Framework Application
```markdown
⏺ **Principle**: This framework implements [agent-selection.md](../principles/agent-selection.md) for MANDATORY agent-first execution.
```

## Anti-Patterns to Avoid

### Incorrect Formats
❌ `• **Principle**:` (wrong symbol)
❌ `⏺ Principle:` (not bold)
❌ `⏺ **Principle**` (missing colon)
❌ `⏺ **Principle**:Implements` (missing space after colon)

### Poor References
❌ `[workflow](../docs/principles/workflow.md)` (missing .md in link text)
❌ `[workflow.md](workflow.md)` (incorrect relative path)
❌ `workflow.md` (not a link)
❌ `[some principle]()` (empty link)

### Weak Descriptions
❌ "This follows principles" (vague)
❌ "Uses workflow principle" (no implementation detail)
❌ "Based on organization" (passive voice)

## Template Variables

Replace these placeholders with specific content:

- `[component/section]`: command, component, section, framework, etc.
- `[principle-name.md]`: actual principle filename
- `[path/to/principle.md]`: correct relative path
- `[specific application]`: how the principle is implemented
- `[method]`: the mechanism or approach used
- `[secondary-principle.md]`: optional additional principle reference

## Cross-References

- [Apply formatting.md standards](../principles/formatting.md)
- [Follow organization.md patterns](../principles/organization.md)
- [Use communication.md tone](../principles/communication.md)