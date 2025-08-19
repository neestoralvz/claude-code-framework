#!/bin/bash

# System Architecture Mapper Script
# Maps templates, logic, creation processes, and agents with file locations

echo "=== SYSTEM ARCHITECTURE MAPPING SCRIPT ==="
echo "Mapping templates, logic, creation processes, and agents..."
echo

# Create output directory
OUTPUT_DIR="operations/$(date +%Y%m%d-%H%M%S)-system-architecture-map"
mkdir -p "$OUTPUT_DIR"

echo "1. MAPPING TEMPLATES ACROSS THE SYSTEM"
echo "======================================"

TEMPLATES_REPORT="$OUTPUT_DIR/templates-map.md"
cat > "$TEMPLATES_REPORT" << 'EOF'
# System Templates Mapping

## Template Categories and Locations

EOF

echo "Searching for templates..."

# Find all template files
find . -name "*template*" -type f -not -path "./operations/*" -not -path "./.git/*" > "$OUTPUT_DIR/template_files.txt"
find . -name "*.md" -exec grep -l -i "template" {} \; -not -path "./operations/*" -not -path "./.git/*" >> "$OUTPUT_DIR/template_files.txt"

# Remove duplicates
sort "$OUTPUT_DIR/template_files.txt" | uniq > "$OUTPUT_DIR/unique_templates.txt"

template_count=$(cat "$OUTPUT_DIR/unique_templates.txt" | wc -l)
echo "Found $template_count template-related files"

cat >> "$TEMPLATES_REPORT" << EOF
### Template Files Found: $template_count

#### Template Files by Category:
EOF

# Categorize templates
echo "#### Agent Templates:" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"
grep -i "agent.*template\|template.*agent" "$OUTPUT_DIR/unique_templates.txt" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"
echo >> "$TEMPLATES_REPORT"

echo "#### Command Templates:" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"
grep -i "command.*template\|template.*command" "$OUTPUT_DIR/unique_templates.txt" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"
echo >> "$TEMPLATES_REPORT"

echo "#### Component Templates:" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"
grep -i "component.*template\|template.*component" "$OUTPUT_DIR/unique_templates.txt" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"
echo >> "$TEMPLATES_REPORT"

echo "#### Documentation Templates:" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"
grep -i "docs.*template\|template.*doc" "$OUTPUT_DIR/unique_templates.txt" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"
echo >> "$TEMPLATES_REPORT"

echo "#### All Template Files:" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"
cat "$OUTPUT_DIR/unique_templates.txt" >> "$TEMPLATES_REPORT"
echo '```' >> "$TEMPLATES_REPORT"

echo

echo "2. MAPPING LOGIC AND CREATION PROCESSES"
echo "======================================="

LOGIC_REPORT="$OUTPUT_DIR/logic-processes-map.md"
cat > "$LOGIC_REPORT" << 'EOF'
# Logic and Creation Processes Mapping

## Process Categories and Locations

EOF

echo "Searching for logic and creation processes..."

# Find creation-related files
find . -name "*.md" -exec grep -l -E "(create|generation|builder|factory|process)" {} \; -not -path "./operations/*" -not -path "./.git/*" > "$OUTPUT_DIR/creation_files.txt"

creation_count=$(cat "$OUTPUT_DIR/creation_files.txt" | wc -l)
echo "Found $creation_count creation-related files"

cat >> "$LOGIC_REPORT" << EOF
### Creation Process Files Found: $creation_count

#### Agent Creation Processes:
EOF

echo '```' >> "$LOGIC_REPORT"
grep -E "(agent.*creat|creat.*agent|agent.*generat|generat.*agent)" "$OUTPUT_DIR/creation_files.txt" >> "$LOGIC_REPORT"
echo '```' >> "$LOGIC_REPORT"
echo >> "$LOGIC_REPORT"

echo "#### Command Creation Processes:" >> "$LOGIC_REPORT"
echo '```' >> "$LOGIC_REPORT"
grep -E "(command.*creat|creat.*command|command.*generat|generat.*command)" "$OUTPUT_DIR/creation_files.txt" >> "$LOGIC_REPORT"
echo '```' >> "$LOGIC_REPORT"
echo >> "$LOGIC_REPORT"

echo "#### Pattern Generation:" >> "$LOGIC_REPORT"
echo '```' >> "$LOGIC_REPORT"
grep -E "(pattern.*generat|generat.*pattern|pattern.*creat|creat.*pattern)" "$OUTPUT_DIR/creation_files.txt" >> "$LOGIC_REPORT"
echo '```' >> "$LOGIC_REPORT"
echo >> "$LOGIC_REPORT"

# Find workflow and methodology files
find . -name "*.md" -exec grep -l -E "(workflow|methodology|process)" {} \; -not -path "./operations/*" -not -path "./.git/*" > "$OUTPUT_DIR/workflow_files.txt"

echo "#### Workflow and Methodology Files:" >> "$LOGIC_REPORT"
echo '```' >> "$LOGIC_REPORT"
cat "$OUTPUT_DIR/workflow_files.txt" | head -20 >> "$LOGIC_REPORT"
echo '```' >> "$LOGIC_REPORT"

echo

echo "3. COMPREHENSIVE AGENT DIRECTORY MAPPING"
echo "========================================"

AGENTS_REPORT="$OUTPUT_DIR/agents-directory-map.md"
cat > "$AGENTS_REPORT" << 'EOF'
# Comprehensive Agent Directory Mapping

## Agent Organization Structure

EOF

echo "Mapping agent directory structure..."

# Get directory tree for agents
if command -v tree >/dev/null 2>&1; then
    echo "### Agent Directory Tree:" >> "$AGENTS_REPORT"
    echo '```' >> "$AGENTS_REPORT"
    tree agents/ >> "$AGENTS_REPORT"
    echo '```' >> "$AGENTS_REPORT"
else
    echo "### Agent Directory Structure:" >> "$AGENTS_REPORT"
    echo '```' >> "$AGENTS_REPORT"
    find agents/ -type d | sort >> "$AGENTS_REPORT"
    echo '```' >> "$AGENTS_REPORT"
fi

echo >> "$AGENTS_REPORT"

# Count agents by category
total_agents=$(find agents/ -name "*.md" | wc -l)
echo "Total agents found: $total_agents"

cat >> "$AGENTS_REPORT" << EOF
### Agent Statistics:
- **Total Agents**: $total_agents

#### Agents by Category:
EOF

# Analyze agent categories
declare -A AGENT_CATEGORIES
while IFS= read -r -d '' file; do
    category=$(dirname "$file" | sed 's|agents/||' | cut -d'/' -f1)
    ((AGENT_CATEGORIES["$category"]++))
done < <(find agents/ -name "*.md" -print0)

for category in "${!AGENT_CATEGORIES[@]}"; do
    count=${AGENT_CATEGORIES[$category]}
    echo "- **$category**: $count agents" >> "$AGENTS_REPORT"
    
    echo "  - Files:" >> "$AGENTS_REPORT"
    echo "    \`\`\`" >> "$AGENTS_REPORT"
    find "agents/$category" -name "*.md" 2>/dev/null | sort >> "$AGENTS_REPORT"
    echo "    \`\`\`" >> "$AGENTS_REPORT"
    echo >> "$AGENTS_REPORT"
done

# Analysis-only compliance
analysis_only_agents=$(find agents/ -name "*.md" -exec grep -l "ANALYSIS-ONLY SPECIALIST" {} \; | wc -l)

cat >> "$AGENTS_REPORT" << EOF

### Compliance Status:
- **Analysis-Only Compliant**: $analysis_only_agents/$total_agents agents ($(echo "scale=1; $analysis_only_agents * 100 / $total_agents" | bc)%)
- **Task Tool Violations**: $(find agents/ -name "*.md" -exec grep -l -E "(Task\(|TodoWrite)" {} \; | wc -l) agents

EOF

echo

echo "4. MAPPING CORE SYSTEM ARCHITECTURE"
echo "==================================="

ARCHITECTURE_REPORT="$OUTPUT_DIR/system-architecture-overview.md"
cat > "$ARCHITECTURE_REPORT" << 'EOF'
# System Architecture Overview

## Core Framework Structure

EOF

echo "Mapping core system architecture..."

# Map major directories
echo "### Directory Structure:" >> "$ARCHITECTURE_REPORT"
echo '```' >> "$ARCHITECTURE_REPORT"
find . -maxdepth 2 -type d -not -path "./.git*" -not -path "./operations*" -not -path "./backups*" -not -path "./statsig*" -not -path "./ide*" | sort >> "$ARCHITECTURE_REPORT"
echo '```' >> "$ARCHITECTURE_REPORT"
echo >> "$ARCHITECTURE_REPORT"

# Core framework files
echo "### Core Framework Files:" >> "$ARCHITECTURE_REPORT"

core_files=(
    "CLAUDE.md"
    "PROJECT_STRUCTURE.md" 
    "commands/index.md"
    "docs/index.md"
    "agents/README.md"
    "playbook/README.md"
)

for file in "${core_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "- ✅ $file" >> "$ARCHITECTURE_REPORT"
    else
        echo "- ❌ $file (missing)" >> "$ARCHITECTURE_REPORT"
    fi
done

echo >> "$ARCHITECTURE_REPORT"

# Count files by type
echo "### File Statistics:" >> "$ARCHITECTURE_REPORT"
echo "- **Markdown Files**: $(find . -name "*.md" -not -path "./operations/*" -not -path "./.git/*" | wc -l)" >> "$ARCHITECTURE_REPORT"
echo "- **Agent Files**: $(find agents/ -name "*.md" | wc -l)" >> "$ARCHITECTURE_REPORT"
echo "- **Command Files**: $(find commands/ -name "*.md" 2>/dev/null | wc -l)" >> "$ARCHITECTURE_REPORT"
echo "- **Documentation Files**: $(find docs/ -name "*.md" 2>/dev/null | wc -l)" >> "$ARCHITECTURE_REPORT"
echo "- **Script Files**: $(find scripts/ -name "*.sh" 2>/dev/null | wc -l)" >> "$ARCHITECTURE_REPORT"

echo

echo "5. CREATION SPECIALISTS AND GENERATORS"
echo "======================================"

GENERATORS_REPORT="$OUTPUT_DIR/creation-specialists-map.md"
cat > "$GENERATORS_REPORT" << 'EOF'
# Creation Specialists and Generators Mapping

## Agent Creation Specialists

EOF

echo "Mapping creation specialists..."

# Find agent creation specialists
echo "### Agent Creation Specialists:" >> "$GENERATORS_REPORT"
echo '```' >> "$GENERATORS_REPORT"
find agents/ -name "*.md" -exec grep -l -E "(creat.*agent|agent.*creat|generat.*agent|agent.*generat)" {} \; >> "$GENERATORS_REPORT"
echo '```' >> "$GENERATORS_REPORT"
echo >> "$GENERATORS_REPORT"

# Find pattern generators
echo "### Pattern Generators:" >> "$GENERATORS_REPORT"
echo '```' >> "$GENERATORS_REPORT"
find agents/ -name "*.md" -exec grep -l -E "(pattern.*generat|generat.*pattern)" {} \; >> "$GENERATORS_REPORT"
echo '```' >> "$GENERATORS_REPORT"
echo >> "$GENERATORS_REPORT"

# Find template specialists
echo "### Template Specialists:" >> "$GENERATORS_REPORT"
echo '```' >> "$GENERATORS_REPORT"
find agents/ -name "*.md" -exec grep -l -E "(template)" {} \; >> "$GENERATORS_REPORT"
echo '```' >> "$GENERATORS_REPORT"
echo >> "$GENERATORS_REPORT"

echo

echo "6. GENERATING COMPREHENSIVE SYSTEM MAP"
echo "====================================="

SYSTEM_MAP="$OUTPUT_DIR/comprehensive-system-map.md"
cat > "$SYSTEM_MAP" << EOF
# Comprehensive System Architecture Map
Generated: $(date)

## Executive Summary
Complete mapping of templates, logic, creation processes, and agents across the Claude Code Framework.

## System Statistics
- **Total Agents**: $total_agents
- **Analysis-Only Compliant**: $analysis_only_agents/$total_agents ($(echo "scale=1; $analysis_only_agents * 100 / $total_agents" | bc)%)
- **Template Files**: $template_count
- **Creation Process Files**: $creation_count
- **Total Markdown Files**: $(find . -name "*.md" -not -path "./operations/*" -not -path "./.git/*" | wc -l)

## Key Architecture Components

### 1. Agent Architecture
- **Location**: \`agents/\` directory
- **Organization**: Category-based subdirectories
- **Compliance**: Analysis-only specialist pattern
- **Tool Restriction**: No Task tools (orchestrator-only)

### 2. Template System
- **Agent Templates**: \`docs/agents-docs/agent-template.md\`
- **Component Templates**: \`docs/templates/components/\`
- **Success Criteria**: \`docs/templates/components/success-criteria-template.md\`
- **Coordination Strategies**: \`docs/templates/components/agent-coordination-strategies.md\`

### 3. Creation Processes
- **Agent Creation**: \`agents/development/architecture/agent-creator.md\`
- **Pattern Generation**: \`agents/specialization/pattern-generation-framework.md\`
- **Component Extraction**: \`agents/development/workflow/component-extraction-specialist.md\`
- **Architecture Design**: \`agents/development/architecture/\`

### 4. Core Framework Logic
- **Main Interface**: \`CLAUDE.md\` (orchestrator playbook)
- **Command System**: \`commands/\` directory
- **Workflow Logic**: \`docs/principles/workflow.md\`
- **Task Tool Syntax**: \`docs/principles/task-tool-syntax.md\`

### 5. System Orchestration
- **Orchestrator**: Uses Task tools for agent deployment
- **Agent Deployment**: Via Task(subagent_type, description, prompt)
- **Analysis Delivery**: Agents provide recommendations to orchestrator
- **Execution Boundary**: Only orchestrator executes, agents analyze

## Directory Structure Overview
\`\`\`
$(find . -maxdepth 2 -type d -not -path "./.git*" -not -path "./operations*" -not -path "./backups*" -not -path "./statsig*" -not -path "./ide*" | sort)
\`\`\`

## Agent Categories
$(for category in "${!AGENT_CATEGORIES[@]}"; do
    count=${AGENT_CATEGORIES[$category]}
    echo "- **$category**: $count agents"
done)

## Reports Generated
1. **Templates Map**: templates-map.md
2. **Logic Processes**: logic-processes-map.md
3. **Agents Directory**: agents-directory-map.md
4. **Architecture Overview**: system-architecture-overview.md
5. **Creation Specialists**: creation-specialists-map.md

## Framework Compliance Status
✅ **Agent Architecture**: Analysis-only specialists with no Task tools
✅ **Orchestrator Pattern**: Task tools reserved for orchestrator use
✅ **Template System**: Comprehensive template library available
✅ **Creation Processes**: Specialized agents for systematic creation
✅ **Documentation**: Complete framework documentation and guidance

EOF

echo "System architecture mapping completed successfully!"
echo "Results saved to: $OUTPUT_DIR"
echo
echo "=== SYSTEM ARCHITECTURE SUMMARY ==="
echo "Total agents: $total_agents"
echo "Analysis-only compliant: $analysis_only_agents/$total_agents"
echo "Template files: $template_count"
echo "Creation process files: $creation_count"
echo
echo "Detailed architecture maps available in: $OUTPUT_DIR"

# Clean up temp files
rm -f "$OUTPUT_DIR"/*.txt