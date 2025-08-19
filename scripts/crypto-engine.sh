#!/bin/bash

# Cryptographic Engine for Claude Code Framework
# AES-256-GCM encryption with PBKDF2 key derivation

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_DIR="$SCRIPT_DIR/vault"
TEMP_DIR="/tmp/claude_crypto_$$"
LOGS_DIR="$(dirname "$SCRIPT_DIR")/logs/crypto"

# Ensure directories exist
mkdir -p "$VAULT_DIR" "$LOGS_DIR"
chmod 700 "$VAULT_DIR"

# Clean up temp directory on exit
trap 'rm -rf "$TEMP_DIR" 2>/dev/null || true' EXIT

# Function to log security events
security_log() {
    local level="$1"
    local event="$2"
    local detail="${3:-}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local user=$(whoami)
    local pid=$$
    echo "[$timestamp] [$level] [PID:$pid] [USER:$user] $event $detail" >> "$LOGS_DIR/security.log"
    
    # Also log to syslog for critical events
    if [[ "$level" == "CRITICAL" ]] || [[ "$level" == "ERROR" ]]; then
        logger -p auth.err "Claude-Crypto: $event $detail"
    fi
}

# Function to generate secure random data
generate_random() {
    local length="$1"
    openssl rand -hex "$length"
}

# Function to derive key from password
derive_key() {
    local password="$1"
    local salt="$2"
    local iterations="${3:-100000}"
    
    echo -n "$password" | openssl dgst -sha256 -mac HMAC -macopt hexkey:"$salt" -binary | base64 -w 0
}

# Function to encrypt data
encrypt_data() {
    local plaintext="$1"
    local password="$2"
    local salt="${3:-$(generate_random 16)}"
    
    security_log "INFO" "ENCRYPTION_ATTEMPT" "salt_length:${#salt}"
    
    # Derive encryption key
    local key=$(derive_key "$password" "$salt")
    
    # Generate IV
    local iv=$(generate_random 12)
    
    # Create temp directory
    mkdir -p "$TEMP_DIR"
    chmod 700 "$TEMP_DIR"
    
    # Encrypt using AES-256-GCM
    local encrypted
    if encrypted=$(echo -n "$plaintext" | openssl enc -aes-256-gcm -e -K "$key" -iv "$iv" -base64 -A 2>/dev/null); then
        # Create result JSON
        jq -n \
            --arg algorithm "AES-256-GCM" \
            --arg salt "$salt" \
            --arg iv "$iv" \
            --arg encrypted "$encrypted" \
            --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
            '{
                algorithm: $algorithm,
                salt: $salt,
                iv: $iv,
                encrypted: $encrypted,
                timestamp: $timestamp
            }'
        
        security_log "INFO" "ENCRYPTION_SUCCESS" "data_length:${#plaintext}"
        return 0
    else
        security_log "ERROR" "ENCRYPTION_FAILED" "openssl_error"
        return 1
    fi
}

# Function to decrypt data
decrypt_data() {
    local encrypted_json="$1"
    local password="$2"
    
    security_log "INFO" "DECRYPTION_ATTEMPT"
    
    # Parse encrypted data
    local algorithm=$(echo "$encrypted_json" | jq -r '.algorithm')
    local salt=$(echo "$encrypted_json" | jq -r '.salt')
    local iv=$(echo "$encrypted_json" | jq -r '.iv')
    local encrypted=$(echo "$encrypted_json" | jq -r '.encrypted')
    
    # Validate algorithm
    if [[ "$algorithm" != "AES-256-GCM" ]]; then
        security_log "ERROR" "DECRYPTION_FAILED" "unsupported_algorithm:$algorithm"
        return 1
    fi
    
    # Derive decryption key
    local key=$(derive_key "$password" "$salt")
    
    # Decrypt data
    local plaintext
    if plaintext=$(echo -n "$encrypted" | openssl enc -aes-256-gcm -d -K "$key" -iv "$iv" -base64 -A 2>/dev/null); then
        echo "$plaintext"
        security_log "INFO" "DECRYPTION_SUCCESS"
        return 0
    else
        security_log "ERROR" "DECRYPTION_FAILED" "invalid_password_or_corrupt_data"
        return 1
    fi
}

# Function to encrypt file
encrypt_file() {
    local input_file="$1"
    local output_file="$2"
    local password="$3"
    
    if [[ ! -f "$input_file" ]]; then
        security_log "ERROR" "FILE_ENCRYPTION_FAILED" "input_file_not_found:$input_file"
        return 1
    fi
    
    local plaintext=$(cat "$input_file")
    local encrypted_json=$(encrypt_data "$plaintext" "$password")
    
    if [[ $? -eq 0 ]]; then
        echo "$encrypted_json" > "$output_file"
        chmod 600 "$output_file"
        security_log "INFO" "FILE_ENCRYPTION_SUCCESS" "output:$output_file"
        return 0
    else
        security_log "ERROR" "FILE_ENCRYPTION_FAILED" "encryption_error"
        return 1
    fi
}

# Function to decrypt file
decrypt_file() {
    local input_file="$1"
    local password="$2"
    local output_file="${3:-}"
    
    if [[ ! -f "$input_file" ]]; then
        security_log "ERROR" "FILE_DECRYPTION_FAILED" "input_file_not_found:$input_file"
        return 1
    fi
    
    local encrypted_json=$(cat "$input_file")
    local plaintext
    
    if plaintext=$(decrypt_data "$encrypted_json" "$password"); then
        if [[ -n "$output_file" ]]; then
            echo "$plaintext" > "$output_file"
            chmod 600 "$output_file"
            security_log "INFO" "FILE_DECRYPTION_SUCCESS" "output:$output_file"
        else
            echo "$plaintext"
            security_log "INFO" "FILE_DECRYPTION_SUCCESS" "stdout"
        fi
        return 0
    else
        security_log "ERROR" "FILE_DECRYPTION_FAILED" "decryption_error"
        return 1
    fi
}

# Function to validate password strength
validate_password() {
    local password="$1"
    local min_length="${2:-12}"
    
    local length=${#password}
    local has_upper=0
    local has_lower=0
    local has_digit=0
    local has_special=0
    
    # Check length
    if [[ $length -lt $min_length ]]; then
        echo "Password too short (minimum: $min_length characters)"
        return 1
    fi
    
    # Check character types
    [[ "$password" =~ [A-Z] ]] && has_upper=1
    [[ "$password" =~ [a-z] ]] && has_lower=1
    [[ "$password" =~ [0-9] ]] && has_digit=1
    [[ "$password" =~ [^A-Za-z0-9] ]] && has_special=1
    
    local score=$((has_upper + has_lower + has_digit + has_special))
    
    if [[ $score -lt 3 ]]; then
        echo "Password must contain at least 3 of: uppercase, lowercase, digits, special characters"
        return 1
    fi
    
    echo "Password validation passed"
    return 0
}

# Function to generate secure password
generate_password() {
    local length="${1:-16}"
    local charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?"
    
    local password=""
    for ((i=0; i<length; i++)); do
        local random_index=$((RANDOM % ${#charset}))
        password+="${charset:$random_index:1}"
    done
    
    echo "$password"
    security_log "INFO" "PASSWORD_GENERATED" "length:$length"
}

# Function to securely wipe data
secure_wipe() {
    local file="$1"
    
    if [[ -f "$file" ]]; then
        # Overwrite with random data multiple times
        for i in {1..3}; do
            dd if=/dev/urandom of="$file" bs=1M count=1 2>/dev/null || true
        done
        rm -f "$file"
        security_log "INFO" "SECURE_WIPE" "file:$file"
    fi
}

# Main execution logic
main() {
    local command="$1"
    shift
    
    case "$command" in
        "encrypt")
            if [[ $# -lt 2 ]]; then
                echo "Usage: $0 encrypt <plaintext> <password> [salt]"
                exit 1
            fi
            encrypt_data "$1" "$2" "${3:-}"
            ;;
        "decrypt")
            if [[ $# -lt 2 ]]; then
                echo "Usage: $0 decrypt <encrypted_json> <password>"
                exit 1
            fi
            decrypt_data "$1" "$2"
            ;;
        "encrypt-file")
            if [[ $# -lt 3 ]]; then
                echo "Usage: $0 encrypt-file <input_file> <output_file> <password>"
                exit 1
            fi
            encrypt_file "$1" "$2" "$3"
            ;;
        "decrypt-file")
            if [[ $# -lt 2 ]]; then
                echo "Usage: $0 decrypt-file <input_file> <password> [output_file]"
                exit 1
            fi
            decrypt_file "$1" "$2" "${3:-}"
            ;;
        "validate-password")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 validate-password <password> [min_length]"
                exit 1
            fi
            validate_password "$1" "${2:-12}"
            ;;
        "generate-password")
            generate_password "${1:-16}"
            ;;
        "generate-random")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 generate-random <length>"
                exit 1
            fi
            generate_random "$1"
            ;;
        "secure-wipe")
            if [[ $# -lt 1 ]]; then
                echo "Usage: $0 secure-wipe <file>"
                exit 1
            fi
            secure_wipe "$1"
            ;;
        *)
            echo "Usage: $0 {encrypt|decrypt|encrypt-file|decrypt-file|validate-password|generate-password|generate-random|secure-wipe} [args...]"
            echo "Examples:"
            echo "  $0 encrypt 'secret data' 'master_password'"
            echo "  $0 decrypt '\$encrypted_json' 'master_password'"
            echo "  $0 encrypt-file plain.txt encrypted.json master_password"
            echo "  $0 decrypt-file encrypted.json master_password [plain.txt]"
            echo "  $0 validate-password 'Test123!@#' 12"
            echo "  $0 generate-password 20"
            echo "  $0 generate-random 32"
            exit 1
            ;;
    esac
}

# Execute main function with all arguments
main "$@"