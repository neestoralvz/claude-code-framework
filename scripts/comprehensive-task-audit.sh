#!/bin/bash

# Comprehensive Task Tool Audit Script
# Searches for all Task tool references across the entire system

echo "=== COMPREHENSIVE TASK TOOL AUDIT SCRIPT ==="
echo "Searching for Task tool references across entire system..."
echo

# Create output directory
OUTPUT_DIR="operations/$(date +%Y%m%d-%H%M%S)-task-audit"
mkdir -p "$OUTPUT_DIR"

# Task tool patterns to search for
declare -a TASK_PATTERNS=(
    "Task("
    "Task tool"
    "Task,"
    "TodoWrite"
    "subagent_type"
    "Task Framework"
    "Task Tool Framework"
    "TASK TOOL"
    "task tool"
    "orchestrator.*Task"
    "agent.*Task"
)

echo "1. COMPREHENSIVE TASK TOOL SEARCH"
echo "================================="

TASK_AUDIT_REPORT="$OUTPUT_DIR/task-tool-audit.md"
cat > "$TASK_AUDIT_REPORT" << 'EOF'
# Comprehensive Task Tool Audit Report

## Summary
Complete audit of Task tool references across the entire Claude Code Framework.

## Task Tool References Found

EOF

total_task_files=0
for pattern in "${TASK_PATTERNS[@]}"; do
    echo "Searching for pattern: $pattern"
    
    # Search across ALL files, not just .md
    find . -type f \( -name "*.md" -o -name "*.sh" -o -name "*.json" -o -name "*.txt" -o -name "*.yml" -o -name "*.yaml" \) \
    -not -path "./operations/*" -not -path "./.git/*" -not -path "./statsig/*" -not -path "./ide/*" | \
    xargs grep -l "$pattern" > "$OUTPUT_DIR/temp_${pattern//[^a-zA-Z0-9]/}_files.txt" 2>/dev/null
    
    file_count=$(cat "$OUTPUT_DIR/temp_${pattern//[^a-zA-Z0-9]/}_files.txt" 2>/dev/null | wc -l)
    if [[ $file_count -gt 0 ]]; then
        echo "### Pattern: '$pattern' ($file_count files)" >> "$TASK_AUDIT_REPORT"
        echo '```' >> "$TASK_AUDIT_REPORT"
        cat "$OUTPUT_DIR/temp_${pattern//[^a-zA-Z0-9]/}_files.txt" >> "$TASK_AUDIT_REPORT"
        echo '```' >> "$TASK_AUDIT_REPORT"
        echo >> "$TASK_AUDIT_REPORT"
        
        total_task_files=$((total_task_files + file_count))
        echo "  Found in $file_count files"
    else
        echo "  No files found"
    fi
    rm -f "$OUTPUT_DIR/temp_${pattern//[^a-zA-Z0-9]/}_files.txt"
done

echo "  Total Task tool pattern matches: $total_task_files"
echo

echo "2. DIRECTORY-SPECIFIC TASK ANALYSIS"
echo "==================================="

DIRECTORY_ANALYSIS="$OUTPUT_DIR/directory-task-analysis.md"
cat > "$DIRECTORY_ANALYSIS" << 'EOF'
# Directory-Specific Task Tool Analysis

## Analysis by Directory

EOF

# Analyze each major directory
declare -a DIRECTORIES=(
    "agents"
    "commands" 
    "docs"
    "playbook"
    "scripts"
    "planning"
)

for dir in "${DIRECTORIES[@]}"; do
    if [[ -d "$dir" ]]; then
        echo "Analyzing $dir/ directory..."
        
        total_files=$(find "$dir" -name "*.md" | wc -l)
        task_files=$(find "$dir" -name "*.md" -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | wc -l)
        
        cat >> "$DIRECTORY_ANALYSIS" << EOF
### $dir/ Directory
- Total files: $total_files
- Files with Task references: $task_files
EOF
        
        if [[ $task_files -gt 0 ]]; then
            echo "#### Files with Task references:" >> "$DIRECTORY_ANALYSIS"
            echo '```' >> "$DIRECTORY_ANALYSIS"
            find "$dir" -name "*.md" -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null >> "$DIRECTORY_ANALYSIS"
            echo '```' >> "$DIRECTORY_ANALYSIS"
        fi
        echo >> "$DIRECTORY_ANALYSIS"
        
        echo "  $dir/: $task_files/$total_files files with Task references"
    fi
done

echo

echo "3. SPECIFIC FILE TYPE ANALYSIS"
echo "=============================="

FILE_TYPE_ANALYSIS="$OUTPUT_DIR/file-type-analysis.md"
cat > "$FILE_TYPE_ANALYSIS" << 'EOF'
# File Type Task Tool Analysis

## Task References by File Type

EOF

# Analyze by file extension
declare -a EXTENSIONS=(
    "md"
    "sh" 
    "json"
    "txt"
    "yml"
    "yaml"
)

for ext in "${EXTENSIONS[@]}"; do
    echo "Analyzing .$ext files..."
    
    total_files=$(find . -name "*.$ext" -not -path "./operations/*" -not -path "./.git/*" | wc -l)
    task_files=$(find . -name "*.$ext" -not -path "./operations/*" -not -path "./.git/*" \
                 -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | wc -l)
    
    cat >> "$FILE_TYPE_ANALYSIS" << EOF
### .$ext Files
- Total files: $total_files
- Files with Task references: $task_files

EOF
    
    if [[ $task_files -gt 0 ]]; then
        echo "#### Files with Task references:" >> "$FILE_TYPE_ANALYSIS"
        echo '```' >> "$FILE_TYPE_ANALYSIS"
        find . -name "*.$ext" -not -path "./operations/*" -not -path "./.git/*" \
             -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null >> "$FILE_TYPE_ANALYSIS"
        echo '```' >> "$FILE_TYPE_ANALYSIS"
        echo >> "$FILE_TYPE_ANALYSIS"
    fi
    
    echo "  .$ext files: $task_files/$total_files with Task references"
done

echo

echo "4. CONTEXT ANALYSIS OF TASK REFERENCES"
echo "======================================"

CONTEXT_ANALYSIS="$OUTPUT_DIR/task-context-analysis.md"
cat > "$CONTEXT_ANALYSIS" << 'EOF'
# Task Reference Context Analysis

## Context Patterns

EOF

echo "Analyzing context of Task tool usage..."

# Find files with Task references and analyze their context
find . -type f -name "*.md" -not -path "./operations/*" -not -path "./.git/*" \
     -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; > "$OUTPUT_DIR/task_ref_files.txt" 2>/dev/null

if [[ -s "$OUTPUT_DIR/task_ref_files.txt" ]]; then
    echo "### Files with Task Tool References and Context:" >> "$CONTEXT_ANALYSIS"
    echo >> "$CONTEXT_ANALYSIS"
    
    while read -r file; do
        echo "#### $file" >> "$CONTEXT_ANALYSIS"
        echo '```' >> "$CONTEXT_ANALYSIS"
        grep -n -A2 -B2 -E "(Task\(|TodoWrite|subagent_type)" "$file" >> "$CONTEXT_ANALYSIS" 2>/dev/null
        echo '```' >> "$CONTEXT_ANALYSIS"
        echo >> "$CONTEXT_ANALYSIS"
    done < "$OUTPUT_DIR/task_ref_files.txt"
fi

rm -f "$OUTPUT_DIR/task_ref_files.txt"

echo

echo "5. IDENTIFICATION OF NON-AGENT TASK TOOL USAGE"
echo "=============================================="

NON_AGENT_ANALYSIS="$OUTPUT_DIR/non-agent-task-analysis.md"
cat > "$NON_AGENT_ANALYSIS" << 'EOF'
# Non-Agent Task Tool Usage Analysis

## Legitimate Task Tool Usage Outside Agents

EOF

echo "Identifying legitimate Task tool usage outside agents directory..."

# Find Task tool references outside agents directory
non_agent_task_files=$(find . -type f -name "*.md" -not -path "./agents/*" -not -path "./operations/*" -not -path "./.git/*" \
                       -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | wc -l)

echo "Non-agent files with Task references: $non_agent_task_files"

if [[ $non_agent_task_files -gt 0 ]]; then
    echo "### Non-Agent Files with Task References:" >> "$NON_AGENT_ANALYSIS"
    echo '```' >> "$NON_AGENT_ANALYSIS"
    find . -type f -name "*.md" -not -path "./agents/*" -not -path "./operations/*" -not -path "./.git/*" \
         -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null >> "$NON_AGENT_ANALYSIS"
    echo '```' >> "$NON_AGENT_ANALYSIS"
    echo >> "$NON_AGENT_ANALYSIS"
    
    echo "### Context Analysis for Non-Agent Task Usage:" >> "$NON_AGENT_ANALYSIS"
    echo >> "$NON_AGENT_ANALYSIS"
    
    find . -type f -name "*.md" -not -path "./agents/*" -not -path "./operations/*" -not -path "./.git/*" \
         -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | \
    while read -r file; do
        echo "#### $file" >> "$NON_AGENT_ANALYSIS"
        echo '```' >> "$NON_AGENT_ANALYSIS"
        grep -n -A3 -B3 -E "(Task\(|TodoWrite|subagent_type)" "$file" 2>/dev/null >> "$NON_AGENT_ANALYSIS"
        echo '```' >> "$NON_AGENT_ANALYSIS"
        echo >> "$NON_AGENT_ANALYSIS"
    done
fi

echo

echo "6. GENERATING COMPREHENSIVE AUDIT SUMMARY"
echo "========================================="

AUDIT_SUMMARY="$OUTPUT_DIR/task-audit-summary.md"
cat > "$AUDIT_SUMMARY" << EOF
# Comprehensive Task Tool Audit Summary
Generated: $(date)

## Executive Summary
Complete audit of Task tool references across entire Claude Code Framework.

## Audit Statistics
- **Total Task Tool Pattern Matches**: $total_task_files
- **Non-Agent Task References**: $non_agent_task_files
- **Agent Task References**: $(find agents/ -name "*.md" -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | wc -l)

## Framework Task Tool Distribution
### Agents Directory
- Should have: NO Task tool references (analysis-only specialists)
- Currently has: $(find agents/ -name "*.md" -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | wc -l) files with Task references

### Non-Agent Locations  
- Should have: Legitimate Task tool usage for orchestration
- Currently has: $non_agent_task_files files with Task references

## Compliance Assessment
$(if [[ $(find agents/ -name "*.md" -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | wc -l) -eq 0 ]]; then echo "✅ AGENTS COMPLIANT: No Task tools found in agents directory"; else echo "⚠️  AGENTS NON-COMPLIANT: Task tools found in agents directory"; fi)
$(if [[ $non_agent_task_files -gt 0 ]]; then echo "✅ NON-AGENT USAGE FOUND: $non_agent_task_files files contain legitimate Task tool usage"; else echo "⚠️  NO NON-AGENT USAGE: No Task tools found outside agents - may need restoration"; fi)

## Key Findings
1. **Agent Directory Status**: $(find agents/ -name "*.md" -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | wc -l) agents contain Task tool references
2. **Framework Documentation Status**: Task tools in framework documentation need verification
3. **Orchestrator Usage Status**: Orchestrator Task tool usage needs validation
4. **Command Documentation Status**: Task tool references in commands need assessment

## Detailed Reports Generated
1. **Task Tool Audit**: task-tool-audit.md
2. **Directory Analysis**: directory-task-analysis.md  
3. **File Type Analysis**: file-type-analysis.md
4. **Context Analysis**: task-context-analysis.md
5. **Non-Agent Analysis**: non-agent-task-analysis.md

## Recommendations
$(if [[ $(find agents/ -name "*.md" -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | wc -l) -gt 0 ]]; then echo "1. **Remove Task Tools from Agents**: Complete removal required for analysis-only compliance"; fi)
$(if [[ $non_agent_task_files -gt 0 ]]; then echo "2. **Validate Non-Agent Usage**: Verify legitimate orchestration usage"; else echo "2. **Restore Non-Agent Usage**: Task tools may need restoration in orchestration documentation"; fi)
3. **Update Framework Documentation**: Ensure Task tool guidance reflects proper usage patterns
4. **Validate Orchestrator Integration**: Confirm Task tool availability for orchestrators

EOF

echo "Audit completed successfully!"
echo "Results saved to: $OUTPUT_DIR"
echo
echo "=== TASK TOOL AUDIT SUMMARY ==="
echo "Total Task pattern matches: $total_task_files"
echo "Non-agent Task references: $non_agent_task_files" 
echo "Agent Task references: $(find agents/ -name "*.md" -exec grep -l -E "(Task\(|TodoWrite|subagent_type)" {} \; 2>/dev/null | wc -l)"
echo
echo "Detailed audit reports available in: $OUTPUT_DIR"