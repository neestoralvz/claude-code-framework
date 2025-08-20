
---

**IF reading individually** → READ [STANDARDS.md](../STANDARDS.md#technical-standards) for context, THEN navigate to this specific standard


# Tool Integration Patterns

**Context**: Quality standard ensuring consistency and compliance requirements


Consistent approaches for integrating and using tools effectively.

## Tool Selection

Choose tools that solve specific problems well rather than trying to use general purpose tools for everything. Prioritize tools with good documentation, active maintenance, and clear integration patterns.

## Integration Architecture

Integrate tools through well defined interfaces rather than tight coupling. Use configuration patterns that allow tools to be swapped or upgraded without changing core logic.

## Usage Consistency

Establish consistent patterns for how tools are invoked, configured, and monitored across your system. Use the same approaches for error handling, logging, and result processing with all tools.

## Documentation Standards

Document which tools are used for which purposes, how to configure them, and what their expected outputs are. Include troubleshooting information for common tool issues.

## Dependency Management

Track tool dependencies and versions explicitly. Use dependency management systems that allow for reproducible environments and easy updates.

## Fallback Strategies

Define fallback strategies for when tools are unavailable or fail. This might include alternative tools, manual processes, or graceful degradation of functionality.

---
