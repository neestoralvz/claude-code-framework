# NAVEGACIÓN CENTRALIZADA - MÓDULO REUTILIZABLE

**Propósito**: Una sola fuente de la verdad para todos los enlaces de navegación  
**Uso**: Referenciar desde cualquier archivo de documentación  
**Mantenimiento**: Actualización centralizada garantiza consistencia  

## NAVEGACIÓN PRINCIPAL

### Breadcrumb Principal
```markdown
[🏠 Framework Home](../../CLAUDE.md) | [📚 Docs Hub](../index.md) | [⚡ Commands](../commands-docs/COMMANDS.md) | [🤖 Live Agents](../../agents/) | [🎫 Planning](../../planning/TICKET_REGISTRY.md)
```

### Enlaces de Sección Agents-Docs
```markdown
[📖 Guides](guides/) | [📋 Reference](reference/) | [🎨 Templates](templates/)
```

### Navegación de Retorno
```markdown
[⬆ Return to Navigation](#-comprehensive-navigation)
```

## ENLACES FRAMEWORK PRIMARIOS

### Control Center
```markdown
- **[Framework Control Center](../../CLAUDE.md)** - Central orchestration and execution patterns
```

### Sistemas Principales
```markdown
- **[Live Agent Directory](../../agents/)** - Active specialist deployment location
- **[Commands Architecture](../commands-docs/COMMANDS.md)** - Command-centered execution framework
- **[System Architecture](../architecture/)** - Comprehensive system design patterns
```

## RECURSOS DE SOPORTE

### Ecosistema de Soporte
```markdown
- **[Operational Principles](../principles/)** - Framework governance and execution standards
- **[Strategic Planning](../../planning/)** - Ticket management and task coordination
- **[Pattern Templates](../templates/)** - Reusable architectural components and patterns
- **[Playbook Procedures](../playbook/)** - Operational procedures and quick reference guides
```

### Rutas de Integración Continua
```markdown
- **[Validation Checkpoints](../playbook/decision-trees/validation-checkpoints.md)** - Quality gate implementations
- **[Emergency Procedures](../playbook/quick-reference/emergency-procedures.md)** - Crisis management protocols
- **[System Initialization](../playbook/procedures/system-initialization.md)** - Framework startup procedures
```

## FLUJOS DE TRABAJO RÁPIDOS

### Acciones Inmediatas
```markdown
DEPLOY AGENT     → Browse [Live Agents](../../agents/) → Select Category → Choose Specialist
CREATE NEW AGENT → Select [Template](templates/) → Follow [Standards](reference/)
UNDERSTAND RULES → Read [agents-only.md](reference/agents-only.md) → Apply enforcement requirements
FIND SPECIALIST  → Use [Navigation Guide](guides/readme.md) → Apply selection criteria
```

### Patrones de Integración
```markdown
- **Framework Integration** → [System Architecture](../architecture/system-architecture-overview.md)
- **Command Integration** → [Commands Reference](../commands-docs/COMMANDS.md)
- **10-Phase Methodology** → [Workflow Principles](../principles/workflow.md)
- **Validation Framework** → [Quality Standards](../principles/validation.md)
```

## USO DEL MÓDULO

### En Archivos de Documentación
```markdown
<!-- Incluir navegación principal -->
{{include:_modules/navigation.md#breadcrumb-principal}}

<!-- Incluir enlaces framework -->
{{include:_modules/navigation.md#enlaces-framework-primarios}}

<!-- Incluir flujos de trabajo -->
{{include:_modules/navigation.md#flujos-de-trabajo-rápidos}}
```

### Ventajas de Centralización
- ✅ **Una Sola Fuente**: Todos los enlaces se mantienen en un lugar
- ✅ **Consistencia Garantizada**: Cambios se propagan automáticamente
- ✅ **Mantenimiento Eficiente**: Actualización única vs 16 archivos
- ✅ **Reducción de Errores**: Elimina enlaces rotos por inconsistencia

