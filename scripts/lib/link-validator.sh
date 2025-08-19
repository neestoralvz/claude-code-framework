#!/bin/bash
# Link Validator Library
# Validates existence of link targets

# Resolve relative path from a source file to target
# Usage: resolve_relative_path <source_file> <target_path>
resolve_relative_path() {
    local source_file="$1"
    local target_path="$2"
    local source_dir
    
    # Get directory of source file
    source_dir=$(dirname "$source_file")
    
    # If target is absolute, return as-is
    if [[ "$target_path" = /* ]]; then
        echo "$target_path"
        return 0
    fi
    
    # Resolve relative path
    local resolved_path="$source_dir/$target_path"
    
    # Normalize path (remove ./ and ../)
    echo "$resolved_path" | sed 's|/\./|/|g' | \
    while IFS='/' read -ra ADDR; do
        local normalized_parts=()
        for part in "${ADDR[@]}"; do
            if [[ "$part" == ".." ]] && [[ ${#normalized_parts[@]} -gt 0 ]]; then
                unset 'normalized_parts[-1]'
            elif [[ "$part" != "." ]] && [[ -n "$part" ]]; then
                normalized_parts+=("$part")
            fi
        done
        printf '%s\n' "${normalized_parts[@]}" | paste -sd '/'
    done
}

# Check if a file exists in the framework
# Usage: validate_file_exists <file_path>
validate_file_exists() {
    local file_path="$1"
    
    # Check exact path
    if [[ -f "$file_path" ]]; then
        return 0
    fi
    
    # Check if it exists in framework root
    if [[ -f "$FRAMEWORK_ROOT/$file_path" ]]; then
        return 0
    fi
    
    return 1
}

# Validate a single link target
# Usage: validate_single_link <source_file> <target> <line_number>
validate_single_link() {
    local source_file="$1"
    local target="$2"
    local line_number="$3"
    local resolved_path
    
    # Skip external links (http, https, mailto, etc.)
    if [[ "$target" =~ ^[a-zA-Z][a-zA-Z0-9+.-]*: ]]; then
        return 0
    fi
    
    # Skip empty targets
    if [[ -z "$target" ]]; then
        return 1
    fi
    
    # Normalize target
    target=$(normalize_link_target "$target")
    
    # Resolve relative path
    resolved_path=$(resolve_relative_path "$source_file" "$target")
    
    # Validate file existence
    if validate_file_exists "$resolved_path"; then
        return 0
    fi
    
    # Check if it's a valid framework path
    if validate_file_exists "$target"; then
        return 0
    fi
    
    return 1
}

# Validate all links from a links file
# Usage: validate_all_links <links_file> <broken_links_file>
validate_all_links() {
    local links_file="$1"
    local broken_links_file="$2"
    local max_jobs="${MAX_JOBS:-4}"
    
    # Clear output file
    > "$broken_links_file"
    
    # Process links in parallel
    while IFS='|' read -r source_file line_number full_line link_text link_target; do
        # Skip empty lines
        [[ -z "$source_file" ]] && continue
        
        # Wait if we have too many background jobs
        while (( $(jobs -r | wc -l) >= max_jobs )); do
            sleep 0.1
        done
        
        # Validate link in background
        {
            if ! validate_single_link "$source_file" "$link_target" "$line_number"; then
                echo "$source_file|$line_number|$full_line|$link_text|$link_target" >> "$broken_links_file.tmp.$$"
            fi
        } &
    done < "$links_file"
    
    # Wait for all validation jobs to complete
    wait
    
    # Consolidate temporary files
    cat "$broken_links_file.tmp."* >> "$broken_links_file" 2>/dev/null
    rm -f "$broken_links_file.tmp."* 2>/dev/null
    
    return 0
}

# Get detailed validation info for a broken link
# Usage: get_validation_details <source_file> <target>
get_validation_details() {
    local source_file="$1"
    local target="$2"
    local resolved_path
    local suggestions=()
    
    # Resolve path
    resolved_path=$(resolve_relative_path "$source_file" "$target")
    
    # Check for similar files
    local base_name=$(basename "$target" .md)
    local dir_name=$(dirname "$target")
    
    # Look for similar files in the same directory
    if [[ -d "$FRAMEWORK_ROOT/$dir_name" ]]; then
        local similar_files
        similar_files=$(find "$FRAMEWORK_ROOT/$dir_name" -name "*$base_name*.md" 2>/dev/null | head -3)
        if [[ -n "$similar_files" ]]; then
            while IFS= read -r similar_file; do
                local relative_similar
                relative_similar=${similar_file#$FRAMEWORK_ROOT/}
                suggestions+=("$relative_similar")
            done <<< "$similar_files"
        fi
    fi
    
    # Export results
    export VALIDATION_RESOLVED_PATH="$resolved_path"
    export VALIDATION_SUGGESTIONS="${suggestions[*]}"
}