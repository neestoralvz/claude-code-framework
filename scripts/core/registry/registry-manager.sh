#!/bin/bash

# Registry Manager for Claude Code Framework
# CRUD operations for all registries with validation and backup

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REGISTRIES_DIR="$SCRIPT_DIR/registries"
BACKUP_DIR="$SCRIPT_DIR/backups/registries"
LOGS_DIR="$(dirname "$SCRIPT_DIR")/logs/registry"

# Ensure directories exist
mkdir -p "$BACKUP_DIR" "$LOGS_DIR"

# Function to log messages
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOGS_DIR/registry.log"
}

# Function to validate registry file
validate_registry() {
    local registry_file="$1"
    
    if [[ ! -f "$registry_file" ]]; then
        log "ERROR" "Registry file not found: $registry_file"
        return 1
    fi
    
    # Validate JSON syntax
    if ! jq empty "$registry_file" 2>/dev/null; then
        log "ERROR" "Invalid JSON in registry: $registry_file"
        return 1
    fi
    
    # Check required fields
    local version=$(jq -r '.version // "missing"' "$registry_file")
    local registry_type=$(jq -r '.registry_type // "missing"' "$registry_file")
    
    if [[ "$version" == "missing" ]] || [[ "$registry_type" == "missing" ]]; then
        log "ERROR" "Missing required fields (version, registry_type) in: $registry_file"
        return 1
    fi
    
    log "INFO" "Registry validation passed: $registry_file"
    return 0
}

# Function to backup registry
backup_registry() {
    local registry_name="$1"
    local registry_file="$REGISTRIES_DIR/$registry_name.json"
    
    if [[ ! -f "$registry_file" ]]; then
        log "WARN" "Registry file not found for backup: $registry_file"
        return 1
    fi
    
    local backup_file="$BACKUP_DIR/${registry_name}_$(date +%Y%m%d_%H%M%S).json"
    cp "$registry_file" "$backup_file"
    log "INFO" "Registry backed up: $backup_file"
}

# Function to update timestamp in registry
update_timestamp() {
    local registry_file="$1"
    local temp_file="${registry_file}.tmp"
    
    jq --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" '.last_updated = $timestamp' "$registry_file" > "$temp_file"
    mv "$temp_file" "$registry_file"
}

# Function to create registry entry
create_entry() {
    local registry_name="$1"
    local entry_id="$2"
    local entry_data="$3"
    
    local registry_file="$REGISTRIES_DIR/$registry_name.json"
    
    if [[ ! -f "$registry_file" ]]; then
        log "ERROR" "Registry not found: $registry_name"
        return 1
    fi
    
    # Backup before modification
    backup_registry "$registry_name"
    
    # Determine the correct path based on registry type
    local data_path
    case "$registry_name" in
        "components") data_path=".components" ;;
        "agents") data_path=".agents" ;;
        "services") data_path=".services" ;;
        "configurations") data_path=".configurations" ;;
        *) 
            log "ERROR" "Unknown registry type: $registry_name"
            return 1
            ;;
    esac
    
    # Check if entry already exists
    if jq -e "${data_path}.\"$entry_id\"" "$registry_file" >/dev/null 2>&1; then
        log "ERROR" "Entry already exists: $entry_id in $registry_name"
        return 1
    fi
    
    # Add entry
    local temp_file="${registry_file}.tmp"
    echo "$entry_data" | jq --arg id "$entry_id" --argjson entry . \
        "${data_path}.\$id = \$entry" "$registry_file" > "$temp_file"
    
    if validate_registry "$temp_file"; then
        update_timestamp "$temp_file"
        mv "$temp_file" "$registry_file"
        log "INFO" "Entry created: $entry_id in $registry_name"
        return 0
    else
        rm -f "$temp_file"
        log "ERROR" "Failed to create entry due to validation error"
        return 1
    fi
}

# Function to read registry or entry
read_entry() {
    local registry_name="$1"
    local entry_id="${2:-}"
    
    local registry_file="$REGISTRIES_DIR/$registry_name.json"
    
    if [[ ! -f "$registry_file" ]]; then
        log "ERROR" "Registry not found: $registry_name"
        return 1
    fi
    
    if [[ -n "$entry_id" ]]; then
        # Read specific entry
        local data_path
        case "$registry_name" in
            "components") data_path=".components" ;;
            "agents") data_path=".agents" ;;
            "services") data_path=".services" ;;
            "configurations") data_path=".configurations" ;;
        esac
        
        jq "${data_path}.\"$entry_id\"" "$registry_file"
    else
        # Read entire registry
        jq . "$registry_file"
    fi
}

# Function to update registry entry
update_entry() {
    local registry_name="$1"
    local entry_id="$2"
    local entry_data="$3"
    
    local registry_file="$REGISTRIES_DIR/$registry_name.json"
    
    if [[ ! -f "$registry_file" ]]; then
        log "ERROR" "Registry not found: $registry_name"
        return 1
    fi
    
    # Backup before modification
    backup_registry "$registry_name"
    
    local data_path
    case "$registry_name" in
        "components") data_path=".components" ;;
        "agents") data_path=".agents" ;;
        "services") data_path=".services" ;;
        "configurations") data_path=".configurations" ;;
        *) 
            log "ERROR" "Unknown registry type: $registry_name"
            return 1
            ;;
    esac
    
    # Check if entry exists
    if ! jq -e "${data_path}.\"$entry_id\"" "$registry_file" >/dev/null 2>&1; then
        log "ERROR" "Entry not found: $entry_id in $registry_name"
        return 1
    fi
    
    # Update entry
    local temp_file="${registry_file}.tmp"
    echo "$entry_data" | jq --arg id "$entry_id" --argjson entry . \
        "${data_path}.\$id = \$entry" "$registry_file" > "$temp_file"
    
    if validate_registry "$temp_file"; then
        update_timestamp "$temp_file"
        mv "$temp_file" "$registry_file"
        log "INFO" "Entry updated: $entry_id in $registry_name"
        return 0
    else
        rm -f "$temp_file"
        log "ERROR" "Failed to update entry due to validation error"
        return 1
    fi
}

# Function to delete registry entry
delete_entry() {
    local registry_name="$1"
    local entry_id="$2"
    
    local registry_file="$REGISTRIES_DIR/$registry_name.json"
    
    if [[ ! -f "$registry_file" ]]; then
        log "ERROR" "Registry not found: $registry_name"
        return 1
    fi
    
    # Backup before modification
    backup_registry "$registry_name"
    
    local data_path
    case "$registry_name" in
        "components") data_path=".components" ;;
        "agents") data_path=".agents" ;;
        "services") data_path=".services" ;;
        "configurations") data_path=".configurations" ;;
        *) 
            log "ERROR" "Unknown registry type: $registry_name"
            return 1
            ;;
    esac
    
    # Check if entry exists
    if ! jq -e "${data_path}.\"$entry_id\"" "$registry_file" >/dev/null 2>&1; then
        log "ERROR" "Entry not found: $entry_id in $registry_name"
        return 1
    fi
    
    # Delete entry
    local temp_file="${registry_file}.tmp"
    jq "del(${data_path}.\"$entry_id\")" "$registry_file" > "$temp_file"
    
    if validate_registry "$temp_file"; then
        update_timestamp "$temp_file"
        mv "$temp_file" "$registry_file"
        log "INFO" "Entry deleted: $entry_id in $registry_name"
        return 0
    else
        rm -f "$temp_file"
        log "ERROR" "Failed to delete entry due to validation error"
        return 1
    fi
}

# Function to search across registries
search_registries() {
    local query="$1"
    
    log "INFO" "Searching registries for: $query"
    
    for registry_file in "$REGISTRIES_DIR"/*.json; do
        if [[ -f "$registry_file" ]]; then
            local registry_name=$(basename "$registry_file" .json)
            echo "=== $registry_name ==="
            
            # Search in multiple fields
            jq -r --arg query "$query" '
                (.components // .agents // .services // .configurations) | 
                to_entries[] | 
                select(.key | contains($query) or 
                       .value.name // "" | contains($query) or 
                       .value.description // "" | contains($query) or 
                       .value.specialization // "" | contains($query)) |
                "\(.key): \(.value.name // .value.description // "")"
            ' "$registry_file" 2>/dev/null || true
            echo
        fi
    done
}

# Function to list all registries
list_registries() {
    echo "Available registries:"
    for registry_file in "$REGISTRIES_DIR"/*.json; do
        if [[ -f "$registry_file" ]]; then
            local registry_name=$(basename "$registry_file" .json)
            local registry_type=$(jq -r '.registry_type' "$registry_file")
            local last_updated=$(jq -r '.last_updated' "$registry_file")
            echo "  $registry_name ($registry_type) - updated: $last_updated"
        fi
    done
}

# Main execution logic
main() {
    local command="$1"
    shift
    
    case "$command" in
        "create")
            if [[ $# -lt 3 ]]; then
                echo "Usage: $0 create <registry> <entry_id> <entry_data_json>"
                exit 1
            fi
            create_entry "$1" "$2" "$3"
            ;;
        "read")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 read <registry> [entry_id]"
                exit 1
            fi
            read_entry "$1" "${2:-}"
            ;;
        "update")
            if [[ $# -lt 3 ]]; then
                echo "Usage: $0 update <registry> <entry_id> <entry_data_json>"
                exit 1
            fi
            update_entry "$1" "$2" "$3"
            ;;
        "delete")
            if [[ $# -lt 2 ]]; then
                echo "Usage: $0 delete <registry> <entry_id>"
                exit 1
            fi
            delete_entry "$1" "$2"
            ;;
        "search")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 search <query>"
                exit 1
            fi
            search_registries "$1"
            ;;
        "list")
            list_registries
            ;;
        "validate")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 validate <registry>"
                exit 1
            fi
            validate_registry "$REGISTRIES_DIR/$1.json"
            ;;
        "backup")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 backup <registry>"
                exit 1
            fi
            backup_registry "$1"
            ;;
        *)
            echo "Usage: $0 {create|read|update|delete|search|list|validate|backup} [args...]"
            echo "Examples:"
            echo "  $0 list"
            echo "  $0 read agents agent-architect"
            echo "  $0 search 'validation'"
            echo "  $0 validate components"
            echo "  $0 backup agents"
            exit 1
            ;;
    esac
}

# Execute main function with all arguments
main "$@"