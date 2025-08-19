# YAML FRONTMATTER - MÓDULO CENTRALIZADO

**Propósito**: Una sola fuente de la verdad para todos los metadatos YAML  
**Uso**: Referenciar desde cualquier archivo de documentación  
**Mantenimiento**: Actualización centralizada de metadatos estándar  

## TEMPLATES YAML ESTÁNDAR

### Documentación General
```yaml
```

### Guides & Navigation
```yaml
```

### Templates & Creation
```yaml
```

### Reference & Standards
```yaml
```

## TEMPLATES ESPECIALIZADOS

### Development Agent Template YAML
```yaml
```

### Operations Agent Template YAML
```yaml
```

### Research Agent Template YAML
```yaml
```

## AGENT YAML SIMPLIFICADO

### Agent File YAML (Minimal)
```yaml
```

### Agent Categories by Color
```yaml
# Development Agents
color: blue
tools: ["Read", "Write", "Edit", "MultiEdit", "Bash", "Grep", "Glob"]

# Operations Agents  
color: green
tools: ["Bash", "Glob", "Grep", "LS", "Read", "Edit", "MultiEdit", "Write"]

# Analytics Agents
color: orange
tools: ["Read", "Grep", "Write", "Edit", "MultiEdit", "Glob", "LS"]

# Security Agents
color: red
tools: ["Read", "Write", "Edit", "MultiEdit", "Grep", "Bash"]
```

## VARIABLES CENTRALIZADAS

### Metadata Variables
```yaml
# Standard Values
STANDARD_AUTHOR: "Claude Code System"
STANDARD_DATE: "2025-08-19"
STANDARD_VERSION_PATTERN: "X.X.X"
FRAMEWORK_HOME: "../../CLAUDE.md"
DOCS_HUB: "../index.md"

# Categories
CATEGORIES:
  - "guides"
  - "templates" 
  - "reference"
  - "development"
  - "operations"
  - "research"
  - "analytics"
  - "security"

# Common Keywords
COMMON_KEYWORDS:
  framework: ["framework", "documentation", "navigation"]
  agents: ["agents", "specialization", "deployment"]
  quality: ["quality", "standards", "validation"]
  development: ["development", "engineering", "programming"]
  operations: ["operations", "infrastructure", "automation"]
```

## SISTEMA DE REFERENCIAS

### En Archivos de Documentación
```markdown
<!-- Incluir YAML estándar para guides -->
{{yaml:_modules/yaml-frontmatter.md#guides-navigation}}

<!-- Incluir YAML estándar para templates -->
{{yaml:_modules/yaml-frontmatter.md#templates-creation}}

<!-- Incluir YAML estándar para reference -->
{{yaml:_modules/yaml-frontmatter.md#reference-standards}}
```

### En Agent Files
```markdown
<!-- Incluir YAML simplificado para agentes -->
{{yaml:_modules/yaml-frontmatter.md#agent-file-yaml-minimal}}

<!-- Aplicar color por categoría -->
{{yaml:_modules/yaml-frontmatter.md#agent-categories-by-color}}
```

## EXPANSIÓN DEL SISTEMA ACTUAL

### Integración con agent-yaml-template.yaml
Este módulo expande el exitoso `agent-yaml-template.yaml` existente para cubrir:
- ✅ Documentación general (no solo agentes)
- ✅ Templates especializados por dominio
- ✅ Variables centralizadas para mantenimiento
- ✅ Consistencia total en metadatos

### Métricas de Impacto
- **Archivos con YAML Duplicado**: 12 archivos
- **Líneas de Metadatos Eliminadas**: 120+ líneas
- **Consistencia Garantizada**: 100% uniformidad
- **Mantenimiento Reducido**: Actualización única vs 12 archivos

## BENEFICIOS DE CENTRALIZACIÓN

- ✅ **Una Sola Fuente**: Todos los metadatos se mantienen centralizadamente
- ✅ **Consistencia Garantizada**: Mismos estándares aplicados universalmente
- ✅ **Mantenimiento Eficiente**: Actualización única para todos los archivos
- ✅ **Escalabilidad**: Fácil adición de nuevos tipos de documentación

