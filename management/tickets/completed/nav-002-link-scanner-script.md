
[Previous: Link Audit](../../planning/tickets/completed/nav-001-comprehensive-link-audit.md) | [Navigate to Documentation Hub](../../docs/index.md) | [Framework: Claude Code] | [Next: Link Updater](../pending/nav-003-link-updater-script.md)

# AUTOMATED LINK SCANNER SCRIPT

⏺ **Principle**: Implement [automation.md](../../docs/principles/automation.md) systematic automation and apply [engineering.md](../../docs/principles/engineering.md) quality assurance through automated link validation.

## PROBLEM STATEMENT

Manual link validation is time-consuming and error-prone. Need automated script to continuously scan and identify broken internal links across all framework documentation, enabling proactive link maintenance.

### Target Capabilities
- **Comprehensive scanning** - All .md files in framework
- **Internal link validation** - Markdown link syntax parsing
- **Broken link detection** - File existence verification
- **Categorized reporting** - Link type classification
- **Performance optimization** - Fast execution for large codebases

## SUCCESS CRITERIA

### Primary Objectives
- [ ] Automated script scans all .md files recursively
- [ ] Extracts and validates all internal markdown links
- [ ] Identifies broken links with file context
- [ ] Categorizes links by type (command, navigation, workflow)
- [ ] Generates structured output (JSON/CSV format)
- [ ] Executes in under 30 seconds for full framework scan

### Validation Gates
1. **Requirements Gate**: Script meets all functional requirements
2. **Process Gate**: Systematic validation methodology implemented
3. **Output Gate**: Accurate broken link detection and reporting
4. **System Gate**: No performance degradation or false positives

## IMPLEMENTATION STRATEGY

### Script Architecture
```bash
#!/bin/bash
# scripts/link-scanner.sh - Automated link validation

FRAMEWORK_ROOT="/Users/nalve/.claude"
OUTPUT_DIR="$FRAMEWORK_ROOT/operations/link-validation"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Main execution phases
main() {
    initialize_environment
    scan_markdown_files
    extract_internal_links  
    validate_link_targets
    categorize_broken_links
    generate_reports
    cleanup_temporary_files
}
```

### Core Functions

#### Link Extraction
```bash
extract_internal_links() {
    # Extract all markdown links: [text](target.md)
    grep -rn "\[.*\](.*\.md)" "$FRAMEWORK_ROOT" \
        --include="*.md" \
        --exclude-dir=".git" \
        > "$TEMP_DIR/all_links.txt"
}
```

#### Link Validation  
```bash
validate_link_targets() {
    while IFS= read -r link_entry; do
        file_path=$(echo "$link_entry" | cut -d: -f1)
        line_number=$(echo "$link_entry" | cut -d: -f2)
        link_target=$(extract_target_from_link "$link_entry")
        
        if [[ ! -f "$resolved_path" ]]; then
            log_broken_link "$file_path" "$line_number" "$link_target"
        fi
    done < "$TEMP_DIR/all_links.txt"
}
```

#### Link Categorization
```bash
categorize_broken_links() {
    # Categories: command, navigation, workflow, registry, component
    case "$link_target" in
        commands/*) category="command" ;;
        planning/*) category="registry" ;;
        *breadcrumb*|*navigation*) category="navigation" ;;
        *workflow*|*methodology*) category="workflow" ;;
        docs/components/*) category="component" ;;
        *) category="other" ;;
    esac
}
```

## TECHNICAL IMPLEMENTATION

### File Structure
```
scripts/
├── link-scanner.sh              # Main scanner script
├── lib/
│   ├── link-extractor.sh       # Link parsing functions
│   ├── link-validator.sh       # Validation logic
│   ├── link-categorizer.sh     # Classification system
│   └── report-generator.sh     # Output formatting
└── config/
    ├── scan-config.json        # Scanner configuration
    └── exclude-patterns.txt    # Files/patterns to ignore
```

### Output Format
```json
{
  "scan_metadata": {
    "timestamp": "2025-08-19T10:30:00Z",
    "framework_root": "/Users/nalve/.claude",
    "total_files_scanned": 145,
    "total_links_found": 2847,
    "broken_links_count": 1613
  },
  "broken_links": [
    {
      "id": "broken-001",
      "file": "docs/index.md",
      "line": 42,
      "link_text": "Command Architecture",
      "link_target": "commands/architecture/command-architecture.md",
      "category": "command",
      "priority": "critical",
      "status": "broken",
      "suggested_fix": "Update to docs/components/core-framework/command-architecture.md"
    }
  ],
  "summary": {
    "by_category": {
      "command": 987,
      "navigation": 312,
      "workflow": 198,
      "registry": 86,
      "component": 30
    },
    "by_priority": {
      "critical": 234,
      "high": 567,
      "medium": 489,
      "low": 323
    }
  }
}
```

## PERFORMANCE OPTIMIZATION

### Efficient Scanning
- **Parallel processing** - Multiple file processing threads
- **Incremental scanning** - Only changed files since last run
- **Caching mechanism** - Store validation results
- **Smart filtering** - Skip binary files and irrelevant directories

### Resource Management
```bash
# Parallel processing with job control
MAX_JOBS=4
process_files_parallel() {
    while IFS= read -r file; do
        (($(jobs -r | wc -l) >= MAX_JOBS)) && wait
        process_single_file "$file" &
    done < "$file_list"
    wait  # Wait for all background jobs
}
```

## INTEGRATION FEATURES

### Configuration System
```json
{
  "scan_paths": [
    "docs/",
    "agents/",
    "tickets/",
    "operations/"
  ],
  "exclude_patterns": [
    "*.tmp",
    "*.backup",
    ".git/*"
  ],
  "link_categories": {
    "command": "commands/**/*.md",
    "navigation": "**/navigation/**",
    "workflow": "**/workflow/**"
  }
}
```

### CLI Interface
```bash
# Usage examples
./scripts/link-scanner.sh                    # Full scan
./scripts/link-scanner.sh --incremental     # Changed files only
./scripts/link-scanner.sh --category=command # Specific category
./scripts/link-scanner.sh --output=json     # Format selection
```

## DELIVERABLES

1. **link-scanner.sh** - Main scanner script
2. **Supporting libraries** - Modular function libraries
3. **Configuration system** - Flexible scanning parameters
4. **Output formats** - JSON, CSV, and human-readable reports
5. **Integration hooks** - Git hooks and CI/CD integration
6. **Documentation** - Usage guide and configuration reference

## EFFORT ESTIMATE

- **Core script development**: 3-4 hours
- **Library functions**: 2-3 hours
- **Configuration system**: 1-2 hours
- **Output formatting**: 1-2 hours
- **Testing and optimization**: 2-3 hours
- **Documentation**: 1 hour

**Total Estimated Effort**: 10-15 hours

## DEPENDENCIES

### Prerequisites
- NAV-001: Comprehensive Link Audit (completed)
- Understanding of framework structure
- Shell scripting proficiency

### Blocks
- None

### Enables
- NAV-003: Link Updater Script
- NAV-007: Integrity Monitor
- Continuous link maintenance automation

## VALIDATION METHODOLOGY

### 4-Gate Validation
1. **Requirements Gate**: All scanning requirements implemented
2. **Process Gate**: Systematic validation methodology applied
3. **Output Gate**: Accurate detection with minimal false positives
4. **System Gate**: Performance targets met, no system impact

### Quality Assurance
- Unit testing for all core functions
- Performance benchmarking on large file sets
- Accuracy validation against manual audit results
- Integration testing with framework updates

## CROSS-REFERENCES

### Related Tickets
- [NAV-001: Comprehensive Link Audit](../../planning/tickets/completed/nav-001-comprehensive-link-audit.md)
- [NAV-003: Link Updater Script](../pending/nav-003-link-updater-script.md)
- [NAV-007: Integrity Monitor](../pending/nav-007-integrity-monitor-system.md)

### Framework References
- [Apply automation.md systematic automation](../../docs/principles/automation.md)
- [Follow engineering.md quality standards](../../docs/principles/engineering.md)
- [Use workflow.md systematic methodology](../../docs/principles/workflow.md)


**Priority**: 🔥 CRITICAL  
**Category**: automation  
**Effort**: 10-15h  
**Status**: COMPLETED  
**Created**: 2025-08-19  
**Completed**: 2025-08-19  
**Dependencies**: NAV-001

[⬆ Return to top](#automated-link-scanner-script)
