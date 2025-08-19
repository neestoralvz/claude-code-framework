
# AGENT ORCHESTRATION DOMAIN

## 🎯 Domain Purpose
Defines agent deployment, coordination, and task orchestration patterns for framework scalability.

## 📋 Files in This Domain (Dependency Order)
1. **[context-efficiency.md](context-efficiency.md)** - Level 1: Context preservation foundation
2. **[agent-selection.md](agent-selection.md)** - Level 2: Agent deployment methodology  
3. **[agent-definition.md](agent-definition.md)** - Level 2: Agent architecture boundaries
4. **[task-orchestration.md](task-orchestration.md)** - Level 2: Task coordination patterns
5. **[task-tool-syntax.md](task-tool-syntax.md)** - Level 3: Implementation framework
6. **[expert-documentation.md](expert-documentation.md)** - Level 3: Authorship standards

## 🔄 Key Dependencies
- **External**: [../core-authority/workflow.md](../core-authority/workflow.md), [engineering.md](../quality-assurance/engineering.md)
- **Internal**: context-efficiency → agent-selection → {agent-definition, task-orchestration} → task-tool-syntax

## 🚀 Common Usage Patterns
- **Agent Deployment**: context-efficiency.md → agent-selection.md → agent-definition.md
- **Task Coordination**: context-efficiency.md → agent-selection.md → task-orchestration.md → task-tool-syntax.md
- **Documentation Standards**: expert-documentation.md for authorship requirements

[← Back to Principles Hub](../README.md) | **Authority**: [⚡ Core](../core-authority/) | **Related**: [📝 Content](../content-management/)