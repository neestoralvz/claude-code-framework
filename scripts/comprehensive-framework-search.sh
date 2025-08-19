#!/bin/bash

# Comprehensive Framework Search Script
# Searches for orchestration, deployment, and coordination references across entire framework

echo "=== COMPREHENSIVE FRAMEWORK SEARCH SCRIPT ==="
echo "Searching for orchestration, deployment, and coordination patterns..."
echo

# Create output directory
OUTPUT_DIR="operations/$(date +%Y%m%d-%H%M%S)-comprehensive-search"
mkdir -p "$OUTPUT_DIR"

# Search terms for different categories
declare -a ORCHESTRATION_TERMS=(
    "orchestrator"
    "orquestrador"
    "orchestrat"
    "orchestr"
)

declare -a DEPLOYMENT_TERMS=(
    "deploy"
    "implement"
    "execute.*system"
    "manage.*system"
    "create.*system"
    "establish.*system"
    "setup.*system"
    "install.*system"
)

declare -a COORDINATION_TERMS=(
    "coordinat"
    "coordinador"
    "coordinate"
    "coordination"
    "coordinating"
)

declare -a TASK_TOOL_TERMS=(
    "Task("
    "TodoWrite"
    "subagent_type"
    "Task tool"
    "Task,"
)

echo "1. SEARCHING FOR ORCHESTRATION REFERENCES"
echo "========================================"

ORCHESTRATION_REPORT="$OUTPUT_DIR/orchestration-references.md"
cat > "$ORCHESTRATION_REPORT" << 'EOF'
# Orchestration References Search Results

## Summary
Search executed for orchestration-related terms across the entire framework.

## Orchestration Terms Found

EOF

total_orchestration_files=0
for term in "${ORCHESTRATION_TERMS[@]}"; do
    echo "Searching for: $term"
    
    # Search in all directories
    find . -name "*.md" -not -path "./operations/*" -not -path "./.git/*" | \
    xargs grep -l -i "$term" > "$OUTPUT_DIR/temp_${term}_files.txt" 2>/dev/null
    
    file_count=$(cat "$OUTPUT_DIR/temp_${term}_files.txt" 2>/dev/null | wc -l)
    if [[ $file_count -gt 0 ]]; then
        echo "### Term: '$term' ($file_count files)" >> "$ORCHESTRATION_REPORT"
        echo '```' >> "$ORCHESTRATION_REPORT"
        cat "$OUTPUT_DIR/temp_${term}_files.txt" >> "$ORCHESTRATION_REPORT"
        echo '```' >> "$ORCHESTRATION_REPORT"
        echo >> "$ORCHESTRATION_REPORT"
        
        total_orchestration_files=$((total_orchestration_files + file_count))
        echo "  Found in $file_count files"
    else
        echo "  No files found"
    fi
    rm -f "$OUTPUT_DIR/temp_${term}_files.txt"
done

echo "  Total orchestration references: $total_orchestration_files"
echo

echo "2. SEARCHING FOR DEPLOYMENT CAPABILITIES"
echo "======================================="

DEPLOYMENT_REPORT="$OUTPUT_DIR/deployment-capabilities.md"
cat > "$DEPLOYMENT_REPORT" << 'EOF'
# Deployment Capabilities Search Results

## Summary
Search executed for deployment-related terms that might indicate execution capabilities.

## Deployment Terms Found

EOF

total_deployment_files=0
for term in "${DEPLOYMENT_TERMS[@]}"; do
    echo "Searching for: $term"
    
    find . -name "*.md" -not -path "./operations/*" -not -path "./.git/*" | \
    xargs grep -l -E "$term" > "$OUTPUT_DIR/temp_${term//[^a-zA-Z]/}_files.txt" 2>/dev/null
    
    file_count=$(cat "$OUTPUT_DIR/temp_${term//[^a-zA-Z]/}_files.txt" 2>/dev/null | wc -l)
    if [[ $file_count -gt 0 ]]; then
        echo "### Term: '$term' ($file_count files)" >> "$DEPLOYMENT_REPORT"
        echo '```' >> "$DEPLOYMENT_REPORT"
        cat "$OUTPUT_DIR/temp_${term//[^a-zA-Z]/}_files.txt" >> "$DEPLOYMENT_REPORT"
        echo '```' >> "$DEPLOYMENT_REPORT"
        echo >> "$DEPLOYMENT_REPORT"
        
        total_deployment_files=$((total_deployment_files + file_count))
        echo "  Found in $file_count files"
    else
        echo "  No files found"
    fi
    rm -f "$OUTPUT_DIR/temp_${term//[^a-zA-Z]/}_files.txt"
done

echo "  Total deployment references: $total_deployment_files"
echo

echo "3. SEARCHING FOR COORDINATION PATTERNS"
echo "====================================="

COORDINATION_REPORT="$OUTPUT_DIR/coordination-patterns.md"
cat > "$COORDINATION_REPORT" << 'EOF'
# Coordination Patterns Search Results

## Summary
Search executed for coordination-related terms to verify analysis-only compliance.

## Coordination Terms Found

EOF

total_coordination_files=0
for term in "${COORDINATION_TERMS[@]}"; do
    echo "Searching for: $term"
    
    find . -name "*.md" -not -path "./operations/*" -not -path "./.git/*" | \
    xargs grep -l -i "$term" > "$OUTPUT_DIR/temp_${term}_files.txt" 2>/dev/null
    
    file_count=$(cat "$OUTPUT_DIR/temp_${term}_files.txt" 2>/dev/null | wc -l)
    if [[ $file_count -gt 0 ]]; then
        echo "### Term: '$term' ($file_count files)" >> "$COORDINATION_REPORT"
        echo '```' >> "$COORDINATION_REPORT"
        cat "$OUTPUT_DIR/temp_${term}_files.txt" >> "$COORDINATION_REPORT"
        echo '```' >> "$COORDINATION_REPORT"
        echo >> "$COORDINATION_REPORT"
        
        total_coordination_files=$((total_coordination_files + file_count))
        echo "  Found in $file_count files"
    else
        echo "  No files found"
    fi
    rm -f "$OUTPUT_DIR/temp_${term}_files.txt"
done

echo "  Total coordination references: $total_coordination_files"
echo

echo "4. SEARCHING FOR TASK TOOL REFERENCES"
echo "===================================="

TASK_TOOLS_REPORT="$OUTPUT_DIR/task-tools-references.md"
cat > "$TASK_TOOLS_REPORT" << 'EOF'
# Task Tools References Search Results

## Summary
Search executed for Task tool usage that should be orchestrator-only.

## Task Tool Terms Found

EOF

total_task_tool_files=0
for term in "${TASK_TOOL_TERMS[@]}"; do
    echo "Searching for: $term"
    
    find . -name "*.md" -not -path "./operations/*" -not -path "./.git/*" | \
    xargs grep -l "$term" > "$OUTPUT_DIR/temp_task_${RANDOM}_files.txt" 2>/dev/null
    
    file_count=$(cat "$OUTPUT_DIR/temp_task_${RANDOM}_files.txt" 2>/dev/null | wc -l || echo 0)
    if [[ $file_count -gt 0 ]]; then
        echo "### Term: '$term' ($file_count files)" >> "$TASK_TOOLS_REPORT"
        echo '```' >> "$TASK_TOOLS_REPORT"
        find . -name "*.md" -not -path "./operations/*" -not -path "./.git/*" | \
        xargs grep -l "$term" >> "$TASK_TOOLS_REPORT" 2>/dev/null
        echo '```' >> "$TASK_TOOLS_REPORT"
        echo >> "$TASK_TOOLS_REPORT"
        
        total_task_tool_files=$((total_task_tool_files + file_count))
        echo "  Found in $file_count files"
    else
        echo "  No files found"
    fi
done

echo "  Total task tool references: $total_task_tool_files"
echo

echo "5. DIRECTORY-SPECIFIC ANALYSIS"
echo "=============================="

DIRECTORY_REPORT="$OUTPUT_DIR/directory-analysis.md"
cat > "$DIRECTORY_REPORT" << 'EOF'
# Directory-Specific Analysis

## Agents Directory Analysis
EOF

echo "Analyzing agents/ directory..."
agents_total=$(find agents/ -name "*.md" | wc -l)
agents_with_analysis_only=$(find agents/ -name "*.md" -exec grep -l "ANALYSIS-ONLY SPECIALIST" {} \; | wc -l)
agents_with_task_tools=$(find agents/ -name "*.md" -exec grep -l "Task" {} \; | wc -l)

cat >> "$DIRECTORY_REPORT" << EOF
- Total agent files: $agents_total
- Agents with ANALYSIS-ONLY clarification: $agents_with_analysis_only
- Agents with Task tool references: $agents_with_task_tools
- Analysis-only compliance: $(echo "scale=1; $agents_with_analysis_only * 100 / $agents_total" | bc)%

## Commands Directory Analysis
EOF

echo "Analyzing commands/ directory..."
commands_total=$(find commands/ -name "*.md" 2>/dev/null | wc -l)
commands_with_orchestration=$(find commands/ -name "*.md" -exec grep -l -i "orchestrat" {} \; 2>/dev/null | wc -l)

cat >> "$DIRECTORY_REPORT" << EOF
- Total command files: $commands_total
- Commands with orchestration references: $commands_with_orchestration

## Documentation Analysis
EOF

echo "Analyzing docs/ directory..."
docs_total=$(find docs/ -name "*.md" 2>/dev/null | wc -l)
docs_with_orchestration=$(find docs/ -name "*.md" -exec grep -l -i "orchestrat" {} \; 2>/dev/null | wc -l)

cat >> "$DIRECTORY_REPORT" << EOF
- Total documentation files: $docs_total
- Documentation with orchestration references: $docs_with_orchestration

## Framework Root Analysis
EOF

echo "Analyzing framework root files..."
root_files=$(find . -maxdepth 1 -name "*.md" | wc -l)
root_with_orchestration=$(find . -maxdepth 1 -name "*.md" -exec grep -l -i "orchestrat" {} \; 2>/dev/null | wc -l)

cat >> "$DIRECTORY_REPORT" << EOF
- Total root documentation files: $root_files
- Root files with orchestration references: $root_with_orchestration
EOF

echo "6. GENERATING COMPREHENSIVE SUMMARY"
echo "=================================="

SUMMARY_REPORT="$OUTPUT_DIR/comprehensive-search-summary.md"
cat > "$SUMMARY_REPORT" << EOF
# Comprehensive Framework Search Summary
Generated: $(date)

## Executive Summary
Complete search executed across entire Claude Code Framework for orchestration, deployment, coordination, and task tool references.

## Search Statistics
- **Orchestration References**: $total_orchestration_files files
- **Deployment Capabilities**: $total_deployment_files files  
- **Coordination Patterns**: $total_coordination_files files
- **Task Tool References**: $total_task_tool_files files

## Framework Compliance Status
- **Total Agent Files**: $agents_total
- **Analysis-Only Compliant**: $agents_with_analysis_only ($((agents_with_analysis_only * 100 / agents_total))%)
- **Task Tool Violations**: $agents_with_task_tools
- **Commands Files**: $commands_total
- **Documentation Files**: $docs_total

## Key Findings
$(if [[ $agents_with_task_tools -eq 0 ]]; then echo "✅ NO TASK TOOL VIOLATIONS: All agents are Task tool compliant"; else echo "⚠️  TASK TOOL VIOLATIONS: $agents_with_task_tools agents still contain Task tools"; fi)
$(if [[ $agents_with_analysis_only -gt $((agents_total * 7 / 10)) ]]; then echo "✅ HIGH ANALYSIS-ONLY COMPLIANCE: $agents_with_analysis_only/$agents_total agents have explicit analysis-only clarifications"; else echo "⚠️  LOW ANALYSIS-ONLY COMPLIANCE: Only $agents_with_analysis_only/$agents_total agents have analysis-only clarifications"; fi)

## Detailed Reports Generated
1. **Orchestration References**: orchestration-references.md
2. **Deployment Capabilities**: deployment-capabilities.md  
3. **Coordination Patterns**: coordination-patterns.md
4. **Task Tools References**: task-tools-references.md
5. **Directory Analysis**: directory-analysis.md

## Search Methodology
- **Scope**: Entire framework excluding operations/ and .git/ directories
- **File Types**: All .md files
- **Search Patterns**: Case-insensitive regex patterns for comprehensive coverage
- **Categorization**: Systematic classification by violation type

## Recommendations
$(if [[ $total_task_tool_files -gt 0 ]]; then echo "1. **Remove Task Tool References**: $total_task_tool_files files require Task tool removal"; fi)
$(if [[ $((agents_total - agents_with_analysis_only)) -gt 0 ]]; then echo "2. **Add Analysis-Only Clarifications**: $((agents_total - agents_with_analysis_only)) agents need explicit analysis-only statements"; fi)
$(if [[ $total_deployment_files -gt 10 ]]; then echo "3. **Review Deployment Terms**: $total_deployment_files files contain deployment-related terms requiring verification"; fi)
$(if [[ $total_orchestration_files -gt 0 ]]; then echo "4. **Validate Orchestration References**: $total_orchestration_files files contain orchestration terms requiring analysis"; fi)

EOF

echo "Search completed successfully!"
echo "Results saved to: $OUTPUT_DIR"
echo
echo "=== SEARCH SUMMARY ==="
echo "Orchestration references: $total_orchestration_files files"
echo "Deployment capabilities: $total_deployment_files files"
echo "Coordination patterns: $total_coordination_files files"
echo "Task tool references: $total_task_tool_files files"
echo "Analysis-only compliance: $agents_with_analysis_only/$agents_total agents"
echo
echo "Detailed reports available in: $OUTPUT_DIR"