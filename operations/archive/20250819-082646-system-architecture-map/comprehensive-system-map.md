# Comprehensive System Architecture Map
Generated: Tue Aug 19 08:27:03 CST 2025

## Executive Summary
Complete mapping of templates, logic, creation processes, and agents across the Claude Code Framework.

## System Statistics
- **Total Agents**:      147
- **Analysis-Only Compliant**:      109/     147 (74.1%)
- **Template Files**:      742
- **Creation Process Files**:     1464
- **Total Markdown Files**:     1870

## Key Architecture Components

### 1. Agent Architecture
- **Location**: `agents/` directory
- **Organization**: Category-based subdirectories
- **Compliance**: Analysis-only specialist pattern
- **Tool Restriction**: No Task tools (orchestrator-only)

### 2. Template System
- **Agent Templates**: `docs/agents-docs/agent-template.md`
- **Component Templates**: `docs/templates/components/`
- **Success Criteria**: `docs/templates/components/success-criteria-template.md`
- **Coordination Strategies**: `docs/templates/components/agent-coordination-strategies.md`

### 3. Creation Processes
- **Agent Creation**: `agents/development/architecture/agent-creator.md`
- **Pattern Generation**: `agents/specialization/pattern-generation-framework.md`
- **Component Extraction**: `agents/development/workflow/component-extraction-specialist.md`
- **Architecture Design**: `agents/development/architecture/`

### 4. Core Framework Logic
- **Main Interface**: `CLAUDE.md` (orchestrator playbook)
- **Command System**: `commands/` directory
- **Workflow Logic**: `docs/principles/workflow.md`
- **Task Tool Syntax**: `docs/principles/task-tool-syntax.md`

### 5. System Orchestration
- **Orchestrator**: Uses Task tools for agent deployment
- **Agent Deployment**: Via Task(subagent_type, description, prompt)
- **Analysis Delivery**: Agents provide recommendations to orchestrator
- **Execution Boundary**: Only orchestrator executes, agents analyze

## Directory Structure Overview
```
.
./.claude
./agents
./agents/ai-ml
./agents/analytics
./agents/backend
./agents/blockchain
./agents/business-analytics
./agents/content
./agents/core-system
./agents/database
./agents/design
./agents/development
./agents/frontend
./agents/infrastructure
./agents/iot
./agents/operations
./agents/planning
./agents/project-management
./agents/research
./agents/security-advanced
./agents/specialization
./agents/strategy
./agents/testing
./agents/user-experience
./automation
./automation/duplication-prevention
./automation/reference-inclusion
./automation/registry-management
./automation/validation
./commands
./commands/compositions
./commands/domains
./commands/foundation
./components
./components/agents
./dashboard
./dashboard/config
./dashboard/data
./dashboard/logs
./dashboard/middleware
./dashboard/monitoring
./dashboard/nginx
./dashboard/node_modules
./dashboard/routes
./dashboard/scripts
./dashboard/services
./docs
./docs/agents-docs
./docs/architecture
./docs/commands-docs
./docs/components
./docs/principles
./docs/templates
./logs
./logs/crypto
./logs/password
./logs/registry
./logs/systems
./planning
./planning/components
./planning/templates
./planning/tickets
./playbook
./playbook/command-guides
./playbook/decision-trees
./playbook/procedures
./playbook/quick-reference
./projects
./projects/-Users-nalve--claude
./projects/-Users-nalve-Projects-work
./projects/-Users-nalve-Projects-work-active-systems-hospitality-operations
./projects/-Users-nalve-Projects-work-active-systems-hospitality-operations-ampare-casa-colonial
./projects/-Users-nalve-Projects-work-business-domains-03-operational-delivery-active-systems-hospitality-operations-ampare-casa-colonial
./scripts
./scripts/agents
./scripts/backups
./scripts/config
./scripts/core
./scripts/crash-prevention
./scripts/documentation
./scripts/hooks
./scripts/lib
./scripts/libs
./scripts/maintenance
./scripts/registries
./scripts/security
./scripts/utilities
./scripts/validation
./scripts/vault
./shell-snapshots
./templates
./templates/yaml
./tickets
./tickets/completed
./tickets/pending
./todos
./todos/completed
./todos/in-progress
./todos/pending
```

## Agent Categories
- **0**: 147 agents

## Reports Generated
1. **Templates Map**: templates-map.md
2. **Logic Processes**: logic-processes-map.md
3. **Agents Directory**: agents-directory-map.md
4. **Architecture Overview**: system-architecture-overview.md
5. **Creation Specialists**: creation-specialists-map.md

## Framework Compliance Status
✅ **Agent Architecture**: Analysis-only specialists with no Task tools
✅ **Orchestrator Pattern**: Task tools reserved for orchestrator use
✅ **Template System**: Comprehensive template library available
✅ **Creation Processes**: Specialized agents for systematic creation
✅ **Documentation**: Complete framework documentation and guidance

