#!/bin/bash

# Remove Orchestration References from Agents Script
# Systematically removes orchestration capabilities from agent files

echo "=== ORCHESTRATION REFERENCE REMOVAL SCRIPT ==="
echo "Removing orchestration capabilities from agent files..."
echo

# Create backup directory
BACKUP_DIR="operations/orchestration-removal-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "1. CREATING BACKUPS"
echo "=================="
# Backup all agent files before modification
find agents/ -name "*.md" -exec cp {} "$BACKUP_DIR/" \; 2>/dev/null
echo "Agent files backed up to: $BACKUP_DIR"

echo
echo "2. REMOVING ORCHESTRATION TERMS FROM AGENT FILES"
echo "================================================"

# Define orchestration terms to remove/replace
declare -A ORCHESTRATION_REPLACEMENTS=(
    # Direct orchestration references
    ["orchestration specialist"]="coordination specialist"
    ["orchestrator specialist"]="coordination specialist"
    ["orchestration expert"]="coordination expert"
    ["orchestrates"]="coordinates"
    ["orchestrating"]="coordinating"
    ["orchestrated"]="coordinated"
    ["orchestration"]="coordination"
    ["orchestrator"]="coordinator"
    
    # Workflow orchestration
    ["workflow orchestration"]="workflow coordination"
    ["workflow orchestrator"]="workflow coordinator"
    ["system orchestration"]="system coordination"
    ["system orchestrator"]="system coordinator"
    
    # Multi-system orchestration
    ["multi-system orchestration"]="multi-system coordination"
    ["distributed orchestration"]="distributed coordination"
    ["parallel orchestration"]="parallel coordination"
    
    # Agent orchestration (most critical)
    ["agent orchestration"]="agent coordination"
    ["agent orchestrator"]="agent coordinator"
    ["orchestrate agents"]="coordinate agents"
    ["orchestrates agents"]="coordinates agents"
    ["orchestrating agents"]="coordinating agents"
    ["parallel agent orchestration"]="parallel agent coordination"
    
    # Management terms that imply orchestration
    ["orchestration management"]="coordination management"
    ["orchestration framework"]="coordination framework"
    ["orchestration patterns"]="coordination patterns"
    ["orchestration protocols"]="coordination protocols"
    
    # Infrastructure orchestration
    ["infrastructure orchestration"]="infrastructure coordination"
    ["deployment orchestration"]="deployment coordination"
    ["container orchestration"]="container coordination"
    
    # Process orchestration
    ["process orchestration"]="process coordination"
    ["execution orchestration"]="execution coordination"
    ["task orchestration"]="task coordination"
)

# Function to replace orchestration terms in a file
replace_orchestration_terms() {
    local file="$1"
    local temp_file=$(mktemp)
    
    cp "$file" "$temp_file"
    
    for old_term in "${!ORCHESTRATION_REPLACEMENTS[@]}"; do
        new_term="${ORCHESTRATION_REPLACEMENTS[$old_term]}"
        
        # Case-sensitive replacement
        sed -i '' "s|$old_term|$new_term|g" "$temp_file"
        
        # Capitalize first letter for sentence beginnings
        old_cap="$(echo "$old_term" | sed 's/\b\w/\U&/g')"
        new_cap="$(echo "$new_term" | sed 's/\b\w/\U&/g')"
        sed -i '' "s|$old_cap|$new_cap|g" "$temp_file"
        
        # Handle title case
        old_title="$(echo "$old_term" | sed 's/\b[a-z]/\U&/g')"
        new_title="$(echo "$new_term" | sed 's/\b[a-z]/\U&/g')"
        sed -i '' "s|$old_title|$new_title|g" "$temp_file"
    done
    
    # Check if changes were made
    if ! cmp -s "$file" "$temp_file"; then
        cp "$temp_file" "$file"
        echo "  ✓ Updated: $file"
        return 0
    else
        rm "$temp_file"
        return 1
    fi
}

# Process all agent files
updated_count=0
total_count=0

while IFS= read -r -d '' file; do
    ((total_count++))
    if replace_orchestration_terms "$file"; then
        ((updated_count++))
    fi
done < <(find agents/ -name "*.md" -print0 2>/dev/null)

echo
echo "3. HANDLING SPECIFIC PROBLEMATIC AGENTS"
echo "======================================="

# Handle specific agent files that need special treatment
PROBLEMATIC_AGENTS=(
    "agents/specialization/AGENT-006-workflow-coordinator.md"
    "agents/project-management/execution/ticket-automation-orchestrator.md"
    "agents/development/workflow/integration-coordinator.md"
)

for agent_file in "${PROBLEMATIC_AGENTS[@]}"; do
    if [[ -f "$agent_file" ]]; then
        echo "Processing problematic agent: $agent_file"
        
        # Remove explicit orchestration descriptions
        sed -i '' '/Advanced workflow orchestration/c\
Advanced workflow coordination' "$agent_file"
        
        sed -i '' '/orchestration specialist/c\
coordination specialist' "$agent_file"
        
        sed -i '' '/parallel agent orchestration/c\
parallel agent coordination' "$agent_file"
        
        echo "  ✓ Special handling applied to: $agent_file"
    fi
done

echo
echo "4. RENAMING ORCHESTRATOR AGENTS"
echo "==============================="

# Rename ticket-automation-orchestrator to ticket-automation-coordinator
if [[ -f "agents/project-management/execution/ticket-automation-orchestrator.md" ]]; then
    mv "agents/project-management/execution/ticket-automation-orchestrator.md" \
       "agents/project-management/execution/ticket-automation-coordinator.md"
    echo "  ✓ Renamed: ticket-automation-orchestrator.md → ticket-automation-coordinator.md"
    
    # Update the name field in the renamed file
    sed -i '' 's/name: ticket-automation-orchestrator/name: ticket-automation-coordinator/' \
        "agents/project-management/execution/ticket-automation-coordinator.md"
fi

echo
echo "5. UPDATING AGENT METADATA"
echo "=========================="

# Update agent metadata that contains orchestration references
find agents/ -name "*.md" -exec grep -l "orchestrat" {} \; | while read file; do
    # Update YAML frontmatter
    sed -i '' 's/orchestrat/coordinat/g' "$file"
    echo "  ✓ Updated metadata in: $file"
done

echo
echo "6. VERIFICATION SCAN"
echo "==================="

# Scan for remaining orchestration references
remaining_files=$(find agents/ -name "*.md" -exec grep -l -i "orchestrat" {} \; 2>/dev/null | wc -l)
echo "Remaining files with orchestration references: $remaining_files"

if [[ $remaining_files -gt 0 ]]; then
    echo "Files still containing orchestration references:"
    find agents/ -name "*.md" -exec grep -l -i "orchestrat" {} \; 2>/dev/null | head -10
fi

echo
echo "7. SUMMARY"
echo "=========="
echo "Total agent files processed: $total_count"
echo "Files updated with term replacements: $updated_count"
echo "Backup directory: $BACKUP_DIR"
echo

# Generate detailed report
echo "8. GENERATING DETAILED REPORT"
echo "============================="
REPORT_FILE="operations/orchestration-removal-report-$(date +%Y%m%d-%H%M%S).md"

cat > "$REPORT_FILE" << EOF
# Orchestration Reference Removal Report
Generated: $(date)

## Summary
- Total agent files processed: $total_count
- Files updated with term replacements: $updated_count
- Backup location: $BACKUP_DIR

## Changes Made
- Replaced "orchestration" with "coordination" throughout agent files
- Replaced "orchestrator" with "coordinator" throughout agent files
- Updated agent metadata and descriptions
- Renamed ticket-automation-orchestrator.md to ticket-automation-coordinator.md

## Term Replacements Applied
EOF

for old_term in "${!ORCHESTRATION_REPLACEMENTS[@]}"; do
    new_term="${ORCHESTRATION_REPLACEMENTS[$old_term]}"
    echo "- \"$old_term\" → \"$new_term\"" >> "$REPORT_FILE"
done

echo >> "$REPORT_FILE"
echo "## Verification Results" >> "$REPORT_FILE"
echo "Remaining files with orchestration references: $remaining_files" >> "$REPORT_FILE"

if [[ $remaining_files -gt 0 ]]; then
    echo >> "$REPORT_FILE"
    echo "### Files requiring manual review:" >> "$REPORT_FILE"
    find agents/ -name "*.md" -exec grep -l -i "orchestrat" {} \; 2>/dev/null | while read file; do
        echo "- $file" >> "$REPORT_FILE"
    done
fi

echo "Detailed report saved to: $REPORT_FILE"

echo
echo "=== ORCHESTRATION REMOVAL COMPLETE ==="
echo "Run validation script to verify all changes."