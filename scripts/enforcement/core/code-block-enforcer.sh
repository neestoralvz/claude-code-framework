#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - CODE BLOCK ENFORCER
#======================================================================
# Purpose: Automatically corrects code block language tag violations
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Corrects: Missing language tags, incorrect usage patterns, format issues
# Safety: Individual file backup with rollback capability
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/code-block-enforcer-$TIMESTAMP.log"

# Environment variables from orchestrator
readonly DRY_RUN="${DRY_RUN:-false}"
readonly MAX_FILES_PER_RUN="${MAX_FILES_PER_RUN:-500}"
readonly MAX_CHANGES_PER_FILE="${MAX_CHANGES_PER_FILE:-20}"
readonly BACKUP_DIR="${BACKUP_DIR:-${SCRIPT_DIR}/../backups/individual}"

#======================================================================
# CODE BLOCK ANALYSIS RULES
#======================================================================
declare -A CRITICAL_RULES=(
    ["CB-001"]="NEVER use bash code blocks for documentation content"
    ["CB-002"]="ALWAYS use markdown code blocks for documentation examples"
    ["CB-003"]="Bash blocks reserved for executable scripts only"
    ["CB-004"]="Use 'markdown' language specification for documentation examples"
    ["CB-005"]="All code blocks must have proper language specification"
)

declare -A LANGUAGE_USAGE_PATTERNS=(
    ["bash"]="executable_only"
    ["sh"]="executable_only"
    ["shell"]="executable_only"
    ["markdown"]="documentation_examples"
    ["yaml"]="configuration_files"
    ["json"]="data_structures"
    ["javascript"]="code_implementation"
    ["js"]="code_implementation"
    ["python"]="code_implementation"
    ["py"]="code_implementation"
    ["typescript"]="code_implementation"
    ["ts"]="code_implementation"
    ["css"]="styling_code"
    ["scss"]="styling_code"
    ["html"]="markup_code"
)

declare -A CONTENT_INDICATORS=(
    # Bash executable indicators
    ["bash_executable"]="^(#!/bin/bash|set -|function |export |if \[|for |while |case )"
    
    # Documentation example indicators  
    ["doc_example"]="^(Usage:|Example:|OPTIONS:|ARGUMENTS:|```|#[[:space:]]*[A-Z]|##[[:space:]]*)"
    
    # Configuration indicators
    ["config_content"]="^([a-z_-]+:|[[:space:]]*-[[:space:]]*[a-z])"
    
    # Code implementation indicators
    ["code_impl"]="^(import |function |class |const |let |var |def |return )"
    
    # Command examples
    ["command_example"]="^(\$|#[[:space:]]*[a-z]|./|cd |ls |mkdir |cp |mv )"
)

declare -A LANGUAGE_CORRECTIONS=(
    # Incorrect usage corrections
    ["bash_for_docs"]="markdown"
    ["shell_for_docs"]="markdown"
    ["sh_for_docs"]="markdown"
    
    # Missing language corrections based on content
    ["config_yaml"]="yaml"
    ["config_json"]="json"
    ["script_bash"]="bash"
    ["code_js"]="javascript"
    ["code_py"]="python"
    ["code_ts"]="typescript"
    ["code_css"]="css"
    ["markup_html"]="html"
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
    ["code_blocks_found"]=0
    ["language_tags_added"]=0
    ["language_tags_corrected"]=0
    ["critical_violations_fixed"]=0
    ["usage_pattern_violations_fixed"]=0
)

declare -a CORRECTION_OPERATIONS=()

#======================================================================
# CODE BLOCK DETECTION AND ANALYSIS
#======================================================================
extract_code_blocks() {
    local file="$1"
    local temp_file=$(mktemp)
    
    awk '
    BEGIN { in_block = 0; block_num = 0; }
    /^```/ { 
        if (in_block) {
            print block_num ":" "END"
            in_block = 0
        } else {
            block_num++
            lang = substr($0, 4)
            gsub(/^[[:space:]]*|[[:space:]]*$/, "", lang)
            print block_num ":" "START:" lang ":" NR
            in_block = 1
        }
        next
    }
    in_block { 
        print block_num ":" "CONTENT:" $0 
    }
    ' "$file" > "$temp_file"
    
    echo "$temp_file"
}

analyze_code_block_content() {
    local content="$1"
    
    # Check for various content patterns
    if echo "$content" | grep -qE "${CONTENT_INDICATORS[bash_executable]}"; then
        echo "bash_executable"
    elif echo "$content" | grep -qE "${CONTENT_INDICATORS[doc_example]}"; then
        echo "doc_example"
    elif echo "$content" | grep -qE "${CONTENT_INDICATORS[config_content]}"; then
        echo "config_content"
    elif echo "$content" | grep -qE "${CONTENT_INDICATORS[code_impl]}"; then
        echo "code_impl"
    elif echo "$content" | grep -qE "${CONTENT_INDICATORS[command_example]}"; then
        echo "command_example"
    else
        echo "unknown"
    fi
}

determine_correct_language() {
    local current_lang="$1"
    local content_type="$2"
    local content="$3"
    
    # If no language specified, infer from content
    if [[ -z "$current_lang" ]]; then
        case "$content_type" in
            "bash_executable"|"command_example")
                echo "bash"
                ;;
            "doc_example")
                echo "markdown"
                ;;
            "config_content")
                if echo "$content" | grep -q "^[a-z_-]*:"; then
                    echo "yaml"
                elif echo "$content" | grep -q "^[[:space:]]*{"; then
                    echo "json"
                else
                    echo "yaml"
                fi
                ;;
            "code_impl")
                if echo "$content" | grep -qE "(function|const|let|var|=>)"; then
                    echo "javascript"
                elif echo "$content" | grep -qE "(def |import |class |from )"; then
                    echo "python"
                elif echo "$content" | grep -qE "(interface|type |export )"; then
                    echo "typescript"
                else
                    echo "javascript"
                fi
                ;;
            *)
                echo "markdown"
                ;;
        esac
        return 0
    fi
    
    # Check for critical violations in existing language tags
    case "$current_lang" in
        "bash"|"sh"|"shell")
            if [[ "$content_type" == "doc_example" ]]; then
                echo "markdown"  # Critical violation: bash used for docs
                return 0
            elif [[ "$content_type" == "bash_executable" ]]; then
                echo "$current_lang"  # Correct usage
                return 0
            else
                echo "markdown"  # Default to markdown for non-executable
                return 0
            fi
            ;;
        "markdown")
            if [[ "$content_type" == "bash_executable" ]]; then
                echo "bash"  # Should be bash for executable content
                return 0
            else
                echo "$current_lang"  # Correct usage
                return 0
            fi
            ;;
        *)
            # Validate other languages against content
            case "$content_type" in
                "bash_executable")
                    echo "bash"
                    ;;
                "doc_example")
                    echo "markdown"
                    ;;
                *)
                    echo "$current_lang"  # Keep existing if reasonable
                    ;;
            esac
            ;;
    esac
}

#======================================================================
# FILE MODIFICATION ENGINE
#======================================================================
backup_file() {
    local file="$1"
    
    mkdir -p "$BACKUP_DIR/code-blocks"
    local backup_file="$BACKUP_DIR/code-blocks/$(basename "$file")-$TIMESTAMP"
    
    cp "$file" "$backup_file"
    log "Backed up: $file -> $backup_file"
}

apply_code_block_corrections() {
    local file="$1"
    shift
    local corrections=("$@")
    
    if [[ ${#corrections[@]} -eq 0 ]]; then
        return 0
    fi
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would apply ${#corrections[@]} code block corrections to $file"
        return 0
    fi
    
    # Backup original file
    backup_file "$file"
    
    # Create temporary file for corrections
    local temp_file=$(mktemp)
    cp "$file" "$temp_file"
    
    # Apply corrections in reverse order (to maintain line numbers)
    local sorted_corrections
    sorted_corrections=$(printf '%s\n' "${corrections[@]}" | sort -t: -k2,2nr)
    
    while IFS= read -r correction; do
        if [[ -n "$correction" ]]; then
            local line_num=$(echo "$correction" | cut -d: -f2)
            local old_lang=$(echo "$correction" | cut -d: -f3)
            local new_lang=$(echo "$correction" | cut -d: -f4)
            
            # Replace the code block language on the specific line
            if [[ -n "$old_lang" ]]; then
                sed -i "${line_num}s/^```$old_lang/\`\`\`$new_lang/" "$temp_file"
            else
                sed -i "${line_num}s/^```$/\`\`\`$new_lang/" "$temp_file"
            fi
            
            log "Applied correction at line $line_num: '$old_lang' -> '$new_lang'"
        fi
    done <<< "$sorted_corrections"
    
    # Replace original file with corrected version
    mv "$temp_file" "$file"
    
    log "Applied ${#corrections[@]} code block corrections to: $file"
}

#======================================================================
# ENFORCEMENT EXECUTION ENGINE
#======================================================================
process_markdown_file_for_code_blocks() {
    local file="$1"
    
    log "Processing: $file"
    METRICS["files_processed"]=$((METRICS["files_processed"] + 1))
    
    # Extract code blocks
    local code_blocks_file
    code_blocks_file=$(extract_code_blocks "$file")
    
    if [[ ! -s "$code_blocks_file" ]]; then
        log "No code blocks found in: $file"
        rm -f "$code_blocks_file"
        return 0
    fi
    
    local block_count=0
    local current_block=""
    local current_lang=""
    local current_line=""
    local current_content=""
    local corrections=()
    
    while IFS=':' read -r block_num action data extra; do
        case "$action" in
            "START")
                if [[ -n "$current_block" ]] && [[ ${#corrections[@]} -lt $MAX_CHANGES_PER_FILE ]]; then
                    # Process previous block
                    local content_type
                    content_type=$(analyze_code_block_content "$current_content")
                    
                    local correct_lang
                    correct_lang=$(determine_correct_language "$current_lang" "$content_type" "$current_content")
                    
                    if [[ "$current_lang" != "$correct_lang" ]]; then
                        corrections+=("correction:$current_line:$current_lang:$correct_lang")
                        
                        if [[ -z "$current_lang" ]]; then
                            METRICS["language_tags_added"]=$((METRICS["language_tags_added"] + 1))
                        else
                            METRICS["language_tags_corrected"]=$((METRICS["language_tags_corrected"] + 1))
                        fi
                        
                        # Check for critical violations
                        if [[ "$current_lang" =~ ^(bash|sh|shell)$ ]] && [[ "$content_type" == "doc_example" ]]; then
                            METRICS["critical_violations_fixed"]=$((METRICS["critical_violations_fixed"] + 1))
                        fi
                        
                        log "Code block correction needed: Line $current_line, '$current_lang' -> '$correct_lang' ($content_type)"
                    fi
                fi
                
                current_block="$block_num"
                current_lang="$data"
                current_line="$extra"
                current_content=""
                block_count=$((block_count + 1))
                ;;
            "CONTENT")
                current_content="$current_content$data\n"
                ;;
            "END")
                # Process final block
                if [[ -n "$current_block" ]] && [[ ${#corrections[@]} -lt $MAX_CHANGES_PER_FILE ]]; then
                    local content_type
                    content_type=$(analyze_code_block_content "$current_content")
                    
                    local correct_lang
                    correct_lang=$(determine_correct_language "$current_lang" "$content_type" "$current_content")
                    
                    if [[ "$current_lang" != "$correct_lang" ]]; then
                        corrections+=("correction:$current_line:$current_lang:$correct_lang")
                        
                        if [[ -z "$current_lang" ]]; then
                            METRICS["language_tags_added"]=$((METRICS["language_tags_added"] + 1))
                        else
                            METRICS["language_tags_corrected"]=$((METRICS["language_tags_corrected"] + 1))
                        fi
                        
                        # Check for critical violations
                        if [[ "$current_lang" =~ ^(bash|sh|shell)$ ]] && [[ "$content_type" == "doc_example" ]]; then
                            METRICS["critical_violations_fixed"]=$((METRICS["critical_violations_fixed"] + 1))
                        fi
                        
                        log "Code block correction needed: Line $current_line, '$current_lang' -> '$correct_lang' ($content_type)"
                    fi
                fi
                current_block=""
                ;;
        esac
    done < "$code_blocks_file"
    
    rm -f "$code_blocks_file"
    
    METRICS["code_blocks_found"]=$((METRICS["code_blocks_found"] + block_count))
    
    # Apply corrections if any were found
    if [[ ${#corrections[@]} -gt 0 ]]; then
        apply_code_block_corrections "$file" "${corrections[@]}"
        METRICS["files_modified"]=$((METRICS["files_modified"] + 1))
        
        # Store correction operations for reporting
        for correction in "${corrections[@]}"; do
            CORRECTION_OPERATIONS+=("$file:$correction")
        done
    else
        log "No code block corrections needed for: $file"
    fi
}

find_markdown_files_for_code_block_enforcement() {
    local include_patterns=(
        "$PROJECT_ROOT/docs/**/*.md"
        "$PROJECT_ROOT/agents/**/*.md"
        "$PROJECT_ROOT/commands/**/*.md"
        "$PROJECT_ROOT/planning/**/*.md"
        "$PROJECT_ROOT/operations/**/*.md"
        "$PROJECT_ROOT/README.md"
        "$PROJECT_ROOT/playbook/**/*.md"
    )
    
    local exclude_patterns=(
        "*/backups/*"
        "*/node_modules/*"
        "*/\.git/*"
        "*/ide/*"
        "*/.DS_Store"
    )
    
    # Find markdown files with code blocks
    find "$PROJECT_ROOT" -name "*.md" -type f \
        | grep -v -E "($(IFS='|'; echo "${exclude_patterns[*]}"))" \
        | head -n "$MAX_FILES_PER_RUN"
}

execute_code_block_enforcement() {
    log "Starting code block enforcement"
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
            
            # Only process files that contain code blocks
            if grep -q "^```" "$file"; then
                process_markdown_file_for_code_blocks "$file"
            else
                log "No code blocks found in: $file"
            fi
        fi
    done < <(find_markdown_files_for_code_block_enforcement)
    
    log "Code block enforcement completed"
    log "Files processed: ${METRICS["files_processed"]}"
    log "Files modified: ${METRICS["files_modified"]}"
    log "Code blocks found: ${METRICS["code_blocks_found"]}"
    log "Language tags added: ${METRICS["language_tags_added"]}"
    log "Language tags corrected: ${METRICS["language_tags_corrected"]}"
    log "Critical violations fixed: ${METRICS["critical_violations_fixed"]}"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    mkdir -p "$(dirname "$LOG_FILE")" "$BACKUP_DIR"
    
    log "Code Block Enforcer starting"
    log "Project root: $PROJECT_ROOT"
    log "Dry run: $DRY_RUN"
    
    execute_code_block_enforcement
    
    # Output metrics for orchestrator
    local total_corrections=$((METRICS["language_tags_added"] + METRICS["language_tags_corrected"]))
    echo "CORRECTIONS_MADE:$total_corrections"
    echo "FILES_MODIFIED:${METRICS["files_modified"]}"
    
    # Save correction operations log
    if [[ ${#CORRECTION_OPERATIONS[@]} -gt 0 ]]; then
        local corrections_log="$SCRIPT_DIR/../logs/code-block-corrections-$TIMESTAMP.log"
        printf '%s\n' "${CORRECTION_OPERATIONS[@]}" > "$corrections_log"
        log "Code block corrections logged to: $corrections_log"
    fi
    
    log "Code Block Enforcer completed successfully"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi