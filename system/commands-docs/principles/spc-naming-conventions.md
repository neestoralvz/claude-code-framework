
[🏠 Framework Hub](../../index.md) | [📋 Commands Index](../navigation/index.md) | [🎯 Command Template](../templates/command-template.md)

# NAMING CONVENTIONS FOR COMMANDS

## 🎯 COMMAND NAMING STANDARDS

### Primary Naming Pattern
**Format**: `{action}-{domain/target}-{specification}`

**Examples**:
- `create-agent` - Create a new agent
- `analyze-dependencies` - Analyze system dependencies
- `validate-structure` - Validate system structure
- `optimize-performance` - Optimize system performance

### Action Verbs (Primary Classification)
**Core Actions**:
- `create` - Generate new elements (agents, commands, components)
- `analyze` - Examine and evaluate existing systems
- `validate` - Verify compliance and correctness
- `optimize` - Improve performance and efficiency
- `manage` - Coordinate and maintain systems
- `execute` - Run processes and workflows
- `monitor` - Observe and track system state
- `configure` - Set up and adjust system parameters

**Secondary Actions**:
- `audit` - Comprehensive system examination
- `deploy` - Implementation and rollout
- `migrate` - Transform and move systems
- `enhance` - Improve existing functionality
- `debug` - Troubleshoot and resolve issues
- `maintain` - Ongoing system care
- `integrate` - Connect systems and components
- `orchestrate` - Coordinate complex workflows

### Domain/Target Classification
**System Components**:
- `agent` - AI agent management
- `command` - Command system operations
- `workflow` - Process and flow management
- `structure` - Organizational and architectural elements
- `dependencies` - System relationship management
- `performance` - Speed and efficiency optimization
- `quality` - Standards and validation
- `documentation` - Knowledge management

**Operational Areas**:
- `system` - Whole system operations
- `framework` - Framework-level operations
- `integration` - Cross-system coordination
- `deployment` - Implementation processes
- `monitoring` - Observation and tracking
- `maintenance` - Ongoing care operations

### Specification Modifiers
**Scope Modifiers**:
- `complete` - Full comprehensive operation
- `parallel` - Multi-threaded execution
- `automated` - Self-executing processes
- `interactive` - User-guided operations
- `batch` - Multiple item processing
- `recursive` - Self-repeating operations

**Quality Modifiers**:
- `enhanced` - Improved or advanced version
- `comprehensive` - Complete coverage
- `intelligent` - AI-driven decision making
- `systematic` - Methodical approach
- `strategic` - High-level planning focus

## 🔄 COMMAND CATEGORIZATION SYSTEM

### Functional Categories
**Management Commands**:
- Pattern: `manage-{target}`
- Examples: `manage-systems`, `manage-tickets`, `manage-workflow`

**Analysis Commands**:
- Pattern: `analyze-{subject}`
- Examples: `analyze-dependencies`, `analyze-performance`, `analyze-structure`

**Creation Commands**:
- Pattern: `create-{output}`
- Examples: `create-agent`, `create-command`, `create-workflow`

**Execution Commands**:
- Pattern: `execute-{process}`
- Examples: `execute-ticket`, `execute-parallel-plan`, `execute-workflow`

**Validation Commands**:
- Pattern: `validate-{target}`
- Examples: `validate-structure`, `validate-compliance`, `validate-quality`

### Complexity Indicators
**Simple Commands**: Single action, single target
- Example: `create-agent`

**Compound Commands**: Multiple actions or complex targets
- Example: `analyze-optimize-performance`

**System Commands**: Framework-wide operations
- Example: `manage-complete-system`

## 🎯 FILE NAMING CONVENTIONS

### File Structure Pattern
**Format**: `{command-name}.md`
- All lowercase
- Hyphens for word separation
- `.md` extension for markdown files

**Examples**:
```
create-agent.md
analyze-dependencies.md
validate-system-structure.md
execute-parallel-workflow.md
```

### Directory Organization
**Location Pattern**: `commands/{category}/{command-name}.md`

**Category Directories**:
- `management/` - System and workflow management commands
- `analysis/` - Examination and evaluation commands
- `creation/` - Generation and building commands
- `execution/` - Process running and implementation commands
- `validation/` - Verification and compliance commands
- `orchestration/` - Multi-system coordination commands

## 🔧 METADATA NAMING STANDARDS

### Frontmatter Requirements
```yaml
title: "Command Name in Title Case"
command_type: "{category}"
complexity: "{simple|moderate|complex}"
execution_time: "{estimated-duration}"
dependencies: ["list-of-dependencies"]
output_format: "{format-description}"
```

### Cross-Reference Naming
**Link Format**: `[Command Description](path/to/command.md)`
- Descriptive link text
- Relative path from current location
- Consistent path structure

## 🎯 NAMING VALIDATION CRITERIA

### Required Elements
1. **Clear Action Verb** - Unambiguous operation description
2. **Specific Target** - Clear scope and domain
3. **Consistent Pattern** - Follows established conventions
4. **Unique Identity** - No naming conflicts
5. **Searchable Terms** - Easy to find and identify

### Prohibited Patterns
- **Generic Names**: `command`, `process`, `system` (without specifics)
- **Ambiguous Terms**: `handle`, `process`, `do` (unclear actions)
- **Redundant Prefixes**: `command-create` (command prefix unnecessary)
- **Special Characters**: Avoid underscores, spaces, special symbols
- **Version Numbers**: In filename (use metadata instead)

### Quality Standards
- **Imperative Tone**: Commands express actions to take
- **Clarity Priority**: Choose clarity over brevity
- **Domain Consistency**: Related commands use consistent terminology
- **Future-Proof**: Names remain valid as system evolves
- **User-Friendly**: Intuitive for human understanding

## 🔄 EVOLUTIONARY NAMING GUIDELINES

### Version Management
- Use metadata for version tracking
- Maintain naming consistency across versions
- Deprecate through metadata, not filename changes

### Naming Evolution
- Document naming decision rationale
- Maintain backward compatibility references
- Update cross-references when names change
- Archive old naming patterns with migration guidance

### Integration Requirements
- **Command Index Compatibility** - Names work in navigation systems
- **Search Optimization** - Terms align with common search patterns
- **Cross-Reference Stability** - Names support link maintenance
- **Template Integration** - Compatible with generation templates

