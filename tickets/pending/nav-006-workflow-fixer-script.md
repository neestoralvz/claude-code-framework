---
title: "Workflow Documentation Link Fixer"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
dependencies: ["NAV-005", "workflow.md", "documentation.md"]
prerequisites: ["Workflow structure understanding", "Documentation link patterns"]
audience: "Developers, documentation maintainers"
purpose: "Create script to fix workflow documentation links and maintain process integrity"
keywords: ["workflow", "documentation", "links", "process", "methodology", "automation", "integrity"]
last_review: "2025-08-19"
---

[Previous: Registry Validator](nav-005-registry-validator-script.md) | [Navigate to Documentation Hub](../../docs/index.md) | [Framework: Claude Code] | [Next: Integrity Monitor](nav-007-integrity-monitor-system.md)

# WORKFLOW DOCUMENTATION LINK FIXER

⏺ **Principle**: Implement [workflow.md](../../docs/principles/workflow.md) systematic process integrity and apply [documentation.md](../../docs/principles/documentation.md) coherent documentation through automated workflow link maintenance.

## PROBLEM STATEMENT

Workflow documentation contains broken links to deleted command files and reorganized methodology documents. Manual workflow link maintenance disrupts process consistency and creates documentation gaps. Need automated script to fix workflow documentation links and maintain process integrity.

### Target Capabilities
- **Workflow link scanning** - Find all workflow-related documentation links
- **Process flow validation** - Ensure workflow sequences remain intact
- **Methodology mapping** - Update references to reorganized methodology docs
- **Phase link repair** - Fix 8-phase workflow navigation
- **Cross-reference integrity** - Maintain workflow cross-references

## SUCCESS CRITERIA

### Primary Objectives
- [ ] Scan all workflow documentation for broken links
- [ ] Fix references to deleted workflow command files
- [ ] Update methodology documentation references
- [ ] Repair 8-phase workflow navigation sequences
- [ ] Maintain workflow cross-reference integrity
- [ ] Preserve workflow process flow consistency

### Validation Gates
1. **Requirements Gate**: All workflow link scenarios properly handled
2. **Process Gate**: Systematic workflow maintenance methodology applied
3. **Output Gate**: Workflow documentation links function correctly
4. **System Gate**: Process integrity maintained without disruption

## IMPLEMENTATION STRATEGY

### Script Architecture
```bash
#!/bin/bash
# scripts/workflow-fixer.sh - Workflow documentation link repair

FRAMEWORK_ROOT="/Users/nalve/.claude"
WORKFLOW_DOCS="$FRAMEWORK_ROOT/docs/principles/workflow.md"
PHASE_DOCS_PATTERN="**/workflow/*"
OUTPUT_DIR="$FRAMEWORK_ROOT/operations/workflow-fixes"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Main execution phases
main() {
    initialize_workflow_analysis
    scan_workflow_documentation
    identify_broken_workflow_links
    map_workflow_reorganization
    fix_phase_navigation_sequences
    update_methodology_references
    validate_workflow_integrity
    generate_workflow_fix_report
}
```

### Core Functions

#### Workflow Documentation Discovery
```bash
discover_workflow_documents() {
    local workflow_files="$TEMP_DIR/workflow_files.txt"
    
    # Find all workflow-related documentation
    find "$FRAMEWORK_ROOT" -name "*.md" -type f | \
    xargs grep -l -i "workflow\|methodology\|phase\|process" | \
    grep -v ".git" > "$workflow_files"
    
    # Add known workflow documents
    echo "$FRAMEWORK_ROOT/docs/principles/workflow.md" >> "$workflow_files"
    echo "$FRAMEWORK_ROOT/CLAUDE.md" >> "$workflow_files"
}
```

#### Workflow Link Extraction
```bash
extract_workflow_links() {
    local document="$1"
    local workflow_links="$TEMP_DIR/workflow_links.txt"
    
    # Extract workflow-related links
    grep -n "\[.*\](.*workflow.*\.md)" "$document" >> "$workflow_links"
    grep -n "\[.*\](.*methodology.*\.md)" "$document" >> "$workflow_links"
    grep -n "\[.*\](.*phase.*\.md)" "$document" >> "$workflow_links"
    grep -n "\[.*\](.*process.*\.md)" "$document" >> "$workflow_links"
}
```

#### Phase Navigation Validation
```bash
validate_phase_navigation() {
    local workflow_doc="$1"
    
    # Check 8-phase workflow sequence
    local phases=(
        "clarify" "explore" "analyze" "present-solutions"
        "plan" "implement" "ripple-effect" "validate"
    )
    
    for i in "${!phases[@]}"; do
        local current_phase="${phases[$i]}"
        local next_phase="${phases[$((i + 1))]}"
        
        validate_phase_link "$workflow_doc" "$current_phase" "$next_phase"
    done
}
```

## TECHNICAL IMPLEMENTATION

### Workflow Link Categories

#### Phase Navigation Links
```bash
fix_phase_navigation_links() {
    local document="$1"
    
    # Update phase references from commands/workflow/ to docs/principles/
    sed -i 's|commands/workflow/\([0-9]*\)-\([^.]*\)\.md|docs/principles/workflow.md#phase-\1-\2|g' "$document"
    
    # Update methodology references
    sed -i 's|commands/methodology/|docs/principles/workflow.md#|g' "$document"
}
```

#### Workflow Command References
```bash
fix_workflow_command_references() {
    local document="$1"
    
    # Map deleted workflow commands to new locations
    declare -A workflow_command_map=(
        ["commands/workflow/1-clarify.md"]="docs/principles/workflow.md#phase-1-clarify"
        ["commands/workflow/2-explore.md"]="docs/principles/workflow.md#phase-2-explore"
        ["commands/workflow/3-analyze.md"]="docs/principles/workflow.md#phase-3-analyze"
        ["commands/workflow/4-present-solutions.md"]="docs/principles/workflow.md#phase-4-present-solutions"
        ["commands/workflow/5-plan.md"]="docs/principles/workflow.md#phase-5-plan"
        ["commands/workflow/6-implement.md"]="docs/principles/workflow.md#phase-6-implement"
        ["commands/workflow/7-ripple-effect.md"]="docs/principles/workflow.md#phase-7-ripple-effect"
        ["commands/workflow/8-validate.md"]="docs/principles/workflow.md#phase-8-validate"
    )
    
    for old_path in "${!workflow_command_map[@]}"; do
        local new_path="${workflow_command_map[$old_path]}"
        sed -i "s|$old_path|$new_path|g" "$document"
    done
}
```

#### Methodology Documentation Updates
```bash
update_methodology_references() {
    local document="$1"
    
    # Update methodology documentation structure
    declare -A methodology_map=(
        ["commands/methodology/8-phase-workflow.md"]="docs/principles/workflow.md"
        ["commands/methodology/systematic-execution.md"]="docs/principles/workflow.md#systematic-execution"
        ["commands/methodology/validation-framework.md"]="docs/principles/workflow.md#validation-framework"
    )
    
    for old_ref in "${!methodology_map[@]}"; do
        local new_ref="${methodology_map[$old_ref]}"
        sed -i "s|$old_ref|$new_ref|g" "$document"
    done
}
```

### Cross-Reference Integrity

#### Workflow Cross-Reference Mapping
```bash
map_workflow_cross_references() {
    local document="$1"
    local cross_refs="$TEMP_DIR/workflow_cross_refs.txt"
    
    # Extract workflow cross-references
    grep -n "Apply workflow.md\|Follow workflow.md\|Use workflow.md" "$document" > "$cross_refs"
    
    # Validate cross-reference targets
    while IFS=':' read -r line_num line_content; do
        validate_workflow_cross_reference "$document" "$line_num" "$line_content"
    done < "$cross_refs"
}
```

#### Process Flow Validation
```bash
validate_process_flow() {
    local workflow_sequence="$1"
    
    # Check workflow sequence integrity
    local expected_flow=(
        "Requirements Clarification"
        "System Exploration"
        "Problem Analysis"
        "Solution Presentation"
        "Implementation Planning"
        "Execution Implementation"
        "Impact Analysis"
        "Validation Verification"
    )
    
    for phase in "${expected_flow[@]}"; do
        if ! grep -q "$phase" "$workflow_sequence"; then
            log "WARNING: Missing workflow phase: $phase"
        fi
    done
}
```

## ADVANCED FEATURES

### Intelligent Link Replacement
```bash
intelligent_link_replacement() {
    local broken_link="$1"
    local context="$2"
    
    # Analyze link context to suggest best replacement
    case "$context" in
        *"8-phase"*|*"methodology"*)
            suggest_replacement "docs/principles/workflow.md"
            ;;
        *"validation"*|*"quality"*)
            suggest_replacement "docs/principles/workflow.md#validation-framework"
            ;;
        *"execution"*|*"implementation"*)
            suggest_replacement "docs/principles/workflow.md#systematic-execution"
            ;;
    esac
}
```

### Workflow Documentation Generation
```bash
generate_workflow_navigation() {
    local workflow_doc="$1"
    
    # Generate workflow phase navigation
    cat >> "$workflow_doc" << 'EOF'
## Workflow Phase Navigation

| Phase | Focus | Next Phase |
|-------|-------|------------|
| [1. Clarify](#phase-1-clarify) | Requirements | [2. Explore](#phase-2-explore) |
| [2. Explore](#phase-2-explore) | Discovery | [3. Analyze](#phase-3-analyze) |
| [3. Analyze](#phase-3-analyze) | Understanding | [4. Present](#phase-4-present-solutions) |
| [4. Present](#phase-4-present-solutions) | Solutions | [5. Plan](#phase-5-plan) |
| [5. Plan](#phase-5-plan) | Strategy | [6. Implement](#phase-6-implement) |
| [6. Implement](#phase-6-implement) | Execution | [7. Ripple](#phase-7-ripple-effect) |
| [7. Ripple](#phase-7-ripple-effect) | Impact | [8. Validate](#phase-8-validate) |
| [8. Validate](#phase-8-validate) | Verification | [1. Clarify](#phase-1-clarify) |
EOF
}
```

### Batch Processing
```bash
process_all_workflow_documents() {
    local workflow_files="$TEMP_DIR/workflow_files.txt"
    local parallel_jobs=4
    
    while read -r workflow_file; do
        (($(jobs -r | wc -l) >= parallel_jobs)) && wait
        fix_workflow_document_links "$workflow_file" &
    done < "$workflow_files"
    wait
}
```

## VALIDATION AND REPORTING

### Fix Validation
```bash
validate_workflow_fixes() {
    local fixed_document="$1"
    local validation_report="$OUTPUT_DIR/validation_report.txt"
    
    # Run link scanner on fixed document
    "$FRAMEWORK_ROOT/scripts/link-scanner.sh" \
        --file="$fixed_document" \
        --output="$TEMP_DIR/post_fix_scan.json"
    
    # Compare with pre-fix state
    local remaining_broken_links=$(jq '.broken_links | length' "$TEMP_DIR/post_fix_scan.json")
    
    if [[ "$remaining_broken_links" -eq 0 ]]; then
        echo "PASS: $fixed_document - All workflow links fixed" >> "$validation_report"
    else
        echo "FAIL: $fixed_document - $remaining_broken_links broken links remain" >> "$validation_report"
    fi
}
```

### Comprehensive Report
```json
{
  "workflow_fix_summary": {
    "timestamp": "2025-08-19T11:00:00Z",
    "documents_processed": 23,
    "total_fixes_applied": 147,
    "workflow_integrity_restored": true
  },
  "fix_categories": {
    "phase_navigation_fixes": 45,
    "methodology_reference_updates": 38,
    "workflow_command_replacements": 42,
    "cross_reference_repairs": 22
  },
  "workflow_validation": {
    "8_phase_sequence_intact": true,
    "methodology_references_valid": true,
    "process_flow_consistent": true,
    "cross_references_functional": true
  }
}
```

## DELIVERABLES

1. **workflow-fixer.sh** - Main workflow link fixer script
2. **Workflow mapping** - Command to documentation mapping
3. **Phase navigation** - 8-phase workflow link repair
4. **Validation system** - Workflow integrity verification
5. **CLI interface** - Command-line usage options
6. **Report generation** - Fix summary and validation results
7. **Documentation** - Workflow maintenance procedures

## EFFORT ESTIMATE

- **Core workflow analysis**: 3-4 hours
- **Link mapping and replacement**: 4-5 hours
- **Phase navigation repair**: 2-3 hours
- **Validation system**: 2-3 hours
- **CLI interface**: 1-2 hours
- **Testing and verification**: 2-3 hours
- **Documentation**: 1 hour

**Total Estimated Effort**: 15-21 hours

## DEPENDENCIES

### Prerequisites
- Workflow structure understanding
- 8-phase methodology knowledge
- Documentation organization familiarity

### Blocks
- None

### Enables
- Workflow documentation integrity
- Process consistency maintenance
- Methodology reference accuracy

## VALIDATION METHODOLOGY

### 4-Gate Validation
1. **Requirements Gate**: All workflow link scenarios properly handled
2. **Process Gate**: Systematic workflow maintenance methodology applied
3. **Output Gate**: Workflow documentation links function correctly
4. **System Gate**: Process integrity maintained without disruption

### Quality Assurance
- Workflow sequence validation
- Cross-reference integrity testing
- Process flow consistency verification
- Integration testing with workflow updates

## CROSS-REFERENCES

### Related Tickets
- [NAV-005: Registry Validator](nav-005-registry-validator-script.md)
- [NAV-007: Integrity Monitor](nav-007-integrity-monitor-system.md)
- [NAV-008: System Principle Update](nav-008-automated-link-maintenance-principle.md)

### Framework References
- [Apply workflow.md systematic methodology](../../docs/principles/workflow.md)
- [Follow documentation.md coherence standards](../../docs/principles/documentation.md)
- [Use organization.md structural patterns](../../docs/principles/organization.md)

---

**Priority**: 🔴 HIGH  
**Category**: workflow  
**Effort**: 15-21h  
**Status**: PENDING  
**Created**: 2025-08-19  
**Dependencies**: NAV-005

[⬆ Return to top](#workflow-documentation-link-fixer)