# File Organization Workflow

_Last updated: 2025-08-20 | Version: 1.0_

## Overview

This workflow provides a systematic approach to organizing files in the Claude Framework while respecting immovable constraints. It ensures a logical, hierarchical, and intuitive folder structure.

## Constraints Analysis

### Immovable Files/Folders (Cannot be moved)
These files and folders are fixed and define our organizational foundation:

```
/Users/nalve/.claude/
├── shell-snapshots/          # Shell state snapshots (system-managed)
├── statsig/                  # Statsig configuration and cache
├── todos/                    # Persistent todo lists (system-managed)
├── CLAUDE.local.md          # Local project customizations
├── CLAUDE.md                # Main framework instructions
├── PROJECT-STRUCTURE.md     # Organization guidelines
├── .gitignore              # Git ignore patterns
├── projects/               # Project-specific workspaces
├── logs/                   # System logs and debugging
├── ide/                    # IDE-specific configurations
├── commands/               # Custom command definitions
└── agents/                 # Specialized agent definitions
```

### Organizational Foundation
Build around these fixed elements to create a coherent structure.

## Organizational Workflow

### Step 1: Create Missing Directories

Create organized directories for movable files:

```bash
# Create script organization
mkdir -p scripts/testing
mkdir -p scripts/performance  
mkdir -p scripts/validation
mkdir -p scripts/utilities

# Create test organization
mkdir -p tests/unit
mkdir -p tests/integration
mkdir -p tests/performance

# Create documentation organization
mkdir -p documentation/reports
mkdir -p documentation/guides
```

### Step 2: Categorize and Move Files

**Performance Files → `scripts/performance/`**
- `performance-analysis.js`
- `performance-monitoring.js`
- `load-testing.js`
- `generate-performance-report.js`
- `run-performance-analysis.js`
- `execute-performance-test.js`
- `optimization-strategies.js`

**Test Files → `tests/unit/`**
- `sum.js`
- `sum.test.js`

**Execution Scripts → `scripts/testing/`**
- `run-tests.js`
- `direct-test-execution.js`

**Validation Scripts → `scripts/validation/`**
- `validate-implementation.js`
- `quick-validation.js`

**Documentation → `documentation/reports/`**
- `PERFORMANCE-ANALYSIS-REPORT.md`
- `TDD-DEMONSTRATION.md`

### Step 3: Verify Organization

After moving files, verify the structure:

```bash
# Check script organization
ls scripts/*/
# Should show: performance/, testing/, validation/, utilities/

# Check test organization  
ls tests/*/
# Should show: unit/, integration/, performance/

# Check documentation
ls documentation/*/
# Should show: reports/, guides/
```

## Final Logical Structure

```
.claude/
├── [IMMOVABLE - Core Configuration]
│   ├── CLAUDE.md                    # Main framework instructions
│   ├── CLAUDE.local.md             # Local customizations
│   ├── PROJECT-STRUCTURE.md        # Organization guide
│   ├── .gitignore                  # Git patterns
│   └── package.json                # Dependencies
│
├── [IMMOVABLE - System Directories]
│   ├── agents/                     # Agent definitions
│   ├── commands/                   # Custom commands
│   ├── ide/                        # IDE configurations
│   ├── logs/                       # System logs
│   ├── projects/                   # Project workspaces
│   ├── shell-snapshots/            # Shell snapshots
│   ├── statsig/                    # Statsig cache
│   └── todos/                      # Persistent todos
│
├── [ORGANIZED - Working Directories]
│   ├── scripts/                    # Organized scripts
│   │   ├── performance/           # Performance analysis
│   │   ├── testing/               # Test execution
│   │   ├── validation/            # Validation utilities
│   │   └── utilities/             # General utilities
│   │
│   ├── tests/                     # Organized test files
│   │   ├── unit/                  # Unit tests
│   │   ├── integration/           # Integration tests
│   │   └── performance/           # Performance tests
│   │
│   ├── documentation/             # Organized documentation
│   │   ├── reports/               # Generated reports
│   │   └── guides/                # User guides
│   │
│   └── [EXISTING - Keep as is]
│       ├── hooks/                 # Hook implementations
│       ├── integrations/          # External integrations
│       ├── metrics/               # Usage metrics
│       ├── operations/            # Work sessions
│       ├── plugins/               # Plugin configs
│       └── system/                # Framework system files
```

## Organization Principles

### Hierarchy
1. **Root Level**: Only essential configuration files
2. **System Level**: Immovable system-managed directories  
3. **Working Level**: Organized functional directories
4. **Content Level**: Files grouped by purpose

### Logic
- **scripts/**: Executable utilities organized by function
- **tests/**: All test files organized by test type
- **documentation/**: Generated and manual documentation
- **[immovable]/**: System-managed, leave untouched

### Simplicity
- Clear directory names indicate purpose
- No more than 3 levels deep in most cases
- Similar files grouped together
- Easy to find and understand

## Maintenance Rules

### When Creating New Files

1. **Identify Purpose**: What does this file do?
2. **Check Category**: Does it fit existing categories?
3. **Place Correctly**: Put in appropriate organized directory
4. **Update Documentation**: Add to this workflow if new category

### When Moving Existing Files

1. **Verify Dependencies**: Check for hardcoded paths
2. **Update References**: Fix any import statements
3. **Test Functionality**: Ensure nothing breaks
4. **Document Changes**: Update workflow if needed

### Regular Cleanup

1. **Monthly Review**: Check for misplaced files
2. **Categorize New**: Move any new files to correct locations
3. **Clean Obsolete**: Remove unused or duplicate files
4. **Update Structure**: Adjust organization as needed

## Integration Points

### With CLAUDE.md
- References to file paths must align with this structure
- Commands should point to organized locations
- Updates here trigger CLAUDE.md updates

### With Operations
- Work sessions create files in appropriate directories
- Temporary files go to operations/ then get organized
- Permanent utilities move to scripts/

### With Git
- Moves tracked in git history
- .gitignore patterns respect this structure
- Commits document reorganization rationale

## Automation Opportunities

### File Organization Script
Create `scripts/utilities/organize-files.sh` that:
- Scans root for misplaced files
- Categorizes by file patterns
- Moves to appropriate directories
- Reports changes made

### Validation Script  
Create `scripts/validation/check-organization.sh` that:
- Verifies structure compliance
- Reports misplaced files
- Suggests corrections
- Runs in CI/CD

## Success Metrics

### Immediate
- [ ] No executable files in root except package.json scripts
- [ ] All tests in tests/ directory
- [ ] All documentation in documentation/ directory
- [ ] All scripts organized by function

### Ongoing
- [ ] New files automatically placed correctly
- [ ] Team follows organization patterns
- [ ] Structure remains maintainable
- [ ] Easy to find and understand files

---

**Organize systematically. Maintain consistently. Find easily.**