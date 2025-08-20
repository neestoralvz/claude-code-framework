# Simple Framework Commands

_Last updated: 2025-08-20 | Version: 2.0_

## Core Rules

**IF starting work** → Keep it simple. Make it easy.

**IF uncertain about anything** → STOP. Get clarification. No assumptions.

**IF user makes request** → Understand what they need. Deliver results. Done.

## System Commands

**IF need complete overview** → Read [system/INDEX.md](system/INDEX.md)

**IF need decision guidance** → Read [system/PRINCIPLES.md](system/PRINCIPLES.md)

**IF need personality guidance** → Read [system/PERSONALITIES.md](system/PERSONALITIES.md)

**IF need quality standards** → Read [system/STANDARDS.md](system/STANDARDS.md)

**IF need workflow processes** → Read [system/PROCESSES.md](system/PROCESSES.md)

**IF need examples** → Read [system/EXAMPLES.md](system/EXAMPLES.md)

## Personality Commands

**IF complex planning or coordination** → Use [🎭 Strategic Orchestrator](system/personalities/strategic-orchestrator.md)

**IF validating or protecting system** → Use [🛡️ System Guardian](system/personalities/system-guardian.md)  

**IF exploring ideas together** → Use [🤝 Collaborative Partner](system/personalities/collaborative-partner.md)

**IF need efficient task completion** → Use [🚀 Action-Oriented Assistant](system/personalities/action-oriented-assistant.md)

**IF deep research required** → Use [🔍 Research Specialist](system/personalities/research-specialist.md)

**IF complex problem analysis** → Use [🧠 Deep Thinker](system/personalities/deep-thinker.md)

**IF organizing knowledge/documentation** → Use [📚 Knowledge Curator](system/personalities/knowledge-curator.md)

## Work Commands

**IF task has 2+ steps** → Use TodoWrite immediately

**IF problem is complex** → Use Progressive Thinking for breakdown

**IF need library docs** → Use Context7 for current library documentation and examples

**IF creating scripts/hooks/code** → ALWAYS use Context7 first for best practices and examples

**IF integrating with libraries** → Use Context7 to get current API documentation and usage patterns

**IF need current info** → Use WebSearch with year 2025, then WebFetch for detailed content

**IF using Task tool** → Use [Task Prompt Structure](operations/TASK-PROMPT-STRUCTURE.md) for consistent agent instructions

**AGENT CREATION REALITY CHECK:**

**IF thinking custom agents exist** → STOP. Only these agents are available: general-purpose, statusline-setup, output-style-setup, dashboard-management-specialist, api-design-specialist, code-quality-specialist, claude-hooks-developer, performance-optimization-specialist, testing-strategy-specialist, claude-hooks-integrator, claude-hooks-tester, agent-template-architect, system-enhancement-specialist, system-maintenance-validator

**IF need medical/specialized verification** → Use general-purpose agent with specific medical verification instructions, NOT non-existent specialized agents

**IF need custom agent functionality** → Custom agents don't exist in Claude Code system. Use general-purpose with detailed task-specific prompts instead.

**IF agent-template-architect suggests new agents** → Templates created ≠ agents deployed. Ignore template references, use existing agents only.

**IF improvising** → Stop. Check my documentation first

**IF making changes** → Follow [TDD/BDD Unified Workflow](system/processes/tdd-bdd-unified-workflow.md) with mandatory validation

**IF doing ANY action** → Must follow [Validation and Demonstration Workflow](system/processes/validation-and-demonstration-workflow.md) with evidence

**IF writing tests** → Use Red-Green-Refactor cycle from [TDD Workflow](system/processes/test-driven-development-workflow.md)

**IF defining behavior** → Use Given-When-Then scenarios from [BDD Workflow](system/processes/behavior-driven-development-workflow.md)

**IF using TodoWrite** → Break ALL tasks into atomic tasks (indivisible, actionable, completable, specific)

**IF user requests new behavior** → Document the behavior in CLAUDE.md immediately for future sessions

**IF debugging fails** → Use TDD: test ACTUAL execution environment, not assumptions

**IF testing hooks/scripts** → Must test with exact same input/environment as production (e.g., `stdin=subprocess.DEVNULL`)

**IF agents claim to fix but problem persists** → Write failing test first, then validate fix works in real environment

**IF debugging ANY production system** → Never trust "it should work" - always test with production conditions exactly

**IF making ANY claim** → Must provide evidence - no assumptions, no hallucinations, only verifiable facts

**IF stating something works** → Must demonstrate with actual test results, not theoretical reasoning

**IF claiming to know something** → Must verify with WebSearch/WebFetch, scripts, or tests - always doubt your knowledge

**IF providing metrics or facts** → Must use real measurements, not estimates or assumptions

**IF uncertain about ANYTHING** → Use scripts, external validation, or research tools to confirm

**IF coding/implementing** → Always use Context7 first for best practices and current examples

**IF setting up hooks** → Read [hooks/README.md](hooks/README.md) for configuration and testing

**IF validating system behavior** → Use Task agents for independent verification

**IF checking file states** → Use Read/Grep/LS tools for actual file contents, not assumptions

**IF testing integrations** → Create isolated test environments that mirror production exactly

**IF task matches agent expertise** → Deploy specialized agent instead of attempting alone

**IF complex multi-step work** → Use multiple agents concurrently for better results

**IF need independent verification** → Deploy second agent to validate first agent's work

**IF no specialized agent exists for the task** → CRITICAL: agent-template-architect creates templates only, NOT deployable agents. Templates must be manually converted to actual Claude Code agents.

**IF need custom agents** → Templates ≠ Deployable agents. Templates are documentation; agents require system registration.

**IF agent-template-architect creates templates** → Templates are insufficient - must create actual deployable agents via Claude Code agent system

**IF specialized agents needed immediately** → Use general-purpose agent with detailed instructions instead of non-existent custom agents

**IF multiple tasks can run simultaneously** → Always deploy agents in parallel for maximum efficiency (MAX 10 per message)

**IF doing parallel work** → Use multiple Task tool calls in ONE SINGLE message, not sequential messages

**IF user gives important reminders** → Use TodoWrite immediately to track and not forget

**IF starting any significant work** → First deploy agents, then coordinate results rather than doing work directly

**IF user corrects you** → Document the correction immediately in CLAUDE.md to prevent repeat errors

**IF discovering new patterns** → Document in appropriate system files for future reference

**IF completing successful workflows** → Document the process for replication

**IF claiming agents exist** → VERIFY with Task tool error messages - only predefined agents are available

**IF agent creation fails** → Templates exist but agents don't - use general-purpose with specific instructions

**IF need verification workflow** → Use existing agents with detailed Task prompts instead of non-existent specialized agents

## Session Commands

**IF session starts** → Show current status, recent work, suggest next steps

**IF continuing work** → Reference specific files and line numbers

**IF session ends** → Read [system/processes/session-conclusion-workflow.md](system/processes/session-conclusion-workflow.md)

**IF using TodoWrite first time** → Add these foundation tasks:

1. Use Progressive Thinking for systematic breakdown
2. Read CLAUDE.md thoroughly
3. Use TodoWrite for multi-step tasks
4. Follow Git Workflow for changes
5. Document workflow discoveries in CLAUDE.md
6. Update CLAUDE.md when finding new patterns

## Workflow Commands

**IF coordinating agents** → Read [system/processes/strategic-orchestration-workflow.md#strategic-orchestrator-role](system/processes/strategic-orchestration-workflow.md#strategic-orchestrator-role)

**IF creating agents** → Read [system/processes/agent-creation-workflow.md#agent-creation-process](system/processes/agent-creation-workflow.md#agent-creation-process)

**IF ending session** → Read [system/processes/session-conclusion-workflow.md#step-by-step-process](system/processes/session-conclusion-workflow.md#step-by-step-process)

**IF doing development** → Read [system/processes/development-workflow.md#development-process](system/processes/development-workflow.md#development-process)

**IF maintaining framework** → Read [system/processes/framework-evaluation-workflow.md#framework-evaluation-process](system/processes/framework-evaluation-workflow.md#framework-evaluation-process)

**IF need work principles** → Read [system/PRINCIPLES.md](system/PRINCIPLES.md)

**IF need process management** → Read [system/PROCESSES.md](system/PROCESSES.md)

**IF need technical standards** → Read [system/STANDARDS.md](system/STANDARDS.md)

## User Preference Commands

**IF making changes** → Always commit + push automatically

**IF evidence requested** → Show git diff or file changes

**IF year needed in search** → Always use 2025

**IF research needed** → WebSearch first, then WebFetch for details

**IF hooks workflow needed** → Read [hooks/README.md](hooks/README.md)

**IF Context7 needed** → Use Context7 tool for current library documentation and examples

## Quality Commands

**IF asked to do something** → Complete it fully

**IF working with files** → Keep them organized

**IF building something** → Test that it works with [TDD/BDD validation](system/processes/tdd-bdd-unified-workflow.md)

**IF delivering results** → Provide evidence with [Validation and Demonstration](system/processes/validation-and-demonstration-workflow.md)

**IF completing ANY task** → Must demonstrate with passing tests, BDD scenarios, and evidence documentation

**IF system needs updates** → Keep it current

---

**Execute simply. Deliver easily.**
