#!/bin/bash

# Return-to-Top Link Insertion Script
# Automatically inserts standardized return-to-top links in documentation files
# Usage: ./insert-return-to-top.sh [file] or ./insert-return-to-top.sh --all

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Configuration
MIN_LINES=20
RETURN_TO_TOP_PATTERN="[⬆ Return to top]"
TEMP_FILE="/tmp/return_to_top_temp.md"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to extract document anchor from file
extract_document_anchor() {
    local file="$1"
    
    # Get first H1 heading and convert to anchor format
    local title=$(grep -m 1 "^# " "$file" 2>/dev/null | sed 's/^# //' | head -1)
    
    if [[ -z "$title" ]]; then
        log_warn "No H1 heading found in $file"
        return 1
    fi
    
    # Convert title to anchor format
    local anchor=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g' | sed 's/ /-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
    echo "#$anchor"
}

# Function to check if file needs return-to-top links
needs_return_to_top() {
    local file="$1"
    
    # Check file length
    local line_count=$(wc -l < "$file")
    if [[ $line_count -lt $MIN_LINES ]]; then
        return 1
    fi
    
    # Check if file has multiple sections (H2 headings)
    local h2_count=$(grep -c "^## " "$file" 2>/dev/null || echo 0)
    if [[ $h2_count -lt 2 ]]; then
        return 1
    fi
    
    return 0
}

# Function to determine insertion points
find_insertion_points() {
    local file="$1"
    local temp_points="/tmp/insertion_points.txt"
    
    # Find lines that should have return-to-top links after them
    grep -n "^## " "$file" | while IFS=: read -r line_num line_content; do
        # Skip if this is the last section and it's Cross-References
        if echo "$line_content" | grep -qi "cross.reference"; then
            continue
        fi
        
        # Find the end of this section (next ## or end of file)
        local next_section=$(tail -n +$((line_num + 1)) "$file" | grep -n "^## " | head -1 | cut -d: -f1)
        if [[ -n "$next_section" ]]; then
            local section_end=$((line_num + next_section - 1))
        else
            local section_end=$(wc -l < "$file")
        fi
        
        # Insert before the next section or at end
        local insert_line=$((section_end - 1))
        echo "$insert_line"
    done > "$temp_points"
    
    # Return unique, sorted insertion points
    sort -rn "$temp_points" | uniq
    rm -f "$temp_points"
}

# Function to insert return-to-top link
insert_return_to_top() {
    local file="$1"
    local anchor="$2"
    local insert_line="$3"
    
    local return_link="$RETURN_TO_TOP_PATTERN($anchor)"
    
    # Check if return-to-top already exists near this location
    local context_start=$((insert_line - 3 > 1 ? insert_line - 3 : 1))
    local context_end=$((insert_line + 3))
    
    if sed -n "${context_start},${context_end}p" "$file" | grep -q "$RETURN_TO_TOP_PATTERN"; then
        return 0  # Already exists, skip
    fi
    
    # Insert the return-to-top link
    {
        head -n "$insert_line" "$file"
        echo ""
        echo "$return_link"
        echo ""
        tail -n +$((insert_line + 1)) "$file"
    } > "$TEMP_FILE"
    
    mv "$TEMP_FILE" "$file"
    log_info "Inserted return-to-top link at line $insert_line in $(basename "$file")"
}

# Function to process a single file
process_file() {
    local file="$1"
    
    log_info "Processing $file"
    
    # Check if file needs return-to-top links
    if ! needs_return_to_top "$file"; then
        log_warn "File $file doesn't need return-to-top links (too short or insufficient sections)"
        return 0
    fi
    
    # Extract document anchor
    local anchor
    if ! anchor=$(extract_document_anchor "$file"); then
        log_error "Failed to extract document anchor from $file"
        return 1
    fi
    
    log_info "Using anchor: $anchor"
    
    # Find insertion points
    local insertion_points
    insertion_points=$(find_insertion_points "$file")
    
    if [[ -z "$insertion_points" ]]; then
        log_warn "No suitable insertion points found in $file"
        return 0
    fi
    
    # Insert return-to-top links at each point
    local modified=false
    while IFS= read -r line_num; do
        if [[ -n "$line_num" ]]; then
            insert_return_to_top "$file" "$anchor" "$line_num"
            modified=true
        fi
    done <<< "$insertion_points"
    
    if [[ "$modified" == true ]]; then
        log_info "Successfully updated $file"
    fi
}

# Function to process all markdown files
process_all_files() {
    local processed=0
    local updated=0
    
    log_info "Processing all markdown files in project..."
    
    find "$PROJECT_ROOT" -name "*.md" -type f | while read -r file; do
        # Skip project files and temporary files
        if [[ "$file" =~ /projects/ ]] || [[ "$(basename "$file")" =~ ^temp- ]]; then
            continue
        fi
        
        ((processed++))
        
        if process_file "$file"; then
            ((updated++))
        fi
    done
    
    log_info "Processed $processed files, updated $updated files"
}

# Main script logic
main() {
    if [[ $# -eq 0 ]] || [[ "$1" == "--help" ]]; then
        echo "Usage: $0 [file.md] | --all"
        echo "  file.md    Process specific markdown file"
        echo "  --all      Process all markdown files in project"
        echo "  --help     Show this help message"
        exit 0
    fi
    
    if [[ "$1" == "--all" ]]; then
        process_all_files
    elif [[ -f "$1" ]]; then
        process_file "$1"
    else
        log_error "File $1 not found"
        exit 1
    fi
}

# Ensure scripts directory exists
mkdir -p "$PROJECT_ROOT/scripts"

# Run main function
main "$@"