
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Research and Document

**Context**: Workflow process defining procedural steps and execution patterns


Process for deploying specialized agents to find current information and preserve it in our system.

**MANDATORY**: All research and documentation must be performed through agent deployment. Never attempt direct research or documentation.

## When to Use Research
- Need current library documentation or examples
- Looking for updated best practices
- Want to find real-world implementation patterns
- Building on existing knowledge rather than reinventing

## Research Sources

**Deploy research-specialist** with access to:
- **Context7** - Current library documentation and code examples
- **WebSearch** - Updated Anthropic documentation and recent information
- **Our own system** - Examples and processes we've already documented

**Agent Instructions**: "Research [topic] using all available sources. Prioritize Context7 for library docs, WebSearch for current info, and internal system for existing patterns."

## Documentation Process

**Deploy documentation-specialist** to manage the documentation workflow:

**Agent Instructions**: "Document research findings for [topic]:
1. Deploy research-specialist to search for relevant information
2. Extract key insights and practical examples
3. Document findings in appropriate system location
4. Create examples showing real usage patterns
5. Update our processes based on new learning"

## Documentation Locations

**Deploy knowledge-curator** to organize documentation:

**Agent Instructions**: "Organize documentation for [topic] in appropriate locations:
- **Examples** - Real-world usage patterns and decisions
- **Standards** - Consistent approaches we should follow
- **Processes** - Step-by-step workflows
- **Tools** - Utilities and scripts for automation"

---

