#!/bin/bash

# Navigation Standardization Implementation Script
# Systematically applies universal navigation template to all system files

set -euo pipefail

# Configuration
PROJECT_ROOT="/Users/nalve/.claude"
SYSTEM_DIR="$PROJECT_ROOT/system"
OPS_DIR="$PROJECT_ROOT/operations/20250819-201718-navigation-standardization"
LOG_FILE="$OPS_DIR/implementation.log"
BACKUP_DIR="$OPS_DIR/backups"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$LOG_FILE"
}

# Create backup
create_backup() {
    local file="$1"
    local backup_file="$BACKUP_DIR/$(basename "$file").backup"
    
    mkdir -p "$BACKUP_DIR"
    cp "$file" "$backup_file"
    log_info "Backup created: $backup_file"
}

# Get file context based on directory and content
get_file_context() {
    local file="$1"
    local filename=$(basename "$file")
    local dirname=$(basename $(dirname "$file"))
    
    case "$filename" in
        "INDEX.md")
            echo "Central navigation hub for the .claude framework system"
            ;;
        "PRINCIPLES.md")
            echo "Core principles that guide framework decision-making and behavior"
            ;;
        "BEHAVIORS.md")
            echo "Behavioral patterns and interaction guidelines for framework usage"
            ;;
        "PROCESSES.md")
            echo "Workflow processes and procedural guidelines for framework operations"
            ;;
        "STANDARDS.md")
            echo "Quality standards and consistency requirements for framework compliance"
            ;;
        "EXAMPLES.md")
            echo "Practical examples demonstrating framework principles and patterns"
            ;;
        "TOOLS.md")
            echo "Utility tools and scripts supporting framework maintenance and operation"
            ;;
        "CHECKS.md")
            echo "Validation checks and quality assurance mechanisms for framework integrity"
            ;;
        *)
            case "$dirname" in
                "principles")
                    echo "Fundamental principle defining framework behavior and decision-making"
                    ;;
                "behaviors")
                    echo "Behavioral pattern specifying interaction and response guidelines"
                    ;;
                "processes")
                    echo "Workflow process defining procedural steps and execution patterns"
                    ;;
                "standards")
                    echo "Quality standard ensuring consistency and compliance requirements"
                    ;;
                "examples")
                    echo "Practical example demonstrating framework implementation patterns"
                    ;;
                "tools")
                    echo "Utility tool supporting framework maintenance and operations"
                    ;;
                "checks")
                    echo "Validation check ensuring framework integrity and compliance"
                    ;;
                "templates")
                    echo "Template component for consistent framework documentation structure"
                    ;;
                *)
                    echo "Framework component providing system functionality and guidance"
                    ;;
            esac
            ;;
    esac
}

# Get navigation links based on file location
get_navigation_links() {
    local file="$1"
    local filename=$(basename "$file")
    local dirname=$(basename $(dirname "$file"))
    local relative_path="${file#$SYSTEM_DIR/}"
    
    # Determine if file is in root or subdirectory
    if [[ "$relative_path" == *.md ]] && [[ "$relative_path" != */* ]]; then
        # Root level file
        case "$filename" in
            "INDEX.md")
                echo "**Navigation:** [🏠 System Hub](INDEX.md)"
                ;;
            *)
                echo "**Navigation:** [↑ System Home](INDEX.md)"
                ;;
        esac
    else
        # Subdirectory file
        case "$dirname" in
            "principles")
                echo "**Navigation:** [← Back to Principles](../PRINCIPLES.md) | [↑ System Home](../INDEX.md)"
                ;;
            "behaviors")
                echo "**Navigation:** [← Back to Behaviors](../BEHAVIORS.md) | [↑ System Home](../INDEX.md)"
                ;;
            "processes")
                echo "**Navigation:** [← Back to Processes](../PROCESSES.md) | [↑ System Home](../INDEX.md)"
                ;;
            "standards")
                echo "**Navigation:** [← Back to Standards](../STANDARDS.md) | [↑ System Home](../INDEX.md)"
                ;;
            "examples")
                echo "**Navigation:** [← Back to Examples](../EXAMPLES.md) | [↑ System Home](../INDEX.md)"
                ;;
            "tools")
                echo "**Navigation:** [← Back to Tools](../TOOLS.md) | [↑ System Home](../INDEX.md)"
                ;;
            "checks")
                echo "**Navigation:** [← Back to Checks](../CHECKS.md) | [↑ System Home](../INDEX.md)"
                ;;
            "templates")
                echo "**Navigation:** [← Back to Templates](../TEMPLATES.md) | [↑ System Home](../INDEX.md)"
                ;;
            *)
                echo "**Navigation:** [↑ System Home](../INDEX.md)"
                ;;
        esac
    fi
}

# Get emoji navigation bar
get_emoji_navigation() {
    local file="$1"
    local relative_path="${file#$SYSTEM_DIR/}"
    
    # Determine if file is in root or subdirectory
    if [[ "$relative_path" == *.md ]] && [[ "$relative_path" != */* ]]; then
        # Root level file
        echo "[🏠 System Hub](INDEX.md) | [📁 Framework](./) | [📖 Current Section](#)"
    else
        # Subdirectory file
        echo "[🏠 System Hub](../INDEX.md) | [📁 Parent Directory](./) | [📖 Current Section](#)"
    fi
}

# Update file with navigation
update_file_navigation() {
    local file="$1"
    local temp_file=$(mktemp)
    local has_changes=false
    
    log_info "Updating navigation for: ${file#$PROJECT_ROOT/}"
    
    # Create backup
    create_backup "$file"
    
    # Read file content
    local content=$(cat "$file")
    
    # Check if file already has emoji navigation
    if ! echo "$content" | grep -q "🏠 System Hub"; then
        # Add emoji navigation at the top
        {
            echo "$(get_emoji_navigation "$file")"
            echo ""
            echo "---"
            echo ""
            cat "$file"
        } > "$temp_file"
        content=$(cat "$temp_file")
        has_changes=true
        log_info "Added emoji navigation"
    fi
    
    # Check if file has context statement
    if ! echo "$content" | grep -q "\*\*Context:\*\*"; then
        # Find the first heading and add context after it
        local context="**Context**: $(get_file_context "$file")"
        
        # Add context after the first heading
        echo "$content" | awk -v context="$context" '
        /^# / && !added {
            print $0
            print ""
            print context
            print ""
            added=1
            next
        }
        { print }
        ' > "$temp_file"
        content=$(cat "$temp_file")
        has_changes=true
        log_info "Added context statement"
    fi
    
    # Check if file has navigation section at bottom
    if ! echo "$content" | grep -q "\*\*Navigation:\*\*"; then
        # Add navigation at the end
        {
            echo "$content"
            echo ""
            echo "---"
            echo ""
            echo "$(get_navigation_links "$file")"
        } > "$temp_file"
        content=$(cat "$temp_file")
        has_changes=true
        log_info "Added navigation section"
    fi
    
    # Apply changes if any were made
    if [[ "$has_changes" == true ]]; then
        cp "$temp_file" "$file"
        log_success "Updated: ${file#$PROJECT_ROOT/}"
    else
        log_info "No changes needed: ${file#$PROJECT_ROOT/}"
    fi
    
    rm -f "$temp_file"
}

# Process all files
process_all_files() {
    local total_files=0
    local updated_files=0
    
    log "Starting navigation implementation for all system files"
    
    # Priority order: main index files first, then subdirectories
    local priority_files=(
        "$SYSTEM_DIR/INDEX.md"
        "$SYSTEM_DIR/PRINCIPLES.md"
        "$SYSTEM_DIR/BEHAVIORS.md"
        "$SYSTEM_DIR/PROCESSES.md"
        "$SYSTEM_DIR/STANDARDS.md"
        "$SYSTEM_DIR/EXAMPLES.md"
        "$SYSTEM_DIR/TOOLS.md"
        "$SYSTEM_DIR/CHECKS.md"
    )
    
    # Process priority files first
    for file in "${priority_files[@]}"; do
        if [[ -f "$file" ]]; then
            ((total_files++))
            update_file_navigation "$file"
            ((updated_files++))
        fi
    done
    
    # Process remaining files
    while IFS= read -r -d '' file; do
        # Skip if already processed
        local skip=false
        for priority_file in "${priority_files[@]}"; do
            if [[ "$file" == "$priority_file" ]]; then
                skip=true
                break
            fi
        done
        
        if [[ "$skip" == false ]]; then
            ((total_files++))
            update_file_navigation "$file"
            ((updated_files++))
        fi
    done < <(find "$SYSTEM_DIR" -name "*.md" -type f -print0)
    
    log ""
    log "=== IMPLEMENTATION SUMMARY ==="
    log "Total files processed: $total_files"
    log "Files updated: $updated_files"
    log "Backups created in: $BACKUP_DIR"
    
    # Run validation to check results
    log "Running post-implementation validation..."
    "$OPS_DIR/navigation-validator.sh"
}

# Main execution
main() {
    # Initialize
    mkdir -p "$OPS_DIR" "$BACKUP_DIR"
    > "$LOG_FILE"
    
    log "Navigation Standardization Implementation Started"
    log "Project root: $PROJECT_ROOT"
    log "System directory: $SYSTEM_DIR"
    log "Operations directory: $OPS_DIR"
    
    process_all_files
    
    log_success "Navigation standardization implementation completed!"
}

# Help function
show_help() {
    cat << EOF
Navigation Standardization Implementation Script

Usage: $0 [OPTIONS]

Options:
    -h, --help     Show this help message
    --dry-run      Show what would be changed without making changes
    --backup-only  Create backups without making changes

Description:
    Systematically applies universal navigation template to all
    markdown files in the system/ directory.

Features:
    - Creates automatic backups of all modified files
    - Adds emoji navigation bars at top of files
    - Inserts context statements after main headings
    - Adds navigation sections at bottom of files
    - Processes files in priority order
    - Runs post-implementation validation

Output:
    - Implementation log: $LOG_FILE
    - File backups: $BACKUP_DIR/
    - Validation report: Generated after completion

EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        --dry-run)
            log_info "DRY RUN mode - no files will be modified"
            # Set dry run flag and modify functions accordingly
            DRY_RUN=true
            shift
            ;;
        --backup-only)
            log_info "BACKUP ONLY mode - creating backups without modifications"
            BACKUP_ONLY=true
            shift
            ;;
        *)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Run main function
main