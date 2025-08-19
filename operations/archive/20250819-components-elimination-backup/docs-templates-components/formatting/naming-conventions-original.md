
[Previous: formatting.md](../../../principles/formatting.md) | [Hub](../../philosophy/index.md) | [Next: link-standards.md](link-standards.md)

# NAMING CONVENTIONS

⏺ **Principle**: Implements [formatting.md](../../../principles/formatting.md) naming standards for clarity and maintainability.

## Core Patterns

### File Patterns
- **Documents**: `{TOPIC}-{subtopic}.md` (CAPS for main topics)
- **Agents**: `{name}-{type}.md` (kebab-case)
- **Commands**: `{action}-{object}.md` (kebab-case)
- **Tickets**: `{number}-{description}.md` (zero-padded)
- **Scripts**: `{purpose}-{type}.sh` (kebab-case)

## Case Conventions
- **kebab-case**: Files, URLs (`agent-architect.md`)
- **camelCase**: JavaScript functions (`getUserData()`)
- **PascalCase**: Classes, Components (`TaskRunner`)
- **snake_case**: Python, database (`get_user_data()`)
- **SCREAMING_SNAKE_CASE**: Constants (`MAX_RETRY_ATTEMPTS`)

## Directory Naming
- **System**: Lowercase (`agents/`, `docs/`, `commands/`)
- **Subdirectories**: kebab-case (`agents-documentation/`)
- **Project**: Follow conventions, document in CLAUDE.md

## Special Cases
- **CLAUDE.md**: Always UPPERCASE (framework authority)
- **System Files**: UPPERCASE for importance (`README.md`)
- **Templates**: `{type}-template.{ext}`
- **Config**: Follow tech conventions (`.env`, `package.json`)
- **Versioned**: Include version when needed (`api-v1.md`)

## Validation Checklist
1. ✓ Consistency with established patterns
2. ✓ Clear purpose indication
3. ✓ Appropriate case for context
4. ✓ No naming conflicts
5. ✓ Reasonable length
6. ✓ Project standard alignment

## Cross-Platform Safety
- **Avoid**: Spaces, special chars (`/ \ : * ? " < > |`), reserved words
- **Use**: ASCII letters, numbers, hyphens, underscores
- **Limits**: <100 chars for files, <260 for paths
- **Case**: Treat as case-sensitive for consistency

## Cross-References
- [Hub](../../philosophy/index.md) | [formatting.md](../../../principles/formatting.md)
- [link-standards.md](link-standards.md) | [code-block-standards.md](code-block-standards.md)
