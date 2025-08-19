#!/bin/bash
# Report Generator Library
# Generates JSON, CSV, and human-readable reports

# Generate JSON report
# Usage: generate_json_report <categorized_links_file> <summary_file> <suggestions_file> <output_file>
generate_json_report() {
    local categorized_links_file="$1"
    local summary_file="$2"
    local suggestions_file="$3"
    local output_file="$4"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    # Start JSON structure
    cat > "$output_file" << EOF
{
  "scan_metadata": {
    "timestamp": "$timestamp",
    "framework_root": "$FRAMEWORK_ROOT",
    "scanner_version": "1.0.0",
    "total_files_scanned": $(find "$FRAMEWORK_ROOT" -name "*.md" -type f | wc -l | tr -d ' '),
    "total_links_found": $(wc -l < "$TEMP_DIR/all_links.txt" | tr -d ' '),
    "broken_links_count": $(tail -n +2 "$categorized_links_file" | wc -l | tr -d ' ')
  },
  "broken_links": [
EOF

    # Add broken links data
    local first_entry=true
    tail -n +2 "$categorized_links_file" | while IFS='|' read -r id source_file line_number full_line link_text link_target category priority status; do
        # Get suggestion for this link
        local suggestion=""
        local confidence=""
        if [[ -f "$suggestions_file" ]]; then
            local suggestion_line
            suggestion_line=$(grep "^$id|" "$suggestions_file" 2>/dev/null)
            if [[ -n "$suggestion_line" ]]; then
                suggestion=$(echo "$suggestion_line" | cut -d'|' -f2)
                confidence=$(echo "$suggestion_line" | cut -d'|' -f3)
            fi
        fi
        
        # Add comma for all but first entry
        if [[ "$first_entry" == "true" ]]; then
            first_entry=false
        else
            echo "," >> "$output_file"
        fi
        
        # Escape JSON strings
        local escaped_full_line
        escaped_full_line=$(echo "$full_line" | sed 's/"/\\"/g' | sed 's/\\/\\\\/g')
        local escaped_link_text
        escaped_link_text=$(echo "$link_text" | sed 's/"/\\"/g' | sed 's/\\/\\\\/g')
        local escaped_suggestion
        escaped_suggestion=$(echo "$suggestion" | sed 's/"/\\"/g' | sed 's/\\/\\\\/g')
        
        # Add JSON entry
        cat >> "$output_file" << EOF
    {
      "id": "$id",
      "file": "$source_file",
      "line": $line_number,
      "full_line": "$escaped_full_line",
      "link_text": "$escaped_link_text",
      "link_target": "$link_target",
      "category": "$category",
      "priority": "$priority",
      "status": "$status",
      "suggested_fix": "$escaped_suggestion",
      "confidence": "$confidence"
    }
EOF
    done
    
    # Add summary section
    cat >> "$output_file" << EOF
  ],
  "summary": {
EOF

    # Parse summary data
    if [[ -f "$summary_file" ]]; then
        local total_broken
        total_broken=$(grep "SUMMARY_TOTAL_BROKEN=" "$summary_file" | cut -d'=' -f2)
        
        echo "    \"total_broken\": $total_broken," >> "$output_file"
        echo "    \"by_category\": {" >> "$output_file"
        
        # Category counts
        local first_cat=true
        grep -A 10 "SUMMARY_BY_CATEGORY:" "$summary_file" | grep "  " | while IFS='=' read -r category count; do
            category=$(echo "$category" | sed 's/^[[:space:]]*//')
            if [[ "$first_cat" == "true" ]]; then
                first_cat=false
            else
                echo "," >> "$output_file"
            fi
            echo "      \"$category\": $count" >> "$output_file"
        done
        
        echo "    }," >> "$output_file"
        echo "    \"by_priority\": {" >> "$output_file"
        
        # Priority counts
        local first_pri=true
        grep -A 10 "SUMMARY_BY_PRIORITY:" "$summary_file" | grep "  " | while IFS='=' read -r priority count; do
            priority=$(echo "$priority" | sed 's/^[[:space:]]*//')
            if [[ "$first_pri" == "true" ]]; then
                first_pri=false
            else
                echo "," >> "$output_file"
            fi
            echo "      \"$priority\": $count" >> "$output_file"
        done
        
        echo "    }" >> "$output_file"
    fi
    
    # Close JSON structure
    cat >> "$output_file" << EOF
  }
}
EOF
}

# Generate CSV report
# Usage: generate_csv_report <categorized_links_file> <output_file>
generate_csv_report() {
    local categorized_links_file="$1"
    local output_file="$2"
    
    # Copy header and data to CSV file
    cat "$categorized_links_file" | sed 's/|/,/g' > "$output_file"
}

# Generate human-readable report
# Usage: generate_human_report <categorized_links_file> <summary_file> <output_file>
generate_human_report() {
    local categorized_links_file="$1"
    local summary_file="$2"
    local output_file="$3"
    local timestamp=$(date)
    
    cat > "$output_file" << EOF
# AUTOMATED LINK SCANNER REPORT
**Generated**: $timestamp
**Framework Root**: $FRAMEWORK_ROOT
**Scanner Version**: 1.0.0

## EXECUTIVE SUMMARY

EOF
    
    # Add summary statistics
    if [[ -f "$summary_file" ]]; then
        local total_broken
        total_broken=$(grep "SUMMARY_TOTAL_BROKEN=" "$summary_file" | cut -d'=' -f2)
        
        echo "- **Total Broken Links**: $total_broken" >> "$output_file"
        echo "" >> "$output_file"
        
        echo "### Breakdown by Category" >> "$output_file"
        echo "| Category | Count |" >> "$output_file"
        echo "|----------|-------|" >> "$output_file"
        
        grep -A 10 "SUMMARY_BY_CATEGORY:" "$summary_file" | grep "  " | while IFS='=' read -r category count; do
            category=$(echo "$category" | sed 's/^[[:space:]]*//')
            echo "| $category | $count |" >> "$output_file"
        done
        
        echo "" >> "$output_file"
        echo "### Breakdown by Priority" >> "$output_file"
        echo "| Priority | Count |" >> "$output_file"
        echo "|----------|-------|" >> "$output_file"
        
        grep -A 10 "SUMMARY_BY_PRIORITY:" "$summary_file" | grep "  " | while IFS='=' read -r priority count; do
            priority=$(echo "$priority" | sed 's/^[[:space:]]*//')
            echo "| $priority | $count |" >> "$output_file"
        done
    fi
    
    # Add critical links section
    echo "" >> "$output_file"
    echo "## CRITICAL BROKEN LINKS" >> "$output_file"
    echo "" >> "$output_file"
    
    local critical_count
    critical_count=$(tail -n +2 "$categorized_links_file" | grep "|critical|" | wc -l | tr -d ' ')
    
    if [[ "$critical_count" -gt 0 ]]; then
        echo "Found $critical_count critical broken links:" >> "$output_file"
        echo "" >> "$output_file"
        
        tail -n +2 "$categorized_links_file" | grep "|critical|" | head -20 | while IFS='|' read -r id source_file line_number full_line link_text link_target category priority status; do
            echo "**$id**: $source_file (line $line_number)" >> "$output_file"
            echo "- Link: [$link_text]($link_target)" >> "$output_file"
            echo "- Category: $category" >> "$output_file"
            echo "" >> "$output_file"
        done
    else
        echo "No critical broken links found." >> "$output_file"
    fi
    
    # Add high priority links section
    echo "" >> "$output_file"
    echo "## HIGH PRIORITY BROKEN LINKS" >> "$output_file"
    echo "" >> "$output_file"
    
    local high_count
    high_count=$(tail -n +2 "$categorized_links_file" | grep "|high|" | wc -l | tr -d ' ')
    
    if [[ "$high_count" -gt 0 ]]; then
        echo "Found $high_count high priority broken links (showing first 10):" >> "$output_file"
        echo "" >> "$output_file"
        
        tail -n +2 "$categorized_links_file" | grep "|high|" | head -10 | while IFS='|' read -r id source_file line_number full_line link_text link_target category priority status; do
            echo "**$id**: $source_file (line $line_number)" >> "$output_file"
            echo "- Link: [$link_text]($link_target)" >> "$output_file"
            echo "- Category: $category" >> "$output_file"
            echo "" >> "$output_file"
        done
    else
        echo "No high priority broken links found." >> "$output_file"
    fi
}

# Generate all report formats
# Usage: generate_all_reports <categorized_links_file> <summary_file> <suggestions_file> <output_prefix>
generate_all_reports() {
    local categorized_links_file="$1"
    local summary_file="$2"
    local suggestions_file="$3"
    local output_prefix="$4"
    
    # Generate JSON report
    generate_json_report "$categorized_links_file" "$summary_file" "$suggestions_file" "${output_prefix}.json"
    
    # Generate CSV report  
    generate_csv_report "$categorized_links_file" "${output_prefix}.csv"
    
    # Generate human-readable report
    generate_human_report "$categorized_links_file" "$summary_file" "${output_prefix}.md"
    
    echo "Reports generated:"
    echo "  JSON: ${output_prefix}.json"
    echo "  CSV: ${output_prefix}.csv"
    echo "  Markdown: ${output_prefix}.md"
}