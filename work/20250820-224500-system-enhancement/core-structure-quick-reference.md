# Core Structure Quick Reference Guide

_Navigate the reorganized core folder with ease_

## Directory Map

```
core/
├── 00-system/          → System configuration & metadata
├── 01-foundation/      → Core concepts & principles  
├── 02-operations/      → Workflows, processes & agents
├── 03-tools/          → Utilities, checks & registries
├── 04-templates/      → Templates, examples & patterns
├── 05-dashboard/      → Dashboard management system
└── 06-archives/       → Deprecated & backup items
```

## Quick Navigation

### "I need to understand..."

| What | Where | File |
|------|-------|------|
| Framework vision | `00-system/` | `vision.md` |
| System overview | `00-system/` | `index.md` |
| Development roadmap | `00-system/` | `roadmap.md` |
| Core principles | `01-foundation/principles/` | `README.md` |
| Quality standards | `01-foundation/standards/` | `README.md` |
| Personality system | `01-foundation/personalities/` | `README.md` |

### "I need to do..."

| Task | Where | File |
|------|-------|------|
| Follow a workflow | `02-operations/workflows/` | `[workflow-name].md` |
| Execute a process | `02-operations/processes/` | `[process-name].md` |
| Deploy an agent | `02-operations/agents/` | `specialization-system.md` |
| Run validation | `03-tools/checks/` | `[check-name].md` |
| Use a utility | `03-tools/utilities/` | `[tool-name].md` |
| Access registry | `03-tools/registries/` | `[registry-name].md` |

### "I need an example of..."

| Need | Where | File |
|------|-------|------|
| Project structure | `04-templates/project-templates/` | `project-documentation.md` |
| Implementation | `04-templates/examples/` | `[example-name].md` |
| Design pattern | `04-templates/patterns/` | `[pattern-name].md` |
| Dashboard config | `05-dashboard/configuration/` | Various configs |
| Deprecated code | `06-archives/deprecated/` | Historical files |

## Common Tasks

### Setting Up a New Project
1. Start: `00-system/index.md` - System overview
2. Review: `01-foundation/principles/README.md` - Core principles
3. Use: `04-templates/project-templates/project-documentation.md` - Template
4. Follow: `02-operations/workflows/organization-workflow.md` - Organization

### Implementing a Feature
1. Check: `01-foundation/standards/README.md` - Quality standards
2. Follow: `02-operations/processes/tdd-bdd-unified.md` - Development process
3. Reference: `04-templates/examples/` - Implementation examples
4. Deploy: `02-operations/agents/` - Specialized agents

### Running System Checks
1. Navigate: `03-tools/checks/README.md` - Overview
2. Select: `03-tools/checks/[specific-check].md` - Specific validation
3. Execute: Follow check instructions
4. Document: Results and actions taken

### Working with Agents
1. Understand: `02-operations/agents/specialization-system.md` - System
2. Create: `02-operations/agents/[template].md` - Templates
3. Deploy: Using Task tool with agent
4. Coordinate: `02-operations/workflows/strategic-orchestration.md`

## File Naming Conventions

### README Files
- **Purpose**: Category overview and navigation
- **Location**: Root of each directory
- **Format**: `README.md` (always uppercase)

### Documentation Files
- **Format**: `kebab-case.md` (lowercase with hyphens)
- **Examples**: `tdd-bdd-unified.md`, `organization-workflow.md`
- **No spaces**: Use hyphens instead

### Directory Names
- **Format**: `NN-category` for top level (00-system)
- **Subdirs**: `lowercase` single words or `kebab-case`
- **No underscores**: Use hyphens for consistency

## Search Patterns

### Finding Files by Type

```bash
# Find all workflows
find core/02-operations/workflows -name "*.md"

# Find all checks
find core/03-tools/checks -name "*.md"

# Find all examples
find core/04-templates/examples -name "*.md"
```

### Finding Files by Content

```bash
# Find files mentioning "TDD"
grep -r "TDD" core/

# Find workflow definitions
grep -r "workflow:" core/02-operations/

# Find agent templates
grep -r "agent:" core/02-operations/agents/
```

## Migration Reference

### Old → New Mapping

| Old Location | New Location |
|--------------|-------------|
| `core/*.md` (root) | `core/00-system/` or category `/README.md` |
| `core/processes/` | `core/02-operations/processes/` |
| `core/workflows/` | `core/02-operations/workflows/` |
| `core/checks/` | `core/03-tools/checks/` |
| `core/tools/` | `core/03-tools/utilities/` |
| `core/examples/` | `core/04-templates/examples/` |
| `core/behaviors_backup/` | `core/06-archives/backups/behaviors/` |

## Quick Tips

### Navigation
- **Start at 00**: System-level understanding
- **Progress numerically**: 00 → 01 → 02 for learning
- **Jump to category**: Direct access when you know what you need

### Discovery
- **Check README first**: Each directory has overview
- **Use numbered prefixes**: Natural sorting helps
- **Follow cross-references**: Files link to related content

### Organization
- **New files**: Place in most specific category
- **Unsure?**: Check similar files for patterns
- **Archive don't delete**: Use 06-archives for old content

## Troubleshooting

### Can't Find a File?
1. Check old → new mapping above
2. Search by content with grep
3. Look in 06-archives for deprecated items
4. Check git history for renamed files

### Broken Reference?
1. File might have moved - check mapping
2. Look for compatibility symlinks
3. Check migration report for details
4. Update reference to new location

### Need Help?
1. Start with `00-system/index.md`
2. Review category README files
3. Check migration documentation
4. Consult reorganization proposal

---

## Remember: Simple and Easy

- **Simple Structure**: 7 main categories, numbered for clarity
- **Easy Navigation**: README in each directory, consistent naming
- **Simple Principle**: If unsure, check the README
- **Easy Discovery**: Numbers guide the path

---

_This guide provides quick access to the reorganized core structure._