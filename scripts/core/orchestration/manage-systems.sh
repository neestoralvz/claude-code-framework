#!/bin/bash

# System Management Script for Claude Code Framework
# Centralized management of hooks, registries, and password systems

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_ROOT="$(dirname "$SCRIPT_DIR")"
LOGS_DIR="$CLAUDE_ROOT/logs/systems"

# Ensure logs directory exists
mkdir -p "$LOGS_DIR"

# Function to log messages
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOGS_DIR/systems.log"
}

# Function to check system status
check_status() {
    local system="${1:-all}"
    
    log "INFO" "Checking system status: $system"
    
    case "$system" in
        "hooks"|"all")
            echo "=== Hooks System ==="
            if [[ -f "$SCRIPT_DIR/hooks-registry.json" ]]; then
                echo "✓ Hooks registry exists"
                local enabled_hooks=$(jq -r '.hooks | to_entries[] | .value | to_entries[] | select(.value.enabled == true) | length' "$SCRIPT_DIR/hooks-registry.json" | wc -l)
                echo "✓ Enabled hooks: $enabled_hooks"
            else
                echo "✗ Hooks registry missing"
            fi
            
            if [[ -x "$SCRIPT_DIR/hooks-executor.sh" ]]; then
                echo "✓ Hooks executor available"
            else
                echo "✗ Hooks executor missing or not executable"
            fi
            ;;
    esac
    
    case "$system" in
        "registry"|"all")
            echo "=== Registry System ==="
            if [[ -d "$SCRIPT_DIR/registries" ]]; then
                echo "✓ Registries directory exists"
                local registry_count=$(find "$SCRIPT_DIR/registries" -name "*.json" | wc -l)
                echo "✓ Registry files: $registry_count"
            else
                echo "✗ Registries directory missing"
            fi
            
            if [[ -x "$SCRIPT_DIR/registry-manager.sh" ]]; then
                echo "✓ Registry manager available"
            else
                echo "✗ Registry manager missing or not executable"
            fi
            ;;
    esac
    
    case "$system" in
        "password"|"all")
            echo "=== Password System ==="
            if [[ -d "$SCRIPT_DIR/vault" ]]; then
                echo "✓ Vault directory exists"
                local vault_perms=$(stat -f %A "$SCRIPT_DIR/vault" 2>/dev/null || echo "unknown")
                if [[ "$vault_perms" == "700" ]]; then
                    echo "✓ Vault permissions secure (700)"
                else
                    echo "⚠ Vault permissions: $vault_perms (should be 700)"
                fi
            else
                echo "✗ Vault directory missing"
            fi
            
            if [[ -x "$SCRIPT_DIR/password-manager.sh" ]]; then
                echo "✓ Password manager available"
            else
                echo "✗ Password manager missing or not executable"
            fi
            
            if [[ -x "$SCRIPT_DIR/crypto-engine.sh" ]]; then
                echo "✓ Crypto engine available"
            else
                echo "✗ Crypto engine missing or not executable"
            fi
            ;;
    esac
}

# Function to check system health
check_health() {
    log "INFO" "Performing system health check"
    
    local health_score=0
    local total_checks=0
    
    echo "=== System Health Check ==="
    
    # Check dependencies
    ((total_checks++))
    if command -v jq >/dev/null 2>&1; then
        echo "✓ jq available"
        ((health_score++))
    else
        echo "✗ jq missing"
    fi
    
    ((total_checks++))
    if command -v openssl >/dev/null 2>&1; then
        echo "✓ openssl available"
        ((health_score++))
    else
        echo "✗ openssl missing"
    fi
    
    # Check file permissions
    ((total_checks++))
    if [[ -d "$SCRIPT_DIR/vault" ]]; then
        local vault_perms=$(stat -f %A "$SCRIPT_DIR/vault" 2>/dev/null || echo "000")
        if [[ "$vault_perms" == "700" ]]; then
            echo "✓ Vault permissions secure"
            ((health_score++))
        else
            echo "✗ Vault permissions insecure: $vault_perms"
        fi
    else
        echo "⚠ Vault directory not found"
    fi
    
    # Check registry integrity
    ((total_checks++))
    local registry_valid=true
    for registry_file in "$SCRIPT_DIR/registries"/*.json; do
        if [[ -f "$registry_file" ]]; then
            if ! jq empty "$registry_file" 2>/dev/null; then
                echo "✗ Invalid JSON in $(basename "$registry_file")"
                registry_valid=false
            fi
        fi
    done
    
    if [[ "$registry_valid" == "true" ]]; then
        echo "✓ All registries valid"
        ((health_score++))
    fi
    
    # Check hooks configuration
    ((total_checks++))
    if [[ -f "$CLAUDE_ROOT/settings.json" ]]; then
        if jq -e '.hooks' "$CLAUDE_ROOT/settings.json" >/dev/null 2>&1; then
            echo "✓ Hooks configured in settings"
            ((health_score++))
        else
            echo "⚠ No hooks configuration in settings"
        fi
    else
        echo "✗ settings.json not found"
    fi
    
    # Calculate health percentage
    local health_percentage=$((health_score * 100 / total_checks))
    echo ""
    echo "Health Score: $health_score/$total_checks ($health_percentage%)"
    
    if [[ $health_percentage -ge 80 ]]; then
        echo "System Health: GOOD"
        log "INFO" "System health check passed: $health_percentage%"
    elif [[ $health_percentage -ge 60 ]]; then
        echo "System Health: FAIR"
        log "WARN" "System health check fair: $health_percentage%"
    else
        echo "System Health: POOR"
        log "ERROR" "System health check failed: $health_percentage%"
    fi
}

# Function to enable system
enable_system() {
    local system="$1"
    
    log "INFO" "Enabling system: $system"
    
    case "$system" in
        "hooks")
            # Update hooks registry to enable all hooks
            if [[ -f "$SCRIPT_DIR/hooks-registry.json" ]]; then
                jq '.hooks | to_entries[] | .value | to_entries[] | .value.enabled = true' \
                    "$SCRIPT_DIR/hooks-registry.json" > "${SCRIPT_DIR}/hooks-registry.json.tmp"
                mv "${SCRIPT_DIR}/hooks-registry.json.tmp" "$SCRIPT_DIR/hooks-registry.json"
                echo "Hooks system enabled"
            else
                echo "Error: Hooks registry not found"
                return 1
            fi
            ;;
        "registry")
            echo "Registry system is always enabled"
            ;;
        "password")
            # Set environment variable
            export CLAUDE_PASSWORD_MANAGER_ENABLED=true
            echo "Password system enabled"
            ;;
        *)
            echo "Unknown system: $system"
            return 1
            ;;
    esac
}

# Function to disable system
disable_system() {
    local system="$1"
    
    log "INFO" "Disabling system: $system"
    
    case "$system" in
        "hooks")
            # Update hooks registry to disable all hooks
            if [[ -f "$SCRIPT_DIR/hooks-registry.json" ]]; then
                jq '.hooks | to_entries[] | .value | to_entries[] | .value.enabled = false' \
                    "$SCRIPT_DIR/hooks-registry.json" > "${SCRIPT_DIR}/hooks-registry.json.tmp"
                mv "${SCRIPT_DIR}/hooks-registry.json.tmp" "$SCRIPT_DIR/hooks-registry.json"
                echo "Hooks system disabled"
            else
                echo "Error: Hooks registry not found"
                return 1
            fi
            ;;
        "registry")
            echo "Registry system cannot be disabled"
            return 1
            ;;
        "password")
            # Unset environment variable
            export CLAUDE_PASSWORD_MANAGER_ENABLED=false
            echo "Password system disabled"
            ;;
        *)
            echo "Unknown system: $system"
            return 1
            ;;
    esac
}

# Function to initialize systems
init_systems() {
    log "INFO" "Initializing all systems"
    
    echo "Initializing Claude Code systems..."
    
    # Create necessary directories
    mkdir -p "$SCRIPT_DIR/registries" "$SCRIPT_DIR/vault" "$SCRIPT_DIR/hooks" "$SCRIPT_DIR/backups"
    chmod 700 "$SCRIPT_DIR/vault"
    
    # Initialize hooks system
    if [[ ! -f "$SCRIPT_DIR/hooks-registry.json" ]]; then
        echo "Creating hooks registry..."
        # Copy from the existing registry if it exists
        if [[ -f "$SCRIPT_DIR/hooks-registry.json" ]]; then
            echo "Hooks registry already exists"
        else
            echo "Error: Hooks registry template not found"
        fi
    fi
    
    # Initialize registries
    for registry in components agents services; do
        if [[ ! -f "$SCRIPT_DIR/registries/${registry}.json" ]]; then
            echo "Creating $registry registry..."
            # These should already exist from our implementation
        fi
    done
    
    # Run startup hook
    if [[ -x "$SCRIPT_DIR/hooks-executor.sh" ]]; then
        "$SCRIPT_DIR/hooks-executor.sh" system startup
    fi
    
    echo "System initialization complete"
    log "INFO" "System initialization completed successfully"
}

# Function to backup systems
backup_systems() {
    local backup_name="${1:-systems_$(date +%Y%m%d_%H%M%S)}"
    local backup_dir="$SCRIPT_DIR/backups"
    
    log "INFO" "Creating system backup: $backup_name"
    
    mkdir -p "$backup_dir"
    
    # Create backup archive
    local backup_file="$backup_dir/${backup_name}.tar.gz"
    
    tar -czf "$backup_file" \
        -C "$CLAUDE_ROOT" \
        --exclude="logs/*" \
        --exclude="scripts/backups/*" \
        scripts/registries/ \
        scripts/hooks-registry.json \
        scripts/vault/ \
        settings.json \
        2>/dev/null || true
    
    if [[ -f "$backup_file" ]]; then
        echo "Backup created: $backup_file"
        log "INFO" "Backup created successfully: $backup_file"
        
        # Clean up old backups (keep last 5)
        ls -t "$backup_dir"/systems_*.tar.gz 2>/dev/null | tail -n +6 | xargs rm -f 2>/dev/null || true
    else
        echo "Error: Failed to create backup"
        log "ERROR" "Backup creation failed"
        return 1
    fi
}

# Function to restore from backup
restore_systems() {
    local backup_file="$1"
    
    if [[ ! -f "$backup_file" ]]; then
        echo "Error: Backup file not found: $backup_file"
        return 1
    fi
    
    log "INFO" "Restoring from backup: $backup_file"
    
    # Create restoration backup first
    backup_systems "pre_restore_$(date +%Y%m%d_%H%M%S)"
    
    # Extract backup
    if tar -xzf "$backup_file" -C "$CLAUDE_ROOT"; then
        echo "Restore completed successfully"
        log "INFO" "Restore completed successfully from: $backup_file"
        
        # Run system health check
        check_health
    else
        echo "Error: Failed to restore from backup"
        log "ERROR" "Restore failed from: $backup_file"
        return 1
    fi
}

# Main execution logic
main() {
    local command="$1"
    shift
    
    case "$command" in
        "status")
            check_status "${1:-all}"
            ;;
        "health")
            check_health
            ;;
        "enable")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 enable <system>"
                exit 1
            fi
            enable_system "$1"
            ;;
        "disable")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 disable <system>"
                exit 1
            fi
            disable_system "$1"
            ;;
        "init")
            init_systems
            ;;
        "backup")
            backup_systems "${1:-}"
            ;;
        "restore")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 restore <backup_file>"
                exit 1
            fi
            restore_systems "$1"
            ;;
        *)
            echo "Usage: $0 {status|health|enable|disable|init|backup|restore} [args...]"
            echo "Examples:"
            echo "  $0 status"
            echo "  $0 status hooks"
            echo "  $0 health"
            echo "  $0 enable hooks"
            echo "  $0 disable password"
            echo "  $0 init"
            echo "  $0 backup"
            echo "  $0 backup my_backup"
            echo "  $0 restore backups/systems_20250819_120000.tar.gz"
            exit 1
            ;;
    esac
}

# Execute main function with all arguments
main "$@"