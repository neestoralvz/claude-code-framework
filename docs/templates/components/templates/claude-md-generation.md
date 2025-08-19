---
title: "CLAUDE.md Generation"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../claude-md-templates.md"]
audience: "Project developers"
purpose: "Automated generation tools for CLAUDE.md files"
keywords: ["claude-md", "generation", "automation"]
---

[Previous: claude-md-project-variants.md](claude-md-project-variants.md) | [Hub](../../index.md) | [Next: claude-md-validation.md](claude-md-validation.md)

# CLAUDE.md GENERATION

⏺ **Principle**: Implements [engineering.md](../../principles/engineering.md) automation standards for systematic CLAUDE.md generation.

## Generation Script

```bash
#!/bin/bash
# generate-claude-md.sh
PROJECT_NAME="$1"
PROJECT_TYPE="$2"
TECH_STACK="$3"

# Validate inputs
if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project_name> <project_type> <tech_stack>"
    exit 1
fi

# Select template
case "$PROJECT_TYPE" in
    "web") TEMPLATE="web-app-template.md" ;;
    "api") TEMPLATE="api-service-template.md" ;;
    *) TEMPLATE="base-template.md" ;;
esac

# Generate with substitution
sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    "docs/templates/components/templates/$TEMPLATE" > CLAUDE.md

echo "✓ Generated CLAUDE.md for $PROJECT_NAME"
```

## Configuration Template

```yaml
# claude-md-config.yaml
project:
  name: "MyProject"
  type: "web"  # web, api, library
  tech_stack: "React + Node.js"
  purpose: "User management system"

commands:
  test: "npm test"
  build: "npm run build"
  deploy: "npm run deploy"

variables:
  frontend_framework: "React"
  backend_framework: "Node.js"
  database_type: "PostgreSQL"
```

## Variable Substitution

### Template Variables
- Standard format: `{{VARIABLE_NAME}}`
- Examples: `{{PROJECT_NAME}}`, `{{TECH_STACK}}`

### Substitution Process
```bash
# Basic substitution with sed
sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{TECH_STACK}}/$TECH_STACK/g" \
    template.md > CLAUDE.md
```

## Automation Integration
- **CI/CD**: GitHub Actions for automatic updates
- **Make**: Makefile targets for generation and validation
- **Validation**: Automated checks for file size and links

## Cross-References
- [Hub](../../index.md) | [claude-md-templates.md](../claude-md-templates.md)
- [claude-md-project-variants.md](claude-md-project-variants.md) | [claude-md-validation.md](claude-md-validation.md)