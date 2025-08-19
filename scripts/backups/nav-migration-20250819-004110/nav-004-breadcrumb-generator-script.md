
[Previous: Link Updater](../../../tickets/pending/nav-003-link-updater-script.md) | [Navigate to Documentation Hub](../../../docs/index.md) | [Framework: Claude Code] | [Next: Registry Validator](nav-005-registry-validator-script.md)

# DYNAMIC BREADCRUMB GENERATOR SCRIPT

⏺ **Principle**: Implement [organization.md](../../../docs/principles/organization.md) hierarchical navigation and apply [navigation.md](../../docs/principles/navigation.md) systematic wayfinding through dynamic breadcrumb generation.

## PROBLEM STATEMENT

Static breadcrumbs become broken when files are moved or the navigation hierarchy changes. Manual breadcrumb maintenance is error-prone and inconsistent. Need automated script to generate navigation breadcrumbs dynamically based on file location and framework hierarchy.

### Target Capabilities
- **Dynamic generation** - Breadcrumbs based on file path and hierarchy
- **Context awareness** - Different breadcrumb patterns per document type
- **Hierarchy mapping** - Understand framework organizational structure
- **Template system** - Configurable breadcrumb formats
- **Live updates** - Regenerate when structure changes

## SUCCESS CRITERIA

### Primary Objectives
- [ ] Generate breadcrumbs dynamically based on file location
- [ ] Support multiple breadcrumb templates per document type
- [ ] Maintain consistent navigation patterns across framework
- [ ] Update breadcrumbs automatically when files move
- [ ] Preserve custom navigation sequences where specified
- [ ] Execute efficiently for batch processing

### Validation Gates
1. **Requirements Gate**: All breadcrumb scenarios properly handled
2. **Process Gate**: Dynamic generation methodology implemented
3. **Output Gate**: Consistent, accurate navigation breadcrumbs
4. **System Gate**: No navigation disruption during updates

## IMPLEMENTATION STRATEGY

### Script Architecture
```bash
#!/bin/bash
# scripts/breadcrumb-generator.sh - Dynamic navigation breadcrumbs

FRAMEWORK_ROOT="/Users/nalve/.claude"
CONFIG_DIR="$FRAMEWORK_ROOT/scripts/config"
TEMPLATES_DIR="$CONFIG_DIR/breadcrumb-templates"
HIERARCHY_MAP="$CONFIG_DIR/framework-hierarchy.json"

# Main execution phases
main() {
    load_hierarchy_configuration
    analyze_file_context
    determine_breadcrumb_template
    generate_navigation_sequence
    format_breadcrumb_output
    update_file_breadcrumbs
    validate_navigation_integrity
}
```

### Core Functions

#### Hierarchy Analysis
```bash
analyze_file_hierarchy() {
    local file_path="$1"
    local relative_path=$(realpath --relative-to="$FRAMEWORK_ROOT" "$file_path")
    
    # Determine document type and context
    case "$relative_path" in
        docs/principles/*)
            document_type="principle"
            parent_hub="docs/PRINCIPLES.md"
            ;;
        docs/components/*)
            document_type="component"
            parent_hub="docs/index.md"
            ;;
        agents/*)
            document_type="agent"
            parent_hub="agents/README.md"
            ;;
        tickets/pending/*)
            document_type="ticket"
            parent_hub="../../planning/TICKET_REGISTRY.md"
            ;;
    esac
}
```

#### Template Selection
```bash
select_breadcrumb_template() {
    local document_type="$1"
    local context="$2"
    
    # Load appropriate template
    case "$document_type" in
        "principle")
            template="$TEMPLATES_DIR/principle-breadcrumb.template"
            ;;
        "component")
            template="$TEMPLATES_DIR/component-breadcrumb.template"
            ;;
        "agent")
            template="$TEMPLATES_DIR/agent-breadcrumb.template"
            ;;
        "ticket")
            template="$TEMPLATES_DIR/ticket-breadcrumb.template"
            ;;
    esac
}
```

#### Dynamic Generation
```bash
generate_breadcrumb_sequence() {
    local file_path="$1"
    local template="$2"
    
    # Extract navigation elements
    local file_name=$(basename "$file_path" .md)
    local parent_dir=$(dirname "$file_path")
    local section=$(extract_section_from_path "$file_path")
    
    # Generate breadcrumb links
    local breadcrumb_sequence=""
    for level in "${navigation_levels[@]}"; do
        local link_text=$(get_level_text "$level")
        local link_target=$(get_level_target "$level")
        breadcrumb_sequence+="\[$link_text\]($link_target) | "
    done
    
    # Remove trailing separator
    breadcrumb_sequence=${breadcrumb_sequence%" | "}
}
```

## TECHNICAL IMPLEMENTATION

### Template System

#### Principle Document Template
```
[Previous: Return to Hub](../../docs/PRINCIPLES.md) | [Navigate to Documentation Hub](../../../docs/index.md) | [Framework: Claude Code] | [Next: Browse Components](../../docs/components/)
```

#### Component Document Template
```
[Previous: Return to Hub](../../../docs/index.md) | [Navigate to {{SECTION}}]({{SECTION_INDEX}}) | [Framework: Claude Code] | [Next: {{NEXT_COMPONENT}}]({{NEXT_TARGET}})
```

#### Agent Document Template
```
[Previous: Return to Registry](../../agents/README.md) | [Navigate to Documentation Hub](../../../docs/index.md) | [Framework: Claude Code] | [Next: Browse Agents](../../agents/)
```

#### Ticket Document Template
```
[Previous: Return to Registry](../../../planning/TICKET_REGISTRY.md) | [Navigate to Documentation Hub](../../../docs/index.md) | [Framework: Claude Code] | [Next: {{NEXT_TICKET}}]({{NEXT_TARGET}})
```

### Hierarchy Configuration
```json
{
  "framework_hierarchy": {
    "root": {
      "path": "/Users/nalve/.claude",
      "index": "CLAUDE.md",
      "title": "Claude Code Framework"
    },
    "sections": {
      "docs": {
        "title": "Documentation Hub",
        "index": "docs/index.md",
        "subsections": {
          "principles": {
            "title": "Core Principles",
            "index": "docs/PRINCIPLES.md"
          },
          "components": {
            "title": "Framework Components", 
            "index": "docs/components/"
          },
          "planning": {
            "title": "Planning & Tickets",
            "index": "../../planning/TICKET_REGISTRY.md"
          }
        }
      },
      "agents": {
        "title": "Specialized Agents",
        "index": "agents/README.md"
      },
      "tickets": {
        "title": "Ticket Management",
        "index": "../../planning/TICKET_REGISTRY.md"
      }
    }
  }
}
```

### Context-Aware Generation

#### Smart Next/Previous Links
```bash
determine_navigation_sequence() {
    local current_file="$1"
    local document_type="$2"
    
    case "$document_type" in
        "principle")
            previous_link="docs/PRINCIPLES.md"
            next_link=$(find_next_principle "$current_file")
            ;;
        "ticket")
            previous_link="../../planning/TICKET_REGISTRY.md"
            next_link=$(find_related_ticket "$current_file")
            ;;
    esac
}
```

#### Semantic Relationships
```bash
find_next_component() {
    local current_component="$1"
    local component_category=$(extract_category "$current_component")
    
    # Find next component in same category
    local next_in_category=$(grep -A1 "$current_component" \
        "$component_category/index.md" | tail -1)
    
    if [[ -n "$next_in_category" ]]; then
        echo "$next_in_category"
    else
        # Find first component in next category
        find_next_category_component "$component_category"
    fi
}
```

## ADVANCED FEATURES

### Variable Substitution
```bash
apply_template_variables() {
    local template_content="$1"
    local file_context="$2"
    
    # Replace template variables
    template_content=${template_content//\{\{SECTION\}\}/$section_title}
    template_content=${template_content//\{\{SECTION_INDEX\}\}/$section_index}
    template_content=${template_content//\{\{NEXT_COMPONENT\}\}/$next_component}
    template_content=${template_content//\{\{NEXT_TARGET\}\}/$next_target}
    
    echo "$template_content"
}
```

### Batch Processing
```bash
process_all_files() {
    local file_pattern="$1"
    local parallel_jobs=4
    
    find "$FRAMEWORK_ROOT" -name "$file_pattern" -type f | \
    while read -r file; do
        (($(jobs -r | wc -l) >= parallel_jobs)) && wait
        generate_breadcrumb_for_file "$file" &
    done
    wait
}
```

### Integration Features

#### File Update Integration
```bash
update_file_breadcrumb() {
    local file_path="$1"
    local new_breadcrumb="$2"
    
    # Find existing breadcrumb line
    local breadcrumb_line=$(grep -n "^\[Previous:" "$file_path" | cut -d: -f1)
    
    if [[ -n "$breadcrumb_line" ]]; then
        # Replace existing breadcrumb
        sed -i "${breadcrumb_line}s/.*/$new_breadcrumb/" "$file_path"
    else
        # Insert breadcrumb after frontmatter
        local insert_line=$(grep -n "^---$" "$file_path" | tail -1 | cut -d: -f1)
        sed -i "$((insert_line + 1))i\\n$new_breadcrumb\\n" "$file_path"
    fi
}
```

#### CLI Interface
```bash
# Usage examples
./scripts/breadcrumb-generator.sh --update-all
./scripts/breadcrumb-generator.sh --file="docs/principles/workflow.md"
./scripts/breadcrumb-generator.sh --type="ticket" --batch
./scripts/breadcrumb-generator.sh --validate-only
```

## DELIVERABLES

1. **breadcrumb-generator.sh** - Main generator script
2. **Template system** - Configurable breadcrumb templates
3. **Hierarchy configuration** - Framework structure mapping
4. **Integration hooks** - File update automation
5. **CLI interface** - Command-line usage options
6. **Validation system** - Navigation integrity verification
7. **Documentation** - Usage guide and template reference

## EFFORT ESTIMATE

- **Core generation logic**: 3-4 hours
- **Template system**: 2-3 hours
- **Hierarchy mapping**: 2-3 hours
- **Integration features**: 2-3 hours
- **CLI interface**: 1-2 hours
- **Testing and validation**: 2-3 hours
- **Documentation**: 1 hour

**Total Estimated Effort**: 13-19 hours

## DEPENDENCIES

### Prerequisites
- Framework hierarchy understanding
- Navigation pattern knowledge
- Template system design

### Blocks
- None

### Enables
- Consistent navigation across framework
- Automatic breadcrumb maintenance
- Reduced manual navigation updates

## VALIDATION METHODOLOGY

### 4-Gate Validation
1. **Requirements Gate**: All breadcrumb scenarios properly handled
2. **Process Gate**: Dynamic generation methodology implemented
3. **Output Gate**: Consistent, accurate navigation breadcrumbs
4. **System Gate**: No navigation disruption during updates

### Quality Assurance
- Template validation for all document types
- Navigation sequence verification
- Integration testing with file operations
- Performance testing for batch processing

## CROSS-REFERENCES

### Related Tickets
- [NAV-003: Link Updater Script](../../../tickets/pending/nav-003-link-updater-script.md)
- [NAV-005: Registry Validator](nav-005-registry-validator-script.md)
- [NAV-007: Integrity Monitor](../../../tickets/pending/nav-007-integrity-monitor-system.md)

### Framework References
- [Apply organization.md hierarchical structure](../../../docs/principles/organization.md)
- [Follow navigation.md wayfinding patterns](../../docs/principles/navigation.md)
- [Use workflow.md systematic methodology](../../../docs/principles/workflow.md)


**Priority**: 🔴 HIGH  
**Category**: automation  
**Effort**: 13-19h  
**Status**: PENDING  
**Created**: 2025-08-19  
**Dependencies**: NAV-003

[⬆ Return to top](#dynamic-breadcrumb-generator-script)
