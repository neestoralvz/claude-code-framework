# Claude Framework Project Structure

_Last updated: 2025-08-20 | Version: 1.0_

## Overview

This document defines the organizational structure for the Claude Framework and provides guidelines for maintaining clean project organization. This structure should be referenced and updated whenever files are moved, created, or reorganized.

## Root Directory Structure

```
.claude/
├── [CORE CONFIGURATION FILES - Root Level Only]
├── CLAUDE.md                    # Main framework instructions (core file)
├── CLAUDE.local.md             # Local project customizations  
├── PROJECT-STRUCTURE.md        # This file - project organization guide
├── ORGANIZATION-WORKFLOW.md    # File organization workflow guide
├── README.md                   # Project overview and setup instructions
├── package.json                # Node.js dependencies and scripts
├── settings.json               # Claude Code configuration
├── .gitignore                  # Git ignore patterns
│
├── [IMMOVABLE SYSTEM DIRECTORIES - Cannot be moved]
├── agents/                     # Specialized agent definitions
├── commands/                   # Custom command definitions
├── ide/                        # IDE-specific configurations
├── logs/                       # System logs and debugging info
├── projects/                   # Project-specific work areas
├── shell-snapshots/            # Shell state snapshots (system-managed)
├── statsig/                    # Statsig configuration and cache
├── todos/                      # Persistent todo lists (system-managed)
│
├── [ORGANIZED WORKING DIRECTORIES - Structured by function]
├── scripts/                    # Organized utility scripts
│   ├── performance/           # Performance analysis and monitoring
│   ├── testing/               # Test execution and management
│   ├── validation/            # Validation and verification utilities
│   └── utilities/             # General-purpose utilities
│
├── tests/                     # Organized test files
│   ├── unit/                  # Unit tests
│   ├── integration/           # Integration tests
│   └── performance/           # Performance tests
│
├── documentation/             # Organized documentation
│   ├── reports/               # Generated reports and demonstrations
│   └── guides/                # User guides and tutorials
│
├── [FRAMEWORK DIRECTORIES - Keep as structured]
├── system/                    # Core framework system files
│   ├── index.md              # System overview and navigation
│   ├── VISION.md             # Strategic vision and objectives
│   ├── PRINCIPLES.md         # Decision-making principles
│   ├── PERSONALITIES.md      # Personality system documentation
│   ├── STANDARDS.md          # Quality and technical standards
│   ├── PROCESSES.md          # Core processes overview
│   ├── EXAMPLES.md           # Usage examples
│   ├── ROADMAP.md            # Development roadmap
│   ├── personalities/        # Individual personality definitions
│   ├── processes/            # Detailed process workflows
│   └── standards/            # Detailed standards documentation
│
├── operations/               # Operational work sessions and experiments
│   ├── YYYYMMDD-HHMMSS-description/  # Timestamped operation directories
│   └── [session-specific files]
│
├── hooks/                   # Claude Code hooks
│   ├── README.md           # Hook configuration documentation
│   └── [hook-scripts]      # Individual hook implementations
│
├── integrations/           # External tool integrations
├── plugins/               # Plugin configurations
└── metrics/               # Performance and usage metrics
```

## File Organization Rules

### What Goes in Root Directory

**ONLY these files should be in the root:**
- `CLAUDE.md` - Main framework instructions
- `CLAUDE.local.md` - Local customizations
- `PROJECT-STRUCTURE.md` - This organization guide
- `ORGANIZATION-WORKFLOW.md` - File organization workflow
- `README.md` - Project overview
- `package.json` - Dependencies and scripts
- `settings.json` - Claude Code settings
- `.gitignore` - Git ignore patterns

### What Should NOT be in Root Directory

**These file types belong in organized subdirectories:**
- Test files (`*.test.js`, `*.spec.js`) → `tests/unit/`
- Script files (`run-*.js`, `execute-*.js`) → `scripts/testing/`
- Performance files (`performance-*.js`, `*-analysis.js`) → `scripts/performance/`
- Validation files (`validate-*.js`, `quick-*.js`) → `scripts/validation/`
- Documentation files (`*-REPORT.md`, `*-DEMONSTRATION.md`) → `documentation/reports/`
- Temporary experiment files → `operations/[timestamped-session]/`

## Directory Purposes

### `/system/`
Core framework files that define how Claude operates. These are foundational and should rarely change.

### `/operations/`
Work sessions, experiments, and temporal activities. Use timestamped directories for organization.

### `/scripts/`
Reusable automation and utility scripts, organized by purpose:
- `testing/` - Test execution and management
- `performance/` - Performance analysis and monitoring  
- `validation/` - Validation and verification utilities
- `utilities/` - General-purpose utilities

### `/scripts/`
Organized utility scripts by function:
- `performance/` - Performance analysis and monitoring scripts
- `testing/` - Test execution and management scripts  
- `validation/` - Validation and verification utilities
- `utilities/` - General-purpose utility scripts

### `/tests/`
All test files organized by test type:
- `unit/` - Unit test files
- `integration/` - Integration test files
- `performance/` - Performance test files

### `/documentation/`
Organized documentation files:
- `reports/` - Generated reports and demonstrations
- `guides/` - User guides and tutorials

### `/hooks/`
Claude Code hook implementations with configuration documentation.

### `/agents/`
Specialized agent definitions for the Task tool system.

## Maintenance Guidelines

### When Creating New Files

1. **Ask:** Does this file belong in root? (Usually NO)
2. **Determine:** What category does this file serve?
3. **Place:** Put it in the appropriate subdirectory
4. **Document:** Update this file if creating new categories

### When Moving Files

1. **Check:** Is the file referenced elsewhere?
2. **Update:** Any import paths or documentation references
3. **Test:** Ensure nothing breaks after the move
4. **Commit:** Document the reorganization in git

### Regular Maintenance

1. **Review:** Root directory monthly for misplaced files
2. **Organize:** Move files to appropriate directories
3. **Update:** This document when structure changes
4. **Clean:** Remove obsolete or duplicate files

## Integration with CLAUDE.md

This project structure is designed to work with the command system in CLAUDE.md:

- System files are referenced with specific paths
- Operations maintain temporal organization
- Scripts provide reusable utilities
- Tests follow TDD/BDD workflows
- Documentation stays organized and findable

When CLAUDE.md references file paths, they should align with this structure to maintain consistency and reliability.

## Version Control

- This file should be updated whenever the project structure changes
- Changes should be committed with descriptive messages about the reorganization
- Structure changes should be coordinated to avoid breaking workflows

---

**Keep it organized. Make it easy to find.**