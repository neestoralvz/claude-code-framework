#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - TEMPLATE COMPLIANCE VALIDATOR
#======================================================================
# Purpose: Validates adherence to component templates and framework patterns
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Rules Validated: Template structure, component patterns, framework standards
# Target: 85% template compliance
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/template-compliance-validator-$TIMESTAMP.log"

#======================================================================
# TEMPLATE COMPLIANCE RULES AND PATTERNS
#======================================================================

# Template types and their expected structures
declare -A TEMPLATE_TYPES=(
    ["agent"]="agents/"
    ["command"]="commands/"
    ["component"]="docs/templates/components/"
    ["document"]="docs/"
    ["ticket"]="planning/tickets/"
    ["principle"]="docs/principles/"
)

# Required sections for each template type
declare -A REQUIRED_SECTIONS=(
    ["agent"]="Purpose,Domain,Specialization,Capabilities,Integration"
    ["command"]="Purpose,Usage,Arguments,Examples,Validation"
    ["component"]="Purpose,Implementation,Integration,Validation,Examples"
    ["document"]="Introduction,Content,Navigation,References"
    ["ticket"]="Summary,Requirements,Acceptance Criteria,Implementation"
    ["principle"]="Statement,Rationale,Implementation,Examples,Validation"
)

# Structural patterns for validation
readonly FRONTMATTER_START="^---$"
readonly FRONTMATTER_END="^---$"
readonly HEADING_PATTERN="^#{1,4}[[:space:]]"
readonly SECTION_ANCHOR_PATTERN="^#{2,4}[[:space:]].*{#[a-zA-Z0-9-_]+}$"
readonly COMPONENT_MARKER_PATTERN="^<!-- COMPONENT:"
readonly PRINCIPLE_MARKER_PATTERN="⏺[[:space:]]*\*\*Principle\*\*:"

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A METRICS=(
    ["total_files"]=0
    ["agent_files"]=0
    ["command_files"]=0
    ["component_files"]=0
    ["document_files"]=0
    ["ticket_files"]=0
    ["principle_files"]=0
    ["template_compliant"]=0
    ["template_violations"]=0
    ["missing_sections"]=0
    ["structure_violations"]=0
    ["correctable_templates"]=0
)

declare -a TEMPLATE_VIOLATIONS=()
declare -a TEMPLATE_CORRECTIONS=()

#======================================================================
# TEMPLATE DETECTION AND CLASSIFICATION
#======================================================================
determine_template_type() {
    local file_path="$1"
    local relative_path="${file_path#$PROJECT_ROOT/}"
    
    # Classify based on file location
    case "$relative_path" in
        agents/*)
            echo "agent"
            ;;
        commands/*)
            echo "command"
            ;;
        docs/templates/components/*)
            echo "component"
            ;;
        docs/principles/*)
            echo "principle"
            ;;
        planning/tickets/*)
            echo "ticket"
            ;;
        docs/*)
            echo "document"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

#======================================================================
# STRUCTURAL VALIDATION
#======================================================================
validate_frontmatter_structure() {
    local file_path="$1"
    local template_type="$2"
    local violations=()
    
    # Check for YAML frontmatter
    if ! head -1 "$file_path" | grep -q "$FRONTMATTER_START"; then
        violations+=("FRONTMATTER: Missing YAML frontmatter")
        return 1
    fi
    
    # Extract frontmatter
    local frontmatter_end_line
    frontmatter_end_line=$(tail -n +2 "$file_path" | grep -n "$FRONTMATTER_END" | head -1 | cut -d: -f1)
    
    if [[ -z "$frontmatter_end_line" ]]; then
        violations+=("FRONTMATTER: Malformed YAML frontmatter (missing end marker)")
        return 1
    fi
    
    frontmatter_end_line=$((frontmatter_end_line + 1))  # Adjust for skipped first line
    
    # Validate required frontmatter fields based on template type
    local frontmatter_content
    frontmatter_content=$(sed -n "2,${frontmatter_end_line}p" "$file_path")
    
    case "$template_type" in
        "agent")
            if ! echo "$frontmatter_content" | grep -q "^agent_type:"; then
                violations+=("AGENT-FM: Missing agent_type field")
            fi
            if ! echo "$frontmatter_content" | grep -q "^domain:"; then
                violations+=("AGENT-FM: Missing domain field")
            fi
            ;;
        "ticket")
            if ! echo "$frontmatter_content" | grep -q "^ticket_id:"; then
                violations+=("TICKET-FM: Missing ticket_id field")
            fi
            if ! echo "$frontmatter_content" | grep -q "^priority:"; then
                violations+=("TICKET-FM: Missing priority field")
            fi
            ;;
        "component")
            if ! echo "$frontmatter_content" | grep -q "^purpose:"; then
                violations+=("COMPONENT-FM: Missing purpose field")
            fi
            ;;
    esac
    
    if [[ ${#violations[@]} -gt 0 ]]; then
        echo "${violations[@]}"
        return 1
    fi
    
    return 0
}

validate_section_structure() {
    local file_path="$1"
    local template_type="$2"
    local violations=()
    
    # Get required sections for this template type
    local required_sections="${REQUIRED_SECTIONS[$template_type]:-}"
    
    if [[ -z "$required_sections" ]]; then
        return 0  # No specific requirements for this type
    fi
    
    # Extract document sections (H2 headings)
    local sections_found=()
    while IFS= read -r heading; do
        local section_title
        section_title=$(echo "$heading" | sed 's/^##[[:space:]]*//' | sed 's/{#.*}$//')
        sections_found+=("$section_title")
    done < <(grep "^##[[:space:]]" "$file_path" 2>/dev/null)
    
    # Check for required sections
    IFS=',' read -ra required_array <<< "$required_sections"
    for required_section in "${required_array[@]}"; do
        local section_found=false
        
        for found_section in "${sections_found[@]}"; do
            if [[ "$found_section" == *"$required_section"* ]] || [[ "$required_section" == *"$found_section"* ]]; then
                section_found=true
                break
            fi
        done
        
        if [[ "$section_found" == "false" ]]; then
            violations+=("SECTION: Missing required section '$required_section'")
        fi
    done
    
    if [[ ${#violations[@]} -gt 0 ]]; then
        echo "${violations[@]}"
        return 1
    fi
    
    return 0
}

#======================================================================
# PATTERN-SPECIFIC VALIDATION
#======================================================================
validate_agent_template() {
    local file_path="$1"
    local violations=()
    
    # Agent-specific validation
    if ! grep -q "## Purpose" "$file_path"; then
        violations+=("AGENT: Missing Purpose section")
    fi
    
    if ! grep -q "## Core Responsibilities" "$file_path" && ! grep -q "## Responsibilities" "$file_path"; then
        violations+=("AGENT: Missing Responsibilities section")
    fi
    
    if ! grep -q "## Integration Framework" "$file_path" && ! grep -q "## Integration" "$file_path"; then
        violations+=("AGENT: Missing Integration section")
    fi
    
    # Check for capability lists
    if ! grep -q "### Technology Stack" "$file_path" && ! grep -q "### Capabilities" "$file_path"; then
        violations+=("AGENT: Missing capabilities or technology stack section")
    fi
    
    echo "${violations[@]}"
}

validate_command_template() {
    local file_path="$1"
    local violations=()
    
    # Command-specific validation
    if ! grep -q "## Usage" "$file_path" && ! grep -q "## Syntax" "$file_path"; then
        violations+=("COMMAND: Missing Usage/Syntax section")
    fi
    
    if ! grep -q "## Examples" "$file_path"; then
        violations+=("COMMAND: Missing Examples section")
    fi
    
    if ! grep -q "## Arguments" "$file_path" && ! grep -q "## Parameters" "$file_path" && ! grep -q "## Options" "$file_path"; then
        violations+=("COMMAND: Missing Arguments/Parameters section")
    fi
    
    # Check for validation criteria
    if ! grep -q -i "validation" "$file_path"; then
        violations+=("COMMAND: Missing validation criteria or procedures")
    fi
    
    echo "${violations[@]}"
}

validate_component_template() {
    local file_path="$1"
    local violations=()
    
    # Component-specific validation
    if ! grep -q "$PRINCIPLE_MARKER_PATTERN" "$file_path"; then
        violations+=("COMPONENT: Missing principle reference marker")
    fi
    
    if ! grep -q "## Implementation" "$file_path"; then
        violations+=("COMPONENT: Missing Implementation section")
    fi
    
    if ! grep -q "## Usage" "$file_path" && ! grep -q "## Integration" "$file_path"; then
        violations+=("COMPONENT: Missing Usage/Integration section")
    fi
    
    # Check for component markers
    if ! grep -q "$COMPONENT_MARKER_PATTERN" "$file_path"; then
        violations+=("COMPONENT: Missing component identification markers")
    fi
    
    echo "${violations[@]}"
}

validate_ticket_template() {
    local file_path="$1"
    local violations=()
    
    # Ticket-specific validation
    if ! grep -q "## Summary" "$file_path" && ! grep -q "## Description" "$file_path"; then
        violations+=("TICKET: Missing Summary/Description section")
    fi
    
    if ! grep -q "## Acceptance Criteria" "$file_path" && ! grep -q "## Success Criteria" "$file_path"; then
        violations+=("TICKET: Missing Acceptance Criteria section")
    fi
    
    if ! grep -q "## Implementation" "$file_path" && ! grep -q "## Tasks" "$file_path"; then
        violations+=("TICKET: Missing Implementation/Tasks section")
    fi
    
    # Check for status tracking
    if ! grep -q "## Status" "$file_path"; then
        violations+=("TICKET: Missing Status section")
    fi
    
    echo "${violations[@]}"
}

#======================================================================
# NAVIGATION AND STRUCTURE VALIDATION
#======================================================================
validate_navigation_structure() {
    local file_path="$1"
    local violations=()
    
    # Check for breadcrumb navigation in first 10 lines
    if ! head -10 "$file_path" | grep -q "\[.*\](.*)" | head -1; then
        violations+=("NAVIGATION: Missing breadcrumb navigation")
    fi
    
    # Check for return-to-top links in long documents
    local file_lines
    file_lines=$(wc -l < "$file_path")
    
    if [[ $file_lines -gt 500 ]] && ! grep -q "⬆.*Return.*top" "$file_path"; then
        violations+=("NAVIGATION: Long document missing return-to-top links")
    fi
    
    # Check for table of contents in complex documents
    local heading_count
    heading_count=$(grep -c "^##[[:space:]]" "$file_path" 2>/dev/null || echo "0")
    
    if [[ $heading_count -gt 5 ]] && ! grep -q -i "table.*contents" "$file_path"; then
        violations+=("NAVIGATION: Complex document missing table of contents")
    fi
    
    echo "${violations[@]}"
}

#======================================================================
# FILE VALIDATION ENGINE
#======================================================================
validate_file_template_compliance() {
    local file_path="$1"
    local template_type
    template_type=$(determine_template_type "$file_path")
    local has_violations=false
    
    # Update file type metrics
    case "$template_type" in
        "agent") METRICS["agent_files"]=$((METRICS["agent_files"] + 1)) ;;
        "command") METRICS["command_files"]=$((METRICS["command_files"] + 1)) ;;
        "component") METRICS["component_files"]=$((METRICS["component_files"] + 1)) ;;
        "document") METRICS["document_files"]=$((METRICS["document_files"] + 1)) ;;
        "ticket") METRICS["ticket_files"]=$((METRICS["ticket_files"] + 1)) ;;
        "principle") METRICS["principle_files"]=$((METRICS["principle_files"] + 1)) ;;
        *) return 0 ;; # Skip unknown types
    esac
    
    local file_violations=()
    
    # Validate frontmatter structure
    local frontmatter_violations
    frontmatter_violations=$(validate_frontmatter_structure "$file_path" "$template_type")
    if [[ $? -ne 0 ]]; then
        has_violations=true
        file_violations+=("Frontmatter: $frontmatter_violations")
        METRICS["structure_violations"]=$((METRICS["structure_violations"] + 1))
    fi
    
    # Validate section structure
    local section_violations
    section_violations=$(validate_section_structure "$file_path" "$template_type")
    if [[ $? -ne 0 ]]; then
        has_violations=true
        file_violations+=("Sections: $section_violations")
        METRICS["missing_sections"]=$((METRICS["missing_sections"] + 1))
        
        # Generate correction for missing sections
        TEMPLATE_CORRECTIONS+=("$file_path:ADD_SECTIONS:$template_type")
        METRICS["correctable_templates"]=$((METRICS["correctable_templates"] + 1))
    fi
    
    # Template-specific validation
    local specific_violations=""
    case "$template_type" in
        "agent")
            specific_violations=$(validate_agent_template "$file_path")
            ;;
        "command")
            specific_violations=$(validate_command_template "$file_path")
            ;;
        "component")
            specific_violations=$(validate_component_template "$file_path")
            ;;
        "ticket")
            specific_violations=$(validate_ticket_template "$file_path")
            ;;
    esac
    
    if [[ -n "$specific_violations" && "$specific_violations" != " " ]]; then
        has_violations=true
        file_violations+=("Template-specific: $specific_violations")
    fi
    
    # Validate navigation structure
    local navigation_violations
    navigation_violations=$(validate_navigation_structure "$file_path")
    if [[ -n "$navigation_violations" && "$navigation_violations" != " " ]]; then
        has_violations=true
        file_violations+=("Navigation: $navigation_violations")
    fi
    
    # Record results
    if [[ "$has_violations" == "true" ]]; then
        TEMPLATE_VIOLATIONS+=("$file_path ($template_type): ${file_violations[*]}")
        METRICS["template_violations"]=$((METRICS["template_violations"] + 1))
        return 1
    else
        METRICS["template_compliant"]=$((METRICS["template_compliant"] + 1))
        return 0
    fi
}

validate_all_files() {
    log "Starting template compliance validation..."
    
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
        
        validate_file_template_compliance "$file_path"
        
    done < "$temp_file_list"
    
    rm "$temp_file_list"
    log "Template compliance validation completed"
}

#======================================================================
# CORRECTION APPLICATION
#======================================================================
apply_template_corrections() {
    log "Applying template compliance corrections..."
    
    local corrections_applied=0
    local corrections_failed=0
    
    for correction in "${TEMPLATE_CORRECTIONS[@]}"; do
        local file_path="${correction%%:*}"
        local correction_data="${correction#*:}"
        IFS=':' read -r correction_type template_type <<< "$correction_data"
        
        case "$correction_type" in
            "ADD_SECTIONS")
                if add_missing_sections "$file_path" "$template_type"; then
                    log "✅ Added missing sections: $file_path"
                    corrections_applied=$((corrections_applied + 1))
                else
                    log "❌ Failed to add sections: $file_path"
                    corrections_failed=$((corrections_failed + 1))
                fi
                ;;
        esac
    done
    
    log "Template corrections applied: $corrections_applied"
    log "Template corrections failed: $corrections_failed"
}

add_missing_sections() {
    local file_path="$1"
    local template_type="$2"
    local temp_file=$(mktemp)
    local backup_file="$file_path.backup-$TIMESTAMP"
    
    # Create backup
    cp "$file_path" "$backup_file"
    
    # Get required sections
    local required_sections="${REQUIRED_SECTIONS[$template_type]:-}"
    if [[ -z "$required_sections" ]]; then
        return 1
    fi
    
    # Copy original content
    cp "$file_path" "$temp_file"
    
    # Add missing sections at the end
    echo "" >> "$temp_file"
    echo "## TODO: Complete Missing Sections" >> "$temp_file"
    echo "" >> "$temp_file"
    
    IFS=',' read -ra required_array <<< "$required_sections"
    for section in "${required_array[@]}"; do
        if ! grep -q "## $section" "$file_path"; then
            echo "### $section" >> "$temp_file"
            echo "" >> "$temp_file"
            echo "TODO: Add $section content" >> "$temp_file"
            echo "" >> "$temp_file"
        fi
    done
    
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
    log "=== TEMPLATE COMPLIANCE VALIDATION REPORT ==="
    
    local total_files=${METRICS["total_files"]}
    local agent_files=${METRICS["agent_files"]}
    local command_files=${METRICS["command_files"]}
    local component_files=${METRICS["component_files"]}
    local document_files=${METRICS["document_files"]}
    local ticket_files=${METRICS["ticket_files"]}
    local principle_files=${METRICS["principle_files"]}
    local template_compliant=${METRICS["template_compliant"]}
    local template_violations=${METRICS["template_violations"]}
    local missing_sections=${METRICS["missing_sections"]}
    local structure_violations=${METRICS["structure_violations"]}
    local correctable_templates=${METRICS["correctable_templates"]}
    
    # Calculate compliance score
    local compliance_score=100
    local template_files=$((agent_files + command_files + component_files + document_files + ticket_files + principle_files))
    
    if [[ $template_files -gt 0 ]]; then
        compliance_score=$((template_compliant * 100 / template_files))
    fi
    
    log "Total Markdown Files: $total_files"
    log "Template Files by Type:"
    log "  - Agent Files: $agent_files"
    log "  - Command Files: $command_files"
    log "  - Component Files: $component_files"
    log "  - Document Files: $document_files"
    log "  - Ticket Files: $ticket_files"
    log "  - Principle Files: $principle_files"
    log "Template Compliant: $template_compliant"
    log "Template Violations: $template_violations"
    log "Missing Sections: $missing_sections"
    log "Structure Violations: $structure_violations"
    log "Auto-Correctable Templates: $correctable_templates"
    log "Template Compliance Score: $compliance_score%"
    
    # Output compliance score for orchestrator
    echo "COMPLIANCE_SCORE:$compliance_score"
    
    if [[ ${#TEMPLATE_VIOLATIONS[@]} -gt 0 ]]; then
        log ""
        log "=== TEMPLATE VIOLATIONS ==="
        for violation in "${TEMPLATE_VIOLATIONS[@]}"; do
            log "❌ $violation"
        done
    fi
    
    if [[ ${#TEMPLATE_CORRECTIONS[@]} -gt 0 ]]; then
        log ""
        log "=== SUGGESTED CORRECTIONS ==="
        for correction in "${TEMPLATE_CORRECTIONS[@]}"; do
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
  "validator": "template-compliance-validator",
  "version": "1.0.0",
  "metrics": {
    "total_files": $total_files,
    "template_files": {
      "agent_files": $agent_files,
      "command_files": $command_files,
      "component_files": $component_files,
      "document_files": $document_files,
      "ticket_files": $ticket_files,
      "principle_files": $principle_files
    },
    "template_compliant": $template_compliant,
    "template_violations": $template_violations,
    "missing_sections": $missing_sections,
    "structure_violations": $structure_violations,
    "correctable_templates": $correctable_templates,
    "compliance_score": $compliance_score
  },
  "template_types": {$(
    for type in "${!TEMPLATE_TYPES[@]}"; do
      echo "    \"$type\": \"${TEMPLATE_TYPES[$type]}\","
    done | sed '$ s/,$//'
  )},
  "required_sections": {$(
    for type in "${!REQUIRED_SECTIONS[@]}"; do
      echo "    \"$type\": \"${REQUIRED_SECTIONS[$type]}\","
    done | sed '$ s/,$//'
  )},
  "violations": [$(
    printf '%s\n' "${TEMPLATE_VIOLATIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
  )],
  "corrections": [$(
    printf '%s\n' "${TEMPLATE_CORRECTIONS[@]}" | sed 's/"/\\"/g' | sed 's/^/    "/' | sed 's/$/",/' | sed '$ s/,$//'
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

Claude Code Framework Template Compliance Validator

VALIDATES:
    - Template structure and required sections
    - Frontmatter completeness and format
    - Navigation patterns and structure
    - Type-specific requirements

TEMPLATE TYPES:
    - Agent: Purpose, responsibilities, capabilities, integration
    - Command: Usage, arguments, examples, validation
    - Component: Purpose, implementation, integration, examples
    - Document: Introduction, content, navigation, references
    - Ticket: Summary, requirements, acceptance criteria, implementation
    - Principle: Statement, rationale, implementation, validation

TARGET: 85% template compliance

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
    log "Template Compliance Validator v1.0.0 started - Project Root: $PROJECT_ROOT"
    
    if [[ "$report_only" == "true" ]]; then
        generate_report; exit 0
    fi
    
    validate_all_files
    
    if [[ "$fix_mode" == "true" ]]; then
        if [[ "$dry_run" == "true" ]]; then
            log "DRY RUN: Would apply ${#TEMPLATE_CORRECTIONS[@]} template corrections"
        else
            apply_template_corrections
        fi
    fi
    
    generate_report
    
    local template_files=$((METRICS["agent_files"] + METRICS["command_files"] + METRICS["component_files"] + METRICS["document_files"] + METRICS["ticket_files"] + METRICS["principle_files"]))
    local compliance_score=100
    
    if [[ $template_files -gt 0 ]]; then
        compliance_score=$((METRICS["template_compliant"] * 100 / template_files))
    fi
    
    if [[ $compliance_score -ge 85 ]]; then
        log "✅ Template compliance achieved ($compliance_score% >= 85%)"
        exit 0
    else
        log "❌ Template compliance below target ($compliance_score% < 85%)"
        exit 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi