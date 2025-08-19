#!/bin/bash

# Navigation Breadcrumb Validator
# Validates breadcrumb consistency across documentation files

set -eo pipefail

CLAUDE_ROOT="/Users/nalve/.claude"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Validate single file breadcrumb
validate_file_breadcrumb() {
    local file_path="$1"
    local file_name=$(basename "$file_path")
    local has_errors=0
    
    log_info "Validating: $file_name"
    
    # Check if file has breadcrumb
    if ! grep -q "^\[.*\](.*.md)" "$file_path" 2>/dev/null; then
        log_warning "No breadcrumb found in $file_name"
        return 1
    fi
    
    # Get breadcrumb line
    local breadcrumb
    breadcrumb=$(grep "^\[.*\](.*.md)" "$file_path" 2>/dev/null | head -1)
    
    # Count pipe separators
    local pipe_count
    pipe_count=$(echo "$breadcrumb" | grep -o "|" | wc -l)
    
    if [[ $pipe_count -lt 2 || $pipe_count -gt 3 ]]; then
        log_error "Invalid pipe count in $file_name (expected 2-3, got $pipe_count)"
        has_errors=1
    fi
    
    # Check for proper markdown link format
    if [[ ! "$breadcrumb" =~ ^\[.*\]\(.*\).*\[.*\]\(.*\).*\[.*\]\(.*\) ]]; then
        log_error "Invalid breadcrumb format in $file_name"
        has_errors=1
    fi
    
    # Check for broken links (simplified check)
    local links
    links=$(echo "$breadcrumb" | grep -o '(\([^)]*\)' | sed 's/[()]//g')
    
    for link in $links; do
        # Skip external links and anchors
        if [[ "$link" == http* || "$link" == "#"* ]]; then
            continue
        fi
        
        # Resolve relative path
        local dir_path=$(dirname "$file_path")
        local resolved_path="$dir_path/$link"
        
        if [[ ! -f "$resolved_path" ]]; then
            log_warning "Potential broken link in $file_name: $link"
        fi
    done
    
    if [[ $has_errors -eq 0 ]]; then
        log_success "Valid breadcrumb in $file_name"
    fi
    
    return $has_errors
}

# Main validation function
main() {
    local target="${1:-all}"
    local error_count=0
    local file_count=0
    
    log_info "Starting breadcrumb validation for: $target"
    
    # Find files based on target
    local files
    case "$target" in
        "all")
            files=$(find "$CLAUDE_ROOT" -name "*.md" -type f | grep -E "(commands|agents|docs)/" | sort)
            ;;
        "commands")
            files=$(find "$CLAUDE_ROOT/commands" -name "*.md" -type f | sort)
            ;;
        "agents")
            files=$(find "$CLAUDE_ROOT/agents" -name "*.md" -type f | sort)
            ;;
        "docs")
            files=$(find "$CLAUDE_ROOT/docs" -name "*.md" -type f | sort)
            ;;
        *)
            log_error "Unknown target: $target"
            exit 1
            ;;
    esac
    
    # Validate each file
    for file_path in $files; do
        if [[ -f "$file_path" ]]; then
            ((file_count++))
            if ! validate_file_breadcrumb "$file_path"; then
                ((error_count++))
            fi
        fi
    done
    
    echo ""
    log_info "Validation Summary:"
    echo "  Files checked: $file_count"
    echo "  Files with errors: $error_count"
    echo "  Success rate: $(( (file_count - error_count) * 100 / file_count ))%"
    
    if [[ $error_count -eq 0 ]]; then
        log_success "All breadcrumbs are valid!"
        exit 0
    else
        log_error "Found $error_count files with breadcrumb issues"
        exit 1
    fi
}

# Execute main function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi