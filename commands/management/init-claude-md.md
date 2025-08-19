---
title: "Initialize CLAUDE.md for New Projects"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../../docs/PRINCIPLES.md", "../../docs/components/templates/claude-md-base-template.md", "../../docs/principles/claude-md.md"]
prerequisites: ["Understanding of operational framework", "Project context knowledge"]
audience: "Project developers and system integrators"
purpose: "Generate CLAUDE.md file for new projects with proper framework integration and global rule inheritance"
keywords: ["init", "claude-md", "project-setup", "framework-integration", "global-rules"]
last_review: "2025-08-18"
---

[Previous: Navigate to commands index](../index.md) | [Return to hub for navigation](../../docs/index.md) | [Review PRINCIPLES.md for framework](../../docs/PRINCIPLES.md) | [Next: Deploy create-ticket.md for tracking](create-ticket.md)

# INITIALIZE CLAUDE.MD FOR NEW PROJECTS

## Table of Contents
- [Purpose](#purpose)
- [Command Overview](#command-overview)
- [Execution Process](#execution-process)
- [Template Generation](#template-generation)
- [Framework Integration](#framework-integration)
- [Validation Requirements](#validation-requirements)
- [Usage Examples](#usage-examples)
- [Cross-References](#cross-references)

## Purpose

⏺ **Principle**: This command implements [claude-md.md project integration principles](../../docs/principles/claude-md.md) for systematic CLAUDE.md generation with proper global framework inheritance.

Generate project-specific CLAUDE.md file that inherits global operational rules and establishes proper authority structure for new projects.

## Command Overview

### Core Functionality
- **Generate CLAUDE.md**: Create project-specific configuration file
- **Inherit Global Rules**: Reference global operational framework
- **Establish Authority**: Set up proper directive hierarchy
- **Configure Integration**: Connect project to framework components

### Key Features
- Interactive project configuration gathering
- Automatic template variable substitution
- Global principle inheritance validation
- Framework compliance verification

## Execution Process

### Phase 1: Project Analysis
1. **Detect project type**: Analyze existing files and structure
2. **Identify technology stack**: Scan for package.json, requirements.txt, etc.
3. **Determine main paths**: Locate source, test, and build directories
4. **Assess existing configuration**: Check for existing CLAUDE.md or similar

### Phase 2: Configuration Gathering
1. **Prompt for project details**: Name, purpose, and key requirements
2. **Validate technology detection**: Confirm or correct detected stack
3. **Configure build commands**: Set up test, build, and deploy commands
4. **Define critical requirements**: Establish 1-3 key project constraints

### Phase 3: Template Generation
1. **Load base template**: Use [claude-md-base-template.md](../../docs/components/templates/claude-md-base-template.md)
2. **Substitute variables**: Replace all {{VARIABLE}} placeholders
3. **Add global framework references**: Link to operational framework
4. **Insert project-specific sections**: Include unique requirements

### Phase 4: Framework Integration
1. **Establish authority structure**: Reference global CLAUDE.md as ultimate authority
2. **Link to global principles**: Connect project to [PRINCIPLES.md](../../docs/PRINCIPLES.md)
3. **Configure command access**: Set up references to [commands/](../index.md)
4. **Enable agent deployment**: Link to [agents/](../../agents/) for complex tasks

### Phase 5: Validation and Finalization
1. **Validate all references**: Ensure all links point to existing files
2. **Check compliance**: Verify adherence to framework principles
3. **Test command integration**: Validate build and test commands work
4. **Create PROJECT_STRUCTURE.md**: Generate structure documentation if needed

## Template Generation

### Base Structure with Global Integration
```markdown
# Project Instructions - {{PROJECT_NAME}}

## Global Framework Authority
**This project operates under the Claude Operational Framework governed by the global CLAUDE.md.**
- **Ultimate Authority**: All operations defer to [global CLAUDE.md](~/.claude/CLAUDE.md)
- **Principles**: Apply [global principles](~/.claude/docs/principles/) systematically
- **Commands**: Execute [global commands](~/.claude/commands/) for operations
- **Agents**: Deploy [global agents](~/.claude/agents/) for complex tasks

## Project Context
- **Type**: {{PROJECT_TYPE}} built with {{TECH_STACK}}
- **Purpose**: {{PROJECT_PURPOSE}}
- **Integration Method**: {{INTEGRATION_METHOD}}

## Framework Compliance Requirements
### Mandatory Global Rule Inheritance
- **ALL operations MUST follow [8-phase workflow](~/.claude/docs/principles/workflow.md)**
- **ALL file operations MUST apply [files.md](~/.claude/docs/principles/files.md) standards**
- **ALL communication MUST use [communication.md](~/.claude/docs/principles/communication.md) imperative tone**
- **ALL tasks MUST use agents from [~/.claude/agents/](~/.claude/agents/) - NO DIRECT EXECUTION**

## Project-Specific Configuration
### Key Directories
- **Main entry**: {{MAIN_PATH}}
- **Configuration**: {{CONFIG_PATH}}
- **Tests**: {{TEST_PATH}} - run {{TEST_COMMAND}}
- **Build**: {{BUILD_PATH}} - execute {{BUILD_COMMAND}}

### Development Workflow
1. **Analysis**: Execute [analyze-file.md](~/.claude/commands/analysis/analyze-file.md)
2. **Development**: Follow [workflow.md](~/.claude/docs/principles/workflow.md) phases
3. **Testing**: Run {{TEST_COMMAND}} then validate
4. **Deployment**: Execute {{DEPLOY_COMMAND}}

## Critical Project Requirements
- {{REQUIREMENT_1}}
- {{REQUIREMENT_2}}
- {{REQUIREMENT_3}}

## Authority Declaration
- **Global Rules**: This CLAUDE.md inherits ALL rules from [~/.claude/CLAUDE.md](~/.claude/CLAUDE.md)
- **Local Extensions**: Project-specific rules supplement but never override global rules
- **Conflict Resolution**: Global framework always takes precedence
```

### Variable Substitution Map
```yaml
PROJECT_NAME: "Detected or prompted project name"
PROJECT_TYPE: "Auto-detected: Web App | API | Tool | Library | System"
PROJECT_PURPOSE: "User-provided project description"
TECH_STACK: "Auto-detected: React/Node | Python/Django | Rust | Go | etc."
INTEGRATION_METHOD: "How project connects to global framework"
MAIN_PATH: "Auto-detected: src/ | app/ | lib/ | main directory"
CONFIG_PATH: "Auto-detected: config/ | .env | settings directory"
TEST_PATH: "Auto-detected: tests/ | __tests__ | spec/ directory"
BUILD_PATH: "Auto-detected: dist/ | build/ | target/ directory"
TEST_COMMAND: "Auto-detected: npm test | pytest | cargo test"
BUILD_COMMAND: "Auto-detected: npm run build | python setup.py"
DEPLOY_COMMAND: "User-provided or standard deployment command"
REQUIREMENT_1: "User-provided critical requirement"
REQUIREMENT_2: "User-provided critical requirement"  
REQUIREMENT_3: "User-provided critical requirement"
```

## Framework Integration

### Global Authority Establishment
```markdown
## Global Framework Authority
**This project operates under the Claude Operational Framework governed by the global CLAUDE.md.**
- **Ultimate Authority**: All operations defer to [global CLAUDE.md](~/.claude/CLAUDE.md)
- **Principles**: Apply [global principles](~/.claude/docs/principles/) systematically
- **Commands**: Execute [global commands](~/.claude/commands/) for operations
- **Agents**: Deploy [global agents](~/.claude/agents/) for complex tasks
```

### Mandatory Rule Inheritance
```markdown
## Framework Compliance Requirements
### Mandatory Global Rule Inheritance
- **ALL operations MUST follow [8-phase workflow](~/.claude/docs/principles/workflow.md)**
- **ALL file operations MUST apply [files.md](~/.claude/docs/principles/files.md) standards**
- **ALL communication MUST use [communication.md](~/.claude/docs/principles/communication.md) imperative tone**
- **ALL tasks MUST use agents from [~/.claude/agents/](~/.claude/agents/) - NO DIRECT EXECUTION**
```

### Authority Declaration
```markdown
## Authority Declaration
- **Global Rules**: This CLAUDE.md inherits ALL rules from [~/.claude/CLAUDE.md](~/.claude/CLAUDE.md)
- **Local Extensions**: Project-specific rules supplement but never override global rules
- **Conflict Resolution**: Global framework always takes precedence
```

## Validation Requirements

### Pre-Generation Checks
- [ ] Target directory is a valid project (has package.json, requirements.txt, or similar)
- [ ] No existing CLAUDE.md file (or confirm overwrite)
- [ ] Write permissions in target directory
- [ ] Global framework files accessible

### Post-Generation Validation
- [ ] All {{VARIABLE}} placeholders replaced
- [ ] All global framework references valid
- [ ] Test command executes successfully
- [ ] Build command executes successfully
- [ ] No forbidden patterns present
- [ ] File length under 200 lines
- [ ] Authority structure properly established

### Compliance Verification
- [ ] Global CLAUDE.md authority properly referenced
- [ ] All mandatory global rules included
- [ ] No conflicting local rules defined
- [ ] Framework integration blocks complete
- [ ] Command and agent references valid

## Usage Examples

### Basic Web Application
```bash
# Navigate to project directory
cd /path/to/my-react-app

# Execute command
claude init-claude-md

# Interactive prompts:
# Project name: My React App
# Purpose: User dashboard with real-time analytics
# Critical requirements: 
#   1. Sub-second load times
#   2. GDPR compliance
#   3. 99.9% uptime
```

### Python API Project
```bash
# Navigate to project directory
cd /path/to/my-fastapi

# Execute with detected settings
claude init-claude-md

# Auto-detected:
# - Type: API
# - Tech Stack: Python/FastAPI
# - Test Command: pytest
# - Build Command: python setup.py build
```

### Library/Tool Project
```bash
# Navigate to project directory
cd /path/to/my-rust-tool

# Execute command
claude init-claude-md

# Auto-detected:
# - Type: Tool
# - Tech Stack: Rust
# - Test Command: cargo test
# - Build Command: cargo build --release
```

[⬆ Return to top](#initialize-claude-md-for-new-projects)

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../../docs/index.md)
- [Browse commands index for tools](../index.md)
- [Deploy create-ticket.md for systematic tracking](create-ticket.md)
- [Review PRINCIPLES.md for framework](../../docs/PRINCIPLES.md)

### Related Principles
- [Apply claude-md.md for project integration](../../docs/principles/claude-md.md)
- [Follow workflow.md for systematic execution](../../docs/principles/workflow.md)
- [Use files.md for file management](../../docs/principles/files.md)
- [Apply communication.md for tone](../../docs/principles/communication.md)

### Related Components
- [Study claude-md-base-template.md for structure](../../docs/components/templates/claude-md-base-template.md)
- [Apply claude-md-templates.md for variants](../../docs/components/templates/claude-md-templates.md)
- [Use engineering-standards.md for quality](../../docs/components/engineering-standards.md)

### Related Commands
- [Deploy create-ticket.md for task tracking](create-ticket.md)
- [Execute system-audit.md for analysis](../analysis/system-audit.md)
- [Apply modularize.md for structure](../analysis/modularize.md)

[⬆ Return to top](#initialize-claude-md-for-new-projects)