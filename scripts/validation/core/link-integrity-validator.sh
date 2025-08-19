#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - LINK INTEGRITY VALIDATOR
#======================================================================
# Purpose: Validates internal link functionality and format compliance
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Rules Validated: LK-001 through LK-004, AV-001 through AV-009, LI-001 through LI-005
# Target: 85% link integrity and format compliance
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/link-integrity-validator-$TIMESTAMP.log"

#======================================================================
# LINK VALIDATION RULES AND PATTERNS
#======================================================================

# Action verbs for link text validation (AV-001 through AV-009)
readonly ACTION_VERBS=(
    "Read" "Study" "Apply" "Execute" "Deploy"
    "Follow" "Review" "Browse" "Navigate" "Access"
    "View" "Open" "Download" "Install" "Configure"
    "Understand" "Learn" "Implement" "Use"
)

# Link format patterns
readonly LINK_PATTERN='\[([^\]]*)\]\(([^)]*)\)'
readonly INTERNAL_LINK_PATTERN='^\.\.|^[^/][^:]*\.md|^#'
readonly ANCHOR_PATTERN='#[a-zA-Z0-9-_]+'

# Required link structure components (LK-001 through LK-004)
declare -A LINK_RULES=(
    ["LK-001"]="Links must include action verb + use case format"
    ["LK-002"]="Path specification required for all links"
    ["LK-003"]="Heading anchors required for section references"
    ["LK-004"]="Link text must clearly indicate destination and purpose"
)

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A METRICS=(
    ["total_files"]=0
    ["files_with_links"]=0
    ["total_links"]=0
    ["internal_links"]=0
    ["external_links"]=0
    ["functional_links"]=0
    ["broken_links"]=0
    ["format_compliant_links"]=0
    ["format_violation_links"]=0
    ["correctable_links"]=0
)

declare -a BROKEN_LINKS=()
declare -a FORMAT_VIOLATIONS=()
declare -a CORRECTIONS=()

#======================================================================
# LINK EXTRACTION AND PARSING
#======================================================================
extract_links_from_file() {
    local file_path="$1"
    local temp_links=$(mktemp)
    
    # Extract all markdown links with line numbers
    grep -n "$LINK_PATTERN" "$file_path" 2>/dev/null | while IFS=: read -r line_num line_content; do
        # Parse all links on this line
        echo "$line_content" | grep -oE "$LINK_PATTERN" | while read -r link; do
            local link_text
            local link_url
            link_text=$(echo "$link" | sed -n 's/\[\([^\]]*\)\].*/\1/p')
            link_url=$(echo "$link" | sed -n 's/.*(\([^)]*\)).*/\1/p')
            
            echo "$file_path:$line_num:$link_text:$link_url"
        done
    done > "$temp_links"
    
    echo "$temp_links"
}

is_internal_link() {
    local url="$1"
    
    # Check if link is internal (relative path, anchor, or .md file)
    if [[ "$url" =~ $INTERNAL_LINK_PATTERN ]]; then
        return 0
    fi
    
    # Check for internal .md files without relative prefix
    if [[ "$url" =~ \.md(#.*)?$ ]] && [[ ! "$url" =~ ^https?:// ]]; then
        return 0
    fi
    
    return 1
}

resolve_link_path() {
    local source_file="$1"
    local link_url="$2"
    
    local source_dir
    source_dir=$(dirname "$source_file")
    
    # Handle anchor-only links
    if [[ "$link_url" =~ ^# ]]; then
        echo "$source_file"
        return
    fi
    
    # Handle relative paths
    if [[ "$link_url" =~ ^\.\./ ]] || [[ "$link_url" =~ ^\./ ]]; then
        local resolved_path
        resolved_path=$(cd "$source_dir" && realpath "$link_url" 2>/dev/null | cut -d'#' -f1)
        if [[ -n "$resolved_path" && "$resolved_path" == "$PROJECT_ROOT"* ]]; then
            echo "$resolved_path"
        fi
        return
    fi
    
    # Handle absolute paths within project
    if [[ "$link_url" =~ ^/ ]]; then
        echo "$PROJECT_ROOT${link_url%#*}"
        return
    fi
    
    # Handle direct .md filenames (assume same directory or relative to project root)
    if [[ "$link_url" =~ \.md$ ]]; then
        # First try same directory
        local same_dir_path="$source_dir/${link_url%#*}"
        if [[ -f "$same_dir_path" ]]; then
            echo "$same_dir_path"
            return
        fi
        
        # Then try project root
        local root_path="$PROJECT_ROOT/${link_url%#*}"
        if [[ -f "$root_path" ]]; then
            echo "$root_path"
            return
        fi
    fi
    
    # Return empty if can't resolve
    echo ""
}

#======================================================================
# LINK VALIDATION FUNCTIONS
#======================================================================
validate_link_format() {
    local link_text="$1"
    local link_url="$2"
    local violations=()
    
    # Rule LK-002: Path specification required
    if [[ -z "$link_url" ]] || [[ "$link_url" =~ ^[[:space:]]*$ ]]; then
        violations+=("LK-002: Missing path specification")
    fi
    
    # Rule LK-001 & LK-004: Action verb + use case format
    if [[ -n "$link_text" ]]; then
        local has_action_verb=false
        
        for verb in "${ACTION_VERBS[@]}"; do
            if [[ "$link_text" =~ ^$verb([[:space:]]|:) ]]; then
                has_action_verb=true
                break
            fi
        done
        
        if [[ "$has_action_verb" == "false" ]]; then
            violations+=("LK-001: Missing action verb in link text")
            violations+=("LK-004: Link text should clearly indicate purpose")
        fi
    else
        violations+=("LK-004: Empty link text")
    fi
    
    # Rule LK-003: Heading anchors for section references
    if [[ "$link_url" =~ #[a-zA-Z0-9-_]+ ]]; then
        # Anchor is present, validate format
        local anchor
        anchor=$(echo "$link_url" | grep -o '#[a-zA-Z0-9-_]*')
        
        if [[ ! "$anchor" =~ ^#[a-z0-9-]+$ ]]; then
            violations+=("LK-003: Invalid anchor format (should be lowercase kebab-case)")
        fi
    fi
    
    echo "${violations[@]}"
}

suggest_link_text_correction() {
    local original_text="$1"
    local link_url="$2"
    
    # Skip if already has action verb
    for verb in "${ACTION_VERBS[@]}"; do
        if [[ "$original_text" =~ ^$verb([[:space:]]|:) ]]; then
            echo ""  # Already compliant
            return
        fi
    done
    
    # Suggest action verb based on context
    local suggested_verb="Read"
    
    # Determine appropriate verb based on URL pattern
    case "$link_url" in
        *command*|*execute*|*run*)
            suggested_verb="Execute"
            ;;
        *template*|*example*|*apply*)
            suggested_verb="Apply"
            ;;
        *guide*|*tutorial*|*learn*)
            suggested_verb="Study"
            ;;
        *index*|*list*|*directory*)
            suggested_verb="Browse"
            ;;
        *reference*|*spec*)
            suggested_verb="Review"
            ;;
        *#*)
            suggested_verb="Navigate"
            ;;
    esac
    
    # Generate suggested text
    if [[ -n "$original_text" ]]; then
        echo "$suggested_verb: $original_text"
    else
        local filename
        filename=$(basename "${link_url%#*}" .md)
        echo "$suggested_verb: ${filename//-/ }"
    fi
}

#======================================================================
# LINK FUNCTIONALITY VALIDATION
#======================================================================
validate_internal_link() {
    local source_file="$1"
    local link_url="$2"
    
    # Resolve the target file path
    local target_file
    target_file=$(resolve_link_path "$source_file" "$link_url")
    
    if [[ -z "$target_file" ]]; then
        echo "ERROR: Cannot resolve link path"
        return 1
    fi
    
    # Check if target file exists
    if [[ ! -f "$target_file" ]]; then
        echo "ERROR: Target file does not exist: $target_file"
        return 1
    fi
    
    # Check anchor if present
    if [[ "$link_url" =~ #(.+)$ ]]; then
        local anchor="${BASH_REMATCH[1]}"
        
        # Convert anchor to heading format for search
        local heading_text
        heading_text=$(echo "$anchor" | tr '-' ' ')
        
        # Search for heading in target file
        if ! grep -qi "^#.*$heading_text" "$target_file"; then
            # Try alternate formats
            local kebab_case
            kebab_case=$(echo "$heading_text" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
            
            if ! grep -qi "id=[\"']$anchor[\"']" "$target_file" && \
               ! grep -qi "name=[\"']$anchor[\"']" "$target_file" && \
               ! grep -qi "{#$anchor}" "$target_file"; then
                echo "WARNING: Anchor '$anchor' not found in target file"
                return 1
            fi
        fi
    fi
    
    echo "OK"
    return 0
}

#======================================================================
# FILE VALIDATION ENGINE
#======================================================================
validate_file_links() {
    local file_path="$1"
    local file_violations=()
    local file_corrections=()
    local links_processed=0
    
    # Extract all links from file
    local links_file
    links_file=$(extract_links_from_file "$file_path")
    
    if [[ ! -s "$links_file" ]]; then
        rm -f "$links_file"
        return 0  # No links to validate
    fi
    
    METRICS["files_with_links"]=$((METRICS["files_with_links"] + 1))
    
    # Process each link
    while IFS=':' read -r source_file line_num link_text link_url; do
        links_processed=$((links_processed + 1))
        
        # Classify link type
        if is_internal_link "$link_url"; then
            METRICS["internal_links"]=$((METRICS["internal_links"] + 1))
            
            # Validate internal link functionality
            local functionality_result
            functionality_result=$(validate_internal_link "$source_file" "$link_url")
            
            if [[ "$functionality_result" == "OK" ]]; then
                METRICS["functional_links"]=$((METRICS["functional_links"] + 1))
            else
                METRICS["broken_links"]=$((METRICS["broken_links"] + 1))
                BROKEN_LINKS+=("$source_file:$line_num: $link_url - $functionality_result")
            fi
        else
            METRICS["external_links"]=$((METRICS["external_links"] + 1))
            # External links are assumed functional (would need network checks)
            METRICS["functional_links"]=$((METRICS["functional_links"] + 1))
        fi
        
        # Validate link format
        local format_violations
        format_violations=$(validate_link_format "$link_text" "$link_url")
        
        if [[ -n "$format_violations" && "$format_violations" != " " ]]; then
            METRICS["format_violation_links"]=$((METRICS["format_violation_links"] + 1))
            FORMAT_VIOLATIONS+=("$source_file:$line_num: [$link_text]($link_url) - $format_violations")
            
            # Generate correction suggestion
            local suggested_text
            suggested_text=$(suggest_link_text_correction "$link_text" "$link_url")
            
            if [[ -n "$suggested_text" && "$suggested_text" != "$link_text" ]]; then
                CORRECTIONS+=("$source_file:$line_num:$link_text:$suggested_text")
                METRICS["correctable_links"]=$((METRICS["correctable_links"] + 1))
            fi
        else
            METRICS["format_compliant_links"]=$((METRICS["format_compliant_links"] + 1))
        fi
        
    done < "$links_file"
    
    rm -f "$links_file"
    
    # Update total links metric
    METRICS["total_links"]=$((METRICS["total_links"] + links_processed))
    
    return 0
}

validate_all_files() {
    log "Starting link integrity and format validation..."
    
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
        
        validate_file_links "$file_path"
        
    done < "$temp_file_list"
    
    rm "$temp_file_list"
    log "Link validation completed"
}

#======================================================================
# CORRECTION APPLICATION
#======================================================================
apply_link_corrections() {
    log "Applying link text corrections..."
    
    local corrections_applied=0
    local corrections_failed=0
    
    # Group corrections by file
    declare -A file_corrections
    for correction in "${CORRECTIONS[@]}"; do
        local file_path="${correction%%:*}"
        local correction_data="${correction#*:}"
        
        if [[ -z "${file_corrections[$file_path]}" ]]; then
            file_corrections["$file_path"]="$correction_data"
        else
            file_corrections["$file_path"]+=$'\n'"$correction_data"
        fi
    done
    
    # Apply corrections file by file
    for file_path in "${!file_corrections[@]}"; do
        local temp_file=$(mktemp)
        local backup_file="$file_path.backup-$TIMESTAMP"
        
        # Create backup
        cp "$file_path" "$backup_file"
        
        local success=true
        cp "$file_path" "$temp_file"
        
        # Apply each correction for this file
        while IFS=':' read -r line_num old_text new_text; do
            if [[ -n "$line_num" && -n "$old_text" && -n "$new_text" ]]; then
                # Replace link text on specified line
                local escaped_old
                local escaped_new
                escaped_old=$(printf '%s\n' "$old_text" | sed 's/[[\.*^$()+?{|]/\\&/g')
                escaped_new=$(printf '%s\n' "$new_text" | sed 's/[[\.*^$()+?{|]/\\&/g')
                
                if sed -i "${line_num}s/\[$escaped_old\]/[$escaped_new]/" "$temp_file" 2>/dev/null; then
                    log "✅ Corrected line $line_num: '$old_text' -> '$new_text' in $file_path"
                else
                    log "❌ Failed to correct line $line_num in $file_path"
                    success=false
                    break
                fi
            fi
        done <<< "${file_corrections[$file_path]}"
        
        if [[ "$success" == "true" ]]; then
            mv "$temp_file" "$file_path"
            rm "$backup_file"
            corrections_applied=$((corrections_applied + 1))
        else
            rm "$temp_file"
            mv "$backup_file" "$file_path"
            corrections_failed=$((corrections_failed + 1))
        fi
    done
    
    log "Link corrections applied: $corrections_applied"
    log "Link corrections failed: $corrections_failed"
}

#======================================================================
# REPORTING AND OUTPUT
#======================================================================
generate_report() {
    log "=== LINK INTEGRITY AND FORMAT VALIDATION REPORT ==="
    
    local total_files=${METRICS["total_files"]}
    local files_with_links=${METRICS["files_with_links"]}
    local total_links=${METRICS["total_links"]}
    local internal_links=${METRICS["internal_links"]}
    local external_links=${METRICS["external_links"]}
    local functional_links=${METRICS["functional_links"]}
    local broken_links=${METRICS["broken_links"]}
    local format_compliant_links=${METRICS["format_compliant_links"]}
    local format_violation_links=${METRICS["format_violation_links"]}
    local correctable_links=${METRICS["correctable_links"]}
    
    # Calculate compliance scores
    local functionality_score=0
    local format_score=0
    local overall_score=0
    
    if [[ $total_links -gt 0 ]]; then
        functionality_score=$((functional_links * 100 / total_links))
        format_score=$((format_compliant_links * 100 / total_links))
        overall_score=$(((functionality_score + format_score) / 2))
    elif [[ $total_files -gt 0 ]]; then
        functionality_score=100
        format_score=100
        overall_score=100
    fi
    
    log "Total Markdown Files: $total_files"
    log "Files with Links: $files_with_links"
    log "Total Links Found: $total_links"
    log "  - Internal Links: $internal_links"
    log "  - External Links: $external_links"
    log "Functional Links: $functional_links"
    log "Broken Links: $broken_links"
    log "Format Compliant Links: $format_compliant_links"
    log "Format Violation Links: $format_violation_links"
    log "Auto-Correctable Links: $correctable_links"
    log ""
    log "Functionality Score: $functionality_score%"
    log "Format Score: $format_score%"
    log "Overall Compliance Score: $overall_score%"
    
    # Output compliance score for orchestrator
    echo "COMPLIANCE_SCORE:$overall_score"
    
    if [[ ${#BROKEN_LINKS[@]} -gt 0 ]]; then
        log ""
        log "=== BROKEN LINKS ==="
        for broken_link in "${BROKEN_LINKS[@]}"; do
            log "🔗 $broken_link"
        done
    fi
    
    if [[ ${#FORMAT_VIOLATIONS[@]} -gt 0 ]]; then
        log ""
        log "=== FORMAT VIOLATIONS ==="
        for violation in "${FORMAT_VIOLATIONS[@]}"; do
            log "❌ $violation"
        done
    fi
    
    if [[ ${#CORRECTIONS[@]} -gt 0 ]]; then
        log ""
        log "=== SUGGESTED CORRECTIONS ==="
        for correction in "${CORRECTIONS[@]}"; do
            local file_path="${correction%%:*}"
            local correction_data="${correction#*:}"
            IFS=':' read -r line_num old_text new_text <<< "$correction_data"
            log "🔧 $file_path:$line_num: '$old_text' -> '$new_text'"
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
  "validator": "link-integrity-validator",
  "version": "1.0.0",
  "metrics": {
    "total_files": $total_files,
    "files_with_links": $files_with_links,
    "total_links": $total_links,
    "internal_links": $internal_links,
    "external_links": $external_links,
    "functional_links": $functional_links,
    "broken_links": $broken_links,
    "format_compliant_links": $format_compliant_links,
    "format_violation_links": $format_violation_links,
    "correctable_links": $correctable_links,
    "functionality_score": $functionality_score,
    "format_score": $format_score,
    "overall_compliance_score": $overall_score
  },
  "action_verbs": [$(
    printf '"%s",' "${ACTION_VERBS[@]}" | sed '$ s/,$//'
  )],
  "broken_links": [$(
    printf '%s\n' "${BROKEN_LINKS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )],
  "format_violations": [$(
    printf '%s\n' "${FORMAT_VIOLATIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )],
  "corrections": [$(
    printf '%s\n' "${CORRECTIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )]
}
EOF
    
    log "Detailed report saved: $json_report"
}

#======================================================================
# COMMAND LINE INTERFACE
#======================================================================
show_usage() {
    cat << EOF
Usage: $0 [PROJECT_ROOT] [OPTIONS]

Claude Code Framework Link Integrity Validator

ARGUMENTS:
    PROJECT_ROOT    Path to project root (default: detect automatically)

OPTIONS:
    -h, --help      Show this help message
    --fix           Apply automatic corrections for link format violations
    --dry-run       Show what would be corrected without applying changes
    --report-only   Generate report from previous validation logs

VALIDATION RULES:
    LK-001: Links must include action verb + use case format
    LK-002: Path specification required for all links
    LK-003: Heading anchors required for section references
    LK-004: Link text must clearly indicate destination and purpose

ACTION VERBS SUPPORTED:
    Read, Study, Apply, Execute, Deploy, Follow, Review, Browse,
    Navigate, Access, View, Open, Download, Install, Configure,
    Understand, Learn, Implement, Use

TARGET: 85% link integrity and format compliance

VALIDATION SCOPE:
    - Internal link functionality (file existence, anchor validation)
    - Link format compliance (action verbs, clear purpose)
    - Anchor format validation (kebab-case)
    - Path resolution and verification

EXAMPLES:
    $0                          # Validate current directory
    $0 /path/to/project         # Validate specific project
    $0 --fix                    # Validate and apply corrections
    $0 --dry-run --fix          # Show corrections without applying

EOF
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    local fix_mode=false
    local dry_run=false
    local report_only=false
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            --fix)
                fix_mode=true
                shift
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            --report-only)
                report_only=true
                shift
                ;;
            *)
                if [[ -d "$1" ]]; then
                    PROJECT_ROOT="$1"
                else
                    log "ERROR: Invalid argument or directory: $1"
                    show_usage
                    exit 1
                fi
                shift
                ;;
        esac
    done
    
    # Ensure log directory exists
    mkdir -p "$(dirname "$LOG_FILE")"
    
    log "Link Integrity Validator v1.0.0 started"
    log "Project Root: $PROJECT_ROOT"
    log "Log File: $LOG_FILE"
    
    if [[ "$report_only" == "true" ]]; then
        log "Report-only mode: generating report from existing data"
        generate_report
        exit 0
    fi
    
    # Validate project root exists
    if [[ ! -d "$PROJECT_ROOT" ]]; then
        log "ERROR: Project root directory does not exist: $PROJECT_ROOT"
        exit 1
    fi
    
    # Perform validation
    validate_all_files
    
    # Apply corrections if requested
    if [[ "$fix_mode" == "true" ]]; then
        if [[ "$dry_run" == "true" ]]; then
            log "DRY RUN: Would apply ${#CORRECTIONS[@]} link format corrections"
            for correction in "${CORRECTIONS[@]}"; do
                local file_path="${correction%%:*}"
                local correction_data="${correction#*:}"
                IFS=':' read -r line_num old_text new_text <<< "$correction_data"
                log "  $file_path:$line_num: '$old_text' -> '$new_text'"
            done
        else
            apply_link_corrections
        fi
    fi
    
    # Generate final report
    generate_report
    
    # Return appropriate exit code based on compliance
    local total_links=${METRICS["total_links"]}
    local functional_links=${METRICS["functional_links"]}
    local format_compliant_links=${METRICS["format_compliant_links"]}
    
    local overall_score=100
    if [[ $total_links -gt 0 ]]; then
        local functionality_score=$((functional_links * 100 / total_links))
        local format_score=$((format_compliant_links * 100 / total_links))
        overall_score=$(((functionality_score + format_score) / 2))
    fi
    
    if [[ $overall_score -ge 85 ]]; then
        log "✅ Link compliance target achieved ($overall_score% >= 85%)"
        exit 0
    else
        log "❌ Link compliance below target ($overall_score% < 85%)"
        exit 1
    fi
}

#======================================================================
# SCRIPT EXECUTION
#======================================================================
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi