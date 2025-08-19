
[Previous: Study code-block-standards.md for overview](code-block-standards.md) | [Return to hub for navigation](../../philosophy/index.md)

# BLOCK USAGE GUIDELINES COMPONENT

⏺ **Principle**: This component implements [formatting.md](../../../principles/formatting.md) usage standards for appropriate code block selection.

## When to Use Each Block Type

### Bash Blocks
**Use for**: Executable commands and scripts
- System commands that can be run directly
- Shell scripts for automation
- File system operations
- Git commands

**Example**:
```bash
# Actual executable command
git status && git diff
```

### Markdown Blocks
**Use for**: Documentation structure examples
- Link format demonstrations
- Heading structure examples
- Navigation pattern illustrations
- Content formatting guidelines

**Example**:
```markdown
# Documentation structure example
[Action verb + purpose](path/to/file.md#section)
```

### Language-Specific Blocks
**Use for**: Code implementations
- Function definitions
- Configuration examples
- Data structure demonstrations
- API response samples

## Block Selection Matrix

| Content Type | Block Type | Purpose |
|-------------|------------|---------|
| Commands to execute | `bash` | Direct execution |
| Documentation examples | `markdown` | Format demonstration |
| Code implementations | `language` | Code illustration |
| Configuration files | `yaml`/`json` | Structure examples |
| Data samples | `json`/`sql` | Data format examples |

## Critical Guidelines

1. **Never use bash blocks for documentation examples**
2. **Always specify language for syntax highlighting**
3. **Use markdown blocks for markdown formatting examples**
4. **Match block type to intended purpose**

[Return to code-block-standards.md](code-block-standards.md)
