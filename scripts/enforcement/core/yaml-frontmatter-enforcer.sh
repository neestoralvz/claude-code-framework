#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - YAML FRONTMATTER ENFORCER
#======================================================================
# Purpose: Automatically corrects YAML frontmatter violations
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Corrects: Missing fields, invalid values, structure issues
# Safety: Backup individual files before modification
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/yaml-frontmatter-enforcer-$TIMESTAMP.log"

# Environment variables from orchestrator
readonly DRY_RUN="${DRY_RUN:-false}"
readonly MAX_FILES_PER_RUN="${MAX_FILES_PER_RUN:-500}"
readonly MAX_CHANGES_PER_FILE="${MAX_CHANGES_PER_FILE:-20}"
readonly BACKUP_DIR="${BACKUP_DIR:-${SCRIPT_DIR}/../backups/individual}"

#======================================================================
# YAML FRONTMATTER TEMPLATES AND RULES
#======================================================================
declare -A REQUIRED_FIELDS_BY_TYPE=(
    # Core document fields (all markdown files)
    ["core"]="title,author,date,version"
    
    # Specialized document types
    ["planning"]="title,author,date,version,purpose,ticket_id,priority,status"
    ["agent"]="title,author,date,version,agent_type,domain,specialization"
    ["command"]="title,author,date,version,purpose,usage,examples"
    ["principle"]="title,author,date,version,principle_type,authority,scope"
    ["template"]="title,author,date,version,template_type,usage_context"
)

declare -A FIELD_DEFAULTS=(
    ["author"]="Claude Code System"
    ["date"]="$(date +%Y-%m-%d)"
    ["version"]="1.0.0"
    ["status"]="pending"
    ["priority"]="MEDIUM"
)

declare -A FIELD_VALIDATION=(
    ["version"]="^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9.-]+)?$"
    ["date"]="^[0-9]{4}-[0-9]{2}-[0-9]{2}$"
    ["priority"]="^(CRITICAL|HIGH|MEDIUM|LOW)$"
    ["status"]="^(pending|in_progress|completed|resolved|blocked)$"
    ["ticket_id"]="^[A-Z]+-[0-9]+$"
)

declare -A VALID_VALUES=(
    ["priority"]="CRITICAL HIGH MEDIUM LOW"
    ["status"]="pending in_progress completed resolved blocked"
    ["author"]="Claude Code System"
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
    ["frontmatter_added"]=0
    ["fields_added"]=0
    ["fields_corrected"]=0
    ["validation_errors_fixed"]=0
)

#======================================================================
# YAML FRONTMATTER PARSING AND DETECTION
#======================================================================
has_yaml_frontmatter() {
    local file="$1"
    
    # Check if file starts with YAML frontmatter delimiter
    head -n 1 "$file" | grep -q "^---$" || return 1
    
    # Check if there's a closing delimiter
    tail -n +2 "$file" | grep -q "^---$" || return 1
    
    return 0
}

extract_yaml_frontmatter() {
    local file="$1"
    
    if ! has_yaml_frontmatter "$file"; then
        echo ""
        return 1
    fi
    
    # Extract content between YAML delimiters
    sed -n '2,/^---$/p' "$file" | sed '$d'
}

extract_markdown_content() {
    local file="$1"
    
    if ! has_yaml_frontmatter "$file"; then
        cat "$file"
        return 0
    fi
    
    # Extract content after YAML frontmatter
    sed '1,/^---$/d' "$file" | sed '1,/^---$/d'
}

get_yaml_field_value() {
    local yaml_content="$1"
    local field="$2"
    
    echo "$yaml_content" | grep "^$field:" | sed "s/^$field:[[:space:]]*[\"']*\([^\"']*\)[\"']*$/\1/" | head -n 1
}

#======================================================================
# FILE TYPE DETECTION
#======================================================================
detect_file_type() {
    local file="$1"
    local file_path="${file#$PROJECT_ROOT/}"
    local filename=$(basename "$file")
    
    # Detect based on path patterns
    case "$file_path" in
        planning/tickets/*)
            echo "planning"
            ;;
        agents/*)
            echo "agent"
            ;;
        commands/*)
            echo "command"
            ;;
        docs/principles/*)
            echo "principle"
            ;;
        docs/templates/*)
            echo "template"
            ;;
        *)
            echo "core"
            ;;
    esac
}

#======================================================================
# YAML FRONTMATTER GENERATION
#======================================================================
generate_yaml_frontmatter() {
    local file="$1"
    local file_type="$2"
    local existing_yaml="${3:-}"
    
    local required_fields="${REQUIRED_FIELDS_BY_TYPE[$file_type]}"
    IFS=',' read -ra fields <<< "$required_fields"
    
    local yaml_output="---"
    
    for field in "${fields[@]}"; do
        local existing_value
        existing_value=$(echo "$existing_yaml" | get_yaml_field_value "$existing_yaml" "$field" || echo "")
        
        local field_value="$existing_value"
        
        # Generate missing fields
        if [[ -z "$field_value" ]]; then
            case "$field" in
                "title")
                    field_value=$(generate_title_from_filename "$file")
                    ;;
                "purpose")
                    field_value=$(generate_purpose_from_content "$file")
                    ;;
                "ticket_id")
                    field_value=$(generate_ticket_id_from_filename "$file")
                    ;;
                *)
                    field_value="${FIELD_DEFAULTS[$field]:-}"
                    ;;
            esac
        fi
        
        # Validate and correct field values
        if [[ -n "${FIELD_VALIDATION[$field]:-}" ]]; then
            if ! [[ "$field_value" =~ ${FIELD_VALIDATION[$field]} ]]; then
                log "Correcting invalid $field value: $field_value"
                field_value="${FIELD_DEFAULTS[$field]:-}"
            fi
        fi
        
        # Add field to YAML
        if [[ -n "$field_value" ]]; then
            if [[ "$field" == "dependencies" || "$field" == "keywords" || "$field" == "capabilities" ]]; then
                # Array fields
                yaml_output="$yaml_output\n$field: []"
            else
                # String fields
                yaml_output="$yaml_output\n$field: \"$field_value\""
            fi
        fi
    done
    
    yaml_output="$yaml_output\n---"
    echo -e "$yaml_output"
}

generate_title_from_filename() {
    local file="$1"
    local filename=$(basename "$file" .md)
    
    # Convert kebab-case to Title Case
    echo "$filename" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1'
}

generate_purpose_from_content() {
    local file="$1"
    
    # Try to extract purpose from first paragraph or comment
    local content
    content=$(extract_markdown_content "$file")
    
    # Look for purpose in first few lines
    echo "$content" | head -n 10 | grep -i "purpose\|objective\|goal" | head -n 1 | sed 's/^[#*-]*//' | sed 's/^[[:space:]]*//' | head -c 100 || echo "Document purpose description"
}

generate_ticket_id_from_filename() {
    local file="$1"
    local filename=$(basename "$file" .md)
    
    # Try to extract ticket ID pattern from filename
    if [[ "$filename" =~ ([A-Z]+-[0-9]+) ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        # Generate a default ticket ID based on filename
        local prefix=$(echo "$filename" | cut -d'-' -f1 | tr '[:lower:]' '[:upper:]')
        local number=$(date +%s | tail -c 3)
        echo "${prefix}-${number}"
    fi
}

#======================================================================
# FILE MODIFICATION ENGINE
#======================================================================
backup_file() {
    local file="$1"
    
    mkdir -p "$BACKUP_DIR/yaml-frontmatter"
    local backup_file="$BACKUP_DIR/yaml-frontmatter/$(basename "$file")-$TIMESTAMP"
    
    cp "$file" "$backup_file"
    log "Backed up: $file -> $backup_file"
}

apply_yaml_frontmatter() {
    local file="$1"
    local new_yaml="$2"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would update YAML frontmatter in $file"
        return 0
    fi
    
    # Backup original file
    backup_file "$file"
    
    # Extract existing markdown content
    local markdown_content
    markdown_content=$(extract_markdown_content "$file")
    
    # Create temporary file with new content
    local temp_file=$(mktemp)
    
    # Write new YAML frontmatter and existing markdown content
    echo -e "$new_yaml" > "$temp_file"
    echo "" >> "$temp_file"
    echo "$markdown_content" >> "$temp_file"
    
    # Replace original file
    mv "$temp_file" "$file"
    
    log "Updated YAML frontmatter: $file"
}

#======================================================================
# ENFORCEMENT EXECUTION ENGINE
#======================================================================
process_markdown_file() {
    local file="$1"
    
    log "Processing: $file"
    METRICS["files_processed"]=$((METRICS["files_processed"] + 1))
    
    # Detect file type for appropriate template
    local file_type
    file_type=$(detect_file_type "$file")
    
    # Extract existing YAML frontmatter
    local existing_yaml
    existing_yaml=$(extract_yaml_frontmatter "$file" || echo "")
    
    # Generate corrected YAML frontmatter
    local corrected_yaml
    corrected_yaml=$(generate_yaml_frontmatter "$file" "$file_type" "$existing_yaml")
    
    # Check if changes are needed
    local current_yaml_hash=""
    local new_yaml_hash=""
    
    if [[ -n "$existing_yaml" ]]; then
        current_yaml_hash=$(echo "$existing_yaml" | md5sum | cut -d' ' -f1)
    fi
    
    new_yaml_hash=$(echo "$corrected_yaml" | md5sum | cut -d' ' -f1)
    
    if [[ "$current_yaml_hash" != "$new_yaml_hash" ]]; then
        # Apply corrections
        apply_yaml_frontmatter "$file" "$corrected_yaml"
        METRICS["files_modified"]=$((METRICS["files_modified"] + 1))
        
        if [[ -z "$existing_yaml" ]]; then
            METRICS["frontmatter_added"]=$((METRICS["frontmatter_added"] + 1))
        fi
        
        # Count specific improvements
        local required_fields="${REQUIRED_FIELDS_BY_TYPE[$file_type]}"
        IFS=',' read -ra fields <<< "$required_fields"
        
        for field in "${fields[@]}"; do
            local existing_value
            existing_value=$(echo "$existing_yaml" | get_yaml_field_value "$existing_yaml" "$field" || echo "")
            
            local new_value
            new_value=$(echo "$corrected_yaml" | get_yaml_field_value "$corrected_yaml" "$field" || echo "")
            
            if [[ -z "$existing_value" && -n "$new_value" ]]; then
                METRICS["fields_added"]=$((METRICS["fields_added"] + 1))
            elif [[ "$existing_value" != "$new_value" ]]; then
                METRICS["fields_corrected"]=$((METRICS["fields_corrected"] + 1))
            fi
        done
        
        log "YAML frontmatter updated for: $file"
    else
        log "No YAML frontmatter changes needed: $file"
    fi
}

find_markdown_files_for_enforcement() {
    local include_patterns=(
        "$PROJECT_ROOT/docs/**/*.md"
        "$PROJECT_ROOT/agents/**/*.md"
        "$PROJECT_ROOT/commands/**/*.md"
        "$PROJECT_ROOT/planning/**/*.md"
        "$PROJECT_ROOT/operations/**/*.md"
    )
    
    local exclude_patterns=(
        "*/backups/*"
        "*/node_modules/*"
        "*/\.git/*"
        "*/ide/*"
        "*/.DS_Store"
    )
    
    # Find markdown files with include/exclude patterns
    find "$PROJECT_ROOT" -name "*.md" -type f | grep -v -E "($(IFS='|'; echo "${exclude_patterns[*]}"))" | head -n "$MAX_FILES_PER_RUN"
}

execute_yaml_frontmatter_enforcement() {
    log "Starting YAML frontmatter enforcement"
    log "Mode: $([ "$DRY_RUN" == "true" ] && echo "DRY RUN" || echo "LIVE")"
    log "Max files per run: $MAX_FILES_PER_RUN"
    
    local file_count=0
    while IFS= read -r -d '' file; do
        file_count=$((file_count + 1))
        
        if [[ $file_count -gt $MAX_FILES_PER_RUN ]]; then
            log "Reached maximum files per run limit: $MAX_FILES_PER_RUN"
            break
        fi
        
        process_markdown_file "$file"
        
    done < <(find_markdown_files_for_enforcement | tr '\n' '\0')
    
    log "YAML frontmatter enforcement completed"
    log "Files processed: ${METRICS["files_processed"]}"
    log "Files modified: ${METRICS["files_modified"]}"
    log "Frontmatter added: ${METRICS["frontmatter_added"]}"
    log "Fields added: ${METRICS["fields_added"]}"
    log "Fields corrected: ${METRICS["fields_corrected"]}"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    mkdir -p "$(dirname "$LOG_FILE")" "$BACKUP_DIR"
    
    log "YAML Frontmatter Enforcer starting"
    log "Project root: $PROJECT_ROOT"
    log "Dry run: $DRY_RUN"
    
    execute_yaml_frontmatter_enforcement
    
    # Output metrics for orchestrator
    echo "CORRECTIONS_MADE:${METRICS["fields_added"]} + ${METRICS["fields_corrected"]}"
    echo "FILES_MODIFIED:${METRICS["files_modified"]}"
    
    log "YAML Frontmatter Enforcer completed successfully"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi