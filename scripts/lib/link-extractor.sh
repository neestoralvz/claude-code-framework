#!/bin/bash
# Link Extractor Library
# Extracts internal markdown links from files

# Extract all markdown links from a file
# Usage: extract_links_from_file <file_path> <output_file>
extract_links_from_file() {
    local file_path="$1"
    local output_file="$2"
    
    if [[ ! -f "$file_path" ]]; then
        return 1
    fi
    
    # Extract markdown links: [text](target.md) or [text](target)
    # Include line numbers for context
    grep -n '\[.*\](.*\.md\|[^)]*[^/]\/[^)]*\|docs\/\|commands\/\|agents\/\|tickets\/\|playbook\/)' "$file_path" | \
    sed -E 's/^([0-9]+):(.*)\[([^\]]*)\]\(([^)]+)\)(.*)/\1|\2[\3](\4)\5|\3|\4/' >> "$output_file" 2>/dev/null
    
    return 0
}

# Extract all links from multiple files in parallel
# Usage: extract_all_links <input_file_list> <output_file>
extract_all_links() {
    local file_list="$1"
    local output_file="$2"
    local max_jobs="${MAX_JOBS:-4}"
    
    # Clear output file
    > "$output_file"
    
    # Process files in parallel
    while IFS= read -r file_path; do
        # Wait if we have too many background jobs
        while (( $(jobs -r | wc -l) >= max_jobs )); do
            sleep 0.1
        done
        
        # Process file in background
        extract_links_from_file "$file_path" "$output_file.tmp.$$" &
    done < "$file_list"
    
    # Wait for all jobs to complete
    wait
    
    # Consolidate temporary files
    cat "$output_file.tmp."* >> "$output_file" 2>/dev/null
    rm -f "$output_file.tmp."* 2>/dev/null
    
    return 0
}

# Parse extracted link data
# Usage: parse_link_entry <link_entry>
parse_link_entry() {
    local entry="$1"
    
    # Parse: line_number|full_line|link_text|link_target
    local line_number=$(echo "$entry" | cut -d'|' -f1)
    local full_line=$(echo "$entry" | cut -d'|' -f2)
    local link_text=$(echo "$entry" | cut -d'|' -f3)
    local link_target=$(echo "$entry" | cut -d'|' -f4)
    
    # Export for use by calling function
    export PARSED_LINE_NUMBER="$line_number"
    export PARSED_FULL_LINE="$full_line"
    export PARSED_LINK_TEXT="$link_text"
    export PARSED_LINK_TARGET="$link_target"
}

# Clean and normalize link targets
# Usage: normalize_link_target <target>
normalize_link_target() {
    local target="$1"
    
    # Remove fragments (#section)
    target="${target%%#*}"
    
    # Remove query parameters (?param=value)
    target="${target%%\?*}"
    
    # Trim whitespace
    target=$(echo "$target" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    echo "$target"
}

# Extract unique link targets for validation
# Usage: get_unique_targets <links_file> <targets_file>
get_unique_targets() {
    local links_file="$1"
    local targets_file="$2"
    
    # Extract just the targets and make them unique
    cut -d'|' -f4 "$links_file" | \
    while IFS= read -r target; do
        normalize_link_target "$target"
    done | \
    sort -u > "$targets_file"
}