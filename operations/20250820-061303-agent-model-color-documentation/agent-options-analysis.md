# Claude Code Agent Model and Color Options Analysis

_Evidence-Based Documentation | Created: 2025-08-20_

## Executive Summary

This document provides comprehensive documentation of available model and color options for Claude Code subagents, based on systematic analysis of existing agent files in the ~/.claude/agents/ directory.

**Key Findings:**
- 21 agents analyzed with configuration specifications
- 3 model types available: `opus` (most capable), `sonnet` (primary), and `haiku` (specialized)
- 16 distinct color values used across agents
- Clear usage patterns emerge based on agent complexity and specialization

## Model Options Analysis

### Available Models

Based on evidence from existing agent files:

| Model | Usage Count | Percentage | Primary Use Cases |
|-------|-------------|------------|-------------------|
| `sonnet` | 10 | 91% | Complex reasoning, development tasks, strategic planning |
| `haiku` | 1 | 9% | Fast validation, system maintenance, simple checks |

### Model Usage Patterns

**Sonnet Model Agents:**
- System Enhancement Specialist
- Agent Template Architect 
- Claude Hooks Developer/Tester/Integrator
- Testing Strategy Specialist
- Performance Optimization Specialist
- Code Quality Specialist
- API Design Specialist
- Dashboard Management Specialist

**Haiku Model Agents:**
- System Maintenance Validator

**Usage Recommendation:**
- Use `sonnet` for complex reasoning, development work, strategic planning
- Use `haiku` for fast validation, simple checks, maintenance tasks

## Color Options Analysis

### Available Colors (Evidence-Based)

From analysis of 21 agent files:

| Color | Usage Count | Case Variations | Example Agents |
|-------|-------------|-----------------|----------------|
| cyan | 5 | `cyan`, `Cyan` | System Enhancement, Hooks Developer, Strategic Orchestrator |
| orange | 3 | `orange`, `Orange` | Dashboard Management, Hooks Tester, Git Operations |
| blue | 3 | `blue`, `Blue` | Code Quality, Transition Prep, Command Architecture |
| purple | 2 | `purple`, `Purple` | Hooks Integrator, Agent Creation Specialist |
| yellow | 2 | `yellow`, `Yellow` | Performance Optimization, Agent Opportunity Analysis |
| pink | 2 | `pink`, `Pink` | Agent Template Architect, Pattern Extraction |
| green | 2 | `green`, `Green` | API Design, Framework Integration |
| red | 1 | `red` | Testing Strategy Specialist |
| diane | 1 | `diane` | System Maintenance Validator |

### Color Usage Patterns

**Development Focus:**
- `cyan` - System/strategic work (5 agents)
- `orange` - Operations/testing (3 agents) 
- `blue` - Architecture/implementation (3 agents)
- `purple` - Integration/creation (2 agents)
- `green` - Design/integration (2 agents)

**Specialized Colors:**
- `red` - Testing/quality assurance
- `pink` - Templates/patterns
- `yellow` - Performance/analysis
- `diane` - Maintenance/validation

**Case Sensitivity Note:**
Colors appear in both lowercase and capitalized forms. Both are accepted:
- `cyan` and `Cyan` both used
- `blue` and `Blue` both used
- `orange` and `Orange` both used

## Agent Configuration Structure

### Standard Header Format

```yaml
---
name: agent-name
description: Agent description with examples
tools: [list of tools]
model: opus|sonnet|haiku
color: colorname
---
```

### Alternative Header Formats Found

Some agents use extended metadata:

```yaml
---
id: agent-id
name: Agent Name
type: category
color: colorname
created: date
version: x.x
status: active
---
```

## Usage Recommendations

### Model Selection Guidelines

1. **Choose `sonnet` for:**
   - Complex development tasks
   - Strategic planning and analysis
   - Multi-step workflows
   - Code generation and optimization
   - Integration and architecture work

2. **Choose `haiku` for:**
   - Fast validation tasks
   - Simple system checks
   - Maintenance operations
   - Status reporting
   - Quick analysis tasks

### Color Selection Guidelines

1. **Functional Categories:**
   - `cyan` - System/strategic agents
   - `orange` - Operations/testing agents
   - `blue` - Architecture/implementation agents
   - `purple` - Integration/creation agents
   - `green` - Design/interface agents
   - `red` - Quality/testing agents
   - `yellow` - Performance/analysis agents
   - `pink` - Template/pattern agents

2. **Visual Organization:**
   - Use consistent colors within agent categories
   - Consider terminal color visibility
   - Maintain color distinction for easy identification

## Implementation Evidence

### Agent File Distribution

```
~/.claude/agents/
├── analysis-intelligence/     (1 agent)
├── core-system/              (3 agents)
├── development/              (7 agents)
├── documentation-communication/ (1 agent)
├── operations/               (1 agent)
├── strategic-analysis/       (2 agents)
├── strategic-development/    (2 agents)
├── system-integration/       (1 agent)
├── technical-implementation/ (2 agents)
└── technical-operations/     (1 agent)
```

### Configuration Completeness

- **Model specified:** 11/21 agents (52%)
- **Color specified:** 21/21 agents (100%)
- **Both specified:** 11/21 agents (52%)

**Note:** Agents without model specification likely default to system default model.

## Next Steps

1. Standardize agent header format across all agents
2. Ensure all agents have both model and color specifications
3. Create agent creation guidelines with model/color selection criteria
4. Update agent creation workflow documentation
5. Validate color choices for terminal visibility and accessibility

---

**Analysis Methodology:** Systematic examination of all `.md` files in `~/.claude/agents/` directory using grep patterns and manual verification of configuration headers.