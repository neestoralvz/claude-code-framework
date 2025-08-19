#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - CODE BLOCK VALIDATOR
#======================================================================
# Purpose: Validates code block language specifications and usage patterns
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Rules Validated: CB-001 through CB-005, LS-001 through LS-005
# Target: 100% proper language specification usage
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/code-block-validator-$TIMESTAMP.log"

#======================================================================
# CODE BLOCK VALIDATION RULES
#======================================================================

# Critical Rules (from CB-001 through CB-005)
declare -A CRITICAL_RULES=(
    ["CB-001"]="NEVER use bash code blocks for documentation content"
    ["CB-002"]="ALWAYS use markdown code blocks for documentation examples"
    ["CB-003"]="Bash blocks reserved for executable scripts only"
    ["CB-004"]="Use 'markdown' language specification for documentation examples"
    ["CB-005"]="All code blocks must have proper language specification"
)

# Language-specific usage patterns (LS-001 through LS-005)
declare -A LANGUAGE_PATTERNS=(
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

# Content analysis patterns
declare -A CONTENT_INDICATORS=(
    # Bash executable indicators
    ["bash_executable"]="^(#!/bin/bash|set -|function |export |if \[|for |while |case )"
    # Documentation example indicators  
    ["doc_example"]="^(Usage:|Example:|OPTIONS:|ARGUMENTS:|```|#[[:space:]]*[A-Z])"
    # Configuration indicators
    ["config_content"]="^([a-z_-]+:|[[:space:]]*-[[:space:]]*[a-z])"
    # Code implementation indicators
    ["code_impl"]="^(import |function |class |const |let |var |def |return )"
)

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A METRICS=(
    ["total_files"]=0
    ["files_with_blocks"]=0
    ["total_blocks"]=0
    ["compliant_blocks"]=0
    ["violation_blocks"]=0
    ["correctable_blocks"]=0
)

declare -a VIOLATIONS=()
declare -a CORRECTIONS=()

#======================================================================
# CODE BLOCK EXTRACTION
#======================================================================
extract_code_blocks() {
    local file_path="$1"
    local temp_blocks=$(mktemp)
    
    # Extract all code blocks with line numbers and language tags
    awk '
    BEGIN { block_num = 0; in_block = 0 }
    /^```/ {
        if (in_block) {
            # End of block
            printf "%s:%d:END:%s\n", FILENAME, NR, ""
            in_block = 0
        } else {
            # Start of block
            block_num++
            lang = substr($0, 4)
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", lang)
            printf "%s:%d:START:%s\n", FILENAME, NR, lang
            in_block = 1
            content_start = NR + 1
        }
    }
    in_block && !/^```/ {
        # Content line
        printf "%s:%d:CONTENT:%s\n", FILENAME, NR, $0
    }
    ' "$file_path" > "$temp_blocks"
    
    echo "$temp_blocks"
}

#======================================================================
# CODE BLOCK ANALYSIS
#======================================================================
analyze_code_block() {
    local file_path="$1"
    local start_line="$2"
    local language="$3"
    local content="$4"
    
    local violations=()
    local suggested_language=""
    local is_correctable=false
    
    # Rule CB-005: All code blocks must have proper language specification
    if [[ -z "$language" ]]; then
        violations+=("CB-005: Missing language specification")
        suggested_language=$(determine_language_from_content "$content")
        if [[ -n "$suggested_language" ]]; then
            is_correctable=true
        fi
    fi
    
    # Critical validation: bash usage rules
    if [[ "$language" == "bash" ]] || [[ "$language" == "sh" ]] || [[ "$language" == "shell" ]]; then
        if ! is_executable_content "$content"; then
            violations+=("CB-001: Bash blocks should not be used for documentation content")
            violations+=("CB-002: Use 'markdown' for documentation examples")
            suggested_language="markdown"
            is_correctable=true
        fi
    fi
    
    # Validate content-language matching
    if [[ -n "$language" ]] && [[ -n "$content" ]]; then
        local expected_language
        expected_language=$(determine_language_from_content "$content")
        
        if [[ -n "$expected_language" ]] && [[ "$language" != "$expected_language" ]]; then
            violations+=("LS-MATCH: Language tag '$language' doesn't match content (suggests '$expected_language')")
            suggested_language="$expected_language"
            is_correctable=true
        fi
    fi
    
    # Rule CB-004: Documentation examples should use 'markdown'
    if is_documentation_example "$content" && [[ "$language" != "markdown" ]]; then
        violations+=("CB-004: Documentation examples should use 'markdown' language specification")
        suggested_language="markdown"
        is_correctable=true
    fi
    
    # Output results
    if [[ ${#violations[@]} -gt 0 ]]; then
        echo "VIOLATIONS:${violations[*]}"
        if [[ "$is_correctable" == "true" && -n "$suggested_language" ]]; then
            echo "CORRECTION:$start_line:$language:$suggested_language"
        fi
        return 1
    fi
    
    return 0
}

#======================================================================
# CONTENT ANALYSIS FUNCTIONS
#======================================================================
is_executable_content() {
    local content="$1"
    
    # Check for bash executable indicators
    if echo "$content" | grep -qE "${CONTENT_INDICATORS[bash_executable]}"; then
        return 0
    fi
    
    # Check for command patterns
    if echo "$content" | grep -qE "^(cd |mkdir |cp |mv |rm |ls |grep |find |awk |sed |sort )"; then
        return 0
    fi
    
    # Check for variable assignments and control structures
    if echo "$content" | grep -qE "^([A-Z_]+=[\"']|if |for |while |function |case )"; then
        return 0
    fi
    
    return 1
}

is_documentation_example() {
    local content="$1"
    
    # Check for documentation example patterns
    if echo "$content" | grep -qE "${CONTENT_INDICATORS[doc_example]}"; then
        return 0
    fi
    
    # Check for usage examples, help text, or markdown formatting
    if echo "$content" | grep -qE "^(Usage:|Options:|Arguments:|Examples?:|# |## |\* |\- )"; then
        return 0
    fi
    
    return 1
}

determine_language_from_content() {
    local content="$1"
    
    # Empty content
    if [[ -z "$content" ]] || [[ "$content" =~ ^[[:space:]]*$ ]]; then
        echo "text"
        return
    fi
    
    # Bash/Shell script detection
    if is_executable_content "$content"; then
        echo "bash"
        return
    fi
    
    # Documentation examples
    if is_documentation_example "$content"; then
        echo "markdown"
        return
    fi
    
    # YAML detection
    if echo "$content" | grep -qE "${CONTENT_INDICATORS[config_content]}"; then
        if echo "$content" | grep -qE "^[a-z_-]+:[[:space:]]*"; then
            echo "yaml"
            return
        fi
    fi
    
    # JSON detection
    if echo "$content" | grep -qE "^\s*[\{\[]" && echo "$content" | grep -qE "[\}\]]\s*$"; then
        echo "json"
        return
    fi
    
    # JavaScript/TypeScript detection
    if echo "$content" | grep -qE "${CONTENT_INDICATORS[code_impl]}"; then
        if echo "$content" | grep -qE "(import.*from|export |interface |type )"; then
            echo "typescript"
        else
            echo "javascript"
        fi
        return
    fi
    
    # Python detection
    if echo "$content" | grep -qE "^(import |from |def |class |if __name__)"; then
        echo "python"
        return
    fi
    
    # CSS detection
    if echo "$content" | grep -qE "^[.#]?[a-zA-Z-_][a-zA-Z0-9-_]*[[:space:]]*\{"; then
        echo "css"
        return
    fi
    
    # HTML detection
    if echo "$content" | grep -qE "^<[a-zA-Z]"; then
        echo "html"
        return
    fi
    
    # Default to text for unrecognized content
    echo "text"
}

#======================================================================
# FILE VALIDATION ENGINE
#======================================================================
validate_file_code_blocks() {
    local file_path="$1"
    local file_violations=()
    local file_corrections=()
    local blocks_processed=0
    local blocks_violated=0
    
    # Extract code blocks
    local blocks_file
    blocks_file=$(extract_code_blocks "$file_path")
    
    if [[ ! -s "$blocks_file" ]]; then
        rm -f "$blocks_file"
        return 0  # No code blocks to validate
    fi
    
    METRICS["files_with_blocks"]=$((METRICS["files_with_blocks"] + 1))
    
    # Process code blocks
    local current_block_start=""
    local current_language=""
    local current_content=""
    local in_block=false
    
    while IFS=':' read -r file line type data; do
        case "$type" in
            "START")
                current_block_start="$line"
                current_language="$data"
                current_content=""
                in_block=true
                blocks_processed=$((blocks_processed + 1))
                ;;
            "CONTENT")
                if [[ "$in_block" == "true" ]]; then
                    current_content+="$data"$'\n'
                fi
                ;;
            "END")
                if [[ "$in_block" == "true" ]]; then
                    # Analyze this block
                    local analysis_result
                    analysis_result=$(analyze_code_block "$file_path" "$current_block_start" "$current_language" "$current_content")
                    local analysis_exit_code=$?
                    
                    if [[ $analysis_exit_code -ne 0 ]]; then
                        blocks_violated=$((blocks_violated + 1))
                        
                        # Parse violations and corrections
                        while IFS= read -r line; do
                            if [[ "$line" == VIOLATIONS:* ]]; then
                                local violations="${line#VIOLATIONS:}"
                                file_violations+=("Line $current_block_start: $violations")
                            elif [[ "$line" == CORRECTION:* ]]; then
                                local correction="${line#CORRECTION:}"
                                file_corrections+=("$correction")
                            fi
                        done <<< "$analysis_result"
                    fi
                    
                    in_block=false
                fi
                ;;
        esac
    done < "$blocks_file"
    
    rm -f "$blocks_file"
    
    # Update metrics
    METRICS["total_blocks"]=$((METRICS["total_blocks"] + blocks_processed))
    METRICS["violation_blocks"]=$((METRICS["violation_blocks"] + blocks_violated))
    METRICS["compliant_blocks"]=$((METRICS["compliant_blocks"] + blocks_processed - blocks_violated))
    
    # Record violations and corrections
    if [[ ${#file_violations[@]} -gt 0 ]]; then
        VIOLATIONS+=("$file_path: ${file_violations[*]}")
    fi
    
    if [[ ${#file_corrections[@]} -gt 0 ]]; then
        for correction in "${file_corrections[@]}"; do
            CORRECTIONS+=("$file_path:$correction")
        done
        METRICS["correctable_blocks"]=$((METRICS["correctable_blocks"] + ${#file_corrections[@]}))
    fi
    
    return $([[ ${#file_violations[@]} -eq 0 ]] && echo 0 || echo 1)
}

validate_all_files() {
    log "Starting code block validation..."
    
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
        
        validate_file_code_blocks "$file_path"
        
    done < "$temp_file_list"
    
    rm "$temp_file_list"
    log "Code block validation completed"
}

#======================================================================
# CORRECTION APPLICATION
#======================================================================
apply_code_block_corrections() {
    log "Applying code block corrections..."
    
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
        while IFS=':' read -r line_num old_lang new_lang; do
            if [[ -n "$line_num" && -n "$new_lang" ]]; then
                # Replace language tag on specified line
                if sed -i "${line_num}s/^```$old_lang$/```$new_lang/" "$temp_file" 2>/dev/null; then
                    log "✅ Corrected line $line_num: '$old_lang' -> '$new_lang' in $file_path"
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
    
    log "Code block corrections applied: $corrections_applied"
    log "Code block corrections failed: $corrections_failed"
}

#======================================================================
# REPORTING AND OUTPUT
#======================================================================
generate_report() {
    log "=== CODE BLOCK VALIDATION REPORT ==="
    
    local total_files=${METRICS["total_files"]}
    local files_with_blocks=${METRICS["files_with_blocks"]}
    local total_blocks=${METRICS["total_blocks"]}
    local compliant_blocks=${METRICS["compliant_blocks"]}
    local violation_blocks=${METRICS["violation_blocks"]}
    local correctable_blocks=${METRICS["correctable_blocks"]}
    
    # Calculate compliance score
    local compliance_score=0
    if [[ $total_blocks -gt 0 ]]; then
        compliance_score=$((compliant_blocks * 100 / total_blocks))
    elif [[ $total_files -gt 0 ]]; then
        compliance_score=100  # No blocks found = 100% compliant
    fi
    
    log "Total Markdown Files: $total_files"
    log "Files with Code Blocks: $files_with_blocks"
    log "Total Code Blocks: $total_blocks"
    log "Compliant Blocks: $compliant_blocks"
    log "Violation Blocks: $violation_blocks"
    log "Auto-Correctable Blocks: $correctable_blocks"
    log "Compliance Score: $compliance_score%"
    
    # Output compliance score for orchestrator
    echo "COMPLIANCE_SCORE:$compliance_score"
    
    if [[ ${#VIOLATIONS[@]} -gt 0 ]]; then
        log ""
        log "=== CODE BLOCK VIOLATIONS ==="
        for violation in "${VIOLATIONS[@]}"; do
            log "❌ $violation"
        done
    fi
    
    if [[ ${#CORRECTIONS[@]} -gt 0 ]]; then
        log ""
        log "=== SUGGESTED CORRECTIONS ==="
        for correction in "${CORRECTIONS[@]}"; do
            local file_path="${correction%%:*}"
            local correction_data="${correction#*:}"
            IFS=':' read -r line_num old_lang new_lang <<< "$correction_data"
            log "🔧 $file_path:$line_num: '$old_lang' -> '$new_lang'"
        done
        
        log ""
        log "To apply corrections automatically, run:"
        log "  $0 --fix"
    fi
    
    if [[ $total_blocks -gt 0 ]]; then
        log ""
        log "=== VALIDATION RULES APPLIED ==="
        for rule in "${!CRITICAL_RULES[@]}"; do
            log "$rule: ${CRITICAL_RULES[$rule]}"
        done
    fi
    
    # Generate detailed JSON report
    local json_report="${LOG_FILE%.log}-report.json"
    cat > "$json_report" << EOF
{
  "timestamp": "$TIMESTAMP",
  "validator": "code-block-validator",
  "version": "1.0.0",
  "metrics": {
    "total_files": $total_files,
    "files_with_blocks": $files_with_blocks,
    "total_blocks": $total_blocks,
    "compliant_blocks": $compliant_blocks,
    "violation_blocks": $violation_blocks,
    "correctable_blocks": $correctable_blocks,
    "compliance_score": $compliance_score
  },
  "critical_rules": {$(
    for rule in "${!CRITICAL_RULES[@]}"; do
      echo "    \"$rule\": \"${CRITICAL_RULES[$rule]}\","
    done | sed '$ s/,$//'
  )},
  "violations": [$(
    printf '%s\n' "${VIOLATIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
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

Claude Code Framework Code Block Validator

ARGUMENTS:
    PROJECT_ROOT    Path to project root (default: detect automatically)

OPTIONS:
    -h, --help      Show this help message
    --fix           Apply automatic corrections for code block violations
    --dry-run       Show what would be corrected without applying changes
    --report-only   Generate report from previous validation logs

CRITICAL VALIDATION RULES:
    CB-001: NEVER use bash code blocks for documentation content
    CB-002: ALWAYS use markdown code blocks for documentation examples
    CB-003: Bash blocks reserved for executable scripts only
    CB-004: Use 'markdown' language specification for documentation examples
    CB-005: All code blocks must have proper language specification

LANGUAGE-SPECIFIC RULES:
    LS-001: Bash for executable commands and scripts only
    LS-002: Markdown for documentation format demonstrations
    LS-003: YAML for configuration files and metadata
    LS-004: JavaScript/Python for code implementations
    LS-005: JSON for data structures and API responses

TARGET: 100% proper language specification usage

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
    
    log "Code Block Validator v1.0.0 started"
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
            log "DRY RUN: Would apply ${#CORRECTIONS[@]} code block corrections"
            for correction in "${CORRECTIONS[@]}"; do
                local file_path="${correction%%:*}"
                local correction_data="${correction#*:}"
                IFS=':' read -r line_num old_lang new_lang <<< "$correction_data"
                log "  $file_path:$line_num: '$old_lang' -> '$new_lang'"
            done
        else
            apply_code_block_corrections
        fi
    fi
    
    # Generate final report
    generate_report
    
    # Return appropriate exit code based on compliance
    local total_blocks=${METRICS["total_blocks"]}
    local compliant_blocks=${METRICS["compliant_blocks"]}
    
    local compliance_score=100
    if [[ $total_blocks -gt 0 ]]; then
        compliance_score=$((compliant_blocks * 100 / total_blocks))
    fi
    
    if [[ $compliance_score -eq 100 ]]; then
        log "🎉 Perfect code block compliance achieved!"
        exit 0
    elif [[ $compliance_score -ge 95 ]]; then
        log "✅ Excellent code block compliance ($compliance_score%)"
        exit 0
    else
        log "❌ Code block compliance below target ($compliance_score% < 100%)"
        exit 1
    fi
}

#======================================================================
# SCRIPT EXECUTION
#======================================================================
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi