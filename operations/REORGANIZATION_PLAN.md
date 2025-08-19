# PLAN DE REORGANIZACIÓN - CARPETA AGENTS

## 🎯 ESTRUCTURA JERÁRQUICA PROPUESTA

### 📁 /agents/ (NIVEL RAÍZ)
```
/agents/
├── README.md                           # Índice principal de navegación
├── AGENTS_ONLY.md                      # Reglas del directorio
├── PRIORITY_AGENT_DIVISIONS.md         # División de prioridades
│
├── 🔧 core-system/                     # SISTEMA CENTRAL
│   ├── enforcement-monitor.md
│   ├── protocol-compliance-verifier.md
│   ├── system-auditor.md
│   ├── validation-engineer.md
│   ├── real-time-state-monitor.md
│   ├── real-time-monitoring-components.md
│   ├── simplicity-enforcer.md
│   ├── configuration-manager.md
│   ├── statusline-setup.md
│   └── output-style-setup.md
│
├── 💻 development/                     # DESARROLLO DE SOFTWARE
│   ├── architecture/                   # Arquitectura de Sistemas
│   │   ├── agent-architect.md
│   │   ├── agent-creator.md
│   │   ├── api-architect.md
│   │   ├── component-architecture-specialist.md
│   │   ├── component-extractor.md
│   │   ├── data-architect.md
│   │   └── pattern-generator.md
│   │
│   ├── specializations/                # Especializaciones Técnicas
│   │   ├── ai/
│   │   │   └── machine-learning-specialist.md
│   │   ├── blockchain/
│   │   │   └── blockchain-specialist.md
│   │   ├── data/
│   │   │   └── database-specialist.md
│   │   ├── frontend/
│   │   │   └── frontend-development-specialist.md
│   │   ├── gaming/
│   │   │   └── game-development-specialist.md
│   │   ├── iot/
│   │   │   └── iot-specialist.md
│   │   └── mobile/
│   │       └── mobile-development-specialist.md
│   │
│   ├── quality/                        # Calidad y Testing
│   │   ├── code-quality-auditor.md
│   │   ├── complexity-reduction-specialist.md
│   │   ├── over-engineering-detector.md
│   │   ├── pattern-deduplicator.md
│   │   ├── security-analyst.md
│   │   ├── simplicity-enforcer.md
│   │   ├── simplicity-metrics-dashboard.md
│   │   └── test-architect.md
│   │
│   └── workflow/                       # Flujo de Trabajo
│       ├── component-extraction-specialist.md
│       ├── deployment-coordinator.md
│       ├── git-workflow-specialist.md
│       ├── integration-coordinator.md
│       └── workflow-coordinator.md
│
├── 🔄 operations/                      # OPERACIONES E INFRAESTRUCTURA
│   ├── infrastructure/                 # Infraestructura
│   │   ├── cloud-solutions-architect.md
│   │   ├── devops-engineer.md
│   │   ├── infrastructure-architect.md
│   │   └── migration-specialist.md
│   │
│   ├── monitoring/                     # Monitoreo
│   │   ├── monitoring-specialist.md
│   │   └── performance-optimizer.md
│   │
│   ├── compliance/                     # Cumplimiento
│   │   ├── compliance-auditor.md
│   │   └── incident-coordinator.md
│   │
│   └── optimization/                   # Optimización
│       └── process-optimizer.md
│
├── 📋 project-management/              # GESTIÓN DE PROYECTOS
│   ├── analysis/                       # Análisis
│   │   └── business-analyst.md
│   │
│   ├── analytics/                      # Analítica
│   │   └── metrics-analyst.md
│   │
│   ├── coordination/                   # Coordinación
│   │   ├── change-management-specialist.md
│   │   ├── command-selection-advisor.md
│   │   ├── delegation-advisor.md
│   │   └── project-optimizer.md
│   │
│   ├── execution/                      # Ejecución
│   │   ├── ticket-automation-orchestrator.md
│   │   └── ticket-executor-agent.md
│   │
│   └── optimization/                   # Optimización
│       └── agent-optimizer.md
│
├── 📊 analytics/                       # ANÁLISIS Y REPORTES
│   ├── exploration-analyst.md
│   ├── research-analyst.md
│   ├── sales-analyst.md
│   ├── report-generator.md
│   └── strategy-synthesis-agent.md
│
├── 🎨 user-experience/                 # EXPERIENCIA DE USUARIO
│   ├── ux-architect.md
│   └── ux-research-specialist.md
│
├── 📚 content/                         # GESTIÓN DE CONTENIDO
│   ├── documentation-curator.md
│   ├── knowledge-curator.md
│   └── technical-writer.md
│
├── 🔧 specialization/                  # ESPECIALISTAS ESPECÍFICOS
│   ├── code-modularization-specialist.md
│   ├── dependency-analysis-specialist.md
│   ├── metadata-management-specialist.md
│   ├── pattern-generation-framework.md
│   ├── pattern-management-specialist.md
│   └── AGENT-006-workflow-coordinator.md
│
└── 🎯 strategy/                        # ESTRATEGIA Y SÍNTESIS
    └── product-manager.md
```

## 🔄 PRINCIPIOS DE ORGANIZACIÓN

### 1. JERARQUÍA CLARA
- **Nivel 1**: Dominios principales (core-system, development, operations, etc.)
- **Nivel 2**: Subdominios especializados (architecture, quality, workflow, etc.)
- **Nivel 3**: Agentes específicos

### 2. COHERENCIA TEMÁTICA
- Agrupación por funcionalidad principal
- Separación clara entre dominios
- Escalabilidad para futuros agentes

### 3. NAVEGACIÓN INTUITIVA
- Nombres descriptivos en español e inglés
- Iconos para identificación visual rápida
- Estructura predictible

### 4. MANTENIBILIDAD
- Fácil ubicación de agentes
- Estructura escalable
- Evita duplicaciones

## 📋 ACCIONES ESPECÍFICAS DE REORGANIZACIÓN

### MOVER ARCHIVOS DEL RAÍZ:
```bash
# Archivos que van a /specialization/
- code-modularization-specialist.md
- dependency-analysis-specialist.md  
- metadata-management-specialist.md
- pattern-generation-framework.md
- pattern-management-specialist.md
- AGENT-006-workflow-coordinator.md

# Archivos que van a /strategy/
- (desde project-management/strategy/)
```

### REESTRUCTURAR SUBDIRECTORIOS:
- Consolidar development/specializations/
- Separar analytics/ como dominio principal
- Crear specialization/ para agentes específicos
- Mover strategy/ como dominio principal

## ✅ BENEFICIOS ESPERADOS

1. **Navegación más rápida** - Estructura lógica predecible
2. **Mantenimiento simplificado** - Ubicaciones claras para cada tipo
3. **Escalabilidad mejorada** - Fácil adición de nuevos agentes
4. **Coherencia sistemática** - Principios organizacionales consistentes
5. **Búsqueda eficiente** - Agrupación por funcionalidad

## 🎯 CRITERIOS DE VALIDACIÓN

- [ ] Todos los agentes tienen ubicación lógica
- [ ] No hay archivos huérfanos en raíz
- [ ] Estructura es predecible y coherente
- [ ] Fácil navegación para usuarios
- [ ] Preparado para crecimiento futuro