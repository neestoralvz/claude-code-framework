---
title: "Claude Code Framework Playbook"
author: "Claude Code System"
date: "2025-08-19"
version: "2.0.0"
purpose: "MANDATORY execution interface for Claude Code Framework - ALL CONTENT IS ESSENTIAL"
dependencies: ["commands/index.md", "docs/principles/workflow.md"]
---

[🏠 Framework Hub](docs/index.md) | [⚡ Commands](commands/index.md) | [🔄 Workflow](docs/principles/workflow.md) | [📋 Success Criteria](docs/templates/components/success-criteria-template.md)

# CLAUDE CODE FRAMEWORK PLAYBOOK

## ⚡ MANDATORY EXECUTION ON EVERY REQUEST

**OBLIGATORY FLOW**: Request → Task + subagent_type + Command → 9-Phase Automatic → Validation → Response

### 1. EXECUTE COMMAND SELECTION IMMEDIATELY

- **ANALYZE REQUEST IMMEDIATELY**: Evaluate context, complexity, domain, requirements
- **CONSULT COMMAND INDEX**: READ [commands/index.md](commands/index.md) for available options
- **USE INTELLIGENT SELECTION**: APPLY [Command Reference Matrix](commands/COMMAND_REFERENCE_MATRIX.md) for:
  - Task complexity assessment (simple/moderate/complex)
  - Execution time estimation (1-5min/5-20min/20+min) 
  - Resource requirements (low/moderate/high)
  - Validation level needs (basic/comprehensive/enterprise)
- **DETERMINE OPTIMAL AGENT**: USE [Agent Workflow Mapping](commands/AGENT_WORKFLOW_MAPPING.md) for:
  - Phase-specific agent selection (9-phase workflow mapping)
  - Specialization matching (domain expertise alignment)
  - Coordination pattern selection (sequential/parallel/hierarchical)

### 2. EXECUTE TASK TOOLS WITH ORCHESTRATOR STRUCTURE

**MANDATORY PRIORITY**: ANALYZE task dependencies and EXECUTE multiple Task tools in the same message when possible.

#### Single Task Execution
```markdown
Task(
  subagent_type: "{agent-determined-dynamically}",
  description: "{specific-description-linked-to-prompt}",
  prompt: "I am the orchestrator and you are the {determined-agent} agent. 
          Search for relevant files in commands/ and docs/ for your execution.
          Context: {specific-context-of-request}
          Execute the slash command /{selected-command} or complete instruction: {detailed-instruction}
          
          DELIVERABLES REQUIRED:
          - Output Format: {specify-format-json-md-code-etc}
          - File Location: {specify-where-to-place-output}
          - Agent Results: operations/{conversation-id}/{agent-results-filename}
          - Content Requirements: {root-cause-analysis-and-integral-solutions}
          - Quality Standards: {lasting-solutions-specialized-agents-atomic-tasks}"
)
```

#### Parallel Task Execution (MANDATORY WHEN POSSIBLE)
```markdown
Task(
  subagent_type: "workflow-coordinator",
  description: "Coordinate parallel execution of {task-1}",
  prompt: "I am the orchestrator and you are the workflow-coordinator agent.
          Search for relevant files in commands/ and docs/ for your execution.
          Context: {specific-coordination-context}
          Execute coordination task: {detailed-coordination-instruction}
          
          DELIVERABLES REQUIRED:
          - Output Format: Coordination plan in JSON format
          - File Location: operations/{conversation-id}/coordination-{timestamp}.json
          - Content Requirements: Atomic task breakdown, specialized agent assignments, root problem solutions
          - Quality Standards: Integral approaches, lasting resolutions, specialized agent deployment"
)

Task(
  subagent_type: "exploration-analyst", 
  description: "Analyze system state for {task-2}",
  prompt: "I am the orchestrator and you are the exploration-analyst agent.
          Search for relevant files in commands/ and docs/ for your execution.
          Context: {specific-analysis-context}
          Execute analysis task: {detailed-analysis-instruction}
          
          DELIVERABLES REQUIRED:
          - Output Format: Analysis report in markdown format
          - File Location: operations/{conversation-id}/analysis-{timestamp}.md
          - Content Requirements: Root cause analysis, integral solution strategies, atomic task identification
          - Quality Standards: Specialized agent recommendations, permanent problem resolution, comprehensive coverage"
)
```

#### Multiple Agent Deployment (MANDATORY FOR INDEPENDENT FILES)
```markdown
Task(
  subagent_type: "component-architect",
  description: "Create component A independently",
  prompt: "I am the orchestrator and you are the component-architect agent.
          Search for relevant files in commands/ and docs/ for your execution.
          Context: Independent component creation for modular architecture.
          Execute component creation: Create authentication component with validation.
          
          DELIVERABLES REQUIRED:
          - Output Format: TypeScript component file  
          - File Location: src/components/auth/AuthComponent.tsx
          - Agent Results: operations/{conversation-id}/auth-component-analysis.json
          - Content Requirements: Root-cause security implementation, integral authentication solution
          - Quality Standards: Permanent security measures, comprehensive validation, lasting architecture"
)

Task(
  subagent_type: "component-architect",
  description: "Create component B independently", 
  prompt: "I am the orchestrator and you are the component-architect agent.
          Search for relevant files in commands/ and docs/ for your execution.
          Context: Independent component creation for modular architecture.
          Execute component creation: Create payment processing component.
          
          DELIVERABLES REQUIRED:
          - Output Format: TypeScript component file
          - File Location: src/components/payment/PaymentComponent.tsx
          - Agent Results: operations/{conversation-id}/payment-component-analysis.json
          - Content Requirements: Integral payment security, root-cause PCI compliance implementation
          - Quality Standards: Lasting security architecture, comprehensive fraud prevention, permanent compliance"
)
```
**MANDATORY NOTE**: DEPLOY same agent multiple times for independent file operations.

### 3. APPLY PROGRESSIVE THINKING AND SYSTEM PRINCIPLES

**MANDATORY PROGRESSIVE THINKING LEVELS**:
- **Think**: Basic analysis and solution identification
- **Think Hard**: Deep analysis with multiple perspectives and edge cases
- **Think Harder**: Complex systems thinking with interdependencies and implications
- **UltraThink**: Comprehensive analysis with long-term consequences and framework evolution

**MANDATORY SYSTEM PRINCIPLES**: ALWAYS FOLLOW [Framework Principles](docs/principles/index.md) → **READ IMMEDIATELY WHEN**: You need authority chain, execution priorities, integration patterns, or principle conflicts. START WITH [directive.md](docs/principles/directive.md) for framework authority and [workflow.md](docs/principles/workflow.md) for systematic execution.

### 4. AUTOMATIC 9-PHASE WORKFLOW EXECUTION

**Commands EXECUTE complete 9-Phase methodology automatically with TodoWrite tracking, progressive thinking integration, and modern research capabilities.**

---

## 🔄 MANDATORY 9-PHASE WORKFLOW

**Commands EXECUTE complete 9-Phase methodology automatically with TodoWrite tracking, progressive thinking integration, and modern research capabilities including WebSearch and Context7.**

**⚠️ CRITICAL EXECUTION RULE: ALL 9 PHASES ARE MANDATORY - NO EXCEPTIONS**
- **NEVER SKIP ANY PHASE** - Each phase must be completed fully before proceeding
- **SEQUENTIAL EXECUTION REQUIRED** - Phases must be executed in exact order 1→2→3→4→5→6→7→8→9  
- **COMPLETION VALIDATION** - Each phase requires "COMPLETE WHEN" criteria satisfaction
- **AUTOMATIC ENFORCEMENT** - Framework will reject incomplete or skipped phases
- **MANDATORY RECURSION** - If validation fails, MUST recurse through workflow until TOTAL VALIDATION ACHIEVED
- **NO PARTIAL SUCCESS** - Only complete validation success terminates workflow execution
- **PROGRESSIVE THINKING MANDATORY** - ALL actions MUST apply Think→Think Hard→Think Harder→UltraThink based on complexity

### PHASE 1: CLARIFICATION (MANDATORY)
**ESTABLISH complete request understanding and success criteria - NO EXCEPTIONS**
- **APPLY PROGRESSIVE THINKING**: Think (basic requirements) → Think Hard (edge cases) → Think Harder (systemic implications) → UltraThink (long-term consequences)
- **CONFIRM** specific target or aspect using appropriate thinking level
- **VERIFY** scope and parameters with systematic analysis depth
- **VALIDATE** input criteria through progressive complexity assessment
- **Git Operations**: `git status`, `git branch -v`, verify clean working directory
- **COMPLETE WHEN**: Requirements clear, success criteria defined, stakeholder alignment confirmed, progressive thinking applied
- **DETAILED GUIDANCE**: READ [Phase 1 Clarification](docs/principles/workflow.md#1-clarification)

### PHASE 2: EXPLORATION (MANDATORY)
**DISCOVER and gather comprehensive contextual information - CANNOT BE SKIPPED**
- **APPLY PROGRESSIVE THINKING**: Think (basic search) → Think Hard (deep patterns) → Think Harder (systemic connections) → UltraThink (architectural implications)
- **SEARCH** relevant files and patterns with systematic depth analysis
- **READ** necessary content applying appropriate thinking complexity
- **MAP** dependencies and relationships through progressive analysis levels
- **Git Operations**: `git log --oneline -10`, `git diff HEAD~1`, examine repository context
- **COMPLETE WHEN**: Context mapped, information gathered, dependencies identified, progressive exploration completed
- **DETAILED GUIDANCE**: READ [Phase 2 Exploration](docs/principles/workflow.md#2-exploration)

### PHASE 3: RESEARCH (MANDATORY)
**EXECUTE modern online research with current information as of 2025-08-19 - OBLIGATORY EXECUTION**
- **APPLY PROGRESSIVE THINKING**: Think (basic research) → Think Hard (comprehensive analysis) → Think Harder (emerging trends) → UltraThink (future implications)
- **RESEARCH** current best practices using WebSearch tool with progressive depth analysis
- **QUERY** Context7 for latest library documentation applying systematic thinking levels
- **VALIDATE** external resources for accuracy using appropriate complexity assessment
- **SYNTHESIZE** online findings with local context through progressive integration
- **CROSS-REFERENCE** current industry standards with systematic thinking depth
- **MANDATORY TOOLS**: 
  - WebSearch for current trends, solutions, and documentation (2025)
  - mcp__context7__resolve-library-id + mcp__context7__get-library-docs for library research
  - WebFetch for specific documentation validation
- **Git Operations**: Document research findings in temporary notes or comments
- **COMPLETE WHEN**: Current information gathered, external validation complete, synthesis ready, progressive research thinking applied
- **DETAILED GUIDANCE**: READ [Phase 3 Research](docs/principles/workflow.md#3-research)

### PHASE 4: ANALYSIS (MANDATORY)
**EXAMINE and understand findings to generate actionable solutions - REQUIRED COMPLETION**
- **APPLY PROGRESSIVE THINKING**: Think (basic analysis) → Think Hard (pattern recognition) → Think Harder (systemic evaluation) → UltraThink (strategic implications)
- **EXAMINE** discovered information from local context and research using systematic thinking depth
- **SYNTHESIZE** local findings with current online research through progressive complexity levels
- **IDENTIFY** patterns, issues, and current best practices with appropriate analytical depth
- **DOCUMENT** key findings with modern context and progressive thinking evidence
- **Git Operations**: `git diff --cached`, `git log --graph --oneline`, assess change impact  
- **COMPLETE WHEN**: Patterns found, solutions generated, feasibility assessed with current standards, progressive analysis completed
- **DETAILED GUIDANCE**: READ [Phase 4 Analysis](docs/principles/workflow.md#4-analysis)

### PHASE 5: SOLUTION PRESENTATION (MANDATORY)
**ENABLE informed decision-making through structured dialogue - OBLIGATORY STAKEHOLDER ENGAGEMENT**
- **APPLY PROGRESSIVE THINKING**: Think (basic presentation) → Think Hard (stakeholder analysis) → Think Harder (decision implications) → UltraThink (strategic alignment)
- **PRESENT** solution alternatives with current industry context using appropriate communication depth
- **FACILITATE** stakeholder dialogue through progressive engagement complexity
- **CONFIRM** selected approach with systematic decision validation
- **Git Operations**: Confirm branching strategy, validate merge approach
- **COMPLETE WHEN**: Decision made, solution selected, approach agreed, progressive presentation thinking applied
- **DETAILED GUIDANCE**: READ [Phase 5 Solution Presentation](docs/principles/workflow.md#5-solution-presentation)

### PHASE 6: PLANNING (MANDATORY)
**DESIGN atomic, hierarchical implementation approach WITH MANDATORY PRINCIPLE VALIDATION - CANNOT PROCEED WITHOUT VALIDATION**
- **APPLY PROGRESSIVE THINKING**: Think (basic planning) → Think Hard (complexity analysis) → Think Harder (integration challenges) → UltraThink (long-term architecture)
- **DESIGN** integral solutions targeting root problems using systematic thinking depth
- **CREATE** comprehensive strategies through progressive complexity assessment
- **STRUCTURE** atomic task breakdown with specialized agent assignment using appropriate thinking level
- **ESTABLISH** operations/{conversation-id}/ storage structure for agent outputs
- **DEFINE** quantifiable success criteria with mathematical validation metrics using progressive thinking
- **CREATE** objective measurement frameworks using calculable evidence with systematic depth
- **SPECIFY** success thresholds with numerical benchmarks and validation scripts
- **ESTABLISH** evidence-based validation protocols with automated verification
- **ENSURE** each atomic task has dedicated specialized agent with specific deliverables
- **VALIDATE PLAN AGAINST PRINCIPLES** (MANDATORY CHECKPOINT):
  - **EXECUTE** [Simplicity Enforcement](docs/principles/simplicity.md) validation
  - **DEPLOY** over-engineering detection using Task(subagent_type: "over-engineering-detector")
  - **VERIFY** SIMPLE framework compliance (Simple, Incremental, Maintainable, Purposeful, Lean, Effective)
  - **CHECK** against [Engineering Standards](docs/principles/engineering.md) for quality patterns
  - **VALIDATE** resource allocation and scope appropriateness
- **MANDATORY TOOLS FOR VALIDATION**:
```markdown
Task(
  subagent_type: "simplicity-enforcer",
  description: "Validate plan against SIMPLE framework principles",
  prompt: "I am the orchestrator and you are the simplicity-enforcer agent. 
          Search for relevant files in commands/ and docs/ for your execution.
          Context: Planning phase requires validation against over-engineering.
          Execute validation of current implementation plan against SIMPLE framework:
          Simple, Incremental, Maintainable, Purposeful, Lean, Effective principles.
          Identify complexity violations and provide simplification recommendations.
          
          DELIVERABLES REQUIRED:
          - Output Format: JSON validation report
          - File Location: operations/{conversation-id}/simplicity-validation-{timestamp}.json
          - Content Requirements: SIMPLE framework compliance score, root cause analysis, integral solutions
          - Quality Standards: Root problem identification, lasting solution recommendations"
)

Task(
  subagent_type: "over-engineering-detector",
  description: "Detect complexity violations and over-engineering patterns",
  prompt: "I am the orchestrator and you are the over-engineering-detector agent.
          Search for relevant files in commands/ and docs/ for your execution.
          Context: Plan validation checkpoint to prevent unnecessary complexity.
          Analyze current implementation plan for over-engineering patterns, 
          excessive abstractions, and unnecessary complexity. Provide specific
          recommendations for complexity reduction and scope optimization.
          
          DELIVERABLES REQUIRED:
          - Output Format: Markdown analysis report
          - File Location: operations/{conversation-id}/over-engineering-analysis-{timestamp}.md
          - Content Requirements: Root cause complexity analysis, integral optimization strategies, atomic task breakdown
          - Quality Standards: Specialized agent assignments, permanent solutions, measurable improvements"
)

Task(
  subagent_type: "compliance-auditor",
  description: "Verify plan adherence to framework principles",
  prompt: "I am the orchestrator and you are the compliance-auditor agent.
          Search for relevant files in commands/ and docs/ for your execution.
          Context: Mandatory checkpoint before implementation phase.
          Verify implementation plan compliance with engineering standards,
          framework principles, and quality patterns. Validate resource
          allocation appropriateness and scope alignment with requirements.
          
          DELIVERABLES REQUIRED:
          - Output Format: JSON compliance report
          - File Location: operations/{conversation-id}/compliance-audit-{timestamp}.json
          - Content Requirements: Comprehensive compliance analysis, root problem identification, integral remediation plan
          - Quality Standards: Atomic task assignments, specialized agent deployment, lasting compliance solutions"
)
```
- **Git Operations**: `git checkout -b feature/task-description`, `git push -u origin feature/task-description`
- **COMPLETE WHEN**: Tasks defined, agents assigned, dependencies mapped, **PRINCIPLES VALIDATED**
- **VALIDATION GATE**: **PLAN MUST PASS SIMPLICITY AND PRINCIPLE VALIDATION BEFORE PROCEEDING**
- **DETAILED GUIDANCE**: READ [Phase 6 Planning](docs/principles/workflow.md#6-planning)

### PHASE 7: IMPLEMENTATION (MANDATORY)
**EXECUTE planned solution through specialized agents - OBLIGATORY EXECUTION OF VALIDATED PLAN**
- **APPLY PROGRESSIVE THINKING**: Think (basic implementation) → Think Hard (integration complexity) → Think Harder (system impacts) → UltraThink (architectural evolution)
- **EXECUTE** designed solution with current best practices using systematic thinking depth
- **APPLY** changes systematically through progressive complexity assessment
- **FOLLOW** established principles and modern standards with appropriate thinking level
- **Git Operations**: `git add [files]`, `git commit -m "type(scope): description"`, `git push origin feature/task-description`
- **COMPLETE WHEN**: Implementation complete, quality verified, integration tested, progressive implementation thinking applied
- **DETAILED GUIDANCE**: READ [Phase 7 Implementation](docs/principles/workflow.md#7-implementation)

### PHASE 8: RIPPLE EFFECT (MANDATORY)
**MANAGE implementation consequences and dependencies - OBLIGATORY IMPACT MANAGEMENT**
- **APPLY PROGRESSIVE THINKING**: Think (direct impacts) → Think Hard (cascading effects) → Think Harder (system-wide implications) → UltraThink (ecosystem evolution)
- **HANDLE** cross-references using systematic thinking depth
- **UPDATE** dependent elements through progressive impact assessment
- **MAINTAIN** system integrity with appropriate complexity analysis
- **Git Operations**: `git fetch origin`, `git rebase origin/main`, `git push --force-with-lease`
- **COMPLETE WHEN**: Dependencies updated, system stable, documentation synced, progressive impact thinking applied
- **DETAILED GUIDANCE**: READ [Phase 8 Ripple Effect](docs/principles/workflow.md#8-ripple-effect)

### PHASE 9: VALIDATION (MANDATORY)
**VERIFY success and completeness using systematic validation methodology - FINAL OBLIGATORY VERIFICATION**
- **APPLY PROGRESSIVE THINKING**: Think (basic validation) → Think Hard (comprehensive testing) → Think Harder (system validation) → UltraThink (strategic success assessment)
- **LOAD** Phase 6 quantifiable success criteria and mathematical benchmarks using systematic thinking depth
- **EXECUTE** objective validation using mathematical calculations and evidence-based scripts with progressive complexity
- **CALCULATE** success metrics using automated verification scripts with numerical outcomes and appropriate thinking level
- **MEASURE** performance against established thresholds through progressive validation depth
- **GENERATE** validation reports with mathematical proof and statistical analysis using systematic thinking
- **STORE** validation evidence in operations/{conversation-id}/validation-results/
- **CREATE** automated validation scripts for reproducible verification with progressive thinking documentation
- **DOCUMENT** mathematical validation results with evidence collection and progressive thinking analysis
- **RECURSIVE EXECUTION**: If validation fails, MANDATORY return to Phase 1 until TOTAL SUCCESS with progressive thinking applied
- **Git Operations**: `gh pr create --title "Title" --body "Description"`, `git diff main..HEAD`, verify CI/CD success
- **COMPLETE WHEN**: ALL mathematical criteria satisfied, objective evidence confirms success, numerical thresholds met, progressive validation thinking applied
- **DETAILED GUIDANCE**: READ [Phase 9 Validation](docs/principles/workflow.md#9-validation)

### WORKFLOW SUPPORT OPERATIONS

#### DEBUG OPERATION - Troubleshoot and resolve workflow issues
- **APPLY PROGRESSIVE THINKING**: Think (basic diagnosis) → Think Hard (root cause analysis) → Think Harder (systemic issues) → UltraThink (architectural problems)
- **EXECUTE** systematic issue diagnosis for workflow execution problems using appropriate thinking depth
- **IDENTIFY** blockages, quality problems, and coordination failures through progressive analysis
- **GENERATE** resolution strategies and recovery procedures with systematic thinking complexity
- **RESUME** workflow execution from stable points with progressive thinking applied
- **DETAILED GUIDANCE**: READ [Debug Operation](docs/principles/workflow.md#debug-operation)

#### RECURSIVE OPERATION - Execute iterative improvement cycles (MANDATORY UNTIL SUCCESS)
- **APPLY PROGRESSIVE THINKING**: Think (basic recursion) → Think Hard (pattern analysis) → Think Harder (systematic improvement) → UltraThink (evolutionary optimization)
- **EXECUTE** OBLIGATORY workflow repetition when validation fails using systematic thinking depth
- **ANALYZE** mathematical gaps and evidence deficiencies through progressive complexity assessment
- **PLAN** optimal recursion strategy with appropriate thinking level based on failure analysis
- **CONTINUE** systematic iteration until ALL mathematical criteria satisfied with progressive thinking applied
- **DOCUMENT** recursion cycles and improvement evidence in operations/{conversation-id}/recursion-logs/
- **ACHIEVE** complete validation success through persistent iteration with progressive thinking - NO PARTIAL ACCEPTANCE
- **DETAILED GUIDANCE**: READ [Recursive Operation](docs/principles/workflow.md#recursive-operation)

---

## 🔧 MANDATORY TASK TOOL STRUCTURE

**FOR COMPLETE Task tool syntax**: READ [Task Tool Syntax Principles](docs/principles/task-tool-syntax.md) for:
- Task tool invocation framework and parameters
- Orchestrator-agent communication patterns  
- Dynamic parameter construction guidelines
- Error handling and validation protocols

**MANDATORY STRUCTURE**:
```markdown
Task(
  subagent_type: "{agent-from-AGENT_WORKFLOW_MAPPING}",
  description: "{action-specific-to-request}",
  prompt: "I am the orchestrator and you are the {agent} agent.
          Search for relevant files in commands/ and docs/ for your execution.
          Context: {specific-context-description}
          Execute: {detailed-instruction-with-requirements}
          
          DELIVERABLES REQUIRED:
          - Output Format: {specify-format-json-md-code-etc}
          - File Location: {specify-exact-path-and-filename}
          - Agent Results: operations/{conversation-id}/{agent-results-filename}
          - Content Requirements: {root-cause-analysis-and-integral-solutions}
          - Quality Standards: {lasting-solutions-specialized-agents-atomic-tasks}"
)
```

---

## ⚡ MANDATORY PARALLEL EXECUTION & DEPENDENCY ANALYSIS

### DEPENDENCY ANALYSIS FRAMEWORK

**ALWAYS ANALYZE task dependencies before execution:**

1. **Independent Tasks** → EXECUTE in parallel (same message)
2. **Sequential Dependencies** → EXECUTE in order with handoff
3. **Partial Dependencies** → EXECUTE parallel for independent components
4. **Resource Conflicts** → SERIALIZE conflicting operations

### MANDATORY PARALLEL EXECUTION PATTERNS

#### Pattern 1: Independent File Operations (MANDATORY APPROACH)
```markdown
Task(subagent_type: "component-architect", description: "Create auth.js")
Task(subagent_type: "component-architect", description: "Create payment.js") 
Task(subagent_type: "component-architect", description: "Create validation.js")
```

#### Pattern 2: Multi-Perspective Analysis (MANDATORY APPROACH)
```markdown
Task(subagent_type: "security-analyst", description: "Security assessment")
Task(subagent_type: "performance-optimizer", description: "Performance analysis")
Task(subagent_type: "code-quality-auditor", description: "Quality evaluation")
```

### MANDATORY PROGRESSIVE THINKING INTEGRATION

**APPLY thinking levels based on task complexity:**

- **Think** → Simple, straightforward tasks (file creation, basic analysis)
- **Think Hard** → Moderate complexity (system integration, security considerations)
- **Think Harder** → Complex systems (architectural decisions, interdependencies)
- **UltraThink** → Framework evolution (long-term implications, strategic changes)

---

## 📋 MANDATORY OPERATIONAL RULES

### 🎯 COMMUNICATION REQUIREMENTS
1. **MAXIMUM 4 LINES** response to user
2. **NO UNNECESSARY EXPLANATIONS** - Avoid preambles and summaries
3. **DIRECT RESPONSE ONLY** - Address only what is requested

### 📁 FILE MANAGEMENT REQUIREMENTS
4. **NO UNNECESSARY FILES** - Only when absolutely required
5. **PREFER Edit OVER Write** - Always modify existing files when possible
6. **NO PROACTIVE DOCUMENTATION** - Don't create READMEs or .md documentation without explicit request

### 🔄 MANDATORY FRAMEWORK FLOW
7. **NEVER BYPASS**: Task + subagent_type + Command is MANDATORY for ALL actions
8. **PRIORITIZE PARALLEL EXECUTION**: Analyze dependencies and execute multiple Task tools in same message when possible
9. **DEPLOY SAME AGENT MULTIPLE TIMES**: For independent file operations
10. **APPLY PROGRESSIVE THINKING**: Use Think → Think Hard → Think Harder → UltraThink levels based on complexity
11. **FOLLOW SYSTEM PRINCIPLES**: Always adhere to [Framework Principles](docs/principles/index.md) authority chain
12. **AUTOMATIC 9-PHASE**: Commands execute complete workflow dynamically with integrated research
13. **INTEGRATED TodoWrite**: For visible workflow progress tracking
14. **AUTOMATIC VALIDATION**: Tests/build/lint included in workflow
15. **MANDATORY PHASE COMPLETION**: Each phase MUST satisfy "COMPLETE WHEN" criteria before proceeding
16. **INTER-PHASE VALIDATION**: Automatic verification that previous phase requirements are met
17. **NO PHASE SKIPPING ALLOWED**: Framework will reject any attempt to bypass workflow phases
18. **OBJECTIVE VALIDATION REQUIRED**: All validation must use mathematical calculations and evidence-based scripts
19. **MANDATORY RECURSION**: If validation fails, MUST recurse until complete mathematical success
20. **EVIDENCE STORAGE REQUIRED**: All validation evidence stored in operations/{conversation-id}/validation-results/
21. **ONLY COMMIT IF EXPLICITLY REQUESTED**

---

## 📚 MANDATORY DOCUMENTATION ACCESS

### ⚡ CORE EXECUTION RESOURCES (READ WHEN NEEDED)
- **[Commands Index](commands/index.md)** → Browse complete command directory
- **[9-Phase Workflow](docs/principles/workflow.md#nine-phase-methodology)** → Understand systematic methodology with research integration
- **[System Architecture](docs/architecture/system-architecture-overview.md)** → Understand framework structure

### 🤖 INTELLIGENT SELECTION MATRICES (MANDATORY USAGE)
- **[Command Reference Matrix](commands/COMMAND_REFERENCE_MATRIX.md#command-selection-matrix)** → USE for intelligent command selection
- **[Agent Workflow Mapping](commands/AGENT_WORKFLOW_MAPPING.md#agent-specialization-matrix)** → USE for optimal agent deployment

### 🔄 COMMAND SELECTION (MANDATORY PROCESS)

**FOR INTELLIGENT COMMAND SELECTION**: USE [Command Reference Matrix](commands/COMMAND_REFERENCE_MATRIX.md#command-selection-decision-tree)
**FOR OPTIMAL AGENT SELECTION**: USE [Agent Workflow Mapping](commands/AGENT_WORKFLOW_MAPPING.md#agent-selection-algorithms)

**MANDATORY SELECTION PROCESS**:
1. ANALYZE request → 2. [Command Matrix](commands/COMMAND_REFERENCE_MATRIX.md) → 3. [Agent Mapping](commands/AGENT_WORKFLOW_MAPPING.md) → 4. EXECUTE Task + Command

**NEVER BYPASS FRAMEWORK**: Task + subagent + Command is MANDATORY for ALL actions

---

## 📚 MANDATORY CROSS-REFERENCES

### Primary Navigation (ACCESS WHEN REQUIRED)
- **[Framework Hub](docs/index.md)** → Access complete framework documentation when need comprehensive understanding
- **[Commands Index](commands/index.md)** → Navigate complete command directory for command selection
- **[9-Phase Workflow](docs/principles/workflow.md)** → Understand detailed methodology phases and operations with research integration

### Dynamic Selection Matrices (MANDATORY USAGE FOR INTELLIGENT SELECTION)
- **[Command Reference Matrix](commands/COMMAND_REFERENCE_MATRIX.md)** → **MANDATORY USE**: For intelligent command selection based on complexity, time, resource requirements
- **[Agent Workflow Mapping](commands/AGENT_WORKFLOW_MAPPING.md)** → **MANDATORY USE**: For optimal agent selection and multi-agent coordination

### Plan Validation Resources (MANDATORY FOR PHASE 6 CHECKPOINT)
- **[Simplicity Enforcement](docs/principles/simplicity.md)** → **READ DURING PLANNING**: SIMPLE framework validation (Simple, Incremental, Maintainable, Purposeful, Lean, Effective)
- **[Over-Engineering Detection](docs/principles/engineering.md#complexity-management)** → **READ DURING PLANNING**: Complexity violation prevention and detection patterns
- **[Engineering Standards](docs/principles/engineering.md)** → **READ DURING PLANNING**: Quality patterns, technical standards, and framework compliance requirements

### Framework Authority (READ WHEN CONFLICTS OR QUESTIONS)
- **[Framework Principles Hub](docs/principles/index.md)** → **READ WHEN**: Need comprehensive system principles, authority chains, execution priorities
- **[Directive Authority](docs/principles/directive.md)** → **READ WHEN**: Need framework hierarchy, decision-making authority, conflict resolution
- **[Task Orchestration](docs/principles/task-orchestration.md)** → **READ WHEN**: Need multi-agent coordination, parallel execution patterns, task distribution
- **[Validation Principles](docs/principles/validation.md)** → **READ WHEN**: Need comprehensive validation, quality gates, evidence-based verification
- **[Engineering Standards](docs/principles/engineering.md)** → **READ WHEN**: Need technical standards, quality patterns, framework compliance
- **[Simplicity Enforcement](docs/principles/simplicity.md)** → **READ WHEN**: Need complexity reduction, over-engineering elimination, SIMPLE framework principles

### Emergency Access (READ WHEN PROBLEMS OCCUR)
- **[Emergency Procedures](playbook/quick-reference/emergency-procedures.md#recovery-protocols)** → **READ WHEN**: System failures or rapid problem resolution needed
- **[Quick Reference](playbook/quick-reference/immediate-access.md#navigation-shortcuts)** → **READ WHEN**: Need immediate access to key framework components

[⬆ Return to top](#claude-code-framework-playbook)