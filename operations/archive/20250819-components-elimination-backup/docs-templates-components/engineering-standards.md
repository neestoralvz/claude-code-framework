
[Previous: workflow-phases.md](workflow-phases.md) | [Hub](../philosophy/index.md) | [Next: directive-implementation.md](directive-implementation.md)

# ENGINEERING STANDARDS

⏺ **Principle**: Implements [engineering.md](../../principles/engineering.md) through concrete standards and quality protocols.

## Testing Standards

### Test Protocol
1. Execution verification
2. Output validation
3. Edge case testing
4. Integration testing

### Test Commands
```bash
npm test                # Node.js
python -m pytest       # Python
cargo test             # Rust
go test ./...          # Go
```

### Quality Gates
- All tests pass
- 80% code coverage minimum
- No critical linting violations
- Security scan clear

## Quality Standards

### Core Principles
- **SOLID**: Single responsibility, Open/Closed, Liskov substitution, Interface segregation, Dependency inversion
- **DRY**: Extract common patterns, avoid duplication
- **YAGNI**: Implement only required functionality

## Development Workflow

### Standard Phases
1. Requirements → 2. Design → 3. Implementation → 4. Testing → 5. Quality review → 6. Documentation → 7. Integration → 8. Deployment

### Code Review Checklist
- [ ] Follows SOLID, DRY, YAGNI principles
- [ ] Includes tests with good coverage
- [ ] Documentation updated
- [ ] No security vulnerabilities
- [ ] Consistent with patterns
- [ ] Error handling implemented

## Templates

### Component Template
```markdown
title: "[Component Name]"
# [COMPONENT NAME]
⏺ **Principle**: Implements [principle.md].
[Details...]
```

### Test Template
```javascript
describe('[Component]', () => {
  it('should [behavior]', () => {
    // Test implementation
  });
});
```

## Quality Assurance

### Automated Checks
- Linting, type checking, security scanning, performance testing, documentation validation

### CI Requirements
- All checks pass, coverage thresholds met, security clear, docs build successfully

## Benefits
- **Consistency**: Uniform development standards
- **Quality**: High-quality code through systematic standards
- **Maintainability**: Clear patterns for maintenance
- **Reliability**: Comprehensive testing reduces defects

## Cross-References
- [Hub](../philosophy/index.md) | [PRINCIPLES.md](principles/PRINCIPLES.md) | [README.md](README.md)
- [engineering.md](../../principles/engineering.md) | [workflow-phases.md](workflow-phases.md)
