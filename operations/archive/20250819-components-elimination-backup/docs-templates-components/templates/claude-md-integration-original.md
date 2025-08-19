
[Previous: claude-md-validation.md](claude-md-validation.md) | [Hub](../../philosophy/index.md) | [Next: ../claude-md-templates.md](../claude-md-templates.md)

# CLAUDE.md INTEGRATION PATTERNS

⏺ **Principle**: Operationalizes [claude-md.md](../../../principles/claude-md.md) by connecting project instructions with framework components.

## Command Integration

### Core Operations Template
```markdown
## Framework Command Integration
- **Analysis**: Execute [analyze-file.md](commands/analyze-file.md) on {{KEY_DIRECTORIES}}
- **Optimization**: Deploy [project-optimizer.md](../../../../agents/project-management/coordination/project-optimizer.md) when {{TRIGGERS}}
- **Documentation**: Run [update-docs.md](commands/update-docs.md) after {{EVENTS}}
- **Auditing**: Apply [system-audit.md](../../../../commands/domains/analysis/workflows/system-audit.md) for {{SCHEDULE}}
```

### Integration Checklist
- [ ] All commands exist in `commands/` directory
- [ ] Execution rights configured
- [ ] Dependencies documented
- [ ] CI/CD integration established

## Agent Integration

### Agent Deployment Template
```markdown
## Framework Agent Integration
- **Analysis**: Deploy [project-optimizer.md](../../../../agents/project-management/coordination/project-optimizer.md) for reviews
- **Architecture**: Use [agent-architect.md](../../../../agents/development/architecture/agent-architect.md) for design validation
- **General Tasks**: Apply [general-purpose.md](agents/general-purpose.md) for workflows
```

### Deployment Triggers
- **Performance**: When thresholds exceeded
- **Architecture**: For major changes
- **Quality**: When metrics decline
- **Releases**: Before deployment

## Principle Integration

### Framework Application
```markdown
## Operational Principle Integration
- **Workflow**: Follow [workflow.md](../../../principles/workflow.md) phases
- **Communication**: Apply [communication.md](../../../principles/communication.md) standards
- **Engineering**: Implement [engineering.md](../../../principles/engineering.md) quality
- **Files**: Use [files.md](../../../principles/files.md) operations
```

### Project Customization
- **Quality Gates**: Align with engineering standards
- **Communication**: Follow framework communication style
- **Workflow**: Implement systematic phases
- **Organization**: Apply structure rules

## Custom Extensions

### Extension Development
1. **Commands**: Use [command-template.md](../../command-template.md)
2. **Agents**: Follow [AGENT_TEMPLATE.md](docs/agents-documentation/AGENT_TEMPLATE.md)
3. **Principles**: Maintain compatibility with core framework

### Extension Template
```markdown
## Project Extensions
- **Custom Commands**: [custom-command.md](commands/custom-command.md)
- **Custom Agents**: [project-agent.md](agents/project-agent.md)
- **Custom Principles**: [project-standards.md](docs/principles/project-standards.md)
```

## Cross-References
- [Hub](../../philosophy/index.md) | [claude-md-templates.md](../claude-md-templates.md)
- [claude-md-project-variants.md](claude-md-project-variants.md) | [claude-md-generation.md](claude-md-generation.md)
