---
title: "CLAUDE.md Project Type Variants"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../claude-md-templates.md", "../../principles/claude-md.md"]
prerequisites: ["Understanding of project types", "Knowledge of template variables"]
audience: "Project developers and system integrators"
purpose: "Provide specialized CLAUDE.md templates for different project types"
keywords: ["claude-md", "templates", "project-types", "web-app", "api", "library"]
last_review: "2025-08-18"
---

[Previous: Study claude-md-templates.md for base structure](../claude-md-templates.md) | [Return to hub for navigation](../../index.md) | [Review PRINCIPLES.md for framework](../../PRINCIPLES.md) | [Next: Apply claude-md-generation.md for automation](claude-md-generation.md)

# CLAUDE.md PROJECT TYPE VARIANTS

## Table of Contents
- [Purpose](#purpose)
- [Web Application Template](#web-application-template)
- [API Service Template](#api-service-template)
- [Library/Tool Template](#librarytool-template)
- [Template Variables](#template-variables)
- [Cross-References](#cross-references)

## Purpose

⏺ **Principle**: This component specializes [claude-md.md](../../principles/claude-md.md) templates for specific project types, ensuring optimal integration patterns for each development context.

Provide specialized CLAUDE.md templates optimized for different project types while maintaining framework integration standards.

## Web Application Template

```markdown
# Project Instructions - {{PROJECT_NAME}} Web App

## Operational Framework Integration
[Standard framework integration block]

## Web Application Context
- **Type**: Web application built with {{FRONTEND_FRAMEWORK}} + {{BACKEND_FRAMEWORK}}
- **Purpose**: {{APP_PURPOSE}} with user interface integration
- **Database**: {{DATABASE_TYPE}} for data persistence
- **Deployment**: {{HOSTING_PLATFORM}} with {{CI_CD_SYSTEM}}

## Development Workflow
1. **Frontend**: Execute [analyze-file.md](commands/analyze-file.md) on components/
2. **Backend**: Deploy [project-optimizer.md](agents/project-optimizer.md) for API analysis
3. **Database**: Follow [engineering.md](docs/principles/engineering.md) for schema design
4. **Testing**: Run {{FRONTEND_TEST}} and {{BACKEND_TEST}} sequentially

## Critical Web App Requirements
- Performance: Load time under {{LOAD_TIME_LIMIT}}
- Security: Authentication via {{AUTH_METHOD}}
- Accessibility: WCAG {{ACCESSIBILITY_LEVEL}} compliance
```

### Web App Variables
```yaml
# Web Application Specific
FRONTEND_FRAMEWORK: "React | Vue | Angular | Svelte"
BACKEND_FRAMEWORK: "Node.js | Django | Rails | .NET"
DATABASE_TYPE: "PostgreSQL | MongoDB | MySQL"
HOSTING_PLATFORM: "Vercel | Netlify | AWS | Azure"
CI_CD_SYSTEM: "GitHub Actions | GitLab CI | Jenkins"
APP_PURPOSE: "Specific application goal"
FRONTEND_TEST: "npm test | yarn test"
BACKEND_TEST: "npm run test:api | pytest"
LOAD_TIME_LIMIT: "2s | 3s | specific requirement"
AUTH_METHOD: "JWT | OAuth | Auth0"
ACCESSIBILITY_LEVEL: "A | AA | AAA"
```

## API Service Template

```markdown
# Project Instructions - {{PROJECT_NAME}} API

## Operational Framework Integration
[Standard framework integration block]

## API Service Context
- **Type**: REST/GraphQL API built with {{API_FRAMEWORK}}
- **Purpose**: {{API_PURPOSE}} for {{CLIENT_SYSTEMS}}
- **Database**: {{DATABASE_TYPE}} with {{ORM_LIBRARY}}
- **Documentation**: {{API_DOC_TOOL}} for endpoint documentation

## API Development Workflow
1. **Schema**: Follow [engineering.md](docs/principles/engineering.md) for design
2. **Endpoints**: Apply [workflow.md](docs/principles/workflow.md) for implementation
3. **Testing**: Run {{UNIT_TESTS}} then {{INTEGRATION_TESTS}}
4. **Documentation**: Update {{API_DOC_COMMAND}} after changes

## Critical API Requirements
- Performance: Response time under {{RESPONSE_TIME_LIMIT}}
- Security: Authentication via {{AUTH_STRATEGY}}
- Versioning: Semantic versioning with {{VERSION_STRATEGY}}
```

### API Service Variables
```yaml
# API Service Specific
API_FRAMEWORK: "Express | FastAPI | Spring Boot | ASP.NET"
API_PURPOSE: "Specific API functionality"
CLIENT_SYSTEMS: "Web app | Mobile app | External systems"
ORM_LIBRARY: "Prisma | SQLAlchemy | ActiveRecord"
API_DOC_TOOL: "OpenAPI | GraphQL Playground | Postman"
UNIT_TESTS: "jest | pytest | JUnit"
INTEGRATION_TESTS: "supertest | requests | TestNG"
API_DOC_COMMAND: "swagger generate | graphql codegen"
RESPONSE_TIME_LIMIT: "100ms | 500ms | specific requirement"
AUTH_STRATEGY: "API keys | OAuth | JWT"
VERSION_STRATEGY: "URL versioning | Header versioning"
```

## Library/Tool Template

```markdown
# Project Instructions - {{PROJECT_NAME}} Library

## Operational Framework Integration
[Standard framework integration block]

## Library Context
- **Type**: {{LIBRARY_TYPE}} library for {{TARGET_LANGUAGE}}
- **Purpose**: {{LIBRARY_PURPOSE}} for {{USER_COMMUNITY}}
- **Package Manager**: {{PACKAGE_MANAGER}} distribution
- **Documentation**: {{DOC_GENERATOR}} for API reference

## Library Development Workflow
1. **API Design**: Follow [fundamental.md](docs/principles/fundamental.md) for simplicity
2. **Implementation**: Apply [engineering.md](docs/principles/engineering.md) standards
3. **Testing**: Ensure {{COVERAGE_REQUIREMENT}}% test coverage
4. **Documentation**: Generate docs with {{DOC_COMMAND}}

## Critical Library Requirements
- Compatibility: Support {{SUPPORTED_VERSIONS}}
- Size: Bundle size under {{SIZE_LIMIT}}
- Dependencies: Minimize to {{MAX_DEPENDENCIES}} packages
```

### Library Variables
```yaml
# Library Specific
LIBRARY_TYPE: "Utility | Framework | SDK | CLI tool"
TARGET_LANGUAGE: "JavaScript | Python | Go | Rust"
LIBRARY_PURPOSE: "Specific library functionality"
USER_COMMUNITY: "Web developers | Data scientists | DevOps"
PACKAGE_MANAGER: "npm | PyPI | crates.io | Go modules"
DOC_GENERATOR: "JSDoc | Sphinx | rustdoc"
COVERAGE_REQUIREMENT: "80 | 90 | 95"
DOC_COMMAND: "npm run docs | sphinx-build"
SUPPORTED_VERSIONS: "Node 14+ | Python 3.8+ | specific versions"
SIZE_LIMIT: "100KB | 1MB | specific size"
MAX_DEPENDENCIES: "5 | 10 | specific number"
```

## Template Variables

### Common Variables Across All Types
```yaml
# Base Template Variables (used in all project types)
PROJECT_NAME: "Project display name"
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
```

[⬆ Return to top](#claude-md-project-type-variants)

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../../index.md)
- [Study claude-md-templates.md for base structure](../claude-md-templates.md)
- [Apply claude-md-generation.md for automation](claude-md-generation.md)
- [Follow claude-md-validation.md for quality](claude-md-validation.md)

### Related Principles
- [Apply claude-md.md for project integration](../../principles/claude-md.md)
- [Follow engineering.md for technical standards](../../principles/engineering.md)
- [Use fundamental.md for simplicity](../../principles/fundamental.md)

### Related Components
- [Study claude-md-templates.md for base patterns](../claude-md-templates.md)
- [Apply workflow-phases.md for execution](../workflow-phases.md)
- [Follow engineering-standards.md for quality](../engineering-standards.md)

[⬆ Return to top](#claude-md-project-type-variants)