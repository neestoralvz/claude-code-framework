#!/bin/bash
# Claude Code Terminal Output Limits
# Prevents terminal buffer overflow and excessive output

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="/Users/nalve/.claude/logs/terminal-limits.log"

# Default limits
DEFAULT_MAX_LINES=1000
DEFAULT_MAX_BYTES=$((10 * 1024 * 1024))  # 10MB
DEFAULT_MAX_WIDTH=120

# Logging function
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Check if output should be limited
should_limit_output() {
    local output_size="$1"
    local line_count="$2"
    
    if [[ $output_size -gt $DEFAULT_MAX_BYTES ]]; then
        return 0  # true - should limit
    fi
    
    if [[ $line_count -gt $DEFAULT_MAX_LINES ]]; then
        return 0  # true - should limit
    fi
    
    return 1  # false - no limit needed
}

# Truncate output with informative message
truncate_output() {
    local input_file="$1"
    local max_lines="${2:-$DEFAULT_MAX_LINES}"
    local total_lines
    
    total_lines=$(wc -l < "$input_file" 2>/dev/null || echo 0)
    
    if [[ $total_lines -gt $max_lines ]]; then
        log_message "WARNING" "Output truncated: $total_lines lines > $max_lines limit"
        
        # Show first portion
        head -n $((max_lines / 2)) "$input_file"
        
        # Show truncation message
        echo ""
        echo "═══ OUTPUT TRUNCATED ═══"
        echo "Showing first $((max_lines / 2)) and last $((max_lines / 2)) lines"
        echo "Total lines: $total_lines (${total_lines}L exceeded ${max_lines}L limit)"
        echo "═══ CONTINUING BELOW ═══"
        echo ""
        
        # Show last portion
        tail -n $((max_lines / 2)) "$input_file"
    else
        cat "$input_file"
    fi
}

# Limit line width for better readability
limit_line_width() {
    local max_width="${1:-$DEFAULT_MAX_WIDTH}"
    
    while IFS= read -r line; do
        if [[ ${#line} -gt $max_width ]]; then
            echo "${line:0:$max_width}..."
        else
            echo "$line"
        fi
    done
}

# Safe command execution with output limits
exec_with_limits() {
    local max_lines="${1:-$DEFAULT_MAX_LINES}"
    local max_width="${2:-$DEFAULT_MAX_WIDTH}"
    shift 2
    local cmd=("$@")
    
    log_message "INFO" "Executing with limits: ${cmd[*]} (max_lines: $max_lines, max_width: $max_width)"
    
    # Create temporary files
    local stdout_file=$(mktemp)
    local stderr_file=$(mktemp)
    
    # Cleanup function
    cleanup() {
        rm -f "$stdout_file" "$stderr_file"
    }
    trap cleanup EXIT
    
    # Execute command
    local exit_code=0
    if ! "${cmd[@]}" > "$stdout_file" 2> "$stderr_file"; then
        exit_code=$?
    fi
    
    # Process stdout with limits
    if [[ -s "$stdout_file" ]]; then
        truncate_output "$stdout_file" "$max_lines" | limit_line_width "$max_width"
    fi
    
    # Process stderr with limits
    if [[ -s "$stderr_file" ]]; then
        {
            echo "STDERR:"
            truncate_output "$stderr_file" "$max_lines" | limit_line_width "$max_width"
        } >&2
    fi
    
    return $exit_code
}

# Stream processing with live limits
stream_with_limits() {
    local max_lines="${1:-$DEFAULT_MAX_LINES}"
    local max_width="${2:-$DEFAULT_MAX_WIDTH}"
    
    local line_count=0
    local truncated=false
    
    while IFS= read -r line; do
        line_count=$((line_count + 1))
        
        if [[ $line_count -gt $max_lines ]]; then
            if [[ "$truncated" == false ]]; then
                echo ""
                echo "═══ STREAM TRUNCATED ═══"
                echo "Output limit reached: $max_lines lines"
                echo "Further output suppressed..."
                echo "═══ END OF STREAM ═══"
                truncated=true
            fi
            break
        fi
        
        # Limit line width
        if [[ ${#line} -gt $max_width ]]; then
            echo "${line:0:$max_width}..."
        else
            echo "$line"
        fi
    done
    
    if [[ "$truncated" == true ]]; then
        log_message "WARNING" "Stream truncated at $max_lines lines"
    fi
}

# Monitor and limit log file sizes
monitor_log_sizes() {
    local max_size="${1:-$DEFAULT_MAX_BYTES}"
    local log_dir="/Users/nalve/.claude/logs"
    
    if [[ ! -d "$log_dir" ]]; then
        return 0
    fi
    
    find "$log_dir" -name "*.log" -type f | while read -r log_file; do
        local file_size
        file_size=$(stat -f%z "$log_file" 2>/dev/null || echo 0)
        
        if [[ $file_size -gt $max_size ]]; then
            log_message "WARNING" "Large log file detected: $log_file ($file_size bytes)"
            
            # Rotate the log file
            local backup="${log_file}.old"
            mv "$log_file" "$backup"
            
            # Keep last 1000 lines in new file
            tail -n 1000 "$backup" > "$log_file"
            
            log_message "INFO" "Log file rotated: $log_file"
        fi
    done
}

# Terminal buffer safety check
check_terminal_buffer() {
    local estimated_lines="$1"
    local terminal_rows
    
    # Get terminal size
    if command -v tput &> /dev/null; then
        terminal_rows=$(tput lines 2>/dev/null || echo 24)
    else
        terminal_rows=24  # fallback
    fi
    
    # Warn if output might overwhelm terminal
    if [[ $estimated_lines -gt $((terminal_rows * 10)) ]]; then
        log_message "WARNING" "Large output detected: $estimated_lines lines (terminal: ${terminal_rows} rows)"
        echo "⚠️  Warning: Large output detected ($estimated_lines lines)"
        echo "   Consider using pagination (less, more) or output redirection"
        echo ""
    fi
}

# Safe pagination wrapper
safe_pager() {
    local content_file="$1"
    local total_lines
    
    total_lines=$(wc -l < "$content_file" 2>/dev/null || echo 0)
    
    check_terminal_buffer "$total_lines"
    
    if [[ $total_lines -gt 50 ]]; then
        if command -v less &> /dev/null; then
            less -R "$content_file"
        elif command -v more &> /dev/null; then
            more "$content_file"
        else
            truncate_output "$content_file"
        fi
    else
        cat "$content_file"
    fi
}

# Initialize limits
apply_terminal_limits() {
    # Set bash history limits
    export HISTSIZE=1000
    export HISTFILESIZE=2000
    
    # Set shell options for output control
    set +H  # Disable history expansion to prevent issues with special chars
    
    log_message "INFO" "Terminal limits applied"
}

# Progress indicator for long operations
show_progress() {
    local current="$1"
    local total="$2"
    local operation="${3:-Processing}"
    
    local percent=$((current * 100 / total))
    local bar_length=20
    local filled=$((percent * bar_length / 100))
    
    # Create progress bar
    local bar=""
    for ((i=0; i<filled; i++)); do
        bar+="█"
    done
    for ((i=filled; i<bar_length; i++)); do
        bar+="░"
    done
    
    # Print progress (carriage return to overwrite)
    printf "\r%s [%s] %d%% (%d/%d)" "$operation" "$bar" "$percent" "$current" "$total"
    
    # New line when complete
    if [[ $current -eq $total ]]; then
        echo ""
    fi
}

# Usage examples and help
show_usage() {
    cat << 'EOF'
Claude Code Terminal Output Limits

Usage:
  source terminal-limits.sh

Functions:
  exec_with_limits [max_lines] [max_width] command...
    Execute command with output limits
    
  stream_with_limits [max_lines] [max_width]
    Process stdin stream with limits
    
  truncate_output file [max_lines]
    Truncate file output intelligently
    
  limit_line_width [max_width]
    Limit line width for readability
    
  monitor_log_sizes [max_size]
    Monitor and rotate large log files
    
  safe_pager file
    Safely paginate large content
    
  show_progress current total [operation]
    Display progress indicator
    
  apply_terminal_limits
    Apply safe terminal settings

Examples:
  exec_with_limits 500 100 ls -la /large/directory
  find /path -name "*.log" | stream_with_limits 200 80
  truncate_output large_file.txt 1000
  echo "very long line..." | limit_line_width 80
  monitor_log_sizes 5M
  safe_pager large_output.txt
  show_progress 50 100 "Analyzing files"

EOF
}

# Initialize logging
mkdir -p "$(dirname "$LOG_FILE")"
log_message "INFO" "Terminal limits library loaded"

# Apply limits when sourced
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    apply_terminal_limits
fi

# If script is executed directly, show usage
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    show_usage
fi