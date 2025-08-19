#!/bin/bash

# Return-to-Top Link Validation Script
# Validates consistent formatting and proper placement of return-to-top links
# Usage: ./validate-return-to-top.sh [file] or ./validate-return-to-top.sh --all

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Configuration
RETURN_TO_TOP_PATTERN='\[⬆ Return to top\]'
TEMP_REPORT="/tmp/return_to_top_validation.txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TOTAL_FILES=0
VALID_FILES=0
INVALID_FILES=0
TOTAL_ISSUES=0

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_issue() {
    echo -e "${BLUE}[ISSUE]${NC} $1"
    ((TOTAL_ISSUES++))
}

# Function to validate return-to-top format
validate_format() {
    local file="$1"
    local issues=()
    
    # Find all return-to-top links
    local return_links=$(grep -n "$RETURN_TO_TOP_PATTERN" "$file" 2>/dev/null || true)
    
    if [[ -z "$return_links" ]]; then
        return 0  # No links to validate
    fi
    
    while IFS= read -r line; do
        local line_num=$(echo "$line" | cut -d: -f1)
        local line_content=$(echo "$line" | cut -d: -f2-)
        
        # Check exact format: [⬆ Return to top](#anchor)
        if ! echo "$line_content" | grep -qE '^\[⬆ Return to top\]\(#[a-z0-9-]+\)$'; then
            issues+=("Line $line_num: Invalid format - '$line_content'")
        fi
        
        # Check for proper anchor format
        local anchor=$(echo "$line_content" | sed -n 's/.*(\(#[^)]*\)).*/\1/p')
        if [[ -n "$anchor" ]]; then
            if ! echo "$anchor" | grep -qE '^#[a-z0-9-]+$'; then
                issues+=("Line $line_num: Invalid anchor format - '$anchor'")
            fi
        fi
        
    done <<< "$return_links"
    
    # Print issues for this file
    if [[ ${#issues[@]} -gt 0 ]]; then
        log_error "Format issues in $(basename "$file"):"
        for issue in "${issues[@]}"; do
            log_issue "  $issue"
        done
        return 1
    fi
    
    return 0
}

# Function to validate return-to-top placement
validate_placement() {
    local file="$1"
    local issues=()
    
    # Get all return-to-top link line numbers
    local link_lines=$(grep -n "$RETURN_TO_TOP_PATTERN" "$file" 2>/dev/null | cut -d: -f1 || true)
    
    if [[ -z "$link_lines" ]]; then
        return 0  # No links to validate
    fi
    
    # Check each link's placement
    while IFS= read -r line_num; do
        [[ -z "$line_num" ]] && continue
        
        # Check if preceded by blank line
        local prev_line=$((line_num - 1))
        if [[ $prev_line -gt 0 ]]; then
            local prev_content=$(sed -n "${prev_line}p" "$file")
            if [[ -n "$prev_content" ]]; then
                issues+=("Line $line_num: Missing blank line before return-to-top link")
            fi
        fi
        
        # Check if followed by blank line (unless it's the last line)
        local total_lines=$(wc -l < "$file")
        local next_line=$((line_num + 1))
        if [[ $next_line -le $total_lines ]]; then
            local next_content=$(sed -n "${next_line}p" "$file")
            if [[ -n "$next_content" ]]; then
                issues+=("Line $line_num: Missing blank line after return-to-top link")
            fi
        fi
        
        # Check if placed at logical section breaks
        local context_start=$((line_num - 5 > 1 ? line_num - 5 : 1))
        local context_end=$((line_num + 5))
        local context=$(sed -n "${context_start},${context_end}p" "$file")
        
        # Should be near section headers or cross-references
        if ! echo "$context" | grep -qE "(^## |## Cross-References|## Related|## Integration)"; then
            issues+=("Line $line_num: Return-to-top link not at logical section break")
        fi
        
    done <<< "$link_lines"
    
    # Print placement issues
    if [[ ${#issues[@]} -gt 0 ]]; then
        log_error "Placement issues in $(basename "$file"):"
        for issue in "${issues[@]}"; do
            log_issue "  $issue"
        done
        return 1
    fi
    
    return 0
}

# Function to validate anchor targets
validate_anchors() {
    local file="$1"
    local issues=()
    
    # Get all return-to-top anchors
    local anchors=$(grep -o "$RETURN_TO_TOP_PATTERN(#[^)]*)" "$file" 2>/dev/null | sed 's/.*(\(#[^)]*\)).*/\1/' || true)
    
    if [[ -z "$anchors" ]]; then
        return 0  # No anchors to validate
    fi
    
    # Extract document title for expected anchor
    local title=$(grep -m 1 "^# " "$file" 2>/dev/null | sed 's/^# //' || true)
    local expected_anchor=""
    
    if [[ -n "$title" ]]; then
        expected_anchor="#$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g' | sed 's/ /-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')"
    fi
    
    # Check each anchor
    while IFS= read -r anchor; do
        [[ -z "$anchor" ]] && continue
        
        # Check if anchor matches expected document anchor
        if [[ -n "$expected_anchor" ]] && [[ "$anchor" != "$expected_anchor" ]]; then
            issues+=("Anchor '$anchor' doesn't match expected document anchor '$expected_anchor'")
        fi
        
        # Check if anchor exists as a heading in the document
        local anchor_text=$(echo "$anchor" | sed 's/^#//' | sed 's/-/ /g')
        if ! grep -qi "^# .*$anchor_text" "$file"; then
            # Try exact match with the heading format
            local heading_pattern="^# .*$(echo "$anchor_text" | sed 's/./[&]/g')"
            if ! grep -qiE "$heading_pattern" "$file"; then
                issues+=("Anchor '$anchor' has no corresponding heading in document")
            fi
        fi
        
    done <<< "$anchors"
    
    # Print anchor issues
    if [[ ${#issues[@]} -gt 0 ]]; then
        log_error "Anchor issues in $(basename "$file"):"
        for issue in "${issues[@]}"; do
            log_issue "  $issue"
        done
        return 1
    fi
    
    return 0
}

# Function to check for duplicate return-to-top links
validate_duplicates() {
    local file="$1"
    local issues=()
    
    # Count return-to-top links
    local link_count=$(grep -c "$RETURN_TO_TOP_PATTERN" "$file" 2>/dev/null || echo 0)
    
    if [[ $link_count -eq 0 ]]; then
        return 0  # No links to check
    fi
    
    # Get section count (H2 headers)
    local section_count=$(grep -c "^## " "$file" 2>/dev/null || echo 0)
    
    # Check for excessive links relative to content
    if [[ $link_count -gt $((section_count + 2)) ]]; then
        issues+=("Too many return-to-top links ($link_count) for content structure ($section_count sections)")
    fi
    
    # Check for links too close together
    local link_lines=$(grep -n "$RETURN_TO_TOP_PATTERN" "$file" 2>/dev/null | cut -d: -f1 || true)
    local prev_line=0
    
    while IFS= read -r line_num; do
        [[ -z "$line_num" ]] && continue
        
        if [[ $prev_line -gt 0 ]]; then
            local distance=$((line_num - prev_line))
            if [[ $distance -lt 20 ]]; then
                issues+=("Return-to-top links too close together (lines $prev_line and $line_num)")
            fi
        fi
        prev_line=$line_num
    done <<< "$link_lines"
    
    # Print duplicate issues
    if [[ ${#issues[@]} -gt 0 ]]; then
        log_error "Duplication issues in $(basename "$file"):"
        for issue in "${issues[@]}"; do
            log_issue "  $issue"
        done
        return 1
    fi
    
    return 0
}

# Function to validate a single file
validate_file() {
    local file="$1"
    local file_valid=true
    
    ((TOTAL_FILES++))
    
    log_info "Validating $(basename "$file")"
    
    # Run all validation checks
    if ! validate_format "$file"; then
        file_valid=false
    fi
    
    if ! validate_placement "$file"; then
        file_valid=false
    fi
    
    if ! validate_anchors "$file"; then
        file_valid=false
    fi
    
    if ! validate_duplicates "$file"; then
        file_valid=false
    fi
    
    # Update counters
    if [[ "$file_valid" == true ]]; then
        ((VALID_FILES++))
        log_info "✅ $(basename "$file") - All validations passed"
    else
        ((INVALID_FILES++))
        log_error "❌ $(basename "$file") - Validation failed"
    fi
    
    return $([[ "$file_valid" == true ]] && echo 0 || echo 1)
}

# Function to validate all markdown files
validate_all_files() {
    log_info "Validating all markdown files in project..."
    
    find "$PROJECT_ROOT" -name "*.md" -type f | while read -r file; do
        # Skip project files and temporary files
        if [[ "$file" =~ /projects/ ]] || [[ "$(basename "$file")" =~ ^temp- ]]; then
            continue
        fi
        
        validate_file "$file"
    done
    
    # Generate summary report
    generate_summary_report
}

# Function to generate summary report
generate_summary_report() {
    echo ""
    echo "============================================"
    echo "Return-to-Top Validation Summary Report"
    echo "============================================"
    echo "Total files validated: $TOTAL_FILES"
    echo "Valid files: $VALID_FILES"
    echo "Invalid files: $INVALID_FILES"
    echo "Total issues found: $TOTAL_ISSUES"
    echo ""
    
    if [[ $INVALID_FILES -eq 0 ]]; then
        log_info "🎉 All files passed validation!"
    else
        log_warn "⚠️  $INVALID_FILES files failed validation with $TOTAL_ISSUES total issues"
        echo ""
        echo "Run with specific file paths to see detailed issue reports."
    fi
    
    # Calculate success rate
    local success_rate=0
    if [[ $TOTAL_FILES -gt 0 ]]; then
        success_rate=$(( (VALID_FILES * 100) / TOTAL_FILES ))
    fi
    
    echo "Success rate: $success_rate%"
    echo "============================================"
}

# Main script logic
main() {
    if [[ $# -eq 0 ]] || [[ "$1" == "--help" ]]; then
        echo "Usage: $0 [file.md] | --all"
        echo "  file.md    Validate specific markdown file"
        echo "  --all      Validate all markdown files in project"
        echo "  --help     Show this help message"
        exit 0
    fi
    
    if [[ "$1" == "--all" ]]; then
        validate_all_files
    elif [[ -f "$1" ]]; then
        validate_file "$1"
    else
        log_error "File $1 not found"
        exit 1
    fi
    
    # Exit with error if any issues found
    if [[ $TOTAL_ISSUES -gt 0 ]]; then
        exit 1
    fi
}

# Run main function
main "$@"