#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - CROSS-REFERENCE ENFORCER
#======================================================================
# Purpose: Automatically corrects broken internal references and standardizes cross-links
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Corrects: Broken internal links, missing cross-references, inconsistent reference patterns
# Safety: Individual file backup with reference integrity validation
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/cross-reference-enforcer-$TIMESTAMP.log"

# Environment variables from orchestrator
readonly DRY_RUN="${DRY_RUN:-false}"
readonly MAX_FILES_PER_RUN="${MAX_FILES_PER_RUN:-500}"
readonly MAX_CHANGES_PER_FILE="${MAX_CHANGES_PER_FILE:-20}"
readonly BACKUP_DIR="${BACKUP_DIR:-${SCRIPT_DIR}/../backups/individual}"

#======================================================================
# CROSS-REFERENCE PATTERNS AND STANDARDS
#======================================================================
declare -A REFERENCE_PATTERNS=(
    # Internal documentation references
    ["doc_reference"]="[📖 Title](relative/path.md)"
    ["principle_reference"]="[⚖️ Principle Name](../principles/principle-name.md)"
    ["command_reference"]="[⚡ Command Name](../commands/command-name.md)"
    ["agent_reference"]="[🤖 Agent Name](../agents/category/agent-name.md)"
    
    # Cross-reference sections
    ["cross_ref_section"]="## Cross-References"
    ["principle_ref_section"]="## Principle References"
    ["related_docs_section"]="## Related Documentation"
)

declare -A REFERENCE_STANDARDS=(
    # Standard cross-reference formats
    ["principle_marker"]="⏺ **Relationship**: This [TYPE] [ACTION] with other principles:"
    ["cross_ref_item"]="- **[TITLE](PATH)**: [DESCRIPTION]"
    ["navigation_item"]="- [ICON TITLE](PATH)"
)

declare -A COMMON_PATHS=(
    # Frequently referenced paths
    ["principles_index"]="docs/principles/index.md"
    ["commands_index"]="commands/index.md"
    ["agents_index"]="agents/index.md"
    ["framework_hub"]="docs/index.md"
    
    # Common principle files
    ["fundamental"]="docs/principles/fundamental.md"
    ["communication"]="docs/principles/communication.md"
    ["organization"]="docs/principles/organization.md"
    ["formatting"]="docs/principles/formatting.md"
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
    ["broken_links_fixed"]=0
    ["cross_references_added"]=0
    ["principle_references_added"]=0
    ["navigation_links_added"]=0
    ["reference_sections_added"]=0
    ["link_formats_standardized"]=0
)

declare -a REFERENCE_CORRECTIONS=()

#======================================================================
# REFERENCE DISCOVERY AND VALIDATION
#======================================================================
discover_existing_files() {
    local file_registry=$(mktemp)
    
    # Create comprehensive file registry for reference resolution
    find "$PROJECT_ROOT" -name "*.md" -type f | while read -r file; do
        local relative_path="${file#$PROJECT_ROOT/}"
        local filename=$(basename "$file" .md)
        local dirname=$(dirname "$relative_path")
        
        echo "$relative_path|$filename|$dirname" >> "$file_registry"
    done
    
    echo "$file_registry"
}

validate_internal_link() {
    local source_file="$1"
    local link_path="$2"
    
    # Handle relative path resolution
    local source_dir=$(dirname "${source_file#$PROJECT_ROOT/}")
    local target_path=""
    
    if [[ "$link_path" =~ ^\.\./ ]]; then
        # Relative path with ../
        target_path="$source_dir/$link_path"
    elif [[ "$link_path" =~ ^\.\/ ]]; then
        # Relative path with ./
        target_path="$source_dir/${link_path#./}"
    elif [[ "$link_path" =~ ^[^/] ]]; then
        # Relative path without prefix
        target_path="$source_dir/$link_path"
    else
        # Absolute path from project root
        target_path="${link_path#/}"
    fi
    
    # Normalize path (remove .. and . components)
    target_path=$(echo "$target_path" | sed 's|/\./|/|g')
    while [[ "$target_path" =~ /[^/]+/\.\./  ]]; do
        target_path=$(echo "$target_path" | sed 's|/[^/]*/\.\./|/|g')
    done
    
    # Check if target exists
    if [[ -f "$PROJECT_ROOT/$target_path" ]]; then
        echo "VALID|$target_path"
    else
        echo "BROKEN|$target_path"
    fi
}

find_potential_link_targets() {
    local broken_path="$1"
    local file_registry="$2"
    local suggestions=()
    
    local filename=$(basename "$broken_path" .md)
    
    # Search for similar filenames
    while IFS='|' read -r path name dirname; do
        if [[ -n "$path" ]]; then
            # Exact filename match
            if [[ "$name" == "$filename" ]]; then
                suggestions+=("EXACT|$path")
            # Partial filename match
            elif [[ "$name" == *"$filename"* ]] || [[ "$filename" == *"$name"* ]]; then
                suggestions+=("PARTIAL|$path")
            fi
        fi
    done < "$file_registry"
    
    printf '%s\n' "${suggestions[@]}"
}

#======================================================================
# CROSS-REFERENCE ANALYSIS
#======================================================================
analyze_file_references() {
    local file="$1"
    local file_registry="$2"
    local issues=()
    
    # Extract all markdown links
    local links
    links=$(grep -n "\[.*\](.*)" "$file" || true)
    
    while IFS=':' read -r line_num link_content; do
        if [[ -n "$link_content" ]]; then
            # Extract link URL
            if [[ "$link_content" =~ \[([^\]]*)\]\(([^)]*)\) ]]; then
                local link_text="${BASH_REMATCH[1]}"
                local link_url="${BASH_REMATCH[2]}"
                
                # Skip external links
                if [[ "$link_url" =~ ^https?:// ]]; then
                    continue
                fi
                
                # Skip anchors and fragments  
                if [[ "$link_url" =~ ^# ]]; then
                    continue
                fi
                
                # Validate internal links
                local validation_result
                validation_result=$(validate_internal_link "$file" "$link_url")
                local status=$(echo "$validation_result" | cut -d'|' -f1)
                local resolved_path=$(echo "$validation_result" | cut -d'|' -f2)
                
                if [[ "$status" == "BROKEN" ]]; then
                    # Try to find potential targets
                    local suggestions
                    suggestions=$(find_potential_link_targets "$resolved_path" "$file_registry")
                    
                    issues+=("$line_num:broken_link:$link_text:$link_url:$suggestions")
                fi
            fi
        fi
    done <<< "$links"
    
    printf '%s\n' "${issues[@]}"
}

check_required_cross_references() {
    local file="$1"
    local issues=()
    
    local relative_path="${file#$PROJECT_ROOT/}"
    
    # Check for required cross-reference sections based on file type
    case "$relative_path" in
        docs/principles/*)
            if ! grep -q "## Principle References" "$file"; then
                issues+=("missing_principle_references")
            fi
            if ! grep -q "## Cross-References" "$file"; then
                issues+=("missing_cross_references")
            fi
            ;;
        commands/*)
            if ! grep -q "## Related Commands" "$file" && ! grep -q "## Cross-References" "$file"; then
                issues+=("missing_cross_references")
            fi
            ;;
        agents/*)
            if ! grep -q "## Related Agents" "$file" && ! grep -q "## Cross-References" "$file"; then
                issues+=("missing_cross_references")
            fi
            ;;
    esac
    
    printf '%s\n' "${issues[@]}"
}

#======================================================================
# REFERENCE CORRECTION GENERATION
#======================================================================
generate_link_corrections() {
    local file="$1"
    local issues="$2"
    local corrections=()
    
    while IFS=':' read -r line_num issue_type link_text link_url suggestions; do
        if [[ -n "$line_num" ]] && [[ "$issue_type" == "broken_link" ]]; then
            # Find best suggestion
            local best_suggestion=""
            local best_type=""
            
            while IFS='|' read -r sugg_type sugg_path; do
                if [[ "$sugg_type" == "EXACT" ]]; then
                    best_suggestion="$sugg_path"
                    best_type="EXACT"
                    break
                elif [[ "$sugg_type" == "PARTIAL" ]] && [[ -z "$best_suggestion" ]]; then
                    best_suggestion="$sugg_path"
                    best_type="PARTIAL"
                fi
            done <<< "$suggestions"
            
            if [[ -n "$best_suggestion" ]]; then
                # Generate corrected relative path
                local source_dir=$(dirname "${file#$PROJECT_ROOT/}")
                local corrected_url
                corrected_url=$(python3 -c "
import os.path
source = '$source_dir'
target = '$best_suggestion'
print(os.path.relpath(target, source))
" 2>/dev/null || echo "$best_suggestion")
                
                corrections+=("$line_num:fix_broken_link:[$link_text]($link_url):[$link_text]($corrected_url):$best_type")
                
                log "Found correction for broken link at line $line_num: $link_url -> $corrected_url ($best_type match)"
            else
                log "No suitable target found for broken link: $link_url"
            fi
        fi
    done <<< "$issues"
    
    printf '%s\n' "${corrections[@]}"
}

generate_cross_reference_sections() {
    local file="$1"
    local missing_sections="$2"
    local additions=()
    
    local relative_path="${file#$PROJECT_ROOT/}"
    
    while IFS= read -r missing_section; do
        if [[ -n "$missing_section" ]]; then
            case "$missing_section" in
                "missing_principle_references")
                    local section_content
                    section_content=$(generate_principle_references_section "$file")
                    additions+=("append:principle_references:$section_content")
                    ;;
                "missing_cross_references")  
                    local section_content
                    section_content=$(generate_cross_references_section "$file")
                    additions+=("append:cross_references:$section_content")
                    ;;
            esac
        fi
    done <<< "$missing_sections"
    
    printf '%s\n' "${additions[@]}"
}

generate_principle_references_section() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    
    cat << EOF

## Principle References

⏺ **Relationship**: This principle provides [RELATIONSHIP_TYPE] for other principles:
- **[fundamental.md](fundamental.md)**: [RELATIONSHIP_DESCRIPTION]
- **[communication.md](communication.md)**: [RELATIONSHIP_DESCRIPTION]
- **[organization.md](organization.md)**: [RELATIONSHIP_DESCRIPTION]
EOF
}

generate_cross_references_section() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    
    # Determine appropriate cross-references based on file location
    local section_content=""
    
    case "$relative_path" in
        docs/principles/*)
            section_content=$(cat << EOF

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../index.md)
- [Study Principles for framework](index.md)
- [Return to previous principle](fundamental.md)

### Implementation Resources
- **Execute principle patterns** through implementation guidelines
- **Apply validation standards** ensuring principle compliance
- **Follow cross-reference patterns** maintaining link integrity
EOF
)
            ;;
        commands/*)
            section_content=$(cat << EOF

## Cross-References

### Related Commands
- [Browse commands directory](index.md)
- [Understand workflow principles](../docs/principles/workflow.md)
- [View system architecture](../docs/architecture/system-architecture-overview.md)

### Implementation Resources
- **Execute command patterns** through specialized agents
- **Apply validation standards** ensuring command compliance
- **Follow integration patterns** maintaining system coherence
EOF
)
            ;;
        *)
            section_content=$(cat << EOF

## Cross-References

### Primary Navigation
- [Navigate to Framework Hub](../docs/index.md)
- [Study system principles](../docs/principles/index.md)
- [Browse related resources](index.md)

### Implementation Resources
- **Follow framework standards** ensuring consistency
- **Apply cross-reference patterns** maintaining navigation integrity
- **Execute validation procedures** ensuring compliance
EOF
)
            ;;
    esac
    
    echo "$section_content"
}

#======================================================================
# FILE MODIFICATION ENGINE
#======================================================================
backup_file() {
    local file="$1"
    
    mkdir -p "$BACKUP_DIR/cross-references"
    local backup_file="$BACKUP_DIR/cross-references/$(basename "$file")-$TIMESTAMP"
    
    cp "$file" "$backup_file"
    log "Backed up: $file -> $backup_file"
}

apply_reference_corrections() {
    local file="$1"
    shift
    local corrections=("$@")
    
    if [[ ${#corrections[@]} -eq 0 ]]; then
        return 0
    fi
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY RUN: Would apply ${#corrections[@]} reference corrections to $file"
        return 0
    fi
    
    backup_file "$file"
    
    local temp_file=$(mktemp)
    cp "$file" "$temp_file"
    
    local corrections_applied=0
    
    # Apply corrections in reverse order (to maintain line numbers)
    local sorted_corrections
    sorted_corrections=$(printf '%s\n' "${corrections[@]}" | sort -t: -k1,1nr)
    
    while IFS=':' read -r line_num correction_type old_content new_content match_type; do
        if [[ -n "$line_num" ]] && [[ $corrections_applied -lt $MAX_CHANGES_PER_FILE ]]; then
            case "$correction_type" in
                "fix_broken_link")
                    # Escape special characters for sed
                    local old_escaped=$(echo "$old_content" | sed 's/[[\]*^$(){}+?.|\\]/\\&/g')
                    local new_escaped=$(echo "$new_content" | sed 's/[[\]*^$(){}+?.|\\]/\\&/g')
                    
                    sed -i "${line_num}s|$old_escaped|$new_escaped|g" "$temp_file"
                    METRICS["broken_links_fixed"]=$((METRICS["broken_links_fixed"] + 1))
                    corrections_applied=$((corrections_applied + 1))
                    
                    log "Fixed broken link at line $line_num: $match_type match"
                    ;;
            esac
        fi
    done <<< "$sorted_corrections"
    
    # Apply section additions
    for correction in "${corrections[@]}"; do
        if [[ "$correction" =~ ^append: ]]; then
            local section_type=$(echo "$correction" | cut -d: -f2)
            local section_content=$(echo "$correction" | cut -d: -f3-)
            
            echo "$section_content" >> "$temp_file"
            
            case "$section_type" in
                "principle_references")
                    METRICS["principle_references_added"]=$((METRICS["principle_references_added"] + 1))
                    ;;
                "cross_references")
                    METRICS["cross_references_added"]=$((METRICS["cross_references_added"] + 1))
                    ;;
            esac
            
            METRICS["reference_sections_added"]=$((METRICS["reference_sections_added"] + 1))
            corrections_applied=$((corrections_applied + 1))
            
            log "Added $section_type section to: $file"
        fi
    done
    
    mv "$temp_file" "$file"
    log "Applied $corrections_applied reference corrections to: $file"
    
    return $corrections_applied
}

#======================================================================
# ENFORCEMENT EXECUTION ENGINE
#======================================================================
process_file_for_cross_references() {
    local file="$1"
    local file_registry="$2"
    
    log "Processing: $file"
    METRICS["files_processed"]=$((METRICS["files_processed"] + 1))
    
    # Analyze reference issues
    local reference_issues
    reference_issues=$(analyze_file_references "$file" "$file_registry")
    
    local missing_sections
    missing_sections=$(check_required_cross_references "$file")
    
    local all_corrections=()
    
    # Generate link corrections
    if [[ -n "$reference_issues" ]]; then
        local link_corrections
        link_corrections=$(generate_link_corrections "$file" "$reference_issues")
        while IFS= read -r correction; do
            if [[ -n "$correction" ]]; then
                all_corrections+=("$correction")
            fi
        done <<< "$link_corrections"
    fi
    
    # Generate section additions
    if [[ -n "$missing_sections" ]]; then
        local section_additions
        section_additions=$(generate_cross_reference_sections "$file" "$missing_sections")
        while IFS= read -r addition; do
            if [[ -n "$addition" ]]; then
                all_corrections+=("$addition")
            fi
        done <<< "$section_additions"
    fi
    
    # Apply all corrections
    if [[ ${#all_corrections[@]} -gt 0 ]]; then
        local corrections_count
        corrections_count=$(apply_reference_corrections "$file" "${all_corrections[@]}")
        
        if [[ $corrections_count -gt 0 ]]; then
            METRICS["files_modified"]=$((METRICS["files_modified"] + 1))
            
            # Store correction operations for reporting
            REFERENCE_CORRECTIONS+=("$file:${#all_corrections[@]} corrections applied")
        fi
    else
        log "No cross-reference corrections needed for: $file"
    fi
}

find_files_for_cross_reference_enforcement() {
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
        "*/templates/*"  # Skip templates
    )
    
    # Find files that likely contain cross-references
    find "$PROJECT_ROOT" -name "*.md" -type f \
        | grep -v -E "($(IFS='|'; echo "${exclude_patterns[*]}"))" \
        | head -n "$MAX_FILES_PER_RUN"
}

execute_cross_reference_enforcement() {
    log "Starting cross-reference enforcement"
    log "Mode: $([ "$DRY_RUN" == "true" ] && echo "DRY RUN" || echo "LIVE")"
    log "Max files per run: $MAX_FILES_PER_RUN"
    
    # Create file registry for reference resolution
    local file_registry
    file_registry=$(discover_existing_files)
    log "Created file registry with $(wc -l < "$file_registry") files"
    
    local file_count=0
    while IFS= read -r file; do
        if [[ -n "$file" ]] && [[ -f "$file" ]]; then
            file_count=$((file_count + 1))
            
            if [[ $file_count -gt $MAX_FILES_PER_RUN ]]; then
                log "Reached maximum files per run limit: $MAX_FILES_PER_RUN"
                break
            fi
            
            process_file_for_cross_references "$file" "$file_registry"
        fi
    done < <(find_files_for_cross_reference_enforcement)
    
    # Cleanup
    rm -f "$file_registry"
    
    log "Cross-reference enforcement completed"
    log "Files processed: ${METRICS["files_processed"]}"
    log "Files modified: ${METRICS["files_modified"]}"
    log "Broken links fixed: ${METRICS["broken_links_fixed"]}"
    log "Cross-references added: ${METRICS["cross_references_added"]}"
    log "Principle references added: ${METRICS["principle_references_added"]}"
    log "Reference sections added: ${METRICS["reference_sections_added"]}"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    mkdir -p "$(dirname "$LOG_FILE")" "$BACKUP_DIR"
    
    log "Cross-Reference Enforcer starting"
    log "Project root: $PROJECT_ROOT"
    log "Dry run: $DRY_RUN"
    
    execute_cross_reference_enforcement
    
    # Output metrics for orchestrator
    local total_corrections=$((METRICS["broken_links_fixed"] + METRICS["cross_references_added"] + METRICS["principle_references_added"]))
    echo "CORRECTIONS_MADE:$total_corrections"
    echo "FILES_MODIFIED:${METRICS["files_modified"]}"
    
    # Save correction operations log
    if [[ ${#REFERENCE_CORRECTIONS[@]} -gt 0 ]]; then
        local corrections_log="$SCRIPT_DIR/../logs/cross-reference-corrections-$TIMESTAMP.log"
        printf '%s\n' "${REFERENCE_CORRECTIONS[@]}" > "$corrections_log"
        log "Cross-reference corrections logged to: $corrections_log"
    fi
    
    log "Cross-Reference Enforcer completed successfully"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi