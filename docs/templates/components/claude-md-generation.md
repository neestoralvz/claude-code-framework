---
title: "CLAUDE.md Generation Component"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["claude-md-base-template.md", "claude-md-project-variants.md"]
prerequisites: ["CLAUDE.md template understanding"]
audience: "Project developers"
purpose: "Automate CLAUDE.md file generation"
keywords: ["claude-md", "generation", "automation", "scripts"]
last_review: "2025-08-18"
---

[Previous: claude-md-project-variants.md](claude-md-project-variants.md) | [Next: claude-md-validation.md](claude-md-validation.md)

# CLAUDE.MD GENERATION COMPONENT

⏺ **Principle**: This component automates [claude-md-base-template.md](claude-md-base-template.md) deployment.

## Generation Script Template
```bash
#!/bin/bash
# generate-claude-md.sh

PROJECT_NAME="$1"
PROJECT_TYPE="$2"
TECH_STACK="$3"

# Validate inputs
if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_TYPE" ] || [ -z "$TECH_STACK" ]; then
    echo "Usage: $0 <project_name> <project_type> <tech_stack>"
    exit 1
fi

# Select template based on project type
case "$PROJECT_TYPE" in
    "web")
        TEMPLATE="web-app-template.md"
        ;;
    "api")
        TEMPLATE="api-service-template.md"
        ;;
    "library")
        TEMPLATE="library-template.md"
        ;;
    *)
        TEMPLATE="base-template.md"
        ;;
esac

# Generate CLAUDE.md with variable substitution
sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{PROJECT_TYPE}}/$PROJECT_TYPE/g" \
    -e "s/{{TECH_STACK}}/$TECH_STACK/g" \
    "docs/templates/components/templates/$TEMPLATE" > CLAUDE.md

echo "Generated CLAUDE.md for $PROJECT_NAME ($PROJECT_TYPE)"
```

## Configuration-Driven Generation
```yaml
# claude-md-config.yaml
project:
  name: "MyProject"
  type: "web"
  tech_stack: "React + Node.js"
  purpose: "User management system"

paths:
  main: "src/"
  config: ".env"
  tests: "tests/"
  build: "dist/"

commands:
  test: "npm test"
  build: "npm run build"
  deploy: "npm run deploy"

requirements:
  - "Performance: Load under 2s"
  - "Security: JWT authentication"
  - "Testing: 80% coverage minimum"
```

## Framework Integration Pattern
```markdown
## Dynamic Command Usage
- **Project Analysis**: Execute [analyze-file.md](commands/analyze-file.md) on {{KEY_DIRECTORIES}}
- **Optimization**: Deploy [project-optimizer.md](agents/project-optimizer.md) when {{OPTIMIZATION_TRIGGER}}
- **Documentation**: Run [update-docs.md](commands/update-docs.md) after {{DOC_TRIGGER}}

### Custom Command Extensions
When project requires operations beyond standard commands:
1. Create project-specific commands in [commands/](commands/) directory
2. Follow [command-template.md](../templates/command-template.md) structure
3. Reference relevant [principles](docs/principles/) for methodology

## Intelligent Agent Deployment
- **Complex Analysis**: Deploy [project-optimizer.md](agents/project-optimizer.md) for comprehensive review
- **Architecture Review**: Use [general-purpose.md](agents/general-purpose.md) for multi-step tasks
- **Custom Needs**: Create project agents following [AGENT_TEMPLATE.md](docs/agents-documentation/AGENT_TEMPLATE.md)

### Agent Customization
For project-specific intelligent assistance:
1. Identify recurring complex tasks
2. Design agent specification using template
3. Integrate with existing workflow phases
```

## Cross-References
- [Build on claude-md-base-template.md](claude-md-base-template.md)
- [Use claude-md-project-variants.md for types](claude-md-project-variants.md)
- [Validate with claude-md-validation.md](claude-md-validation.md)