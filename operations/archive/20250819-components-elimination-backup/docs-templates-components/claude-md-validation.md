
[Previous: claude-md-generation.md](claude-md-generation.md) | [Return: claude-md-base-template.md](claude-md-base-template.md)

# CLAUDE.MD VALIDATION COMPONENT

⏺ **Principle**: This component ensures [claude-md-base-template.md](claude-md-base-template.md) quality standards.

## CLAUDE.md Quality Checklist
```markdown
## Pre-Implementation Validation
- [ ] Project-specific focus confirmed
- [ ] All commands verified functional
- [ ] Structure follows operational framework
- [ ] Length under 200 lines
- [ ] No abstract framework creation
- [ ] Integration points clearly defined

## Post-Implementation Validation
- [ ] Enhances development workflow
- [ ] No conflicts with core functionality
- [ ] All paths and commands work correctly
- [ ] Team members understand immediately
- [ ] Regular maintenance plan established
```

## Integration Testing
```bash
# Test CLAUDE.md integration
echo "Testing CLAUDE.md integration..."

# Verify framework references
grep -q "docs/principles/workflow.md" CLAUDE.md || echo "Missing workflow reference"
grep -q "commands/" CLAUDE.md || echo "Missing commands reference"
grep -q "agents/" CLAUDE.md || echo "Missing agents reference"

# Test command paths
if [ -f "commands/analyze-file.md" ]; then
    echo "✓ Commands directory accessible"
else
    echo "✗ Commands directory not found"
fi

# Validate project-specific paths
TEST_COMMAND=$(grep "TEST_COMMAND" CLAUDE.md | cut -d: -f2 | tr -d ' ')
if command -v "$TEST_COMMAND" >/dev/null 2>&1; then
    echo "✓ Test command available: $TEST_COMMAND"
else
    echo "✗ Test command not found: $TEST_COMMAND"
fi
```

## Benefits
- **Rapid Setup**: Generate project-specific CLAUDE.md files quickly
- **Framework Alignment**: Automatic integration with operational framework
- **Consistency**: Standardized structure across all project types
- **Validation**: Built-in quality checks and testing
- **Maintainability**: Template-based approach enables easy updates

## Cross-References
- [Follow claude-md-base-template.md for foundation](claude-md-base-template.md)
- [Use claude-md-project-variants.md for project types](claude-md-project-variants.md)
- [Apply claude-md-generation.md for automation](claude-md-generation.md)
