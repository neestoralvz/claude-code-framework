---
title: "Code Block Standards"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../../principles/formatting.md"]
audience: "Content creators and developers"
purpose: "Standards for code block usage and language specifications"
keywords: ["code-blocks", "markdown", "documentation"]
---

[Previous: link-standards.md](link-standards.md) | [Hub](../../index.md) | [Next: ../](../)

# CODE BLOCK STANDARDS

⏺ **Principle**: Implements [formatting.md](../../principles/formatting.md) to distinguish executable code from documentation examples.

## Critical Rule
- **NEVER use bash blocks for documentation content**
- **ALWAYS use markdown blocks for documentation examples**

## Usage by Type

### Documentation Examples
```markdown
# Correct: Use markdown blocks for documentation
[Execute command.md](command.md)
## Section Headers
```

### Executable Scripts
```bash
# Correct: Only for real executable commands
echo "Processing files..."
find . -name "*.md" -exec wc -l {} \;
```

## Language Blocks

### Common Types
- **bash**: Executable shell commands only
- **markdown**: Documentation examples
- **yaml**: Configuration files
- **javascript**: JS code
- **python**: Python code
- **json**: Data structures
- **sql**: Database queries

## Selection Matrix

| Content Type | Block Type | Example |
|--------------|-----------|--------|
| Shell commands | `bash` | `npm install` |
| Documentation | `markdown` | `## Header` |
| JavaScript | `javascript` | `function test() {}` |
| Python | `python` | `def test():` |
| Config files | `yaml`/`json` | `name: "value"` |
| SQL queries | `sql` | `SELECT * FROM` |
| Plain text | `text` | `Error: File not found` |

## Validation Checklist
- [ ] Bash blocks contain only executable scripts
- [ ] Markdown blocks used for documentation examples
- [ ] Language specification matches content type
- [ ] Proper syntax highlighting applied
- [ ] Executable code tested and functional

## Common Patterns
- **Templates**: Use markdown blocks for file structure examples
- **Scripts**: Bash blocks only for actual executable content
- **API Docs**: JSON blocks for requests/responses
- **Config**: YAML/JSON blocks for configuration files

## Cross-References
- [Hub](../../index.md) | [formatting.md](../../principles/formatting.md)
- [link-standards.md](link-standards.md) | [naming-conventions.md](naming-conventions.md)