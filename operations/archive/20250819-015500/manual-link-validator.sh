#!/bin/bash

# Manual Link Validator - Comprehensive Testing
# DevOps Engineer Agent - Progressive Thinking Implementation

set -euo pipefail

REPO_ROOT="/Users/nalve/.claude"
REPORT_DIR="/Users/nalve/.claude/operations/20250819-015500"
TEMP_FILE="/tmp/link-validation-$$"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counters
TOTAL_FILES=0
TOTAL_LINKS=0
BROKEN_LINKS=0
VALID_LINKS=0

# Arrays for results
declare -a BROKEN_LINKS_ARRAY=()
declare -a LINK_PATTERNS=()

log() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')] $1${NC}"
}

log_error() {
    echo -e "${RED}[$(date '+%H:%M:%S')] ✗ $1${NC}"
}

log_success() {
    echo -e "${GREEN}[$(date '+%H:%M:%S')] ✓ $1${NC}"
}

# Extract markdown links from a file
extract_links() {
    local file="$1"
    local base_dir="$(dirname "$file")"
    
    # Use grep to find markdown links - more reliable
    grep -oE '\[[^\]]*\]\([^)]+\)' "$file" 2>/dev/null | \
    grep -v -E '\]\(https?://' | \
    sed -E 's/\[([^\]]*)\]\(([^)]+)\)/\2/' | \
    while read -r link; do
        # Clean the link (remove anchors)
        local clean_link="${link%#*}"
        [[ -n "$clean_link" ]] && echo "$base_dir|$clean_link|$link"
    done
}

# Resolve relative path
resolve_path() {
    local base_dir="$1"
    local link_path="$2"
    
    case "$link_path" in
        /*) 
            echo "$REPO_ROOT${link_path}"
            ;;
        ./*) 
            echo "$base_dir/${link_path#./}"
            ;;
        ../*)
            (cd "$base_dir" && realpath "$link_path" 2>/dev/null || echo "")
            ;;
        *)
            echo "$base_dir/$link_path"
            ;;
    esac
}

# Validate a single link
validate_link() {
    local source_file="$1"
    local base_dir="$2" 
    local clean_link="$3"
    local full_link="$4"
    
    local resolved_path
    resolved_path=$(resolve_path "$base_dir" "$clean_link")
    
    if [[ -z "$resolved_path" ]]; then
        BROKEN_LINKS=$((BROKEN_LINKS + 1))
        BROKEN_LINKS_ARRAY+=("$source_file|$full_link|Path resolution failed")
        return 1
    fi
    
    if [[ -f "$resolved_path" ]]; then
        VALID_LINKS=$((VALID_LINKS + 1))
        return 0
    else
        # Look for suggestions
        local basename_file="$(basename "$resolved_path")"
        local suggestions=""
        
        # Find similar files in commands directory
        if [[ "$clean_link" == *".md" ]]; then
            local found_files
            found_files=$(find "$REPO_ROOT" -name "$basename_file" -type f 2>/dev/null | head -3)
            if [[ -n "$found_files" ]]; then
                suggestions="Found alternatives: $(echo "$found_files" | sed "s|$REPO_ROOT/||g" | tr '\n' ' ')"
            fi
        fi
        
        BROKEN_LINKS=$((BROKEN_LINKS + 1))
        BROKEN_LINKS_ARRAY+=("$source_file|$full_link|File not found: $resolved_path | $suggestions")
        return 1
    fi
}

# Main scanning function
scan_all_files() {
    log "Starting comprehensive link validation..."
    log "Scanning repository: $REPO_ROOT"
    
    # Find all markdown files
    local md_files
    md_files=$(find "$REPO_ROOT" -name "*.md" -type f \
        ! -path "*/node_modules/*" \
        ! -path "*/.git/*" \
        ! -path "*/vendor/*" \
        2>/dev/null)
    
    TOTAL_FILES=$(echo "$md_files" | wc -l | tr -d ' ')
    log "Found $TOTAL_FILES markdown files to scan"
    
    # Process each file
    local counter=0
    while IFS= read -r file; do
        [[ -n "$file" ]] || continue
        
        counter=$((counter + 1))
        if [[ $((counter % 100)) -eq 0 ]]; then
            log "Progress: $counter/$TOTAL_FILES files processed..."
        fi
        
        # Extract and validate links
        local links
        links=$(extract_links "$file")
        
        if [[ -n "$links" ]]; then
            while IFS='|' read -r base_dir clean_link full_link; do
                [[ -n "$clean_link" ]] || continue
                
                TOTAL_LINKS=$((TOTAL_LINKS + 1))
                
                # Track link patterns
                LINK_PATTERNS+=("$clean_link")
                
                # Validate the link
                if ! validate_link "$file" "$base_dir" "$clean_link" "$full_link"; then
                    echo "BROKEN: $file -> $clean_link" >> "$TEMP_FILE"
                fi
                
            done <<< "$links"
        fi
        
    done <<< "$md_files"
}

# Generate comprehensive report
generate_report() {
    local report_file="$REPORT_DIR/link-validation-results.txt"
    
    cat > "$report_file" << EOF
================================================================================
CLAUDE CODE FRAMEWORK - COMPREHENSIVE LINK VALIDATION REPORT
================================================================================

EXECUTION DETAILS:
- Generated: $(date)
- Validator: DevOps Engineer Agent
- Repository: Claude Code Framework
- Progressive Thinking Applied: Think → Think Hard → Think Harder → UltraThink

VALIDATION STATISTICS:
- Total Files Scanned: $TOTAL_FILES
- Total Internal Links Found: $TOTAL_LINKS  
- Valid Links: $VALID_LINKS
- Broken Links: $BROKEN_LINKS
- Success Rate: $(if [[ $TOTAL_LINKS -gt 0 ]]; then echo $(( (VALID_LINKS * 100) / TOTAL_LINKS )); else echo 0; fi)%

STATUS OVERVIEW:
EOF

    if [[ $BROKEN_LINKS -eq 0 ]]; then
        cat >> "$report_file" << EOF
✅ ALL LINKS VALID - Framework integrity maintained after three-tier reorganization
EOF
    else
        cat >> "$report_file" << EOF
⚠️  BROKEN LINKS DETECTED - $BROKEN_LINKS links require attention

BROKEN LINK DETAILS:
================================================================================

EOF
        
        local counter=1
        for broken_link in "${BROKEN_LINKS_ARRAY[@]}"; do
            IFS='|' read -r source_file link_text details <<< "$broken_link"
            
            cat >> "$report_file" << EOF
[$counter] $(basename "$source_file")
    Source: $source_file
    Link: $link_text  
    Issue: $details

EOF
            counter=$((counter + 1))
        done
        
        # Analyze patterns
        cat >> "$report_file" << EOF

PATTERN ANALYSIS:
================================================================================

EOF
        
        # Most common broken link patterns
        if [[ -f "$TEMP_FILE" ]]; then
            cat >> "$report_file" << EOF
Common broken link patterns:
$(cat "$TEMP_FILE" | cut -d' ' -f3- | sort | uniq -c | sort -nr | head -10)

EOF
        fi
    fi
    
    cat >> "$report_file" << EOF

FIX RECOMMENDATIONS:
================================================================================

1. UPDATE COMMAND STRUCTURE REFERENCES
   - Many links may point to old commands/ structure
   - Update to new three-tier organization (foundation/domains/compositions)

2. BATCH LINK CORRECTIONS
   - Use find-and-replace for common patterns
   - Update relative path references

3. VALIDATION INTEGRATION
   - Add link validation to CI/CD pipeline
   - Implement pre-commit hooks for link checking

4. DOCUMENTATION UPDATES
   - Update navigation references
   - Correct cross-references between documents

EXECUTION COMPLETED: $(date)
================================================================================
EOF

    log_success "Comprehensive report generated: $report_file"
}

# Main execution
main() {
    log "=== MANUAL LINK VALIDATION - PROGRESSIVE THINKING MODE ==="
    
    # Phase 1: Scan repository
    scan_all_files
    
    # Phase 2: Generate comprehensive report
    generate_report
    
    # Phase 3: Final summary
    echo ""
    echo "================== VALIDATION COMPLETE =================="
    log_success "Files scanned: $TOTAL_FILES"
    log_success "Links found: $TOTAL_LINKS"
    log_success "Valid links: $VALID_LINKS"
    
    if [[ $BROKEN_LINKS -gt 0 ]]; then
        log_error "Broken links: $BROKEN_LINKS"
        echo ""
        log "📋 Full report: $REPORT_DIR/link-validation-results.txt"
        exit 1
    else
        log_success "All links are valid! ✅"
        exit 0
    fi
}

# Cleanup
trap 'rm -f "$TEMP_FILE"' EXIT

# Execute
main "$@"