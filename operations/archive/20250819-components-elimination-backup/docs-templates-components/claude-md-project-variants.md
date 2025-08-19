
[Previous: claude-md-base-template.md](claude-md-base-template.md) | [Next: claude-md-generation.md](claude-md-generation.md)

# CLAUDE.MD PROJECT VARIANTS COMPONENT

⏺ **Principle**: This component extends [claude-md-base-template.md](claude-md-base-template.md) with project-specific variants.

## Web Application Template
```markdown
# Project Instructions - {{PROJECT_NAME}} Web App

## Operational Framework Integration
[Standard framework integration block from base template]

## Web Application Context
- **Type**: Web application built with {{FRONTEND_FRAMEWORK}} + {{BACKEND_FRAMEWORK}}
- **Purpose**: {{APP_PURPOSE}} with user interface integration
- **Database**: {{DATABASE_TYPE}} for data persistence
- **Deployment**: {{HOSTING_PLATFORM}} with {{CI_CD_SYSTEM}}

## Development Workflow
1. **Frontend**: Execute [analyze-file.md](commands/analyze-file.md) on templates/components/
2. **Backend**: Deploy [project-optimizer.md](../../../agents/project-management/coordination/project-optimizer.md) for API analysis
3. **Database**: Follow [engineering.md](../../principles/engineering.md) for schema design
4. **Testing**: Run {{FRONTEND_TEST}} and {{BACKEND_TEST}} sequentially

## Critical Web App Requirements
- Performance: Load time under {{LOAD_TIME_LIMIT}}
- Security: Authentication via {{AUTH_METHOD}}
- Accessibility: WCAG {{ACCESSIBILITY_LEVEL}} compliance
```

## API Service Template
```markdown
# Project Instructions - {{PROJECT_NAME}} API

## Operational Framework Integration
[Standard framework integration block from base template]

## API Service Context
- **Type**: REST/GraphQL API built with {{API_FRAMEWORK}}
- **Purpose**: {{API_PURPOSE}} for {{CLIENT_SYSTEMS}}
- **Database**: {{DATABASE_TYPE}} with {{ORM_LIBRARY}}
- **Documentation**: {{API_DOC_TOOL}} for endpoint documentation

## API Development Workflow
1. **Schema**: Follow [engineering.md](../../principles/engineering.md) for design
2. **Endpoints**: Apply [workflow.md](../../principles/workflow.md) for implementation
3. **Testing**: Run {{UNIT_TESTS}} then {{INTEGRATION_TESTS}}
4. **Documentation**: Update {{API_DOC_COMMAND}} after changes

## Critical API Requirements
- Performance: Response time under {{RESPONSE_TIME_LIMIT}}
- Security: Authentication via {{AUTH_STRATEGY}}
- Versioning: Semantic versioning with {{VERSION_STRATEGY}}
```

## Library/Tool Template
```markdown
# Project Instructions - {{PROJECT_NAME}} Library

## Operational Framework Integration
[Standard framework integration block from base template]

## Library Context
- **Type**: {{LIBRARY_TYPE}} library for {{TARGET_LANGUAGE}}
- **Purpose**: {{LIBRARY_PURPOSE}} for {{USER_COMMUNITY}}
- **Package Manager**: {{PACKAGE_MANAGER}} distribution
- **Documentation**: {{DOC_GENERATOR}} for API reference

## Library Development Workflow
1. **API Design**: Follow [fundamental.md](../../principles/fundamental.md) for simplicity
2. **Implementation**: Apply [engineering.md](../../principles/engineering.md) standards
3. **Testing**: Ensure {{COVERAGE_REQUIREMENT}}% test coverage
4. **Documentation**: Generate docs with {{DOC_COMMAND}}

## Critical Library Requirements
- Compatibility: Support {{SUPPORTED_VERSIONS}}
- Size: Bundle size under {{SIZE_LIMIT}}
- Dependencies: Minimize to {{MAX_DEPENDENCIES}} packages
```

## Cross-References
- [Use claude-md-base-template.md for foundation](claude-md-base-template.md)
- [Apply claude-md-generation.md for automation](claude-md-generation.md)
- [Follow claude-md-validation.md for quality](claude-md-validation.md)
