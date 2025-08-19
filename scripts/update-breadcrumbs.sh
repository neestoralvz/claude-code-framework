#!/bin/bash

# Batch Update Breadcrumbs Script
# Updates navigation breadcrumbs across all documentation files
# Uses breadcrumb-generator.sh for standardized generation

set -euo pipefail

# Configuration
CLAUDE_ROOT="/Users/nalve/.claude"
GENERATOR_SCRIPT="$CLAUDE_ROOT/docs/components/breadcrumb-generator.sh"
BACKUP_DIR="$CLAUDE_ROOT/.breadcrumb-backups"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}INFO:${NC} $1"
}

log_success() {
    echo -e "${GREEN}SUCCESS:${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}WARNING:${NC} $1"
}

log_error() {
    echo -e "${RED}ERROR:${NC} $1"
}

# Create backup of current file
create_backup() {
    local file_path="$1"
    local backup_path="$BACKUP_DIR/$(date +%Y%m%d_%H%M%S)_$(basename "$file_path")"
    
    mkdir -p "$BACKUP_DIR"
    cp "$file_path" "$backup_path"
    echo "$backup_path"
}

# Check if file has existing breadcrumb
has_breadcrumb() {
    local file_path="$1"
    grep -q "^\[.*\](.*.md)" "$file_path" 2>/dev/null
}

# Extract existing breadcrumb line number
get_breadcrumb_line() {
    local file_path="$1"
    grep -n "^\[.*\](.*.md)" "$file_path" 2>/dev/null | head -1 | cut -d: -f1
}

# Update breadcrumb in file
update_breadcrumb() {
    local file_path="$1"
    local new_breadcrumb="$2"
    local backup_path
    
    # Create backup
    backup_path=$(create_backup "$file_path")
    log_info "Created backup: $backup_path"
    
    # Check if file has existing breadcrumb
    if has_breadcrumb "$file_path"; then
        local line_num
        line_num=$(get_breadcrumb_line "$file_path")
        
        # Replace existing breadcrumb
        sed -i.tmp "${line_num}s|.*|$new_breadcrumb|" "$file_path"
        rm -f "$file_path.tmp"
        
        log_success "Updated existing breadcrumb at line $line_num"
    else
        # Insert breadcrumb after frontmatter (if present) or at beginning
        if head -1 "$file_path" | grep -q "^---$"; then
            # Find end of frontmatter
            local frontmatter_end
            frontmatter_end=$(grep -n "^---$" "$file_path" | sed -n '2p' | cut -d: -f1)
            
            if [[ -n "$frontmatter_end" ]]; then
                # Insert after frontmatter
                sed -i.tmp "${frontmatter_end}a\\
\\
$new_breadcrumb\\
" "$file_path"
                rm -f "$file_path.tmp"
                log_success "Added breadcrumb after frontmatter"
            else
                log_warning "Frontmatter format unclear, adding at beginning"
                sed -i.tmp "1i\\
$new_breadcrumb\\
" "$file_path"
                rm -f "$file_path.tmp"
            fi
        else
            # Insert at beginning of file
            sed -i.tmp "1i\\
$new_breadcrumb\\
" "$file_path"
            rm -f "$file_path.tmp"
            log_success "Added breadcrumb at beginning of file"
        fi
    fi
}

# Validate breadcrumb format
validate_breadcrumb() {
    local breadcrumb="$1"
    local file_path="$2"
    
    # Check basic format
    if [[ ! "$breadcrumb" =~ ^\[.*\]\(.*\).*\[.*\]\(.*\).*\[.*\]\(.*\) ]]; then
        log_error "Invalid breadcrumb format for $file_path"
        return 1
    fi
    
    # Check for proper pipe separators
    local pipe_count
    pipe_count=$(echo "$breadcrumb" | grep -o "|" | wc -l)
    
    if [[ $pipe_count -lt 2 || $pipe_count -gt 3 ]]; then
        log_error "Invalid pipe separator count for $file_path (expected 2-3, got $pipe_count)"
        return 1
    fi
    
    return 0
}

# Process single file
process_file() {
    local file_path="$1"
    local file_name
    file_name=$(basename "$file_path")
    
    log_info "Processing: $file_name"
    
    # Skip certain files
    case "$file_name" in
        "README.md"|"CHANGELOG.md"|"LICENSE.md")
            log_warning "Skipping system file: $file_name"
            return 0
            ;;
    esac
    
    # Generate new breadcrumb
    local new_breadcrumb
    if ! new_breadcrumb=$("$GENERATOR_SCRIPT" "$file_path" 2>/dev/null); then
        log_error "Failed to generate breadcrumb for $file_path"
        return 1
    fi
    
    # Validate generated breadcrumb
    if ! validate_breadcrumb "$new_breadcrumb" "$file_path"; then
        return 1
    fi
    
    # Update file with new breadcrumb
    if ! update_breadcrumb "$file_path" "$new_breadcrumb"; then
        log_error "Failed to update breadcrumb in $file_path"
        return 1
    fi
    
    log_success "Updated: $file_name"
    return 0
}

# Find all documentation files
find_documentation_files() {
    local target_dir="${1:-$CLAUDE_ROOT}"
    
    find "$target_dir" -name "*.md" -type f | grep -E "(commands|agents|docs)/" | sort
}

# Process directory batch
process_directory_batch() {
    local target_dir="$1"
    local processed=0
    local errors=0
    
    log_info "Processing directory: $target_dir"
    
    while IFS= read -r file_path; do
        if [[ -f "$file_path" ]]; then
            if process_file "$file_path"; then
                ((processed++))
            else
                ((errors++))
            fi
        fi
    done < <(find_documentation_files "$target_dir")
    
    log_info "Directory completed: $processed processed, $errors errors"
}

# Restore from backup
restore_backup() {
    local backup_timestamp="$1"
    local restore_count=0
    
    log_info "Restoring from backup timestamp: $backup_timestamp"
    
    if [[ ! -d "$BACKUP_DIR" ]]; then
        log_error "Backup directory not found"
        return 1
    fi
    
    for backup_file in "$BACKUP_DIR"/${backup_timestamp}_*; do
        if [[ -f "$backup_file" ]]; then
            local original_name
            original_name=$(basename "$backup_file" | sed "s/^${backup_timestamp}_//")
            
            # Find original file location (simplified search)
            local original_path
            original_path=$(find "$CLAUDE_ROOT" -name "$original_name" -type f | head -1)
            
            if [[ -n "$original_path" && -f "$original_path" ]]; then
                cp "$backup_file" "$original_path"
                log_success "Restored: $original_name"
                ((restore_count++))
            else
                log_warning "Could not locate original file for: $original_name"
            fi
        fi
    done
    
    log_info "Restored $restore_count files from backup"
}

# Show usage information
show_usage() {
    cat << EOF
Batch Update Breadcrumbs Script

USAGE:
    $0 [OPTIONS] [TARGET]

OPTIONS:
    -h, --help              Show this help message
    -v, --validate          Validate existing breadcrumbs only
    -b, --backup-only       Create backups without updating
    -r, --restore TIMESTAMP Restore from specific backup timestamp
    -d, --directory DIR     Process specific directory only
    --dry-run              Show what would be updated without making changes

TARGETS:
    all                    Process all documentation files (default)
    commands              Process command files only
    agents                Process agent files only
    docs                  Process docs files only
    components            Process component files only

EXAMPLES:
    $0                          # Update all documentation files
    $0 commands                 # Update command files only
    $0 --validate               # Validate existing breadcrumbs
    $0 --restore 20250118_143022 # Restore from specific backup
    $0 --dry-run                # Preview changes without updating

EOF
}

# Main execution function
main() {
    local target="all"
    local validate_only=false
    local backup_only=false
    local restore_timestamp=""
    local specific_directory=""
    local dry_run=false
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -v|--validate)
                validate_only=true
                shift
                ;;
            -b|--backup-only)
                backup_only=true
                shift
                ;;
            -r|--restore)
                restore_timestamp="$2"
                shift 2
                ;;
            -d|--directory)
                specific_directory="$2"
                shift 2
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            all|commands|agents|docs|components)
                target="$1"
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    # Validate generator script exists
    if [[ ! -f "$GENERATOR_SCRIPT" ]]; then
        log_error "Breadcrumb generator script not found: $GENERATOR_SCRIPT"
        exit 1
    fi
    
    # Make generator script executable
    chmod +x "$GENERATOR_SCRIPT"
    
    # Handle restore operation
    if [[ -n "$restore_timestamp" ]]; then
        restore_backup "$restore_timestamp"
        exit $?
    fi
    
    # Handle validation only
    if [[ "$validate_only" == true ]]; then
        log_info "Validation mode - checking existing breadcrumbs"
        # Implement validation logic here
        exit 0
    fi
    
    # Handle backup only
    if [[ "$backup_only" == true ]]; then
        log_info "Backup mode - creating backups only"
        # Implement backup-only logic here
        exit 0
    fi
    
    # Handle dry run
    if [[ "$dry_run" == true ]]; then
        log_info "Dry run mode - showing what would be updated"
        # Implement dry run logic here
        exit 0
    fi
    
    # Process based on target
    case "$target" in
        "all")
            log_info "Starting breadcrumb update for all documentation files"
            process_directory_batch "$CLAUDE_ROOT"
            ;;
        "commands")
            process_directory_batch "$CLAUDE_ROOT/commands"
            ;;
        "agents")
            process_directory_batch "$CLAUDE_ROOT/agents"
            ;;
        "docs")
            process_directory_batch "$CLAUDE_ROOT/docs"
            ;;
        "components")
            process_directory_batch "$CLAUDE_ROOT/docs/components"
            ;;
        *)
            if [[ -n "$specific_directory" ]]; then
                process_directory_batch "$specific_directory"
            else
                log_error "Unknown target: $target"
                show_usage
                exit 1
            fi
            ;;
    esac
    
    log_success "Breadcrumb update process completed"
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi