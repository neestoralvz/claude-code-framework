
[⬆ Commands Index](../docs/index.md) | [🏗 Architecture](../../docs/commands-docs/system-audit-architecture.md)

# System Audit Command

Execute [WorkflowInstructions.md](../templates/WorkflowInstructions.md) with:

**Domain**: System analysis  
**Agents**: [exploration-analyst, system-auditor]  
**Templates**: [ValidationTemplate.md, CrossReferenceTemplate.md]  
**Assembly**: [SystemAnalysisAssembly.md](../commands/compositions/assemblies/SystemAnalysisAssembly.md)

## Syntax
```bash
/system-audit [scope] [output-format]
```

## Parameters
- `--scope [minimal|comprehensive]` - Analysis depth control
- `--output [summary|detailed|json]` - Result format specification
- `--priority [HIGH|MEDIUM|LOW]` - Importance classification
- `--category [type]` - Classification for organization

## Examples
```bash
/system-audit --comprehensive --output json
/system-audit --minimal --output summary  
/system-audit --priority HIGH
```

## Success Criteria
Reference: [Success Criteria Template](../docs/templates/components/success-criteria-template.md)

## Architecture Documentation
Detailed implementation patterns and architectural guidance: [System Audit Architecture](../../docs/commands-docs/system-audit-architecture.md)

[⬆ Return to top](#system-audit-command)
