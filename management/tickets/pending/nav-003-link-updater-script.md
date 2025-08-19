
[Previous: Link Scanner](../completed/nav-002-link-scanner-script.md) | [Navigate to Documentation Hub](../../docs/index.md) | [Framework: Claude Code] | [Next: Breadcrumb Generator](nav-004-breadcrumb-generator-script.md)

# AUTOMATED LINK UPDATER SCRIPT

⏺ **Principle**: Implement [task-orchestration.md](../../docs/principles/task-orchestration.md) systematic automation and apply [engineering.md](../../docs/principles/engineering.md) safety-first file modification through automated reference updating.

## PROBLEM STATEMENT

When files are moved, renamed, or deleted, references throughout the framework become broken. Manual updates are error-prone and incomplete. Need automated script to systematically update all references when file operations occur.

### Target Capabilities
- **File operation detection** - Track moves, renames, deletions
- **Reference discovery** - Find all links to affected files
- **Safe batch updates** - Atomic reference replacement
- **Rollback capability** - Undo changes if needed
- **Integration hooks** - Git integration for automatic triggering

## SUCCESS CRITERIA

### Primary Objectives
- [ ] Detect file moves/renames/deletions automatically
- [ ] Find all references to affected files across framework
- [ ] Safely update references with new paths
- [ ] Maintain link integrity during batch operations
- [ ] Provide rollback mechanism for failed updates
- [ ] Integrate with git hooks for automatic execution

### Validation Gates
1. **Requirements Gate**: All update scenarios handled correctly
2. **Process Gate**: Safe file modification methodology applied
3. **Output Gate**: References updated accurately with no corruption
4. **System Gate**: No data loss or unintended modifications

## IMPLEMENTATION STRATEGY

### Script Architecture
```bash
#!/bin/bash
# scripts/link-updater.sh - Automated reference updating

FRAMEWORK_ROOT="/Users/nalve/.claude"
BACKUP_DIR="$FRAMEWORK_ROOT/operations/link-updates/backups"
LOG_DIR="$FRAMEWORK_ROOT/operations/link-updates/logs"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Main execution phases
main() {
    parse_update_request
    validate_operation_safety
    create_backup_snapshot
    discover_affected_references
    plan_update_operations
    execute_safe_updates
    validate_update_integrity
    cleanup_or_rollback
}
```

### Core Functions

#### File Operation Detection
```bash
detect_file_operations() {
    # Integration with git hooks
    case "$operation" in
        "move")
            old_path="$1"
            new_path="$2"
            update_references_batch "$old_path" "$new_path"
            ;;
        "delete")
            deleted_path="$1"
            handle_deleted_file_references "$deleted_path"
            ;;
        "rename")
            old_name="$1"
            new_name="$2"
            update_filename_references "$old_name" "$new_name"
            ;;
    esac
}
```

#### Reference Discovery
```bash
find_all_references() {
    local target_file="$1"
    local references_file="$TEMP_DIR/references.txt"
    
    # Find all markdown links to target file
    grep -rn "\[.*\]([^)]*$(basename "$target_file")" \
        "$FRAMEWORK_ROOT" \
        --include="*.md" \
        --exclude-dir=".git" \
        > "$references_file"
    
    # Find relative path references
    grep -rn "\]([^)]*$target_file" \
        "$FRAMEWORK_ROOT" \
        --include="*.md" \
        >> "$references_file"
}
```

#### Safe Batch Updates
```bash
execute_safe_updates() {
    local update_plan="$1"
    local backup_id="$TIMESTAMP"
    
    # Create atomic update transaction
    begin_update_transaction "$backup_id"
    
    while IFS= read -r update_entry; do
        if ! apply_single_update "$update_entry"; then
            rollback_transaction "$backup_id"
            return 1
        fi
    done < "$update_plan"
    
    commit_transaction "$backup_id"
}
```

## TECHNICAL IMPLEMENTATION

### Update Operation Types

#### File Move Updates
```bash
update_file_move() {
    local old_path="$1"
    local new_path="$2"
    
    # Calculate relative path adjustments
    while IFS= read -r reference; do
        file=$(echo "$reference" | cut -d: -f1)
        line=$(echo "$reference" | cut -d: -f2)
        
        # Calculate new relative path from referencing file
        new_relative_path=$(calculate_relative_path "$file" "$new_path")
        
        # Update the reference
        update_link_in_file "$file" "$line" "$old_path" "$new_relative_path"
    done < "$references_file"
}
```

#### File Deletion Handling
```bash
handle_deleted_file() {
    local deleted_file="$1"
    local action="$2"  # remove, comment, or replace
    
    case "$action" in
        "remove")
            remove_broken_links "$deleted_file"
            ;;
        "comment")
            comment_broken_links "$deleted_file"
            ;;
        "replace")
            replace_with_alternative "$deleted_file" "$replacement_file"
            ;;
    esac
}
```

### Safety Mechanisms

#### Backup System
```bash
create_backup_snapshot() {
    local backup_id="$1"
    local backup_path="$BACKUP_DIR/$backup_id"
    
    mkdir -p "$backup_path"
    
    # Create file list of all files to be modified
    while IFS= read -r file; do
        cp "$file" "$backup_path/$(basename "$file")"
        echo "$file" >> "$backup_path/file_list.txt"
    done < "$files_to_modify"
}
```

#### Rollback Capability
```bash
rollback_transaction() {
    local backup_id="$1"
    local backup_path="$BACKUP_DIR/$backup_id"
    
    log "ROLLBACK: Restoring files from backup $backup_id"
    
    while IFS= read -r original_file; do
        if [[ -f "$backup_path/$(basename "$original_file")" ]]; then
            cp "$backup_path/$(basename "$original_file")" "$original_file"
            log "RESTORED: $original_file"
        fi
    done < "$backup_path/file_list.txt"
}
```

### Integration Features

#### Git Hook Integration
```bash
# .git/hooks/post-move (custom hook)
#!/bin/bash
if [[ "$1" =~ \.md$ ]]; then
    "$FRAMEWORK_ROOT/scripts/link-updater.sh" \
        --operation=move \
        --old-path="$1" \
        --new-path="$2" \
        --auto-commit
fi
```

#### CLI Interface
```bash
# Usage examples
./scripts/link-updater.sh --move old.md new.md
./scripts/link-updater.sh --delete deleted.md --action=comment
./scripts/link-updater.sh --batch-update update-plan.json
./scripts/link-updater.sh --rollback backup-20250819-103000
```

## ADVANCED FEATURES

### Intelligent Path Resolution
```bash
calculate_relative_path() {
    local from_file="$1"
    local to_file="$2"
    
    # Use realpath for accurate relative path calculation
    local from_dir=$(dirname "$(realpath "$from_file")")
    local to_path=$(realpath "$to_file")
    
    # Calculate relative path
    python3 -c "
import os
print(os.path.relpath('$to_path', '$from_dir'))
"
}
```

### Update Validation
```bash
validate_update_integrity() {
    local update_log="$1"
    
    # Run link scanner to verify no new broken links
    "$FRAMEWORK_ROOT/scripts/link-scanner.sh" \
        --output="$TEMP_DIR/post_update_scan.json"
    
    # Compare with pre-update state
    if ! diff "$pre_update_scan" "$post_update_scan" > /dev/null; then
        log "WARNING: New broken links detected after update"
        return 1
    fi
}
```

### Batch Processing
```json
{
  "update_operations": [
    {
      "type": "move",
      "old_path": "commands/analysis/system-audit.md",
      "new_path": "docs/components/analysis/system-audit.md",
      "update_strategy": "maintain_relative_paths"
    },
    {
      "type": "delete",
      "path": "commands/deprecated/old-command.md",
      "action": "comment_references",
      "comment_text": "// DEPRECATED: Command removed in framework v4.0"
    }
  ]
}
```

## DELIVERABLES

1. **link-updater.sh** - Main updater script
2. **Update libraries** - Modular update functions
3. **Safety system** - Backup and rollback mechanisms
4. **Git integration** - Hook scripts for automatic execution
5. **CLI interface** - Command-line usage options
6. **Validation system** - Update integrity verification
7. **Documentation** - Usage guide and safety procedures

## EFFORT ESTIMATE

- **Core updater logic**: 4-5 hours
- **Safety mechanisms**: 3-4 hours
- **Git integration**: 2-3 hours
- **CLI interface**: 1-2 hours
- **Validation system**: 2-3 hours
- **Testing and edge cases**: 3-4 hours
- **Documentation**: 1 hour

**Total Estimated Effort**: 16-22 hours

## DEPENDENCIES

### Prerequisites
- NAV-002: Link Scanner Script (completed)
- File backup and restore capability
- Git integration understanding

### Blocks
- None

### Enables
- Safe file reorganization operations
- Automated framework maintenance
- Git workflow integration

## VALIDATION METHODOLOGY

### 4-Gate Validation
1. **Requirements Gate**: All update scenarios properly handled
2. **Process Gate**: Safety-first methodology implemented
3. **Output Gate**: References updated accurately with integrity maintained
4. **System Gate**: No data loss, successful rollback capability

### Quality Assurance
- Unit testing for all update operations
- Safety testing with rollback scenarios
- Integration testing with git workflows
- Performance testing with large reference sets

## CROSS-REFERENCES

### Related Tickets
- [NAV-002: Link Scanner Script](../completed/nav-002-link-scanner-script.md)
- [NAV-004: Breadcrumb Generator](nav-004-breadcrumb-generator-script.md)
- [NAV-007: Integrity Monitor](nav-007-integrity-monitor-system.md)

### Framework References
- [Apply task-orchestration.md systematic automation](../../docs/principles/task-orchestration.md)
- [Follow engineering.md safety standards](../../docs/principles/engineering.md)
- [Use workflow.md systematic methodology](../../docs/principles/workflow.md)


**Priority**: 🔥 CRITICAL  
**Category**: automation  
**Effort**: 16-22h  
**Status**: PENDING  
**Created**: 2025-08-19  
**Dependencies**: NAV-002

[⬆ Return to top](#automated-link-updater-script)
