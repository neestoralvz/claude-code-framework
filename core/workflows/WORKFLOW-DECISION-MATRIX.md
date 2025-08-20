# Workflow Decision Matrix

_Last updated: 2025-08-20 | Version: 2.0 - Complete Agent Ecosystem_

## Quick Decision Guide

**Use this matrix to select the right workflow for your task. Match your situation to the criteria below.**

**🎯 Complete Agent Ecosystem:** 56 specialized agents across 16 categories providing full coverage for any development scenario.

## Command-Workflow-Agent Integration

### Slash Commands → Workflows → Agents

| Command | Primary Workflow | Secondary Workflows | Key Agents | When to Use |
|---------|------------------|-------------------|------------|-------------|
| `/recenter` | [RECENTER](../processes/recenter-workflow.md) | All patterns activated | system-enhancement-specialist | Lost in complexity, need optimization reset |
| `/project [name]` | [Project Documentation](../processes/project-documentation-workflow.md) | Strategic Orchestration, TodoWrite | documentation-curator, strategic-operations-orchestrator | Starting new project, need structured planning |
| `/done` | [Session Conclusion](../processes/session-conclusion-workflow.md) | Validation & Demonstration | system-maintenance-validator | Ending work session, need cleanup |

### Progressive Thinking Levels → Agent Deployment

| Thinking Level | Agent Selection | Workflow Integration | Purpose |
|----------------|----------------|---------------------|---------|
| **LEVEL 1: THINK** | general-purpose, documentation-curator | TodoWrite Management | Initial analysis and task breakdown |
| **LEVEL 2: THINK HARD** | code-quality-specialist, testing-strategy-specialist, user-discovery-specialist, agile-methodology-specialist | TDD/BDD Unified, Project Documentation | Deep technical analysis, user research |
| **LEVEL 3: THINK HARDER** | performance-optimization-specialist, security-validator, project-execution-specialist | Quality Assurance TDD | Strategic optimization, execution management |
| **LEVEL 4: ULTRA THINK** | strategic-operations-orchestrator, framework-evaluation-agent, system-architecture-specialist | Strategic Orchestration | Meta-analysis, system integration, architecture design |

### Agent Categories → Workflow Alignment

| Agent Category | Primary Agents | Workflow Focus | Use Cases |
|----------------|---------------|----------------|-----------|
| **Core System** | system-enhancement-specialist, framework-evaluation-agent | Framework Evaluation, System Enhancement | System maintenance, framework updates |
| **Development** | code-quality-specialist, testing-strategy-specialist, api-design-specialist | TDD/BDD Unified, Quality Assurance | Code creation, testing, API development |
| **Strategic** | strategic-operations-orchestrator, agent-template-architect | Strategic Orchestration, Agent Creation | Multi-domain coordination, agent design |
| **Operations** | dashboard-management-specialist, git-operations-agent, monitoring-observability-specialist | Validation & Demonstration, Development | System monitoring, version control |
| **Technical Implementation** | command-architecture-specialist, transition-preparation-agent | Development, Strategic Orchestration | Architecture design, system transitions |
| **Data Management** | database-design-specialist, data-validation-specialist | TDD/BDD, Quality Assurance | Database design, data integrity validation |
| **Frontend Development** | frontend-architecture-specialist, ux-validation-specialist | TDD/BDD, Quality Assurance | Component architecture, user experience |
| **Infrastructure** | infrastructure-automation-specialist | Strategic Orchestration, TDD/BDD | IaC, CI/CD, cloud architecture |
| **Security & Compliance** | application-security-specialist, data-privacy-compliance-specialist, security-validator | Quality Assurance, Evidence-Based | Security assessment, privacy compliance |
| **Testing & Quality** | load-testing-specialist, accessibility-testing-specialist, testing-strategy-specialist | TDD/BDD, Quality Assurance | Performance testing, accessibility compliance |
| **Business Analysis** | requirements-analysis-specialist, business-process-analyst | Project Documentation, Strategic Orchestration | Requirements gathering, process optimization |
| **Communication** | stakeholder-communication-specialist, technical-writing-specialist, documentation-curator | Strategic Orchestration, Validation | Stakeholder management, technical documentation |
| **Project Management** | project-execution-specialist, agile-methodology-specialist | Project Documentation, Strategic Orchestration | Timeline tracking, agile methodology, execution management |
| **User Research** | user-discovery-specialist | Project Documentation, Evidence-Based | User interviews, persona development, needs assessment |
| **Architecture Design** | system-architecture-specialist | Strategic Orchestration, TDD/BDD | System design, scalability planning, integration architecture |

## Primary Workflow Matrix

| Task Characteristics | Primary Workflow | When to Use | Key Indicators |
|---------------------|------------------|-------------|----------------|
| **Session starting, complex request received** | [RECENTER](../processes/recenter-workflow.md) | Universal optimization check | Multiple patterns need activation |
| **Writing/changing code, scripts, or system files** | [TDD/BDD Unified](../processes/tdd-bdd-unified-workflow.md) | All code changes | Creating, fixing, or modifying functionality |
| **Multiple agents needed, complex coordination** | [Strategic Orchestration](../processes/strategic-orchestration-workflow.md) | Multi-domain work requiring agent coordination | Strategic vs tactical work division needed |
| **Need proof that something works** | [Validation & Demonstration](../processes/validation-and-demonstration-workflow.md) | All deliverables requiring evidence | Must prove functionality works |
| **Creating custom specialized functionality** | [Agent Creation](../processes/agent-creation-workflow.md) | Building reusable specialized capabilities | Need domain expertise not available |

## Secondary Workflow Matrix

| Task Type | Secondary Workflow | Supporting Workflow | Use Case |
|-----------|-------------------|-------------------|----------|
| **Complex problem analysis** | [Progressive Thinking](../processes/extended-thinking-workflow.md) | With RECENTER | Multi-step reasoning needed |
| **Project initialization** | [Project Documentation](../processes/project-documentation-workflow.md) | With TodoWrite | Starting new project work |
| **Research and information gathering** | [Context7 Integration](../processes/context7-integration-workflow.md) + [Web Research](../processes/web-research-workflow.md) | With Evidence-Based | Need current/accurate information |
| **Quality assurance** | [Quality Assurance TDD](../processes/quality-assurance-tdd-workflow.md) | With Validation | Code quality and standards compliance |
| **Bug fixing** | [Debugging TDD](../processes/debugging-tdd-workflow.md) | With Root Cause Analysis | Production issues requiring systematic fix |
| **System maintenance** | [Framework Evaluation](../processes/framework-evaluation-workflow.md) | With Validation | Keeping framework updated |
| **Error handling** | [Error Handling](../processes/error-handling-workflow.md) + [Root Cause Analysis](../processes/root-cause-analysis-workflow.md) | With TDD/BDD | Systematic error resolution |

## Workflow Combination Patterns

### Standard Combinations
- **RECENTER + TDD/BDD** → For all code work
- **Strategic Orchestration + Agent Creation** → For complex multi-agent tasks
- **Validation + TDD/BDD** → For proving code works
- **Context7 + Web Research + Evidence-Based** → For research tasks
- **Progressive Thinking + TodoWrite** → For complex planning

### Advanced Combinations
- **Strategic Orchestration + Parallel Agent Coordination + TDD/BDD** → Complex multi-domain development
- **Agent Creation + Strategic Orchestration + Validation** → Building and deploying specialized systems
- **RECENTER + Progressive Thinking + Strategic Orchestration** → Complex strategic analysis

## Integrated Decision Tree

```
START: What kind of task is this?

├─ WRITING CODE OR SCRIPTS?
│  └─ YES → Command: /recenter → Workflow: TDD/BDD Unified
│      ├─ Need specialized expertise? → Agent: code-quality-specialist, api-design-specialist
│      ├─ Multiple agents needed? → + Strategic Orchestration → strategic-operations-orchestrator  
│      └─ Must prove it works? → + Validation → testing-strategy-specialist
│
├─ RESEARCHING OR GATHERING INFO?
│  └─ YES → Workflow: Context7 + Web Research + Evidence-Based
│      ├─ Complex analysis needed? → Agent: pattern-extraction-agent
│      ├─ Medical research? → Agent: medical-literature-researcher
│      └─ For strategic decisions? → Agent: strategic-operations-orchestrator
│
├─ COORDINATING MULTIPLE AGENTS/DOMAINS?
│  └─ YES → Workflow: Strategic Orchestration → Agent: strategic-operations-orchestrator
│      ├─ Creating new agents? → Agent: agent-template-architect
│      ├─ Need parallel execution? → + Parallel Agent Coordination
│      └─ Complex reasoning? → Progressive Thinking L4: ULTRA THINK
│
├─ STARTING NEW PROJECT?
│  └─ YES → Command: /project [name] → Workflow: Project Documentation
│      ├─ Complex coordination? → Agent: strategic-operations-orchestrator
│      ├─ Research needed? → Agent: documentation-curator
│      └─ Technical setup? → Agent: command-architecture-specialist
│
├─ FIXING BUGS OR ERRORS?
│  └─ YES → Workflow: Debugging TDD → Agent: testing-strategy-specialist
│      ├─ System-wide issues? → Agent: system-enhancement-specialist
│      ├─ Performance issues? → Agent: performance-optimization-specialist
│      └─ Security concerns? → Agent: security-validator
│
├─ MAINTAINING OR UPDATING SYSTEM?
│  └─ YES → Workflow: Framework Evaluation → Agent: framework-evaluation-agent
│      ├─ Quality concerns? → Agent: code-quality-specialist
│      ├─ System validation? → Agent: system-maintenance-validator
│      └─ Documentation? → Agent: documentation-curator
│
├─ ENDING WORK SESSION?
│  └─ YES → Command: /done → Workflow: Session Conclusion → Agent: system-maintenance-validator
│
└─ UNSURE OR COMPLEX SITUATION?
   └─ Command: /recenter → Workflow: RECENTER (auto-detects patterns)
      └─ Progressive Thinking L1-L4 → Deploy appropriate agents per level
```

## Task Complexity Indicators

### Simple Tasks (1-2 workflows)
- Single file edits
- Basic research questions  
- Simple bug fixes
- Documentation updates

### Moderate Tasks (2-3 workflows)
- Feature implementation
- Multi-file changes
- Research with analysis
- System configuration

### Complex Tasks (3+ workflows)
- Multi-domain projects
- System architecture changes
- Cross-functional coordination  
- Framework modifications

## Workflow Triggers by Task Type

### Development Tasks
| Task | Command | Workflow | Primary Agents | Evidence |
|------|---------|----------|---------------|----------|
| New Feature | `/recenter` | TDD/BDD Unified | code-quality-specialist, api-design-specialist | Tests pass, behavior demo |
| Bug Fix | `/recenter` | Debugging TDD | testing-strategy-specialist, performance-optimization-specialist | Fix proven, no regression |
| Refactoring | `/recenter` | TDD/BDD + Quality Assurance | code-quality-specialist, testing-strategy-specialist | All tests pass, quality metrics |
| API Integration | `/recenter` | TDD/BDD + Context7 | api-design-specialist, integration-specialist | Working integration, tests |

### Research Tasks  
| Task | Command | Workflow | Primary Agents | Evidence |
|------|---------|----------|---------------|----------|
| Library Research | N/A | Context7 + Web Research | documentation-curator, pattern-extraction-agent | Current docs, examples |
| Medical Research | N/A | Web Research + Evidence-Based | medical-literature-researcher, medical-bibliography-verifier | Verified sources, analysis |
| Problem Analysis | N/A | Progressive Thinking L2-L3 | pattern-extraction-agent, strategic-operations-orchestrator | Systematic analysis |
| Technical Investigation | N/A | Context7 + Progressive Thinking | documentation-curator, command-architecture-specialist | Comprehensive findings |

### Coordination Tasks
| Task | Command | Workflow | Primary Agents | Evidence |
|------|---------|----------|---------------|----------|
| Multi-Agent Work | N/A | Strategic Orchestration | strategic-operations-orchestrator, agent-template-architect | Coordinated results |
| Project Planning | `/project [name]` | Project Documentation + Strategic Orchestration | strategic-operations-orchestrator, documentation-curator | Clear roadmap, documentation |
| System Architecture | N/A | Strategic Orchestration + Progressive Thinking L4 | command-architecture-specialist, strategic-operations-orchestrator | Design decisions, validation |
| Agent Creation | N/A | Agent Creation + Strategic Orchestration | agent-template-architect, agent-creation-specialist | Functional agents deployed |

### Maintenance Tasks
| Task | Command | Workflow | Primary Agents | Evidence |
|------|---------|----------|---------------|----------|
| System Updates | N/A | Framework Evaluation | framework-evaluation-agent, system-enhancement-specialist | System health validated |
| Error Resolution | N/A | Error Handling + Root Cause Analysis | testing-strategy-specialist, system-maintenance-validator | Error eliminated |
| Performance Issues | N/A | Quality Assurance TDD + Progressive Thinking L3 | performance-optimization-specialist, code-quality-specialist | Performance improved |
| Documentation Updates | N/A | Validation + Framework Evaluation | documentation-curator, system-maintenance-validator | Accurate docs validated |
| Session Cleanup | `/done` | Session Conclusion | system-maintenance-validator, git-operations-agent | Clean state confirmed |

## Emergency Situations

### When Workflows Fail
1. **Use RECENTER** → Reactivate all optimization patterns
2. **Apply Root Cause Analysis** → Find systematic failure
3. **Deploy Strategic Orchestration** → Coordinate recovery
4. **Validate Recovery** → Prove system works

### When Unsure Which Workflow
1. **Start with RECENTER** → Auto-detect patterns
2. **Add Progressive Thinking** → Systematic analysis  
3. **Use Evidence-Based Decision** → Choose based on facts
4. **Document Pattern** → Update this matrix

## Success Metrics

### Workflow Selection Success
- ✅ Task completed successfully
- ✅ All quality gates passed  
- ✅ Evidence provided for claims
- ✅ No rework needed
- ✅ Patterns documented for reuse

### Decision Matrix Effectiveness
- Fast workflow selection (< 30 seconds)
- Appropriate workflow combination  
- Successful task completion
- Quality standards maintained
- Learning captured for improvement

---

**Choose wisely. Execute systematically.**