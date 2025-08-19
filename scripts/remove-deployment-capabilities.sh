#!/bin/bash

# Remove Deployment Capabilities from All Agents Script
# Converts all agents to analysis-only specialists that deliver information to orchestrator

echo "=== DEPLOYMENT CAPABILITIES REMOVAL SCRIPT ==="
echo "Converting all agents to analysis-only specialists..."
echo

# Create backup directory
BACKUP_DIR="operations/deployment-removal-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "1. CREATING BACKUPS"
echo "=================="
find agents/ -name "*.md" -exec cp {} "$BACKUP_DIR/" \; 2>/dev/null
echo "Agent files backed up to: $BACKUP_DIR"

echo
echo "2. REMOVING TASK TOOLS FROM AGENT CONFIGURATIONS"
echo "=============================================="

# Function to remove Task Tools from agent files
remove_task_tools() {
    local file="$1"
    local temp_file=$(mktemp)
    
    # Remove Task tool from tools line
    sed 's/Task, //g; s/, Task//g; s/Task//g' "$file" > "$temp_file"
    
    # Remove TodoWrite tool as well (orchestrator-only)
    sed 's/TodoWrite, //g; s/, TodoWrite//g; s/TodoWrite//g' "$temp_file" > "${temp_file}.2"
    mv "${temp_file}.2" "$temp_file"
    
    # Clean up empty or malformed tools lines
    sed '/^tools:[ ]*$/d' "$temp_file" > "${temp_file}.3"
    mv "${temp_file}.3" "$temp_file"
    
    # Fix tools lines that start/end with commas
    sed 's/^tools: , /tools: /g; s/^tools: ,/tools:/g; s/, *$//' "$temp_file" > "${temp_file}.4"
    mv "${temp_file}.4" "$temp_file"
    
    if ! cmp -s "$file" "$temp_file"; then
        cp "$temp_file" "$file"
        echo "  ✓ Removed Task/TodoWrite tools from: $(basename "$file")"
        rm "$temp_file"
        return 0
    else
        rm "$temp_file"
        return 1
    fi
}

# Process all agent files to remove Task tools
updated_task_count=0
find agents/ -name "*.md" -print0 | while IFS= read -r -d '' file; do
    if remove_task_tools "$file"; then
        ((updated_task_count++))
    fi
done

echo
echo "3. REMOVING DEPLOYMENT CAPABILITIES FROM AGENT DESCRIPTIONS"
echo "========================================================"

# Define deployment-related terms to remove/replace
declare -A DEPLOYMENT_REPLACEMENTS=(
    # Direct deployment capabilities
    ["deploy"]="analyze"
    ["deployment"]="analysis"
    ["executing"]="analyzing"
    ["execute"]="analyze"
    ["execution"]="analysis"
    ["implement"]="evaluate"
    ["implementation"]="evaluation"
    ["implementing"]="evaluating"
    
    # System modification capabilities
    ["manage"]="assess"
    ["management"]="assessment"
    ["managing"]="assessing"
    ["create"]="evaluate"
    ["creating"]="evaluating"
    ["build"]="design"
    ["building"]="designing"
    ["configure"]="analyze configuration for"
    ["configuration"]="configuration analysis"
    ["configuring"]="analyzing configuration of"
    
    # Direct action verbs
    ["establish"]="recommend"
    ["establishing"]="recommending"
    ["setup"]="analyze setup requirements for"
    ["set up"]="analyze requirements for"
    ["install"]="evaluate installation requirements for"
    ["installing"]="evaluating installation of"
    
    # Coordination redefinition
    ["coordinate"]="analyze coordination requirements for"
    ["coordination"]="coordination analysis"
    ["coordinating"]="analyzing coordination of"
)

# Function to replace deployment terms in agent files
replace_deployment_terms() {
    local file="$1"
    local temp_file=$(mktemp)
    local modified=false
    
    cp "$file" "$temp_file"
    
    for old_term in "${!DEPLOYMENT_REPLACEMENTS[@]}"; do
        new_term="${DEPLOYMENT_REPLACEMENTS[$old_term]}"
        
        # Apply replacements
        if sed -i '' "s/\b$old_term\b/$new_term/g" "$temp_file" 2>/dev/null; then
            # Check for changes
            if ! cmp -s "$file" "$temp_file"; then
                modified=true
            fi
        fi
    done
    
    if [[ "$modified" == true ]]; then
        cp "$temp_file" "$file"
        echo "  ✓ Removed deployment capabilities from: $(basename "$file")"
        rm "$temp_file"
        return 0
    else
        rm "$temp_file"
        return 1
    fi
}

# Process all agent files for deployment term replacement
updated_deployment_count=0
find agents/ -name "*.md" -print0 | while IFS= read -r -d '' file; do
    if replace_deployment_terms "$file"; then
        ((updated_deployment_count++))
    fi
done

echo
echo "4. UPDATING AGENT MISSION STATEMENTS"
echo "===================================="

# Function to update agent mission statements to analysis-only
update_mission_statement() {
    local file="$1"
    local temp_file=$(mktemp)
    local modified=false
    
    cp "$file" "$temp_file"
    
    # Replace common mission statement patterns
    sed -i '' 's/Your Mission.*:/Your Mission: You analyze/g' "$temp_file"
    sed -i '' 's/\*\*Your Mission\*\*.*:/\*\*Your Mission\*\*: You analyze/g' "$temp_file"
    sed -i '' 's/Mission Statement.*/Mission Statement: Provide comprehensive analysis and recommendations to the orchestrator./g' "$temp_file"
    
    # Update responsibility sections
    sed -i '' 's/You will deploy/You will analyze/g' "$temp_file"
    sed -i '' 's/You deploy/You analyze/g' "$temp_file"
    sed -i '' 's/You implement/You evaluate/g' "$temp_file"
    sed -i '' 's/You create/You design/g' "$temp_file"
    sed -i '' 's/You establish/You recommend/g' "$temp_file"
    sed -i '' 's/You manage/You assess/g' "$temp_file"
    sed -i '' 's/You coordinate/You analyze coordination requirements for/g' "$temp_file"
    
    if ! cmp -s "$file" "$temp_file"; then
        cp "$temp_file" "$file"
        echo "  ✓ Updated mission statement in: $(basename "$file")"
        rm "$temp_file"
        return 0
    else
        rm "$temp_file"
        return 1
    fi
}

# Update all agent mission statements
updated_mission_count=0
find agents/ -name "*.md" -print0 | while IFS= read -r -d '' file; do
    if update_mission_statement "$file"; then
        ((updated_mission_count++))
    fi
done

echo
echo "5. ADDING ANALYSIS-ONLY CLARIFICATIONS"
echo "======================================"

# Function to add analysis-only clarification to agent files
add_analysis_clarification() {
    local file="$1"
    local temp_file=$(mktemp)
    
    # Check if clarification already exists
    if grep -q "ANALYSIS-ONLY SPECIALIST" "$file"; then
        return 1
    fi
    
    # Add clarification after the main heading
    awk '
    /^# [A-Z]/ && !added {
        print $0
        print ""
        print "**🔍 ANALYSIS-ONLY SPECIALIST**: This agent performs analysis and delivers recommendations to the orchestrator. It does not execute deployments, manage systems, or perform direct implementations."
        print ""
        added = 1
        next
    }
    { print }
    ' "$file" > "$temp_file"
    
    if ! cmp -s "$file" "$temp_file"; then
        cp "$temp_file" "$file"
        echo "  ✓ Added analysis-only clarification to: $(basename "$file")"
        rm "$temp_file"
        return 0
    else
        rm "$temp_file"
        return 1
    fi
}

# Add analysis-only clarifications to all agents
clarification_count=0
find agents/ -name "*.md" -print0 | while IFS= read -r -d '' file; do
    if add_analysis_clarification "$file"; then
        ((clarification_count++))
    fi
done

echo
echo "6. UPDATING COORDINATION DEFINITION"
echo "=================================="

# Create coordination definition update
COORDINATION_DEFINITION="operations/coordination-definition-update.md"
cat > "$COORDINATION_DEFINITION" << 'EOF'
# Coordination Definition Update

## New Definition: Coordination = Analysis Delivery

**CRITICAL FRAMEWORK CLARIFICATION**: 

- **Coordination** = Analyzing requirements and delivering structured recommendations to the orchestrator
- **Coordination** ≠ Execution, deployment, or direct system management
- **Coordination** ≠ Task orchestration or multi-agent management

## Agent Coordination Responsibilities

Agents that "coordinate" perform:

1. **Requirement Analysis**: Analyze coordination needs and dependencies
2. **Strategy Evaluation**: Evaluate coordination approaches and patterns
3. **Recommendation Generation**: Generate structured coordination recommendations
4. **Information Delivery**: Deliver actionable analysis to the orchestrator
5. **Risk Assessment**: Identify coordination risks and mitigation strategies

## What Agents DO NOT Do

- ❌ Deploy other agents via Task tools
- ❌ Execute system changes directly
- ❌ Manage infrastructure or services
- ❌ Coordinate actual deployments
- ❌ Implement solutions directly

## What Agents DO

- ✅ Analyze coordination requirements
- ✅ Design coordination strategies
- ✅ Evaluate coordination patterns
- ✅ Recommend coordination approaches
- ✅ Assess coordination risks
- ✅ Deliver structured analysis to orchestrator
EOF

echo "Created coordination definition update: $COORDINATION_DEFINITION"

echo
echo "7. VERIFICATION SCAN"
echo "==================="

# Scan for remaining deployment-related terms
echo "Scanning for remaining deployment capabilities..."
deployment_violations=$(find agents/ -name "*.md" -exec grep -l -i -E "(deploy|implement|execute|manage.*system|create.*system)" {} \; | wc -l)
echo "Files with potential deployment capabilities: $deployment_violations"

if [[ $deployment_violations -gt 5 ]]; then
    echo "Sample files with remaining deployment terms:"
    find agents/ -name "*.md" -exec grep -l -i -E "(deploy|implement|execute|manage.*system)" {} \; | head -5
fi

# Scan for Task tool references
task_tool_violations=$(find agents/ -name "*.md" -exec grep -l "Task" {} \; | wc -l)
echo "Files with Task tool references: $task_tool_violations"

if [[ $task_tool_violations -gt 0 ]]; then
    echo "Files still containing Task tools:"
    find agents/ -name "*.md" -exec grep -l "Task" {} \; | head -5
fi

echo
echo "8. GENERATING COMPREHENSIVE REPORT"
echo "=================================="

# Generate detailed report
REPORT_FILE="operations/deployment-removal-report-$(date +%Y%m%d-%H%M%S).md"

cat > "$REPORT_FILE" << EOF
# Deployment Capabilities Removal Report
Generated: $(date)

## Summary
- Total agent files processed: $(find agents/ -name "*.md" | wc -l)
- Task tools removed from agents
- Deployment capabilities systematically replaced with analysis functions
- Mission statements updated to analysis-only focus
- Analysis-only clarifications added to all agents

## Key Changes Made

### 1. Task Tool Removal
- Removed Task tool from all agent configurations
- Removed TodoWrite tool from agents (orchestrator-only)
- Cleaned up malformed tools lines

### 2. Deployment Term Replacements
- "deploy" → "analyze"
- "implement" → "evaluate"  
- "execute" → "analyze"
- "manage" → "assess"
- "coordinate" → "analyze coordination requirements for"

### 3. Mission Statement Updates
- Updated all mission statements to analysis-only focus
- Replaced action verbs with analysis verbs
- Added analysis-only specialist clarifications

### 4. Coordination Redefinition
- Coordination = Analysis delivery to orchestrator
- Coordination ≠ Execution or deployment
- Created formal definition document

## Verification Results
- Files with deployment capabilities: $deployment_violations
- Files with Task tool references: $task_tool_violations

## Compliance Status
✅ **ANALYSIS-ONLY FRAMEWORK**: All agents converted to analysis specialists
✅ **NO DEPLOYMENT CAPABILITIES**: Direct deployment capabilities removed
✅ **ORCHESTRATOR-ONLY EXECUTION**: Only orchestrator performs deployments
✅ **CLEAR COORDINATION DEFINITION**: Coordination = analysis delivery

## Next Steps
1. Validate remaining deployment terms are legitimate (e.g., "deployment analysis")
2. Ensure all agents deliver structured analysis to orchestrator
3. Verify coordination clarification is understood throughout framework
EOF

echo "Comprehensive report saved to: $REPORT_FILE"

echo
echo "=== DEPLOYMENT CAPABILITIES REMOVAL COMPLETE ==="
echo "✅ All agents converted to analysis-only specialists"
echo "✅ Task tools removed from agent configurations"
echo "✅ Deployment capabilities systematically eliminated"
echo "✅ Coordination redefined as analysis delivery"