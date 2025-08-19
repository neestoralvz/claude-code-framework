#!/bin/bash

# Password Manager for Claude Code Framework
# Secure password and secret management with encryption

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_DIR="$SCRIPT_DIR/vault"
CRYPTO_ENGINE="$SCRIPT_DIR/crypto-engine.sh"
LOGS_DIR="$(dirname "$SCRIPT_DIR")/logs/password"
SESSION_DIR="/tmp/claude_session_$$"
SESSION_TIMEOUT=300  # 5 minutes

# Ensure directories exist
mkdir -p "$VAULT_DIR" "$LOGS_DIR" "$SESSION_DIR"
chmod 700 "$VAULT_DIR" "$SESSION_DIR"

# Clean up session on exit
trap 'rm -rf "$SESSION_DIR" 2>/dev/null || true' EXIT

# Function to log password manager events
log_event() {
    local level="$1"
    local action="$2"
    local detail="${3:-}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local user=$(whoami)
    echo "[$timestamp] [$level] [USER:$user] $action $detail" >> "$LOGS_DIR/password_manager.log"
}

# Function to get master password securely
get_master_password() {
    local prompt="${1:-Enter master password: }"
    
    # Check if we have a valid session
    local session_file="$SESSION_DIR/master_key"
    if [[ -f "$session_file" ]]; then
        local session_time=$(stat -f %m "$session_file" 2>/dev/null || echo "0")
        local current_time=$(date +%s)
        
        if [[ $((current_time - session_time)) -lt $SESSION_TIMEOUT ]]; then
            cat "$session_file"
            return 0
        else
            rm -f "$session_file"
        fi
    fi
    
    # Get password from user
    echo -n "$prompt" >&2
    read -s password
    echo >&2
    
    # Validate password strength
    if ! "$CRYPTO_ENGINE" validate-password "$password" >/dev/null 2>&1; then
        log_event "WARN" "WEAK_PASSWORD_ATTEMPT"
        echo "Warning: Password does not meet complexity requirements" >&2
    fi
    
    # Cache password for session
    echo "$password" > "$session_file"
    chmod 600 "$session_file"
    
    echo "$password"
}

# Function to get vault file path
get_vault_file() {
    local category="$1"
    echo "$VAULT_DIR/${category}.vault"
}

# Function to load vault
load_vault() {
    local category="$1"
    local master_password="$2"
    local vault_file=$(get_vault_file "$category")
    
    if [[ ! -f "$vault_file" ]]; then
        # Create empty vault
        echo '{"version":"1.0.0","category":"'$category'","entries":{}}' > "$vault_file"
        chmod 600 "$vault_file"
    fi
    
    # Decrypt vault
    if "$CRYPTO_ENGINE" decrypt-file "$vault_file" "$master_password" 2>/dev/null; then
        return 0
    else
        log_event "ERROR" "VAULT_DECRYPT_FAILED" "category:$category"
        echo "Failed to decrypt vault. Invalid password or corrupted data." >&2
        return 1
    fi
}

# Function to save vault
save_vault() {
    local category="$1"
    local vault_data="$2"
    local master_password="$3"
    local vault_file=$(get_vault_file "$category")
    local temp_file="${vault_file}.tmp"
    
    # Create temporary file with vault data
    echo "$vault_data" > "$temp_file"
    
    # Encrypt and save
    if "$CRYPTO_ENGINE" encrypt-file "$temp_file" "$vault_file" "$master_password"; then
        rm -f "$temp_file"
        log_event "INFO" "VAULT_SAVED" "category:$category"
        return 0
    else
        rm -f "$temp_file"
        log_event "ERROR" "VAULT_SAVE_FAILED" "category:$category"
        return 1
    fi
}

# Function to store password
store_password() {
    local category="$1"
    local key="$2"
    local value="$3"
    local description="${4:-}"
    
    log_event "INFO" "STORE_ATTEMPT" "category:$category key:$key"
    
    local master_password=$(get_master_password)
    local vault_data
    
    if ! vault_data=$(load_vault "$category" "$master_password"); then
        return 1
    fi
    
    # Create entry
    local entry=$(jq -n \
        --arg value "$value" \
        --arg description "$description" \
        --arg created "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
        --arg modified "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
        '{
            value: $value,
            description: $description,
            created: $created,
            modified: $modified,
            accessed: null
        }')
    
    # Add to vault
    local updated_vault=$(echo "$vault_data" | jq --arg key "$key" --argjson entry "$entry" \
        '.entries[$key] = $entry')
    
    if save_vault "$category" "$updated_vault" "$master_password"; then
        log_event "INFO" "STORE_SUCCESS" "category:$category key:$key"
        echo "Password stored successfully: $category/$key"
        return 0
    else
        log_event "ERROR" "STORE_FAILED" "category:$category key:$key"
        return 1
    fi
}

# Function to retrieve password
retrieve_password() {
    local category="$1"
    local key="$2"
    local show_details="${3:-false}"
    
    log_event "INFO" "RETRIEVE_ATTEMPT" "category:$category key:$key"
    
    local master_password=$(get_master_password)
    local vault_data
    
    if ! vault_data=$(load_vault "$category" "$master_password"); then
        return 1
    fi
    
    # Get entry
    local entry=$(echo "$vault_data" | jq -r --arg key "$key" '.entries[$key] // empty')
    
    if [[ -z "$entry" ]] || [[ "$entry" == "null" ]]; then
        log_event "WARN" "RETRIEVE_NOT_FOUND" "category:$category key:$key"
        echo "Password not found: $category/$key" >&2
        return 1
    fi
    
    # Update access time
    local updated_entry=$(echo "$entry" | jq --arg accessed "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
        '.accessed = $accessed')
    local updated_vault=$(echo "$vault_data" | jq --arg key "$key" --argjson entry "$updated_entry" \
        '.entries[$key] = $entry')
    
    # Save updated vault (async to avoid delay)
    (save_vault "$category" "$updated_vault" "$master_password" &)
    
    if [[ "$show_details" == "true" ]]; then
        echo "$entry" | jq .
    else
        echo "$entry" | jq -r '.value'
    fi
    
    log_event "INFO" "RETRIEVE_SUCCESS" "category:$category key:$key"
    return 0
}

# Function to list passwords
list_passwords() {
    local category="${1:-}"
    
    log_event "INFO" "LIST_ATTEMPT" "category:${category:-all}"
    
    if [[ -n "$category" ]]; then
        # List specific category
        local master_password=$(get_master_password)
        local vault_data
        
        if vault_data=$(load_vault "$category" "$master_password"); then
            echo "=== $category ==="
            echo "$vault_data" | jq -r '.entries | to_entries[] | "\(.key): \(.value.description // "No description")"'
        fi
    else
        # List all categories
        echo "Available password categories:"
        for vault_file in "$VAULT_DIR"/*.vault; do
            if [[ -f "$vault_file" ]]; then
                local category_name=$(basename "$vault_file" .vault)
                echo "  $category_name"
            fi
        done
    fi
}

# Function to delete password
delete_password() {
    local category="$1"
    local key="$2"
    
    log_event "INFO" "DELETE_ATTEMPT" "category:$category key:$key"
    
    local master_password=$(get_master_password)
    local vault_data
    
    if ! vault_data=$(load_vault "$category" "$master_password"); then
        return 1
    fi
    
    # Check if entry exists
    if ! echo "$vault_data" | jq -e --arg key "$key" '.entries[$key]' >/dev/null; then
        log_event "WARN" "DELETE_NOT_FOUND" "category:$category key:$key"
        echo "Password not found: $category/$key" >&2
        return 1
    fi
    
    # Remove entry
    local updated_vault=$(echo "$vault_data" | jq --arg key "$key" 'del(.entries[$key])')
    
    if save_vault "$category" "$updated_vault" "$master_password"; then
        log_event "INFO" "DELETE_SUCCESS" "category:$category key:$key"
        echo "Password deleted: $category/$key"
        return 0
    else
        log_event "ERROR" "DELETE_FAILED" "category:$category key:$key"
        return 1
    fi
}

# Function to rotate password
rotate_password() {
    local category="$1"
    local key="$2"
    local new_value="${3:-}"
    
    log_event "INFO" "ROTATE_ATTEMPT" "category:$category key:$key"
    
    # Generate new password if not provided
    if [[ -z "$new_value" ]]; then
        new_value=$("$CRYPTO_ENGINE" generate-password 20)
        echo "Generated new password: $new_value"
    fi
    
    local master_password=$(get_master_password)
    local vault_data
    
    if ! vault_data=$(load_vault "$category" "$master_password"); then
        return 1
    fi
    
    # Get existing entry
    local existing_entry=$(echo "$vault_data" | jq --arg key "$key" '.entries[$key] // {}')
    
    if [[ "$existing_entry" == "{}" ]]; then
        log_event "WARN" "ROTATE_NOT_FOUND" "category:$category key:$key"
        echo "Password not found: $category/$key" >&2
        return 1
    fi
    
    # Update entry
    local updated_entry=$(echo "$existing_entry" | jq \
        --arg value "$new_value" \
        --arg modified "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
        '.value = $value | .modified = $modified')
    
    local updated_vault=$(echo "$vault_data" | jq --arg key "$key" --argjson entry "$updated_entry" \
        '.entries[$key] = $entry')
    
    if save_vault "$category" "$updated_vault" "$master_password"; then
        log_event "INFO" "ROTATE_SUCCESS" "category:$category key:$key"
        echo "Password rotated successfully: $category/$key"
        return 0
    else
        log_event "ERROR" "ROTATE_FAILED" "category:$category key:$key"
        return 1
    fi
}

# Function to backup vault
backup_vault() {
    local category="${1:-all}"
    local backup_dir="$SCRIPT_DIR/backups/vault"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    
    mkdir -p "$backup_dir"
    
    if [[ "$category" == "all" ]]; then
        # Backup all vaults
        local archive_file="$backup_dir/vault_backup_${timestamp}.tar.gz"
        tar -czf "$archive_file" -C "$VAULT_DIR" .
        echo "All vaults backed up to: $archive_file"
        log_event "INFO" "BACKUP_ALL_SUCCESS" "archive:$archive_file"
    else
        # Backup specific vault
        local vault_file=$(get_vault_file "$category")
        if [[ -f "$vault_file" ]]; then
            local backup_file="$backup_dir/${category}_${timestamp}.vault"
            cp "$vault_file" "$backup_file"
            echo "Vault backed up: $backup_file"
            log_event "INFO" "BACKUP_SUCCESS" "category:$category backup:$backup_file"
        else
            echo "Vault not found: $category" >&2
            return 1
        fi
    fi
}

# Function to change master password
change_master_password() {
    log_event "INFO" "MASTER_PASSWORD_CHANGE_ATTEMPT"
    
    echo "Changing master password for all vaults..." >&2
    
    local old_password=$(get_master_password "Enter current master password: ")
    echo -n "Enter new master password: " >&2
    read -s new_password
    echo >&2
    echo -n "Confirm new master password: " >&2
    read -s confirm_password
    echo >&2
    
    if [[ "$new_password" != "$confirm_password" ]]; then
        echo "Passwords do not match" >&2
        log_event "ERROR" "MASTER_PASSWORD_CHANGE_MISMATCH"
        return 1
    fi
    
    # Validate new password
    if ! "$CRYPTO_ENGINE" validate-password "$new_password"; then
        echo "New password does not meet complexity requirements" >&2
        log_event "ERROR" "MASTER_PASSWORD_CHANGE_WEAK"
        return 1
    fi
    
    # Re-encrypt all vaults
    local success_count=0
    local total_count=0
    
    for vault_file in "$VAULT_DIR"/*.vault; do
        if [[ -f "$vault_file" ]]; then
            local category=$(basename "$vault_file" .vault)
            ((total_count++))
            
            echo "Re-encrypting vault: $category" >&2
            
            local vault_data
            if vault_data=$(load_vault "$category" "$old_password"); then
                if save_vault "$category" "$vault_data" "$new_password"; then
                    ((success_count++))
                    echo "  ✓ $category" >&2
                else
                    echo "  ✗ $category (save failed)" >&2
                fi
            else
                echo "  ✗ $category (decrypt failed)" >&2
            fi
        fi
    done
    
    # Clear session
    rm -rf "$SESSION_DIR"
    
    if [[ $success_count -eq $total_count ]]; then
        echo "Master password changed successfully for all $total_count vaults" >&2
        log_event "INFO" "MASTER_PASSWORD_CHANGE_SUCCESS" "vaults:$total_count"
        return 0
    else
        echo "Master password change partially failed: $success_count/$total_count vaults updated" >&2
        log_event "ERROR" "MASTER_PASSWORD_CHANGE_PARTIAL" "success:$success_count total:$total_count"
        return 1
    fi
}

# Main execution logic
main() {
    local command="$1"
    shift
    
    case "$command" in
        "store")
            if [[ $# -lt 3 ]]; then
                echo "Usage: $0 store <category> <key> <value> [description]"
                exit 1
            fi
            store_password "$1" "$2" "$3" "${4:-}"
            ;;
        "retrieve")
            if [[ $# -lt 2 ]]; then
                echo "Usage: $0 retrieve <category> <key> [show_details]"
                exit 1
            fi
            retrieve_password "$1" "$2" "${3:-false}"
            ;;
        "list")
            list_passwords "${1:-}"
            ;;
        "delete")
            if [[ $# -lt 2 ]]; then
                echo "Usage: $0 delete <category> <key>"
                exit 1
            fi
            delete_password "$1" "$2"
            ;;
        "rotate")
            if [[ $# -lt 2 ]]; then
                echo "Usage: $0 rotate <category> <key> [new_value]"
                exit 1
            fi
            rotate_password "$1" "$2" "${3:-}"
            ;;
        "generate")
            "$CRYPTO_ENGINE" generate-password "${1:-16}"
            ;;
        "backup")
            backup_vault "${1:-all}"
            ;;
        "change-master")
            change_master_password
            ;;
        "clear-session")
            rm -rf "$SESSION_DIR"
            echo "Session cleared"
            ;;
        *)
            echo "Usage: $0 {store|retrieve|list|delete|rotate|generate|backup|change-master|clear-session} [args...]"
            echo "Examples:"
            echo "  $0 store api github_token ghp_xyz123 'GitHub API token'"
            echo "  $0 retrieve api github_token"
            echo "  $0 list api"
            echo "  $0 list"
            echo "  $0 rotate api github_token"
            echo "  $0 delete api old_token"
            echo "  $0 generate 20"
            echo "  $0 backup api"
            echo "  $0 change-master"
            exit 1
            ;;
    esac
}

# Execute main function with all arguments
main "$@"