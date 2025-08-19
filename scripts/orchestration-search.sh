#!/bin/bash

# Comprehensive Orchestration Capability Search Script
# Searches for agent orchestration assignments across entire project

echo "=== COMPREHENSIVE ORCHESTRATION CAPABILITY SEARCH ==="
echo "Searching for agents assigned orchestration capabilities..."
echo

# Create results directory
mkdir -p operations/orchestration-search-results
RESULTS_DIR="operations/orchestration-search-results"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Define search terms
ORCHESTRATION_TERMS=(
    "orchestrat" 
    "coordinat"
    "manag"
    "control"
    "meta-orchestrat"
    "workflow.*coordinat"
    "system.*coordinat"
    "agent.*coordinat"
    "multi.*agent.*coordinat"
    "execution.*coordinat"
    "deployment.*coordinat"
    "workflow.*orchestrat"
    "system.*orchestrat"
    "task.*orchestrat"
    "project.*orchestrat"
    "execution.*orchestrat"
)

# Define file patterns to search
FILE_PATTERNS=(
    "*.md"
    "*.json"
    "*.yaml"
    "*.yml"
    "*.sh"
    "*.js"
    "*.ts"
)

echo "1. ORCHESTRATION TERMS SEARCH"
echo "==============================="

# Search for orchestration terms in all files
for term in "${ORCHESTRATION_TERMS[@]}"; do
    echo "Searching for: $term"
    find . -type f \( -name "*.md" -o -name "*.json" -o -name "*.yaml" -o -name "*.yml" \) \
        -exec grep -l -i "$term" {} \; 2>/dev/null | \
        grep -v ".git" | \
        sort | uniq >> "$RESULTS_DIR/files-with-orchestration-$TIMESTAMP.txt"
done

echo
echo "2. AGENT FILES WITH ORCHESTRATION CAPABILITIES"
echo "=============================================="

# Specifically search agent files
find agents/ -name "*.md" -exec grep -l -i -E "(orchestrat|coordinat|manag.*agent|control.*agent|workflow.*manag|system.*manag)" {} \; 2>/dev/null | \
    sort | uniq > "$RESULTS_DIR/agent-orchestration-files-$TIMESTAMP.txt"

echo "Agent files with orchestration capabilities:"
cat "$RESULTS_DIR/agent-orchestration-files-$TIMESTAMP.txt"

echo
echo "3. DETAILED CONTENT SEARCH"
echo "=========================="

# Create detailed content search
echo "# ORCHESTRATION CAPABILITY DETAILED SEARCH RESULTS" > "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"
echo "Generated: $(date)" >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"
echo >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"

# Search for specific problematic patterns
echo "## Agent Orchestration Assignments" >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"
echo "### Files containing agent orchestration references:" >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"

find . -type f -name "*.md" -exec grep -n -i -E "(agent.*orchestrat|orchestrat.*agent|agent.*coordinat|coordinat.*agent)" {} /dev/null \; 2>/dev/null | \
    grep -v ".git" >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"

echo >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"
echo "## Workflow Coordination References" >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"

find . -type f -name "*.md" -exec grep -n -i -E "(workflow.*coordinat|workflow.*orchestrat|workflow.*manag)" {} /dev/null \; 2>/dev/null | \
    grep -v ".git" >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"

echo >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"
echo "## System Management References" >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"

find . -type f -name "*.md" -exec grep -n -i -E "(system.*manag|system.*coordinat|system.*orchestrat)" {} /dev/null \; 2>/dev/null | \
    grep -v ".git" >> "$RESULTS_DIR/detailed-content-$TIMESTAMP.md"

echo
echo "4. AGENT-SPECIFIC ANALYSIS"
echo "========================="

# Analyze specific agent files for orchestration capabilities
echo "# AGENT ORCHESTRATION CAPABILITY ANALYSIS" > "$RESULTS_DIR/agent-analysis-$TIMESTAMP.md"
echo "Generated: $(date)" >> "$RESULTS_DIR/agent-analysis-$TIMESTAMP.md"
echo >> "$RESULTS_DIR/agent-analysis-$TIMESTAMP.md"

for agent_file in $(find agents/ -name "*.md" 2>/dev/null); do
    if grep -q -i -E "(orchestrat|coordinat|workflow.*manag|system.*manag|multi.*agent)" "$agent_file" 2>/dev/null; then
        echo "## $agent_file" >> "$RESULTS_DIR/agent-analysis-$TIMESTAMP.md"
        echo "### Orchestration references found:" >> "$RESULTS_DIR/agent-analysis-$TIMESTAMP.md"
        grep -n -i -E "(orchestrat|coordinat|workflow.*manag|system.*manag|multi.*agent)" "$agent_file" 2>/dev/null >> "$RESULTS_DIR/agent-analysis-$TIMESTAMP.md"
        echo >> "$RESULTS_DIR/agent-analysis-$TIMESTAMP.md"
    fi
done

echo
echo "5. COMMAND FILES ANALYSIS"
echo "========================="

# Search command files for agent orchestration assignments
find commands/ -name "*.md" -exec grep -l -i -E "(agent.*orchestrat|orchestrat.*agent|agent.*coordinat)" {} \; 2>/dev/null | \
    sort | uniq > "$RESULTS_DIR/command-orchestration-files-$TIMESTAMP.txt"

echo "Command files with agent orchestration references:"
cat "$RESULTS_DIR/command-orchestration-files-$TIMESTAMP.txt"

echo
echo "6. DOCUMENTATION ANALYSIS"
echo "========================="

# Search documentation for orchestration patterns
find docs/ -name "*.md" -exec grep -l -i -E "(agent.*orchestrat|orchestrat.*agent|agent.*coordinat|agent.*manag)" {} \; 2>/dev/null | \
    sort | uniq > "$RESULTS_DIR/docs-orchestration-files-$TIMESTAMP.txt"

echo "Documentation files with agent orchestration references:"
cat "$RESULTS_DIR/docs-orchestration-files-$TIMESTAMP.txt"

echo
echo "=== SEARCH COMPLETE ==="
echo "Results saved in: $RESULTS_DIR/"
echo "Files generated:"
ls -la "$RESULTS_DIR/"*$TIMESTAMP*

echo
echo "=== SUMMARY STATISTICS ==="
echo "Total unique files with orchestration terms: $(cat "$RESULTS_DIR/files-with-orchestration-$TIMESTAMP.txt" 2>/dev/null | sort | uniq | wc -l)"
echo "Agent files with orchestration capabilities: $(cat "$RESULTS_DIR/agent-orchestration-files-$TIMESTAMP.txt" 2>/dev/null | wc -l)"
echo "Command files with agent orchestration: $(cat "$RESULTS_DIR/command-orchestration-files-$TIMESTAMP.txt" 2>/dev/null | wc -l)"
echo "Documentation files with agent orchestration: $(cat "$RESULTS_DIR/docs-orchestration-files-$TIMESTAMP.txt" 2>/dev/null | wc -l)"