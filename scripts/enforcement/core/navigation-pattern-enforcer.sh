#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - NAVIGATION PATTERN ENFORCER
#======================================================================
# Purpose: Automatically adds missing navigation patterns (breadcrumbs, return-to-top)
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Corrects: Missing breadcrumbs, missing return-to-top links, navigation consistency
# Safety: Individual file backup with navigation structure validation
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/navigation-pattern-enforcer-$TIMESTAMP.log"

# Environment variables from orchestrator
readonly DRY_RUN="${DRY_RUN:-false}"
readonly MAX_FILES_PER_RUN="${MAX_FILES_PER_RUN:-500}"
readonly MAX_CHANGES_PER_FILE="${MAX_CHANGES_PER_FILE:-20}"
readonly BACKUP_DIR="${BACKUP_DIR:-${SCRIPT_DIR}/../backups/individual}"

#======================================================================
# NAVIGATION PATTERN TEMPLATES
#======================================================================
declare -A BREADCRUMB_TEMPLATES=(
    # Core navigation patterns by directory
    ["docs"]="[🏠 Framework Hub](../index.md) | [📚 Documentation](index.md)"
    ["docs/principles"]="[🏠 Framework Hub](../../index.md) | [📚 Documentation](../index.md) | [⚖️ Principles](index.md)"
    ["docs/architecture"]="[🏠 Framework Hub](../../index.md) | [📚 Documentation](../index.md) | [🏗️ Architecture](index.md)"
    ["docs/templates"]="[🏠 Framework Hub](../../index.md) | [📚 Documentation](../index.md) | [📄 Templates](index.md)"
    ["docs/commands-docs"]="[🏠 Framework Hub](../../index.md) | [📚 Documentation](../index.md) | [⚡ Commands Docs](index.md)"
    
    ["commands"]="[🏠 Framework Hub](../index.md) | [⚡ Commands](index.md)"
    ["commands/foundation"]="[🏠 Framework Hub](../../index.md) | [⚡ Commands](../index.md) | [⚡ Foundation](index.md)"
    ["commands/domains"]="[🏠 Framework Hub](../../index.md) | [⚡ Commands](../index.md) | [🎯 Domains](index.md)"
    ["commands/compositions"]="[🏠 Framework Hub](../../index.md) | [⚡ Commands](../index.md) | [🔄 Compositions](index.md)"
    
    ["agents"]="[🏠 Framework Hub](../index.md) | [🤖 Agents](index.md)"
    ["agents/development"]="[🏠 Framework Hub](../../index.md) | [🤖 Agents](../index.md) | [💻 Development](index.md)"
    ["agents/operations"]="[🏠 Framework Hub](../../index.md) | [🤖 Agents](../index.md) | [⚙️ Operations](index.md)"
    ["agents/content"]="[🏠 Framework Hub](../../index.md) | [🤖 Agents](../index.md) | [📝 Content](index.md)"
    
    ["planning"]="[🏠 Framework Hub](../index.md) | [📋 Planning](index.md)"
    ["planning/tickets"]="[🏠 Framework Hub](../../index.md) | [📋 Planning](../index.md) | [🎫 Tickets](index.md)"
    
    ["operations"]="[🏠 Framework Hub](../index.md) | [⚙️ Operations](index.md)"
    
    ["playbook"]="[🏠 Framework Hub](../index.md) | [📖 Playbook](index.md)"
    ["playbook/procedures"]="[🏠 Framework Hub](../../index.md) | [📖 Playbook](../index.md) | [📋 Procedures](index.md)"
    ["playbook/quick-reference"]="[🏠 Framework Hub](../../index.md) | [📖 Playbook](../index.md) | [⚡ Quick Reference](index.md)"
    
    ["scripts"]="[🏠 Framework Hub](../index.md) | [🔧 Scripts](index.md)"
    ["scripts/validation"]="[🏠 Framework Hub](../../index.md) | [🔧 Scripts](../index.md) | [✅ Validation](index.md)"
    ["scripts/enforcement"]="[🏠 Framework Hub](../../index.md) | [🔧 Scripts](../index.md) | [🔧 Enforcement](index.md)"
)

declare -A RETURN_TO_TOP_TEMPLATES=(
    # Standard return-to-top patterns
    ["standard"]="[⬆ Return to top](#)"
    ["named"]="[⬆ Return to top](#DOCUMENT_NAME)"
    ["section"]="[⬆ Return to section](#SECTION_NAME)"
)

declare -A NAVIGATION_RULES=(
    # Rules for different file types
    ["documentation"]="breadcrumb_required,return_to_top_required"
    ["command"]="breadcrumb_required,return_to_top_optional"
    ["agent"]="breadcrumb_required,return_to_top_optional"
    ["ticket"]="breadcrumb_optional,return_to_top_optional"
    ["readme"]="breadcrumb_required,return_to_top_required"
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
    ["breadcrumbs_added"]=0
    ["breadcrumbs_updated"]=0
    ["return_to_top_added"]=0
    ["return_to_top_updated"]=0
    ["navigation_patterns_standardized"]=0
)

declare -a NAVIGATION_MODIFICATIONS=()

#======================================================================
# FILE ANALYSIS AND CLASSIFICATION
#======================================================================
classify_file_type() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    local filename=$(basename "$file")
    
    # Classify based on path and filename patterns
    case "$relative_path" in
        docs/*)
            echo "documentation"
            ;;
        commands/*)
            echo "command"
            ;;
        agents/*)
            echo "agent"
            ;;
        planning/tickets/*)
            echo "ticket"
            ;;
        *README.md|*readme.md)
            echo "readme"
            ;;
        *)
            echo "documentation"
            ;;
    esac
}

get_file_directory_path() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    local dir_path=$(dirname "$relative_path")
    
    echo "$dir_path"
}

get_navigation_requirements() {
    local file_type="$1"
    
    local rules="${NAVIGATION_RULES[$file_type]:-breadcrumb_optional,return_to_top_optional}"
    echo "$rules"
}

#======================================================================
# BREADCRUMB GENERATION AND DETECTION
#======================================================================
has_breadcrumb_navigation() {
    local file="$1"
    
    # Check for existing breadcrumb patterns
    if head -n 10 "$file" | grep -qE "^\[.*\].*\|.*\[.*\].*\|"; then
        return 0
    fi
    
    # Check for navigation blocks
    if head -n 15 "$file" | grep -qE "Framework Hub.*Commands.*Workflow"; then
        return 0
    fi
    
    return 1
}

generate_breadcrumb_for_path() {
    local dir_path="$1"
    
    # Try exact match first
    if [[ -n "${BREADCRUMB_TEMPLATES[$dir_path]:-}" ]]; then
        echo "${BREADCRUMB_TEMPLATES[$dir_path]}"
        return 0
    fi
    
    # Generate breadcrumb based on path components
    local breadcrumb_parts=()
    local current_path=""
    local relative_prefix=""
    
    # Always start with Framework Hub
    breadcrumb_parts+=("[🏠 Framework Hub]")
    
    IFS='/' read -ra path_components <<< "$dir_path"
    
    for i in "${!path_components[@]}"; do
        local component="${path_components[i]}"
        current_path="$current_path$component"
        
        # Calculate relative path to this component
        local depth=$((${#path_components[@]} - i))
        relative_prefix=$(printf "../%.0s" $(seq 1 $((depth - 1))))
        
        local component_link="$relative_prefix$component/index.md"
        
        # Get appropriate emoji and display name
        local emoji="📁"
        local display_name="$component"
        
        case "$component" in
            "docs") emoji="📚"; display_name="Documentation" ;;
            "commands") emoji="⚡"; display_name="Commands" ;;
            "agents") emoji="🤖"; display_name="Agents" ;;
            "principles") emoji="⚖️"; display_name="Principles" ;;
            "architecture") emoji="🏗️"; display_name="Architecture" ;;
            "templates") emoji="📄"; display_name="Templates" ;;
            "planning") emoji="📋"; display_name="Planning" ;;
            "operations") emoji="⚙️"; display_name="Operations" ;;
            "playbook") emoji="📖"; display_name="Playbook" ;;
            "scripts") emoji="🔧"; display_name="Scripts" ;;
            "validation") emoji="✅"; display_name="Validation" ;;
            "enforcement") emoji="🔧"; display_name="Enforcement" ;;
            "tickets") emoji="🎫"; display_name="Tickets" ;;
            "development") emoji="💻"; display_name="Development" ;;
            "content") emoji="📝"; display_name="Content" ;;
        esac
        
        breadcrumb_parts+=("[$emoji $display_name]($component_link)")
        current_path="$current_path/"
    done
    
    # Join breadcrumb parts
    local breadcrumb
    breadcrumb=$(IFS=' | '; echo "${breadcrumb_parts[*]}")
    
    # Update Framework Hub link with correct relative path
    local hub_depth=${#path_components[@]}
    local hub_prefix=$(printf "../%.0s" $(seq 1 $hub_depth))
    breadcrumb=$(echo "$breadcrumb" | sed "s|\[🏠 Framework Hub\]|[🏠 Framework Hub](${hub_prefix}index.md)|")
    
    echo "$breadcrumb"
}

#======================================================================
# RETURN-TO-TOP GENERATION AND DETECTION
#======================================================================
has_return_to_top_links() {
    local file="$1"
    
    # Check for return-to-top patterns
    if grep -q "⬆.*[Rr]eturn.*top" "$file"; then
        return 0
    fi
    
    # Check for anchor-based returns
    if grep -q "\[.*⬆.*\](#.*)" "$file"; then
        return 0
    fi
    
    return 1
}

generate_return_to_top_link() {
    local file="$1"
    
    # Extract document title for named return
    local title
    title=$(head -n 20 "$file" | grep "^# " | head -n 1 | sed 's/^# //' | sed 's/[^a-zA-Z0-9-]/-/g' | tr '[:upper:]' '[:lower:]')
    
    if [[ -n "$title" ]]; then
        echo "[⬆ Return to top](#$title)"
    else
        echo "[⬆ Return to top](#)"
    fi
}

determine_return_to_top_placement() {
    local file="$1"
    
    # Find major sections where return-to-top should be added
    local placement_lines=()
    
    # Look for major section breaks (## headers)
    while IFS=':' read -r line_num content; do
        if [[ "$content" =~ ^##[[:space:]] ]]; then
            # Check if there's substantial content before this section
            local prev_content_lines
            prev_content_lines=$(sed -n "1,$((line_num - 1))p" "$file" | grep -c "^[^#[:space:]]" || echo "0")
            
            if [[ $prev_content_lines -gt 10 ]]; then
                placement_lines+=("$((line_num - 1))")
            fi
        fi
    done < <(grep -n "^##" "$file" || true)
    
    # Always add at end if file is long enough
    local total_lines
    total_lines=$(wc -l < "$file")
    
    if [[ $total_lines -gt 50 ]]; then
        placement_lines+=("$total_lines")
    fi
    
    printf '%s\n' "${placement_lines[@]}"
}

#======================================================================
# FILE MODIFICATION ENGINE
#======================================================================
backup_file() {
    local file="$1"
    
    mkdir -p "$BACKUP_DIR/navigation"
    local backup_file="$BACKUP_DIR/navigation/$(basename "$file")-$TIMESTAMP"
    
    cp "$file" "$backup_file"
    log "Backed up: $file -> $backup_file"
}

add_breadcrumb_navigation() {
    local file="$1"
    local breadcrumb="$2"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would add breadcrumb to $file"
        return 0
    fi
    
    backup_file "$file"
    
    local temp_file=$(mktemp)
    
    # Find insertion point (after frontmatter if present, otherwise at start)
    local insert_line=1
    if head -n 1 "$file" | grep -q "^---$"; then
        # Skip YAML frontmatter
        insert_line=$(tail -n +2 "$file" | grep -n "^---$" | head -n 1 | cut -d: -f1)
        if [[ -n "$insert_line" ]]; then
            insert_line=$((insert_line + 2))
        else
            insert_line=1
        fi
    fi
    
    # Insert breadcrumb navigation
    {
        if [[ $insert_line -gt 1 ]]; then
            sed -n "1,$((insert_line - 1))p" "$file"
        fi
        echo ""
        echo "$breadcrumb"
        echo ""
        if [[ $insert_line -le $(wc -l < "$file") ]]; then
            sed -n "${insert_line},\$p" "$file"
        fi
    } > "$temp_file"
    
    mv "$temp_file" "$file"
    log "Added breadcrumb navigation to: $file"
}

add_return_to_top_links() {
    local file="$1"
    local return_link="$2"
    shift 2
    local placement_lines=("$@")
    
    if [[ ${#placement_lines[@]} -eq 0 ]]; then
        return 0
    fi
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would add ${#placement_lines[@]} return-to-top links to $file"
        return 0
    fi
    
    backup_file "$file"
    
    local temp_file=$(mktemp)
    cp "$file" "$temp_file"
    
    # Add return-to-top links in reverse order (to maintain line numbers)
    local sorted_lines
    sorted_lines=$(printf '%s\n' "${placement_lines[@]}" | sort -nr)
    
    while IFS= read -r line_num; do
        if [[ -n "$line_num" ]]; then
            # Insert return-to-top link
            sed -i "${line_num}a\\
\\
$return_link\\
" "$temp_file"
            
            log "Added return-to-top link at line $line_num"
        fi
    done <<< "$sorted_lines"
    
    mv "$temp_file" "$file"
    log "Added ${#placement_lines[@]} return-to-top links to: $file"
}

#======================================================================
# ENFORCEMENT EXECUTION ENGINE
#======================================================================
process_file_for_navigation() {
    local file="$1"
    
    log "Processing: $file"
    METRICS["files_processed"]=$((METRICS["files_processed"] + 1))
    
    # Classify file and get requirements
    local file_type
    file_type=$(classify_file_type "$file")
    
    local requirements
    requirements=$(get_navigation_requirements "$file_type")
    
    local needs_breadcrumb=false
    local needs_return_to_top=false
    local file_modified=false
    
    # Check breadcrumb requirement
    if [[ "$requirements" =~ breadcrumb_required ]]; then
        needs_breadcrumb=true
    fi
    
    # Check return-to-top requirement
    if [[ "$requirements" =~ return_to_top_required ]]; then
        needs_return_to_top=true
    fi
    
    # Process breadcrumb navigation
    if [[ "$needs_breadcrumb" == "true" ]] && ! has_breadcrumb_navigation "$file"; then
        local dir_path
        dir_path=$(get_file_directory_path "$file")
        
        local breadcrumb
        breadcrumb=$(generate_breadcrumb_for_path "$dir_path")
        
        if [[ -n "$breadcrumb" ]]; then
            add_breadcrumb_navigation "$file" "$breadcrumb"
            METRICS["breadcrumbs_added"]=$((METRICS["breadcrumbs_added"] + 1))
            file_modified=true
            
            NAVIGATION_MODIFICATIONS+=("$file:breadcrumb_added:$breadcrumb")
            log "Added breadcrumb to: $file"
        fi
    fi
    
    # Process return-to-top links
    if [[ "$needs_return_to_top" == "true" ]] && ! has_return_to_top_links "$file"; then
        local return_link
        return_link=$(generate_return_to_top_link "$file")
        
        local placement_lines
        mapfile -t placement_lines < <(determine_return_to_top_placement "$file")
        
        if [[ ${#placement_lines[@]} -gt 0 ]]; then
            add_return_to_top_links "$file" "$return_link" "${placement_lines[@]}"
            METRICS["return_to_top_added"]=$((METRICS["return_to_top_added"] + ${#placement_lines[@]}))
            file_modified=true
            
            NAVIGATION_MODIFICATIONS+=("$file:return_to_top_added:${#placement_lines[@]}")
            log "Added ${#placement_lines[@]} return-to-top links to: $file"
        fi
    fi
    
    if [[ "$file_modified" == "true" ]]; then
        METRICS["files_modified"]=$((METRICS["files_modified"] + 1))
        METRICS["navigation_patterns_standardized"]=$((METRICS["navigation_patterns_standardized"] + 1))
    fi
}

find_files_for_navigation_enforcement() {
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
        "*/templates/*"  # Skip templates to avoid modifying them
    )
    
    # Find markdown files needing navigation
    find "$PROJECT_ROOT" -name "*.md" -type f \
        | grep -v -E "($(IFS='|'; echo "${exclude_patterns[*]}"))" \
        | head -n "$MAX_FILES_PER_RUN"
}

execute_navigation_pattern_enforcement() {
    log "Starting navigation pattern enforcement"
    log "Mode: $([ "$DRY_RUN" == "true" ] && echo "DRY RUN" || echo "LIVE")"
    log "Max files per run: $MAX_FILES_PER_RUN"
    
    local file_count=0
    while IFS= read -r file; do
        if [[ -n "$file" ]] && [[ -f "$file" ]]; then
            file_count=$((file_count + 1))
            
            if [[ $file_count -gt $MAX_FILES_PER_RUN ]]; then
                log "Reached maximum files per run limit: $MAX_FILES_PER_RUN"
                break
            fi
            
            process_file_for_navigation "$file"
        fi
    done < <(find_files_for_navigation_enforcement)
    
    log "Navigation pattern enforcement completed"
    log "Files processed: ${METRICS["files_processed"]}"
    log "Files modified: ${METRICS["files_modified"]}"
    log "Breadcrumbs added: ${METRICS["breadcrumbs_added"]}"
    log "Return-to-top links added: ${METRICS["return_to_top_added"]}"
    log "Navigation patterns standardized: ${METRICS["navigation_patterns_standardized"]}"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    mkdir -p "$(dirname "$LOG_FILE")" "$BACKUP_DIR"
    
    log "Navigation Pattern Enforcer starting"
    log "Project root: $PROJECT_ROOT"
    log "Dry run: $DRY_RUN"
    
    execute_navigation_pattern_enforcement
    
    # Output metrics for orchestrator
    local total_corrections=$((METRICS["breadcrumbs_added"] + METRICS["return_to_top_added"]))
    echo "CORRECTIONS_MADE:$total_corrections"
    echo "FILES_MODIFIED:${METRICS["files_modified"]}"
    
    # Save navigation modifications log
    if [[ ${#NAVIGATION_MODIFICATIONS[@]} -gt 0 ]]; then
        local modifications_log="$SCRIPT_DIR/../logs/navigation-modifications-$TIMESTAMP.log"
        printf '%s\n' "${NAVIGATION_MODIFICATIONS[@]}" > "$modifications_log"
        log "Navigation modifications logged to: $modifications_log"
    fi
    
    log "Navigation Pattern Enforcer completed successfully"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi