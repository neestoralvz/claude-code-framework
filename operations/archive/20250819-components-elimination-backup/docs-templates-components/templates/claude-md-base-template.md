
[Previous: Study claude-md-templates.md for overview](../claude-md-templates.md) | [Return to hub for navigation](../../philosophy/index.md) | [Review PRINCIPLES.md for framework](../principles/PRINCIPLES.md) | [Next: Apply claude-md-project-variants.md for specialization](claude-md-project-variants.md)

# CLAUDE.md BASE TEMPLATE

## Table of Contents
- [Purpose](#purpose)
- [Architecture](#architecture)
- [Available Components](#available-components)
- [Usage Guidelines](#usage-guidelines)
- [Implementation Guide](#implementation-guide)
- [Benefits](#benefits)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Purpose

⏺ **Principle**: This component provides the foundational implementation of [claude-md.md](../../../principles/claude-md.md) principles through a standardized base template that ensures consistent project integration.

Provide the core CLAUDE.md template structure that forms the foundation for all project-specific implementations.

## Minimal Structure

### Complete Base Template
```markdown
# Project Instructions - {{PROJECT_NAME}}

## Operational Framework Integration
Operate within the Claude operational framework:
- **Principles**: Apply [workflow.md](../../../principles/workflow.md) phases systematically
- **Commands**: Execute [commands/](commands/) for specific operations
- **Agents**: Deploy [agents/](agents/) for complex tasks
- **Structure**: Follow [PROJECT_STRUCTURE.md](../../../../PROJECT_STRUCTURE.md) organization

## Project Context
- **Type**: {{PROJECT_TYPE}} built with {{TECH_STACK}}
- **Purpose**: {{PROJECT_PURPOSE}} within operational framework
- **Integration**: {{INTEGRATION_METHOD}}

## Key Directories & Framework Alignment
- **Main entry**: {{MAIN_PATH}} - integrate with {{PRINCIPLE_REFERENCE}}
- **Configuration**: {{CONFIG_PATH}} - follow [engineering.md](../../../principles/engineering.md)
- **Tests**: {{TEST_PATH}} - run {{TEST_COMMAND}}
- **Build**: {{BUILD_PATH}} - execute {{BUILD_COMMAND}}

## Workflow Integration
1. **Analysis**: Execute [analyze-file.md](commands/analyze-file.md) for project examination
2. **Development**: Follow [workflow.md](../../../principles/workflow.md) phases systematically
3. **Testing**: Run {{TEST_COMMAND}} then verify with {{VALIDATION_METHOD}}
4. **Deployment**: Execute {{DEPLOY_COMMAND}} aligned with [engineering.md](../../../principles/engineering.md)

## Critical Project Requirements
- {{REQUIREMENT_1}}
- {{REQUIREMENT_2}}
- {{REQUIREMENT_3}}

## Framework Compliance
- **Always**: Follow [CLAUDE.md](../../../../CLAUDE.md) operational directives
- **File Management**: Apply [files.md](../../../principles/files.md) for all operations
- **Communication**: Use [communication.md](../../../principles/communication.md) imperative tone
```

## Template Variables

### Required Variables
```yaml
# Core Project Identity
PROJECT_NAME: "Project display name"
PROJECT_TYPE: "Web app | API | Tool | System | Library"
PROJECT_PURPOSE: "Specific goal within framework"
TECH_STACK: "Primary technologies used"
INTEGRATION_METHOD: "How project connects to operational system"

# Path Configuration
MAIN_PATH: "src/ | app/ | lib/ | main.py"
CONFIG_PATH: "config/ | .env | settings/"
TEST_PATH: "tests/ | __tests__ | spec/"
BUILD_PATH: "dist/ | build/ | target/"

# Command Configuration
TEST_COMMAND: "npm test | pytest | cargo test"
BUILD_COMMAND: "npm run build | python setup.py | cargo build"
DEPLOY_COMMAND: "npm run deploy | docker-compose up"
VALIDATION_METHOD: "how to verify success"

# Principle Integration
PRINCIPLE_REFERENCE: "specific principle for main entry integration"

# Critical Requirements (1-3 constraints)
REQUIREMENT_1: "Performance constraint"
REQUIREMENT_2: "Security requirement"  
REQUIREMENT_3: "Integration standard"
```

### Optional Enhancement Variables
```yaml
# Extended Configuration (use when needed)
DATABASE_TYPE: "PostgreSQL | MongoDB | MySQL | SQLite"
HOSTING_PLATFORM: "Vercel | AWS | Azure | Self-hosted"
CI_CD_SYSTEM: "GitHub Actions | GitLab CI | Jenkins"
AUTH_METHOD: "JWT | OAuth | API Keys | Custom"
MONITORING_TOOLS: "Specific monitoring and logging tools"
BACKUP_STRATEGY: "Data backup and recovery approach"
SCALING_APPROACH: "Horizontal | Vertical | Auto-scaling"
```

## Integration Blocks

### Standard Framework Integration Block
```markdown
## Operational Framework Integration
Operate within the Claude operational framework:
- **Principles**: Apply [workflow.md](../../../principles/workflow.md) phases systematically
- **Commands**: Execute [commands/](commands/) for specific operations
- **Agents**: Deploy [agents/](agents/) for complex tasks
- **Structure**: Follow [PROJECT_STRUCTURE.md](../../../../PROJECT_STRUCTURE.md) organization
```

### Workflow Integration Block
```markdown
## Workflow Integration
1. **Analysis**: Execute [analyze-file.md](commands/analyze-file.md) for project examination
2. **Development**: Follow [workflow.md](../../../principles/workflow.md) phases systematically
3. **Testing**: Run {{TEST_COMMAND}} then verify with {{VALIDATION_METHOD}}
4. **Deployment**: Execute {{DEPLOY_COMMAND}} aligned with [engineering.md](../../../principles/engineering.md)
```

### Framework Compliance Block
```markdown
## Framework Compliance
- **Always**: Follow [CLAUDE.md](../../../../CLAUDE.md) operational directives
- **File Management**: Apply [files.md](../../../principles/files.md) for all operations
- **Communication**: Use [communication.md](../../../principles/communication.md) imperative tone
```

## Customization Guidelines

### When to Use Base Template
- **Simple Projects**: Single-purpose tools or utilities
- **Standard Workflows**: Projects using common development patterns
- **Quick Setup**: When rapid CLAUDE.md creation is priority
- **Template Foundation**: As starting point for specialized variants

### Customization Process
1. **Copy Base Template**: Start with complete structure above
2. **Replace Variables**: Substitute {{VARIABLE}} placeholders with actual values
3. **Add Project Specifics**: Include unique requirements and constraints
4. **Validate Integration**: Test all referenced commands and paths
5. **Review Compliance**: Ensure adherence to framework principles

### Common Customizations
- **Additional Commands**: Include project-specific command references
- **Extended Requirements**: Add domain-specific constraints
- **Custom Workflows**: Modify workflow steps for project needs
- **Tool Integration**: Include specific development tools and practices

### Validation Checklist
- [ ] All variables replaced with actual values
- [ ] No unresolved {{VARIABLE}} placeholders remain
- [ ] All referenced commands exist and are accessible
- [ ] Project paths are valid and functional
- [ ] Requirements are specific and measurable
- [ ] Framework integration blocks are complete
- [ ] File length under 200 lines (recommended)

[⬆ Return to top](#claude-md-base-template)

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../../philosophy/index.md)
- [Study claude-md-templates.md for overview](../claude-md-templates.md)
- [Apply claude-md-project-variants.md for specialization](claude-md-project-variants.md)
- [Follow claude-md-generation.md for automation](claude-md-generation.md)

### Related Principles
- [Apply claude-md.md for project integration principles](../../../principles/claude-md.md)
- [Follow workflow.md for systematic execution](../../../principles/workflow.md)
- [Use engineering.md for technical standards](../../../principles/engineering.md)

### Related Components
- [Study claude-md-templates.md for navigation](../claude-md-templates.md)
- [Apply workflow-phases.md for execution](../workflow-phases.md)
- [Follow engineering-standards.md for quality](../engineering-standards.md)

[⬆ Return to top](#claude-md-base-template)
