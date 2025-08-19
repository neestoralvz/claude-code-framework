# Core Framework Components

This directory contains the modularized components of the CLAUDE.md framework, implementing [content-deduplication.md single-source truth methodology](../../../../operations/content-deduplication.md).

## Component Architecture

Each component serves as the authoritative source for its specific domain:

- **[command-architecture.md](command-architecture.md)** - Command-centered execution patterns and benefits
- **[command-selection.md](command-selection.md)** - Command selection strategies and decision trees  
- **[session-management.md](session-management.md)** - Session initialization and context handling
- **[quality-integration.md](quality-integration.md)** - Quality assurance and validation frameworks
- **[compliance-framework.md](compliance-framework.md)** - Framework adherence and principle application
- **[navigation-hub.md](navigation-hub.md)** - Framework access patterns and reference guides
- **[command-flow-triggers.md](command-flow-triggers.md)** - Execution triggers and workflow integration

## Usage Pattern

Components use instructional links to reference each other, following the pattern:
```markdown
**[Access component-name.md for specific-purpose](component-name.md)**
```

## Authority Assignment

Each component maintains single-source authority for its domain, with the main CLAUDE.md serving as the orchestration hub that links to these authoritative sources.