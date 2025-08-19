# Command Metadata Standards

Metadata standards for command documentation files.

## Base Fields
```yaml
---
title: "{{COMMAND_NAME}} Command"
author: "System"
date: "{{DATE}}"
version: "1.0.0"
keywords: [{{COMMAND_KEYWORDS}}]
last_review: "{{DATE}}"

# Command-specific fields
dependencies: ["../COMMANDS.md", "../principles/workflow.md", "{{RELATED_DEPENDENCIES}}"]
audience: "system operators"
purpose: "{{COMMAND_PURPOSE}}"

# Additional command fields
category: "command"
command: "/{{COMMAND_SLUG}}"
parameters: [{{COMMAND_PARAMETERS}}]
returns: "{{COMMAND_RETURNS}}"
examples: [{{COMMAND_EXAMPLES}}]
---
```

## Common Command Keywords
- analyze, file, redundancy, optimization, minimalism
- modularize, refactor, extract, patterns, reusability
- optimize, performance, efficiency, improvement
- update, documentation, sync, maintain, consistency
- validate, check, verify, compliance, standards

## Command Structure Requirements
Commands in `/commands/` directory must:
1. Define executable `/command` syntax
2. Follow workflow-phases.md methodology
3. Include success criteria and validation
4. Reference appropriate principles