#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - NAVIGATION PATTERN VALIDATOR
#======================================================================
# Purpose: Validates navigation patterns including breadcrumbs and return-to-top
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Rules Validated: NP-001 through NP-004, RT-001 through RT-004, BC-001 through BC-004
# Target: 80% navigation pattern compliance
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/navigation-validator-$TIMESTAMP.log"

#======================================================================
# NAVIGATION VALIDATION RULES
#======================================================================

# Navigation Philosophy Standards (NP-001 through NP-004)
declare -A NAV_PHILOSOPHY=(
    ["NP-001"]="Predictable navigation patterns across all documentation"
    ["NP-002"]="Clear destination and purpose indication in all links"
    ["NP-003"]="Minimal cognitive load navigation design"
    ["NP-004"]="Context-aware navigation adaptation"
)

# Return-to-Top Standards (RT-001 through RT-004)
declare -A RETURN_TO_TOP_RULES=(
    ["RT-001"]="Format: [⬆ Return to top](#document-anchor)"
    ["RT-002"]="Placement at end of major sections in long documents (>500 lines)"
    ["RT-003"]="Unicode arrow (⬆) + consistent text + anchor link"
    ["RT-004"]="Proper anchor link functionality"
)

# Breadcrumb Standards (BC-001 through BC-004)
declare -A BREADCRUMB_RULES=(
    ["BC-001"]="Variable-based navigation templates"
    ["BC-002"]="Context-aware hub references"
    ["BC-003"]="Automated breadcrumb validation"
    ["BC-004"]="Consistent breadcrumb format across file types"
)

# Pattern definitions
readonly RETURN_TO_TOP_PATTERN='\[⬆[[:space:]]*Return[[:space:]]*to[[:space:]]*top\]\(#[a-zA-Z0-9-_]+\)'
readonly BREADCRUMB_PATTERN='\[[^]]*\]\([^)]*\)[[:space:]]*\|[[:space:]]*\[[^]]*\]\([^)]*\)'
readonly TOC_PATTERN='^##?[[:space:]]*Table[[:space:]]*of[[:space:]]*Contents'

# File size thresholds
readonly LONG_DOCUMENT_LINES=500
readonly SECTION_THRESHOLD_LINES=100

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A METRICS=(
    ["total_files"]=0
    ["long_documents"]=0
    ["files_with_breadcrumbs"]=0
    ["files_with_return_to_top"]=0
    ["files_with_toc"]=0
    ["breadcrumb_compliant"]=0
    ["return_to_top_compliant"]=0
    ["navigation_violations"]=0
    ["correctable_navigation"]=0
)

declare -a NAVIGATION_VIOLATIONS=()
declare -a NAVIGATION_CORRECTIONS=()

#======================================================================
# DOCUMENT ANALYSIS FUNCTIONS
#======================================================================
count_file_lines() {
    local file_path="$1"
    wc -l < "$file_path" 2>/dev/null || echo "0"
}

extract_headings() {
    local file_path="$1"
    local temp_headings=$(mktemp)
    
    grep -n '^#\+[[:space:]]' "$file_path" | while IFS=: read -r line_num heading; do
        local level
        level=$(echo "$heading" | grep -o '^#\+' | wc -c)
        level=$((level - 1))
        
        local title
        title=$(echo "$heading" | sed 's/^#\+[[:space:]]*//')
        
        echo "$line_num:$level:$title"
    done > "$temp_headings"
    
    echo "$temp_headings"
}

find_major_sections() {
    local headings_file="$1"
    local major_sections=()
    
    # Find H1 and H2 headings as major sections
    while IFS=: read -r line_num level title; do
        if [[ $level -le 2 ]]; then
            major_sections+=("$line_num")
        fi
    done < "$headings_file"
    
    printf '%s\n' "${major_sections[@]}"
}

#======================================================================
# BREADCRUMB VALIDATION
#======================================================================
validate_breadcrumbs() {
    local file_path="$1"
    local violations=()
    
    # Look for breadcrumb pattern in first 10 lines
    local breadcrumb_line
    breadcrumb_line=$(head -10 "$file_path" | grep -n "$BREADCRUMB_PATTERN" | head -1)
    
    if [[ -z "$breadcrumb_line" ]]; then
        # Check if file should have breadcrumbs based on location
        local relative_path="${file_path#$PROJECT_ROOT/}"
        
        case "$relative_path" in
            docs/*|commands/*|agents/*|planning/*)
                violations+=("BC-001: Missing breadcrumb navigation")
                violations+=("BC-002: No context-aware hub reference found")
                return 1
                ;;
        esac
    else
        # Validate breadcrumb format
        local line_num="${breadcrumb_line%%:*}"
        local content="${breadcrumb_line#*:}"
        
        # Check for consistent format
        if [[ ! "$content" =~ \| ]]; then
            violations+=("BC-004: Breadcrumb format inconsistent (missing separators)")
        fi
        
        # Check for hub references
        if [[ ! "$content" =~ (Hub|Index|Home) ]]; then
            violations+=("BC-002: Missing context-aware hub reference")
        fi
    fi
    
    if [[ ${#violations[@]} -gt 0 ]]; then
        NAVIGATION_VIOLATIONS+=("$file_path: Breadcrumb violations: ${violations[*]}")
        return 1
    fi
    
    return 0
}

#======================================================================
# RETURN-TO-TOP VALIDATION
#======================================================================
validate_return_to_top() {
    local file_path="$1"
    local file_lines
    file_lines=$(count_file_lines "$file_path")
    local violations=()
    
    # Check if document qualifies for return-to-top links
    if [[ $file_lines -lt $LONG_DOCUMENT_LINES ]]; then
        return 0  # Short documents don't need return-to-top
    fi
    
    METRICS["long_documents"]=$((METRICS["long_documents"] + 1))
    
    # Find return-to-top links
    local return_to_top_count
    return_to_top_count=$(grep -c "$RETURN_TO_TOP_PATTERN" "$file_path" 2>/dev/null || echo "0")
    
    if [[ $return_to_top_count -eq 0 ]]; then
        violations+=("RT-002: Missing return-to-top links in long document (${file_lines} lines)")
        violations+=("RT-001: No return-to-top format found")
        
        # Generate correction suggestion
        NAVIGATION_CORRECTIONS+=("$file_path:ADD_RETURN_TO_TOP:$file_lines")
        METRICS["correctable_navigation"]=$((METRICS["correctable_navigation"] + 1))
        
    else
        # Validate return-to-top format and placement
        local headings_file
        headings_file=$(extract_headings "$file_path")
        
        local major_sections
        readarray -t major_sections < <(find_major_sections "$headings_file")
        
        # Check if return-to-top appears after major sections
        local expected_return_to_top_count=${#major_sections[@]}
        
        if [[ $return_to_top_count -lt $expected_return_to_top_count ]]; then
            violations+=("RT-002: Insufficient return-to-top links for document structure")
        fi
        
        # Validate format of existing return-to-top links
        while IFS=: read -r line_num content; do
            # Check Unicode arrow
            if [[ ! "$content" =~ ⬆ ]]; then
                violations+=("RT-003: Missing Unicode arrow (⬆)")
            fi
            
            # Check anchor functionality
            local anchor
            anchor=$(echo "$content" | grep -o '#[a-zA-Z0-9-_]*')
            
            if [[ -n "$anchor" ]]; then
                # Validate anchor exists in document
                if ! grep -q "^#.*${anchor##}" "$file_path" && \
                   ! grep -q "id=[\"']${anchor##}[\"']" "$file_path"; then
                    violations+=("RT-004: Return-to-top anchor '$anchor' not found in document")
                fi
            else
                violations+=("RT-001: Return-to-top missing proper anchor link")
            fi
            
        done < <(grep -n "$RETURN_TO_TOP_PATTERN" "$file_path")
        
        rm -f "$headings_file"
    fi
    
    if [[ ${#violations[@]} -gt 0 ]]; then
        NAVIGATION_VIOLATIONS+=("$file_path: Return-to-top violations: ${violations[*]}")
        return 1
    fi
    
    return 0
}

#======================================================================
# TABLE OF CONTENTS VALIDATION
#======================================================================
validate_table_of_contents() {
    local file_path="$1"
    local file_lines
    file_lines=$(count_file_lines "$file_path")
    local violations=()
    
    # Check if document should have TOC
    if [[ $file_lines -lt $LONG_DOCUMENT_LINES ]]; then
        return 0  # Short documents don't need TOC
    fi
    
    # Look for TOC
    local toc_line
    toc_line=$(grep -n "$TOC_PATTERN" "$file_path" | head -1)
    
    local headings_file
    headings_file=$(extract_headings "$file_path")
    local heading_count
    heading_count=$(wc -l < "$headings_file")
    
    # Documents with many headings should have TOC
    if [[ $heading_count -gt 10 ]] && [[ -z "$toc_line" ]]; then
        violations+=("TOC-001: Long document with many sections should have Table of Contents")
        NAVIGATION_CORRECTIONS+=("$file_path:ADD_TOC:$heading_count")
        METRICS["correctable_navigation"]=$((METRICS["correctable_navigation"] + 1))
    fi
    
    rm -f "$headings_file"
    
    if [[ ${#violations[@]} -gt 0 ]]; then
        NAVIGATION_VIOLATIONS+=("$file_path: TOC violations: ${violations[*]}")
        return 1
    fi
    
    return 0
}

#======================================================================
# NAVIGATION CONSISTENCY VALIDATION
#======================================================================
validate_navigation_consistency() {
    local file_path="$1"
    local violations=()
    
    # Check for consistent navigation patterns
    local relative_path="${file_path#$PROJECT_ROOT/}"
    
    # Validate context-aware navigation based on file location
    case "$relative_path" in
        docs/*)
            # Documentation should link back to main index
            if ! grep -q "docs/index\.md\|Framework Hub\|Documentation Index" "$file_path"; then
                violations+=("NP-004: Documentation file missing context navigation to docs hub")
            fi
            ;;
        commands/*)
            # Commands should link to commands index
            if ! grep -q "commands/index\.md\|Commands Index\|Command Hub" "$file_path"; then
                violations+=("NP-004: Command file missing context navigation to commands hub")
            fi
            ;;
        agents/*)
            # Agents should link to agents index
            if ! grep -q "agents/.*index\.md\|Agents.*Index\|Agent Hub" "$file_path"; then
                violations+=("NP-004: Agent file missing context navigation to agents hub")
            fi
            ;;
    esac
    
    # Check for predictable navigation patterns
    local link_count
    link_count=$(grep -c '\[.*\](.*\.md)' "$file_path" 2>/dev/null || echo "0")
    
    if [[ $link_count -gt 0 ]]; then
        # Validate that links follow consistent patterns
        local inconsistent_links
        inconsistent_links=$(grep -o '\[.*\](.*\.md)' "$file_path" | grep -v '^[A-Z][a-z]*:' | wc -l)
        
        if [[ $inconsistent_links -gt 0 ]]; then
            violations+=("NP-002: Some links missing clear destination/purpose indication")
        fi
    fi
    
    if [[ ${#violations[@]} -gt 0 ]]; then
        NAVIGATION_VIOLATIONS+=("$file_path: Navigation consistency violations: ${violations[*]}")
        return 1
    fi
    
    return 0
}

#======================================================================
# FILE VALIDATION ENGINE
#======================================================================
validate_file_navigation() {
    local file_path="$1"
    local has_violations=false
    
    # Validate breadcrumbs
    if ! validate_breadcrumbs "$file_path"; then
        has_violations=true
    else
        METRICS["breadcrumb_compliant"]=$((METRICS["breadcrumb_compliant"] + 1))
    fi
    
    # Check if file has breadcrumbs
    if head -10 "$file_path" | grep -q "$BREADCRUMB_PATTERN"; then
        METRICS["files_with_breadcrumbs"]=$((METRICS["files_with_breadcrumbs"] + 1))
    fi
    
    # Validate return-to-top
    if ! validate_return_to_top "$file_path"; then
        has_violations=true
    else
        METRICS["return_to_top_compliant"]=$((METRICS["return_to_top_compliant"] + 1))
    fi
    
    # Check if file has return-to-top
    if grep -q "$RETURN_TO_TOP_PATTERN" "$file_path"; then
        METRICS["files_with_return_to_top"]=$((METRICS["files_with_return_to_top"] + 1))
    fi
    
    # Validate table of contents
    if ! validate_table_of_contents "$file_path"; then
        has_violations=true
    fi
    
    # Check if file has TOC
    if grep -q "$TOC_PATTERN" "$file_path"; then
        METRICS["files_with_toc"]=$((METRICS["files_with_toc"] + 1))
    fi
    
    # Validate navigation consistency
    if ! validate_navigation_consistency "$file_path"; then
        has_violations=true
    fi
    
    if [[ "$has_violations" == "true" ]]; then
        METRICS["navigation_violations"]=$((METRICS["navigation_violations"] + 1))
        return 1
    fi
    
    return 0
}

validate_all_files() {
    log "Starting navigation pattern validation..."
    
    # Find all markdown files
    local temp_file_list=$(mktemp)
    find "$PROJECT_ROOT" -name "*.md" -type f \
        ! -path "*/.git/*" \
        ! -path "*/node_modules/*" \
        ! -path "*/.DS_Store*" \
        ! -path "*/ide/*" \
        ! -path "*/statsig/*" \
        ! -path "*/backups/*" \
        > "$temp_file_list"
    
    local total_files
    total_files=$(wc -l < "$temp_file_list")
    METRICS["total_files"]=$total_files
    
    log "Found $total_files markdown files to validate"
    
    local progress_count=0
    while IFS= read -r file_path; do
        progress_count=$((progress_count + 1))
        
        if [[ $((progress_count % 50)) -eq 0 ]]; then
            log "Progress: $progress_count/$total_files files processed"
        fi
        
        validate_file_navigation "$file_path"
        
    done < "$temp_file_list"
    
    rm "$temp_file_list"
    log "Navigation pattern validation completed"
}

#======================================================================
# CORRECTION APPLICATION
#======================================================================
apply_navigation_corrections() {
    log "Applying navigation corrections..."
    
    local corrections_applied=0
    local corrections_failed=0
    
    for correction in "${NAVIGATION_CORRECTIONS[@]}"; do
        local file_path="${correction%%:*}"
        local correction_type="${correction#*:}"
        correction_type="${correction_type%%:*}"
        local correction_data="${correction##*:}"
        
        case "$correction_type" in
            "ADD_RETURN_TO_TOP")
                if add_return_to_top_links "$file_path"; then
                    log "✅ Added return-to-top links: $file_path"
                    corrections_applied=$((corrections_applied + 1))
                else
                    log "❌ Failed to add return-to-top links: $file_path"
                    corrections_failed=$((corrections_failed + 1))
                fi
                ;;
            "ADD_TOC")
                if add_table_of_contents "$file_path"; then
                    log "✅ Added table of contents: $file_path"
                    corrections_applied=$((corrections_applied + 1))
                else
                    log "❌ Failed to add table of contents: $file_path"
                    corrections_failed=$((corrections_failed + 1))
                fi
                ;;
        esac
    done
    
    log "Navigation corrections applied: $corrections_applied"
    log "Navigation corrections failed: $corrections_failed"
}

add_return_to_top_links() {
    local file_path="$1"
    local temp_file=$(mktemp)
    local backup_file="$file_path.backup-$TIMESTAMP"
    
    # Create backup
    cp "$file_path" "$backup_file"
    
    # Find major sections and add return-to-top after each
    local headings_file
    headings_file=$(extract_headings "$file_path")
    
    local major_sections
    readarray -t major_sections < <(find_major_sections "$headings_file")
    
    # Generate document anchor from filename
    local doc_anchor
    doc_anchor=$(basename "$file_path" .md | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    
    # Process file and insert return-to-top links
    local current_line=1
    local section_index=0
    
    while IFS= read -r line; do
        echo "$line" >> "$temp_file"
        
        # Check if this line matches a major section
        if [[ $section_index -lt ${#major_sections[@]} ]]; then
            local section_line="${major_sections[$section_index]}"
            
            if [[ $current_line -eq $section_line ]]; then
                # Add some content, then return-to-top
                local lines_to_section_end=$((current_line + SECTION_THRESHOLD_LINES))
                
                # Skip ahead and add return-to-top
                local skip_count=0
                while IFS= read -r next_line && [[ $skip_count -lt $SECTION_THRESHOLD_LINES ]]; do
                    echo "$next_line" >> "$temp_file"
                    skip_count=$((skip_count + 1))
                    current_line=$((current_line + 1))
                done
                
                # Add return-to-top
                echo "" >> "$temp_file"
                echo "[⬆ Return to top](#$doc_anchor)" >> "$temp_file"
                echo "" >> "$temp_file"
                
                section_index=$((section_index + 1))
            fi
        fi
        
        current_line=$((current_line + 1))
    done < "$file_path"
    
    rm -f "$headings_file"
    
    # Replace original file
    if mv "$temp_file" "$file_path"; then
        rm "$backup_file"
        return 0
    else
        mv "$backup_file" "$file_path"
        rm -f "$temp_file"
        return 1
    fi
}

add_table_of_contents() {
    local file_path="$1"
    local temp_file=$(mktemp)
    local backup_file="$file_path.backup-$TIMESTAMP"
    
    # Create backup
    cp "$file_path" "$backup_file"
    
    # Generate TOC from headings
    local headings_file
    headings_file=$(extract_headings "$file_path")
    
    # Find insertion point (after title and before first heading)
    local insert_line=1
    local found_title=false
    
    while IFS= read -r line; do
        if [[ "$line" =~ ^# ]] && [[ "$found_title" == "false" ]]; then
            found_title=true
            insert_line=$((insert_line + 2))  # After title + blank line
            break
        fi
        insert_line=$((insert_line + 1))
    done < "$file_path"
    
    # Generate TOC content
    local toc_content=$(mktemp)
    echo "## Table of Contents" > "$toc_content"
    echo "" >> "$toc_content"
    
    while IFS=: read -r line_num level title; do
        if [[ $level -le 3 ]]; then  # Only include H1, H2, H3
            local indent=""
            for ((i=1; i<level; i++)); do
                indent="  $indent"
            done
            
            local anchor
            anchor=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
            
            echo "$indent- [Navigate: $title](#$anchor)" >> "$toc_content"
        fi
    done < "$headings_file"
    
    echo "" >> "$toc_content"
    
    # Insert TOC into file
    {
        head -$((insert_line - 1)) "$file_path"
        cat "$toc_content"
        tail -n +$insert_line "$file_path"
    } > "$temp_file"
    
    rm -f "$headings_file" "$toc_content"
    
    # Replace original file
    if mv "$temp_file" "$file_path"; then
        rm "$backup_file"
        return 0
    else
        mv "$backup_file" "$file_path"
        rm -f "$temp_file"
        return 1
    fi
}

#======================================================================
# REPORTING AND OUTPUT
#======================================================================
generate_report() {
    log "=== NAVIGATION PATTERN VALIDATION REPORT ==="
    
    local total_files=${METRICS["total_files"]}
    local long_documents=${METRICS["long_documents"]}
    local files_with_breadcrumbs=${METRICS["files_with_breadcrumbs"]}
    local files_with_return_to_top=${METRICS["files_with_return_to_top"]}
    local files_with_toc=${METRICS["files_with_toc"]}
    local breadcrumb_compliant=${METRICS["breadcrumb_compliant"]}
    local return_to_top_compliant=${METRICS["return_to_top_compliant"]}
    local navigation_violations=${METRICS["navigation_violations"]}
    local correctable_navigation=${METRICS["correctable_navigation"]}
    
    # Calculate compliance score
    local compliance_score=0
    if [[ $total_files -gt 0 ]]; then
        local compliant_files=$((total_files - navigation_violations))
        compliance_score=$((compliant_files * 100 / total_files))
    fi
    
    log "Total Markdown Files: $total_files"
    log "Long Documents (>500 lines): $long_documents"
    log "Files with Breadcrumbs: $files_with_breadcrumbs"
    log "Files with Return-to-Top: $files_with_return_to_top"
    log "Files with Table of Contents: $files_with_toc"
    log "Breadcrumb Compliant: $breadcrumb_compliant"
    log "Return-to-Top Compliant: $return_to_top_compliant"
    log "Navigation Violations: $navigation_violations"
    log "Auto-Correctable Navigation: $correctable_navigation"
    log "Navigation Compliance Score: $compliance_score%"
    
    # Output compliance score for orchestrator
    echo "COMPLIANCE_SCORE:$compliance_score"
    
    if [[ ${#NAVIGATION_VIOLATIONS[@]} -gt 0 ]]; then
        log ""
        log "=== NAVIGATION VIOLATIONS ==="
        for violation in "${NAVIGATION_VIOLATIONS[@]}"; do
            log "❌ $violation"
        done
    fi
    
    if [[ ${#NAVIGATION_CORRECTIONS[@]} -gt 0 ]]; then
        log ""
        log "=== SUGGESTED CORRECTIONS ==="
        for correction in "${NAVIGATION_CORRECTIONS[@]}"; do
            log "🔧 $correction"
        done
        
        log ""
        log "To apply corrections automatically, run:"
        log "  $0 --fix"
    fi
    
    # Generate detailed JSON report
    local json_report="${LOG_FILE%.log}-report.json"
    cat > "$json_report" << EOF
{
  "timestamp": "$TIMESTAMP",
  "validator": "navigation-validator",
  "version": "1.0.0",
  "metrics": {
    "total_files": $total_files,
    "long_documents": $long_documents,
    "files_with_breadcrumbs": $files_with_breadcrumbs,
    "files_with_return_to_top": $files_with_return_to_top,
    "files_with_toc": $files_with_toc,
    "breadcrumb_compliant": $breadcrumb_compliant,
    "return_to_top_compliant": $return_to_top_compliant,
    "navigation_violations": $navigation_violations,
    "correctable_navigation": $correctable_navigation,
    "compliance_score": $compliance_score
  },
  "navigation_rules": {$(
    for rule in "${!NAV_PHILOSOPHY[@]}"; do
      echo "    \"$rule\": \"${NAV_PHILOSOPHY[$rule]}\","
    done
    for rule in "${!RETURN_TO_TOP_RULES[@]}"; do
      echo "    \"$rule\": \"${RETURN_TO_TOP_RULES[$rule]}\","
    done
    for rule in "${!BREADCRUMB_RULES[@]}"; do
      echo "    \"$rule\": \"${BREADCRUMB_RULES[$rule]}\","
    done | sed '$ s/,$//'
  )},
  "violations": [$(
    printf '%s\n' "${NAVIGATION_VIOLATIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )],
  "corrections": [$(
    printf '%s\n' "${NAVIGATION_CORRECTIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )]
}
EOF
    
    log "Detailed report saved: $json_report"
}

#======================================================================
# COMMAND LINE INTERFACE AND MAIN EXECUTION
#======================================================================
show_usage() {
    cat << EOF
Usage: $0 [PROJECT_ROOT] [OPTIONS]

Claude Code Framework Navigation Pattern Validator

VALIDATION RULES:
    Navigation Philosophy (NP-001 to NP-004): Predictable, clear, minimal cognitive load
    Return-to-Top (RT-001 to RT-004): Format, placement, Unicode arrow, anchor functionality
    Breadcrumbs (BC-001 to BC-004): Variable templates, context-aware, consistent format

TARGET: 80% navigation pattern compliance

OPTIONS:
    -h, --help      Show this help message
    --fix           Apply automatic corrections
    --dry-run       Show corrections without applying
    --report-only   Generate report only

EOF
}

main() {
    local fix_mode=false
    local dry_run=false
    local report_only=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help) show_usage; exit 0 ;;
            --fix) fix_mode=true; shift ;;
            --dry-run) dry_run=true; shift ;;
            --report-only) report_only=true; shift ;;
            *) if [[ -d "$1" ]]; then PROJECT_ROOT="$1"; else log "ERROR: Invalid argument: $1"; exit 1; fi; shift ;;
        esac
    done
    
    mkdir -p "$(dirname "$LOG_FILE")"
    log "Navigation Validator v1.0.0 started - Project Root: $PROJECT_ROOT"
    
    if [[ "$report_only" == "true" ]]; then
        generate_report; exit 0
    fi
    
    validate_all_files
    
    if [[ "$fix_mode" == "true" ]]; then
        if [[ "$dry_run" == "true" ]]; then
            log "DRY RUN: Would apply ${#NAVIGATION_CORRECTIONS[@]} navigation corrections"
        else
            apply_navigation_corrections
        fi
    fi
    
    generate_report
    
    local compliance_score=$((((METRICS["total_files"] - METRICS["navigation_violations"]) * 100) / METRICS["total_files"]))
    
    if [[ $compliance_score -ge 80 ]]; then
        log "✅ Navigation compliance achieved ($compliance_score% >= 80%)"
        exit 0
    else
        log "❌ Navigation compliance below target ($compliance_score% < 80%)"
        exit 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi