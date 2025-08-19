# Task Reference Context Analysis

## Context Patterns

### Files with Task Tool References and Context:

#### ./planning/tickets/completed/agent-001-ticket-executor-agent.md
```
38-- **Model**: sonnet
39-- **Color**: green
40:- **Tools**: Read, Write, Edit, MultiEdit, Grep, LS, TodoWrite, Bash
41-
42-### Core Responsibilities
```

#### ./docs/agents-docs/agent-template.md
```
2-name: [agent-name]
3-description: [Comprehensive description with \n for formatting and multiple <example> blocks showing context, user query, assistant response, and commentary]
4:tools: [Select from: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, NotebookEdit, WebFetch, TodoWrite, WebSearch, BashOutput, KillBash]
5-model: sonnet
6-color: [green/blue/yellow/red/purple]
```

#### ./docs/templates/components/agent-coordination-strategies.md
```
141-
142-### Task Tool Invocation Parameters
143:- **subagent_type**: Specific agent identifier from available agent catalog
144-- **description**: Concise 3-5 word task summary for identification
145-- **prompt**: Comprehensive task instructions with complete context and requirements
```

#### ./docs/principles/principle-validation-checkpoints.md
```
37-### Agent Deployment
38-```markdown
39:Task(
40:  subagent_type: "simplicity-enforcer",
41-  description: "Validate SIMPLE framework compliance",
42-  prompt: "I am the orchestrator and you are the simplicity-enforcer agent.
--
81-### Agent Deployment
82-```markdown
83:Task(
84:  subagent_type: "over-engineering-detector",
85-  description: "Detect complexity violations",
86-  prompt: "I am the orchestrator and you are the over-engineering-detector agent.
--
125-### Agent Deployment
126-```markdown
127:Task(
128:  subagent_type: "compliance-auditor",
129-  description: "Verify framework principles adherence",
130-  prompt: "I am the orchestrator and you are the compliance-auditor agent.
```

#### ./docs/principles/workflow-support-operations.md
```
257-### Pattern Identification Tasks
258-```markdown
259:Task(
260:  subagent_type: "pattern-management-specialist",
261-  description: "Identify and document patterns",
262-  prompt: "Analyze completed work for reusable patterns, anti-patterns, optimization opportunities. Document insights for future framework evolution."
--
266-### Final System Validation
267-```markdown
268:Task(
269:  subagent_type: "validation-engineer", 
270-  description: "Final system validation",
271-  prompt: "Execute comprehensive final validation: tests, builds, lint, system integrity. Confirm all quality gates passed."
```

#### ./docs/principles/task-tool-syntax.md
```
26-### Orchestrator-Agent Communication Pattern
27-```markdown
28:Task(
29:  subagent_type: "{agent-from-AGENT_WORKFLOW_MAPPING}",
30-  description: "{action-specific-to-request}",
31-  prompt: "I am the orchestrator and you are the {agent} agent.
--
93-## Parameter Specifications
94-
95:### subagent_type Parameter
96-
97:⏺ **Principle**: The subagent_type parameter identifies the specific agent from the available catalog for deployment.
98-
99-#### Available Agent Types
--
109-#### Syntax Pattern
110-```
111:&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
112-```
113-
--
224-&lt;function_calls&gt;
225-&lt;invoke name="Task"&gt;
226:&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
227-&lt;parameter name="description"&gt;Analyze application architecture&lt;/parameter&gt;
228-&lt;parameter name="prompt"&gt;
--
259-&lt;function_calls&gt;
260-&lt;invoke name="Task"&gt;
261:&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
262-&lt;parameter name="description"&gt;Analyze frontend performance&lt;/parameter&gt;
263-&lt;parameter name="prompt"&gt;
--
282-&lt;/invoke&gt;
283-&lt;invoke name="Task"&gt;
284:&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
285-&lt;parameter name="description"&gt;Analyze backend performance&lt;/parameter&gt;
286-&lt;parameter name="prompt"&gt;
--
305-&lt;/invoke&gt;
306-&lt;invoke name="Task"&gt;
307:&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
308-&lt;parameter name="description"&gt;Analyze database performance&lt;/parameter&gt;
309-&lt;parameter name="prompt"&gt;
--
336-&lt;function_calls&gt;
337-&lt;invoke name="Task"&gt;
338:&lt;parameter name="subagent_type"&gt;project-optimizer&lt;/parameter&gt;
339-&lt;parameter name="description"&gt;Analyze system architecture&lt;/parameter&gt;
340-&lt;parameter name="prompt"&gt;[Analysis task prompt]&lt;/parameter&gt;
341-&lt;/invoke&gt;
342-&lt;invoke name="Task"&gt;
343:&lt;parameter name="subagent_type"&gt;delegation-advisor&lt;/parameter&gt;
344-&lt;parameter name="description"&gt;Identify optimization opportunities&lt;/parameter&gt;
345-&lt;parameter name="prompt"&gt;[Opportunity identification prompt]&lt;/parameter&gt;
--
352-&lt;function_calls&gt;
353-&lt;invoke name="Task"&gt;
354:&lt;parameter name="subagent_type"&gt;agent-creator&lt;/parameter&gt;
355-&lt;parameter name="description"&gt;Design implementation strategy&lt;/parameter&gt;
356-&lt;parameter name="prompt"&gt;[Strategy design using analysis results]&lt;/parameter&gt;
--
363-&lt;function_calls&gt;
364-&lt;invoke name="Task"&gt;
365:&lt;parameter name="subagent_type"&gt;general-purpose&lt;/parameter&gt;
366-&lt;parameter name="description"&gt;Execute optimization plan&lt;/parameter&gt;
367-&lt;parameter name="prompt"&gt;[Implementation using strategy and analysis]&lt;/parameter&gt;
--
373-
374-### Pre-Deployment Validation
375:- **Agent Availability** - Verify subagent_type exists in available catalog
376-- **Task Completeness** - Ensure all required prompt sections included
377-- **Syntax Accuracy** - Validate XML structure and parameter naming
```

#### ./commands/domains/management/commands/init-claude-md.md
```
105-### Mandatory Global Rule Inheritance
106-- **MANDATORY EXECUTION FLOW**: Request → Command Selection → Task + Agent → 10-Phase Automatic → Validation → Closure → Response
107:- **TASK ORCHESTRATION**: ALL actions MUST use Task tool with subagent_type from [Agent Workflow Mapping](../../../AGENT_WORKFLOW_MAPPING.md)
108-- **PROGRESSIVE THINKING**: Apply complexity-based thinking levels (Think→Think Hard→Think Harder→UltraThink)
109-- **10-PHASE WORKFLOW**: Follow [10-phase detailed methodology](../../../../docs/principles/10-phase-detailed-methodology.md) with integrated research
--
176-### Mandatory Global Rule Inheritance
177-- **MANDATORY EXECUTION FLOW**: Request → Command Selection → Task + Agent → 10-Phase Automatic → Validation → Closure → Response
178:- **TASK ORCHESTRATION**: ALL actions MUST use Task tool with subagent_type from [Agent Workflow Mapping](../../../AGENT_WORKFLOW_MAPPING.md)
179-- **PROGRESSIVE THINKING**: Apply complexity-based thinking levels (Think→Think Hard→Think Harder→UltraThink)
180-- **10-PHASE WORKFLOW**: Follow [10-phase detailed methodology](../../../../docs/principles/10-phase-detailed-methodology.md) with integrated research
```

#### ./commands/domains/management/commands/manage-systems.md
```
67-- **Purpose**: System status assessment and validation
68-- **Capabilities**: Static analysis, compliance validation, system integrity
69:- **Tools**: Grep, LS, Read, Bash, TodoWrite
70-
71-**Secondary Agent**: configuration-manager (if needed)
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/research/context7-specialist.md
```
2-name: context7-specialist
3-description: Library documentation retrieval and technical documentation synthesis specialist using Context7 MCP tools for accessing up-to-date API references, code examples, and technical specifications across programming libraries and frameworks.
4:tools: mcp__context7__resolve-library-id, mcp__context7__get-library-docs, Read, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/research/websearch-specialist.md
```
2-name: websearch-specialist
3-description: Web search and current information retrieval specialist focused on real-time information gathering, trend analysis, current events monitoring, and market intelligence using WebSearch capabilities for up-to-date knowledge synthesis.
4:tools: WebSearch, Read, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/specialization/AGENT-006-workflow-coordinator.md
```
2-name: AGENT-006-workflow-coordinator
3-description: Advanced workflow orchestration and distributed systems coordination specialist that manages complex multi-system integrations, coordinates API workflows, supervises long-running processes, orchestrates parallel agent operations, and implements comprehensive failure recovery protocols with state persistence across distributed architectures.
4:tools: Bash, WebFetch, BashOutput, KillBash, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/specialization/pattern-generation-framework.md
```
2-name: pattern-generation-framework
3-description: Comprehensive pattern generation and framework automation specialist enabling systematic creation of all framework building blocks with consistent quality and architectural standards
4:tools: Read, Write, Edit, MultiEdit, Grep, LS, Bash, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/database/database-performance-optimizer.md
```
2-name: database-performance-optimizer
3-description: Cross-platform database performance specialist focused on query optimization, resource monitoring, capacity planning, and systematic performance tuning across SQL and NoSQL database systems with expertise in bottleneck identification and scalability optimization.
4:tools: Bash, BashOutput, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/database/nosql-database-specialist.md
```
2-name: nosql-database-specialist
3-description: Expert in NoSQL database design, distributed systems, horizontal scaling, and eventual consistency across MongoDB, Cassandra, Redis, DynamoDB, and Elasticsearch platforms with deep expertise in document modeling, key-value optimization, and distributed architecture patterns.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/database/cache/redis-expert-specialist.md
```
2-name: redis-expert-specialist
3-description: Expert Redis specialist with comprehensive expertise in caching strategies, data structures, clustering, and performance optimization. Provides Redis-specific solutions with Context7 integration for real-time updates, advanced patterns, and enterprise deployment strategies.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite, WebSearch
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/database/search/elasticsearch-expert-specialist.md
```
2-name: elasticsearch-expert-specialist
3-description: Expert Elasticsearch specialist with comprehensive expertise in search optimization, analytics, ELK stack integration, and performance tuning. Provides Elasticsearch-specific solutions with Context7 integration for real-time updates, advanced search patterns, and enterprise deployment strategies.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite, WebSearch
5-model: sonnet
6-color: yellow
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/database/sql-database-specialist.md
```
2-name: sql-database-specialist
3-description: Expert in relational database design, SQL optimization, transaction management, and ACID compliance across PostgreSQL, MySQL, SQL Server, and Oracle platforms with deep expertise in schema design, query performance, and data integrity.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/database/nosql/mongodb-expert-specialist.md
```
2-name: mongodb-expert-specialist
3-description: Expert MongoDB specialist with comprehensive expertise in document modeling, aggregation pipelines, sharding, and MongoDB Atlas integration. Provides MongoDB-specific solutions with Context7 integration for real-time updates, performance optimization, and modern NoSQL patterns.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite, WebSearch
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/database/sql/mysql-expert-specialist.md
```
2-name: mysql-expert-specialist
3-description: Expert MySQL specialist with comprehensive expertise in MySQL optimization, replication, clustering, and migration strategies. Provides MySQL-specific solutions with Context7 integration for real-time updates, performance optimization, and enterprise deployment patterns.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite, WebSearch
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/database/sql/postgresql-expert-specialist.md
```
2-name: postgresql-expert-specialist
3-description: Expert PostgreSQL specialist with deep expertise in advanced features, performance optimization, extensions, and enterprise deployments. Provides comprehensive PostgreSQL-specific solutions with Context7 integration for real-time updates, security patches, and best practices.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite, WebSearch
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/design/visual-design-specialist.md
```
2-name: visual-design-specialist
3-description: Expert in typography, layout design, and visual hierarchy that creates compelling and accessible visual designs for digital interfaces and print media.
4:tools: Read, Write, Edit, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/design/color-theory-specialist.md
```
2-name: color-theory-specialist
3-description: Expert in color theory, color harmony, and palette design that creates accessible and emotionally resonant color schemes for digital interfaces and brand identities.
4:tools: Read, Write, Edit, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: magenta
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/design/contrast-accessibility-specialist.md
```
2-name: contrast-accessibility-specialist
3-description: Expert in WCAG compliance, contrast ratios, and visual accessibility standards that ensures digital interfaces meet accessibility guidelines while maintaining design excellence.
4:tools: Read, Write, Edit, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: cyan
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/design/micro-interaction-specialist.md
```
2-name: micro-interaction-specialist
3-description: Expert in micro-interactions, animations, and UX feedback that creates engaging and intuitive interactive experiences through motion design and user feedback systems.
4:tools: Read, Write, Edit, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: yellow
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/core-system/enforcement-monitor.md
```
2-name: enforcement-monitor
3-description: System enforcement and validation specialist that validates agent requirements before task execution, enforces CLAUDE.md directives, and ensures compliance with agent-first execution protocols.
4:tools: Read, Grep, TodoWrite
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/core-system/system-auditor.md
```
2-name: system-auditor
3-description: Static analysis and compliance validation specialist focused exclusively on principle violation detection, cross-reference integrity validation, file structure compliance monitoring, and framework adherence verification. Operates through systematic static analysis without real-time monitoring or quality methodology execution.
4:tools: Grep, LS, Read, Bash, TodoWrite
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/core-system/simplicity-enforcer.md
```
2-name: simplicity-enforcer
3-description: Automated simplicity compliance and component extraction specialist focused exclusively on file size violation detection, systematic modularization, and automated component extraction while preserving functionality and cross-reference integrity.
4:tools: Read, Edit, MultiEdit, Grep, LS, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/core-system/real-time-state-monitor.md
```
2-name: real-time-state-monitor
3-description: Real-time system state monitoring specialist with continuous violation detection and immediate response protocols. Implements sub-second violation detection, automatic remediation triggers, and seamless integration with enforcement framework for comprehensive system oversight.
4:tools: Grep, Read, TodoWrite, Bash
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/core-system/validation-engineer.md
```
2-name: validation-engineer
3-description: Quality methodology and systematic validation specialist focused exclusively on evidence-based verification using 4-gate validation framework (Requirements, Process, Output, System). Implements comprehensive quality assurance methodologies without real-time monitoring or static compliance analysis. \n\n<example>\nContext: Command execution completed, need validation\nUser Query: "Validate the modularization command execution against success criteria"\nAssistant Response: "I'll execute comprehensive validation using the 4-gate methodology. First, Requirements Gate: verifying all modularization specifications met completely [evidence collection]. Process Gate: confirming 8-phase workflow compliance [verification steps]. Output Gate: validating deliverable quality standards [quality metrics]. System Gate: ensuring no regressions introduced [integrity checks]. Generating validation report with quantifiable evidence and quality confirmation."\nCommentary: Demonstrates systematic 4-gate validation approach with evidence-based verification\n</example>\n\n<example>\nContext: Critical system change requiring validation\nUser Query: "Execute comprehensive validation for the principle migration implementation"\nAssistant Response: "Initiating comprehensive validation for critical system change. Applying enhanced validation level with all four quality gates plus additional scrutiny. Evidence collection: [specific metrics]. Performance impact validation: [benchmark results]. Security and integrity verification: [compliance checks]. Cross-reference validation: [link integrity]. Generating comprehensive validation report with complete documentation and stakeholder communication."\nCommentary: Shows comprehensive validation level application for critical changes\n</example>
4:tools: Read, Grep, Bash, TodoWrite, WebFetch
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/core-system/protocol-compliance-verifier.md
```
2-name: protocol-compliance-verifier
3-description: Automatic real-time protocol compliance verification specialist that validates CLAUDE.md adherence before every user interaction, enforces system initialization requirements, and prevents framework violations through immediate remediation.
4:tools: Read, Grep, TodoWrite
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/frontend/vuejs-specialist.md
```
2-name: vuejs-specialist
3-description: Vue.js ecosystem specialist focused on Composition API, Pinia state management, Nuxt.js applications, Vue 3 patterns, and Vue-specific architecture for reactive user interfaces. Integrates Context7 for real-time Vue.js ecosystem updates, framework evolution, and best practices.
4:tools: Read, Write, Edit, MultiEdit, Bash, Grep, Glob, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/frontend/angular-specialist.md
```
2-name: angular-specialist
3-description: Angular ecosystem specialist focused on TypeScript patterns, RxJS reactive programming, dependency injection, Angular Material, and modern Angular architecture for enterprise applications. Integrates Context7 for real-time Angular ecosystem updates, framework evolution, and best practices.
4:tools: Read, Write, Edit, MultiEdit, Bash, Grep, Glob, TodoWrite
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/frontend/css-specialist.md
```
2-name: css-specialist
3-description: CSS architecture and design systems specialist focused on modern CSS patterns, performance optimization, accessibility, responsive design, and scalable styling solutions.
4:tools: Read, Write, Edit, MultiEdit, Bash, Grep, Glob, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/frontend/react-specialist.md
```
2-name: react-specialist
3-description: React ecosystem specialist focused on modern React patterns, hooks, state management, performance optimization, and React-specific architecture for exceptional user interfaces. Integrates Context7 for real-time React ecosystem updates, framework evolution, and best practices.
4:tools: Read, Write, Edit, MultiEdit, Bash, Grep, Glob, TodoWrite
5-model: sonnet
6-color: cyan
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/frontend/build-tools-specialist.md
```
2-name: build-tools-specialist
3-description: Frontend build tools and optimization specialist focused on webpack, Vite, bundling strategies, performance optimization, and modern development workflow automation.
4:tools: Read, Write, Edit, MultiEdit, Bash, Grep, Glob, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/quality/simplicity-metrics-dashboard.md
```
2-name: simplicity-metrics-dashboard
3-description: Comprehensive real-time dashboard platform providing visibility into system complexity, over-engineering indicators, SIMPLE framework compliance, and proactive complexity management through advanced visualization, trend analysis, and actionable insights for multi-stakeholder decision making.
4:tools: Read, Edit, MultiEdit, Grep, LS, Write, TodoWrite, Glob
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/quality/simplicity-enforcer.md
```
2-name: simplicity-enforcer
3-description: Comprehensive continuous monitoring and enforcement agent for proactive complexity prevention, real-time violation detection, automated intervention workflows, and SIMPLE framework integration with the overdrive-engineering command system.
4:tools: Read, Edit, MultiEdit, Grep, LS, Write, TodoWrite, Glob
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/quality/test-architect.md
```
2-name: test-architect
3-description: Comprehensive testing strategy design and implementation specialist that creates robust test frameworks, automated testing pipelines, and systematic quality assurance protocols across software development lifecycle. Generates unit, integration, and system test cases while designing test automation frameworks and analyzing coverage gaps. \n\n<example>\nContext: New feature development requires comprehensive testing strategy\nUser Query: "Design testing strategy for the new payment processing module"\nAssistant Response: "I'll design a comprehensive testing strategy for your payment processing module. First, analyzing requirements to generate test cases covering functional, security, and performance aspects [requirement analysis]. Creating test pyramid with unit tests for payment logic, integration tests for external APIs, and system tests for end-to-end workflows [framework design]. Implementing automated test pipeline with coverage analysis and gap identification [automation strategy]. Designing test data management for various payment scenarios and edge cases [data management]. Generating validation protocols with quality gates integration [validation framework]."\nCommentary: Demonstrates systematic testing approach with comprehensive strategy design\n</example>\n\n<example>\nContext: Existing codebase needs test coverage analysis and improvement\nUser Query: "Analyze test coverage gaps and create improvement plan for the user management system"\nAssistant Response: "Executing comprehensive test coverage analysis for user management system. Scanning codebase for test coverage metrics and identifying gaps [coverage analysis]. Generating missing test cases for uncovered code paths and edge cases [gap identification]. Designing test automation enhancements with CI/CD integration [automation improvement]. Creating test data management strategy for user scenarios and validation rules [data strategy]. Implementing quality gates with validation protocols ensuring systematic coverage improvement [quality assurance]."\nCommentary: Shows systematic coverage analysis with gap identification and improvement planning\n</example>
4:tools: Read, Write, Bash, Grep, TodoWrite
5-model: sonnet
6-color: lime
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/quality/performance-testing-specialist.md
```
2-name: performance-testing-specialist
3-description: Performance testing methodology specialist focused exclusively on load testing, stress testing, performance benchmarking, bottleneck identification through testing, and performance validation frameworks. Operates through systematic testing protocols with comprehensive test execution and measurement.
4:tools: Bash, BashOutput, Read, Grep, TodoWrite, WebFetch
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/quality/code-quality-auditor.md
```
2-name: code-quality-auditor
3-description: Expert in code review, static analysis, and quality metrics enforcement, ensuring code maintainability, performance, and adherence to standards.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: yellow
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/languages/typescript-expert-specialist.md
```
24-</example>
25-
26:tools: Read, Edit, Write, Bash, Grep, Glob, WebSearch, WebFetch, TodoWrite
27-model: sonnet
28-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/languages/rust-expert-specialist.md
```
24-</example>
25-
26:tools: Read, Edit, Write, Bash, Grep, Glob, WebSearch, WebFetch, TodoWrite
27-model: sonnet
28-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/languages/python-expert-specialist.md
```
24-</example>
25-
26:tools: Read, Edit, Write, Bash, Grep, Glob, WebSearch, WebFetch, TodoWrite
27-model: sonnet
28-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/languages/javascript-nodejs-expert-specialist.md
```
24-</example>
25-
26:tools: Read, Edit, Write, Bash, Grep, Glob, WebSearch, WebFetch, TodoWrite
27-model: sonnet
28-color: yellow
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/languages/go-expert-specialist.md
```
24-</example>
25-
26:tools: Read, Edit, Write, Bash, Grep, Glob, WebSearch, WebFetch, TodoWrite
27-model: sonnet
28-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/languages/csharp-expert-specialist.md
```
24-</example>
25-
26:tools: Read, Edit, Write, Bash, Grep, Glob, WebSearch, WebFetch, TodoWrite
27-model: sonnet
28-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/languages/php-expert-specialist.md
```
24-</example>
25-
26:tools: Read, Edit, Write, Bash, Grep, Glob, WebSearch, WebFetch, TodoWrite
27-model: sonnet
28-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/languages/java-expert-specialist.md
```
24-</example>
25-
26:tools: Read, Edit, Write, Bash, Grep, Glob, WebSearch, WebFetch, TodoWrite
27-model: sonnet
28-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/architecture/agent-architect.md
```
2-name: agent-architect
3-description: Create new AI agents for specific tasks and capabilities, analyzing requirements and producing deployment-ready configurations.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, NotebookEdit, WebFetch, TodoWrite, WebSearch, BashOutput, KillBash
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/architecture/agent-creator.md
```
2-name: agent-creator
3-description: Create specialized agents based on detected capability gaps or specific task requirements.
4:tools: Read, Write, Edit, MultiEdit, Glob, Grep, LS, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/architecture/pattern-generator.md
```
2-name: pattern-generator
3-description: Generate standardized patterns for commands, agents, principles, components, navigation, and actions enabling systematic framework expansion
4:tools: Read, Write, Edit, MultiEdit, Grep, LS, Bash, TodoWrite
5-model: sonnet
6-color: cyan
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/architecture/security-architecture-specialist.md
```
2-name: security-architecture-specialist
3-description: Security architecture design and secure system engineering specialist that creates comprehensive security architectures, designs zero-trust frameworks, implements defense-in-depth strategies, architects secure communication protocols, and establishes security-by-design principles for enterprise-grade secure systems with embedded threat modeling and compliance integration.
4:tools: Read, Write, Grep, Bash, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/architecture/component-architecture-specialist.md
```
2-name: component-architecture-specialist
3-description: Component design and integration specialist for systematic architecture optimization and modular design management
4:tools: Read, Edit, MultiEdit, Grep, LS, Write, Bash, TodoWrite, Glob
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/architecture/api-architect.md
```
2-name: api-architect
3-description: API design and service architecture specialist for REST, GraphQL, and microservices that creates comprehensive API specifications, designs microservice boundaries, implements service communication patterns, manages API gateways, and architects service mesh integration strategies.
4:tools: Read, Write, WebFetch, Bash, TodoWrite
5-model: sonnet
6-color: blue
--
24-Commentary: Shows systematic approach to modern API design with legacy integration and incremental migration strategies
25-</example>
26:tools: Read, Write, WebFetch, Bash, TodoWrite
27-model: sonnet
28-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/specializations/gaming/game-development-specialist.md
```
2-name: game-development-specialist
3-description: Expert in game development across multiple platforms and engines, specializing in gameplay programming, graphics, physics, and multiplayer systems with focus on performance and player experience.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: cyan
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/specializations/frontend/frontend-development-specialist.md
```
2-name: frontend-development-specialist
3-description: Expert in modern frontend development with React, Vue, Angular, and web technologies, focusing on user experience, performance, and accessibility.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: pink
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/specializations/iot/iot-specialist.md
```
2-name: iot-specialist
3-description: Expert in Internet of Things development, embedded systems, sensor integration, and edge computing with focus on connectivity, security, and scalable IoT architectures.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: teal
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/specializations/blockchain/blockchain-specialist.md
```
2-name: blockchain-specialist
3-description: Expert in blockchain technology, smart contracts, DeFi protocols, and Web3 development with focus on Ethereum, Solidity, and decentralized applications.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: gold
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/specializations/mobile/mobile-development-specialist.md
```
2-name: mobile-development-specialist
3-description: Expert in iOS and Android mobile development with React Native, Flutter, and native technologies, focusing on performance, user experience, and cross-platform solutions.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/specializations/ai/machine-learning-specialist.md
```
2-name: machine-learning-specialist
3-description: Expert in machine learning model development, data science, and AI integration with focus on practical applications, model optimization, and deployment strategies.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/specializations/data/database-specialist.md
```
2-name: database-specialist
3-description: Expert in database design, implementation, and optimization across SQL and NoSQL platforms, handling schema design, query optimization, and data architecture.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: cyan
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/workflow/integration-coordinator.md
```
2-name: integration-coordinator
3-description: Multi-system integration and coordination management specialist that orchestrates complex workflows across distributed systems, manages API integrations, monitors long-running processes, and coordinates parallel agent operations with robust failure recovery protocols.
4:tools: Bash, WebFetch, BashOutput, KillBash, TodoWrite
5-model: sonnet
6-color: magenta
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/workflow/deployment-coordinator.md
```
2-name: deployment-coordinator
3-description: CI/CD pipeline orchestration and deployment strategy specialist that designs comprehensive continuous integration and deployment pipelines, manages advanced release strategies including blue-green and canary deployments, coordinates multi-environment promotion workflows, implements automated deployment processes with rollback capabilities, and establishes quality gates throughout deployment pipelines.
4:tools: Bash, BashOutput, WebFetch, KillBash, TodoWrite
5-model: sonnet
6-color: green
--
31-Commentary: Agent demonstrates advanced deployment strategy knowledge, integration with monitoring systems, and automated decision-making based on quality gates.
32-</example>
33:tools: Bash, BashOutput, WebFetch, KillBash, TodoWrite
34-model: sonnet
35-color: darkblue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/workflow/workflow-coordinator.md
```
2-name: workflow-coordinator
3-description: 8-phase methodology orchestration specialist that coordinates complete workflow execution from clarification through validation, manages intelligent phase transitions with built-in quality gates, supports recursive operations for continuous improvement cycles, and integrates seamlessly with existing agent ecosystem through Task tool framework.
4:tools: Bash, Read, Write, Edit, MultiEdit, Grep, LS, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/workflow/component-extraction-specialist.md
```
2-name: component-extraction-specialist
3-description: Specializes in modularizing large codebases, extracting components, and breaking down complex files into manageable modules while maintaining functionality and dependencies.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/development/workflow/git-workflow-specialist.md
```
2-name: git-workflow-specialist
3-description: Git workflow integration and version control management specialist for systematic 8-phase methodology implementation
4:tools: Bash, Read, Grep, LS, TodoWrite
5-model: sonnet
6-color: gray
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/project-management/analysis/business-analyst.md
```
2-name: business-analyst
3-description: Expert in business requirements analysis, process optimization, and stakeholder communication to bridge technical solutions with business objectives.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/project-management/coordination/command-selection-advisor.md
```
2-name: command-selection-advisor
3-description: Intelligent command matching and recommendation for command-centered architecture, analyzing user requests and providing scored command recommendations.
4:tools: Read, Grep, LS, TodoWrite
5-model: sonnet
6-color: teal
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/project-management/coordination/change-management-specialist.md
```
2-name: change-management-specialist
3-description: Expert in organizational change management, adoption strategies, and stakeholder engagement to ensure successful transformation initiatives.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/project-management/coordination/delegation-advisor.md
```
2-name: delegation-advisor
3-description: Provide instructions on HOW to delegate tasks to appropriate agents without performing delegation directly.
4:tools: Read, Grep, LS, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/project-management/coordination/project-optimizer.md
```
2-name: project-optimizer
3-description: Analyze and optimize project structure, code quality, and development workflow for comprehensive improvements.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, NotebookEdit, WebFetch, TodoWrite, WebSearch, BashOutput, KillBash
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/project-management/optimization/agent-optimizer.md
```
2-name: agent-optimizer
3-description: Optimize agent deployment patterns and eliminate redundancy in agent selection and coordination workflows.
4:tools: Grep, Read, Edit, MultiEdit, Write, LS, Bash, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/project-management/execution/ticket-executor-agent.md
```
2-name: ticket-executor-agent
3-description: Executes ticket workflows and task management operations, coordinating between commands and agents to complete assigned work items systematically.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/project-management/execution/ticket-automation-orchestrator.md
```
2-name: ticket-automation-orchestrator
3-description: Comprehensive ticket lifecycle orchestration specialist providing automated coordination, dependency resolution, quality validation, and intelligent scheduling for systematic ticket management and execution optimization across complex project environments.
4:tools: Read, Grep, Glob, LS, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/project-management/analytics/metrics-analyst.md
```
2-name: metrics-analyst
3-description: Business intelligence, KPI tracking, and analytics reporting specialist that designs comprehensive BI frameworks, creates automated reporting systems, and provides data-driven insights for strategic decision making.
4:tools: Bash, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: gold
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/planning/technical-planning-specialist.md
```
2-name: technical-planning-specialist
3-description: Technical planning specialist for development workflows, implementation strategies, and technical coordination. Serves as intelligent selector for technical execution patterns, coordinating specialized development agents for optimal code quality, performance, and delivery efficiency.
4:tools: Read, Grep, Write, TodoWrite, WebSearch, WebFetch
5-model: sonnet
6-color: cyan
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/planning/domain-planning-specialist.md
```
2-name: domain-planning-specialist
3-description: Expert in business requirements analysis, stakeholder alignment, and domain-specific workflow coordination serving as intelligent selector for business analysts, UX specialists, and domain experts.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/planning/operational-planning-specialist.md
```
2-name: operational-planning-specialist
3-description: Operational planning specialist for deployment, monitoring, maintenance workflows, and operational excellence. Serves as intelligent selector for DevOps, SRE, and operational specialists, coordinating infrastructure deployment, monitoring strategies, incident response planning, and operational reliability optimization.
4:tools: Read, Grep, Write, TodoWrite, WebSearch, WebFetch
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/planning/strategic-planning-specialist.md
```
2-name: strategic-planning-specialist
3-description: Strategic planning specialist for enterprise architecture decisions and long-term roadmap development. Serves as intelligent selector analyzing requirements to recommend optimal agent combinations for strategic initiatives across business, technical, security, and operational domains.
4:tools: Read, Grep, Write, TodoWrite, WebSearch, WebFetch
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/content/technical-writer.md
```
2-name: technical-writer
3-description: Expert in creating comprehensive technical documentation, API documentation, user guides, and developer resources with focus on clarity and usability.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/content/knowledge-curator.md
```
2-name: knowledge-curator
3-description: Knowledge base maintenance and information architecture specialist that identifies documentation gaps, organizes knowledge systematically, optimizes repository structure for discoverability, enhances information retrieval processes, and facilitates knowledge transfer workflows across organizational systems.
4:tools: Read, Grep, WebSearch, TodoWrite
5-model: sonnet
6-color: indigo
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/backend/backend-development-specialist.md
```
2-name: backend-development-specialist
3-description: Comprehensive backend development specialist focused on server architecture, database design, security patterns, performance optimization, and modern backend technologies for scalable applications.
4:tools: Read, Write, Edit, MultiEdit, Bash, Grep, Glob, WebFetch, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/backend/microservices-architect.md
```
2-name: microservices-architect
3-description: Microservices architecture specialist focused on distributed systems design, service decomposition, inter-service communication, event-driven patterns, and comprehensive microservices governance for scalable distributed applications.
4:tools: Read, Write, Edit, MultiEdit, Bash, WebFetch, Grep, Glob, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/backend/api-design-specialist.md
```
2-name: api-design-specialist
3-description: API design and standards specialist focused on RESTful API patterns, OpenAPI specifications, endpoint optimization, request/response design, and comprehensive API documentation for developer experience excellence. Integrates Context7 for real-time API standards updates, security practices, and design pattern evolution.
4:tools: Read, Write, Edit, MultiEdit, WebFetch, Grep, Glob, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/operations/optimization/process-optimizer.md
```
2-name: process-optimizer
3-description: Expert in workflow optimization, efficiency improvements, and process reengineering to eliminate bottlenecks and maximize organizational productivity.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/operations/compliance/data-governance-compliance-specialist.md
```
2-name: data-governance-compliance-specialist
3-description: Data privacy regulations and governance compliance specialist with doctorate-level expertise in GDPR, CCPA, LGPD, PIPEDA, and emerging privacy frameworks. Specializes in privacy by design implementation, data sovereignty compliance, cross-border data transfer protocols, consent management systems, and privacy impact assessments. \n\n<example>\nContext: Multinational SaaS platform requiring GDPR Article 30 compliance documentation\nUser Query: Create comprehensive data processing records for our customer analytics platform under GDPR Article 30\nAssistant Response: I'll create complete Article 30 records mapping all data processing activities. This includes detailed processing purposes, legal bases, data categories, recipient categories, retention periods, cross-border transfers with appropriate safeguards, and technical security measures. Each record will include controller/processor roles, data subject categories, and specific deletion procedures aligned with your privacy policy.\nCommentary: Demonstrates ultra-specific GDPR expertise with comprehensive documentation requirements\n</example>\n\n<example>\nContext: Healthcare technology company expanding to California requiring CCPA compliance\nUser Query: Design CCPA-compliant privacy infrastructure for patient portal with data minimization principles\nAssistant Response: I'll architect CCPA-compliant privacy infrastructure implementing privacy by design from data collection through deletion. This includes opt-out mechanisms, data mapping for deletion requests, third-party disclosure tracking, consumer rights fulfillment workflows, and privacy policy automation. The design ensures data minimization while maintaining healthcare functionality and HIPAA compatibility.\nCommentary: Shows multi-regulatory expertise combining CCPA with healthcare-specific requirements\n</example>\n\n<example>\nContext: European fintech requiring data localization and cross-border transfer compliance\nUser Query: Validate our data sovereignty strategy for EU financial data processing with third-party vendors\nAssistant Response: I'll conduct comprehensive data sovereignty validation covering data residency requirements, adequacy decisions, Standard Contractual Clauses implementation, and vendor compliance verification. This includes mapping data flows, validating transfer mechanisms, assessing third-party processor agreements, and creating audit trails for regulatory examinations under both GDPR and financial services regulations.\nCommentary: Demonstrates sophisticated understanding of data sovereignty and regulatory intersections\n</example>
4:tools: Read, Grep, WebSearch, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/operations/compliance/compliance-auditor.md
```
2-name: compliance-auditor
3-description: Regulatory compliance and standards adherence validation specialist that systematically audits systems against regulatory frameworks, maps requirements to implementations, identifies compliance gaps, and generates comprehensive compliance documentation. \n\n<example>\nContext: Financial services application requiring SOC 2 Type II compliance validation\nUser Query: Audit our payment processing system for SOC 2 compliance requirements\nAssistant Response: I'll conduct a comprehensive SOC 2 Type II compliance audit of your payment processing system. This includes evaluating security controls, availability measures, processing integrity, confidentiality safeguards, and privacy protections. I'll map each control to your implementation, identify gaps, and provide remediation recommendations with timeline estimates.\nCommentary: Demonstrates systematic approach to specific compliance framework with clear deliverables\n</example>\n\n<example>\nContext: Healthcare system needing HIPAA compliance verification\nUser Query: Generate a HIPAA compliance gap analysis for our patient data management system\nAssistant Response: I'll perform a thorough HIPAA compliance gap analysis focusing on the Administrative, Physical, and Technical Safeguards. This includes reviewing access controls, audit logs, encryption standards, breach notification procedures, and business associate agreements. The analysis will include risk ratings and prioritized remediation plans.\nCommentary: Shows domain-specific expertise with structured methodology for healthcare regulations\n</example>\n\n<example>\nContext: E-commerce platform requiring PCI DSS compliance\nUser Query: Validate our payment card data handling against PCI DSS requirements\nAssistant Response: I'll conduct a comprehensive PCI DSS compliance validation covering all 12 requirements across 6 control objectives. This includes network security, cardholder data protection, vulnerability management, access control, monitoring, and information security policies. I'll map your current controls to requirements and identify remediation priorities.\nCommentary: Demonstrates comprehensive framework knowledge with systematic validation approach\n</example>
4:tools: Read, Grep, WebSearch, TodoWrite
5-model: sonnet
6-color: navy
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/operations/compliance/incident-coordinator.md
```
2-name: incident-coordinator
3-description: Incident response, post-mortem analysis, and Site Reliability Engineering specialist that coordinates immediate response to production incidents and outages, conducts thorough post-incident analysis and documentation, implements SRE practices and reliability improvements, manages incident escalation protocols and communication channels, and designs recovery procedures with preventive measures for enhanced system reliability.
4:tools: Bash, WebFetch, TodoWrite, BashOutput
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/operations/monitoring/monitoring-specialist.md
```
2-name: monitoring-specialist
3-description: Real-time operational monitoring specialist focused exclusively on live system performance tracking, alerting infrastructure management, dashboard coordination, incident response orchestration, and monitoring system optimization. Operates in real-time environments with live metrics and operational visibility.
4:tools: Bash, BashOutput, TodoWrite, WebFetch
5-model: sonnet
6-color: teal
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/operations/monitoring/performance-optimizer.md
```
2-name: performance-optimizer
3-description: System performance analysis and optimization implementation specialist that identifies bottlenecks, monitors resource utilization, implements optimization strategies, validates performance improvements, and establishes ongoing monitoring systems to ensure optimal system performance and efficiency.
4:tools: Bash, BashOutput, Read, Grep, TodoWrite
5-model: sonnet
6-color: yellow
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/operations/infrastructure/devops-engineer.md
```
2-name: devops-engineer
3-description: Expert in CI/CD pipelines, infrastructure automation, deployment strategies, and DevOps practices for reliable software delivery and operations.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/operations/infrastructure/cloud-solutions-architect.md
```
2-name: cloud-solutions-architect
3-description: Expert in cloud architecture design and implementation across AWS, Azure, and GCP, specializing in serverless, containers, and scalable infrastructure solutions.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/iot/edge-computing-specialist.md
```
2-name: edge-computing-specialist
3-description: Expert in edge computing architectures, distributed processing, and intelligent edge systems with focus on real-time analytics, machine learning inference, and optimized compute resource management at the network edge.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: cyan
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/iot/industrial-iot-specialist.md
```
2-name: industrial-iot-specialist
3-description: Expert in Industrial IoT systems, manufacturing automation, and industrial communication protocols with focus on predictive maintenance, process optimization, and integration with enterprise manufacturing systems.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/iot/iot-device-specialist.md
```
2-name: iot-device-specialist
3-description: Expert in embedded systems development, sensor integration, microcontroller programming, and IoT device hardware optimization with focus on power efficiency, real-time processing, and robust device communication protocols.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: teal
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/iot/iot-data-pipeline-specialist.md
```
2-name: iot-data-pipeline-specialist
3-description: Expert in IoT data pipelines, real-time streaming analytics, and scalable data architecture with focus on sensor data ingestion, time-series processing, and intelligent data transformation for IoT ecosystems.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/iot/iot-security-specialist.md
```
2-name: iot-security-specialist
3-description: Expert in IoT cybersecurity, device security, and network protection with focus on end-to-end encryption, secure authentication, vulnerability assessment, and comprehensive security frameworks for distributed IoT ecosystems.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/testing/unit-testing-specialist.md
```
2-name: unit-testing-specialist
3-description: Comprehensive unit testing specialist focused on atomic code-level testing, test-driven development, mocking strategies, and code coverage optimization. Designs isolated test suites, implements advanced mocking frameworks, and creates systematic unit test documentation with continuous integration protocols. \n\n<example>\nContext: New feature development requires comprehensive unit test coverage\nUser Query: "Create unit tests for the user authentication service with comprehensive mocking"\nAssistant Response: "I'll create comprehensive unit tests for your authentication service. First, analyzing service dependencies to design isolated test scenarios [dependency analysis]. Creating test suites with advanced mocking strategies for external services and database interactions [mocking framework]. Implementing edge case coverage for authentication flows, error handling, and boundary conditions [comprehensive coverage]. Designing test data factories with realistic scenarios and validation assertions [test data management]. Establishing continuous integration protocols with coverage reporting and quality gates [CI integration]."\nCommentary: Demonstrates systematic unit testing approach with isolation and comprehensive coverage\n</example>\n\n<example>\nContext: Existing codebase needs unit test coverage improvement\nUser Query: "Analyze unit test gaps and implement TDD practices for the payment processing module"\nAssistant Response: "Executing unit test coverage analysis for payment processing module. Scanning code for test coverage gaps and identifying untested code paths [coverage analysis]. Implementing test-driven development approach with red-green-refactor cycles [TDD implementation]. Creating comprehensive mocking strategies for payment gateways and external dependencies [advanced mocking]. Designing unit test suites with edge case validation and error scenario coverage [systematic testing]. Establishing coverage targets with quality gate integration and continuous monitoring [quality assurance]."\nCommentary: Shows systematic TDD implementation with gap analysis and coverage optimization\n</example>
4:tools: Read, Write, Bash, Grep, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/testing/integration-testing-specialist.md
```
2-name: integration-testing-specialist
3-description: Comprehensive integration testing specialist focused on component interaction validation, API testing protocols, database integration testing, and inter-service communication verification. Designs comprehensive integration test suites, implements contract testing frameworks, and creates systematic component interaction validation with continuous integration protocols. \n\n<example>\nContext: Microservices architecture requires comprehensive integration testing strategy\nUser Query: "Design integration tests for the order processing microservices with payment and inventory services"\nAssistant Response: "I'll design comprehensive integration tests for your microservices ecosystem. First, analyzing service interaction patterns to identify integration points and data flow dependencies [service mapping]. Creating contract testing framework with API validation protocols and service boundary verification [contract testing]. Implementing database integration tests with transaction coordination and data consistency validation [database integration]. Designing inter-service communication tests with message queue validation and systematic error handling [communication testing]. Establishing integration test automation with environment management and systematic validation protocols [automation framework]."\nCommentary: Demonstrates systematic integration testing approach with comprehensive service interaction coverage\n</example>\n\n<example>\nContext: Legacy system integration with new components requires validation\nUser Query: "Create integration tests for new API gateway integration with existing backend services"\nAssistant Response: "Executing integration testing strategy for API gateway implementation. Analyzing existing service interfaces to design compatibility testing protocols [interface analysis]. Creating integration test suites with legacy system validation and backward compatibility verification [legacy integration]. Implementing API gateway testing with routing validation, authentication flow testing, and systematic load balancing verification [gateway testing]. Designing data transformation testing with systematic validation protocols and error scenario coverage [data integration]. Establishing integration monitoring with continuous validation and systematic regression testing protocols [monitoring integration]."\nCommentary: Shows systematic legacy integration approach with compatibility validation and comprehensive testing coverage\n</example>
4:tools: Read, Write, Bash, Grep, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/testing/security-testing-specialist.md
```
2-name: security-testing-specialist
3-description: Comprehensive security testing specialist focused on vulnerability assessment, penetration testing protocols, authentication security validation, and systematic threat modeling with security compliance verification. Designs security test frameworks, implements automated security scanning, and creates systematic security validation protocols with continuous monitoring integration. Integrates Context7 for real-time security threat intelligence, vulnerability databases, and attack methodology evolution. \n\n<example>\nContext: Web application requires comprehensive security vulnerability assessment\nUser Query: "Design security testing strategy for the customer portal with authentication and data protection validation"\nAssistant Response: "I'll design comprehensive security testing for your customer portal. First, conducting threat modeling analysis to identify attack vectors and vulnerability surfaces [threat analysis]. Creating penetration testing framework with authentication bypass testing, injection attack validation, and systematic privilege escalation verification [penetration testing]. Implementing automated security scanning with OWASP compliance validation and systematic vulnerability detection protocols [automated scanning]. Designing data protection testing with encryption validation, access control verification, and systematic privacy compliance testing [data protection]. Establishing security monitoring integration with threat detection and systematic incident response protocols [security monitoring]."\nCommentary: Demonstrates systematic security testing approach with comprehensive threat validation\n</example>\n\n<example>\nContext: API security requires comprehensive validation and compliance testing\nUser Query: "Create security test suite for REST API with OAuth authentication and rate limiting validation"\nAssistant Response: "Executing comprehensive API security testing strategy. Analyzing API endpoints to identify security vulnerabilities and authentication weaknesses [API analysis]. Creating OAuth security testing with token validation, scope verification, and systematic authentication bypass testing [OAuth testing]. Implementing rate limiting validation with DDoS simulation, throttling verification, and systematic abuse prevention testing [rate limiting]. Designing API input validation testing with injection attack prevention and systematic data sanitization verification [input validation]. Establishing API security monitoring with threat detection and systematic compliance validation protocols [security monitoring]."\nCommentary: Shows systematic API security approach with comprehensive authentication and protection validation\n</example>
4:tools: Read, Write, Bash, Grep, TodoWrite
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/testing/e2e-testing-specialist.md
```
2-name: e2e-testing-specialist
3-description: Comprehensive end-to-end testing specialist focused on complete user workflow validation, browser automation, cross-platform testing, and systematic full-system behavior verification. Designs user journey testing frameworks, implements automated browser testing protocols, and creates systematic user experience validation with continuous integration. \n\n<example>\nContext: E-commerce platform requires comprehensive user journey testing\nUser Query: "Design E2E tests for the complete customer purchase workflow from product browsing to order confirmation"\nAssistant Response: "I'll design comprehensive E2E tests for your customer purchase workflow. First, mapping complete user journey from product discovery to order completion with systematic touchpoint identification [journey mapping]. Creating browser automation framework with cross-platform testing protocols and device-specific validation [automation framework]. Implementing user interaction testing with form validation, payment processing, and systematic error scenario coverage [interaction testing]. Designing visual regression testing with UI consistency validation and systematic accessibility compliance verification [visual testing]. Establishing E2E test automation with continuous integration and systematic user experience monitoring [automation integration]."\nCommentary: Demonstrates systematic E2E testing approach with comprehensive user workflow coverage\n</example>\n\n<example>\nContext: Multi-platform application needs comprehensive E2E validation\nUser Query: "Create E2E test suite for mobile and web application with cross-platform user experience validation"\nAssistant Response: "Executing comprehensive E2E testing strategy for multi-platform application. Analyzing user workflows across web and mobile platforms to identify consistency requirements [platform analysis]. Creating cross-platform automation framework with responsive design validation and systematic device compatibility testing [cross-platform framework]. Implementing user experience testing with navigation validation, performance consistency, and systematic accessibility compliance [UX testing]. Designing data synchronization testing with offline capability validation and systematic cross-device state management [sync testing]. Establishing comprehensive monitoring with user journey analytics and systematic performance validation protocols [monitoring framework]."\nCommentary: Shows systematic cross-platform E2E approach with comprehensive user experience validation\n</example>
4:tools: Read, Write, Bash, Grep, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/testing/performance-load-testing-specialist.md
```
2-name: performance-load-testing-specialist
3-description: Comprehensive performance and load testing specialist focused on system performance validation, scalability testing, stress testing protocols, and systematic performance optimization with continuous monitoring integration. Designs performance test frameworks, implements automated load testing, and creates systematic performance validation protocols. \n\n<example>\nContext: E-commerce platform requires comprehensive performance validation for high-traffic scenarios\nUser Query: "Design performance testing strategy for the product catalog system with Black Friday traffic simulation"\nAssistant Response: "I'll design comprehensive performance testing for your product catalog system. First, analyzing expected traffic patterns to establish performance baselines and scalability requirements [traffic analysis]. Creating load testing framework with gradual traffic ramp-up, peak load simulation, and systematic performance measurement protocols [load testing]. Implementing stress testing with system breaking point identification and systematic recovery validation [stress testing]. Designing performance monitoring with real-time metrics collection, bottleneck identification, and systematic optimization guidance [performance monitoring]. Establishing continuous performance validation with automated testing and systematic regression detection protocols [automation integration]."\nCommentary: Demonstrates systematic performance testing approach with comprehensive scalability validation\n</example>\n\n<example>\nContext: Microservices architecture needs performance optimization and load distribution validation\nUser Query: "Create performance test suite for microservices with container scaling and database performance validation"\nAssistant Response: "Executing comprehensive performance testing strategy for microservices architecture. Analyzing service interaction patterns to identify performance bottlenecks and scaling constraints [service analysis]. Creating distributed load testing with inter-service communication validation and systematic resource utilization monitoring [distributed testing]. Implementing database performance testing with connection pool optimization and systematic query performance validation [database testing]. Designing container scaling validation with auto-scaling trigger testing and systematic resource allocation verification [scaling validation]. Establishing performance monitoring integration with APM tools and systematic optimization recommendation protocols [monitoring integration]."\nCommentary: Shows systematic microservices performance approach with comprehensive scaling and optimization validation\n</example>
4:tools: Read, Write, Bash, Grep, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/blockchain/nft-token-specialist.md
```
2-name: nft-token-specialist
3-description: NFT and token expert specializing in token economics, NFT platforms, minting systems, and digital asset trading.
4:tools: Read, Write, Edit, MultiEdit, Glob, Grep, LS, TodoWrite
5-model: sonnet
6-color: magenta
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/blockchain/defi-protocol-specialist.md
```
2-name: defi-protocol-specialist
3-description: DeFi expert specializing in decentralized finance protocols, yield strategies, and liquidity management systems.
4:tools: Read, Write, Edit, MultiEdit, Glob, Grep, LS, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/blockchain/blockchain-infrastructure-specialist.md
```
2-name: blockchain-infrastructure-specialist
3-description: Blockchain infrastructure expert specializing in node management, network scaling, consensus mechanisms, and enterprise blockchain architecture.
4:tools: Read, Write, Edit, MultiEdit, Glob, Grep, LS, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/blockchain/smart-contract-specialist.md
```
2-name: smart-contract-specialist
3-description: Solidity expert specializing in smart contract development, testing, and deployment across multiple blockchain networks.
4:tools: Read, Write, Edit, MultiEdit, Glob, Grep, LS, TodoWrite
5-model: sonnet
6-color: cyan
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/blockchain/web3-integration-specialist.md
```
2-name: web3-integration-specialist
3-description: Web3 expert specializing in dApp development, blockchain frontend integration, and wallet connectivity.
4:tools: Read, Write, Edit, MultiEdit, Glob, Grep, LS, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/ai-ml/nlp-specialist.md
```
2-name: nlp-specialist
3-description: Expert in natural language processing, transformer models, and language understanding with focus on modern NLP architectures, text generation, and multimodal language systems.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/ai-ml/deep-learning-specialist.md
```
2-name: deep-learning-specialist
3-description: Expert in neural networks, transformer architectures, and deep learning model development with focus on cutting-edge AI technologies, distributed training, and production deployment. Integrates Context7 for real-time AI research updates, framework evolution, and breakthrough methodologies.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/ai-ml/computer-vision-specialist.md
```
2-name: computer-vision-specialist
3-description: Expert in computer vision, image processing, and video analysis with focus on modern vision architectures, object detection, and multimodal AI systems. Integrates Context7 for real-time computer vision research updates, framework evolution, and breakthrough methodologies.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/ai-ml/mlops-specialist.md
```
2-name: mlops-specialist
3-description: Expert in ML pipeline automation, model deployment, and MLOps lifecycle management with focus on CI/CD for ML, model monitoring, and production ML infrastructure.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/user-experience/ux-research-specialist.md
```
2-name: ux-research-specialist
3-description: Expert in user experience research, usability testing, and user-centered design methodologies to improve product usability and user satisfaction.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/user-experience/ux-architect.md
```
2-name: ux-architect
3-description: User experience design, accessibility, and frontend architecture specialist for user-centered interfaces, inclusive design practices, scalable frontend systems, user research methodologies, and comprehensive design system management.
4:tools: Read, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: pink
--
24-Commentary: Shows systematic approach to frontend architecture with comprehensive design system and research integration
25-</example>
26:tools: Read, WebFetch, WebSearch, TodoWrite
27-model: sonnet
28-color: pink
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/business-analytics/financial-analytics-specialist.md
```
2-name: financial-analytics-specialist
3-description: Advanced financial modeling and forecasting specialist for enterprise financial decision-making, risk assessment, and strategic financial planning with modern analytics frameworks.
4:tools: Read, Grep, Write, Edit, MultiEdit, TodoWrite, Glob, LS
5-model: sonnet
6-color: emerald
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/business-analytics/customer-analytics-specialist.md
```
2-name: customer-analytics-specialist
3-description: Advanced customer behavior analytics and segmentation specialist for customer experience optimization, retention modeling, and personalization strategies with machine learning frameworks.
4:tools: Read, Grep, Write, Edit, MultiEdit, TodoWrite, Glob, LS
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/business-analytics/market-research-specialist.md
```
2-name: market-research-specialist
3-description: Comprehensive market research and competitive intelligence specialist for strategic market analysis, consumer insights, and competitive positioning with advanced analytics frameworks.
4:tools: Read, Grep, Write, Edit, MultiEdit, TodoWrite, Glob, LS
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/business-analytics/business-intelligence-specialist.md
```
2-name: business-intelligence-specialist
3-description: Enterprise business intelligence and data visualization specialist for executive dashboards, self-service analytics, and data-driven decision support systems with modern BI platforms.
4:tools: Read, Grep, Write, Edit, MultiEdit, TodoWrite, Glob, LS
5-model: sonnet
6-color: indigo
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/business-analytics/operations-analytics-specialist.md
```
2-name: operations-analytics-specialist
3-description: Advanced operations analytics and process optimization specialist for operational efficiency, KPI tracking, supply chain analytics, and performance monitoring with real-time analytics frameworks.
4:tools: Read, Grep, Write, Edit, MultiEdit, TodoWrite, Glob, LS
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/infrastructure/service-mesh-specialist.md
```
2-name: service-mesh-specialist
3-description: Expert in service mesh architecture, microservices networking, traffic management, and observability using Istio, Linkerd, and Consul Connect.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: green
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/infrastructure/gitops-specialist.md
```
2-name: gitops-specialist
3-description: Expert in GitOps methodology, infrastructure automation, declarative deployments, and continuous delivery using ArgoCD, Flux, and Tekton.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/infrastructure/observability-specialist.md
```
2-name: observability-specialist
3-description: Expert in comprehensive monitoring, logging, tracing, and alerting systems using Prometheus, Grafana, ELK Stack, Jaeger, and modern observability platforms.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: yellow
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/infrastructure/multi-cloud-specialist.md
```
2-name: multi-cloud-specialist
3-description: Expert in multi-cloud architecture, cloud-agnostic infrastructure, hybrid cloud strategies, and cross-cloud resource management and orchestration.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: cyan
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/infrastructure/kubernetes-orchestration-specialist.md
```
2-name: kubernetes-orchestration-specialist
3-description: Expert in Kubernetes container orchestration, cluster management, workload scheduling, and cloud-native application deployment strategies.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/analytics/strategy-synthesis-agent.md
```
2-name: strategy-synthesis-agent
3-description: Strategic synthesis specialist that consolidates multiple analysis results into comprehensive deployment-ready strategy documents for system orchestrators and decision-making processes.
4:tools: Read, Grep, Write, TodoWrite
5-model: sonnet
6-color: gold
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/analytics/research-analyst.md
```
2-name: research-analyst
3-description: Research analysis and information synthesis specialist that conducts comprehensive research across multiple sources and domains, evaluates evidence quality, identifies insights and trends, and provides competitive intelligence with structured JSON output generation.
4:tools: Read, Grep, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/analytics/sales-analyst.md
```
2-name: sales-analyst
3-description: Sales performance and business metrics analysis specialist that analyzes revenue trends, conversion rates, market positioning, customer segmentation, and provides data-driven sales strategy optimization with structured JSON output generation.
4:tools: Read, Grep, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/analytics/exploration-analyst.md
```
2-name: exploration-analyst
3-description: System exploration and pattern analysis specialist that identifies recurring patterns, anti-patterns, and optimization opportunities through comprehensive codebase, infrastructure, and architecture discovery with structured JSON output generation.
4:tools: Read, Grep, Bash, Glob, LS, WebFetch, WebSearch, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/analytics/report-generator.md
```
2-name: report-generator
3-description: Multi-analysis synthesis specialist that processes multiple JSON analyses into consolidated reports for orchestrator decision-making and comprehensive business intelligence.
4:tools: Read, Grep, Write, TodoWrite
5-model: sonnet
6-color: teal
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/strategy/product-manager.md
```
2-name: product-manager
3-description: Expert in product strategy, feature prioritization, requirements gathering, and stakeholder management to drive product success and market fit.
4:tools: Bash, Glob, Grep, LS, Read, Edit, MultiEdit, Write, TodoWrite
5-model: sonnet
6-color: blue
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/security-advanced/cybersecurity-threat-detection-specialist.md
```
2-name: cybersecurity-threat-detection-specialist
3-description: Advanced cybersecurity threat detection and analysis specialist that leverages AI-driven threat hunting, behavioral analytics, threat intelligence integration, and sophisticated SIEM correlation to identify, analyze, and respond to emerging cyber threats with real-time monitoring and automated threat classification.
4:tools: Grep, Bash, WebFetch, WebSearch, Read, TodoWrite
5-model: sonnet
6-color: red
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/security-advanced/incident-response-specialist.md
```
2-name: incident-response-specialist
3-description: Advanced cybersecurity incident response and crisis management specialist that orchestrates comprehensive security breach response, digital forensics investigation, containment and eradication procedures, and business continuity restoration with stakeholder communication and regulatory compliance coordination.
4:tools: Grep, Bash, WebFetch, WebSearch, Read, TodoWrite
5-model: sonnet
6-color: crimson
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/security-advanced/zero-trust-architecture-specialist.md
```
2-name: zero-trust-architecture-specialist
3-description: Zero Trust security architecture design and implementation specialist that creates comprehensive never-trust-always-verify security frameworks, identity-centric access controls, network microsegmentation, and continuous authentication systems with policy-driven security orchestration and risk-based adaptive access management.
4:tools: Grep, Bash, WebFetch, WebSearch, Read, TodoWrite
5-model: sonnet
6-color: orange
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/security-advanced/penetration-testing-specialist.md
```
2-name: penetration-testing-specialist
3-description: Advanced penetration testing and offensive security assessment specialist that conducts comprehensive security evaluations through ethical hacking methodologies, vulnerability exploitation, social engineering assessments, and red team exercises with detailed remediation guidance and security posture enhancement recommendations.
4:tools: Grep, Bash, WebFetch, WebSearch, Read, TodoWrite
5-model: sonnet
6-color: darkred
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/agents/security-advanced/privacy-engineering-specialist.md
```
2-name: privacy-engineering-specialist
3-description: Privacy engineering and data protection compliance specialist that implements privacy-by-design architectures, GDPR and CCPA compliance frameworks, data minimization strategies, and comprehensive privacy impact assessments with automated privacy controls and consent management systems.
4:tools: Grep, Bash, WebFetch, WebSearch, Read, TodoWrite
5-model: sonnet
6-color: purple
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/commands/domains/management/commands/init-claude-md.md
```
105-### Mandatory Global Rule Inheritance
106-- **MANDATORY EXECUTION FLOW**: Request → Command Selection → Task + Agent → 10-Phase Automatic → Validation → Closure → Response
107:- **TASK ORCHESTRATION**: ALL actions MUST use Task tool with subagent_type from [Agent Workflow Mapping](../../../AGENT_WORKFLOW_MAPPING.md)
108-- **PROGRESSIVE THINKING**: Apply complexity-based thinking levels (Think→Think Hard→Think Harder→UltraThink)
109-- **10-PHASE WORKFLOW**: Follow [10-phase detailed methodology](../../../../docs/principles/10-phase-detailed-methodology.md) with integrated research
--
176-### Mandatory Global Rule Inheritance
177-- **MANDATORY EXECUTION FLOW**: Request → Command Selection → Task + Agent → 10-Phase Automatic → Validation → Closure → Response
178:- **TASK ORCHESTRATION**: ALL actions MUST use Task tool with subagent_type from [Agent Workflow Mapping](../../../AGENT_WORKFLOW_MAPPING.md)
179-- **PROGRESSIVE THINKING**: Apply complexity-based thinking levels (Think→Think Hard→Think Harder→UltraThink)
180-- **10-PHASE WORKFLOW**: Follow [10-phase detailed methodology](../../../../docs/principles/10-phase-detailed-methodology.md) with integrated research
```

#### ./backups/20250819-mass-refactoring/pre-refactoring-state/commands/domains/management/commands/manage-systems.md
```
67-- **Purpose**: System status assessment and validation
68-- **Capabilities**: Static analysis, compliance validation, system integrity
69:- **Tools**: Grep, LS, Read, Bash, TodoWrite
70-
71-**Secondary Agent**: configuration-manager (if needed)
```

#### ./CLAUDE.md
```
46-### 📋 ESSENTIAL ORCHESTRATOR-AGENT PATTERN
47-```markdown
48:Task(
49:  subagent_type: "{agent-from-AGENT_WORKFLOW_MAPPING}",
50-  description: "{3-5-word-specific-action}",
51-  prompt: "I am the orchestrator and you are the {agent} agent.
--
126-- ❌ WebSearch tool (orchestrators must deploy agents via Task tools)
127-- ❌ WebFetch tool (orchestrators must deploy agents via Task tools)
128:- ❌ TodoWrite tool (orchestrator-only via Task tools for workflow tracking)
129-
130:**✅ ORCHESTRATOR PATTERN**: Task(subagent_type: "agent-name", description: "action", prompt: "detailed-instruction")
131-**✅ AGENT FREEDOM**: Deployed agents execute directly with Read, Edit, Write, Bash, Grep, Glob, WebSearch, WebFetch
132-
--
147-### 🔄 MANDATORY FRAMEWORK FLOW
148-7. **ORCHESTRATOR TASK TOOL REQUIREMENT**: Orchestrators must use Task tools for agent deployment
149:8. **NEVER BYPASS FRAMEWORK**: Task + subagent_type + Command is MANDATORY for orchestrator actions
150-9. **PRIORITIZE PARALLEL EXECUTION**: Analyze dependencies and execute multiple Task tools when possible
151-10. **DEPLOY SAME AGENT MULTIPLE TIMES**: For independent file operations
--
153-12. **FOLLOW SYSTEM PRINCIPLES**: Always adhere to [Framework Principles](docs/principles/index.md) authority chain
154-13. **AUTOMATIC 10-PHASE**: Commands execute complete workflow dynamically with integrated research and closure
155:14. **INTEGRATED TodoWrite**: Orchestrator-only responsibility for visible workflow progress tracking
156-15. **AUTOMATIC VALIDATION**: Tests/build/lint included in workflow
157-16. **MANDATORY PHASE COMPLETION**: Each phase MUST satisfy completion criteria before proceeding
```

