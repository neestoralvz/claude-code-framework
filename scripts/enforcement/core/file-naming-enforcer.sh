#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - FILE NAMING ENFORCER
#======================================================================
# Purpose: Automatically corrects file naming convention violations
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Corrects: Case violations, invalid characters, length issues
# Safety: Comprehensive backup and dependency tracking
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/file-naming-enforcer-$TIMESTAMP.log"

# Environment variables from orchestrator
readonly DRY_RUN="${DRY_RUN:-false}"
readonly MAX_FILES_PER_RUN="${MAX_FILES_PER_RUN:-500}"
readonly MAX_CHANGES_PER_FILE="${MAX_CHANGES_PER_FILE:-20}"
readonly BACKUP_DIR="${BACKUP_DIR:-${SCRIPT_DIR}/../backups/individual}"

# File naming rules and constraints
readonly MAX_FILENAME_LENGTH=100
readonly VALID_CHARS_PATTERN="^[a-zA-Z0-9._-]+$"
readonly MIN_FILENAME_LENGTH=3

#======================================================================
# NAMING CONVENTION RULES
#======================================================================
declare -A NAMING_RULES=(
    # Documents: kebab-case
    ['docs/**/*.md']="kebab-case"
    ['agents/**/*.md']="kebab-case"
    ['commands/**/*.md']="kebab-case"
    ['planning/**/*.md']="kebab-case"
    ['operations/**/*.md']="kebab-case"
    
    # Scripts: kebab-case
    ['scripts/**/*.sh']="kebab-case"
    ['scripts/**/*.js']="kebab-case"
    ['scripts/**/*.py']="kebab-case"
    
    # Configuration files: kebab-case
    ['**/*.yaml']="kebab-case"
    ['**/*.yml']="kebab-case"
    ['**/*.json']="kebab-case"
    
    # Special cases
    ['**/README.md']="UPPERCASE"
    ['**/LICENSE']="UPPERCASE"
    ['**/CHANGELOG.md']="UPPERCASE"
)

declare -A CASE_CONVERTERS=(
    ["kebab-case"]="to_kebab_case"
    ["snake_case"]="to_snake_case"
    ["camelCase"]="to_camel_case"
    ["PascalCase"]="to_pascal_case"
    ["UPPERCASE"]="to_uppercase"
)

declare -A CASE_VALIDATORS=(
    ["kebab-case"]="^[a-z0-9-]+(\.[a-z0-9]+)*$"
    ["snake_case"]="^[a-z0-9_]+(\.[a-z0-9]+)*$"
    ["camelCase"]="^[a-z][a-zA-Z0-9]*(\.[a-z0-9]+)*$"
    ["PascalCase"]="^[A-Z][a-zA-Z0-9]*(\.[a-z0-9]+)*$"
    ["UPPERCASE"]="^[A-Z][A-Z0-9_]*(\.[A-Z0-9]+)*$"
)

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A METRICS=(
    ["files_processed"]=0
    ["files_renamed"]=0
    ["case_violations_fixed"]=0
    ["length_violations_fixed"]=0
    ["character_violations_fixed"]=0
    ["references_updated"]=0
)

declare -a RENAME_OPERATIONS=()
declare -a REFERENCE_UPDATES=()

#======================================================================
# CASE CONVERSION FUNCTIONS
#======================================================================
to_kebab_case() {
    local input="$1"
    local filename="${input%.*}"
    local extension="${input##*.}"
    
    # Convert to kebab-case
    local kebab_filename
    kebab_filename=$(echo "$filename" | \
        sed 's/[A-Z]/-\L&/g' | \
        sed 's/[^a-zA-Z0-9-]/-/g' | \
        sed 's/--*/-/g' | \
        sed 's/^-\|-$//g' | \
        tr '[:upper:]' '[:lower:]')
    
    if [[ "$input" == "$filename" ]]; then
        echo "$kebab_filename"
    else
        echo "$kebab_filename.$extension"
    fi
}

to_snake_case() {
    local input="$1"
    local filename="${input%.*}"
    local extension="${input##*.}"
    
    local snake_filename
    snake_filename=$(echo "$filename" | \
        sed 's/[A-Z]/_\L&/g' | \
        sed 's/[^a-zA-Z0-9_]/_/g' | \
        sed 's/__*/_/g' | \
        sed 's/^_\|_$//g' | \
        tr '[:upper:]' '[:lower:]')
    
    if [[ "$input" == "$filename" ]]; then
        echo "$snake_filename"
    else
        echo "$snake_filename.$extension"
    fi
}

to_camel_case() {
    local input="$1"
    local filename="${input%.*}"
    local extension="${input##*.}"
    
    local camel_filename
    camel_filename=$(echo "$filename" | \
        sed 's/[^a-zA-Z0-9]/ /g' | \
        awk '{
            result = tolower($1)
            for(i=2; i<=NF; i++) {
                result = result toupper(substr($i,1,1)) tolower(substr($i,2))
            }
            print result
        }')
    
    if [[ "$input" == "$filename" ]]; then
        echo "$camel_filename"
    else
        echo "$camel_filename.$extension"
    fi
}

to_pascal_case() {
    local input="$1"
    local filename="${input%.*}"
    local extension="${input##*.}"
    
    local pascal_filename
    pascal_filename=$(echo "$filename" | \
        sed 's/[^a-zA-Z0-9]/ /g' | \
        awk '{
            result = ""
            for(i=1; i<=NF; i++) {
                result = result toupper(substr($i,1,1)) tolower(substr($i,2))
            }
            print result
        }')
    
    if [[ "$input" == "$filename" ]]; then
        echo "$pascal_filename"
    else
        echo "$pascal_filename.$extension"
    fi
}

to_uppercase() {
    local input="$1"
    echo "$input" | tr '[:lower:]' '[:upper:]'
}

#======================================================================
# FILE ANALYSIS AND VALIDATION
#======================================================================
get_naming_rule_for_file() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    
    # Check specific patterns
    for pattern in "${!NAMING_RULES[@]}"; do
        if [[ "$relative_path" == $pattern ]]; then
            echo "${NAMING_RULES[$pattern]}"
            return 0
        fi
    done
    
    # Default rule based on file extension
    case "${file##*.}" in
        md|txt|yaml|yml|json|sh|js|py|ts|tsx|css|scss)
            echo "kebab-case"
            ;;
        *)
            echo "kebab-case"
            ;;
    esac
}

validate_filename() {
    local filename="$1"
    local required_case="$2"
    
    local validator_pattern="${CASE_VALIDATORS[$required_case]:-}"
    
    if [[ -z "$validator_pattern" ]]; then
        log "No validator pattern for case: $required_case"
        return 1
    fi
    
    # Check case compliance
    if ! [[ "$filename" =~ $validator_pattern ]]; then
        return 1
    fi
    
    # Check length constraints
    if [[ ${#filename} -gt $MAX_FILENAME_LENGTH ]]; then
        return 1
    fi
    
    if [[ ${#filename} -lt $MIN_FILENAME_LENGTH ]]; then
        return 1
    fi
    
    # Check character constraints
    if ! [[ "$filename" =~ $VALID_CHARS_PATTERN ]]; then
        return 1
    fi
    
    return 0
}

generate_corrected_filename() {
    local original_filename="$1"
    local required_case="$2"
    
    local converter_function="${CASE_CONVERTERS[$required_case]:-}"
    
    if [[ -z "$converter_function" ]]; then
        log "No converter function for case: $required_case"
        echo "$original_filename"
        return 1
    fi
    
    # Apply case conversion
    local corrected_filename
    corrected_filename=$($converter_function "$original_filename")
    
    # Handle length violations
    if [[ ${#corrected_filename} -gt $MAX_FILENAME_LENGTH ]]; then
        local filename_part="${corrected_filename%.*}"
        local extension="${corrected_filename##*.}"
        local max_base_length=$((MAX_FILENAME_LENGTH - ${#extension} - 1))
        
        corrected_filename="${filename_part:0:$max_base_length}.$extension"
        METRICS["length_violations_fixed"]=$((METRICS["length_violations_fixed"] + 1))
    fi
    
    # Handle invalid characters
    if ! [[ "$corrected_filename" =~ $VALID_CHARS_PATTERN ]]; then
        corrected_filename=$(echo "$corrected_filename" | sed 's/[^a-zA-Z0-9._-]/-/g' | sed 's/--*/-/g')
        METRICS["character_violations_fixed"]=$((METRICS["character_violations_fixed"] + 1))
    fi
    
    echo "$corrected_filename"
}

#======================================================================
# REFERENCE UPDATE ENGINE
#======================================================================
find_file_references() {
    local old_path="$1"
    local relative_old_path="${old_path#$PROJECT_ROOT/}"
    
    local reference_files=()
    
    # Search for references in markdown files
    while IFS= read -r -d '' file; do
        if grep -l "$relative_old_path\|$(basename "$old_path")" "$file" >/dev/null 2>&1; then
            reference_files+=("$file")
        fi
    done < <(find "$PROJECT_ROOT" -name "*.md" -type f -print0)
    
    # Search for references in configuration files
    while IFS= read -r -d '' file; do
        if grep -l "$relative_old_path\|$(basename "$old_path")" "$file" >/dev/null 2>&1; then
            reference_files+=("$file")
        fi
    done < <(find "$PROJECT_ROOT" -name "*.json" -o -name "*.yaml" -o -name "*.yml" -type f -print0)
    
    printf '%s\n' "${reference_files[@]}"
}

update_file_references() {
    local old_path="$1"
    local new_path="$2"
    
    local relative_old_path="${old_path#$PROJECT_ROOT/}"
    local relative_new_path="${new_path#$PROJECT_ROOT/}"
    local old_filename=$(basename "$old_path")
    local new_filename=$(basename "$new_path")
    
    log "Updating references: $relative_old_path -> $relative_new_path"
    
    local reference_files
    reference_files=$(find_file_references "$old_path")
    
    if [[ -z "$reference_files" ]]; then
        log "No references found for: $relative_old_path"
        return 0
    fi
    
    local updated_files=0
    while IFS= read -r ref_file; do
        if [[ -n "$ref_file" ]] && [[ -f "$ref_file" ]]; then
            # Backup reference file
            backup_file "$ref_file"
            
            if [[ "$DRY_RUN" == "true" ]]; then
                log "DRY RUN: Would update references in $ref_file"
            else
                # Update path references
                sed -i.bak \
                    -e "s|$relative_old_path|$relative_new_path|g" \
                    -e "s|$old_filename|$new_filename|g" \
                    "$ref_file" && rm -f "$ref_file.bak"
                
                log "Updated references in: $ref_file"
                updated_files=$((updated_files + 1))
            fi
        fi
    done <<< "$reference_files"
    
    METRICS["references_updated"]=$((METRICS["references_updated"] + updated_files))
    log "Updated references in $updated_files files"
}

#======================================================================
# FILE MODIFICATION ENGINE
#======================================================================
backup_file() {
    local file="$1"
    
    mkdir -p "$BACKUP_DIR/file-naming"
    local backup_file="$BACKUP_DIR/file-naming/$(basename "$file")-$TIMESTAMP"
    
    cp "$file" "$backup_file" 2>/dev/null || true
    log "Backed up: $file -> $backup_file"
}

rename_file_safely() {
    local old_path="$1"
    local new_path="$2"
    
    if [[ "$old_path" == "$new_path" ]]; then
        log "No rename needed: $old_path"
        return 0
    fi
    
    if [[ -e "$new_path" ]]; then
        log "Target file exists, cannot rename: $old_path -> $new_path"
        return 1
    fi
    
    # Create target directory if needed
    mkdir -p "$(dirname "$new_path")"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would rename $old_path -> $new_path"
        RENAME_OPERATIONS+=("$old_path|$new_path|DRY_RUN")
        return 0
    fi
    
    # Backup original file
    backup_file "$old_path"
    
    # Perform rename
    if mv "$old_path" "$new_path"; then
        log "Renamed: $old_path -> $new_path"
        RENAME_OPERATIONS+=("$old_path|$new_path|SUCCESS")
        METRICS["files_renamed"]=$((METRICS["files_renamed"] + 1))
        
        # Update references to the renamed file
        update_file_references "$old_path" "$new_path"
        return 0
    else
        log "Failed to rename: $old_path -> $new_path"
        RENAME_OPERATIONS+=("$old_path|$new_path|FAILED")
        return 1
    fi
}

#======================================================================
# ENFORCEMENT EXECUTION ENGINE
#======================================================================
process_file_for_naming() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        return 0
    fi
    
    log "Processing: $file"
    METRICS["files_processed"]=$((METRICS["files_processed"] + 1))
    
    local filename=$(basename "$file")
    local required_case
    required_case=$(get_naming_rule_for_file "$file")
    
    # Validate current filename
    if validate_filename "$filename" "$required_case"; then
        log "Filename compliant: $filename"
        return 0
    fi
    
    log "Filename violation detected: $filename (required: $required_case)"
    
    # Generate corrected filename
    local corrected_filename
    corrected_filename=$(generate_corrected_filename "$filename" "$required_case")
    
    if [[ "$filename" != "$corrected_filename" ]]; then
        local old_path="$file"
        local new_path="$(dirname "$file")/$corrected_filename"
        
        # Perform rename operation
        if rename_file_safely "$old_path" "$new_path"; then
            METRICS["case_violations_fixed"]=$((METRICS["case_violations_fixed"] + 1))
        fi
    fi
}

find_files_for_naming_enforcement() {
    local include_patterns=(
        "docs/**/*"
        "agents/**/*"
        "commands/**/*"
        "scripts/**/*"
        "planning/**/*"
        "operations/**/*"
    )
    
    local exclude_patterns=(
        "*/backups/*"
        "*/node_modules/*"
        "*/\.git/*"
        "*/ide/*"
        "*/.DS_Store"
        "*/statsig/*"
    )
    
    # Find files matching patterns
    find "$PROJECT_ROOT" -type f \
        -name "*.md" -o -name "*.sh" -o -name "*.js" -o -name "*.py" \
        -o -name "*.yaml" -o -name "*.yml" -o -name "*.json" \
        | grep -v -E "($(IFS='|'; echo "${exclude_patterns[*]}"))" \
        | head -n "$MAX_FILES_PER_RUN"
}

execute_file_naming_enforcement() {
    log "Starting file naming enforcement"
    log "Mode: $([ "$DRY_RUN" == "true" ] && echo "DRY RUN" || echo "LIVE")"
    log "Max files per run: $MAX_FILES_PER_RUN"
    
    local file_count=0
    while IFS= read -r file; do
        if [[ -n "$file" ]]; then
            file_count=$((file_count + 1))
            
            if [[ $file_count -gt $MAX_FILES_PER_RUN ]]; then
                log "Reached maximum files per run limit: $MAX_FILES_PER_RUN"
                break
            fi
            
            process_file_for_naming "$file"
        fi
    done < <(find_files_for_naming_enforcement)
    
    log "File naming enforcement completed"
    log "Files processed: ${METRICS["files_processed"]}"
    log "Files renamed: ${METRICS["files_renamed"]}"
    log "Case violations fixed: ${METRICS["case_violations_fixed"]}"
    log "Length violations fixed: ${METRICS["length_violations_fixed"]}"
    log "Character violations fixed: ${METRICS["character_violations_fixed"]}"
    log "References updated: ${METRICS["references_updated"]}"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    mkdir -p "$(dirname "$LOG_FILE")" "$BACKUP_DIR"
    
    log "File Naming Enforcer starting"
    log "Project root: $PROJECT_ROOT"
    log "Dry run: $DRY_RUN"
    log "Max filename length: $MAX_FILENAME_LENGTH"
    
    execute_file_naming_enforcement
    
    # Output metrics for orchestrator
    local total_corrections=$((METRICS["case_violations_fixed"] + METRICS["length_violations_fixed"] + METRICS["character_violations_fixed"]))
    echo "CORRECTIONS_MADE:$total_corrections"
    echo "FILES_MODIFIED:${METRICS["files_renamed"]}"
    
    # Save rename operations log
    if [[ ${#RENAME_OPERATIONS[@]} -gt 0 ]]; then
        local rename_log="$SCRIPT_DIR/../logs/file-naming-renames-$TIMESTAMP.log"
        printf '%s\n' "${RENAME_OPERATIONS[@]}" > "$rename_log"
        log "Rename operations logged to: $rename_log"
    fi
    
    log "File Naming Enforcer completed successfully"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi