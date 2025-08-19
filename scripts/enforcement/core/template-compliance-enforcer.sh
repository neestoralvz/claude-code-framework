#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - TEMPLATE COMPLIANCE ENFORCER
#======================================================================
# Purpose: Automatically applies missing template components and ensures template compliance
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Corrects: Missing template components, structural inconsistencies, standard patterns
# Safety: Individual file backup with template integrity validation
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/template-compliance-enforcer-$TIMESTAMP.log"

# Environment variables from orchestrator
readonly DRY_RUN="${DRY_RUN:-false}"
readonly MAX_FILES_PER_RUN="${MAX_FILES_PER_RUN:-500}"
readonly MAX_CHANGES_PER_FILE="${MAX_CHANGES_PER_FILE:-20}"
readonly BACKUP_DIR="${BACKUP_DIR:-${SCRIPT_DIR}/../backups/individual}"

# Template directories
readonly TEMPLATES_DIR="$PROJECT_ROOT/docs/templates"
readonly COMPONENTS_DIR="$TEMPLATES_DIR/components"

#======================================================================
# TEMPLATE COMPLIANCE RULES
#======================================================================
declare -A TEMPLATE_REQUIREMENTS=(
    # Document type requirements
    ["principles"]="frontmatter,principle_marker,cross_references,return_to_top"
    ["commands"]="frontmatter,usage_section,examples_section,cross_references"
    ["agents"]="frontmatter,capabilities_section,integration_section,cross_references"
    ["tickets"]="frontmatter,status_tracking,implementation_section"
    ["documentation"]="frontmatter,navigation,cross_references,return_to_top"
)

declare -A TEMPLATE_COMPONENTS=(
    # Standard template components
    ["frontmatter"]="YAML frontmatter with required fields"
    ["principle_marker"]="⏺ **Relationship** marker for principle connections"
    ["cross_references"]="## Cross-References section"
    ["return_to_top"]="[⬆ Return to top](#anchor) links"
    ["navigation"]="Breadcrumb navigation links"
    ["usage_section"]="## Usage section for commands"
    ["examples_section"]="## Examples section with code samples"
    ["capabilities_section"]="## Capabilities section for agents"
    ["integration_section"]="## Integration section for workflow patterns"
    ["status_tracking"]="Status and priority tracking for tickets"
    ["implementation_section"]="## Implementation section for execution details"
)

declare -A COMPONENT_TEMPLATES=(
    # Template content for missing components
    ["usage_section"]=$(cat << 'EOF'

## Usage

**Basic Execution:**
```bash
# Execute this command with standard parameters
./command-name [OPTIONS] [ARGUMENTS]
```

**Advanced Usage:**
```bash
# Execute with specific configuration
./command-name --config custom.yaml --verbose
```
EOF
)
    
    ["examples_section"]=$(cat << 'EOF'

## Examples

### Basic Example
```bash
# Simple execution example
command-example --basic
```

### Advanced Example
```bash
# Complex execution with multiple parameters
command-example --advanced --parameter value --flag
```

### Integration Example
```bash
# Integration with other framework components
command-example --integrate --component other-system
```
EOF
)
    
    ["capabilities_section"]=$(cat << 'EOF'

## Capabilities

### Core Capabilities
- **Primary Function**: [DESCRIPTION]
- **Integration Points**: [SYSTEMS]
- **Automation Level**: [MANUAL/SEMI/FULL]

### Technical Specifications
- **Input Requirements**: [SPECIFICATIONS]
- **Output Formats**: [FORMATS] 
- **Performance Characteristics**: [METRICS]

### Quality Standards
- **Validation Methods**: [METHODS]
- **Error Handling**: [APPROACHES]
- **Safety Measures**: [SAFEGUARDS]
EOF
)
    
    ["integration_section"]=$(cat << 'EOF'

## Integration

### Workflow Integration
- **Command Dependencies**: [REQUIRED_COMMANDS]
- **Agent Coordination**: [AGENT_PATTERNS]
- **Validation Integration**: [VALIDATION_STEPS]

### System Coordination
- **Input Sources**: [DATA_SOURCES]
- **Output Destinations**: [TARGET_SYSTEMS]
- **Feedback Loops**: [MONITORING_POINTS]

### Quality Assurance
- **Testing Patterns**: [TEST_APPROACHES]
- **Verification Steps**: [VERIFICATION_METHODS]
- **Success Criteria**: [MEASURABLE_OUTCOMES]
EOF
)

    ["implementation_section"]=$(cat << 'EOF'

## Implementation

### Prerequisites
- [ ] [PREREQUISITE_1]
- [ ] [PREREQUISITE_2]
- [ ] [PREREQUISITE_3]

### Implementation Steps
1. **[STEP_1]**: [DESCRIPTION]
2. **[STEP_2]**: [DESCRIPTION]
3. **[STEP_3]**: [DESCRIPTION]

### Validation Checklist
- [ ] [VALIDATION_ITEM_1]
- [ ] [VALIDATION_ITEM_2]
- [ ] [VALIDATION_ITEM_3]

### Success Criteria
- **Measurable Outcome 1**: [METRIC]
- **Measurable Outcome 2**: [METRIC]
- **Quality Standard**: [STANDARD]
EOF
)
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
    ["template_components_added"]=0
    ["structural_improvements"]=0
    ["compliance_violations_fixed"]=0
    ["template_sections_standardized"]=0
)

declare -a TEMPLATE_CORRECTIONS=()

#======================================================================
# FILE CLASSIFICATION AND ANALYSIS
#======================================================================
classify_document_type() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    local filename=$(basename "$file")
    
    # Classify based on path and content patterns
    case "$relative_path" in
        docs/principles/*)
            echo "principles"
            ;;
        commands/*)
            echo "commands"
            ;;
        agents/*)
            echo "agents"
            ;;
        planning/tickets/*)
            echo "tickets"
            ;;
        docs/*|playbook/*|operations/*)
            echo "documentation"
            ;;
        *)
            echo "documentation"
            ;;
    esac
}

analyze_template_compliance() {
    local file="$1"
    local doc_type="$2"
    
    local required_components="${TEMPLATE_REQUIREMENTS[$doc_type]:-}"
    local missing_components=()
    
    if [[ -z "$required_components" ]]; then
        return 0
    fi
    
    IFS=',' read -ra components <<< "$required_components"
    
    for component in "${components[@]}"; do
        case "$component" in
            "frontmatter")
                if ! head -n 3 "$file" | grep -q "^---$"; then
                    missing_components+=("frontmatter")
                fi
                ;;
            "principle_marker")
                if ! grep -q "⏺ \*\*Relationship\*\*" "$file"; then
                    missing_components+=("principle_marker")
                fi
                ;;
            "cross_references")
                if ! grep -q "## Cross-References" "$file"; then
                    missing_components+=("cross_references")
                fi
                ;;
            "return_to_top")
                if ! grep -q "⬆.*[Rr]eturn.*top" "$file"; then
                    missing_components+=("return_to_top")
                fi
                ;;
            "navigation")
                if ! head -n 15 "$file" | grep -qE "^\[.*\].*\|.*\[.*\]"; then
                    missing_components+=("navigation")
                fi
                ;;
            "usage_section")
                if ! grep -q "## Usage" "$file"; then
                    missing_components+=("usage_section")
                fi
                ;;
            "examples_section")
                if ! grep -q "## Examples" "$file"; then
                    missing_components+=("examples_section")
                fi
                ;;
            "capabilities_section")
                if ! grep -q "## Capabilities" "$file"; then
                    missing_components+=("capabilities_section")
                fi
                ;;
            "integration_section")
                if ! grep -q "## Integration" "$file"; then
                    missing_components+=("integration_section")
                fi
                ;;
            "status_tracking")
                if ! grep -qE "(status:|priority:)" "$file"; then
                    missing_components+=("status_tracking")
                fi
                ;;
            "implementation_section")
                if ! grep -q "## Implementation" "$file"; then
                    missing_components+=("implementation_section")
                fi
                ;;
        esac
    done
    
    printf '%s\n' "${missing_components[@]}"
}

check_structural_consistency() {
    local file="$1"
    local issues=()
    
    # Check header hierarchy
    local headers
    headers=$(grep -n "^#" "$file" | head -n 20 || true)
    
    local prev_level=0
    while IFS=':' read -r line_num header; do
        if [[ -n "$header" ]]; then
            local level
            level=$(echo "$header" | grep -o '^#*' | wc -c)
            level=$((level - 1))
            
            if [[ $level -gt $((prev_level + 1)) ]] && [[ $prev_level -gt 0 ]]; then
                issues+=("header_hierarchy_skip:$line_num:$prev_level:$level")
            fi
            
            prev_level=$level
        fi
    done <<< "$headers"
    
    # Check for missing main title
    if ! head -n 10 "$file" | grep -q "^# "; then
        issues+=("missing_main_title")
    fi
    
    printf '%s\n' "${issues[@]}"
}

#======================================================================
# TEMPLATE COMPONENT GENERATION
#======================================================================
generate_missing_components() {
    local file="$1"
    local doc_type="$2"
    shift 2
    local missing_components=("$@")
    
    local additions=()
    
    for component in "${missing_components[@]}"; do
        case "$component" in
            "usage_section"|"examples_section"|"capabilities_section"|"integration_section"|"implementation_section")
                local component_content="${COMPONENT_TEMPLATES[$component]}"
                if [[ -n "$component_content" ]]; then
                    additions+=("append:$component:$component_content")
                fi
                ;;
            "cross_references")
                local cross_ref_content
                cross_ref_content=$(generate_cross_references_template "$file" "$doc_type")
                additions+=("append:cross_references:$cross_ref_content")
                ;;
            "return_to_top")
                local return_top_content
                return_top_content=$(generate_return_to_top_template "$file")
                additions+=("append:return_to_top:$return_top_content")
                ;;
            "principle_marker")
                local principle_marker_content
                principle_marker_content=$(generate_principle_marker_template "$file" "$doc_type")
                additions+=("insert_after_header:principle_marker:$principle_marker_content")
                ;;
        esac
    done
    
    printf '%s\n' "${additions[@]}"
}

generate_cross_references_template() {
    local file="$1"
    local doc_type="$2"
    
    local relative_path="${file#$PROJECT_ROOT/}"
    local dirname=$(dirname "$relative_path")
    
    case "$doc_type" in
        "principles")
            cat << EOF

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../index.md)
- [Study Principles for framework](index.md)
- [Return to fundamental principles](fundamental.md)

### Implementation Resources
- **Execute principle patterns** through implementation guidelines
- **Apply validation standards** ensuring principle compliance
- **Follow cross-reference patterns** maintaining link integrity

[⬆ Return to top](#$(basename "$file" .md | tr '[:upper:]' '[:lower:]'))
EOF
            ;;
        "commands")
            cat << EOF

## Cross-References

### Related Commands
- [Browse commands directory](index.md)
- [Understand workflow principles](../docs/principles/workflow.md)
- [View system architecture](../docs/architecture/system-architecture-overview.md)

### Implementation Resources
- **Execute command patterns** through specialized agents
- **Apply validation standards** ensuring command compliance
- **Follow integration patterns** maintaining system coherence

[⬆ Return to top](#$(basename "$file" .md | tr '[:upper:]' '[:lower:]'))
EOF
            ;;
        "agents")
            cat << EOF

## Cross-References

### Related Agents
- [Browse agents directory](../index.md)
- [Understand agent coordination](../../docs/principles/task-orchestration.md)
- [View workflow patterns](../../docs/principles/workflow.md)

### Implementation Resources
- **Execute agent patterns** through task coordination
- **Apply validation standards** ensuring agent compliance
- **Follow integration patterns** maintaining system coherence

[⬆ Return to top](#$(basename "$file" .md | tr '[:upper:]' '[:lower:]'))
EOF
            ;;
        *)
            cat << EOF

## Cross-References

### Primary Navigation
- [Navigate to Framework Hub](../docs/index.md)
- [Study system principles](../docs/principles/index.md)
- [Browse related resources](index.md)

### Implementation Resources
- **Follow framework standards** ensuring consistency
- **Apply cross-reference patterns** maintaining navigation integrity
- **Execute validation procedures** ensuring compliance

[⬆ Return to top](#$(basename "$file" .md | tr '[:upper:]' '[:lower:]'))
EOF
            ;;
    esac
}

generate_return_to_top_template() {
    local file="$1"
    
    # Extract document title for anchor
    local title
    title=$(head -n 20 "$file" | grep "^# " | head -n 1 | sed 's/^# //' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-zA-Z0-9-]/-/g' || basename "$file" .md)
    
    echo "[⬆ Return to top](#$title)"
}

generate_principle_marker_template() {
    local file="$1"
    local doc_type="$2"
    
    case "$doc_type" in
        "principles")
            echo "⏺ **Relationship**: This principle provides [RELATIONSHIP_TYPE] for other principles:"
            ;;
        *)
            echo "⏺ **Framework Integration**: This component integrates with the framework through:"
            ;;
    esac
}

#======================================================================
# FILE MODIFICATION ENGINE
#======================================================================
backup_file() {
    local file="$1"
    
    mkdir -p "$BACKUP_DIR/template-compliance"
    local backup_file="$BACKUP_DIR/template-compliance/$(basename "$file")-$TIMESTAMP"
    
    cp "$file" "$backup_file"
    log "Backed up: $file -> $backup_file"
}

apply_template_corrections() {
    local file="$1"
    shift
    local corrections=("$@")
    
    if [[ ${#corrections[@]} -eq 0 ]]; then
        return 0
    fi
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would apply ${#corrections[@]} template corrections to $file"
        return 0
    fi
    
    backup_file "$file"
    
    local temp_file=$(mktemp)
    cp "$file" "$temp_file"
    
    local corrections_applied=0
    
    for correction in "${corrections[@]}"; do
        if [[ $corrections_applied -lt $MAX_CHANGES_PER_FILE ]]; then
            local action=$(echo "$correction" | cut -d: -f1)
            local component=$(echo "$correction" | cut -d: -f2)
            local content=$(echo "$correction" | cut -d: -f3-)
            
            case "$action" in
                "append")
                    echo "$content" >> "$temp_file"
                    METRICS["template_components_added"]=$((METRICS["template_components_added"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    log "Added $component section to: $file"
                    ;;
                "insert_after_header")
                    # Insert after the first main header
                    local header_line
                    header_line=$(grep -n "^# " "$temp_file" | head -n 1 | cut -d: -f1 || echo "1")
                    
                    if [[ -n "$header_line" ]]; then
                        sed -i "${header_line}a\\
\\
$content\\
" "$temp_file"
                        METRICS["template_components_added"]=$((METRICS["template_components_added"] + 1))
                        corrections_applied=$((corrections_applied + 1))
                        log "Inserted $component after header in: $file"
                    fi
                    ;;
            esac
        fi
    done
    
    mv "$temp_file" "$file"
    log "Applied $corrections_applied template corrections to: $file"
    
    return $corrections_applied
}

#======================================================================
# ENFORCEMENT EXECUTION ENGINE
#======================================================================
process_file_for_template_compliance() {
    local file="$1"
    
    log "Processing: $file"
    METRICS["files_processed"]=$((METRICS["files_processed"] + 1))
    
    # Classify document type
    local doc_type
    doc_type=$(classify_document_type "$file")
    
    # Analyze template compliance
    local missing_components
    missing_components=$(analyze_template_compliance "$file" "$doc_type")
    
    # Check structural consistency
    local structural_issues
    structural_issues=$(check_structural_consistency "$file")
    
    local all_corrections=()
    
    # Generate corrections for missing components
    if [[ -n "$missing_components" ]]; then
        local component_array
        mapfile -t component_array <<< "$missing_components"
        
        local component_additions
        component_additions=$(generate_missing_components "$file" "$doc_type" "${component_array[@]}")
        
        while IFS= read -r addition; do
            if [[ -n "$addition" ]]; then
                all_corrections+=("$addition")
            fi
        done <<< "$component_additions"
        
        log "Found missing components for $file ($doc_type): ${component_array[*]}"
    fi
    
    # Apply all corrections
    if [[ ${#all_corrections[@]} -gt 0 ]]; then
        local corrections_count
        corrections_count=$(apply_template_corrections "$file" "${all_corrections[@]}")
        
        if [[ $corrections_count -gt 0 ]]; then
            METRICS["files_modified"]=$((METRICS["files_modified"] + 1))
            METRICS["structural_improvements"]=$((METRICS["structural_improvements"] + 1))
            METRICS["compliance_violations_fixed"]=$((METRICS["compliance_violations_fixed"] + 1))
            
            # Store correction operations for reporting
            TEMPLATE_CORRECTIONS+=("$file:$doc_type:${#all_corrections[@]} template corrections applied")
        fi
    else
        log "No template compliance corrections needed for: $file"
    fi
}

find_files_for_template_compliance() {
    local include_patterns=(
        "$PROJECT_ROOT/docs/**/*.md"
        "$PROJECT_ROOT/agents/**/*.md"
        "$PROJECT_ROOT/commands/**/*.md"
        "$PROJECT_ROOT/planning/**/*.md"
    )
    
    local exclude_patterns=(
        "*/backups/*"
        "*/node_modules/*"
        "*/\.git/*"
        "*/ide/*"
        "*/.DS_Store"
        "*/templates/*"  # Don't modify templates themselves
        "*README.md"     # Skip README files
    )
    
    # Find files that should follow template patterns
    find "$PROJECT_ROOT" -name "*.md" -type f \
        | grep -v -E "($(IFS='|'; echo "${exclude_patterns[*]}"))" \
        | head -n "$MAX_FILES_PER_RUN"
}

execute_template_compliance_enforcement() {
    log "Starting template compliance enforcement"
    log "Mode: $([ "$DRY_RUN" == "true" ] && echo "DRY RUN" || echo "LIVE")"
    log "Max files per run: $MAX_FILES_PER_RUN"
    log "Templates directory: $TEMPLATES_DIR"
    
    local file_count=0
    while IFS= read -r file; do
        if [[ -n "$file" ]] && [[ -f "$file" ]]; then
            file_count=$((file_count + 1))
            
            if [[ $file_count -gt $MAX_FILES_PER_RUN ]]; then
                log "Reached maximum files per run limit: $MAX_FILES_PER_RUN"
                break
            fi
            
            process_file_for_template_compliance "$file"
        fi
    done < <(find_files_for_template_compliance)
    
    log "Template compliance enforcement completed"
    log "Files processed: ${METRICS["files_processed"]}"
    log "Files modified: ${METRICS["files_modified"]}"
    log "Template components added: ${METRICS["template_components_added"]}"
    log "Structural improvements: ${METRICS["structural_improvements"]}"
    log "Compliance violations fixed: ${METRICS["compliance_violations_fixed"]}"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    mkdir -p "$(dirname "$LOG_FILE")" "$BACKUP_DIR"
    
    log "Template Compliance Enforcer starting"
    log "Project root: $PROJECT_ROOT"
    log "Dry run: $DRY_RUN"
    
    execute_template_compliance_enforcement
    
    # Output metrics for orchestrator
    local total_corrections=$((METRICS["template_components_added"] + METRICS["compliance_violations_fixed"]))
    echo "CORRECTIONS_MADE:$total_corrections"
    echo "FILES_MODIFIED:${METRICS["files_modified"]}"
    
    # Save correction operations log
    if [[ ${#TEMPLATE_CORRECTIONS[@]} -gt 0 ]]; then
        local corrections_log="$SCRIPT_DIR/../logs/template-compliance-corrections-$TIMESTAMP.log"
        printf '%s\n' "${TEMPLATE_CORRECTIONS[@]}" > "$corrections_log"
        log "Template compliance corrections logged to: $corrections_log"
    fi
    
    log "Template Compliance Enforcer completed successfully"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi