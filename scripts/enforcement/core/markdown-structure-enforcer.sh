#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - MARKDOWN STRUCTURE ENFORCER
#======================================================================
# Purpose: Automatically corrects markdown formatting and structure violations
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Corrects: Header hierarchy, list formatting, emphasis, line breaks, structure
# Safety: Individual file backup with content integrity validation
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/markdown-structure-enforcer-$TIMESTAMP.log"

# Environment variables from orchestrator
readonly DRY_RUN="${DRY_RUN:-false}"
readonly MAX_FILES_PER_RUN="${MAX_FILES_PER_RUN:-500}"
readonly MAX_CHANGES_PER_FILE="${MAX_CHANGES_PER_FILE:-20}"
readonly BACKUP_DIR="${BACKUP_DIR:-${SCRIPT_DIR}/../backups/individual}"

#======================================================================
# MARKDOWN FORMATTING RULES
#======================================================================
declare -A STRUCTURE_RULES=(
    # Header hierarchy rules
    ["header_hierarchy"]="Headers must follow logical sequence (H1 → H2 → H3, no skipping)"
    ["header_spacing"]="Headers must have blank lines before and after"
    ["header_consistency"]="Use # syntax, not underline syntax"
    
    # List formatting rules
    ["list_indentation"]="Consistent 2-space indentation for nested lists"
    ["list_markers"]="Use - for unordered lists, 1. for ordered lists"
    ["list_spacing"]="Single blank line between list groups"
    
    # Emphasis and inline formatting
    ["emphasis_consistency"]="Use **bold** and *italic*, not __bold__ or _italic_"
    ["code_inline"]="Use `code` for inline code"
    
    # Line and paragraph formatting
    ["line_endings"]="No trailing whitespace"
    ["paragraph_spacing"]="Single blank line between paragraphs"
    ["section_spacing"]="Double blank line before major sections"
)

declare -A FORMATTING_PATTERNS=(
    # Header patterns
    ["h1_pattern"]="^# "
    ["h2_pattern"]="^## "
    ["h3_pattern"]="^### "
    ["h4_pattern"]="^#### "
    ["h5_pattern"]="^##### "
    ["h6_pattern"]="^###### "
    
    # List patterns
    ["unordered_list"]="^[[:space:]]*[-*+][[:space:]]"
    ["ordered_list"]="^[[:space:]]*[0-9]+\.[[:space:]]"
    ["nested_list"]="^[[:space:]]{2,}[-*+][[:space:]]"
    
    # Emphasis patterns
    ["bold_double"]="\\*\\*([^*]+)\\*\\*"
    ["bold_underscore"]="__([^_]+)__"
    ["italic_single"]="\\*([^*]+)\\*"
    ["italic_underscore"]="_([^_]+)_"
    
    # Code patterns
    ["inline_code"]"`([^`]+)`"
    ["trailing_spaces"]="[[:space:]]+$"
)

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A METRICS=(
    ["files_processed"]=0
    ["files_modified"]=0
    ["header_fixes"]=0
    ["list_fixes"]=0
    ["emphasis_fixes"]=0
    ["spacing_fixes"]=0
    ["trailing_space_fixes"]=0
    ["structure_improvements"]=0
)

declare -a STRUCTURE_CORRECTIONS=()

#======================================================================
# MARKDOWN ANALYSIS FUNCTIONS
#======================================================================
analyze_header_hierarchy() {
    local file="$1"
    local issues=()
    
    # Extract all headers with line numbers
    local headers
    headers=$(grep -n "^#" "$file" || true)
    
    local prev_level=0
    while IFS=':' read -r line_num header; do
        if [[ -n "$header" ]]; then
            # Count # symbols to determine level
            local level
            level=$(echo "$header" | grep -o '^#*' | wc -c)
            level=$((level - 1))
            
            # Check for level skipping
            if [[ $level -gt $((prev_level + 1)) ]] && [[ $prev_level -gt 0 ]]; then
                issues+=("$line_num:header_skip:$prev_level:$level")
            fi
            
            # Check for proper spacing
            if [[ $line_num -gt 1 ]]; then
                local prev_line
                prev_line=$(sed -n "$((line_num - 1))p" "$file")
                if [[ -n "$prev_line" ]]; then
                    issues+=("$line_num:header_spacing_before")
                fi
            fi
            
            local next_line
            next_line=$(sed -n "$((line_num + 1))p" "$file")
            if [[ -n "$next_line" ]]; then
                issues+=("$line_num:header_spacing_after")
            fi
            
            prev_level=$level
        fi
    done <<< "$headers"
    
    printf '%s\n' "${issues[@]}"
}

analyze_list_formatting() {
    local file="$1"
    local issues=()
    
    # Find all list items
    local list_items
    list_items=$(grep -n "^[[:space:]]*[-*+0-9]" "$file" || true)
    
    while IFS=':' read -r line_num item; do
        if [[ -n "$item" ]]; then
            # Check indentation consistency
            local indent
            indent=$(echo "$item" | grep -o "^[[:space:]]*")
            local indent_count=${#indent}
            
            if [[ $indent_count -gt 0 ]] && [[ $((indent_count % 2)) -ne 0 ]]; then
                issues+=("$line_num:list_indent:$indent_count")
            fi
            
            # Check list marker consistency
            if [[ "$item" =~ ^[[:space:]]*\* ]]; then
                issues+=("$line_num:list_marker_star")
            elif [[ "$item" =~ ^[[:space:]]*\+ ]]; then
                issues+=("$line_num:list_marker_plus")
            fi
        fi
    done <<< "$list_items"
    
    printf '%s\n' "${issues[@]}"
}

analyze_emphasis_formatting() {
    local file="$1"
    local issues=()
    
    # Check for underscore emphasis (should use asterisks)
    local underscore_bold
    underscore_bold=$(grep -n "__.*__" "$file" || true)
    while IFS=':' read -r line_num content; do
        if [[ -n "$content" ]]; then
            issues+=("$line_num:underscore_bold")
        fi
    done <<< "$underscore_bold"
    
    local underscore_italic
    underscore_italic=$(grep -n "_[^_]*_" "$file" || true)
    while IFS=':' read -r line_num content; do
        if [[ -n "$content" ]]; then
            issues+=("$line_num:underscore_italic")
        fi
    done <<< "$underscore_italic"
    
    printf '%s\n' "${issues[@]}"
}

analyze_spacing_issues() {
    local file="$1"
    local issues=()
    
    # Find trailing spaces
    local trailing_spaces
    trailing_spaces=$(grep -n "[[:space:]]$" "$file" || true)
    while IFS=':' read -r line_num content; do
        if [[ -n "$content" ]]; then
            issues+=("$line_num:trailing_spaces")
        fi
    done <<< "$trailing_spaces"
    
    # Find multiple consecutive blank lines
    local blank_lines
    blank_lines=$(grep -n "^$" "$file" || true)
    local prev_blank_line=0
    while IFS=':' read -r line_num content; do
        if [[ -n "$line_num" ]]; then
            if [[ $((line_num - prev_blank_line)) -eq 1 ]]; then
                issues+=("$line_num:excessive_blank_lines")
            fi
            prev_blank_line=$line_num
        fi
    done <<< "$blank_lines"
    
    printf '%s\n' "${issues[@]}"
}

#======================================================================
# CORRECTION GENERATION
#======================================================================
generate_header_corrections() {
    local file="$1"
    local issues="$2"
    local corrections=()
    
    while IFS=':' read -r line_num issue_type details; do
        if [[ -n "$line_num" ]]; then
            case "$issue_type" in
                "header_spacing_before")
                    corrections+=("$line_num:insert_blank_line_before")
                    ;;
                "header_spacing_after")
                    corrections+=("$((line_num + 1)):insert_blank_line_after")
                    ;;
            esac
        fi
    done <<< "$issues"
    
    printf '%s\n' "${corrections[@]}"
}

generate_list_corrections() {
    local file="$1"
    local issues="$2"
    local corrections=()
    
    while IFS=':' read -r line_num issue_type details; do
        if [[ -n "$line_num" ]]; then
            case "$issue_type" in
                "list_marker_star"|"list_marker_plus")
                    corrections+=("$line_num:fix_list_marker")
                    ;;
                "list_indent")
                    local correct_indent=$((details / 2 * 2))
                    corrections+=("$line_num:fix_list_indent:$correct_indent")
                    ;;
            esac
        fi
    done <<< "$issues"
    
    printf '%s\n' "${corrections[@]}"
}

generate_emphasis_corrections() {
    local file="$1"
    local issues="$2"
    local corrections=()
    
    while IFS=':' read -r line_num issue_type; do
        if [[ -n "$line_num" ]]; then
            case "$issue_type" in
                "underscore_bold")
                    corrections+=("$line_num:fix_underscore_bold")
                    ;;
                "underscore_italic")
                    corrections+=("$line_num:fix_underscore_italic")
                    ;;
            esac
        fi
    done <<< "$issues"
    
    printf '%s\n' "${corrections[@]}"
}

generate_spacing_corrections() {
    local file="$1"
    local issues="$2"
    local corrections=()
    
    while IFS=':' read -r line_num issue_type; do
        if [[ -n "$line_num" ]]; then
            case "$issue_type" in
                "trailing_spaces")
                    corrections+=("$line_num:remove_trailing_spaces")
                    ;;
                "excessive_blank_lines")
                    corrections+=("$line_num:remove_blank_line")
                    ;;
            esac
        fi
    done <<< "$issues"
    
    printf '%s\n' "${corrections[@]}"
}

#======================================================================
# FILE MODIFICATION ENGINE
#======================================================================
backup_file() {
    local file="$1"
    
    mkdir -p "$BACKUP_DIR/markdown-structure"
    local backup_file="$BACKUP_DIR/markdown-structure/$(basename "$file")-$TIMESTAMP"
    
    cp "$file" "$backup_file"
    log "Backed up: $file -> $backup_file"
}

apply_structure_corrections() {
    local file="$1"
    shift
    local corrections=("$@")
    
    if [[ ${#corrections[@]} -eq 0 ]]; then
        return 0
    fi
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would apply ${#corrections[@]} structure corrections to $file"
        return 0
    fi
    
    backup_file "$file"
    
    local temp_file=$(mktemp)
    cp "$file" "$temp_file"
    
    # Apply corrections in reverse order (to maintain line numbers)
    local sorted_corrections
    sorted_corrections=$(printf '%s\n' "${corrections[@]}" | sort -t: -k1,1nr)
    
    local corrections_applied=0
    while IFS=':' read -r line_num correction_type details; do
        if [[ -n "$line_num" ]] && [[ $corrections_applied -lt $MAX_CHANGES_PER_FILE ]]; then
            case "$correction_type" in
                "insert_blank_line_before")
                    sed -i "${line_num}i\\" "$temp_file"
                    METRICS["spacing_fixes"]=$((METRICS["spacing_fixes"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    ;;
                    
                "insert_blank_line_after")
                    sed -i "${line_num}a\\" "$temp_file"
                    METRICS["spacing_fixes"]=$((METRICS["spacing_fixes"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    ;;
                    
                "fix_list_marker")
                    sed -i "${line_num}s/^\\([[:space:]]*\\)[*+]/\\1-/" "$temp_file"
                    METRICS["list_fixes"]=$((METRICS["list_fixes"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    ;;
                    
                "fix_list_indent")
                    local correct_spaces=$(printf "%*s" "$details" "")
                    sed -i "${line_num}s/^[[:space:]]*/$(echo "$correct_spaces" | sed 's/[[\]*^$(){}+?.|\\]/\\&/g')/" "$temp_file"
                    METRICS["list_fixes"]=$((METRICS["list_fixes"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    ;;
                    
                "fix_underscore_bold")
                    sed -i "${line_num}s/__\\([^_]*\\)__/**(\\1)**/g" "$temp_file"
                    METRICS["emphasis_fixes"]=$((METRICS["emphasis_fixes"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    ;;
                    
                "fix_underscore_italic")
                    sed -i "${line_num}s/_\\([^_]*\\)_/*(\\1)*/g" "$temp_file"
                    METRICS["emphasis_fixes"]=$((METRICS["emphasis_fixes"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    ;;
                    
                "remove_trailing_spaces")
                    sed -i "${line_num}s/[[:space:]]*$//" "$temp_file"
                    METRICS["trailing_space_fixes"]=$((METRICS["trailing_space_fixes"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    ;;
                    
                "remove_blank_line")
                    sed -i "${line_num}d" "$temp_file"
                    METRICS["spacing_fixes"]=$((METRICS["spacing_fixes"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    ;;
            esac
            
            log "Applied correction at line $line_num: $correction_type"
        fi
    done <<< "$sorted_corrections"
    
    mv "$temp_file" "$file"
    log "Applied $corrections_applied structure corrections to: $file"
    
    return $corrections_applied
}

#======================================================================
# ENFORCEMENT EXECUTION ENGINE
#======================================================================
process_file_for_markdown_structure() {
    local file="$1"
    
    log "Processing: $file"
    METRICS["files_processed"]=$((METRICS["files_processed"] + 1))
    
    # Analyze various markdown structure issues
    local header_issues
    header_issues=$(analyze_header_hierarchy "$file")
    
    local list_issues
    list_issues=$(analyze_list_formatting "$file")
    
    local emphasis_issues
    emphasis_issues=$(analyze_emphasis_formatting "$file")
    
    local spacing_issues
    spacing_issues=$(analyze_spacing_issues "$file")
    
    # Generate corrections for each issue type
    local all_corrections=()
    
    if [[ -n "$header_issues" ]]; then
        local header_corrections
        header_corrections=$(generate_header_corrections "$file" "$header_issues")
        while IFS= read -r correction; do
            if [[ -n "$correction" ]]; then
                all_corrections+=("$correction")
            fi
        done <<< "$header_corrections"
    fi
    
    if [[ -n "$list_issues" ]]; then
        local list_corrections
        list_corrections=$(generate_list_corrections "$file" "$list_issues")
        while IFS= read -r correction; do
            if [[ -n "$correction" ]]; then
                all_corrections+=("$correction")
            fi
        done <<< "$list_corrections"
    fi
    
    if [[ -n "$emphasis_issues" ]]; then
        local emphasis_corrections
        emphasis_corrections=$(generate_emphasis_corrections "$file" "$emphasis_issues")
        while IFS= read -r correction; do
            if [[ -n "$correction" ]]; then
                all_corrections+=("$correction")
            fi
        done <<< "$emphasis_corrections"
    fi
    
    if [[ -n "$spacing_issues" ]]; then
        local spacing_corrections
        spacing_corrections=$(generate_spacing_corrections "$file" "$spacing_issues")
        while IFS= read -r correction; do
            if [[ -n "$correction" ]]; then
                all_corrections+=("$correction")
            fi
        done <<< "$spacing_corrections"
    fi
    
    # Apply all corrections
    if [[ ${#all_corrections[@]} -gt 0 ]]; then
        local corrections_count
        corrections_count=$(apply_structure_corrections "$file" "${all_corrections[@]}")
        
        if [[ $corrections_count -gt 0 ]]; then
            METRICS["files_modified"]=$((METRICS["files_modified"] + 1))
            METRICS["structure_improvements"]=$((METRICS["structure_improvements"] + 1))
            
            # Store correction operations for reporting
            STRUCTURE_CORRECTIONS+=("$file:${#all_corrections[@]} corrections applied")
        fi
    else
        log "No markdown structure corrections needed for: $file"
    fi
}

find_files_for_markdown_structure_enforcement() {
    local include_patterns=(
        "$PROJECT_ROOT/docs/**/*.md"
        "$PROJECT_ROOT/agents/**/*.md"
        "$PROJECT_ROOT/commands/**/*.md"
        "$PROJECT_ROOT/planning/**/*.md"
        "$PROJECT_ROOT/operations/**/*.md"
        "$PROJECT_ROOT/playbook/**/*.md"
        "$PROJECT_ROOT/README.md"
    )
    
    local exclude_patterns=(
        "*/backups/*"
        "*/node_modules/*"
        "*/\.git/*"
        "*/ide/*"
        "*/.DS_Store"
    )
    
    # Find markdown files needing structure enforcement
    find "$PROJECT_ROOT" -name "*.md" -type f \
        | grep -v -E "($(IFS='|'; echo "${exclude_patterns[*]}"))" \
        | head -n "$MAX_FILES_PER_RUN"
}

execute_markdown_structure_enforcement() {
    log "Starting markdown structure enforcement"
    log "Mode: $([ "$DRY_RUN" == "true" ] && echo "DRY RUN" || echo "LIVE")"
    log "Max files per run: $MAX_FILES_PER_RUN"
    log "Max changes per file: $MAX_CHANGES_PER_FILE"
    
    local file_count=0
    while IFS= read -r file; do
        if [[ -n "$file" ]] && [[ -f "$file" ]]; then
            file_count=$((file_count + 1))
            
            if [[ $file_count -gt $MAX_FILES_PER_RUN ]]; then
                log "Reached maximum files per run limit: $MAX_FILES_PER_RUN"
                break
            fi
            
            process_file_for_markdown_structure "$file"
        fi
    done < <(find_files_for_markdown_structure_enforcement)
    
    log "Markdown structure enforcement completed"
    log "Files processed: ${METRICS["files_processed"]}"
    log "Files modified: ${METRICS["files_modified"]}"
    log "Header fixes: ${METRICS["header_fixes"]}"
    log "List fixes: ${METRICS["list_fixes"]}"
    log "Emphasis fixes: ${METRICS["emphasis_fixes"]}"
    log "Spacing fixes: ${METRICS["spacing_fixes"]}"
    log "Trailing space fixes: ${METRICS["trailing_space_fixes"]}"
    log "Structure improvements: ${METRICS["structure_improvements"]}"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    mkdir -p "$(dirname "$LOG_FILE")" "$BACKUP_DIR"
    
    log "Markdown Structure Enforcer starting"
    log "Project root: $PROJECT_ROOT"
    log "Dry run: $DRY_RUN"
    
    execute_markdown_structure_enforcement
    
    # Output metrics for orchestrator
    local total_corrections=$((METRICS["header_fixes"] + METRICS["list_fixes"] + METRICS["emphasis_fixes"] + METRICS["spacing_fixes"] + METRICS["trailing_space_fixes"]))
    echo "CORRECTIONS_MADE:$total_corrections"
    echo "FILES_MODIFIED:${METRICS["files_modified"]}"
    
    # Save correction operations log
    if [[ ${#STRUCTURE_CORRECTIONS[@]} -gt 0 ]]; then
        local corrections_log="$SCRIPT_DIR/../logs/markdown-structure-corrections-$TIMESTAMP.log"
        printf '%s\n' "${STRUCTURE_CORRECTIONS[@]}" > "$corrections_log"
        log "Markdown structure corrections logged to: $corrections_log"
    fi
    
    log "Markdown Structure Enforcer completed successfully"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi