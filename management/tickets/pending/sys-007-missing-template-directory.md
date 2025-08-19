
# Ticket: Fix Missing Template Directory with 10+ Broken Links

## Problem

The `/docs/templates/` directory referenced throughout the system documentation does not exist, creating multiple broken links and false expectations about available templates.

**Referenced but Missing**:
- `/docs/templates/` - Main templates directory (referenced in PROJECT_STRUCTURE.md)
- `/docs/templates/command-template.md` - Referenced in docs/index.md line 104
- `/docs/templates/metadata-template.yaml` - Referenced in PROJECT_STRUCTURE.md line 95
- `/docs/templates/metadata-variants/` - Referenced in PROJECT_STRUCTURE.md line 96
- Multiple variant templates listed in PROJECT_STRUCTURE.md lines 97-100

**Broken References Found In**:
1. `docs/index.md` - Line 104: "Apply command-template.md to create commands"
2. `PROJECT_STRUCTURE.md` - Lines 93-100: Complete templates section
3. `docs/index.md` - Line 183: "Use appropriate templates from docs/templates/"
4. `planning/TICKET_REGISTRY.md` - Multiple template references
5. `commands/create-ticket.md` - Template system expectations

## Impact

- **Scope**: Documentation integrity and user experience  
- **Users**: All developers attempting to use template system
- **Severity**: CRITICAL - Breaks promised functionality and creates user confusion

**Specific Issues**:
1. **Broken Navigation**: Users click template links and receive 404-style errors
2. **Inconsistent Documentation**: PROJECT_STRUCTURE.md lists non-existent files
3. **Workflow Disruption**: Commands expect templates that don't exist
4. **User Trust**: Documented features don't work as advertised

## Solution

Create comprehensive template system matching documented structure:

1. **Create Main Templates Directory**: `/docs/templates/`
2. **Implement Core Templates**: All templates referenced in PROJECT_STRUCTURE.md
3. **Build Metadata Variants**: Specialized metadata templates for different file types
4. **Validate All Links**: Ensure every template reference resolves correctly

## Implementation Steps

1. **Create Directory Structure**
   ```bash
   mkdir -p /docs/templates/metadata-variants
   ```

2. **Create Core Templates**
   - `command-template.md` - Standard command structure template
   - `metadata-template.yaml` - Base metadata template
   - Additional templates as documented in PROJECT_STRUCTURE.md

3. **Create Metadata Variants**
   - `agent-metadata.yaml` - Agent-specific metadata
   - `command-metadata.yaml` - Command-specific metadata  
   - `documentation-metadata.yaml` - Documentation metadata
   - `principle-metadata.yaml` - Principle-specific metadata

4. **Populate Template Content**
   - Extract patterns from existing well-structured files
   - Create standardized, reusable template formats
   - Include comprehensive frontmatter and structure

5. **Validate All References**
   - Test every template link in documentation
   - Update any incorrect paths discovered
   - Verify PROJECT_STRUCTURE.md accuracy

6. **Update PROJECT_STRUCTURE.md**
   - Ensure all listed files actually exist
   - Add any missing template files created
   - Verify file count accuracy

## Acceptance Criteria

- [ ] `/docs/templates/` directory exists with proper structure
- [ ] `command-template.md` exists and provides usable template
- [ ] `metadata-template.yaml` exists with comprehensive base structure
- [ ] All metadata variant templates exist (agent, command, documentation, principle)
- [ ] All template links in docs/index.md resolve correctly
- [ ] All template references in PROJECT_STRUCTURE.md point to real files
- [ ] Template system is fully functional for new file creation
- [ ] No broken template links exist anywhere in system

## Dependencies

None - this is an infrastructure issue affecting multiple system components.

## Notes

Generated from critical system audit finding. The template system is fundamental infrastructure that multiple workflows depend on.

**Directory Structure to Create**:
```
docs/templates/
├── command-template.md
├── metadata-template.yaml
└── metadata-variants/
    ├── agent-metadata.yaml
    ├── command-metadata.yaml
    ├── documentation-metadata.yaml
    └── principle-metadata.yaml
```

**Files to Update After Creation**:
- Verify no additional updates needed to PROJECT_STRUCTURE.md
- Test all template links in documentation system
- Update any workflow documentation that references templates

**Principle Violations**:
- Violates [fundamental.md] by lacking evidence (promises non-existent files)
- Violates [engineering.md] by having broken functionality
- Violates [organization.md] by having inconsistent file structure
