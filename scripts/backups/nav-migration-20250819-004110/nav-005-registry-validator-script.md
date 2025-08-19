---
title: "Command Registry Validator Script"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["NAV-004", "organization.md", "registry.md"]
prerequisites: ["Registry structure understanding", "Command validation knowledge"]
audience: "Developers, documentation maintainers"
purpose: "Create script to validate command registry references and maintain registry integrity"
keywords: ["registry", "validation", "commands", "references", "integrity", "automation"]
last_review: "2025-08-19"
---

[Previous: Breadcrumb Generator](nav-004-breadcrumb-generator-script.md) | [Navigate to Documentation Hub](../../docs/index.md) | [Framework: Claude Code] | [Next: Workflow Fixer](nav-006-workflow-fixer-script.md)

# COMMAND REGISTRY VALIDATOR SCRIPT

⏺ **Principle**: Implement [organization.md](../../docs/principles/organization.md) systematic registry management and apply [registry.md](../../docs/principles/registry.md) reference integrity through automated validation.

## PROBLEM STATEMENT

The command registry and related documentation contain references to deleted command files, creating broken links and outdated information. Manual registry maintenance is error-prone and incomplete. Need automated script to validate registry references and maintain registry integrity.

### Target Capabilities
- **Registry validation** - Verify all command references exist
- **Reference tracking** - Map registry entries to actual files
- **Orphan detection** - Find registry entries without corresponding files
- **Missing entries** - Identify files not registered
- **Consistency checks** - Validate registry format and completeness

## SUCCESS CRITERIA

### Primary Objectives
- [ ] Validate all command references in registry files
- [ ] Detect orphaned registry entries (no corresponding files)
- [ ] Identify unregistered command files
- [ ] Verify registry format consistency
- [ ] Generate registry repair recommendations
- [ ] Maintain registry-to-file mapping database

### Validation Gates
1. **Requirements Gate**: All registry validation scenarios handled
2. **Process Gate**: Systematic validation methodology implemented
3. **Output Gate**: Accurate registry integrity assessment
4. **System Gate**: Registry consistency maintained without corruption

## IMPLEMENTATION STRATEGY

### Script Architecture
```bash
#!/bin/bash
# scripts/registry-validator.sh - Command registry validation

FRAMEWORK_ROOT="/Users/nalve/.claude"
REGISTRY_DIR="$FRAMEWORK_ROOT/planning"
COMMANDS_DIR="$FRAMEWORK_ROOT/commands"  # May not exist
OUTPUT_DIR="$FRAMEWORK_ROOT/operations/registry-validation"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Main execution phases
main() {
    initialize_validation_environment
    scan_registry_files
    extract_command_references
    validate_reference_targets
    detect_orphaned_entries
    identify_unregistered_commands
    generate_validation_report
    create_repair_recommendations
}
```

### Core Functions

#### Registry Scanning
```bash
scan_registry_files() {
    local registry_files=(
        "$REGISTRY_DIR/TICKET_REGISTRY.md"
        "$FRAMEWORK_ROOT/docs/COMMANDS.md"
        "$FRAMEWORK_ROOT/CLAUDE.md"
    )
    
    for registry_file in "${registry_files[@]}"; do
        if [[ -f "$registry_file" ]]; then
            extract_command_references_from_file "$registry_file"
        else
            log "WARNING: Registry file not found: $registry_file"
        fi
    done
}
```

#### Reference Extraction
```bash
extract_command_references() {
    local registry_file="$1"
    local temp_refs="$TEMP_DIR/registry_refs.txt"
    
    # Extract command references
    grep -n "commands/" "$registry_file" | \
    sed 's/.*\[\([^]]*\)\](\([^)]*commands\/[^)]*\)).*/\1|\2/' | \
    while IFS='|' read -r link_text target_path; do
        echo "$registry_file:$link_text:$target_path" >> "$temp_refs"
    done
}
```

#### Reference Validation
```bash
validate_command_reference() {
    local registry_file="$1"
    local link_text="$2"
    local target_path="$3"
    
    # Resolve absolute path
    local abs_path
    if [[ "$target_path" =~ ^/ ]]; then
        abs_path="$target_path"
    else
        abs_path=$(realpath -m "$(dirname "$registry_file")/$target_path")
    fi
    
    # Check if target exists
    if [[ ! -f "$abs_path" ]]; then
        log_broken_reference "$registry_file" "$link_text" "$target_path" "FILE_NOT_FOUND"
        return 1
    fi
    
    return 0
}
```

## TECHNICAL IMPLEMENTATION

### Registry Analysis Types

#### Ticket Registry Validation
```bash
validate_ticket_registry() {
    local registry_file="$REGISTRY_DIR/TICKET_REGISTRY.md"
    
    # Extract ticket entries
    grep -n "| \[.*\](.*\.md)" "$registry_file" | \
    while IFS='|' read -r line_num ticket_link; do
        local ticket_path=$(echo "$ticket_link" | sed 's/.*](\([^)]*\)).*/\1/')
        validate_ticket_file "$registry_file" "$line_num" "$ticket_path"
    done
}
```

#### Command Documentation Validation
```bash
validate_command_docs() {
    local commands_doc="$FRAMEWORK_ROOT/docs/COMMANDS.md"
    
    if [[ -f "$commands_doc" ]]; then
        # Extract command references
        grep -n "commands/" "$commands_doc" | \
        while read -r command_ref; do
            validate_command_documentation_reference "$command_ref"
        done
    fi
}
```

#### CLAUDE.md Reference Validation
```bash
validate_claude_md_references() {
    local claude_md="$FRAMEWORK_ROOT/CLAUDE.md"
    
    # Check for command directory references
    grep -n "commands/" "$claude_md" | \
    while read -r line_num line_content; do
        local command_path=$(extract_path_from_link "$line_content")
        if [[ ! -f "$FRAMEWORK_ROOT/$command_path" ]]; then
            log_claude_md_broken_reference "$line_num" "$command_path"
        fi
    done
}
```

### Orphan Detection
```bash
detect_orphaned_registry_entries() {
    local registry_refs="$TEMP_DIR/all_registry_refs.txt"
    local orphaned_entries="$OUTPUT_DIR/orphaned_entries.txt"
    
    while IFS=':' read -r registry_file link_text target_path; do
        if [[ ! -f "$target_path" ]]; then
            echo "$registry_file:$link_text:$target_path:ORPHANED" >> "$orphaned_entries"
        fi
    done < "$registry_refs"
}
```

### Missing Entry Detection
```bash
identify_unregistered_files() {
    local existing_files="$TEMP_DIR/existing_files.txt"
    local registry_refs="$TEMP_DIR/registry_refs.txt"
    local unregistered="$OUTPUT_DIR/unregistered_files.txt"
    
    # Find all .md files that could be commands
    find "$FRAMEWORK_ROOT" -name "*.md" -type f | \
    grep -E "(command|cmd|execute)" > "$existing_files"
    
    # Compare with registry references
    while read -r file_path; do
        if ! grep -q "$file_path" "$registry_refs"; then
            echo "$file_path:UNREGISTERED" >> "$unregistered"
        fi
    done < "$existing_files"
}
```

## VALIDATION REPORTS

### Comprehensive Report Format
```json
{
  "validation_metadata": {
    "timestamp": "2025-08-19T10:30:00Z",
    "validator_version": "1.0.0",
    "framework_root": "/Users/nalve/.claude",
    "registries_scanned": 3,
    "total_references": 147
  },
  "validation_results": {
    "broken_references": [
      {
        "registry_file": "../../planning/TICKET_REGISTRY.md",
        "line_number": 89,
        "link_text": "System Audit Command",
        "target_path": "commands/analysis/system-audit.md",
        "error_type": "FILE_NOT_FOUND",
        "suggested_fix": "Remove reference or update to new location"
      }
    ],
    "orphaned_entries": [
      {
        "registry_file": "docs/COMMANDS.md",
        "section": "Analysis Commands",
        "entry_count": 12,
        "missing_files": [
          "commands/analysis/system-audit.md",
          "commands/analysis/dependency-analysis.md"
        ]
      }
    ],
    "unregistered_files": [
      {
        "file_path": "docs/components/command-execution.md",
        "suggested_registry": "docs/COMMANDS.md",
        "category": "component"
      }
    ]
  },
  "summary": {
    "total_broken_references": 89,
    "total_orphaned_entries": 34,
    "total_unregistered_files": 12,
    "registry_integrity_score": 0.42
  }
}
```

### Repair Recommendations
```bash
generate_repair_recommendations() {
    local validation_results="$1"
    local recommendations="$OUTPUT_DIR/repair_recommendations.md"
    
    cat > "$recommendations" << EOF
# Registry Repair Recommendations

## Immediate Actions Required

### Broken References (Critical)
- Remove 89 references to deleted command files
- Update CLAUDE.md command directory references
- Consolidate ticket registry orphaned entries

### Registry Cleanup (High Priority)  
- Remove orphaned entries from TICKET_REGISTRY.md
- Update docs/COMMANDS.md structure
- Consolidate command documentation

### Missing Registrations (Medium Priority)
- Register 12 unregistered command-related files
- Update registry categories and sections
- Improve registry organization

## Automated Fix Scripts
- run_registry_cleanup.sh - Remove broken references
- update_registry_structure.sh - Reorganize registry
- register_missing_files.sh - Add unregistered files
EOF
}
```

## INTEGRATION FEATURES

### CLI Interface
```bash
# Usage examples
./scripts/registry-validator.sh --full-validation
./scripts/registry-validator.sh --registry="TICKET_REGISTRY.md"
./scripts/registry-validator.sh --fix-broken-refs
./scripts/registry-validator.sh --generate-repair-plan
```

### Automated Fixes
```bash
fix_broken_references() {
    local validation_report="$1"
    local fix_mode="$2"  # remove, comment, or update
    
    case "$fix_mode" in
        "remove")
            remove_broken_registry_references "$validation_report"
            ;;
        "comment")
            comment_broken_registry_references "$validation_report"
            ;;
        "update")
            interactive_reference_update "$validation_report"
            ;;
    esac
}
```

## DELIVERABLES

1. **registry-validator.sh** - Main validation script
2. **Validation libraries** - Modular validation functions
3. **Report generation** - JSON and markdown output formats
4. **Repair recommendations** - Automated fix suggestions
5. **CLI interface** - Command-line usage options
6. **Integration hooks** - Registry maintenance automation
7. **Documentation** - Validation guide and procedures

## EFFORT ESTIMATE

- **Core validation logic**: 3-4 hours
- **Registry analysis**: 2-3 hours
- **Report generation**: 2-3 hours
- **Repair recommendations**: 2-3 hours
- **CLI interface**: 1-2 hours
- **Testing and validation**: 2-3 hours
- **Documentation**: 1 hour

**Total Estimated Effort**: 13-19 hours

## DEPENDENCIES

### Prerequisites
- Registry structure understanding
- Command organization knowledge
- Validation methodology familiarity

### Blocks
- None

### Enables
- Registry integrity maintenance
- Automated registry cleanup
- Consistent command organization

## VALIDATION METHODOLOGY

### 4-Gate Validation
1. **Requirements Gate**: All registry validation scenarios handled
2. **Process Gate**: Systematic validation methodology implemented
3. **Output Gate**: Accurate registry integrity assessment
4. **System Gate**: Registry consistency maintained without corruption

### Quality Assurance
- Validation accuracy testing
- Report format verification
- Integration testing with registry updates
- Performance testing with large registries

## CROSS-REFERENCES

### Related Tickets
- [NAV-004: Breadcrumb Generator](nav-004-breadcrumb-generator-script.md)
- [NAV-006: Workflow Fixer](nav-006-workflow-fixer-script.md)
- [NAV-007: Integrity Monitor](nav-007-integrity-monitor-system.md)

### Framework References
- [Apply organization.md registry management](../../docs/principles/organization.md)
- [Follow registry.md integrity standards](../../docs/principles/registry.md)
- [Use workflow.md systematic methodology](../../docs/principles/workflow.md)

---

**Priority**: 🔴 HIGH  
**Category**: validation  
**Effort**: 13-19h  
**Status**: PENDING  
**Created**: 2025-08-19  
**Dependencies**: NAV-004

[⬆ Return to top](#command-registry-validator-script)