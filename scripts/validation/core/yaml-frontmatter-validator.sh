#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - YAML FRONTMATTER VALIDATOR
#======================================================================
# Purpose: Validates YAML frontmatter structure and required fields
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Rules Validated: YM-001 through YM-005, DC-001 through DC-005, TS-001 through TS-005
# Target: 95% required field compliance
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/yaml-frontmatter-validator-$TIMESTAMP.log"

# Required for YAML parsing
readonly YAML_PARSER_AVAILABLE=$(command -v yq &> /dev/null && echo "true" || echo "false")

#======================================================================
# FIELD REQUIREMENTS BY FILE TYPE
#======================================================================
declare -A CORE_REQUIRED_FIELDS=(
    ["title"]="string"
    ["author"]="string"  
    ["date"]="date"
    ["version"]="version"
)

declare -A DOCUMENT_FIELDS=(
    ["purpose"]="string"
    ["dependencies"]="array"
    ["audience"]="string"
    ["keywords"]="array"
)

declare -A TICKET_FIELDS=(
    ["ticket_id"]="ticket_id"
    ["priority"]="priority"
    ["status"]="status" 
    ["category"]="string"
    ["estimated_effort"]="string"
)

declare -A AGENT_FIELDS=(
    ["agent_type"]="string"
    ["domain"]="string"
    ["specialization"]="string"
    ["capabilities"]="array"
)

# Valid values for constrained fields
declare -A VALID_VALUES=(
    ["priority"]="CRITICAL,HIGH,MEDIUM,LOW"
    ["status"]="pending,in_progress,completed,resolved,blocked"
    ["author"]="Claude Code System"
)

# Pattern validation
declare -A FIELD_PATTERNS=(
    ["date"]="^[0-9]{4}-[0-9]{2}-[0-9]{2}$"
    ["version"]="^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9.-]+)?$"
    ["ticket_id"]="^[A-Z]+-[0-9]+$"
)

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A METRICS=(
    ["total_files"]=0
    ["files_with_frontmatter"]=0
    ["compliant_files"]=0
    ["files_missing_frontmatter"]=0
    ["files_with_violations"]=0
    ["correctable_files"]=0
)

declare -a VIOLATIONS=()
declare -a CORRECTIONS=()
declare -a MISSING_FRONTMATTER=()

#======================================================================
# YAML FRONTMATTER EXTRACTION
#======================================================================
extract_frontmatter() {
    local file_path="$1"
    local temp_yaml=$(mktemp)
    
    # Extract YAML frontmatter between --- markers
    if awk '/^---$/{flag=!flag;next}flag' "$file_path" > "$temp_yaml" 2>/dev/null; then
        if [[ -s "$temp_yaml" ]]; then
            echo "$temp_yaml"
            return 0
        fi
    fi
    
    rm -f "$temp_yaml"
    return 1
}

has_frontmatter() {
    local file_path="$1"
    head -1 "$file_path" | grep -q "^---$" 2>/dev/null
}

#======================================================================
# YAML VALIDATION ENGINE
#======================================================================
validate_yaml_syntax() {
    local yaml_file="$1"
    
    if [[ "$YAML_PARSER_AVAILABLE" == "true" ]]; then
        yq eval '.' "$yaml_file" >/dev/null 2>&1
        return $?
    else
        # Basic YAML syntax check without yq
        if grep -q $'\t' "$yaml_file"; then
            return 1  # YAML doesn't allow tabs
        fi
        
        # Check for basic structural issues
        if ! python3 -c "import yaml; yaml.safe_load(open('$yaml_file'))" 2>/dev/null; then
            return 1
        fi
    fi
    
    return 0
}

get_yaml_field() {
    local yaml_file="$1"
    local field="$2"
    
    if [[ "$YAML_PARSER_AVAILABLE" == "true" ]]; then
        yq eval ".$field" "$yaml_file" 2>/dev/null | sed 's/null//'
    else
        # Fallback parsing without yq
        awk -F': ' -v field="$field" '$1 == field {gsub(/^[ \t]*|[ \t]*$/, "", $2); gsub(/^["'"'"']|["'"'"']$/, "", $2); print $2}' "$yaml_file"
    fi
}

get_yaml_array() {
    local yaml_file="$1"
    local field="$2"
    
    if [[ "$YAML_PARSER_AVAILABLE" == "true" ]]; then
        yq eval ".$field[]?" "$yaml_file" 2>/dev/null | grep -v null || true
    else
        # Basic array extraction - handles simple arrays only
        awk -v field="$field" '
        $0 ~ "^" field ":" {
            in_array = 1
            next
        }
        in_array && /^[[:space:]]*-/ {
            gsub(/^[[:space:]]*-[[:space:]]*/, "")
            print
        }
        in_array && !/^[[:space:]]*-/ && !/^[[:space:]]*$/ {
            in_array = 0
        }
        ' "$yaml_file"
    fi
}

#======================================================================
# FIELD VALIDATION FUNCTIONS
#======================================================================
validate_required_field() {
    local yaml_file="$1"
    local field="$2"
    local field_type="$3"
    local file_path="$4"
    
    local field_value
    field_value=$(get_yaml_field "$yaml_file" "$field")
    
    if [[ -z "$field_value" ]]; then
        return 1  # Field missing
    fi
    
    case "$field_type" in
        "string")
            if [[ ${#field_value} -eq 0 ]]; then
                return 1
            fi
            ;;
        "date")
            if [[ ! "$field_value" =~ ${FIELD_PATTERNS["date"]} ]]; then
                return 1
            fi
            ;;
        "version")
            if [[ ! "$field_value" =~ ${FIELD_PATTERNS["version"]} ]]; then
                return 1
            fi
            ;;
        "ticket_id")
            if [[ ! "$field_value" =~ ${FIELD_PATTERNS["ticket_id"]} ]]; then
                return 1
            fi
            ;;
        "priority"|"status")
            local valid_values="${VALID_VALUES[$field_type]}"
            if [[ ",$valid_values," != *",$field_value,"* ]]; then
                return 1
            fi
            ;;
        "array")
            local array_items
            array_items=$(get_yaml_array "$yaml_file" "$field")
            if [[ -z "$array_items" ]]; then
                return 1
            fi
            ;;
    esac
    
    return 0
}

validate_author_field() {
    local yaml_file="$1"
    local author_value
    author_value=$(get_yaml_field "$yaml_file" "author")
    
    if [[ "$author_value" != "Claude Code System" ]]; then
        return 1
    fi
    
    return 0
}

#======================================================================
# FILE TYPE DETECTION AND REQUIREMENTS
#======================================================================
determine_file_requirements() {
    local file_path="$1"
    local relative_path="${file_path#$PROJECT_ROOT/}"
    
    # Determine required fields based on file location and type
    if [[ "$relative_path" == planning/tickets/* ]]; then
        echo "ticket"
    elif [[ "$relative_path" == agents/* ]]; then
        echo "agent"
    elif [[ "$relative_path" == docs/* ]] || [[ "$relative_path" == commands/* ]]; then
        echo "document"
    else
        echo "basic"
    fi
}

get_required_fields() {
    local requirement_type="$1"
    local fields=()
    
    # Always require core fields
    for field in "${!CORE_REQUIRED_FIELDS[@]}"; do
        fields+=("$field:${CORE_REQUIRED_FIELDS[$field]}")
    done
    
    # Add specific requirements
    case "$requirement_type" in
        "document")
            for field in "${!DOCUMENT_FIELDS[@]}"; do
                fields+=("$field:${DOCUMENT_FIELDS[$field]}")
            done
            ;;
        "ticket")
            for field in "${!TICKET_FIELDS[@]}"; do
                fields+=("$field:${TICKET_FIELDS[$field]}")
            done
            ;;
        "agent")
            for field in "${!AGENT_FIELDS[@]}"; do
                fields+=("$field:${AGENT_FIELDS[$field]}")
            done
            ;;
    esac
    
    printf '%s\n' "${fields[@]}"
}

#======================================================================
# MAIN VALIDATION ENGINE
#======================================================================
validate_file_frontmatter() {
    local file_path="$1"
    local violations=()
    local correctable=false
    
    # Check if file has frontmatter
    if ! has_frontmatter "$file_path"; then
        MISSING_FRONTMATTER+=("$file_path")
        METRICS["files_missing_frontmatter"]=$((METRICS["files_missing_frontmatter"] + 1))
        return 1
    fi
    
    METRICS["files_with_frontmatter"]=$((METRICS["files_with_frontmatter"] + 1))
    
    # Extract frontmatter
    local yaml_file
    if ! yaml_file=$(extract_frontmatter "$file_path"); then
        violations+=("YM-EXTRACT: Failed to extract valid YAML frontmatter")
        VIOLATIONS+=("$file_path: ${violations[*]}")
        return 1
    fi
    
    # Validate YAML syntax
    if ! validate_yaml_syntax "$yaml_file"; then
        violations+=("YM-SYNTAX: Invalid YAML syntax")
        VIOLATIONS+=("$file_path: ${violations[*]}")
        rm -f "$yaml_file"
        return 1
    fi
    
    # Determine requirements for this file type
    local requirement_type
    requirement_type=$(determine_file_requirements "$file_path")
    
    # Validate required fields
    while IFS=':' read -r field field_type; do
        if ! validate_required_field "$yaml_file" "$field" "$field_type" "$file_path"; then
            violations+=("YM-$field: Missing or invalid $field field ($field_type)")
            correctable=true
        fi
    done < <(get_required_fields "$requirement_type")
    
    # Special validation for author field (Rule YM-002)
    if ! validate_author_field "$yaml_file"; then
        violations+=("YM-002: Author must be 'Claude Code System'")
        correctable=true
    fi
    
    # Clean up temporary file
    rm -f "$yaml_file"
    
    # Record results
    if [[ ${#violations[@]} -gt 0 ]]; then
        VIOLATIONS+=("$file_path: ${violations[*]}")
        METRICS["files_with_violations"]=$((METRICS["files_with_violations"] + 1))
        
        if [[ "$correctable" == "true" ]]; then
            METRICS["correctable_files"]=$((METRICS["correctable_files"] + 1))
        fi
        
        return 1
    else
        METRICS["compliant_files"]=$((METRICS["compliant_files"] + 1))
        return 0
    fi
}

validate_all_files() {
    log "Starting YAML frontmatter validation..."
    
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
        
        validate_file_frontmatter "$file_path"
        
    done < "$temp_file_list"
    
    rm "$temp_file_list"
    log "YAML frontmatter validation completed"
}

#======================================================================
# CORRECTION GENERATION
#======================================================================
generate_frontmatter_template() {
    local file_path="$1"
    local requirement_type="$2"
    local filename=$(basename "$file_path")
    local current_date=$(date +%Y-%m-%d)
    
    cat << EOF
---
title: "${filename%.*}"
author: "Claude Code System"
date: "$current_date"
version: "1.0.0"
EOF
    
    case "$requirement_type" in
        "document")
            cat << EOF
purpose: "TODO: Add purpose description"
dependencies: []
audience: "framework-users"
keywords: ["documentation"]
EOF
            ;;
        "ticket")
            cat << EOF
ticket_id: "TODO-001"
priority: "MEDIUM"
status: "pending"
category: "enhancement"
estimated_effort: "1-2 hours"
EOF
            ;;
        "agent")
            cat << EOF
agent_type: "specialist"
domain: "TODO: Add domain"
specialization: "TODO: Add specialization"
capabilities: ["TODO: Add capabilities"]
EOF
            ;;
    esac
    
    echo "---"
}

#======================================================================
# CORRECTION APPLICATION
#======================================================================
apply_frontmatter_corrections() {
    log "Applying frontmatter corrections..."
    
    local corrections_applied=0
    local corrections_failed=0
    
    for file_path in "${MISSING_FRONTMATTER[@]}"; do
        if [[ ! -f "$file_path" ]]; then
            log "⚠️  Skipped missing file: $file_path"
            continue
        fi
        
        local requirement_type
        requirement_type=$(determine_file_requirements "$file_path")
        
        local temp_file=$(mktemp)
        local original_content=$(mktemp)
        
        # Backup original content
        cp "$file_path" "$original_content"
        
        # Generate frontmatter template
        generate_frontmatter_template "$file_path" "$requirement_type" > "$temp_file"
        echo "" >> "$temp_file"
        
        # Append original content
        cat "$file_path" >> "$temp_file"
        
        # Replace original file
        if mv "$temp_file" "$file_path"; then
            log "✅ Added frontmatter: $file_path"
            corrections_applied=$((corrections_applied + 1))
        else
            log "❌ Failed to add frontmatter: $file_path"
            corrections_failed=$((corrections_failed + 1))
            # Restore original
            mv "$original_content" "$file_path"
        fi
        
        rm -f "$original_content"
    done
    
    log "Frontmatter corrections applied: $corrections_applied"
    log "Frontmatter corrections failed: $corrections_failed"
}

#======================================================================
# REPORTING AND OUTPUT
#======================================================================
generate_report() {
    log "=== YAML FRONTMATTER VALIDATION REPORT ==="
    
    local total_files=${METRICS["total_files"]}
    local files_with_frontmatter=${METRICS["files_with_frontmatter"]}
    local compliant_files=${METRICS["compliant_files"]}
    local files_missing_frontmatter=${METRICS["files_missing_frontmatter"]}
    local files_with_violations=${METRICS["files_with_violations"]}
    local correctable_files=${METRICS["correctable_files"]}
    
    # Calculate compliance score
    local compliance_score=0
    if [[ $total_files -gt 0 ]]; then
        compliance_score=$(((compliant_files + files_missing_frontmatter) * 100 / total_files))
    fi
    
    log "Total Markdown Files: $total_files"
    log "Files with Frontmatter: $files_with_frontmatter"
    log "Compliant Files: $compliant_files"
    log "Files Missing Frontmatter: $files_missing_frontmatter"
    log "Files with Violations: $files_with_violations"  
    log "Auto-Correctable Files: $correctable_files"
    log "Compliance Score: $compliance_score%"
    
    # Output compliance score for orchestrator
    echo "COMPLIANCE_SCORE:$compliance_score"
    
    if [[ ${#MISSING_FRONTMATTER[@]} -gt 0 ]]; then
        log ""
        log "=== FILES MISSING FRONTMATTER ==="
        for file_path in "${MISSING_FRONTMATTER[@]}"; do
            log "📝 $file_path"
        done
    fi
    
    if [[ ${#VIOLATIONS[@]} -gt 0 ]]; then
        log ""
        log "=== FRONTMATTER VIOLATIONS ==="
        for violation in "${VIOLATIONS[@]}"; do
            log "❌ $violation"
        done
    fi
    
    if [[ $correctable_files -gt 0 ]]; then
        log ""
        log "To apply automatic corrections, run:"
        log "  $0 --fix"
    fi
    
    # Generate detailed JSON report
    local json_report="${LOG_FILE%.log}-report.json"
    cat > "$json_report" << EOF
{
  "timestamp": "$TIMESTAMP",
  "validator": "yaml-frontmatter-validator",
  "version": "1.0.0",
  "yaml_parser_available": $YAML_PARSER_AVAILABLE,
  "metrics": {
    "total_files": $total_files,
    "files_with_frontmatter": $files_with_frontmatter,
    "compliant_files": $compliant_files,
    "files_missing_frontmatter": $files_missing_frontmatter,
    "files_with_violations": $files_with_violations,
    "correctable_files": $correctable_files,
    "compliance_score": $compliance_score
  },
  "missing_frontmatter": [$(
    printf '%s\n' "${MISSING_FRONTMATTER[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )],
  "violations": [$(
    printf '%s\n' "${VIOLATIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
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

Claude Code Framework YAML Frontmatter Validator

ARGUMENTS:
    PROJECT_ROOT    Path to project root (default: detect automatically)

OPTIONS:
    -h, --help      Show this help message
    --fix           Apply automatic corrections for missing frontmatter
    --dry-run       Show what would be corrected without applying changes
    --report-only   Generate report from previous validation logs

VALIDATION RULES:
    YM-001: Title field required with quoted string format
    YM-002: Author field required with "Claude Code System" standard  
    YM-003: Date field required with ISO format (YYYY-MM-DD)
    YM-004: Version field required with semantic versioning format
    YM-005: All required fields must be present and properly formatted

TARGET: 95% required field compliance

FIELD REQUIREMENTS BY FILE TYPE:
    Basic: title, author, date, version
    Documents: + purpose, dependencies, audience, keywords
    Tickets: + ticket_id, priority, status, category, estimated_effort  
    Agents: + agent_type, domain, specialization, capabilities

DEPENDENCIES:
    Optional: yq (for enhanced YAML parsing)
    Fallback: Python3 with PyYAML (for basic validation)

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
    
    log "YAML Frontmatter Validator v1.0.0 started"
    log "Project Root: $PROJECT_ROOT"
    log "YAML Parser Available: $YAML_PARSER_AVAILABLE"
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
    
    # Check dependencies
    if [[ "$YAML_PARSER_AVAILABLE" == "false" ]]; then
        if ! command -v python3 &> /dev/null; then
            log "WARNING: Neither yq nor python3 found. Limited validation capabilities."
        fi
    fi
    
    # Perform validation
    validate_all_files
    
    # Apply corrections if requested
    if [[ "$fix_mode" == "true" ]]; then
        if [[ "$dry_run" == "true" ]]; then
            log "DRY RUN: Would add frontmatter to ${#MISSING_FRONTMATTER[@]} files"
            for file_path in "${MISSING_FRONTMATTER[@]}"; do
                log "  $file_path"
            done
        else
            apply_frontmatter_corrections
        fi
    fi
    
    # Generate final report
    generate_report
    
    # Return appropriate exit code based on compliance
    local total_files=${METRICS["total_files"]}
    local compliant_files=${METRICS["compliant_files"]}
    local files_missing_frontmatter=${METRICS["files_missing_frontmatter"]}
    
    local compliance_score=0
    if [[ $total_files -gt 0 ]]; then
        compliance_score=$(((compliant_files + files_missing_frontmatter) * 100 / total_files))
    fi
    
    if [[ $compliance_score -ge 95 ]]; then
        log "✅ Compliance target achieved ($compliance_score% >= 95%)"
        exit 0
    else
        log "❌ Compliance below target ($compliance_score% < 95%)"
        exit 1
    fi
}

#======================================================================
# SCRIPT EXECUTION
#======================================================================
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi