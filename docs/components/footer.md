---
title: Footer Navigation Component
component_type: navigation
version: 1.0.0
dependencies: []
usage: universal
purpose: Provide consistent footer navigation across all documents
---

[Previous: Execute navigation-usage.md for guidance](navigation-usage.md) | [Return to Documentation Hub for navigation](../index.md) | [Master PRINCIPLES.md for framework](../PRINCIPLES.md) | [Next: Deploy README.md for architecture](README.md)

# Footer Navigation Component

## Standard Footer
```markdown
[⬆ Return to top](#{{title}})
```

## Documentation Hub Footer
```markdown
[⬆ Return to top](#{{title}})
[Return to Documentation Hub]({{hub_path}})
```

## Usage Variables
- `{{title}}` - Document title anchor (lowercase, hyphenated)
- `{{hub_path}}` - Relative path to docs/index.md

## Examples

### For docs/principles/workflow.md
```markdown
[⬆ Return to top](#workflow)
[Return to Documentation Hub](../index.md)
```

### For commands/analyze-file.md
```markdown
[⬆ Return to top](#analyze-file-command)
[Return to Documentation Hub](../docs/index.md)
```

### For agents/project-optimizer.md
```markdown
[⬆ Return to top](#project-optimizer-agent)
[Return to Documentation Hub](../docs/index.md)
```