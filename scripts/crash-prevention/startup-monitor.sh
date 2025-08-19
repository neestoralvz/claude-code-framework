#!/bin/bash
# Claude Code Crash Prevention System Startup Monitor
# Ensures crash prevention activates automatically and remains active

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="/Users/nalve/.claude/logs/startup-monitor.log"
PID_FILE="/Users/nalve/.claude/logs/crash-prevention-monitor.pid"
STATUS_FILE="/Users/nalve/.claude/logs/crash-prevention-status.json"
STARTUP_TIMEOUT=30
CHECK_INTERVAL=10

# Logging function
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Check if crash prevention monitor is running
is_monitor_running() {
    if [[ -f "$PID_FILE" ]]; then
        local pid=$(cat "$PID_FILE" 2>/dev/null || echo "")
        if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
            return 0  # Running
        fi
    fi
    return 1  # Not running
}

# Check if monitor is healthy
is_monitor_healthy() {
    if [[ ! -f "$STATUS_FILE" ]]; then
        return 1  # No status file
    fi
    
    # Check if status file is recent (within last 30 seconds)
    local file_age
    if command -v gstat &> /dev/null; then
        file_age=$(($(date +%s) - $(gstat -c %Y "$STATUS_FILE")))
    else
        file_age=$(($(date +%s) - $(stat -f %m "$STATUS_FILE" 2>/dev/null || echo 0)))
    fi
    
    if [[ $file_age -gt 30 ]]; then
        return 1  # Status file too old
    fi
    
    # Check crash prevention score if possible
    if command -v python3 &> /dev/null; then
        local score=$(python3 -c "
import json
try:
    with open('$STATUS_FILE', 'r') as f:
        data = json.load(f)
    print(data.get('crash_prevention_score', 0))
except:
    print(0)
" 2>/dev/null || echo "0")
        
        # Score should be > 0.5 for healthy
        if (( $(echo "$score > 0.5" | bc -l 2>/dev/null || echo "0") )); then
            return 0  # Healthy
        fi
    fi
    
    return 1  # Not healthy
}

# Start crash prevention monitor
start_monitor() {
    log_message "INFO" "Starting crash prevention monitor..."
    
    if is_monitor_running; then
        log_message "WARNING" "Monitor already running"
        return 0
    fi
    
    # Start monitor in background
    cd "$SCRIPT_DIR"
    nohup python3 continuous-monitor.py > /dev/null 2>&1 &
    local monitor_pid=$!
    
    # Save PID
    echo "$monitor_pid" > "$PID_FILE"
    
    # Wait for startup
    local timeout=$STARTUP_TIMEOUT
    while [[ $timeout -gt 0 ]]; do
        if is_monitor_healthy; then
            log_message "INFO" "Monitor started successfully (PID: $monitor_pid)"
            return 0
        fi
        
        sleep 1
        ((timeout--))
    done
    
    log_message "ERROR" "Monitor failed to start within $STARTUP_TIMEOUT seconds"
    return 1
}

# Stop crash prevention monitor
stop_monitor() {
    log_message "INFO" "Stopping crash prevention monitor..."
    
    if [[ -f "$PID_FILE" ]]; then
        local pid=$(cat "$PID_FILE" 2>/dev/null || echo "")
        if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
            kill "$pid"
            
            # Wait for graceful shutdown
            local timeout=10
            while [[ $timeout -gt 0 ]] && kill -0 "$pid" 2>/dev/null; do
                sleep 1
                ((timeout--))
            done
            
            # Force kill if still running
            if kill -0 "$pid" 2>/dev/null; then
                kill -9 "$pid" 2>/dev/null || true
            fi
        fi
        rm -f "$PID_FILE"
    fi
    
    log_message "INFO" "Monitor stopped"
}

# Restart crash prevention monitor
restart_monitor() {
    log_message "INFO" "Restarting crash prevention monitor..."
    stop_monitor
    sleep 2
    start_monitor
}

# Check and maintain monitor health
check_and_maintain() {
    if ! is_monitor_running; then
        log_message "WARNING" "Monitor not running, starting..."
        start_monitor
        return $?
    fi
    
    if ! is_monitor_healthy; then
        log_message "WARNING" "Monitor unhealthy, restarting..."
        restart_monitor
        return $?
    fi
    
    log_message "DEBUG" "Monitor healthy"
    return 0
}

# Continuous monitoring mode
continuous_monitoring() {
    log_message "INFO" "Starting continuous monitoring mode (interval: ${CHECK_INTERVAL}s)"
    
    # Ensure monitor is running initially
    check_and_maintain
    
    # Setup signal handlers
    trap 'log_message "INFO" "Received shutdown signal"; stop_monitor; exit 0' SIGINT SIGTERM
    
    while true; do
        sleep "$CHECK_INTERVAL"
        check_and_maintain
    done
}

# Get current status
get_status() {
    echo "=== Crash Prevention Monitor Status ==="
    
    if is_monitor_running; then
        echo "Monitor Process: ✅ RUNNING"
        if [[ -f "$PID_FILE" ]]; then
            echo "PID: $(cat "$PID_FILE")"
        fi
    else
        echo "Monitor Process: ❌ NOT RUNNING"
    fi
    
    if is_monitor_healthy; then
        echo "Monitor Health: ✅ HEALTHY"
    else
        echo "Monitor Health: ❌ UNHEALTHY"
    fi
    
    if [[ -f "$STATUS_FILE" ]]; then
        echo "Status File: ✅ PRESENT"
        local file_age
        if command -v gstat &> /dev/null; then
            file_age=$(($(date +%s) - $(gstat -c %Y "$STATUS_FILE")))
        else
            file_age=$(($(date +%s) - $(stat -f %m "$STATUS_FILE" 2>/dev/null || echo 0)))
        fi
        echo "Status Age: ${file_age}s"
        
        # Show crash prevention score if available
        if command -v python3 &> /dev/null; then
            local score=$(python3 -c "
import json
try:
    with open('$STATUS_FILE', 'r') as f:
        data = json.load(f)
    print(f\"Crash Prevention Score: {data.get('crash_prevention_score', 0):.2f}\")
    print(f\"Components Active: {sum([
        data.get('resource_monitor_active', False),
        data.get('early_warning_active', False), 
        data.get('degradation_manager_active', False),
        data.get('bash_limits_available', False)
    ])}/4\")
    memory = data.get('system_load', {}).get('memory_percent', 0)
    print(f\"System Memory: {memory:.1f}%\")
except Exception as e:
    print(f\"Status parse error: {e}\")
" 2>/dev/null || echo "Status parsing failed")
            echo "$score"
        fi
    else
        echo "Status File: ❌ MISSING"
    fi
    
    echo "Log File: $LOG_FILE"
    echo "============================================"
}

# Integrate with Claude Code startup
integrate_startup() {
    log_message "INFO" "Integrating with Claude Code startup..."
    
    # Create startup hook script
    local hook_dir="/Users/nalve/.claude/scripts/hooks"
    mkdir -p "$hook_dir"
    
    cat > "$hook_dir/crash-prevention-startup.sh" << 'EOF'
#!/bin/bash
# Auto-start crash prevention monitoring with Claude Code
/Users/nalve/.claude/scripts/crash-prevention/startup-monitor.sh start
EOF
    
    chmod +x "$hook_dir/crash-prevention-startup.sh"
    
    # Create shutdown hook script
    cat > "$hook_dir/crash-prevention-shutdown.sh" << 'EOF'
#!/bin/bash
# Auto-stop crash prevention monitoring with Claude Code
/Users/nalve/.claude/scripts/crash-prevention/startup-monitor.sh stop
EOF
    
    chmod +x "$hook_dir/crash-prevention-shutdown.sh"
    
    log_message "INFO" "Startup integration completed"
}

# Show usage
show_usage() {
    cat << 'EOF'
Claude Code Crash Prevention Startup Monitor

Usage:
  startup-monitor.sh start              Start the monitor
  startup-monitor.sh stop               Stop the monitor  
  startup-monitor.sh restart            Restart the monitor
  startup-monitor.sh status             Show current status
  startup-monitor.sh check              Check and maintain health
  startup-monitor.sh continuous         Run continuous monitoring
  startup-monitor.sh integrate          Integrate with Claude Code startup
  startup-monitor.sh help               Show this help

Examples:
  # Start monitoring
  ./startup-monitor.sh start
  
  # Check if everything is working
  ./startup-monitor.sh status
  
  # Run continuous health checking
  ./startup-monitor.sh continuous
  
  # Integrate with Claude Code startup
  ./startup-monitor.sh integrate

EOF
}

# Main command processing
main() {
    local command="${1:-help}"
    
    case "$command" in
        start)
            start_monitor
            ;;
        stop)
            stop_monitor
            ;;
        restart)
            restart_monitor
            ;;
        status)
            get_status
            ;;
        check)
            check_and_maintain
            ;;
        continuous)
            continuous_monitoring
            ;;
        integrate)
            integrate_startup
            ;;
        help|--help|-h)
            show_usage
            ;;
        *)
            echo "Unknown command: $command"
            show_usage
            exit 1
            ;;
    esac
}

# Initialize logging
log_message "INFO" "Startup monitor initialized"

# Run main function
main "$@"