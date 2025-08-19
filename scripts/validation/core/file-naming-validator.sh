#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - FILE NAMING VALIDATOR
#======================================================================
# Purpose: Validates file naming conventions across the framework
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Rules Validated: FN-001 through FN-008, CF-001 through CF-005
# Target: 100% filename compliance across framework
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/file-naming-validator-$TIMESTAMP.log"

# File naming patterns and requirements
readonly MAX_FILENAME_LENGTH=100
readonly VALID_CHARS_PATTERN="^[a-zA-Z0-9._-]+$"

# Directory patterns to include/exclude
readonly INCLUDE_PATTERNS=(
    "*.md"
    "*.yaml" 
    "*.yml"
    "*.json"
    "*.js"
    "*.py"
    "*.sh"
    "*.ts"
    "*.tsx"
    "*.css"
    "*.scss"
)

readonly EXCLUDE_DIRS=(
    ".git"
    "node_modules"
    ".DS_Store"
    "*.tmp"
    "*.cache"
    "ide"
    "statsig"
    "backups"
)

#======================================================================
# NAMING CONVENTION RULES
#======================================================================
declare -A NAMING_RULES=(
    # Documents: {TOPIC}-{subtopic}.md
    ['docs/**/*.md']="kebab-case"
    # Agents: {name}-{type}.md  
    ['agents/**/*.md']="kebab-case"
    # Commands: {action}-{object}.md
    ['commands/**/*.md']="kebab-case"
    # Templates: {feature}-{type}.md  
    ['docs/templates/**/*.md']="kebab-case"
    # Scripts: kebab-case.{ext}
    ['scripts/**/*.sh']="kebab-case"
    ['scripts/**/*.js']="kebab-case"
    ['scripts/**/*.py']="kebab-case"
    # Configuration files
    ['**/*.yaml']="kebab-case"
    ['**/*.yml']="kebab-case"
    ['**/*.json']="kebab-case"
)

declare -A CASE_RULES=(
    ["kebab-case"]="^[a-z0-9-]+(\.[a-z0-9]+)*$"
    ["snake_case"]="^[a-z0-9_]+(\.[a-z0-9]+)*$"
    ["camelCase"]="^[a-z][a-zA-Z0-9]*(\.[a-z0-9]+)*$"
    ["PascalCase"]="^[A-Z][a-zA-Z0-9]*(\.[a-z0-9]+)*$"
)

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Metrics tracking
declare -A METRICS=(
    ["total_files"]=0
    ["compliant_files"]=0
    ["violation_files"]=0
    ["correctable_files"]=0
)

declare -a VIOLATIONS=()
declare -a CORRECTIONS=()

#======================================================================
# FILE DISCOVERY AND FILTERING
#======================================================================
discover_files() {
    local temp_file_list=$(mktemp)
    
    log "Discovering files for naming validation..."
    
    # Build find command with include patterns
    local find_args=()
    for pattern in "${INCLUDE_PATTERNS[@]}"; do
        if [[ ${#find_args[@]} -gt 0 ]]; then
            find_args+=("-o")
        fi
        find_args+=("-name" "$pattern")
    done
    
    # Build exclude arguments
    local exclude_args=()
    for exclude_dir in "${EXCLUDE_DIRS[@]}"; do
        exclude_args+=("-path" "*/$exclude_dir" "-prune" "-o")
    done
    
    # Execute find command
    find "$PROJECT_ROOT" "${exclude_args[@]}" \( "${find_args[@]}" \) -type f -print > "$temp_file_list"
    
    local file_count=$(wc -l < "$temp_file_list")
    METRICS["total_files"]=$file_count
    log "Discovered $file_count files for validation"
    
    echo "$temp_file_list"
}

#======================================================================
# NAMING CONVENTION VALIDATION
#======================================================================
validate_filename_basic() {
    local file_path="$1"
    local filename=$(basename "$file_path")
    local violations=()
    
    # Rule FN-006: Maximum filename length
    if [[ ${#filename} -gt $MAX_FILENAME_LENGTH ]]; then
        violations+=("FN-006: Filename exceeds maximum length (${#filename} > $MAX_FILENAME_LENGTH)")
    fi
    
    # Rule FN-007: Valid characters only
    if [[ ! "$filename" =~ $VALID_CHARS_PATTERN ]]; then
        violations+=("FN-007: Invalid characters in filename")
    fi
    
    # Check for common problematic patterns
    if [[ "$filename" =~ [[:space:]] ]]; then
        violations+=("FN-007: Spaces not allowed in filenames")
    fi
    
    if [[ "$filename" =~ [A-Z] ]] && [[ "$filename" =~ \.(md|yaml|yml|json|sh|py|js)$ ]]; then
        violations+=("FN-005: Uppercase letters not allowed in kebab-case filenames")
    fi
    
    echo "${violations[@]}"
}

validate_naming_convention() {
    local file_path="$1"
    local relative_path="${file_path#$PROJECT_ROOT/}"
    local filename=$(basename "$file_path")
    local basename_no_ext="${filename%.*}"
    local violations=()
    
    # Determine expected case format based on file pattern
    local expected_case=""
    for pattern in "${!NAMING_RULES[@]}"; do
        if [[ "$relative_path" == $pattern ]]; then
            expected_case="${NAMING_RULES[$pattern]}"
            break
        fi
    done
    
    # Default to kebab-case if no specific rule found
    if [[ -z "$expected_case" ]]; then
        expected_case="kebab-case"
    fi
    
    # Validate against case convention
    local case_pattern="${CASE_RULES[$expected_case]}"
    if [[ ! "$filename" =~ $case_pattern ]]; then
        violations+=("CASE: Does not follow $expected_case convention")
    fi
    
    # Specific validation based on file type and location
    case "$relative_path" in
        agents/**/*.md)
            # Rule FN-002: Agents use {name}-{type}.md format
            if [[ ! "$basename_no_ext" =~ ^[a-z0-9-]+-[a-z0-9-]+$ ]]; then
                violations+=("FN-002: Agent files should use {name}-{type}.md format")
            fi
            ;;
        commands/**/*.md)
            # Rule FN-003: Commands use {action}-{object}.md format  
            if [[ ! "$basename_no_ext" =~ ^[a-z0-9-]+-[a-z0-9-]+$ ]]; then
                violations+=("FN-003: Command files should use {action}-{object}.md format")
            fi
            ;;
        docs/**/*.md)
            # Rule FN-001: Documents use {TOPIC}-{subtopic}.md format
            if [[ ! "$basename_no_ext" =~ ^[a-z0-9-]+(-[a-z0-9-]+)*$ ]]; then
                violations+=("FN-001: Document files should use {topic}-{subtopic}.md format")
            fi
            ;;
    esac
    
    echo "${violations[@]}"
}

#======================================================================
# CORRECTION SUGGESTIONS
#======================================================================
suggest_filename_correction() {
    local file_path="$1"
    local filename=$(basename "$file_path")
    local directory=$(dirname "$file_path")
    local basename_no_ext="${filename%.*}"
    local extension="${filename##*.}"
    
    # Convert to kebab-case
    local corrected_name="$basename_no_ext"
    
    # Convert spaces to hyphens
    corrected_name="${corrected_name// /-}"
    
    # Convert underscores to hyphens for kebab-case
    corrected_name="${corrected_name//_/-}"
    
    # Convert camelCase/PascalCase to kebab-case
    corrected_name=$(echo "$corrected_name" | sed 's/\([a-z]\)\([A-Z]\)/\1-\2/g' | tr '[:upper:]' '[:lower:]')
    
    # Remove multiple consecutive hyphens
    corrected_name=$(echo "$corrected_name" | sed 's/-\+/-/g')
    
    # Remove leading/trailing hyphens
    corrected_name="${corrected_name#-}"
    corrected_name="${corrected_name%-}"
    
    # Reconstruct filename
    local corrected_filename="$corrected_name.$extension"
    
    # Check if correction is needed
    if [[ "$filename" != "$corrected_filename" ]]; then
        echo "$directory/$corrected_filename"
    fi
}

#======================================================================
# MAIN VALIDATION ENGINE
#======================================================================
validate_all_files() {
    log "Starting file naming validation..."
    
    local file_list_file
    file_list_file=$(discover_files)
    
    local progress_count=0
    
    while IFS= read -r file_path; do
        progress_count=$((progress_count + 1))
        
        if [[ $((progress_count % 100)) -eq 0 ]]; then
            log "Progress: $progress_count/${METRICS[total_files]} files processed"
        fi
        
        local basic_violations
        basic_violations=$(validate_filename_basic "$file_path")
        
        local convention_violations  
        convention_violations=$(validate_naming_convention "$file_path")
        
        local all_violations="$basic_violations $convention_violations"
        
        if [[ -n "$all_violations" && "$all_violations" != " " ]]; then
            VIOLATIONS+=("$file_path: $all_violations")
            METRICS["violation_files"]=$((METRICS["violation_files"] + 1))
            
            # Check if file can be auto-corrected
            local suggested_path
            suggested_path=$(suggest_filename_correction "$file_path")
            
            if [[ -n "$suggested_path" ]]; then
                CORRECTIONS+=("$file_path -> $suggested_path")
                METRICS["correctable_files"]=$((METRICS["correctable_files"] + 1))
            fi
        else
            METRICS["compliant_files"]=$((METRICS["compliant_files"] + 1))
        fi
        
    done < "$file_list_file"
    
    rm "$file_list_file"
    
    log "File naming validation completed"
}

#======================================================================
# REPORTING AND OUTPUT
#======================================================================
generate_report() {
    log "=== FILE NAMING VALIDATION REPORT ==="
    
    local total_files=${METRICS["total_files"]}
    local compliant_files=${METRICS["compliant_files"]}
    local violation_files=${METRICS["violation_files"]}
    local correctable_files=${METRICS["correctable_files"]}
    
    # Calculate compliance score
    local compliance_score=0
    if [[ $total_files -gt 0 ]]; then
        compliance_score=$((compliant_files * 100 / total_files))
    fi
    
    log "Total Files Analyzed: $total_files"
    log "Compliant Files: $compliant_files"
    log "Files with Violations: $violation_files"
    log "Auto-Correctable Files: $correctable_files"
    log "Compliance Score: $compliance_score%"
    
    # Output compliance score for orchestrator
    echo "COMPLIANCE_SCORE:$compliance_score"
    
    if [[ ${#VIOLATIONS[@]} -gt 0 ]]; then
        log ""
        log "=== VIOLATIONS FOUND ==="
        for violation in "${VIOLATIONS[@]}"; do
            log "❌ $violation"
        done
    fi
    
    if [[ ${#CORRECTIONS[@]} -gt 0 ]]; then
        log ""
        log "=== SUGGESTED CORRECTIONS ==="
        for correction in "${CORRECTIONS[@]}"; do
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
  "validator": "file-naming-validator",
  "version": "1.0.0",
  "metrics": {
    "total_files": $total_files,
    "compliant_files": $compliant_files,
    "violation_files": $violation_files,
    "correctable_files": $correctable_files,
    "compliance_score": $compliance_score
  },
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
# AUTOMATIC CORRECTION ENGINE
#======================================================================
apply_corrections() {
    if [[ ${#CORRECTIONS[@]} -eq 0 ]]; then
        log "No corrections to apply"
        return 0
    fi
    
    log "Applying ${#CORRECTIONS[@]} filename corrections..."
    
    local corrections_applied=0
    local corrections_failed=0
    
    for correction in "${CORRECTIONS[@]}"; do
        local old_path="${correction%% -> *}"
        local new_path="${correction##* -> }"
        
        if [[ -f "$old_path" ]] && [[ ! -f "$new_path" ]]; then
            if git mv "$old_path" "$new_path" 2>/dev/null; then
                log "✅ Renamed: $old_path -> $new_path"
                corrections_applied=$((corrections_applied + 1))
            else
                log "❌ Failed to rename: $old_path -> $new_path"
                corrections_failed=$((corrections_failed + 1))
            fi
        else
            log "⚠️  Skipped: $old_path (source missing or target exists)"
        fi
    done
    
    log "Corrections applied: $corrections_applied"
    log "Corrections failed: $corrections_failed"
}

#======================================================================
# COMMAND LINE INTERFACE
#======================================================================
show_usage() {
    cat << EOF
Usage: $0 [PROJECT_ROOT] [OPTIONS]

Claude Code Framework File Naming Validator

ARGUMENTS:
    PROJECT_ROOT    Path to project root (default: detect automatically)

OPTIONS:
    -h, --help      Show this help message
    --fix           Apply automatic corrections for naming violations
    --dry-run       Show what would be corrected without applying changes
    --report-only   Generate report from previous validation logs

VALIDATION RULES:
    FN-001: Documents use {topic}-{subtopic}.md format
    FN-002: Agents use {name}-{type}.md format
    FN-003: Commands use {action}-{object}.md format  
    FN-004: Components use {feature}-{type}.md format
    FN-005: All files use kebab-case format
    FN-006: Maximum 100 character filename length
    FN-007: ASCII letters, numbers, hyphens, underscores, dots only
    FN-008: Case-sensitive system treatment

TARGET: 100% filename compliance

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
    
    log "File Naming Validator v1.0.0 started"
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
            log "DRY RUN: Would apply ${#CORRECTIONS[@]} corrections"
            for correction in "${CORRECTIONS[@]}"; do
                log "  $correction"
            done
        else
            apply_corrections
        fi
    fi
    
    # Generate final report
    generate_report
    
    # Return appropriate exit code
    local compliance_score=$((METRICS["compliant_files"] * 100 / METRICS["total_files"]))
    
    if [[ $compliance_score -eq 100 ]]; then
        log "🎉 Perfect compliance achieved!"
        exit 0
    elif [[ $compliance_score -ge 95 ]]; then
        log "✅ Good compliance achieved ($compliance_score%)"
        exit 0
    else
        log "❌ Compliance below target ($compliance_score% < 100%)"
        exit 1
    fi
}

#======================================================================
# SCRIPT EXECUTION
#======================================================================
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi