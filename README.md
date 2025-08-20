# Claude Framework

[![Tests](https://img.shields.io/badge/tests-passing-brightgreen.svg)](/)
[![Coverage](https://img.shields.io/badge/coverage-100%25-brightgreen.svg)](/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Node.js](https://img.shields.io/badge/node-%3E%3D%2014.0.0-brightgreen.svg)](https://nodejs.org/)

A comprehensive Claude Code framework implementing Simple and Easy principles through systematic organization, specialized agents, and evidence-based development workflows.

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Immovable System Constraints](#immovable-system-constraints)
- [Organization Guidelines](#organization-guidelines)
- [Framework Components](#framework-components)
- [Getting Started](#getting-started)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

## Overview

This framework provides a structured approach to working with Claude Code, emphasizing simplicity, clarity, and systematic organization. Built around the core principle: **Keep it simple. Make it easy.**

### Key Features

- **Systematic Organization**: Clear hierarchical structure with logical file placement
- **Specialized Agents**: Task-specific agents for complex workflows
- **Evidence-Based Development**: TDD/BDD methodologies with validation requirements
- **Immovable Constraint Support**: Respects system-managed directories
- **Progressive Enhancement**: Evolving structure that adapts to needs

## Project Structure

The framework is organized into distinct categories that respect system constraints while providing logical organization:

```
.claude/
├── [CORE CONFIGURATION FILES - Root Level Only]
├── CLAUDE.md                    # Main framework instructions
├── CLAUDE.local.md             # Local project customizations  
├── ORGANIZATION-WORKFLOW.md    # File organization workflow guide
├── README.md                   # This documentation (project overview)
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

## Immovable System Constraints

### What These Directories Are

The following directories cannot be moved or reorganized due to system constraints. They serve specific purposes and are managed by Claude Code or external systems:

#### `/shell-snapshots/`
- **Purpose**: Stores shell state snapshots for session management
- **Managed By**: Claude Code system
- **Content**: Shell environment state, command history, working directory snapshots
- **Why Immovable**: Referenced by system processes for session restoration

#### `/statsig/` 
- **Purpose**: Configuration and cache for Statsig analytics service
- **Managed By**: Statsig SDK and Claude Code integration
- **Content**: 
  - `statsig.cached.evaluations.*` - Cached feature flag evaluations
  - `statsig.last_modified_time.evaluations` - Cache timestamp management
  - `statsig.session_id.*` - Session tracking data
- **Why Immovable**: External service integration requires fixed paths

#### `/todos/`
- **Purpose**: Persistent todo lists and task management
- **Managed By**: Claude Code TodoWrite system
- **Content**: Serialized todo lists, task state management
- **Why Immovable**: System-managed persistence layer

#### `/ide/`
- **Purpose**: IDE-specific configurations and state
- **Managed By**: Claude Code IDE integration
- **Content**: IDE settings, workspace configurations, language server data
- **Why Immovable**: IDE integration requires stable configuration paths

#### `/logs/`
- **Purpose**: System logs and debugging information
- **Managed By**: Claude Code logging system  
- **Content**: Execution logs, error traces, debugging output
- **Why Immovable**: Logging system expects fixed path structure

#### Other System Directories

The following are also immovable but represent more traditional configuration areas:

- `/agents/` - Agent definitions for Task tool (Claude Code system)
- `/commands/` - Custom command definitions (user-configurable but location-dependent)
- `/projects/` - Project-specific workspaces (system-managed isolation)

### Working With Constraints

#### Design Principles
1. **Respect the Immovable**: Never attempt to move or reorganize constrained directories
2. **Organize Around Constraints**: Design file structure that works with fixed elements
3. **Document the Why**: Always explain why certain directories can't be moved
4. **Plan for Constraints**: Consider system constraints when designing workflows

#### File Organization Strategy
- **Root Level**: Only essential configuration files
- **System Level**: Respect immovable system directories
- **Working Level**: Organize functional directories around constraints
- **Content Level**: Group similar files within organized directories

## Organization Guidelines

### What Goes Where

#### Root Directory (Only These Files)
- `CLAUDE.md` - Main framework instructions
- `CLAUDE.local.md` - Local customizations
- `ORGANIZATION-WORKFLOW.md` - File organization workflow  
- `README.md` - This project documentation
- `package.json` - Dependencies and scripts
- `settings.json` - Claude Code settings
- `.gitignore` - Git ignore patterns

#### Organized Directories (Movable Files)
- **Test files** (`*.test.js`, `*.spec.js`) → `tests/unit/`
- **Script files** (`run-*.js`, `execute-*.js`) → `scripts/testing/`
- **Performance files** (`performance-*.js`, `*-analysis.js`) → `scripts/performance/`
- **Validation files** (`validate-*.js`, `quick-*.js`) → `scripts/validation/`
- **Documentation files** (`*-REPORT.md`, `*-DEMONSTRATION.md`) → `documentation/reports/`
- **Utility scripts** → `scripts/utilities/`

### Maintenance Rules

#### When Creating New Files
1. **Identify Purpose**: Determine what the file does
2. **Check Category**: See if it fits existing organized categories
3. **Place Correctly**: Put in appropriate organized directory
4. **Avoid Root**: Never place working files in root directory
5. **Respect Constraints**: Never place files in immovable directories

#### When System Creates Files
1. **System Directories**: Files created by Claude Code go in system-managed directories
2. **User Files**: Files created by user work go in organized directories
3. **Temporary Files**: Session work goes in `operations/[timestamped]/`
4. **Documentation**: Generated docs go in `documentation/`

#### Regular Cleanup
1. **Monthly Review**: Check for misplaced files in root
2. **Categorize New**: Move any new files to organized locations
3. **Document Changes**: Update this README when structure evolves
4. **Maintain Constraints**: Verify immovable directories remain untouched

## Framework Components

### Core System (`/system/`)
- **Navigation**: System overview and guidance documents
- **Principles**: Decision-making frameworks and standards  
- **Processes**: Detailed workflows and methodologies
- **Personalities**: Role-based interaction patterns

### Specialized Agents (`/agents/`)
Task-specific agents for complex workflows:
- **testing-strategy-specialist**: TDD/BDD methodology implementation
- **performance-optimization-specialist**: System performance analysis
- **security-validator**: Security validation and vulnerability assessment
- **integration-specialist**: API and service integration
- And many more specialized agents

### Hooks System (`/hooks/`)
Event-driven automation:
- Pre/post tool execution hooks
- Validation and security hooks
- Workflow automation triggers

### Operations (`/operations/`)
Timestamped work sessions:
- Experimental work areas
- Session-specific files and reports
- Temporary development artifacts

## Getting Started

### Prerequisites
- Node.js >= 14.0.0
- Claude Code CLI installed
- Git repository initialized

### Initial Setup
```bash
# Clone or initialize in existing Claude workspace
cd ~/.claude

# Install dependencies if package.json exists
npm install

# Verify framework structure
ls -la
```

### Basic Usage
```bash
# Start with main framework instructions
cat CLAUDE.md

# Check current organization
cat ORGANIZATION-WORKFLOW.md

# Review system documentation
ls system/
```

## Development

### Framework Principles
1. **Simple and Easy**: Keep complexity minimal, make tasks straightforward
2. **Evidence-Based**: All claims must be backed by tests, measurements, or verification
3. **Systematic**: Follow established workflows and patterns
4. **Organized**: Maintain clear file structure and logical organization

### Development Workflow
1. **Planning**: Use TodoWrite for multi-step tasks
2. **Implementation**: Follow TDD/BDD methodologies
3. **Validation**: Provide evidence and demonstration
4. **Documentation**: Update relevant documentation
5. **Organization**: Ensure proper file placement

### Quality Standards
- **100% Test Coverage**: All code must be fully tested
- **Evidence Required**: Claims must be demonstrable
- **Clear Organization**: Files must be properly categorized
- **Documentation**: Changes must be documented

## Contributing

### Getting Started
1. Understand the immovable constraints
2. Follow organization guidelines
3. Respect the Simple and Easy principles
4. Provide evidence for all changes

### Pull Request Guidelines
- [ ] Files organized according to structure guidelines
- [ ] No working files left in root directory
- [ ] Immovable directories left untouched
- [ ] Documentation updated for structural changes
- [ ] Tests included where applicable
- [ ] Evidence provided for claims

### Reporting Issues
When reporting structural or organizational issues:
- Identify specific files that seem misplaced
- Explain why current organization isn't working
- Suggest improvements that respect constraints
- Consider impact on system functionality

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### MIT License Summary
- ✅ **Use**: Commercial and private use allowed
- ✅ **Modify**: Modification allowed
- ✅ **Distribute**: Distribution allowed  
- ✅ **Sublicense**: Sublicensing allowed
- ⚠️ **Limitation**: No liability or warranty provided
- 📋 **Condition**: License and copyright notice must be included

---

## Appendix

### Historical Context

This framework evolved from recognizing the need to work within system constraints while maintaining logical organization. The immovable directories represent integration points with Claude Code's core systems and external services.

### Design Philosophy

**Constraint-Aware Organization**: Rather than fighting system constraints, the framework embraces them as fixed points around which to build logical structure. This creates a more stable and predictable development environment.

**Evidence-Based Iteration**: Every organizational decision is backed by evidence of improved workflow, reduced confusion, or better system integration.

**Progressive Enhancement**: The structure evolves based on actual usage patterns while maintaining backward compatibility and system integration.

---

**Built with constraint awareness and systematic organization principles**

*This README serves as the definitive guide to the Claude Framework's structure and the rationale behind its organization decisions.*