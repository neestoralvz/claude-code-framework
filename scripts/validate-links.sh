#!/bin/bash

# Comprehensive Link Validation Script for Commands-Docs Workflows Directory
# Created: $(date)
# Purpose: Validate all markdown links in the workflows directory

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Base directory for validation
BASE_DIR="/Users/nalve/.claude/docs/commands-docs/.claude/workflows"
REPORT_FILE="${BASE_DIR}/link-validation-report.txt"

# Counters
TOTAL_FILES=0
TOTAL_LINKS=0
BROKEN_LINKS=0
VALID_LINKS=0

# Arrays to store results
declare -a BROKEN_LINK_DETAILS=()
declare -a VALID_LINK_DETAILS=()

echo -e "${BLUE}=== COMPREHENSIVE LINK VALIDATION REPORT ===${NC}"
echo -e "${BLUE}Generated: $(date)${NC}"
echo -e "${BLUE}Target Directory: ${BASE_DIR}${NC}"
echo ""

# Initialize report file
cat > "${REPORT_FILE}" << EOF
COMPREHENSIVE LINK VALIDATION REPORT
Generated: $(date)
Target Directory: ${BASE_DIR}

=== SUMMARY ===
EOF

# Function to resolve relative paths
resolve_path() {
    local link_path="$1"
    local source_file="$2"
    local resolved_path=""
    
    # Get directory of source file
    local source_dir=$(dirname "$source_file")
    
    # Handle absolute paths
    if [[ "$link_path" == /* ]]; then
        resolved_path="$link_path"
    else
        # Handle relative paths
        resolved_path=$(realpath -m "$source_dir/$link_path" 2>/dev/null || echo "$source_dir/$link_path")
    fi
    
    echo "$resolved_path"
}

# Function to check if file exists
check_file_exists() {
    local file_path="$1"
    
    # Handle different scenarios
    if [[ -f "$file_path" ]]; then
        echo "exists"
    elif [[ -d "$file_path" ]]; then
        echo "directory"
    else
        echo "missing"
    fi
}

# Find all markdown files in the workflows directory
echo -e "${YELLOW}Scanning for markdown files...${NC}"

# Use a more compatible approach to collect files
MD_FILES_LIST=$(find "${BASE_DIR}" -name "*.md" -type f 2>/dev/null | sort)

if [[ -z "$MD_FILES_LIST" ]]; then
    echo -e "${RED}No markdown files found in ${BASE_DIR}${NC}"
    exit 1
fi

# Count files
TOTAL_FILES=$(echo "$MD_FILES_LIST" | wc -l)
echo -e "${GREEN}Found ${TOTAL_FILES} markdown files${NC}"
echo ""

# Process each markdown file
while IFS= read -r md_file; do
    echo -e "${BLUE}Processing: ${md_file}${NC}"
    
    # Extract markdown links using multiple patterns
    # Pattern 1: [text](link) - standard markdown links
    # Pattern 2: [text]: link - reference-style links
    # Pattern 3: <link> - direct links
    
    # Use grep to find lines with markdown links
    if [[ -f "$md_file" ]]; then
        # Find standard markdown links [text](link)
        while IFS= read -r line_with_number; do
            if [[ -n "$line_with_number" ]]; then
                line_number=$(echo "$line_with_number" | cut -d: -f1)
                line_content=$(echo "$line_with_number" | cut -d: -f2-)
                
                # Extract links using sed
                links=$(echo "$line_content" | sed -n 's/.*\[\([^]]*\)\](\([^)]*\)).*/\2/gp')
                
                while IFS= read -r link; do
                    if [[ -n "$link" && "$link" != "#"* ]]; then
                        TOTAL_LINKS=$((TOTAL_LINKS + 1))
                        
                        # Skip external URLs
                        if [[ "$link" =~ ^https?:// ]]; then
                            echo -e "  ${YELLOW}Skipping external URL: ${link}${NC}"
                            continue
                        fi
                        
                        # Skip anchors within same file
                        if [[ "$link" == "#"* ]]; then
                            echo -e "  ${YELLOW}Skipping anchor: ${link}${NC}"
                            continue
                        fi
                        
                        # Resolve the path
                        resolved_path=$(resolve_path "$link" "$md_file")
                        
                        # Check if file exists
                        file_status=$(check_file_exists "$resolved_path")
                        
                        if [[ "$file_status" == "exists" || "$file_status" == "directory" ]]; then
                            VALID_LINKS=$((VALID_LINKS + 1))
                            VALID_LINK_DETAILS+=("✓ ${md_file}:${line_number} → ${link} (${file_status})")
                            echo -e "    ${GREEN}✓ Valid: ${link} → ${resolved_path}${NC}"
                        else
                            BROKEN_LINKS=$((BROKEN_LINKS + 1))
                            BROKEN_LINK_DETAILS+=("✗ ${md_file}:${line_number} → ${link} (MISSING: ${resolved_path})")
                            echo -e "    ${RED}✗ Broken: ${link} → ${resolved_path}${NC}"
                        fi
                    fi
                done <<< "$links"
            fi
        done < <(grep -n '\[.*\](.*\.md\|.*/)' "$md_file" 2>/dev/null || true)
        
        # Also check reference-style links [text]: link
        while IFS= read -r line_with_number; do
            if [[ -n "$line_with_number" ]]; then
                line_number=$(echo "$line_with_number" | cut -d: -f1)
                line_content=$(echo "$line_with_number" | cut -d: -f2-)
                
                # Extract reference links
                ref_link=$(echo "$line_content" | sed -n 's/^\[.*\]:[[:space:]]*\(.*\)/\1/p' | xargs)
                
                if [[ -n "$ref_link" && "$ref_link" != "#"* ]]; then
                    TOTAL_LINKS=$((TOTAL_LINKS + 1))
                    
                    # Skip external URLs
                    if [[ "$ref_link" =~ ^https?:// ]]; then
                        echo -e "  ${YELLOW}Skipping external URL: ${ref_link}${NC}"
                        continue
                    fi
                    
                    # Resolve the path
                    resolved_path=$(resolve_path "$ref_link" "$md_file")
                    
                    # Check if file exists
                    file_status=$(check_file_exists "$resolved_path")
                    
                    if [[ "$file_status" == "exists" || "$file_status" == "directory" ]]; then
                        VALID_LINKS=$((VALID_LINKS + 1))
                        VALID_LINK_DETAILS+=("✓ ${md_file}:${line_number} → ${ref_link} (reference, ${file_status})")
                        echo -e "    ${GREEN}✓ Valid reference: ${ref_link} → ${resolved_path}${NC}"
                    else
                        BROKEN_LINKS=$((BROKEN_LINKS + 1))
                        BROKEN_LINK_DETAILS+=("✗ ${md_file}:${line_number} → ${ref_link} (reference, MISSING: ${resolved_path})")
                        echo -e "    ${RED}✗ Broken reference: ${ref_link} → ${resolved_path}${NC}"
                    fi
                fi
            fi
        done < <(grep -n '^\[.*\]:' "$md_file" 2>/dev/null || true)
    fi
    echo ""
done <<< "$MD_FILES_LIST"

# Generate summary report
echo -e "${BLUE}=== VALIDATION SUMMARY ===${NC}"
echo -e "${BLUE}Files Processed: ${TOTAL_FILES}${NC}"
echo -e "${BLUE}Total Links Found: ${TOTAL_LINKS}${NC}"
echo -e "${GREEN}Valid Links: ${VALID_LINKS}${NC}"
echo -e "${RED}Broken Links: ${BROKEN_LINKS}${NC}"

if [[ ${BROKEN_LINKS} -eq 0 ]]; then
    echo -e "${GREEN}✓ All links are valid!${NC}"
else
    echo -e "${RED}✗ Found ${BROKEN_LINKS} broken links${NC}"
fi

# Write detailed report to file
{
    echo "Files Processed: ${TOTAL_FILES}"
    echo "Total Links Found: ${TOTAL_LINKS}"
    echo "Valid Links: ${VALID_LINKS}"
    echo "Broken Links: ${BROKEN_LINKS}"
    echo ""
    echo "=== BROKEN LINKS DETAILS ==="
    if [[ ${BROKEN_LINKS} -gt 0 ]]; then
        printf '%s\n' "${BROKEN_LINK_DETAILS[@]}"
    else
        echo "No broken links found."
    fi
    echo ""
    echo "=== VALID LINKS DETAILS ==="
    if [[ ${VALID_LINKS} -gt 0 ]]; then
        printf '%s\n' "${VALID_LINK_DETAILS[@]}"
    else
        echo "No valid links found."
    fi
} >> "${REPORT_FILE}"

echo ""
echo -e "${BLUE}Detailed report saved to: ${REPORT_FILE}${NC}"

# Show broken links if any
if [[ ${BROKEN_LINKS} -gt 0 ]]; then
    echo ""
    echo -e "${RED}=== BROKEN LINKS DETAILS ===${NC}"
    printf '%s\n' "${BROKEN_LINK_DETAILS[@]}" | while read -r detail; do
        echo -e "${RED}${detail}${NC}"
    done
fi

# Exit with error code if broken links found
exit ${BROKEN_LINKS}