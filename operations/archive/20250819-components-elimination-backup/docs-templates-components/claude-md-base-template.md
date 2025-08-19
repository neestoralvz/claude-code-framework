
[Previous: component navigation](README.md) | [Next: claude-md-project-variants.md](claude-md-project-variants.md)

# CLAUDE.MD BASE TEMPLATE COMPONENT

⏺ **Principle**: This component implements [claude-md.md](../../principles/claude-md.md) with minimal template structure.

## Minimal CLAUDE.md Structure
```markdown
# Project Instructions - {{PROJECT_NAME}}

## Operational Framework Integration
Operate within the Claude operational framework:
- **Principles**: Apply [workflow.md](../../principles/workflow.md) phases systematically
- **Commands**: Execute [commands/](commands/) for specific operations
- **Agents**: Deploy [agents/](agents/) for complex tasks
- **Structure**: Follow [PROJECT_STRUCTURE.md](../../../PROJECT_STRUCTURE.md) organization

## Project Context
- **Type**: {{PROJECT_TYPE}} built with {{TECH_STACK}}
- **Purpose**: {{PROJECT_PURPOSE}} within operational framework
- **Integration**: {{INTEGRATION_METHOD}}

## Key Directories & Framework Alignment
- **Main entry**: {{MAIN_PATH}} - integrate with {{PRINCIPLE_REFERENCE}}
- **Configuration**: {{CONFIG_PATH}} - follow [engineering.md](../../principles/engineering.md)
- **Tests**: {{TEST_PATH}} - run {{TEST_COMMAND}}
- **Build**: {{BUILD_PATH}} - execute {{BUILD_COMMAND}}

## Workflow Integration
1. **Analysis**: Execute [analyze-file.md](commands/analyze-file.md) for project examination
2. **Development**: Follow [workflow.md](../../principles/workflow.md) phases systematically
3. **Testing**: Run {{TEST_COMMAND}} then verify with {{VALIDATION_METHOD}}
4. **Deployment**: Execute {{DEPLOY_COMMAND}} aligned with [engineering.md](../../principles/engineering.md)

## Critical Project Requirements
- {{REQUIREMENT_1}}
- {{REQUIREMENT_2}}
- {{REQUIREMENT_3}}

## Framework Compliance
- **Always**: Follow [CLAUDE.md](../../../CLAUDE.md) operational directives
- **File Management**: Apply [files.md](../../principles/files.md) for all operations
- **Communication**: Use [communication.md](../../principles/communication.md) imperative tone
```

## Template Variables
```yaml
# Required Variables
PROJECT_NAME: "Project display name"
PROJECT_TYPE: "Web app | API | Tool | System | Library"
PROJECT_PURPOSE: "Specific goal within framework"
TECH_STACK: "Primary technologies used"
INTEGRATION_METHOD: "How project connects to operational system"

# Path Variables
MAIN_PATH: "src/ | app/ | lib/ | main.py"
CONFIG_PATH: "config/ | .env | settings/"
TEST_PATH: "tests/ | __tests__ | spec/"
BUILD_PATH: "dist/ | build/ | target/"

# Command Variables
TEST_COMMAND: "npm test | pytest | cargo test"
BUILD_COMMAND: "npm run build | python setup.py | cargo build"
DEPLOY_COMMAND: "npm run deploy | docker-compose up"
VALIDATION_METHOD: "how to verify success"

# Requirements (1-3 critical constraints)
REQUIREMENT_1: "Performance constraint"
REQUIREMENT_2: "Security requirement"  
REQUIREMENT_3: "Integration standard"
```

## Cross-References
- [Study claude-md-project-variants.md for project types](claude-md-project-variants.md)
- [Apply claude-md-generation.md for automation](claude-md-generation.md)
- [Follow claude-md-validation.md for quality checks](claude-md-validation.md)
