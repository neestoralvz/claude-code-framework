#!/bin/bash

# Context7 Framework - File Operations Library
# Robust file handling patterns based on Model Context Protocol best practices
# Implements graceful error handling, retry logic, and structured responses

# Context7 Pattern: Structured logging with context
log_with_context() {
    local level="$1"
    local message="$2"
    local context="${3:-general}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] [$context] $message"
}

# Context7 Pattern: Retry logic with exponential backoff
execute_with_retry() {
    local operation="$1"
    local description="$2"
    local max_retries="${3:-3}"
    local base_delay="${4:-1}"
    local retry_count=0
    
    while [[ $retry_count -lt $max_retries ]]; do
        if eval "$operation" 2>/dev/null; then
            log_with_context "INFO" "SUCCESS: $description" "retry-handler"
            return 0
        else
            retry_count=$((retry_count + 1))
            if [[ $retry_count -ge $max_retries ]]; then
                log_with_context "ERROR" "FAILED: $description after $max_retries attempts" "retry-handler"
                return 1
            fi
            
            local delay=$((base_delay * retry_count))
            log_with_context "WARN" "RETRY: $description (attempt $retry_count/$max_retries, waiting ${delay}s)" "retry-handler"
            sleep "$delay"
        fi
    done
}

# Context7 Pattern: Safe file creation with fallback
safe_file_create() {
    local file_path="$1"
    local content="$2"
    local description="${3:-file creation}"
    
    # Create parent directory if it doesn't exist
    local parent_dir=$(dirname "$file_path")
    if [[ ! -d "$parent_dir" ]]; then
        if ! mkdir -p "$parent_dir" 2>/dev/null; then
            log_with_context "ERROR" "Failed to create parent directory: $parent_dir" "file-ops"
            return 1
        fi
    fi
    
    # Attempt to create file with retry
    local create_operation="echo '$content' > '$file_path'"
    if execute_with_retry "$create_operation" "$description"; then
        log_with_context "INFO" "File created successfully: $file_path" "file-ops"
        return 0
    else
        log_with_context "ERROR" "Failed to create file: $file_path" "file-ops"
        return 1
    fi
}

# Context7 Pattern: Safe file validation
validate_file_integrity() {
    local file_path="$1"
    local expected_type="${2:-any}"
    
    # Check if file exists
    if [[ ! -f "$file_path" ]]; then
        log_with_context "ERROR" "File does not exist: $file_path" "validation"
        return 1
    fi
    
    # Check if file is readable
    if [[ ! -r "$file_path" ]]; then
        log_with_context "ERROR" "File is not readable: $file_path" "validation"
        return 1
    fi
    
    # Type-specific validation
    case "$expected_type" in
        "json")
            if command -v jq >/dev/null 2>&1; then
                if ! jq empty "$file_path" 2>/dev/null; then
                    log_with_context "ERROR" "Invalid JSON file: $file_path" "validation"
                    return 1
                fi
            else
                log_with_context "WARN" "Cannot validate JSON - jq not available" "validation"
            fi
            ;;
        "executable")
            if [[ ! -x "$file_path" ]]; then
                log_with_context "ERROR" "File is not executable: $file_path" "validation"
                return 1
            fi
            ;;
    esac
    
    log_with_context "INFO" "File validation passed: $file_path" "validation"
    return 0
}

# Context7 Pattern: Resource-aware process management
check_system_resources() {
    local context="${1:-resource-check}"
    
    # Check available memory
    if command -v free >/dev/null 2>&1; then
        local available_mem=$(free -m | awk 'NR==2{printf "%.0f", $7}')
        if [[ $available_mem -lt 100 ]]; then
            log_with_context "WARN" "Low available memory: ${available_mem}MB" "$context"
            return 1
        fi
    elif command -v vm_stat >/dev/null 2>&1; then
        # macOS memory check
        local free_pages=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
        local page_size=4096
        local free_mb=$((free_pages * page_size / 1024 / 1024))
        if [[ $free_mb -lt 100 ]]; then
            log_with_context "WARN" "Low available memory: ${free_mb}MB" "$context"
            return 1
        fi
    fi
    
    # Check process count
    local process_count=$(ps aux | wc -l)
    if [[ $process_count -gt 500 ]]; then
        log_with_context "WARN" "High process count: $process_count" "$context"
        return 1
    fi
    
    log_with_context "INFO" "System resources OK" "$context"
    return 0
}

# Context7 Pattern: Graceful degradation
execute_with_degradation() {
    local primary_operation="$1"
    local fallback_operation="$2"
    local description="$3"
    
    # Try primary operation first
    if eval "$primary_operation" 2>/dev/null; then
        log_with_context "INFO" "Primary operation succeeded: $description" "degradation"
        return 0
    else
        log_with_context "WARN" "Primary operation failed, trying fallback: $description" "degradation"
        
        # Try fallback operation
        if eval "$fallback_operation" 2>/dev/null; then
            log_with_context "INFO" "Fallback operation succeeded: $description" "degradation"
            return 0
        else
            log_with_context "ERROR" "Both primary and fallback operations failed: $description" "degradation"
            return 1
        fi
    fi
}

# Context7 Pattern: Structured error responses
generate_error_response() {
    local error_type="$1"
    local error_message="$2"
    local context="${3:-general}"
    local timestamp=$(date -Iseconds)
    
    local error_response="{"
    error_response+="\"timestamp\": \"$timestamp\","
    error_response+="\"error_type\": \"$error_type\","
    error_response+="\"message\": \"$error_message\","
    error_response+="\"context\": \"$context\","
    error_response+="\"success\": false"
    error_response+="}"
    
    echo "$error_response"
}

# Context7 Pattern: Success responses
generate_success_response() {
    local operation="$1"
    local details="${2:-Operation completed successfully}"
    local context="${3:-general}"
    local timestamp=$(date -Iseconds)
    
    local success_response="{"
    success_response+="\"timestamp\": \"$timestamp\","
    success_response+="\"operation\": \"$operation\","
    success_response+="\"details\": \"$details\","
    success_response+="\"context\": \"$context\","
    success_response+="\"success\": true"
    success_response+="}"
    
    echo "$success_response"
}