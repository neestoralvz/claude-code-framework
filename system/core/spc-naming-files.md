
# File Naming Convention

## Standard Pattern: Type-Action-Target

```
{category}/{type}-{action}-{target}.md
```

**3-Element Structure:**
- **type**: What it is (guide, matrix, template, spec, workflow, hub, index)
- **action**: What it does (browse, create, map, validate, organize, navigate, discover)
- **target**: What it operates on (commands, agents, structure, files, workflows, system)

## File Types

### Core Types (3-Letter Codes)
- `spc-` - Specifications and technical documents
- `gui-` - User guides and references  
- `mtx-` - Decision matrices and mappings
- `tpl-` - Creation templates and patterns
- `wfl-` - Process workflows and procedures
- `hub-` - Navigation and coordination centers
- `idx-` - Organized catalogs and listings

### Common Actions
- `browse`, `navigate`, `discover` - Navigation actions
- `create`, `generate`, `build` - Creation actions
- `map`, `organize`, `structure` - Organization actions
- `validate`, `check`, `verify` - Validation actions
- `maintain`, `manage`, `update` - Maintenance actions

### Common Targets
- `commands`, `agents`, `workflows` - System entities
- `structure`, `files`, `system` - Organizational targets
- `navigation`, `reference`, `documentation` - Content types

## Directory-Specific Patterns

### Core System (`core/`)
Foundation files and specifications:
- `cmd-consolidate-specification.md` - Command system consolidation specs
- `sys-directory-overview.md` - System directory overview

### Navigation (`navigation/`)
Discovery and reference tools:
- `nav-browse-commands.md` - Command browsing interface
- `nav-index-commands.md` - Command index system
- `nav-reference-guide.md` - Navigation reference guide
- `nav-discover-matrix.md` - Discovery matrix tool
- `nav-navigate-hub.md` - Central navigation hub

### Reference (`reference/`)
Technical matrices and mappings:
- `ref-map-agent-workflows.md` - Agent workflow mapping
- `ref-matrix-command-reference.md` - Command reference matrix

### Templates (`templates/`)
Creation patterns and structures:
- `doc-create-command.md` - Command creation template
- `doc-create-enhanced-command.md` - Enhanced command template

### Principles (`principles/`)
Guidelines and standards:
- `doc-create-commands.md` - Command creation guidelines
- `doc-apply-dry-principles.md` - DRY methodology principles
- `sys-name-conventions.md` - Naming conventions standard
- `doc-apply-solid-language.md` - SOLID language principles

### Workflows (`workflows/`)
#### Core (`workflows/core/`)
- `sys-name-files.md` - File naming standards (this file)

#### Components (`workflows/components/`)
- `sys-organize-structure.md` - Structure organization workflow
- `sys-maintain-claude.md` - CLAUDE.md maintenance workflow
- `doc-apply-templates.md` - Template application workflow

#### Templates (`workflows/templates/`)
- `wf-create-workflow.md` - Workflow creation template
- `wf-create-simple-workflow.md` - Simple workflow template

#### Modules (`workflows/modules/`)
- `wf-plan-execution.md` - Planning and execution workflow
- `wf-validate-success.md` - Success validation workflow
- `wf-recurse-improvement.md` - Recursive improvement workflow
- `wf-manage-ripple-effects.md` - Ripple effect management workflow
- `wf-execute-plans.md` - Plan execution workflow
- `wf-index-workflows.md` - Workflow index system

## Naming Rules

1. **Action-oriented**: Start with verb when possible
2. **Descriptive**: Clear purpose indication
3. **Concise**: Avoid unnecessary words
4. **Consistent**: Follow verb-noun pattern
5. **Lowercase**: All characters lowercase
6. **Hyphens**: Use `-` not `_` or spaces
7. **No redundancy**: Don't repeat directory context

## Bad vs Good Examples

### ❌ Current Problems
- `COMMAND_CONSOLIDATION_SPECIFICATION.md` → Too verbose, all caps
- `universal-planning-workflow.md` → Redundant "universal" and "workflow"
- `gui-reference-commands.md` → Updated to 3-letter GUI prefix in navigation/
- `README.md` → Generic, non-descriptive

### ✅ Improved Names
- `consolidate-specification.md` → Clear action and target
- `plan-execution.md` → Simple, direct
- `reference-guide.md` → Clear purpose
- `directory-overview.md` → Descriptive purpose

## Migration Strategy

1. **Gradual**: Rename files one category at a time
2. **Links**: Update all cross-references after renaming
3. **Validation**: Test navigation after each batch
4. **Documentation**: Update this guide as patterns evolve

## Benefits

- **Predictable naming** - Easy to find workflows
- **Logical grouping** - Similar workflows cluster naturally
- **Sequential clarity** - Multi-step processes clearly ordered
- **Maintenance friendly** - Easy to identify outdated workflows
- **Search optimized** - Consistent patterns enable effective searching