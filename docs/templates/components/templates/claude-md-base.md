---
title: "Base CLAUDE.md Template"
component_type: "template"
parent: "../claude-md-templates.md"
version: "1.0.0"
---

# Base CLAUDE.md Template

⏺ **Principle**: Implements [claude-md.md](../../principles/claude-md.md) principles through standardized project integration.

## Minimal CLAUDE.md Structure
```markdown
# Project Instructions - {{PROJECT_NAME}}

## Operational Framework Integration
Operate within the Claude operational framework:
- **Principles**: Apply [workflow.md](docs/principles/workflow.md) phases systematically
- **Commands**: Execute [commands/](commands/) for specific operations
- **Agents**: Deploy [agents/](agents/) for complex tasks
- **Structure**: Follow [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) organization

## Project Context
- **Type**: {{PROJECT_TYPE}} built with {{TECH_STACK}}
- **Purpose**: {{PROJECT_PURPOSE}} within operational framework
- **Integration**: {{INTEGRATION_METHOD}}

## Key Directories & Framework Alignment
- **Main entry**: {{MAIN_PATH}} - integrate with {{PRINCIPLE_REFERENCE}}
- **Configuration**: {{CONFIG_PATH}} - follow [engineering.md](docs/principles/engineering.md)
- **Tests**: {{TEST_PATH}} - run {{TEST_COMMAND}}
- **Build**: {{BUILD_PATH}} - execute {{BUILD_COMMAND}}

## Workflow Integration
1. **Analysis**: Execute [analyze-file.md](commands/analyze-file.md) for project examination
2. **Development**: Follow [workflow.md](docs/principles/workflow.md) phases systematically
3. **Testing**: Run {{TEST_COMMAND}} then verify with {{VALIDATION_METHOD}}
4. **Deployment**: Execute {{DEPLOY_COMMAND}} aligned with [engineering.md](docs/principles/engineering.md)

## Critical Project Requirements
- {{REQUIREMENT_1}}
- {{REQUIREMENT_2}}
- {{REQUIREMENT_3}}

## Framework Compliance
- **Always**: Follow [CLAUDE.md](CLAUDE.md) operational directives
- **File Management**: Apply [files.md](docs/principles/files.md) for all operations
- **Communication**: Use [communication.md](docs/principles/communication.md) imperative tone
```

## Template Variables
```yaml
# Required Variables
PROJECT_NAME: "Project display name"
PROJECT_TYPE: "Web app | API | Tool | System | Library"
PROJECT_PURPOSE: "Specific goal within framework"
TECH_STACK: "Primary technologies used"
INTEGRATION_METHOD: "How project integrates with framework"
MAIN_PATH: "Primary entry point path"
CONFIG_PATH: "Configuration directory/files"
TEST_PATH: "Test directory path"
BUILD_PATH: "Build output path"
TEST_COMMAND: "Command to run tests"
BUILD_COMMAND: "Command to build project"
VALIDATION_METHOD: "How to verify results"
DEPLOY_COMMAND: "Deployment command"
PRINCIPLE_REFERENCE: "Relevant principle for main code"
REQUIREMENT_1: "First critical requirement"
REQUIREMENT_2: "Second critical requirement"
REQUIREMENT_3: "Third critical requirement"
```

[Return to claude-md-templates.md](../claude-md-templates.md)