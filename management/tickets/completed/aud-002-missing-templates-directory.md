
# Missing /docs/templates/ Directory Structure

## Problem Statement

⏺ **Principle**: This ticket addresses [engineering.md](../../../docs/principles/engineering.md) violations by restoring missing infrastructure that compromises system integrity and [files.md](../../../docs/principles/files.md) by ensuring documented directory structure exists.

The entire `/docs/templates/` directory is missing despite being extensively documented in PROJECT_STRUCTURE.md and referenced across multiple files.

## Impact Analysis

### Missing Components
- `/docs/templates/` directory completely absent
- `command-template.md` referenced but missing
- `metadata-template.yaml` referenced but missing
- `/metadata-variants/` subdirectory missing
- 4 metadata variant files missing

### Broken References
- 9+ files reference templates/ directory
- PROJECT_STRUCTURE.md lists non-existent structure
- Navigation links broken in docs/index.md
- Command creation workflow compromised

## Root Cause

Directory structure was either:
1. Never created during initial setup
2. Accidentally removed during refactoring
3. Moved without updating documentation

## Solution Approach

### Phase 1: Create Directory Structure
1. **Create /docs/templates/ directory**
2. **Create /docs/templates/metadata-variants/ subdirectory**

### Phase 2: Implement Core Templates
1. **command-template.md** - Standard command file template
2. **metadata-template.yaml** - Basic metadata template

### Phase 3: Create Metadata Variants
1. **agent-metadata.yaml** - Agent frontmatter template
2. **command-metadata.yaml** - Command frontmatter template
3. **documentation-metadata.yaml** - Docs frontmatter template
4. **principle-metadata.yaml** - Principle frontmatter template

### Phase 4: Verify Integration
1. **Update all references** to templates
2. **Test template functionality**
3. **Ensure navigation works**

## Success Criteria

- [x] /docs/templates/ directory exists
- [x] /docs/templates/metadata-variants/ subdirectory exists
- [x] command-template.md created and functional
- [x] metadata-template.yaml created and functional
- [x] All 4 metadata variant files exist
- [x] All references to templates/ work correctly
- [x] PROJECT_STRUCTURE.md matches actual structure
- [x] Navigation links function properly

## Implementation Notes

**Directory Creation**: Use filesystem tools to create structure
**Template Content**: Base on existing patterns from working files
**Metadata Standards**: Follow frontmatter patterns from current files

## Validation

```bash
# Verify directory structure
ls -la /docs/templates/
ls -la /docs/templates/metadata-variants/

# Check references resolve
grep -r "templates/" docs/ | grep -v "\.jsonl"

# Test template functionality
```

[Return to TICKET_REGISTRY.md](../../TICKET_REGISTRY.md)
