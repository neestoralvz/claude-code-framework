#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - CROSS-REFERENCE VALIDATOR
#======================================================================
# Purpose: Validates cross-reference integrity and principle references
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Rules Validated: CR-001 through CR-005, LI-001 through LI-005
# Target: 90% cross-reference integrity
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/cross-reference-validator-$TIMESTAMP.log"

#======================================================================
# CROSS-REFERENCE VALIDATION RULES
#======================================================================

# Principle Reference Format Rules (CR-001 through CR-005)
declare -A PRINCIPLE_RULES=(
    ["CR-001"]="Format: ⏺ **Principle**: This component implements [principle-name.md](path) by [description]"
    ["CR-002"]="Clear principle name statement required"
    ["CR-003"]="Implementation description explanation required"
    ["CR-004"]="Relevance justification specified"
    ["CR-005"]="Explicit language pattern usage"
)

# Link Integrity Standards (LI-001 through LI-005)
declare -A INTEGRITY_RULES=(
    ["LI-001"]="Link integrity checking for all internal links"
    ["LI-002"]="Anchor validation for section references"
    ["LI-003"]="Path verification for file references"
    ["LI-004"]="Automated cross-reference scanning"
    ["LI-005"]="Broken link identification and reporting"
)

# Pattern definitions
readonly PRINCIPLE_MARKER_PATTERN='⏺[[:space:]]*\*\*Principle\*\*:[[:space:]]*'
readonly PRINCIPLE_REFERENCE_PATTERN='⏺[[:space:]]*\*\*Principle\*\*:[[:space:]]*.*\[.*\]\(.*\.md.*\)'
readonly CROSS_REFERENCE_PATTERN='\[.*\]\([^)]*\.md[^)]*\)'
readonly INTERNAL_REFERENCE_PATTERN='\[.*\]\(#[^)]*\)'

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A METRICS=(
    ["total_files"]=0
    ["files_with_principles"]=0
    ["files_with_cross_refs"]=0
    ["total_principle_refs"]=0
    ["valid_principle_refs"]=0
    ["invalid_principle_refs"]=0
    ["total_cross_refs"]=0
    ["valid_cross_refs"]=0
    ["broken_cross_refs"]=0
    ["missing_descriptions"]=0
    ["correctable_refs"]=0
)

declare -a PRINCIPLE_VIOLATIONS=()
declare -a CROSS_REF_VIOLATIONS=()
declare -a REFERENCE_CORRECTIONS=()

#======================================================================
# PRINCIPLE DISCOVERY AND MAPPING
#======================================================================
discover_principles() {
    local principles_file=$(mktemp)
    
    # Find all principle files
    find "$PROJECT_ROOT/docs/principles" -name "*.md" -type f 2>/dev/null | while read -r principle_file; do
        local principle_name
        principle_name=$(basename "$principle_file" .md)
        
        # Extract principle title from file
        local principle_title
        principle_title=$(grep -m1 '^#[[:space:]]' "$principle_file" 2>/dev/null | sed 's/^#[[:space:]]*//' || echo "$principle_name")
        
        echo "$principle_name:$principle_file:$principle_title"
    done > "$principles_file"
    
    echo "$principles_file"
}

#======================================================================
# PRINCIPLE REFERENCE VALIDATION
#======================================================================
validate_principle_reference() {
    local file_path="$1"
    local line_num="$2"
    local reference_text="$3"
    local violations=()
    
    # Rule CR-001: Validate format pattern
    if [[ ! "$reference_text" =~ $PRINCIPLE_REFERENCE_PATTERN ]]; then
        violations+=("CR-001: Invalid principle reference format")
    fi
    
    # Extract components
    local principle_link
    principle_link=$(echo "$reference_text" | grep -o '\[.*\](.*\.md[^)]*)' || echo "")
    
    if [[ -n "$principle_link" ]]; then
        local link_text
        local link_path
        link_text=$(echo "$principle_link" | sed -n 's/\[\([^\]]*\)\].*/\1/p')
        link_path=$(echo "$principle_link" | sed -n 's/.*(\([^)]*\)).*/\1/p')
        
        # Rule CR-002: Clear principle name statement
        if [[ -z "$link_text" ]] || [[ ! "$link_text" =~ [a-zA-Z] ]]; then
            violations+=("CR-002: Missing clear principle name statement")
        fi
        
        # Validate principle file exists
        local resolved_path
        resolved_path=$(resolve_principle_path "$file_path" "$link_path")
        
        if [[ -z "$resolved_path" ]] || [[ ! -f "$resolved_path" ]]; then
            violations+=("LI-003: Principle file not found: $link_path")
        fi
        
        # Rule CR-003: Implementation description required
        if [[ ! "$reference_text" =~ by[[:space:]]+[a-zA-Z] ]]; then
            violations+=("CR-003: Missing implementation description after 'by'")
        fi
        
        # Rule CR-004: Relevance justification
        local description
        description=$(echo "$reference_text" | sed -n 's/.*by[[:space:]]\+\(.*\)/\1/p')
        
        if [[ -n "$description" ]]; then
            if [[ ${#description} -lt 10 ]]; then
                violations+=("CR-004: Relevance justification too brief (minimum 10 characters)")
            fi
        fi
    else
        violations+=("CR-001: No valid principle link found in reference")
    fi
    
    echo "${violations[@]}"
}

resolve_principle_path() {
    local source_file="$1"
    local principle_path="$2"
    local source_dir
    source_dir=$(dirname "$source_file")
    
    # Handle relative paths
    if [[ "$principle_path" =~ ^\.\./ ]] || [[ "$principle_path" =~ ^\./ ]]; then
        local resolved
        resolved=$(cd "$source_dir" && realpath "$principle_path" 2>/dev/null | cut -d'#' -f1)
        if [[ -n "$resolved" && -f "$resolved" ]]; then
            echo "$resolved"
            return
        fi
    fi
    
    # Handle absolute paths within project
    if [[ "$principle_path" =~ ^/ ]]; then
        local absolute_path="$PROJECT_ROOT${principle_path%#*}"
        if [[ -f "$absolute_path" ]]; then
            echo "$absolute_path"
            return
        fi
    fi
    
    # Handle direct principle references
    local direct_path="$PROJECT_ROOT/docs/principles/${principle_path%#*}"
    if [[ -f "$direct_path" ]]; then
        echo "$direct_path"
        return
    fi
    
    echo ""
}

#======================================================================
# CROSS-REFERENCE VALIDATION
#======================================================================
validate_cross_reference() {
    local source_file="$1"
    local reference="$2"
    local violations=()
    
    # Extract link components
    local link_text
    local link_path
    link_text=$(echo "$reference" | sed -n 's/\[\([^\]]*\)\].*/\1/p')
    link_path=$(echo "$reference" | sed -n 's/.*(\([^)]*\)).*/\1/p')
    
    # Rule LI-003: Path verification
    local resolved_path
    resolved_path=$(resolve_cross_reference_path "$source_file" "$link_path")
    
    if [[ -z "$resolved_path" ]] || [[ ! -f "$resolved_path" ]]; then
        violations+=("LI-003: Referenced file not found: $link_path")
        return 1
    fi
    
    # Rule LI-002: Anchor validation for section references
    if [[ "$link_path" =~ #(.+)$ ]]; then
        local anchor="${BASH_REMATCH[1]}"
        
        # Validate anchor exists in target file
        if ! validate_anchor_exists "$resolved_path" "$anchor"; then
            violations+=("LI-002: Anchor '$anchor' not found in target file")
        fi
    fi
    
    # Check if link text provides clear context
    if [[ -z "$link_text" ]] || [[ ${#link_text} -lt 3 ]]; then
        violations+=("CROSS-REF: Link text too brief or missing")
    fi
    
    if [[ ${#violations[@]} -gt 0 ]]; then
        echo "${violations[@]}"
        return 1
    fi
    
    return 0
}

resolve_cross_reference_path() {
    local source_file="$1"
    local ref_path="$2"
    local source_dir
    source_dir=$(dirname "$source_file")
    
    # Remove anchor for file resolution
    local file_path="${ref_path%#*}"
    
    # Handle relative paths
    if [[ "$file_path" =~ ^\.\./ ]] || [[ "$file_path" =~ ^\./ ]]; then
        local resolved
        resolved=$(cd "$source_dir" && realpath "$file_path" 2>/dev/null)
        if [[ -n "$resolved" && -f "$resolved" ]]; then
            echo "$resolved"
            return
        fi
    fi
    
    # Handle absolute paths within project
    if [[ "$file_path" =~ ^/ ]]; then
        local absolute_path="$PROJECT_ROOT$file_path"
        if [[ -f "$absolute_path" ]]; then
            echo "$absolute_path"
            return
        fi
    fi
    
    # Handle direct references (try common locations)
    local common_locations=(
        "$PROJECT_ROOT/$file_path"
        "$PROJECT_ROOT/docs/$file_path"
        "$PROJECT_ROOT/commands/$file_path"
        "$PROJECT_ROOT/agents/$file_path"
    )
    
    for location in "${common_locations[@]}"; do
        if [[ -f "$location" ]]; then
            echo "$location"
            return
        fi
    done
    
    echo ""
}

validate_anchor_exists() {
    local file_path="$1"
    local anchor="$2"
    
    # Convert anchor to various possible heading formats
    local heading_variants=(
        "$(echo "$anchor" | tr '-' ' ')"
        "$(echo "$anchor" | tr '-' ' ' | sed 's/\b\w/\U&/g')"  # Title Case
        "$anchor"
    )
    
    for variant in "${heading_variants[@]}"; do
        # Check for markdown headings
        if grep -qi "^#.*$variant" "$file_path"; then
            return 0
        fi
        
        # Check for HTML anchors
        if grep -qi "id=[\"']$anchor[\"']" "$file_path" || \
           grep -qi "name=[\"']$anchor[\"']" "$file_path" || \
           grep -qi "{#$anchor}" "$file_path"; then
            return 0
        fi
    done
    
    return 1
}

#======================================================================
# INTERNAL REFERENCE VALIDATION
#======================================================================
validate_internal_references() {
    local file_path="$1"
    local violations=()
    
    # Find all internal anchor references
    while IFS=: read -r line_num reference; do
        local anchor
        anchor=$(echo "$reference" | sed -n 's/.*(\(#[^)]*\)).*/\1/p')
        
        if [[ -n "$anchor" ]]; then
            local anchor_name="${anchor#\#}"
            
            if ! validate_anchor_exists "$file_path" "$anchor_name"; then
                violations+=("LI-002: Line $line_num - Internal anchor '$anchor' not found in document")
            fi
        fi
    done < <(grep -n "$INTERNAL_REFERENCE_PATTERN" "$file_path" 2>/dev/null)
    
    echo "${violations[@]}"
}

#======================================================================
# FILE VALIDATION ENGINE
#======================================================================
validate_file_cross_references() {
    local file_path="$1"
    local has_violations=false
    local file_violations=()
    
    # Validate principle references
    local principle_line_num=0
    while IFS= read -r line; do
        principle_line_num=$((principle_line_num + 1))
        
        if [[ "$line" =~ $PRINCIPLE_MARKER_PATTERN ]]; then
            METRICS["files_with_principles"]=$((METRICS["files_with_principles"] + 1))
            METRICS["total_principle_refs"]=$((METRICS["total_principle_refs"] + 1))
            
            local principle_violations
            principle_violations=$(validate_principle_reference "$file_path" "$principle_line_num" "$line")
            
            if [[ -n "$principle_violations" && "$principle_violations" != " " ]]; then
                has_violations=true
                PRINCIPLE_VIOLATIONS+=("$file_path:$principle_line_num: $principle_violations")
                METRICS["invalid_principle_refs"]=$((METRICS["invalid_principle_refs"] + 1))
                
                # Generate correction if possible
                if [[ "$principle_violations" =~ CR-003 ]]; then
                    REFERENCE_CORRECTIONS+=("$file_path:$principle_line_num:ADD_DESCRIPTION")
                    METRICS["correctable_refs"]=$((METRICS["correctable_refs"] + 1))
                fi
            else
                METRICS["valid_principle_refs"]=$((METRICS["valid_principle_refs"] + 1))
            fi
        fi
    done < "$file_path"
    
    # Validate cross-references to other documents
    local cross_ref_count=0
    while IFS=: read -r line_num reference; do
        cross_ref_count=$((cross_ref_count + 1))
        
        local cross_ref_violations
        cross_ref_violations=$(validate_cross_reference "$file_path" "$reference")
        
        if [[ -n "$cross_ref_violations" && "$cross_ref_violations" != " " ]]; then
            has_violations=true
            CROSS_REF_VIOLATIONS+=("$file_path:$line_num: $reference - $cross_ref_violations")
            METRICS["broken_cross_refs"]=$((METRICS["broken_cross_refs"] + 1))
        else
            METRICS["valid_cross_refs"]=$((METRICS["valid_cross_refs"] + 1))
        fi
    done < <(grep -n "$CROSS_REFERENCE_PATTERN" "$file_path" 2>/dev/null)
    
    if [[ $cross_ref_count -gt 0 ]]; then
        METRICS["files_with_cross_refs"]=$((METRICS["files_with_cross_refs"] + 1))
        METRICS["total_cross_refs"]=$((METRICS["total_cross_refs"] + cross_ref_count))
    fi
    
    # Validate internal references
    local internal_violations
    internal_violations=$(validate_internal_references "$file_path")
    
    if [[ -n "$internal_violations" && "$internal_violations" != " " ]]; then
        has_violations=true
        CROSS_REF_VIOLATIONS+=("$file_path: Internal references - $internal_violations")
    fi
    
    return $([[ "$has_violations" == "false" ]] && echo 0 || echo 1)
}

validate_all_files() {
    log "Starting cross-reference validation..."
    
    # Discover available principles
    local principles_file
    principles_file=$(discover_principles)
    local principle_count
    principle_count=$(wc -l < "$principles_file" 2>/dev/null || echo "0")
    log "Discovered $principle_count principle files"
    
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
        
        validate_file_cross_references "$file_path"
        
    done < "$temp_file_list"
    
    rm -f "$temp_file_list" "$principles_file"
    log "Cross-reference validation completed"
}

#======================================================================
# CORRECTION APPLICATION
#======================================================================
apply_cross_reference_corrections() {
    log "Applying cross-reference corrections..."
    
    local corrections_applied=0
    local corrections_failed=0
    
    for correction in "${REFERENCE_CORRECTIONS[@]}"; do
        local file_path="${correction%%:*}"
        local correction_data="${correction#*:}"
        IFS=':' read -r line_num correction_type <<< "$correction_data"
        
        case "$correction_type" in
            "ADD_DESCRIPTION")
                if add_principle_description "$file_path" "$line_num"; then
                    log "✅ Added principle description: $file_path:$line_num"
                    corrections_applied=$((corrections_applied + 1))
                else
                    log "❌ Failed to add principle description: $file_path:$line_num"
                    corrections_failed=$((corrections_failed + 1))
                fi
                ;;
        esac
    done
    
    log "Cross-reference corrections applied: $corrections_applied"
    log "Cross-reference corrections failed: $corrections_failed"
}

add_principle_description() {
    local file_path="$1"
    local line_num="$2"
    local temp_file=$(mktemp)
    local backup_file="$file_path.backup-$TIMESTAMP"
    
    # Create backup
    cp "$file_path" "$backup_file"
    
    # Add description to principle reference
    local current_line=1
    while IFS= read -r line; do
        if [[ $current_line -eq $line_num ]] && [[ "$line" =~ $PRINCIPLE_MARKER_PATTERN ]]; then
            # Add default implementation description
            if [[ ! "$line" =~ by[[:space:]]+[a-zA-Z] ]]; then
                line="$line by implementing the specified pattern and maintaining consistency with framework standards."
            fi
        fi
        
        echo "$line" >> "$temp_file"
        current_line=$((current_line + 1))
    done < "$file_path"
    
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
    log "=== CROSS-REFERENCE VALIDATION REPORT ==="
    
    local total_files=${METRICS["total_files"]}
    local files_with_principles=${METRICS["files_with_principles"]}
    local files_with_cross_refs=${METRICS["files_with_cross_refs"]}
    local total_principle_refs=${METRICS["total_principle_refs"]}
    local valid_principle_refs=${METRICS["valid_principle_refs"]}
    local invalid_principle_refs=${METRICS["invalid_principle_refs"]}
    local total_cross_refs=${METRICS["total_cross_refs"]}
    local valid_cross_refs=${METRICS["valid_cross_refs"]}
    local broken_cross_refs=${METRICS["broken_cross_refs"]}
    local correctable_refs=${METRICS["correctable_refs"]}
    
    # Calculate compliance scores
    local principle_compliance=100
    local cross_ref_compliance=100
    local overall_compliance=0
    
    if [[ $total_principle_refs -gt 0 ]]; then
        principle_compliance=$((valid_principle_refs * 100 / total_principle_refs))
    fi
    
    if [[ $total_cross_refs -gt 0 ]]; then
        cross_ref_compliance=$((valid_cross_refs * 100 / total_cross_refs))
    fi
    
    if [[ $((total_principle_refs + total_cross_refs)) -gt 0 ]]; then
        overall_compliance=$(((valid_principle_refs + valid_cross_refs) * 100 / (total_principle_refs + total_cross_refs)))
    elif [[ $total_files -gt 0 ]]; then
        overall_compliance=100  # No references = 100% compliant
    fi
    
    log "Total Markdown Files: $total_files"
    log "Files with Principle References: $files_with_principles"
    log "Files with Cross-References: $files_with_cross_refs"
    log "Total Principle References: $total_principle_refs"
    log "Valid Principle References: $valid_principle_refs"
    log "Invalid Principle References: $invalid_principle_refs"
    log "Total Cross-References: $total_cross_refs"
    log "Valid Cross-References: $valid_cross_refs"
    log "Broken Cross-References: $broken_cross_refs"
    log "Auto-Correctable References: $correctable_refs"
    log ""
    log "Principle Reference Compliance: $principle_compliance%"
    log "Cross-Reference Compliance: $cross_ref_compliance%"
    log "Overall Cross-Reference Compliance: $overall_compliance%"
    
    # Output compliance score for orchestrator
    echo "COMPLIANCE_SCORE:$overall_compliance"
    
    if [[ ${#PRINCIPLE_VIOLATIONS[@]} -gt 0 ]]; then
        log ""
        log "=== PRINCIPLE REFERENCE VIOLATIONS ==="
        for violation in "${PRINCIPLE_VIOLATIONS[@]}"; do
            log "❌ $violation"
        done
    fi
    
    if [[ ${#CROSS_REF_VIOLATIONS[@]} -gt 0 ]]; then
        log ""
        log "=== CROSS-REFERENCE VIOLATIONS ==="
        for violation in "${CROSS_REF_VIOLATIONS[@]}"; do
            log "❌ $violation"
        done
    fi
    
    if [[ ${#REFERENCE_CORRECTIONS[@]} -gt 0 ]]; then
        log ""
        log "=== SUGGESTED CORRECTIONS ==="
        for correction in "${REFERENCE_CORRECTIONS[@]}"; do
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
  "validator": "cross-reference-validator",
  "version": "1.0.0",
  "metrics": {
    "total_files": $total_files,
    "files_with_principles": $files_with_principles,
    "files_with_cross_refs": $files_with_cross_refs,
    "total_principle_refs": $total_principle_refs,
    "valid_principle_refs": $valid_principle_refs,
    "invalid_principle_refs": $invalid_principle_refs,
    "total_cross_refs": $total_cross_refs,
    "valid_cross_refs": $valid_cross_refs,
    "broken_cross_refs": $broken_cross_refs,
    "correctable_refs": $correctable_refs,
    "principle_compliance": $principle_compliance,
    "cross_ref_compliance": $cross_ref_compliance,
    "overall_compliance": $overall_compliance
  },
  "validation_rules": {$(
    for rule in "${!PRINCIPLE_RULES[@]}"; do
      echo "    \"$rule\": \"${PRINCIPLE_RULES[$rule]}\","
    done
    for rule in "${!INTEGRITY_RULES[@]}"; do
      echo "    \"$rule\": \"${INTEGRITY_RULES[$rule]}\","
    done | sed '$ s/,$//'
  )},
  "principle_violations": [$(
    printf '%s\n' "${PRINCIPLE_VIOLATIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )],
  "cross_ref_violations": [$(
    printf '%s\n' "${CROSS_REF_VIOLATIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )],
  "corrections": [$(
    printf '%s\n' "${REFERENCE_CORRECTIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
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

Claude Code Framework Cross-Reference Validator

VALIDATION RULES:
    Principle References (CR-001 to CR-005): Format, name, description, relevance
    Link Integrity (LI-001 to LI-005): Internal links, anchors, path verification

TARGET: 90% cross-reference integrity

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
    log "Cross-Reference Validator v1.0.0 started - Project Root: $PROJECT_ROOT"
    
    if [[ "$report_only" == "true" ]]; then
        generate_report; exit 0
    fi
    
    validate_all_files
    
    if [[ "$fix_mode" == "true" ]]; then
        if [[ "$dry_run" == "true" ]]; then
            log "DRY RUN: Would apply ${#REFERENCE_CORRECTIONS[@]} cross-reference corrections"
        else
            apply_cross_reference_corrections
        fi
    fi
    
    generate_report
    
    local total_refs=$((METRICS["total_principle_refs"] + METRICS["total_cross_refs"]))
    local valid_refs=$((METRICS["valid_principle_refs"] + METRICS["valid_cross_refs"]))
    
    local compliance_score=100
    if [[ $total_refs -gt 0 ]]; then
        compliance_score=$((valid_refs * 100 / total_refs))
    fi
    
    if [[ $compliance_score -ge 90 ]]; then
        log "✅ Cross-reference compliance achieved ($compliance_score% >= 90%)"
        exit 0
    else
        log "❌ Cross-reference compliance below target ($compliance_score% < 90%)"
        exit 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi