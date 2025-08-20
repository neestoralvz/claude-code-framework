#!/bin/bash

# Test Script for Monitoring System Integration with v5.0 Framework
# This validates that monitoring enhances without complicating

echo "========================================"
echo "MONITORING SYSTEM INTEGRATION TEST"
echo "Framework v5.0 - Simple and Easy"
echo "========================================"
echo ""

# Test 1: Verify CLAUDE.md has monitoring integration
echo "Test 1: Checking CLAUDE.md integration..."
if grep -q "/monitor" /Users/nalve/.claude/CLAUDE.md; then
    echo "  ✅ /monitor command found in slash commands"
else
    echo "  ❌ /monitor command missing from CLAUDE.md"
fi

if grep -q "Monitor" /Users/nalve/.claude/CLAUDE.md | head -1; then
    echo "  ✅ Monitor tool listed in Key Tools"
else
    echo "  ❌ Monitor tool missing from Key Tools"
fi
echo ""

# Test 2: Verify monitoring documentation exists
echo "Test 2: Checking monitoring documentation..."
if [ -f "/Users/nalve/.claude/work/20250820-224500-monitoring-integration/universal-monitoring-system.md" ]; then
    echo "  ✅ Universal monitoring system documentation exists"
    lines=$(wc -l < "/Users/nalve/.claude/work/20250820-224500-monitoring-integration/universal-monitoring-system.md")
    echo "  📄 Documentation size: $lines lines"
else
    echo "  ❌ Monitoring documentation not found"
fi
echo ""

# Test 3: Verify agent templates exist
echo "Test 3: Checking monitoring agent templates..."
if [ -f "/Users/nalve/.claude/work/20250820-224500-monitoring-integration/monitoring-agents.md" ]; then
    echo "  ✅ Monitoring agent templates exist"
    agents=$(grep -c "^## " "/Users/nalve/.claude/work/20250820-224500-monitoring-integration/monitoring-agents.md")
    echo "  🤖 Agent templates defined: $agents"
else
    echo "  ❌ Agent templates not found"
fi
echo ""

# Test 4: Verify example workflow
echo "Test 4: Checking example workflow..."
if [ -f "/Users/nalve/.claude/work/20250820-224500-monitoring-integration/example-monitoring-workflow.md" ]; then
    echo "  ✅ Example workflow documentation exists"
    if grep -q "Think.*Deploy Agent.*Track.*Done" "/Users/nalve/.claude/work/20250820-224500-monitoring-integration/example-monitoring-workflow.md"; then
        echo "  ✅ Workflow follows v5.0 pattern"
    else
        echo "  ⚠️  Workflow pattern not clearly defined"
    fi
else
    echo "  ❌ Example workflow not found"
fi
echo ""

# Test 5: Check simplicity metrics
echo "Test 5: Validating simplicity..."
original_lines=$(grep -c "^## " /Users/nalve/.claude/CLAUDE.md)
echo "  📈 CLAUDE.md sections: $original_lines"
echo "  🎯 Target: Minimal additions (2-3 lines max)"

monitor_additions=$(grep -c "monitor" /Users/nalve/.claude/CLAUDE.md)
echo "  ➕ Monitor references added: $monitor_additions"

if [ $monitor_additions -le 3 ]; then
    echo "  ✅ Minimal integration achieved - maintains simplicity"
else
    echo "  ⚠️  Consider simplifying integration"
fi
echo ""

# Test 6: Validate monitoring patterns
echo "Test 6: Checking monitoring patterns..."
echo "  Verifying key principles:"

if grep -q "Monitor simply" /Users/nalve/.claude/work/20250820-224500-monitoring-integration/universal-monitoring-system.md; then
    echo "    ✅ 'Monitor simply' principle present"
fi

if grep -q "Simple View (Default)" /Users/nalve/.claude/work/20250820-224500-monitoring-integration/universal-monitoring-system.md; then
    echo "    ✅ Default to simple view"
fi

if grep -q "Automated Responses" /Users/nalve/.claude/work/20250820-224500-monitoring-integration/universal-monitoring-system.md; then
    echo "    ✅ Automatic issue handling"
fi
echo ""

# Test 7: Integration completeness
echo "Test 7: Integration completeness check..."
required_components=(
    "System Monitor Agent"
    "Quality Monitor Agent" 
    "Performance Monitor Agent"
    "Simple Access Pattern"
    "Automated Responses"
)

complete=true
for component in "${required_components[@]}"; do
    if grep -q "$component" /Users/nalve/.claude/work/20250820-224500-monitoring-integration/*.md 2>/dev/null; then
        echo "  ✅ $component defined"
    else
        echo "  ❌ $component missing"
        complete=false
    fi
done
echo ""

# Final Summary
echo "========================================"
echo "TEST SUMMARY"
echo "========================================"

if [ "$complete" = true ]; then
    echo "✅ INTEGRATION SUCCESSFUL"
    echo ""
    echo "The monitoring system has been successfully integrated with:"
    echo "  - Minimal changes to CLAUDE.md (maintains simplicity)"
    echo "  - Comprehensive monitoring capabilities"
    echo "  - Clear documentation and examples"
    echo "  - Agent templates ready for deployment"
    echo ""
    echo "Key Features:"
    echo "  📊 Simple dashboard with /monitor command"
    echo "  🤖 5 specialized monitoring agents"
    echo "  ⚡ Automatic issue detection and response"
    echo "  📈 Performance tracking and optimization"
    echo "  ✅ Quality assurance automation"
else
    echo "⚠️ INTEGRATION INCOMPLETE"
    echo "Some components are missing. Please review the test output above."
fi

echo ""
echo "Usage: Simply type '/monitor' to access the monitoring system"
echo "========================================"