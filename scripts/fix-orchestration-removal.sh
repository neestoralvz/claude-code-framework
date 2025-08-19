#!/bin/bash

# Fix Orchestration Removal Script
# Fixes the syntax errors and completes the orchestration reference removal

echo "=== ORCHESTRATION REMOVAL FIX SCRIPT ==="
echo "Fixing orchestration reference removal..."
echo

# Fix the problematic agent files that have syntax errors
echo "1. FIXING SYNTAX ERRORS"
echo "======================="

# Fix AGENT-006-workflow-coordinator.md
echo "Fixing AGENT-006-workflow-coordinator.md..."
if [[ -f "agents/specialization/AGENT-006-workflow-coordinator.md" ]]; then
    # Fix the broken YAML frontmatter
    sed -i '' '3s/Advanced workflow coordinationtools:/description: "Advanced workflow coordination and distributed systems coordination specialist"/g' \
        "agents/specialization/AGENT-006-workflow-coordinator.md"
    
    # Add missing tools line
    sed -i '' '4i\
tools: Bash, WebFetch, BashOutput, KillBash, TodoWrite' \
        "agents/specialization/AGENT-006-workflow-coordinator.md"
    
    # Fix the broken description at line 12
    sed -i '' '12s/parallel agent coordination/You are an Advanced Workflow Coordination and Distributed Systems Coordination Specialist./g' \
        "agents/specialization/AGENT-006-workflow-coordinator.md"
    
    echo "  ✓ Fixed AGENT-006-workflow-coordinator.md"
fi

echo
echo "2. SYSTEMATIC ORCHESTRATION TERM REPLACEMENT"
echo "==========================================="

# Function to safely replace orchestration terms
safe_replace() {
    local file="$1"
    local old_pattern="$2"
    local new_pattern="$3"
    
    if [[ -f "$file" ]]; then
        # Use perl for more reliable regex replacement
        perl -pi -e "s/\Q$old_pattern\E/$new_pattern/g" "$file"
        # Handle capitalized versions
        local old_cap="$(echo "$old_pattern" | sed 's/\b\w/\U&/g')"
        local new_cap="$(echo "$new_pattern" | sed 's/\b\w/\U&/g')"
        perl -pi -e "s/\Q$old_cap\E/$new_cap/g" "$file"
    fi
}

# Define files that need orchestration term replacement
declare -a FILES_TO_PROCESS=(
    "agents/specialization/AGENT-006-workflow-coordinator.md"
    "agents/development/workflow/integration-coordinator.md"
    "agents/development/workflow/deployment-coordinator.md"
    "agents/development/workflow/workflow-coordinator.md"
    "agents/project-management/execution/ticket-automation-coordinator.md"
    "agents/operations/orchestration/container-orchestration-specialist.md"
    "agents/infrastructure/kubernetes-orchestration-specialist.md"
)

# Process each file with orchestration replacements
for file in "${FILES_TO_PROCESS[@]}"; do
    if [[ -f "$file" ]]; then
        echo "Processing: $file"
        
        # Replace orchestration terms
        safe_replace "$file" "orchestration" "coordination"
        safe_replace "$file" "orchestrator" "coordinator"
        safe_replace "$file" "orchestrate" "coordinate"
        safe_replace "$file" "orchestrating" "coordinating"
        safe_replace "$file" "orchestrated" "coordinated"
        safe_replace "$file" "orchestrates" "coordinates"
        
        # Fix specific patterns
        safe_replace "$file" "workflow coordination specialist" "workflow coordination specialist"
        safe_replace "$file" "coordination specialist" "coordination specialist"
        
        echo "  ✓ Updated orchestration terms in: $file"
    fi
done

echo
echo "3. UPDATING REMAINING REFERENCES"
echo "==============================="

# Find and process remaining files with orchestration references
find agents/ -name "*.md" -exec grep -l -i "orchestrat" {} \; | while read file; do
    echo "Processing remaining file: $file"
    safe_replace "$file" "orchestration" "coordination"
    safe_replace "$file" "orchestrator" "coordinator" 
    safe_replace "$file" "orchestrate" "coordinate"
    safe_replace "$file" "orchestrating" "coordinating"
    safe_replace "$file" "orchestrated" "coordinated"
    safe_replace "$file" "orchestrates" "coordinates"
done

echo
echo "4. FIXING KUBERNETES ORCHESTRATION SPECIALIST"
echo "============================================"

# The Kubernetes orchestration specialist should keep "orchestration" as it's a technical term
if [[ -f "agents/infrastructure/kubernetes-orchestration-specialist.md" ]]; then
    echo "Kubernetes orchestration specialist requires special handling..."
    # Restore orchestration for Kubernetes context only
    sed -i '' 's/kubernetes-coordination-specialist/kubernetes-orchestration-specialist/g' \
        "agents/infrastructure/kubernetes-orchestration-specialist.md"
    sed -i '' 's/Kubernetes.*coordination/Kubernetes orchestration/g' \
        "agents/infrastructure/kubernetes-orchestration-specialist.md"
    sed -i '' 's/container coordination specialist/container orchestration specialist/g' \
        "agents/infrastructure/kubernetes-orchestration-specialist.md"
    echo "  ✓ Preserved Kubernetes orchestration technical terminology"
fi

echo
echo "5. FINAL VERIFICATION"
echo "===================="

# Count remaining orchestration references
remaining_files=$(find agents/ -name "*.md" -exec grep -l -i "orchestrat" {} \; 2>/dev/null | wc -l)
echo "Files with remaining orchestration references: $remaining_files"

if [[ $remaining_files -gt 0 ]]; then
    echo "Files still containing orchestration references:"
    find agents/ -name "*.md" -exec grep -l -i "orchestrat" {} \; 2>/dev/null | head -5
    echo
    echo "Checking if these are legitimate technical terms..."
    find agents/ -name "*.md" -exec grep -n -i "orchestrat" {} /dev/null \; 2>/dev/null | head -10
fi

echo
echo "6. CLEANING UP BROKEN FILES"
echo "=========================="

# Fix any files with duplicate content
find agents/ -name "*.md" -exec grep -l "No newline at end of file" {} \; | while read file; do
    echo "Cleaning duplicate content in: $file"
    # Remove duplicate "No newline at end of file" lines
    sed -i '' '/No newline at end of file/d' "$file"
done

echo
echo "=== ORCHESTRATION REMOVAL FIX COMPLETE ==="
echo "Orchestration references have been systematically removed from agents."