
[🏠 Framework Hub](../../index.md) | [🏗️ Architecture Hub](index.md) | [⚡ Commands](../commands-docs/index.md) | [🤖 Agent Matrix](agent-orchestration/agent-capability-matrix.md)

# ARCHITECTURE DOMAIN FRAMEWORK PLAYBOOK

## 🎯 ARCHITECTURE COMMAND CENTER

### ⚡ ARCHITECTURE EXECUTION FLOW
**MANDATORY SEQUENCE**: Request → Architecture Analysis → Agent Selection → Design → Implementation → Validation → Documentation

**ORCHESTRATOR REQUIREMENT**: Use Task tools for architecture agent deployment

**ARCHITECTURE DIRECTORY RESTRICTION**: ALL architecture operations must be performed exclusively within `/Users/nalve/.claude/docs/architecture/` directory and its subdirectories

### 🏗️ CORE ARCHITECTURE AGENTS

#### System Design Specialists
- **api-architect**: API design, endpoint specification, integration patterns
- **data-architect**: Data modeling, database design, migration strategies  
- **security-architecture-specialist**: Security patterns, threat modeling, compliance
- **component-architecture-specialist**: Component design, modularity patterns

#### Implementation Specialists
- **devops-engineer**: CI/CD, deployment automation, infrastructure
- **performance-optimizer**: Performance analysis, optimization strategies
- **cloud-solutions-architect**: Cloud architecture, service selection

### 🔄 ARCHITECTURE WORKFLOW

#### 1. ANALYSIS PHASE
```markdown
Task(
  subagent_type: "system-auditor",
  description: "Analyze system architecture",
  prompt: "Analyze current system architecture and identify optimization opportunities"
)
```

#### 2. DESIGN PHASE
```markdown
Task(
  subagent_type: "api-architect", 
  description: "Design API architecture",
  prompt: "Design comprehensive API architecture with security and performance considerations"
)
```

#### 3. VALIDATION PHASE
```markdown
Task(
  subagent_type: "security-architecture-specialist",
  description: "Validate security architecture", 
  prompt: "Review architecture design for security compliance and threat mitigation"
)
```

## 🏗️ ARCHITECTURE PATTERNS

### Design Patterns
- **Microservices**: Service-based decomposition
- **Event-Driven**: Asynchronous communication
- **Layered**: Separation of concerns
- **API-First**: Well-defined interfaces

### Quality Gates
- [ ] **Performance Requirements**: Meets defined criteria
- [ ] **Security Standards**: Implements required controls
- [ ] **Scalability**: Handles anticipated load
- [ ] **Maintainability**: Supports evolution

## 📚 ARCHITECTURE RESOURCES

### Core Resources
- **[System Architecture Overview](core/system-architecture-overview.md)** → Framework foundation
- **[Agent Capability Matrix](agent-orchestration/agent-capability-matrix.md)** → Agent selection guide
- **[Agent Orchestration Framework](agent-orchestration/agent-orchestration-framework.md)** → Coordination patterns
- **[Decision Matrix Specifications](patterns/decision-matrix-specifications.md)** → Decision framework

### Integration Resources  
- **[Systems Integration](integration/systems-integration.md)** → Cross-system patterns
- **[Command Consolidation Architecture](command-system/command-consolidation-architecture.md)** → Command patterns

