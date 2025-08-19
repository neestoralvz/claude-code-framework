#!/bin/bash
# Link Categorizer Library
# Categorizes broken links by type and priority

# Categorize a link target by type
# Usage: categorize_link_type <target>
categorize_link_type() {
    local target="$1"
    local category="other"
    
    case "$target" in
        commands/*|**/command-*.md|**/commands.md)
            category="command" ;;
        planning/*|**/tickets/**|**/registry*|**/TICKET*.md)
            category="registry" ;;
        *breadcrumb*|*navigation*|**/nav-*.md|**/index.md|docs/index.md)
            category="navigation" ;;
        *workflow*|*methodology*|**/procedures/**|**/playbook/**)
            category="workflow" ;;
        docs/components/**|**/templates/**)
            category="component" ;;
        agents/**|**/agent-*.md)
            category="agent" ;;
        docs/principles/**|**/principles.md)
            category="principle" ;;
        *)
            category="other" ;;
    esac
    
    echo "$category"
}

# Determine priority based on file and link type
# Usage: determine_priority <source_file> <target> <category>
determine_priority() {
    local source_file="$1"
    local target="$2"
    local category="$3"
    local priority="low"
    
    # Critical priority conditions
    if [[ "$source_file" == *"CLAUDE.md"* ]] || [[ "$source_file" == *"README.md"* ]]; then
        priority="critical"
    elif [[ "$source_file" == *"docs/index.md"* ]] || [[ "$source_file" == *"/index.md"* ]]; then
        priority="critical"
    elif [[ "$category" == "command" ]] && [[ "$source_file" == *"commands/"* ]]; then
        priority="critical"
    # High priority conditions
    elif [[ "$category" == "command" ]] || [[ "$category" == "navigation" ]]; then
        priority="high"
    elif [[ "$source_file" == *"docs/"* ]] && [[ "$category" == "workflow" ]]; then
        priority="high"
    # Medium priority conditions
    elif [[ "$category" == "workflow" ]] || [[ "$category" == "registry" ]] || [[ "$category" == "agent" ]]; then
        priority="medium"
    elif [[ "$source_file" == *"docs/"* ]]; then
        priority="medium"
    # Low priority (default)
    else
        priority="low"
    fi
    
    echo "$priority"
}

# Categorize all broken links
# Usage: categorize_broken_links <broken_links_file> <categorized_links_file>
categorize_broken_links() {
    local broken_links_file="$1"
    local categorized_links_file="$2"
    local link_id=1
    
    # Clear output file and add header
    echo "id|source_file|line_number|full_line|link_text|link_target|category|priority|status" > "$categorized_links_file"
    
    # Process each broken link
    while IFS='|' read -r source_file line_number full_line link_text link_target; do
        # Skip empty lines
        [[ -z "$source_file" ]] && continue
        
        # Categorize link
        local category
        category=$(categorize_link_type "$link_target")
        
        # Determine priority
        local priority
        priority=$(determine_priority "$source_file" "$link_target" "$category")
        
        # Generate ID
        local formatted_id
        formatted_id=$(printf "broken-%03d" $link_id)
        
        # Add to categorized file
        echo "$formatted_id|$source_file|$line_number|$full_line|$link_text|$link_target|$category|$priority|broken" >> "$categorized_links_file"
        
        ((link_id++))
    done < "$broken_links_file"
}

# Generate summary statistics
# Usage: generate_summary_stats <categorized_links_file> <summary_file>
generate_summary_stats() {
    local categorized_links_file="$1"
    local summary_file="$2"
    
    # Skip header line and calculate statistics
    tail -n +2 "$categorized_links_file" | {
        local total_broken=0
        declare -A category_counts
        declare -A priority_counts
        
        while IFS='|' read -r id source_file line_number full_line link_text link_target category priority status; do
            ((total_broken++))
            ((category_counts[$category]++))
            ((priority_counts[$priority]++))
        done
        
        # Write summary to file
        {
            echo "SUMMARY_TOTAL_BROKEN=$total_broken"
            echo "SUMMARY_BY_CATEGORY:"
            for category in "${!category_counts[@]}"; do
                echo "  $category=${category_counts[$category]}"
            done
            echo "SUMMARY_BY_PRIORITY:"
            for priority in "${!priority_counts[@]}"; do
                echo "  $priority=${priority_counts[$priority]}"
            done
        } > "$summary_file"
    }
}

# Get suggested fixes for broken links
# Usage: suggest_link_fixes <categorized_links_file> <suggestions_file>
suggest_link_fixes() {
    local categorized_links_file="$1"
    local suggestions_file="$2"
    
    # Clear output file
    echo "id|suggested_fix|confidence" > "$suggestions_file"
    
    # Process each broken link
    tail -n +2 "$categorized_links_file" | while IFS='|' read -r id source_file line_number full_line link_text link_target category priority status; do
        local suggested_fix=""
        local confidence="low"
        
        # Generate suggestions based on patterns
        case "$link_target" in
            commands/analysis/*)
                suggested_fix="Check if moved to docs/components/ or commands/"
                confidence="medium" ;;
            docs/principles/*)
                suggested_fix="Verify principle file exists or use docs/PRINCIPLES.md"
                confidence="high" ;;
            **/index.md)
                suggested_fix="Verify directory structure and index file location"
                confidence="medium" ;;
            ../*)
                suggested_fix="Review relative path resolution from source directory"
                confidence="high" ;;
            *)
                suggested_fix="Verify file exists and check for recent moves"
                confidence="low" ;;
        esac
        
        echo "$id|$suggested_fix|$confidence" >> "$suggestions_file"
    done
}