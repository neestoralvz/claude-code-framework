#!/bin/bash
# Claude Code Safe Operations Library
# Provides safe wrappers for common operations with timeout and resource limits

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="/Users/nalve/.claude/logs/safe-operations.log"
RESOURCE_MONITOR="$SCRIPT_DIR/resource-monitor.py"

# Default limits
DEFAULT_TIMEOUT=120  # 2 minutes
DEFAULT_MAX_OUTPUT_LINES=1000
DEFAULT_MAX_FILE_SIZE="10M"
DEFAULT_BATCH_SIZE=5

# Logging function
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Check if resource monitor is available
check_resource_monitor() {
    if [[ -f "$RESOURCE_MONITOR" ]] && command -v python3 &> /dev/null; then
        return 0
    else
        log_message "WARNING" "Resource monitor not available"
        return 1
    fi
}

# Check system resources before operation
check_resources() {
    local operation_type="${1:-default}"
    
    if check_resource_monitor; then
        local result
        result=$(python3 -c "
import sys
sys.path.append('$SCRIPT_DIR')
from resource_monitor import ResourceMonitor
monitor = ResourceMonitor()
should_prevent, reason = monitor.should_prevent_operation('$operation_type')
if should_prevent:
    print('PREVENT:' + reason)
    sys.exit(1)
else:
    print('OK')
    sys.exit(0)
" 2>/dev/null)
        
        if [[ $? -ne 0 ]]; then
            log_message "WARNING" "Resource check failed for $operation_type"
            return 1
        fi
        
        if [[ "$result" == PREVENT:* ]]; then
            log_message "WARNING" "${result#PREVENT:}"
            return 1
        fi
    fi
    
    return 0
}

# Safe command execution with timeout
safe_exec() {
    local timeout="${1:-$DEFAULT_TIMEOUT}"
    local max_lines="${2:-$DEFAULT_MAX_OUTPUT_LINES}"
    shift 2
    local cmd=("$@")
    
    log_message "INFO" "Executing: ${cmd[*]} (timeout: ${timeout}s, max_lines: $max_lines)"
    
    # Check resources before execution
    if ! check_resources "command_execution"; then
        log_message "ERROR" "Resource check failed, command aborted"
        return 1
    fi
    
    # Create temporary files for output
    local stdout_file=$(mktemp)
    local stderr_file=$(mktemp)
    
    # Cleanup function
    cleanup() {
        rm -f "$stdout_file" "$stderr_file"
    }
    trap cleanup EXIT
    
    # Execute with timeout and output limits
    if command -v gtimeout &> /dev/null; then
        # Use GNU timeout (from coreutils on macOS)
        gtimeout "$timeout" "${cmd[@]}" > "$stdout_file" 2> "$stderr_file" &
    elif command -v timeout &> /dev/null; then
        # Use system timeout
        timeout "$timeout" "${cmd[@]}" > "$stdout_file" 2> "$stderr_file" &
    else
        # Fallback: execute without timeout
        log_message "WARNING" "No timeout command available, executing without timeout"
        "${cmd[@]}" > "$stdout_file" 2> "$stderr_file" &
    fi
    
    local cmd_pid=$!
    local exit_code=0
    
    # Wait for command completion
    if ! wait $cmd_pid; then
        exit_code=$?
        log_message "ERROR" "Command failed with exit code $exit_code"
    fi
    
    # Limit output size
    local stdout_lines=$(wc -l < "$stdout_file" 2>/dev/null || echo 0)
    local stderr_lines=$(wc -l < "$stderr_file" 2>/dev/null || echo 0)
    
    if [[ $stdout_lines -gt $max_lines ]]; then
        log_message "WARNING" "Output truncated: $stdout_lines lines > $max_lines limit"
        head -n "$max_lines" "$stdout_file"
        echo "... [OUTPUT TRUNCATED] ..."
    else
        cat "$stdout_file"
    fi
    
    if [[ $stderr_lines -gt 0 ]]; then
        if [[ $stderr_lines -gt $max_lines ]]; then
            log_message "WARNING" "Error output truncated: $stderr_lines lines > $max_lines limit"
            head -n "$max_lines" "$stderr_file" >&2
            echo "... [ERROR OUTPUT TRUNCATED] ..." >&2
        else
            cat "$stderr_file" >&2
        fi
    fi
    
    return $exit_code
}

# Safe file reading with size limits
safe_read_file() {
    local file_path="$1"
    local max_size="${2:-$DEFAULT_MAX_FILE_SIZE}"
    local max_lines="${3:-$DEFAULT_MAX_OUTPUT_LINES}"
    
    if [[ ! -f "$file_path" ]]; then
        log_message "ERROR" "File not found: $file_path"
        return 1
    fi
    
    # Check file size
    if command -v gstat &> /dev/null; then
        local file_size=$(gstat -c%s "$file_path")
    else
        local file_size=$(stat -f%z "$file_path" 2>/dev/null || stat -c%s "$file_path" 2>/dev/null || echo 0)
    fi
    
    local max_bytes
    case "$max_size" in
        *K) max_bytes=$((${max_size%K} * 1024)) ;;
        *M) max_bytes=$((${max_size%M} * 1024 * 1024)) ;;
        *G) max_bytes=$((${max_size%G} * 1024 * 1024 * 1024)) ;;
        *) max_bytes="$max_size" ;;
    esac
    
    if [[ $file_size -gt $max_bytes ]]; then
        log_message "WARNING" "File too large: $file_path ($file_size bytes > $max_bytes limit)"
        return 1
    fi
    
    # Read with line limit
    if command -v ghead &> /dev/null; then
        ghead -n "$max_lines" "$file_path"
    else
        head -n "$max_lines" "$file_path"
    fi
    
    local actual_lines
    actual_lines=$(wc -l < "$file_path" 2>/dev/null || echo 0)
    if [[ $actual_lines -gt $max_lines ]]; then
        echo "... [FILE TRUNCATED: $actual_lines total lines] ..."
    fi
}

# Safe batch file processing
safe_batch_process() {
    local batch_size="${1:-$DEFAULT_BATCH_SIZE}"
    local pause_seconds="${2:-2}"
    shift 2
    local files=("$@")
    
    log_message "INFO" "Starting batch processing: ${#files[@]} files, batch size $batch_size"
    
    local processed=0
    local failed=0
    local batch_count=0
    
    for ((i=0; i<${#files[@]}; i+=batch_size)); do
        batch_count=$((batch_count + 1))
        log_message "INFO" "Processing batch $batch_count"
        
        # Check resources before each batch
        if ! check_resources "bulk_file_ops"; then
            log_message "WARNING" "Resource check failed, pausing batch processing"
            sleep $((pause_seconds * 2))
            continue
        fi
        
        # Process batch
        for ((j=i; j<i+batch_size && j<${#files[@]}; j++)); do
            local file="${files[j]}"
            
            if safe_read_file "$file" >/dev/null 2>&1; then
                processed=$((processed + 1))
                echo "✓ $file"
            else
                failed=$((failed + 1))
                echo "✗ $file" >&2
            fi
        done
        
        # Pause between batches
        if [[ $((i + batch_size)) -lt ${#files[@]} ]]; then
            log_message "INFO" "Pausing ${pause_seconds}s between batches"
            sleep "$pause_seconds"
        fi
    done
    
    log_message "INFO" "Batch processing completed: $processed successful, $failed failed"
    return $([[ $failed -eq 0 ]] && echo 0 || echo 1)
}

# Safe grep with resource limits
safe_grep() {
    local pattern="$1"
    local file="$2"
    local max_matches="${3:-100}"
    local context_lines="${4:-0}"
    
    if [[ ! -f "$file" ]]; then
        log_message "ERROR" "File not found: $file"
        return 1
    fi
    
    # Check resources
    if ! check_resources "file_search"; then
        log_message "WARNING" "Resource check failed for grep operation"
        return 1
    fi
    
    local grep_args=()
    if [[ $context_lines -gt 0 ]]; then
        grep_args+=("-C" "$context_lines")
    fi
    
    # Use ripgrep if available, otherwise grep
    if command -v rg &> /dev/null; then
        safe_exec 30 $((max_matches + 10)) rg "${grep_args[@]}" -m "$max_matches" "$pattern" "$file"
    else
        safe_exec 30 $((max_matches + 10)) grep "${grep_args[@]}" -m "$max_matches" "$pattern" "$file"
    fi
}

# Safe find with limits
safe_find() {
    local search_path="$1"
    local pattern="$2"
    local max_results="${3:-500}"
    local max_depth="${4:-10}"
    
    if [[ ! -d "$search_path" ]]; then
        log_message "ERROR" "Directory not found: $search_path"
        return 1
    fi
    
    # Check resources
    if ! check_resources "directory_scan"; then
        log_message "WARNING" "Resource check failed for find operation"
        return 1
    fi
    
    log_message "INFO" "Searching in $search_path for $pattern (max: $max_results results, depth: $max_depth)"
    
    safe_exec 60 $((max_results + 10)) find "$search_path" \
        -maxdepth "$max_depth" \
        -name "$pattern" \
        -type f \
        2>/dev/null | head -n "$max_results"
}

# Memory usage check
check_memory_usage() {
    if check_resource_monitor; then
        python3 -c "
import sys
sys.path.append('$SCRIPT_DIR')
from resource_monitor import ResourceMonitor
monitor = ResourceMonitor()
metrics = monitor.get_system_metrics()
if metrics:
    memory = metrics.get('memory', {})
    print(f\"Memory: {memory.get('percent', 0):.1f}% used\")
    print(f\"Available: {memory.get('available', 0) / (1024**3):.1f}GB\")
    claude_count = metrics.get('processes', {}).get('claude_count', 0)
    print(f\"Claude processes: {claude_count}\")
"
    else
        # Fallback to basic system commands
        if command -v vm_stat &> /dev/null; then
            vm_stat | head -5
        elif command -v free &> /dev/null; then
            free -h
        else
            echo "Memory information not available"
        fi
    fi
}

# Usage examples and help
show_usage() {
    cat << 'EOF'
Claude Code Safe Operations Library

Usage:
  source safe-operations.sh

Functions:
  safe_exec [timeout] [max_lines] command...
    Execute command with timeout and output limits
    
  safe_read_file file [max_size] [max_lines]
    Read file with size and line limits
    
  safe_batch_process [batch_size] [pause] file1 file2...
    Process files in safe batches with pauses
    
  safe_grep pattern file [max_matches] [context]
    Search with resource limits
    
  safe_find path pattern [max_results] [max_depth]
    Find files with limits
    
  check_memory_usage
    Display current memory usage
    
  check_resources [operation_type]
    Check if resources allow operation

Examples:
  safe_exec 30 500 ls -la /large/directory
  safe_read_file /path/to/large/file.txt 5M 1000
  safe_batch_process 3 2 *.md
  safe_grep "pattern" file.txt 50 2
  safe_find /Users/nalve/.claude "*.md" 100 5

EOF
}

# Initialize logging
mkdir -p "$(dirname "$LOG_FILE")"
log_message "INFO" "Safe operations library loaded"

# If script is executed directly, show usage
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    show_usage
fi