[🏠 System Hub](../INDEX.md) | [📁 Parent Directory](./) | [📖 Current Section](#)

---

# File Organization Standards

**Context**: Quality standard ensuring consistency and compliance requirements


**[System](../INDEX.md) › [Standards](../STANDARDS.md) › File Organization Standards**

Complete structural organization standards for the .claude directory framework.

## Core Organization Principles

### 1. Purpose-Based Grouping
- Group files by **function and purpose**, not by type
- Co-locate related functionality 
- Avoid artificial separation (e.g., separating all .md files from .py files)

### 2. Logical Hierarchy
- Maximum 3 levels deep for most content
- Use flat structures when hierarchy adds no value
- Place frequently accessed files closer to root

### 3. Predictable Placement
- Users should intuitively know where to find things
- Consistent placement patterns across similar directories
- Standard entry points (INDEX.md, README.md) at appropriate levels

## Directory Structure Standards

### Top-Level Directories

```
.claude/
├── CLAUDE.md                 # Main framework entry point
├── system/                   # Core framework components
├── agents/                   # Deployed agent instances
├── commands/                 # Executable command definitions
├── scripts/                  # Automation and utilities
├── operations/               # Timestamped work sessions
├── dashboard/                # Monitoring and metrics
├── projects/                 # Project-specific contexts
├── plugins/                  # External integrations
├── logs/                     # System logs and audit trails
├── todos/                    # Task management
└── shell-snapshots/          # Session state preservation
```

### System Directory Structure

```
system/
├── INDEX.md                  # Main navigation hub
├── README.md                 # System overview
├── PRINCIPLES.md             # Core principles index
├── BEHAVIORS.md              # Behaviors index  
├── STANDARDS.md              # Standards index
├── PROCESSES.md              # Processes index
├── EXAMPLES.md               # Examples index
├── CHECKS.md                 # Quality checks index
├── TOOLS.md                  # System tools index
├── principles/               # Individual principle files
├── behaviors/                # Individual behavior files
├── standards/                # Individual standard files
├── processes/                # Individual process files
├── examples/                 # Real demonstration files
├── checks/                   # Quality validation files
├── tools/                    # System utility files
└── templates/                # Reusable component files
```

## File Naming Conventions

### Directory Names
- **Lowercase with hyphens**: `file-organization-standards/`
- **Descriptive purpose**: `test-driven-development/` not `tdd/`
- **Plural for collections**: `principles/`, `standards/`, `examples/`
- **Singular for single purpose**: `dashboard/`, `system/`

### File Names

#### Standard Files
- **Lowercase with hyphens**: `file-organization-standards.md`
- **Descriptive and complete**: `test-driven-development-workflow.md`
- **Purpose-based**: `parallel-execution-workflow.md` not `parallel.md`

#### Index Files
- **Uppercase INDEX.md**: Primary navigation files
- **Lowercase readme.md**: Directory explanation files
- **INDEX.md precedence**: Use INDEX.md over README.md for navigation

#### Special Patterns
- **Timestamped operations**: `20250819-123456-task-description/`
- **Project contexts**: `-Users-nalve-project-path/` (auto-generated)
- **Agent instances**: `agent-name-instance/`

## Content Placement Rules

### System Framework Content
```
system/
├── {category}/               # Individual items by category
│   ├── item-name.md         # Specific implementation
│   └── another-item.md      # Another implementation
└── {CATEGORY}.md            # Category index and navigation
```

### Operations and Work
```
operations/
├── timestamp-task-name/     # Timestamped work sessions
│   ├── work-results.md     # Session outcomes
│   ├── analysis.json       # Structured data
│   └── artifacts/          # Generated files
└── archive/                # Completed operations
```

### Scripts and Automation
```
scripts/
├── category/               # Grouped by function
│   ├── README.md          # Category overview
│   ├── script-name.py     # Executable scripts
│   └── config.yaml        # Configuration files
└── lib/                   # Shared utilities
```

### Agents and Commands
```
agents/
├── domain-expert/          # Specialized agent types
│   ├── definition.md      # Agent specification
│   ├── deployment.md      # Usage instructions
│   └── examples/          # Usage examples
└── core-system/           # System-level agents

commands/
├── category/              # Command groupings
│   ├── command-name.md   # Individual commands
│   └── README.md         # Category overview
└── INDEX.md              # Complete command reference
```

## Maintenance Automation

### Validation Scripts

#### Directory Structure Validator
```bash
#!/bin/bash
# scripts/validation/directory-structure-check.sh

# Check required top-level directories exist
required_dirs=("system" "agents" "commands" "scripts" "operations")
for dir in "${required_dirs[@]}"; do
    [[ -d "/Users/nalve/.claude/$dir" ]] || echo "Missing: $dir"
done

# Validate system structure
system_dirs=("principles" "behaviors" "standards" "processes" "examples" "checks" "tools" "templates")
for dir in "${system_dirs[@]}"; do
    [[ -d "/Users/nalve/.claude/system/$dir" ]] || echo "Missing system/$dir"
done

# Check for INDEX.md files
[[ -f "/Users/nalve/.claude/system/INDEX.md" ]] || echo "Missing system/INDEX.md"
```

#### File Naming Validator
```bash
#!/bin/bash
# scripts/validation/naming-check.sh

# Check for uppercase files in system (except INDEX files)
find /Users/nalve/.claude/system -name "*.md" -not -name "INDEX.md" -not -name "*INDEX*" | \
while read file; do
    basename=$(basename "$file")
    if [[ "$basename" =~ [A-Z] ]]; then
        echo "Naming violation: $file (should be lowercase-with-hyphens)"
    fi
done

# Check for spaces in filenames
find /Users/nalve/.claude -name "* *" -not -path "*/projects/*" | \
while read file; do
    echo "Space in filename: $file (should use hyphens)"
done
```

#### Organization Audit
```bash
#!/bin/bash
# scripts/validation/organization-audit.sh

# Check for deep nesting (>3 levels)
find /Users/nalve/.claude -type d -not -path "*/projects/*" -not -path "*/.git/*" | \
while read dir; do
    depth=$(echo "$dir" | tr '/' '\n' | wc -l)
    if [[ $depth -gt 6 ]]; then  # .claude = 3, so 6 = 3 levels deep
        echo "Too deep: $dir (max 3 levels recommended)"
    fi
done

# Check for orphaned files (no parent INDEX or README)
find /Users/nalve/.claude -name "*.md" -not -path "*/projects/*" | \
while read file; do
    dir=$(dirname "$file")
    if [[ ! -f "$dir/INDEX.md" && ! -f "$dir/README.md" && ! -f "$dir/../INDEX.md" ]]; then
        echo "Orphaned file: $file (no navigation parent)"
    fi
done
```

### Enforcement Mechanisms

#### Pre-commit Hook
```bash
#!/bin/bash
# .git/hooks/pre-commit

# Run organization validation
./scripts/validation/directory-structure-check.sh
./scripts/validation/naming-check.sh
./scripts/validation/organization-audit.sh

# Exit with error if violations found
if [[ $? -ne 0 ]]; then
    echo "Organization standards violations found. Fix before committing."
    exit 1
fi
```

#### Automated Cleanup
```bash
#!/bin/bash
# scripts/maintenance/organization-cleanup.sh

# Move misplaced files to correct locations
# Archive old operations
# Clean up empty directories
# Update broken navigation links
```

## Quality Metrics

### Organization Health Indicators
- **Navigation Completeness**: Every directory has INDEX.md or README.md
- **Naming Compliance**: All files follow naming conventions
- **Depth Compliance**: No unnecessary deep nesting
- **Purpose Alignment**: Files in appropriate category directories
- **Link Integrity**: All internal links resolve correctly

### Automated Reporting
```bash
#!/bin/bash
# scripts/monitoring/organization-report.sh

echo "=== Organization Health Report ==="
echo "Navigation files: $(find /Users/nalve/.claude -name "INDEX.md" -o -name "README.md" | wc -l)"
echo "Naming violations: $(./scripts/validation/naming-check.sh | wc -l)"
echo "Deep nesting issues: $(./scripts/validation/organization-audit.sh | grep "Too deep" | wc -l)"
echo "Orphaned files: $(./scripts/validation/organization-audit.sh | grep "Orphaned" | wc -l)"
```

## Migration Guidelines

### Restructuring Process
1. **Analyze current placement** against standards
2. **Create target structure** following standards
3. **Migrate files systematically** with link updates
4. **Validate organization** using automated checks
5. **Update navigation** to reflect new structure

### Backward Compatibility
- Maintain redirects during transition periods
- Update all internal links systematically
- Document changes in migration logs
- Provide clear migration paths for existing content

---
**Navigation:** [← Back to Standards](../STANDARDS.md) | [↑ System Home](../INDEX.md)
