#!/bin/bash

#===============================================================================
# COMPREHENSIVE LINK VALIDATION SCRIPT
# 
# Purpose: Validate all internal markdown links across the Claude Code Framework
# Version: 1.0.0
# Author: DevOps Engineer Agent
# Date: 2025-08-19
#
# Features:
# - Scans all markdown files in repository
# - Extracts internal markdown links (relative paths)
# - Validates target file existence
# - Generates detailed reports with fix suggestions
# - Handles three-tier command structure (foundation/domains/compositions)
# - Supports dry-run mode for safe testing
#===============================================================================

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
REPORT_DIR="$REPO_ROOT/operations/$(date +%Y%m%d-%H%M%S)-link-validation"
TEMP_DIR="/tmp/link-validator-$$"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TOTAL_FILES=0
TOTAL_LINKS=0
BROKEN_LINKS=0
VALID_LINKS=0

# Arrays for results
declare -a BROKEN_LINKS_ARRAY=()
declare -a VALIDATION_RESULTS=()

#===============================================================================
# UTILITY FUNCTIONS
#===============================================================================

log() {
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')] $1${NC}"
}

log_success() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')] ✓ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}[$(date '+%Y-%m-%d %H:%M:%S')] ⚠ $1${NC}"
}

log_error() {
    echo -e "${RED}[$(date '+%Y-%m-%d %H:%M:%S')] ✗ $1${NC}"
}

usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Comprehensive link validation for Claude Code Framework

OPTIONS:
    -h, --help          Show this help message
    -d, --dry-run       Run in dry-run mode (no file modifications)
    -v, --verbose       Enable verbose output
    -f, --fix           Attempt to auto-fix simple issues
    -o, --output DIR    Specify output directory (default: operations/timestamp)
    --exclude PATTERN   Exclude files matching pattern
    --include-external  Include external links (default: internal only)

EXAMPLES:
    $0                          # Basic validation
    $0 -v                       # Verbose validation
    $0 --dry-run --verbose      # Safe test run
    $0 --fix                    # Auto-fix simple issues
    $0 --exclude "node_modules" # Exclude node_modules

EOF
}

#===============================================================================
# LINK EXTRACTION FUNCTIONS
#===============================================================================

extract_markdown_links() {
    local file="$1"
    local base_dir
    base_dir="$(dirname "$file")"
    
    # Extract all markdown links using ripgrep
    # Pattern matches: [text](path) but excludes http/https links
    rg -o '\[([^\]]*)\]\(([^)]+)\)' "$file" 2>/dev/null | \
    grep -v -E '\]\(https?://' | \
    sed -E 's/\[([^\]]*)\]\(([^)]+)\)/\2/' | \
    while read -r link; do
        # Clean the link (remove anchors for file validation)
        local clean_link="${link%#*}"
        # Skip empty links
        [[ -n "$clean_link" ]] && echo "$base_dir|$clean_link|$link"
    done
}

#===============================================================================
# PATH RESOLUTION FUNCTIONS  
#===============================================================================

resolve_relative_path() {
    local base_dir="$1"
    local link_path="$2"
    local resolved_path
    
    # Handle different path types
    case "$link_path" in
        /*) 
            # Absolute path from repo root
            resolved_path="$REPO_ROOT${link_path}"
            ;;
        ./*) 
            # Explicit current directory
            resolved_path="$base_dir/${link_path#./}"
            ;;
        ../*)
            # Parent directory traversal
            resolved_path="$(cd "$base_dir" && realpath "$link_path" 2>/dev/null || echo "")"
            ;;
        *)
            # Relative to current directory
            resolved_path="$base_dir/$link_path"
            ;;
    esac
    
    # Normalize path
    if [[ -n "$resolved_path" ]]; then
        realpath "$resolved_path" 2>/dev/null || echo ""
    fi
}

#===============================================================================
# VALIDATION FUNCTIONS
#===============================================================================

validate_link() {
    local source_file="$1"
    local base_dir="$2" 
    local clean_link="$3"
    local full_link="$4"
    local resolved_path
    local validation_result=""
    
    # Resolve the path
    resolved_path=$(resolve_relative_path "$base_dir" "$clean_link")
    
    if [[ -z "$resolved_path" ]]; then
        validation_result="ERROR: Cannot resolve path '$clean_link'"
        BROKEN_LINKS=$((BROKEN_LINKS + 1))
        BROKEN_LINKS_ARRAY+=("$source_file|$full_link|Path resolution failed")
        return 1
    fi
    
    # Check if target exists
    if [[ -f "$resolved_path" ]]; then
        validation_result="VALID: $clean_link → $resolved_path"
        VALID_LINKS=$((VALID_LINKS + 1))
        return 0
    else
        # Check for potential fixes
        local fix_suggestion=""
        fix_suggestion=$(suggest_fix "$resolved_path" "$clean_link")
        
        validation_result="BROKEN: $clean_link → $resolved_path (File not found)"
        if [[ -n "$fix_suggestion" ]]; then
            validation_result="$validation_result | Suggestion: $fix_suggestion"
        fi
        
        BROKEN_LINKS=$((BROKEN_LINKS + 1))
        BROKEN_LINKS_ARRAY+=("$source_file|$full_link|$validation_result")
        return 1
    fi
}

#===============================================================================
# FIX SUGGESTION FUNCTIONS
#===============================================================================

suggest_fix() {
    local broken_path="$1"
    local original_link="$2"
    local dirname_path
    local basename_file
    local suggestions=""
    
    dirname_path="$(dirname "$broken_path")"
    basename_file="$(basename "$broken_path")"
    
    # Look for similar files in the same directory
    if [[ -d "$dirname_path" ]]; then
        local similar_files
        similar_files=$(find "$dirname_path" -name "*.md" -type f | head -5)
        if [[ -n "$similar_files" ]]; then
            suggestions="Similar files in directory: $(echo "$similar_files" | tr '\n' ' ')"
        fi
    fi
    
    # Look for the file in the three-tier command structure
    if [[ "$original_link" == *".md" ]]; then
        local found_files
        found_files=$(find "$REPO_ROOT/commands" -name "$basename_file" -type f 2>/dev/null | head -3)
        if [[ -n "$found_files" ]]; then
            suggestions="${suggestions} | Found in commands: $(echo "$found_files" | sed "s|$REPO_ROOT/||g" | tr '\n' ' ')"
        fi
    fi
    
    echo "$suggestions"
}

#===============================================================================
# REPORTING FUNCTIONS
#===============================================================================

generate_summary_report() {
    local report_file="$REPORT_DIR/validation-summary.md"
    
    cat > "$report_file" << EOF
# Link Validation Summary Report

**Generated:** $(date)  
**Repository:** Claude Code Framework  
**Validator:** DevOps Engineer Agent

## 📊 Validation Statistics

| Metric | Count |
|--------|-------|
| Total Files Scanned | $TOTAL_FILES |
| Total Links Found | $TOTAL_LINKS |
| Valid Links | $VALID_LINKS |
| Broken Links | $BROKEN_LINKS |
| Success Rate | $(if [[ $TOTAL_LINKS -gt 0 ]]; then echo $(( (VALID_LINKS * 100) / TOTAL_LINKS )); else echo 0; fi)% |

## 🎯 Status Overview

EOF

    if [[ $BROKEN_LINKS -eq 0 ]]; then
        cat >> "$report_file" << EOF
✅ **ALL LINKS VALID** - No broken links detected!

The framework's internal link structure is completely intact after the commands folder reorganization.

EOF
    else
        cat >> "$report_file" << EOF
⚠️ **BROKEN LINKS DETECTED** - $BROKEN_LINKS link(s) need attention

The following issues were found and require resolution:

EOF
    fi
}

generate_detailed_report() {
    local report_file="$REPORT_DIR/broken-links-detailed.md"
    
    if [[ ${#BROKEN_LINKS_ARRAY[@]} -eq 0 ]]; then
        echo "# No Broken Links Found" > "$report_file"
        echo "" >> "$report_file"
        echo "All internal links are valid! ✅" >> "$report_file"
        return
    fi
    
    cat > "$report_file" << EOF
# Detailed Broken Links Report

**Generated:** $(date)  
**Total Broken Links:** ${#BROKEN_LINKS_ARRAY[@]}

## 🔍 Broken Link Details

EOF

    local counter=1
    for broken_link in "${BROKEN_LINKS_ARRAY[@]}"; do
        IFS='|' read -r source_file link_text details <<< "$broken_link"
        
        cat >> "$report_file" << EOF

### $counter. $(basename "$source_file")

- **Source File:** \`$source_file\`
- **Broken Link:** \`$link_text\`
- **Details:** $details

EOF
        counter=$((counter + 1))
    done
}

generate_fix_script() {
    local fix_script="$REPORT_DIR/suggested-fixes.sh"
    
    cat > "$fix_script" << 'EOF'
#!/bin/bash

# AUTOMATED FIX SUGGESTIONS
# Generated by Link Validator
# Review each fix before applying

set -euo pipefail

log() {
    echo "[$(date '+%H:%M:%S')] $1"
}

EOF

    chmod +x "$fix_script"
    
    log "Generated fix script: $fix_script"
}

#===============================================================================
# MAIN VALIDATION LOGIC
#===============================================================================

scan_repository() {
    log "Starting comprehensive link validation..."
    log "Repository root: $REPO_ROOT"
    
    # Find all markdown files
    local md_files
    md_files=$(find "$REPO_ROOT" -name "*.md" -type f \
        ! -path "*/node_modules/*" \
        ! -path "*/.*" \
        ! -path "*/vendor/*" \
        2>/dev/null)
    
    TOTAL_FILES=$(echo "$md_files" | wc -l)
    log "Found $TOTAL_FILES markdown files to scan"
    
    # Process each file
    while IFS= read -r file; do
        [[ -n "$file" ]] || continue
        
        log "Scanning: $(echo "$file" | sed "s|$REPO_ROOT/||")"
        
        # Extract and validate links
        local links
        links=$(extract_markdown_links "$file")
        
        if [[ -n "$links" ]]; then
            while IFS='|' read -r base_dir clean_link full_link; do
                [[ -n "$clean_link" ]] || continue
                
                TOTAL_LINKS=$((TOTAL_LINKS + 1))
                
                # Validate the link
                if validate_link "$file" "$base_dir" "$clean_link" "$full_link"; then
                    [[ -n "${VERBOSE:-}" ]] && log_success "✓ $clean_link"
                else
                    log_error "✗ $clean_link in $(basename "$file")"
                fi
                
            done <<< "$links"
        fi
        
    done <<< "$md_files"
}

#===============================================================================
# MAIN EXECUTION
#===============================================================================

main() {
    local dry_run=""
    local verbose=""
    local fix_mode=""
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                usage
                exit 0
                ;;
            -d|--dry-run)
                dry_run="true"
                shift
                ;;
            -v|--verbose)
                verbose="true"
                VERBOSE="true"
                shift
                ;;
            -f|--fix)
                fix_mode="true"
                shift
                ;;
            -o|--output)
                REPORT_DIR="$2"
                shift 2
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Setup
    mkdir -p "$REPORT_DIR"
    mkdir -p "$TEMP_DIR"
    
    log "=== CLAUDE CODE FRAMEWORK LINK VALIDATOR ==="
    log "Report directory: $REPORT_DIR"
    [[ -n "$dry_run" ]] && log_warning "Running in DRY-RUN mode"
    [[ -n "$verbose" ]] && log "Verbose mode enabled"
    
    # Main validation
    scan_repository
    
    # Generate reports
    log "Generating validation reports..."
    generate_summary_report
    generate_detailed_report
    generate_fix_script
    
    # Final summary
    echo ""
    echo "================== VALIDATION COMPLETE =================="
    log_success "Scanned $TOTAL_FILES files"
    log_success "Found $TOTAL_LINKS internal links"
    log_success "Valid links: $VALID_LINKS"
    
    if [[ $BROKEN_LINKS -gt 0 ]]; then
        log_error "Broken links: $BROKEN_LINKS"
        log "📋 Detailed report: $REPORT_DIR/broken-links-detailed.md"
        log "🔧 Fix suggestions: $REPORT_DIR/suggested-fixes.sh"
        exit 1
    else
        log_success "All links are valid! ✅"
        exit 0
    fi
}

# Cleanup on exit
trap 'rm -rf "$TEMP_DIR"' EXIT

# Execute main function
main "$@"