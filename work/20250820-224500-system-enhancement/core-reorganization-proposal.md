# Core Folder Hierarchical Reorganization Proposal

_Version: 1.0 | Date: 2025-08-20_

## Executive Summary

This proposal presents a comprehensive reorganization of the Simple Framework's core folder to improve navigation, discoverability, and maintainability while adhering to the Simple and Easy principles.

## Current State Analysis

### Existing Structure Issues
1. **Mixed hierarchy levels**: System files, documentation, and operational tools at same level
2. **Inconsistent naming**: Mix of CAPS.md, lowercase.md, and kebab-case.md files
3. **Scattered backups**: behaviors_backup folder indicates incomplete migration
4. **Unclear categorization**: Some directories overlap in purpose (workflows vs processes)
5. **Deep nesting**: Dashboard has 5+ subdirectories creating navigation complexity

### Current Statistics
- 15 root-level markdown files
- 15 subdirectories with varying organization patterns
- Mixed operational and documentation files
- Backup files indicating incomplete refactoring

## Proposed New Structure

```
core/
├── 00-system/                    # Core system configuration and metadata
│   ├── index.md                  # System overview and navigation guide
│   ├── vision.md                 # Framework vision and goals
│   ├── roadmap.md                # Development roadmap and milestones
│   └── core.md                   # Core system documentation
│
├── 01-foundation/                # Foundational framework elements
│   ├── principles/               # Core principles and guidelines
│   │   ├── README.md            # Principles overview
│   │   ├── simple-and-easy.md   # Primary principle
│   │   └── [principle-files]    # Individual principle docs
│   │
│   ├── standards/                # Technical and quality standards
│   │   ├── README.md            # Standards overview
│   │   ├── code-standards.md    # Coding standards
│   │   └── [standard-files]     # Individual standard docs
│   │
│   └── personalities/            # Personality system
│       ├── README.md            # Personalities overview
│       ├── personality-matrix.md # Personality orchestration
│       └── [personality-files]  # Individual personality docs
│
├── 02-operations/                # Operational workflows and processes
│   ├── workflows/                # High-level workflow orchestration
│   │   ├── README.md            # Workflows overview
│   │   ├── decision-matrix.md   # Workflow selection guide
│   │   └── [workflow-files]     # Individual workflow docs
│   │
│   ├── processes/                # Detailed process implementations
│   │   ├── README.md            # Processes overview
│   │   ├── tdd-bdd-unified.md   # Core development process
│   │   └── [process-files]      # Individual process docs
│   │
│   └── agents/                   # Agent system and specializations
│       ├── README.md            # Agents overview
│       ├── specialization-system.md # Agent specialization framework
│       └── [agent-templates]    # Agent template files
│
├── 03-tools/                     # Tools and utilities
│   ├── checks/                   # System validation checks
│   │   ├── README.md            # Checks overview
│   │   └── [check-scripts]      # Individual check tools
│   │
│   ├── utilities/                # Utility scripts and tools
│   │   ├── README.md            # Utilities overview
│   │   └── [utility-tools]      # Individual utilities
│   │
│   └── registries/               # System registries and indexes
│       ├── README.md            # Registries overview
│       └── [registry-files]     # Registry data files
│
├── 04-templates/                 # Templates and examples
│   ├── project-templates/        # Project structure templates
│   │   ├── README.md            # Templates overview
│   │   └── project-documentation.md # Project doc template
│   │
│   ├── examples/                 # Implementation examples
│   │   ├── README.md            # Examples overview
│   │   └── [example-files]      # Individual examples
│   │
│   └── patterns/                 # Design patterns and solutions
│       ├── README.md            # Patterns overview
│       └── [pattern-files]      # Pattern implementations
│
├── 05-dashboard/                 # Dashboard management system
│   ├── README.md                # Dashboard overview
│   ├── configuration/            # Dashboard configuration
│   ├── operations/               # Dashboard operations
│   └── assets/                   # Dashboard resources
│
└── 06-archives/                  # Archived and deprecated items
    ├── README.md                # Archive policy and index
    ├── deprecated/               # Deprecated but referenced
    └── backups/                  # Backup files pending cleanup
```

## Detailed Mapping of Existing Files

### Root Level Files → New Locations

| Current File | New Location | Rationale |
|-------------|--------------|------------|
| INDEX.md | 00-system/index.md | System-level navigation |
| VISION.md | 00-system/vision.md | Core system documentation |
| ROADMAP.md | 00-system/roadmap.md | System planning document |
| CORE.md | 00-system/core.md | System documentation |
| PRINCIPLES.md | 01-foundation/principles/README.md | Foundation overview |
| STANDARDS.md | 01-foundation/standards/README.md | Standards overview |
| PERSONALITIES.md | 01-foundation/personalities/README.md | Personality overview |
| PROCESSES.md | 02-operations/processes/README.md | Process overview |
| EXAMPLES.md | 04-templates/examples/README.md | Examples overview |
| CHECKS.md | 03-tools/checks/README.md | Checks overview |
| TOOLS.md | 03-tools/utilities/README.md | Tools overview |
| PROJECT-DOCUMENTATION-TEMPLATE.md | 04-templates/project-templates/project-documentation.md | Template file |
| organization-workflow.md | 02-operations/workflows/organization-workflow.md | Workflow document |
| agents-specialization-system.md | 02-operations/agents/specialization-system.md | Agent system doc |

### Directory Migrations

| Current Directory | New Location | Notes |
|------------------|--------------|--------|
| principles/ | 01-foundation/principles/ | Direct migration |
| standards/ | 01-foundation/standards/ | Direct migration |
| personalities/ | 01-foundation/personalities/ | Direct migration |
| processes/ | 02-operations/processes/ | Direct migration |
| workflows/ | 02-operations/workflows/ | Direct migration |
| agents/ | 02-operations/agents/ | Direct migration |
| checks/ | 03-tools/checks/ | Direct migration |
| tools/ | 03-tools/utilities/ | Renamed for clarity |
| registries/ | 03-tools/registries/ | Grouped with tools |
| templates/ | 04-templates/project-templates/ | Reorganized |
| examples/ | 04-templates/examples/ | Reorganized |
| dashboard/ | 05-dashboard/ | Simplified structure |
| behaviors_backup/ | 06-archives/backups/behaviors/ | Archived |

## Organizational Rationale

### 1. Numbered Prefix System (00-06)
**Purpose**: Natural sorting and clear hierarchy
- **00-system**: Highest priority, system-level documentation
- **01-foundation**: Core concepts users must understand
- **02-operations**: How to work within the framework
- **03-tools**: Supporting utilities and validation
- **04-templates**: Resources for implementation
- **05-dashboard**: Specialized subsystem
- **06-archives**: Deprecated/backup items

### 2. README.md Convention
**Purpose**: Consistent navigation and discovery
- Each directory has README.md as its index
- Provides overview and navigation within category
- Eliminates CAPS.md files for consistency

### 3. Three-Level Maximum Depth
**Purpose**: Simple navigation
- core/category/subcategory/file.md maximum
- Prevents deep nesting complexity
- Maintains easy mental model

### 4. Functional Grouping
**Purpose**: Logical organization by purpose
- System configuration separate from operations
- Clear distinction between foundation and implementation
- Tools grouped by function not format

### 5. Progressive Disclosure
**Purpose**: Learning path alignment
- Start with system overview (00)
- Learn foundations (01)
- Understand operations (02)
- Use tools (03)
- Apply templates (04)
- Specialized systems (05)

## New Directory Categories

### Introduced Categories

1. **00-system**: Consolidates system-level documentation
2. **01-foundation**: Groups conceptual framework elements
3. **02-operations**: Unifies all operational aspects
4. **04-templates/patterns**: New location for design patterns
5. **06-archives**: Formal archive structure

### Consolidated Categories

- **workflows + processes → operations**: Related concepts unified
- **tools + checks + registries → tools**: All utilities together
- **templates + examples → templates**: Resources consolidated

## Cleanup Recommendations

### Immediate Cleanup
1. **behaviors_backup/**: Archive or integrate into current system
2. **Duplicate README files**: Consolidate into category READMEs
3. **Mixed naming conventions**: Standardize to kebab-case.md

### Deferred Cleanup
1. **Dashboard subdirectories**: Flatten structure in phase 2
2. **Process/workflow overlap**: Review and consolidate similar docs
3. **Orphaned files**: Identify and archive unused files

## Impact Assessment on CLAUDE.md

### Required Updates

CLAUDE.md contains approximately 45 direct file references that need updating:

1. **System Integration Section** (8 references)
   - `[core/index.md]` → `[core/00-system/index.md]`
   - `[core/VISION.md]` → `[core/00-system/vision.md]`
   - `[core/PRINCIPLES.md]` → `[core/01-foundation/principles/README.md]`
   - etc.

2. **Workflow Commands Section** (12 references)
   - Process file paths need updating
   - Workflow file paths need updating

3. **Documentation References** (15 references)
   - Various markdown file references throughout

4. **Tool References** (10 references)
   - Check and utility paths need updating

### Migration Strategy

1. **Phase 1**: Create new structure alongside existing
2. **Phase 2**: Copy files to new locations
3. **Phase 3**: Update all CLAUDE.md references
4. **Phase 4**: Test all references work
5. **Phase 5**: Remove old structure

### Backward Compatibility

- Create symbolic links from old to new during transition
- Maintain redirect documentation for 30 days
- Update all agent templates and workflows

## Implementation Plan

### Phase 1: Preparation (Day 1)
- Create new directory structure
- Document migration mapping
- Prepare update scripts

### Phase 2: Migration (Day 2)
- Copy files to new locations
- Update internal cross-references
- Create compatibility links

### Phase 3: Update (Day 3)
- Update CLAUDE.md references
- Update agent templates
- Update workflow files

### Phase 4: Validation (Day 4)
- Run all system checks
- Validate all references
- Test agent deployments

### Phase 5: Cleanup (Day 5)
- Archive old structure
- Remove compatibility links
- Final documentation update

## Benefits Summary

1. **Improved Navigation**: Clear hierarchical structure with numbered categories
2. **Better Discoverability**: Consistent README.md pattern and logical grouping
3. **Reduced Complexity**: Maximum 3-level depth and functional organization
4. **Clear Learning Path**: Progressive disclosure from system to implementation
5. **Maintainability**: Organized archives and consistent naming conventions
6. **Scalability**: Room for growth within established categories

## Risk Mitigation

1. **Reference Breakage**: Comprehensive testing and validation phase
2. **User Confusion**: Clear migration documentation and transition period
3. **Agent Disruption**: Careful update of all agent templates
4. **Workflow Impact**: Gradual migration with compatibility layer

## Conclusion

This reorganization will transform the core folder from a mixed collection of files into a clearly structured, easily navigable hierarchy that embodies the Simple and Easy Framework principles. The numbered category system provides immediate orientation, while the consistent README pattern ensures discoverability at every level.

---

_This proposal follows the Simple and Easy Framework principles: organized simply, structured easily, and designed for immediate comprehension._