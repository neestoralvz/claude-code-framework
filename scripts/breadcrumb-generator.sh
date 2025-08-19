#!/bin/bash

# Navigation Breadcrumb Generator
# Generates standardized breadcrumbs for documentation files
# Based on navigation-breadcrumb.md component specification

set -eo pipefail

# Configuration
CLAUDE_ROOT="/Users/nalve/.claude"
DOCS_DIR="$CLAUDE_ROOT/docs"
COMMANDS_DIR="$CLAUDE_ROOT/commands" 
AGENTS_DIR="$CLAUDE_ROOT/agents"
SCRIPTS_DIR="$CLAUDE_ROOT/scripts"

# Action verb mappings function
get_action_verb() {
    local file_name="$1"
    
    case "$file_name" in
        *analyze*) echo "Analyze" ;;
        *audit*) echo "Execute" ;;
        *create*) echo "Deploy" ;;
        *execute*) echo "Execute" ;;
        *modularize*) echo "Deploy" ;;
        *review*) echo "Review" ;;
        *system*) echo "Execute" ;;
        *update*) echo "Deploy" ;;
        *validate*) echo "Apply" ;;
        *agent*) echo "Deploy" ;;
        *project*) echo "Deploy" ;;
        *index*) echo "Navigate to" ;;
        *README*) echo "Navigate to" ;;
        *PRINCIPLES*) echo "Study" ;;
        *ticket*) echo "Review" ;;
        *planning*) echo "Study" ;;
        *components*) echo "Navigate to" ;;
        *) echo "Navigate to" ;;
    esac
}

# Generate breadcrumb for a file
generate_breadcrumb() {
    local file_path="$1"
    local relative_dir
    local file_name
    local file_type
    local breadcrumb
    
    # Extract file information
    relative_dir=$(dirname "$file_path" | sed "s|$CLAUDE_ROOT/||")
    file_name=$(basename "$file_path" .md)
    
    # Determine file type and generate appropriate breadcrumb
    case "$relative_dir" in
        "commands")
            breadcrumb=$(generate_command_breadcrumb "$file_name")
            ;;
        "agents")
            breadcrumb=$(generate_agent_breadcrumb "$file_name")
            ;;
        "docs")
            breadcrumb=$(generate_docs_breadcrumb "$file_name")
            ;;
        "docs/components")
            breadcrumb=$(generate_component_breadcrumb "$file_name")
            ;;
        "docs/planning")
            breadcrumb=$(generate_planning_breadcrumb "$file_name")
            ;;
        "docs/planning/tickets"*|"docs/planning/components"*)
            breadcrumb=$(generate_ticket_breadcrumb "$file_name" "$relative_dir")
            ;;
        "docs/principles")
            breadcrumb=$(generate_principle_breadcrumb "$file_name")
            ;;
        *)
            breadcrumb=$(generate_default_breadcrumb "$file_name" "$relative_dir")
            ;;
    esac
    
    echo "$breadcrumb"
}

# Generate breadcrumb for command files
generate_command_breadcrumb() {
    local file_name="$1"
    local previous_file next_file
    
    # Get file order in commands directory
    previous_file=$(get_previous_file "$COMMANDS_DIR" "$file_name")
    next_file=$(get_next_file "$COMMANDS_DIR" "$file_name")
    
    local previous_link="[Return to Commands Index](index.md)"
    local next_link="[Return to Commands Index](index.md)"
    
    if [[ -n "$previous_file" ]]; then
        local prev_action=$(get_action_verb "$previous_file")
        local prev_desc=$(get_file_description "$previous_file")
        previous_link="[Previous: $prev_action $prev_desc]($previous_file.md)"
    fi
    
    if [[ -n "$next_file" ]]; then
        local next_action=$(get_action_verb "$next_file")
        local next_desc=$(get_file_description "$next_file")
        next_link="[Next: $next_action $next_desc]($next_file.md)"
    fi
    
    echo "$previous_link | [Return to Commands Index](index.md) | [Master PRINCIPLES.md](../docs/PRINCIPLES.md) | $next_link"
}

# Generate breadcrumb for agent files
generate_agent_breadcrumb() {
    local file_name="$1"
    local previous_file next_file
    
    previous_file=$(get_previous_file "$AGENTS_DIR" "$file_name")
    next_file=$(get_next_file "$AGENTS_DIR" "$file_name")
    
    local previous_link="[Return to hub for navigation](../docs/index.md)"
    local next_link="[Study agent documentation for deployment](../docs/agents-documentation/README.md)"
    
    if [[ -n "$previous_file" ]]; then
        local prev_action=$(get_action_verb "$previous_file")
        local prev_desc=$(get_file_description "$previous_file")
        previous_link="[Previous: $prev_action $prev_desc]($previous_file.md)"
    fi
    
    if [[ -n "$next_file" ]]; then
        local next_action=$(get_action_verb "$next_file")
        local next_desc=$(get_file_description "$next_file")
        next_link="[Next: $next_action $next_desc]($next_file.md)"
    fi
    
    echo "$previous_link | [Return to hub for navigation](../docs/index.md) | [Study PRINCIPLES.md for framework](../docs/PRINCIPLES.md) | $next_link"
}

# Generate breadcrumb for docs files
generate_docs_breadcrumb() {
    local file_name="$1"
    
    case "$file_name" in
        "index")
            echo "[Previous: Study index.md for navigation](index.md) | [Return to hub for navigation](index.md) | [Study PRINCIPLES.md for framework](PRINCIPLES.md) | [Next: Browse commands index for tools](../commands/index.md)"
            ;;
        "PRINCIPLES")
            echo "[Previous: Study index.md for navigation](index.md) | [Return to hub for navigation](index.md) | [Study PRINCIPLES.md for framework](PRINCIPLES.md) | [Next: Browse commands index for tools](../commands/index.md)"
            ;;
        *)
            echo "[Previous: Study PRINCIPLES.md for framework](PRINCIPLES.md) | [Return to hub for navigation](index.md) | [Study PRINCIPLES.md for framework](PRINCIPLES.md) | [Next: Browse commands index for tools](../commands/index.md)"
            ;;
    esac
}

# Generate breadcrumb for component files
generate_component_breadcrumb() {
    local file_name="$1"
    
    if [[ "$file_name" == "README" ]]; then
        echo "[Navigate to Documentation Hub](../index.md) | [Study organization.md for structure](../principles/organization.md) | [Review PRINCIPLES.md for framework](../PRINCIPLES.md)"
    else
        echo "[Navigate to Components Hub](README.md) | [Study organization.md for structure](../principles/organization.md) | [Review PRINCIPLES.md for framework](../PRINCIPLES.md)"
    fi
}

# Generate breadcrumb for planning files
generate_planning_breadcrumb() {
    local file_name="$1"
    
    case "$file_name" in
        "TICKET_REGISTRY")
            echo "[Previous: Study TICKET_METHODOLOGY.md for methodology](TICKET_METHODOLOGY.md) | [Return to hub for navigation](../index.md) | [Review PRINCIPLES.md for framework](../PRINCIPLES.md) | [Next: Browse commands for tools](../../commands/index.md)"
            ;;
        *)
            echo "[Navigate to Planning Hub](TICKET_REGISTRY.md) | [Return to hub for navigation](../index.md) | [Review PRINCIPLES.md for framework](../PRINCIPLES.md)"
            ;;
    esac
}

# Generate breadcrumb for ticket files
generate_ticket_breadcrumb() {
    local file_name="$1"
    local relative_dir="$2"
    
    # Determine proper hub path based on depth
    local hub_path="../../../index.md"
    local principles_path="../../../PRINCIPLES.md"
    
    if [[ "$relative_dir" == *"components"* ]]; then
        hub_path="../../index.md"
        principles_path="../../PRINCIPLES.md"
    fi
    
    echo "[Navigate to Ticket Registry](../TICKET_REGISTRY.md) | [Return to hub for navigation]($hub_path) | [Review PRINCIPLES.md for framework]($principles_path)"
}

# Generate breadcrumb for principle files
generate_principle_breadcrumb() {
    local file_name="$1"
    
    echo "[Navigate to Documentation Hub](../index.md) | [Study PRINCIPLES.md for framework](../PRINCIPLES.md) | [Browse principles directory](./)"
}

# Generate default breadcrumb
generate_default_breadcrumb() {
    local file_name="$1"
    local relative_dir="$2"
    
    echo "[Navigate to Documentation Hub](../index.md) | [Study PRINCIPLES.md for framework](../PRINCIPLES.md) | [Return to directory](./)"
}

# Get previous file in directory order
get_previous_file() {
    local dir="$1"
    local current_file="$2"
    
    if [[ ! -d "$dir" ]]; then
        return
    fi
    
    local files=($(ls "$dir"/*.md 2>/dev/null | xargs -n1 basename | sed 's/\.md$//' | sort))
    local current_index=-1
    
    for i in "${!files[@]}"; do
        if [[ "${files[$i]}" == "$current_file" ]]; then
            current_index=$i
            break
        fi
    done
    
    if [[ $current_index -gt 0 ]]; then
        echo "${files[$((current_index - 1))]}"
    fi
}

# Get next file in directory order
get_next_file() {
    local dir="$1"
    local current_file="$2"
    
    if [[ ! -d "$dir" ]]; then
        return
    fi
    
    local files=($(ls "$dir"/*.md 2>/dev/null | xargs -n1 basename | sed 's/\.md$//' | sort))
    local current_index=-1
    
    for i in "${!files[@]}"; do
        if [[ "${files[$i]}" == "$current_file" ]]; then
            current_index=$i
            break
        fi
    done
    
    if [[ $current_index -ge 0 && $current_index -lt $((${#files[@]} - 1)) ]]; then
        echo "${files[$((current_index + 1))]}"
    fi
}

# Function already defined above

# Get human-readable description for file
get_file_description() {
    local file_name="$1"
    
    # Convert filename to readable description
    local desc=$(echo "$file_name" | sed 's/-/ /g' | sed 's/_/ /g')
    
    # Capitalize first word
    desc=$(echo "${desc}" | sed 's/^\(.\)/\U\1/')
    
    echo "$desc"
}

# Main execution
main() {
    local target_file="${1:-}"
    
    if [[ -z "$target_file" ]]; then
        echo "Usage: $0 <file_path>"
        echo "Generate standardized breadcrumb for specified file"
        exit 1
    fi
    
    if [[ ! -f "$target_file" ]]; then
        echo "Error: File $target_file does not exist"
        exit 1
    fi
    
    local breadcrumb
    breadcrumb=$(generate_breadcrumb "$target_file")
    
    echo "Generated breadcrumb for $target_file:"
    echo "$breadcrumb"
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi