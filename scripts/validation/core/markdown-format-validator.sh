#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - MARKDOWN FORMAT VALIDATOR
#======================================================================
# Purpose: Validates markdown document structure and formatting standards
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Rules Validated: DS-001 through DS-007, TF-001 through TF-005
# Target: 95% markdown format compliance
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/markdown-format-validator-$TIMESTAMP.log"

#======================================================================
# MARKDOWN FORMATTING RULES
#======================================================================

# Document Structure Standards (DS-001 through DS-007)
declare -A STRUCTURE_RULES=(
    ["DS-001"]="H1 titles must use Title Case format"
    ["DS-002"]="H2 sections must use Title Case format"
    ["DS-003"]="H3 subsections must use Title Case format"
    ["DS-004"]="H4 details must use Title Case format"
    ["DS-005"]="Maximum 4 heading levels allowed"
    ["DS-006"]="No empty headings permitted"
    ["DS-007"]="Heading hierarchy must be sequential (no skipped levels)"
)

# Text Formatting Standards (TF-001 through TF-005)
declare -A TEXT_FORMAT_RULES=(
    ["TF-001"]="Bold formatting only for emphasis and key terms"
    ["TF-002"]="Italic formatting used sparingly for subtle emphasis"
    ["TF-003"]="UPPERCASE reserved for system directives and constants"
    ["TF-004"]="Code backticks for technical terms and values"
    ["TF-005"]="Consistent symbol usage (→, •, ✓) for hierarchy"
)

# Title Case patterns for validation
readonly TITLE_CASE_PATTERN='^[A-Z][a-z]*(\s+[A-Z][a-z]*|\s+[a-z]{1,3}\s+[A-Z][a-z]*)*$'
readonly ARTICLE_WORDS="a an the and but or nor for so yet at by for from in into of off on onto to up with as"

# Formatting patterns
readonly BOLD_PATTERN='\*\*[^*]+\*\*'
readonly ITALIC_PATTERN='\*[^*]+\*'
readonly CODE_PATTERN='`[^`]+`'
readonly HEADING_PATTERN='^#{1,6}\s'

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A METRICS=(
    ["total_files"]=0
    ["files_with_headings"]=0
    ["total_headings"]=0
    ["compliant_headings"]=0
    ["title_case_violations"]=0
    ["hierarchy_violations"]=0
    ["empty_headings"]=0
    ["excessive_levels"]=0
    ["format_violations"]=0
    ["correctable_issues"]=0
)

declare -a FORMAT_VIOLATIONS=()
declare -a FORMAT_CORRECTIONS=()

#======================================================================
# TITLE CASE VALIDATION
#======================================================================
is_title_case() {
    local text="$1"
    
    # Remove special characters and numbers for validation
    local clean_text
    clean_text=$(echo "$text" | sed 's/[^a-zA-Z ]//g')
    
    # Check if empty after cleaning
    if [[ -z "$clean_text" ]]; then
        return 0  # Consider technical headings as valid
    fi
    
    # Split into words and check each
    local words
    read -ra words <<< "$clean_text"
    
    for i in "${!words[@]}"; do
        local word="${words[i]}"
        local lower_word
        lower_word=$(echo "$word" | tr '[:upper:]' '[:lower:]')
        
        # First word should always be capitalized
        if [[ $i -eq 0 ]]; then
            if [[ ! "$word" =~ ^[A-Z] ]]; then
                return 1
            fi
        # Articles and short prepositions can be lowercase (unless first/last)
        elif [[ $i -ne $((${#words[@]} - 1)) ]] && [[ " $ARTICLE_WORDS " == *" $lower_word "* ]]; then
            if [[ "$word" =~ ^[A-Z] ]]; then
                continue  # Allow capitalized articles
            fi
        # All other words should be capitalized
        else
            if [[ ! "$word" =~ ^[A-Z] ]]; then
                return 1
            fi
        fi
    done
    
    return 0
}

convert_to_title_case() {
    local text="$1"
    local result=""
    local words
    
    read -ra words <<< "$text"
    
    for i in "${!words[@]}"; do
        local word="${words[i]}"
        local lower_word
        lower_word=$(echo "$word" | tr '[:upper:]' '[:lower:]')
        
        # First and last words always capitalized
        if [[ $i -eq 0 ]] || [[ $i -eq $((${#words[@]} - 1)) ]]; then
            word="${word^}"  # Capitalize first letter
        # Small articles and prepositions stay lowercase
        elif [[ " $ARTICLE_WORDS " == *" $lower_word "* ]] && [[ ${#lower_word} -le 3 ]]; then
            word="$lower_word"
        # All other words capitalized
        else
            word="${word^}"
        fi
        
        if [[ $i -eq 0 ]]; then
            result="$word"
        else
            result="$result $word"
        fi
    done
    
    echo "$result"
}

#======================================================================
# HEADING STRUCTURE VALIDATION
#======================================================================
validate_heading_hierarchy() {
    local headings_file="$1"
    local violations=()
    local previous_level=0
    local line_num=0
    
    while IFS=: read -r file_line level title; do
        line_num=$((line_num + 1))
        
        # Rule DS-005: Maximum 4 heading levels
        if [[ $level -gt 4 ]]; then
            violations+=("DS-005: Line $file_line - Heading level $level exceeds maximum (4)")
        fi
        
        # Rule DS-006: No empty headings
        if [[ -z "$title" ]] || [[ "$title" =~ ^[[:space:]]*$ ]]; then
            violations+=("DS-006: Line $file_line - Empty heading not permitted")
        fi
        
        # Rule DS-007: Sequential hierarchy (no skipped levels)
        if [[ $level -gt $((previous_level + 1)) ]]; then
            violations+=("DS-007: Line $file_line - Skipped heading level (from H$previous_level to H$level)")
        fi
        
        # Title case validation (DS-001 through DS-004)
        if [[ -n "$title" ]] && ! is_title_case "$title"; then
            local rule_code
            case $level in
                1) rule_code="DS-001" ;;
                2) rule_code="DS-002" ;;
                3) rule_code="DS-003" ;;
                4) rule_code="DS-004" ;;
                *) rule_code="DS-TITLE" ;;
            esac
            
            violations+=("$rule_code: Line $file_line - Heading not in Title Case: '$title'")
            
            # Generate correction
            local corrected_title
            corrected_title=$(convert_to_title_case "$title")
            if [[ "$corrected_title" != "$title" ]]; then
                FORMAT_CORRECTIONS+=("$file_line:HEADING:$title:$corrected_title")
            fi
        fi
        
        previous_level=$level
    done < "$headings_file"
    
    echo "${violations[@]}"
}

extract_headings() {
    local file_path="$1"
    local temp_headings=$(mktemp)
    
    grep -n '^#\+[[:space:]]' "$file_path" | while IFS=: read -r line_num heading; do
        local level
        level=$(echo "$heading" | grep -o '^#\+' | wc -c)
        level=$((level - 1))
        
        local title
        title=$(echo "$heading" | sed 's/^#\+[[:space:]]*//' | sed 's/[[:space:]]*$//')
        
        echo "$line_num:$level:$title"
    done > "$temp_headings"
    
    echo "$temp_headings"
}

#======================================================================
# TEXT FORMATTING VALIDATION
#======================================================================
validate_text_formatting() {
    local file_path="$1"
    local violations=()
    local line_num=0
    
    while IFS= read -r line; do
        line_num=$((line_num + 1))
        
        # Rule TF-001: Bold formatting validation
        if [[ "$line" =~ $BOLD_PATTERN ]]; then
            # Check for excessive bold usage
            local bold_count
            bold_count=$(echo "$line" | grep -o "$BOLD_PATTERN" | wc -l)
            
            if [[ $bold_count -gt 3 ]]; then
                violations+=("TF-001: Line $line_num - Excessive bold formatting ($bold_count instances)")
            fi
            
            # Check for bold entire sentences (likely misuse)
            if echo "$line" | grep -q '\*\*[^*]*[.!?][^*]*\*\*'; then
                violations+=("TF-001: Line $line_num - Bold should be for emphasis, not entire sentences")
            fi
        fi
        
        # Rule TF-002: Italic formatting validation
        if [[ "$line" =~ $ITALIC_PATTERN ]]; then
            # Check for excessive italic usage
            local italic_count
            italic_count=$(echo "$line" | grep -o "$ITALIC_PATTERN" | wc -l)
            
            if [[ $italic_count -gt 2 ]]; then
                violations+=("TF-002: Line $line_num - Excessive italic formatting ($italic_count instances)")
            fi
        fi
        
        # Rule TF-003: UPPERCASE validation
        local uppercase_words
        uppercase_words=$(echo "$line" | grep -o '\b[A-Z][A-Z][A-Z]\+\b' | wc -l)
        
        if [[ $uppercase_words -gt 0 ]]; then
            # Check if they're legitimate (constants, directives, etc.)
            if ! echo "$line" | grep -qE '\b(API|URL|HTTP|JSON|YAML|XML|SQL|CLI|GUI|IDE|README|TODO|FIXME|NOTE|WARNING|ERROR|SUCCESS|MANDATORY|CRITICAL|IMPORTANT)\b'; then
                violations+=("TF-003: Line $line_num - UPPERCASE should be reserved for system directives and constants")
            fi
        fi
        
        # Rule TF-004: Code backtick validation
        if [[ "$line" =~ $CODE_PATTERN ]]; then
            # Check for misuse of backticks for emphasis instead of code
            local code_segments
            readarray -t code_segments < <(echo "$line" | grep -o "$CODE_PATTERN")
            
            for segment in "${code_segments[@]}"; do
                local content="${segment#\`}"
                content="${content%\`}"
                
                # Check if it's actually code-like
                if [[ ! "$content" =~ [./=(){}[\]<>] ]] && [[ ${#content} -gt 20 ]]; then
                    violations+=("TF-004: Line $line_num - Backticks should be for technical terms, not emphasis: '$content'")
                fi
            done
        fi
        
        # Rule TF-005: Symbol consistency validation
        # Check for inconsistent list markers
        if [[ "$line" =~ ^[[:space:]]*[-*+][[:space:]] ]]; then
            local marker
            marker=$(echo "$line" | grep -o '^[[:space:]]*[-*+]')
            
            # Store marker for consistency checking (simplified for this script)
            if [[ ! "$marker" =~ ^[[:space:]]*-[[:space:]]$ ]]; then
                violations+=("TF-005: Line $line_num - Use consistent list marker (-)")
            fi
        fi
        
    done < "$file_path"
    
    echo "${violations[@]}"
}

#======================================================================
# LIST AND STRUCTURE VALIDATION
#======================================================================
validate_list_formatting() {
    local file_path="$1"
    local violations=()
    local in_list=false
    local list_marker=""
    local line_num=0
    
    while IFS= read -r line; do
        line_num=$((line_num + 1))
        
        # Check for list items
        if [[ "$line" =~ ^[[:space:]]*[-*+][[:space:]] ]]; then
            local current_marker
            current_marker=$(echo "$line" | grep -o '^[[:space:]]*[-*+]' | tr -d '[:space:]')
            
            if [[ "$in_list" == "false" ]]; then
                in_list=true
                list_marker="$current_marker"
            elif [[ "$current_marker" != "$list_marker" ]]; then
                violations+=("LIST-CONSISTENCY: Line $line_num - Inconsistent list marker ('$current_marker' vs '$list_marker')")
            fi
            
            # Check for proper spacing after marker
            if [[ ! "$line" =~ ^[[:space:]]*[-*+][[:space:]][^[:space:]] ]]; then
                violations+=("LIST-SPACING: Line $line_num - Missing space after list marker or empty list item")
            fi
            
        elif [[ "$line" =~ ^[[:space:]]*$ ]]; then
            # Empty line - continue list context
            continue
        elif [[ "$in_list" == "true" ]] && [[ ! "$line" =~ ^[[:space:]] ]]; then
            # End of list
            in_list=false
            list_marker=""
        fi
        
        # Check for numbered list formatting
        if [[ "$line" =~ ^[[:space:]]*[0-9]+\.[[:space:]] ]]; then
            # Validate proper numbering sequence (simplified)
            if [[ ! "$line" =~ ^[[:space:]]*[0-9]+\.[[:space:]][^[:space:]] ]]; then
                violations+=("NUMBERED-LIST: Line $line_num - Improper numbered list formatting")
            fi
        fi
        
    done < "$file_path"
    
    echo "${violations[@]}"
}

#======================================================================
# FILE VALIDATION ENGINE
#======================================================================
validate_file_markdown() {
    local file_path="$1"
    local has_violations=false
    local file_violations=()
    
    # Extract and validate headings
    local headings_file
    headings_file=$(extract_headings "$file_path")
    
    if [[ -s "$headings_file" ]]; then
        METRICS["files_with_headings"]=$((METRICS["files_with_headings"] + 1))
        
        local heading_count
        heading_count=$(wc -l < "$headings_file")
        METRICS["total_headings"]=$((METRICS["total_headings"] + heading_count))
        
        # Validate heading hierarchy
        local hierarchy_violations
        hierarchy_violations=$(validate_heading_hierarchy "$headings_file")
        
        if [[ -n "$hierarchy_violations" && "$hierarchy_violations" != " " ]]; then
            has_violations=true
            file_violations+=("$hierarchy_violations")
            
            # Count specific violation types
            if [[ "$hierarchy_violations" =~ DS-005 ]]; then
                METRICS["excessive_levels"]=$((METRICS["excessive_levels"] + 1))
            fi
            if [[ "$hierarchy_violations" =~ DS-006 ]]; then
                METRICS["empty_headings"]=$((METRICS["empty_headings"] + 1))
            fi
            if [[ "$hierarchy_violations" =~ DS-007 ]]; then
                METRICS["hierarchy_violations"]=$((METRICS["hierarchy_violations"] + 1))
            fi
            if [[ "$hierarchy_violations" =~ DS-00[1-4] ]]; then
                METRICS["title_case_violations"]=$((METRICS["title_case_violations"] + 1))
            fi
        else
            METRICS["compliant_headings"]=$((METRICS["compliant_headings"] + heading_count))
        fi
    fi
    
    rm -f "$headings_file"
    
    # Validate text formatting
    local text_violations
    text_violations=$(validate_text_formatting "$file_path")
    
    if [[ -n "$text_violations" && "$text_violations" != " " ]]; then
        has_violations=true
        file_violations+=("Text formatting: $text_violations")
    fi
    
    # Validate list formatting
    local list_violations
    list_violations=$(validate_list_formatting "$file_path")
    
    if [[ -n "$list_violations" && "$list_violations" != " " ]]; then
        has_violations=true
        file_violations+=("List formatting: $list_violations")
    fi
    
    # Record violations
    if [[ "$has_violations" == "true" ]]; then
        FORMAT_VIOLATIONS+=("$file_path: ${file_violations[*]}")
        METRICS["format_violations"]=$((METRICS["format_violations"] + 1))
        
        # Check if corrections are available
        if [[ ${#FORMAT_CORRECTIONS[@]} -gt 0 ]]; then
            local file_corrections=0
            for correction in "${FORMAT_CORRECTIONS[@]}"; do
                if [[ "$correction" == *"$file_path"* ]]; then
                    file_corrections=$((file_corrections + 1))
                fi
            done
            if [[ $file_corrections -gt 0 ]]; then
                METRICS["correctable_issues"]=$((METRICS["correctable_issues"] + 1))
            fi
        fi
        
        return 1
    fi
    
    return 0
}

validate_all_files() {
    log "Starting markdown format validation..."
    
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
        
        validate_file_markdown "$file_path"
        
    done < "$temp_file_list"
    
    rm "$temp_file_list"
    log "Markdown format validation completed"
}

#======================================================================
# CORRECTION APPLICATION
#======================================================================
apply_format_corrections() {
    log "Applying markdown format corrections..."
    
    local corrections_applied=0
    local corrections_failed=0
    
    # Group corrections by file
    declare -A file_corrections
    for correction in "${FORMAT_CORRECTIONS[@]}"; do
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
        while IFS=':' read -r line_num correction_type old_text new_text; do
            if [[ "$correction_type" == "HEADING" ]]; then
                # Replace heading text on specified line
                local escaped_old
                local escaped_new
                escaped_old=$(printf '%s\n' "$old_text" | sed 's/[[\.*^$()+?{|]/\\&/g')
                escaped_new=$(printf '%s\n' "$new_text" | sed 's/[[\.*^$()+?{|]/\\&/g')
                
                if sed -i "${line_num}s/$escaped_old/$escaped_new/" "$temp_file" 2>/dev/null; then
                    log "✅ Corrected heading line $line_num: '$old_text' -> '$new_text' in $file_path"
                else
                    log "❌ Failed to correct heading line $line_num in $file_path"
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
    
    log "Markdown format corrections applied: $corrections_applied"
    log "Markdown format corrections failed: $corrections_failed"
}

#======================================================================
# REPORTING AND OUTPUT
#======================================================================
generate_report() {
    log "=== MARKDOWN FORMAT VALIDATION REPORT ==="
    
    local total_files=${METRICS["total_files"]}
    local files_with_headings=${METRICS["files_with_headings"]}
    local total_headings=${METRICS["total_headings"]}
    local compliant_headings=${METRICS["compliant_headings"]}
    local title_case_violations=${METRICS["title_case_violations"]}
    local hierarchy_violations=${METRICS["hierarchy_violations"]}
    local empty_headings=${METRICS["empty_headings"]}
    local excessive_levels=${METRICS["excessive_levels"]}
    local format_violations=${METRICS["format_violations"]}
    local correctable_issues=${METRICS["correctable_issues"]}
    
    # Calculate compliance scores
    local heading_compliance=100
    local overall_compliance=0
    
    if [[ $total_headings -gt 0 ]]; then
        heading_compliance=$((compliant_headings * 100 / total_headings))
    fi
    
    if [[ $total_files -gt 0 ]]; then
        local compliant_files=$((total_files - format_violations))
        overall_compliance=$((compliant_files * 100 / total_files))
    fi
    
    log "Total Markdown Files: $total_files"
    log "Files with Headings: $files_with_headings"
    log "Total Headings: $total_headings"
    log "Compliant Headings: $compliant_headings"
    log "Title Case Violations: $title_case_violations"
    log "Hierarchy Violations: $hierarchy_violations"
    log "Empty Headings: $empty_headings"
    log "Excessive Heading Levels: $excessive_levels"
    log "Format Violations: $format_violations"
    log "Auto-Correctable Issues: $correctable_issues"
    log ""
    log "Heading Compliance: $heading_compliance%"
    log "Overall Format Compliance: $overall_compliance%"
    
    # Output compliance score for orchestrator
    echo "COMPLIANCE_SCORE:$overall_compliance"
    
    if [[ ${#FORMAT_VIOLATIONS[@]} -gt 0 ]]; then
        log ""
        log "=== FORMAT VIOLATIONS ==="
        for violation in "${FORMAT_VIOLATIONS[@]}"; do
            log "❌ $violation"
        done
    fi
    
    if [[ ${#FORMAT_CORRECTIONS[@]} -gt 0 ]]; then
        log ""
        log "=== SUGGESTED CORRECTIONS ==="
        for correction in "${FORMAT_CORRECTIONS[@]}"; do
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
  "validator": "markdown-format-validator",
  "version": "1.0.0",
  "metrics": {
    "total_files": $total_files,
    "files_with_headings": $files_with_headings,
    "total_headings": $total_headings,
    "compliant_headings": $compliant_headings,
    "title_case_violations": $title_case_violations,
    "hierarchy_violations": $hierarchy_violations,
    "empty_headings": $empty_headings,
    "excessive_levels": $excessive_levels,
    "format_violations": $format_violations,
    "correctable_issues": $correctable_issues,
    "heading_compliance": $heading_compliance,
    "overall_compliance": $overall_compliance
  },
  "structure_rules": {$(
    for rule in "${!STRUCTURE_RULES[@]}"; do
      echo "    \"$rule\": \"${STRUCTURE_RULES[$rule]}\","
    done | sed '$ s/,$//'
  )},
  "text_format_rules": {$(
    for rule in "${!TEXT_FORMAT_RULES[@]}"; do
      echo "    \"$rule\": \"${TEXT_FORMAT_RULES[$rule]}\","
    done | sed '$ s/,$//'
  )},
  "violations": [$(
    printf '%s\n' "${FORMAT_VIOLATIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )],
  "corrections": [$(
    printf '%s\n' "${FORMAT_CORRECTIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
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

Claude Code Framework Markdown Format Validator

VALIDATION RULES:
    Document Structure (DS-001 to DS-007): Title case headings, sequential hierarchy
    Text Formatting (TF-001 to TF-005): Proper use of bold, italic, code, symbols

TARGET: 95% markdown format compliance

OPTIONS:
    -h, --help      Show help
    --fix           Apply corrections
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
    log "Markdown Format Validator v1.0.0 started - Project Root: $PROJECT_ROOT"
    
    if [[ "$report_only" == "true" ]]; then
        generate_report; exit 0
    fi
    
    validate_all_files
    
    if [[ "$fix_mode" == "true" ]]; then
        if [[ "$dry_run" == "true" ]]; then
            log "DRY RUN: Would apply ${#FORMAT_CORRECTIONS[@]} format corrections"
        else
            apply_format_corrections
        fi
    fi
    
    generate_report
    
    local compliance_score=$((((METRICS["total_files"] - METRICS["format_violations"]) * 100) / METRICS["total_files"]))
    
    if [[ $compliance_score -ge 95 ]]; then
        log "✅ Markdown format compliance achieved ($compliance_score% >= 95%)"
        exit 0
    else
        log "❌ Markdown format compliance below target ($compliance_score% < 95%)"
        exit 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi