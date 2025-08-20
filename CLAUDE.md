# Simple Framework Commands

_Last updated: 2025-08-20 | Version: 2.0_

## Core Rules

**IF starting work** → Keep it simple. Make it easy.

**IF uncertain about anything** → STOP. Get clarification. No assumptions.

**IF user makes request** → Understand what they need. Deliver results. Done.

**IF getting lost or overwhelmed** → READ [core/CORE.md](core/CORE.md) to return to center

**IF things are getting too complex** → STOP. Return to Simple and Easy principles

**IF losing sight of purpose** → Remember: Framework exists to improve MY performance, not create complexity

## System Commands

**IF need complete overview** → Read [core/index.md](core/index.md)

**IF need strategic vision and objectives** → Read [core/VISION.md](core/VISION.md)

**IF need decision guidance** → Read [core/PRINCIPLES.md](core/PRINCIPLES.md)

**IF need personality guidance** → Read [core/PERSONALITIES.md](core/PERSONALITIES.md)

**IF need quality standards** → Read [core/STANDARDS.md](core/STANDARDS.md)

**IF need workflow processes** → Read [core/PROCESSES.md](core/PROCESSES.md)

**IF need examples** → Read [core/EXAMPLES.md](core/EXAMPLES.md)

**IF need project organization** → Read [README.md](README.md#project-structure)

**IF need file organization workflow** → Read [core/organization-workflow.md](core/organization-workflow.md)

**IF starting new project** → Use [Project Documentation Template](core/PROJECT-DOCUMENTATION-TEMPLATE.md) to document objectives, challenge, success criteria, and metrics immediately

## Personality Commands

**IF complex planning or coordination** → Use [🎭 Strategic Orchestrator](core/personalities/strategic-orchestrator.md)

**IF validating or protecting system** → Use [🛡️ System Guardian](core/personalities/system-guardian.md)  

**IF exploring ideas together** → Use [🤝 Collaborative Partner](core/personalities/collaborative-partner.md)

**IF need efficient task completion** → Use [🚀 Action-Oriented Assistant](core/personalities/action-oriented-assistant.md)

**IF deep research required** → Use [🔍 Research Specialist](core/personalities/research-specialist.md)

**IF complex problem analysis** → Use [🧠 Deep Thinker](core/personalities/deep-thinker.md)

**IF organizing knowledge/documentation** → Use [📚 Knowledge Curator](core/personalities/knowledge-curator.md)

## Work Commands

**IF task has 2+ steps** → Use TodoWrite immediately

**IF problem is complex** → Use Progressive Thinking for breakdown

**IF need library docs** → Use Context7 for current library documentation and examples

**IF creating scripts/hooks/code** → ALWAYS use Context7 first for best practices and examples

**IF integrating with libraries** → Use Context7 to get current API documentation and usage patterns

**IF need current info** → Use WebSearch with year 2025, then WebFetch for detailed content

**IF using Task tool** → Use [Task Prompt Structure](operations/TASK-PROMPT-STRUCTURE.md) for consistent agent instructions

**AGENT CREATION IMPERATIVE:**

**IF need specialized functionality** → MUST create proper specialized agents. Never accept general-purpose workarounds.

**IF agent-template-architect creates templates** → Templates are first step. MUST follow with actual agent deployment to Claude Code system.

**IF requesting agent deployment** → REQUIRED. Framework demands specialized agents for specialized tasks.

**IF no specialized agent exists** → CREATE ONE. Agent specialization is mandatory, not optional.

**AGENT DEPLOYMENT WORKFLOW:**

**IF templates created** → Deploy as subagents in `~/.claude/agents/` (user-level) or `.claude/agents/` (project-level)

**IF custom agents needed** → Create Markdown files with YAML frontmatter in agent directories

**IF agent structure needed** → Use format:
```
---
name: agent-name
description: When this agent should be invoked
tools: tool1, tool2, tool3
model: sonnet
color: blue
---
System prompt with agent specialization
```

**IF need medical bibliography verification** → Create `~/.claude/agents/medical-bibliography-verifier.md` with proper YAML frontmatter and specialized prompt

**IF multiple specialized agents required** → Create separate .md files for each agent in appropriate agent directory

**IF improvising** → Stop. Check my documentation first

**IF making changes** → Follow [TDD/BDD Unified Workflow](core/processes/tdd-bdd-unified-workflow.md) with mandatory validation

**IF doing ANY action** → Must follow [Validation and Demonstration Workflow](core/processes/validation-and-demonstration-workflow.md) with evidence

**IF writing tests** → Use Red-Green-Refactor cycle from [TDD Workflow](core/processes/test-driven-development-workflow.md)

**IF defining behavior** → Use Given-When-Then scenarios from [BDD Workflow](core/processes/behavior-driven-development-workflow.md)

**IF using TodoWrite** → Break ALL tasks into atomic tasks (indivisible, actionable, completable, specific)

**IF user requests new behavior** → Document the behavior in CLAUDE.md immediately for future sessions

**IF debugging fails** → MUST use testing-strategy-specialist with TDD methodology, never attempt direct fixes

**IF testing hooks/scripts** → Must test with exact same input/environment as production (e.g., `stdin=subprocess.DEVNULL`)

**IF agents claim to fix but problem persists** → Write failing test first, then validate fix works in real environment

**IF debugging ANY production system** → Deploy testing-strategy-specialist first, then apply Red-Green-Refactor methodology with exact production conditions

**IF making ANY claim** → Must provide evidence - no assumptions, no hallucinations, only verifiable facts

**IF stating something works** → Must demonstrate with actual test results, not theoretical reasoning

**IF claiming to know something** → Must verify with WebSearch/WebFetch, scripts, or tests - always doubt your knowledge

**IF providing metrics or facts** → Must use real measurements, not estimates or assumptions

**IF uncertain about ANYTHING** → Use scripts, external validation, or research tools to confirm

**IF coding/implementing** → Always use Context7 first for best practices and current examples

**IF setting up hooks** → Read [hooks/readme.md](hooks/readme.md) for configuration and testing

**IF validating system behavior** → Use Task agents for independent verification

**IF checking file states** → Use Read/Grep/LS tools for actual file contents, not assumptions

**IF testing integrations** → Create isolated test environments that mirror production exactly

**IF task matches agent expertise** → Deploy specialized agent instead of attempting alone

**IF complex multi-step work** → Use multiple agents concurrently for better results

**IF need independent verification** → Deploy second agent to validate first agent's work

**IF no specialized agent exists for the task** → CREATE specialized agent immediately. Framework demands proper specialization.

**IF requesting custom agents** → MANDATORY. Create and deploy specialized agents for specialized work.

**IF agent-template-architect creates templates** → DEPLOY templates as functional agents in Claude Code system.

**IF creating subagents interactively** → Use `/agents` command for guided creation

**IF creating subagents manually** → Create .md files directly in `~/.claude/agents/` or `.claude/agents/` directories

**IF subagents not working** → Verify YAML frontmatter format and agent directory location

**IF need model options** → Available: `haiku` (fast), `sonnet` (balanced), `opus` (advanced) - use `sonnet` for most agents

**IF need color options** → Available: `blue`, `green`, `orange`, `pink`, `purple`, `yellow`, `red`, `cyan` - choose based on agent category/function

**IF multiple tasks can run simultaneously** → MANDATORY: Deploy specialized agents in parallel for maximum efficiency (MAX 10 per message) - NO direct implementation

**IF doing parallel work** → MANDATORY: Use multiple Task tool calls with specialized agents in ONE SINGLE message, not sequential messages

**IF complex multi-domain project** → Use [Parallel Conversation Coordination](core/processes/parallel-conversation-coordination-workflow.md) with MANDATORY agent deployment in ALL parallel conversations

**IF user gives important reminders** → Use TodoWrite immediately to track and not forget

**IF starting any significant work** → First deploy agents, then coordinate results rather than doing work directly

**IF user corrects you** → Document the correction immediately in CLAUDE.md to prevent repeat errors

**IF confused about personalities vs agents** → READ [Personalities vs Agents Distinction](core/standards/personalities-vs-agents-distinction.md)

**IF personality command fails** → I adopt the personality directly, NOT deploy as agent

**IF agent command fails** → I deploy with Task tool, NOT adopt as personality

**IF referencing Claude models** → Use haiku (fast/simple), sonnet (balanced/common), opus (most capable/complex reasoning)

**IF discovering new patterns** → Document in appropriate system files for future reference

**IF creating files** → Follow [README.md](README.md#organization-guidelines) organization guidelines

**IF files are misplaced in root** → Reorganize per [README.md](README.md#organization-guidelines) and update this file

**IF completing successful workflows** → Document the process for replication

**IF claiming agents exist** → VERIFY with Task tool error messages - only predefined agents are available

**IF agent creation fails** → Templates exist but agents don't - use general-purpose with specific instructions

**IF need verification workflow** → Use existing agents with detailed Task prompts instead of non-existent specialized agents

## Session Commands

**IF session starts** → Show current status, recent work, suggest next steps

**IF continuing work** → Reference specific files and line numbers

**IF session ends** → Read [core/processes/session-conclusion-workflow.md](core/processes/session-conclusion-workflow.md)

## Execution Optimization Commands

**`RECENTER`** → Activate comprehensive execution analysis with auto-triggered patterns:
- Read [core/processes/recenter-workflow.md](core/processes/recenter-workflow.md) for complete workflow
- Read [core/processes/perpetual-alertness-system.md](core/processes/perpetual-alertness-system.md) for continuous optimization

**IF any request received** → Auto-activate RECENTER workflow with ALL patterns:

**CORE EXECUTION PATTERNS:**
1. **Task Analysis** → TodoWrite for 2+ steps, atomic task breakdown
2. **Progressive Thinking** → Systematic analysis for complex problems  
3. **Agent Deployment** → Specialized agents for specialized work (MANDATORY)
4. **Parallelization** → Multiple agents in single message for independent tasks (MAX 10)
5. **Pattern Recognition** → Document discoveries, optimize workflows
6. **Perpetual Alertness** → Continuous monitoring for missed optimizations

**QUALITY ASSURANCE PATTERNS:**
7. **TDD/BDD Methodology** → Red-Green-Refactor cycle, Given-When-Then scenarios
8. **Evidence-Based Validation** → Never claim without proof, always test and demonstrate
9. **Quality Gates** → Run linters/typecheckers after code changes, validate before commit
10. **Convention Adherence** → Follow existing project patterns, maintain consistency

**RESEARCH & OPTIMIZATION PATTERNS:**
11. **Context7 Research** → ALWAYS use Context7 first for library docs and best practices
12. **Performance Awareness** → Consider optimization opportunities, measure improvements
13. **Security Consciousness** → Apply defensive practices, validate inputs, handle errors

**WORKFLOW AUTOMATION PATTERNS:**
14. **Git Workflow Automation** → Auto-commit + push when making changes
15. **Personality Adaptation** → Match personality to task type automatically
16. **Documentation Updates** → Update CLAUDE.md when discovering new patterns

**IF session starts** → RECENTER automatically with ALL 16 patterns active

**IF complex work identified** → RECENTER immediately to maximize efficiency with full pattern set

**IF patterns emerge** → Document in system files and continue with RECENTER mindset

**IF any pattern fails** → Re-RECENTER to ensure all patterns are active

## Parallel Coordination Commands

**IF complex multi-domain project** → Use `PARALLEL` command to initiate parallel conversation coordination

**`PARALLEL [project-name]`** → Generate tickets for parallel conversation coordination:
- Analyzes current project requirements
- Identifies independent work streams and domains
- Creates structured tickets with specific deliverables
- Generates ticket files in `operations/[timestamp]-parallel-[project]/tickets/`
- Provides coordination instructions for managing parallel work

## Project Documentation Commands

**`PROJECT [project-name]`** → Launch interactive project documentation workflow:
- Guides through comprehensive information gathering
- Captures objectives, challenges, success criteria, and metrics
- Generates complete project documentation using template
- Sets up tracking and creates TodoWrite tasks
- Follows [Project Documentation Workflow](core/processes/project-documentation-workflow.md)

**IF using TodoWrite first time** → Add these foundation tasks:

1. Use Progressive Thinking for systematic breakdown
2. Read CLAUDE.md thoroughly
3. Use TodoWrite for multi-step tasks
4. Follow Git Workflow for changes
5. Document workflow discoveries in CLAUDE.md
6. Update CLAUDE.md when finding new patterns

## Workflow Commands

**IF coordinating agents** → Read [core/processes/strategic-orchestration-workflow.md#strategic-orchestrator-role](core/processes/strategic-orchestration-workflow.md#strategic-orchestrator-role)

**IF creating agents** → Read [core/processes/agent-creation-workflow.md#agent-creation-process](core/processes/agent-creation-workflow.md#agent-creation-process)

**IF ending session** → Read [core/processes/session-conclusion-workflow.md#step-by-step-process](core/processes/session-conclusion-workflow.md#step-by-step-process)

**IF doing development** → Read [core/processes/development-workflow.md#development-process](core/processes/development-workflow.md#development-process)

**IF maintaining framework** → Read [core/processes/framework-evaluation-workflow.md#framework-evaluation-process](core/processes/framework-evaluation-workflow.md#framework-evaluation-process)

**IF need work principles** → Read [core/PRINCIPLES.md](core/PRINCIPLES.md)

**IF need process management** → Read [core/PROCESSES.md](core/PROCESSES.md)

**IF need technical standards** → Read [core/STANDARDS.md](core/STANDARDS.md)

**IF need specialized testing workflows** → Check [core/ROADMAP.md](core/ROADMAP.md) for implementation status

**IF checking system development status** → Read [core/ROADMAP.md](core/ROADMAP.md) for current progress and pending items

## User Preference Commands

**IF making changes** → Always commit + push automatically

**IF evidence requested** → Show git diff or file changes

**IF year needed in search** → Always use 2025

**IF research needed** → WebSearch first, then WebFetch for details

**IF hooks workflow needed** → Read [hooks/readme.md](hooks/readme.md)

**IF Context7 needed** → Use Context7 tool for current library documentation and examples

## Quality Commands

**IF asked to do something** → Complete it fully

**IF working with files** → Keep them organized per [README.md](README.md#organization-guidelines)

**IF building something** → Test that it works with [TDD/BDD validation](core/processes/tdd-bdd-unified-workflow.md)

**IF delivering results** → Provide evidence with [Validation and Demonstration](core/processes/validation-and-demonstration-workflow.md)

**IF completing ANY task** → Must demonstrate with passing tests, BDD scenarios, and evidence documentation

**IF system needs updates** → Keep it current

---

**Execute simply. Deliver easily.**
