#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - MASTER ENFORCEMENT ORCHESTRATOR
#======================================================================
# Purpose: Coordinates automated correction of formatting violations
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Safety: Comprehensive backup and rollback capabilities
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION CONSTANTS
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
readonly ENFORCEMENT_DIR="$SCRIPT_DIR"
readonly CORE_DIR="$ENFORCEMENT_DIR/core"
readonly BACKUPS_DIR="$ENFORCEMENT_DIR/backups"
readonly LOGS_DIR="$ENFORCEMENT_DIR/logs"
readonly REPORTS_DIR="$ENFORCEMENT_DIR/reports"
readonly CONFIG_DIR="$ENFORCEMENT_DIR/config"
readonly VALIDATION_DIR="$SCRIPT_DIR/../validation"

# Execution configuration
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly RUN_ID="enforcement-$TIMESTAMP"
readonly LOG_FILE="$LOGS_DIR/$RUN_ID.log"
readonly BACKUP_DIR="$BACKUPS_DIR/$RUN_ID"
readonly REPORT_FILE="$REPORTS_DIR/$RUN_ID-enforcement-report.html"

# Safety thresholds
readonly MAX_FILES_PER_RUN=500
readonly MAX_CHANGES_PER_FILE=20
readonly BACKUP_RETENTION_DAYS=30

#======================================================================
# ENFORCEMENT SCRIPT REGISTRY
#======================================================================
declare -A ENFORCEMENT_SCRIPTS=(
    ["yaml-frontmatter"]="$CORE_DIR/yaml-frontmatter-enforcer.sh"
    ["file-naming"]="$CORE_DIR/file-naming-enforcer.sh"
    ["code-blocks"]="$CORE_DIR/code-block-enforcer.sh"
    ["link-format"]="$CORE_DIR/link-format-enforcer.sh"
    ["navigation-patterns"]="$CORE_DIR/navigation-pattern-enforcer.sh"
    ["markdown-structure"]="$CORE_DIR/markdown-structure-enforcer.sh"
    ["cross-references"]="$CORE_DIR/cross-reference-enforcer.sh"
    ["template-compliance"]="$CORE_DIR/template-compliance-enforcer.sh"
)

declare -A ENFORCEMENT_PRIORITIES=(
    ["yaml-frontmatter"]="1"
    ["file-naming"]="1"
    ["code-blocks"]="2"
    ["markdown-structure"]="2"
    ["link-format"]="3"
    ["navigation-patterns"]="3"
    ["cross-references"]="4"
    ["template-compliance"]="4"
)

declare -A ENFORCEMENT_RESULTS=()
declare -A ENFORCEMENT_METRICS=()
declare -A BACKUP_LOCATIONS=()

#======================================================================
# LOGGING AND ERROR HANDLING
#======================================================================
log() {
    local level="$1"
    shift
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $*" | tee -a "$LOG_FILE"
}

log_info() { log "INFO" "$@"; }
log_warn() { log "WARN" "$@"; }
log_error() { log "ERROR" "$@"; }
log_success() { log "SUCCESS" "$@"; }

cleanup_on_exit() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        log_error "Enforcement orchestrator failed with exit code: $exit_code"
        log_error "Rollback available at: $BACKUP_DIR"
        generate_failure_report
    fi
    exit $exit_code
}

trap cleanup_on_exit EXIT

#======================================================================
# SAFETY AND BACKUP SYSTEM
#======================================================================
create_comprehensive_backup() {
    log_info "Creating comprehensive backup before enforcement"
    
    mkdir -p "$BACKUP_DIR"
    
    # Create manifest of all files to be modified
    cat > "$BACKUP_DIR/backup-manifest.json" << EOF
{
  "backup_id": "$RUN_ID",
  "timestamp": "$TIMESTAMP",
  "project_root": "$PROJECT_ROOT",
  "backup_location": "$BACKUP_DIR",
  "files_backed_up": []
}
EOF
    
    # Backup key directories
    local backup_dirs=(
        "docs"
        "agents"
        "commands" 
        "scripts"
        "planning"
        "operations"
    )
    
    local total_files=0
    for dir in "${backup_dirs[@]}"; do
        if [[ -d "$PROJECT_ROOT/$dir" ]]; then
            log_info "Backing up directory: $dir"
            cp -r "$PROJECT_ROOT/$dir" "$BACKUP_DIR/" 2>/dev/null || true
            local dir_files=$(find "$PROJECT_ROOT/$dir" -type f | wc -l)
            total_files=$((total_files + dir_files))
        fi
    done
    
    # Update manifest
    jq --arg count "$total_files" '.total_files_backed_up = ($count | tonumber)' \
       "$BACKUP_DIR/backup-manifest.json" > "$BACKUP_DIR/backup-manifest.json.tmp" && \
       mv "$BACKUP_DIR/backup-manifest.json.tmp" "$BACKUP_DIR/backup-manifest.json"
    
    log_success "Backup completed: $total_files files backed up to $BACKUP_DIR"
    BACKUP_LOCATIONS["main"]="$BACKUP_DIR"
}

verify_backup_integrity() {
    log_info "Verifying backup integrity"
    
    if [[ ! -f "$BACKUP_DIR/backup-manifest.json" ]]; then
        log_error "Backup manifest not found: $BACKUP_DIR/backup-manifest.json"
        return 1
    fi
    
    local expected_files
    expected_files=$(jq -r '.total_files_backed_up' "$BACKUP_DIR/backup-manifest.json")
    
    local actual_files
    actual_files=$(find "$BACKUP_DIR" -type f ! -name "backup-manifest.json" | wc -l)
    
    if [[ $actual_files -ne $expected_files ]]; then
        log_error "Backup integrity check failed: expected $expected_files, found $actual_files"
        return 1
    fi
    
    log_success "Backup integrity verified: $actual_files files"
    return 0
}

emergency_rollback() {
    local backup_location="${1:-$BACKUP_DIR}"
    
    log_error "EMERGENCY ROLLBACK INITIATED"
    log_info "Rolling back from: $backup_location"
    
    if [[ ! -d "$backup_location" ]]; then
        log_error "Backup directory not found: $backup_location"
        return 1
    fi
    
    # Restore directories from backup
    local restore_dirs=(
        "docs"
        "agents"
        "commands"
        "scripts"
        "planning"
        "operations"
    )
    
    for dir in "${restore_dirs[@]}"; do
        if [[ -d "$backup_location/$dir" ]]; then
            log_info "Restoring directory: $dir"
            rm -rf "$PROJECT_ROOT/$dir"
            cp -r "$backup_location/$dir" "$PROJECT_ROOT/"
        fi
    done
    
    log_success "Emergency rollback completed from: $backup_location"
}

#======================================================================
# PRE-ENFORCEMENT VALIDATION
#======================================================================
run_pre_enforcement_validation() {
    log_info "Running pre-enforcement validation"
    
    # Check if validation system is available
    if [[ ! -f "$VALIDATION_DIR/master-validation-orchestrator.sh" ]]; then
        log_error "Validation system not available: $VALIDATION_DIR/master-validation-orchestrator.sh"
        return 1
    fi
    
    # Run validation to establish baseline
    local validation_report
    validation_report="$LOGS_DIR/$RUN_ID-pre-validation.log"
    
    if ! "$VALIDATION_DIR/master-validation-orchestrator.sh" > "$validation_report" 2>&1; then
        log_warn "Pre-validation completed with issues - see: $validation_report"
        
        # Extract compliance score
        local compliance_score
        compliance_score=$(grep -o "Overall Compliance: [0-9]*%" "$validation_report" | grep -o "[0-9]*" || echo "0")
        log_info "Baseline compliance score: ${compliance_score}%"
        
        ENFORCEMENT_METRICS["baseline_compliance"]="$compliance_score"
    else
        log_success "Pre-validation completed successfully"
        ENFORCEMENT_METRICS["baseline_compliance"]="100"
    fi
}

#======================================================================
# ENFORCEMENT EXECUTION ENGINE
#======================================================================
execute_enforcement_script() {
    local script_name="$1"
    local script_path="${ENFORCEMENT_SCRIPTS[$script_name]}"
    local priority="${ENFORCEMENT_PRIORITIES[$script_name]}"
    
    log_info "Executing enforcement: $script_name (Priority: $priority)"
    
    if [[ ! -f "$script_path" ]]; then
        log_warn "Enforcement script not found: $script_path"
        ENFORCEMENT_RESULTS["$script_name"]="MISSING"
        ENFORCEMENT_METRICS["$script_name"]="0"
        return 1
    fi
    
    if [[ ! -x "$script_path" ]]; then
        chmod +x "$script_path"
    fi
    
    # Execute enforcement script with safety limits
    local start_time=$(date +%s)
    local temp_output=$(mktemp)
    local exit_code=0
    
    # Set enforcement environment variables
    export ENFORCEMENT_MODE="safe"
    export MAX_FILES_PER_RUN="$MAX_FILES_PER_RUN"
    export MAX_CHANGES_PER_FILE="$MAX_CHANGES_PER_FILE"
    export BACKUP_DIR="$BACKUP_DIR"
    export DRY_RUN="${DRY_RUN:-false}"
    
    timeout 600 "$script_path" "$PROJECT_ROOT" > "$temp_output" 2>&1 || exit_code=$?
    
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    if [[ $exit_code -eq 124 ]]; then
        log_error "Enforcement timeout: $script_name (>600s)"
        ENFORCEMENT_RESULTS["$script_name"]="TIMEOUT"
        ENFORCEMENT_METRICS["$script_name"]="0"
    elif [[ $exit_code -ne 0 ]]; then
        log_error "Enforcement failed: $script_name (exit code: $exit_code)"
        ENFORCEMENT_RESULTS["$script_name"]="FAILED"
        ENFORCEMENT_METRICS["$script_name"]="0"
        log_error "Output: $(cat "$temp_output")"
    else
        # Parse enforcement results
        local corrections_made
        corrections_made=$(grep -o "CORRECTIONS_MADE:[0-9]*" "$temp_output" | cut -d: -f2 || echo "0")
        
        local files_modified
        files_modified=$(grep -o "FILES_MODIFIED:[0-9]*" "$temp_output" | cut -d: -f2 || echo "0")
        
        ENFORCEMENT_METRICS["$script_name"]="$corrections_made"
        ENFORCEMENT_RESULTS["$script_name"]="SUCCESS"
        
        log_success "Enforcement completed: $script_name ($corrections_made corrections, $files_modified files)"
        log_info "$script_name completed in ${duration}s"
    fi
    
    # Store detailed output
    mv "$temp_output" "$LOGS_DIR/$RUN_ID-$script_name.log"
}

execute_enforcement_by_priority() {
    log_info "Executing enforcement scripts by priority"
    
    # Group scripts by priority
    declare -A priority_groups
    for script_name in "${!ENFORCEMENT_PRIORITIES[@]}"; do
        local priority="${ENFORCEMENT_PRIORITIES[$script_name]}"
        if [[ -z "${priority_groups[$priority]:-}" ]]; then
            priority_groups[$priority]="$script_name"
        else
            priority_groups[$priority]="${priority_groups[$priority]} $script_name"
        fi
    done
    
    # Execute by priority (1 = highest priority)
    for priority in $(printf '%s\n' "${!priority_groups[@]}" | sort -n); do
        log_info "Executing Priority $priority enforcement scripts"
        
        IFS=' ' read -ra scripts <<< "${priority_groups[$priority]}"
        for script_name in "${scripts[@]}"; do
            execute_enforcement_script "$script_name"
            
            # Safety check after each script
            if [[ "${ENFORCEMENT_RESULTS[$script_name]}" == "FAILED" ]]; then
                log_warn "Priority $priority script failed: $script_name"
                if [[ "$SAFE_MODE" == "true" ]]; then
                    log_error "Safe mode enabled - stopping enforcement execution"
                    return 1
                fi
            fi
        done
        
        log_info "Priority $priority enforcement completed"
    done
}

#======================================================================
# POST-ENFORCEMENT VALIDATION
#======================================================================
run_post_enforcement_validation() {
    log_info "Running post-enforcement validation"
    
    local validation_report
    validation_report="$LOGS_DIR/$RUN_ID-post-validation.log"
    
    if ! "$VALIDATION_DIR/master-validation-orchestrator.sh" > "$validation_report" 2>&1; then
        log_warn "Post-validation completed with remaining issues"
        
        # Extract compliance score
        local compliance_score
        compliance_score=$(grep -o "Overall Compliance: [0-9]*%" "$validation_report" | grep -o "[0-9]*" || echo "0")
        log_info "Post-enforcement compliance score: ${compliance_score}%"
        
        ENFORCEMENT_METRICS["final_compliance"]="$compliance_score"
        
        # Calculate improvement
        local baseline="${ENFORCEMENT_METRICS[baseline_compliance]:-0}"
        local improvement=$((compliance_score - baseline))
        ENFORCEMENT_METRICS["compliance_improvement"]="$improvement"
        
        if [[ $improvement -gt 0 ]]; then
            log_success "Compliance improved by ${improvement}% (${baseline}% → ${compliance_score}%)"
        else
            log_warn "No compliance improvement detected"
        fi
    else
        log_success "Post-validation: Perfect compliance achieved!"
        ENFORCEMENT_METRICS["final_compliance"]="100"
        
        local baseline="${ENFORCEMENT_METRICS[baseline_compliance]:-0}"
        local improvement=$((100 - baseline))
        ENFORCEMENT_METRICS["compliance_improvement"]="$improvement"
        log_success "Compliance improved by ${improvement}% (${baseline}% → 100%)"
    fi
}

#======================================================================
# ENFORCEMENT DASHBOARD AND REPORTING
#======================================================================
generate_enforcement_dashboard() {
    log_info "Generating enforcement dashboard"
    
    local total_corrections=0
    local successful_enforcers=0
    local failed_enforcers=0
    
    for script_name in "${!ENFORCEMENT_RESULTS[@]}"; do
        local result="${ENFORCEMENT_RESULTS[$script_name]}"
        local corrections="${ENFORCEMENT_METRICS[$script_name]:-0}"
        
        case "$result" in
            "SUCCESS") 
                successful_enforcers=$((successful_enforcers + 1))
                total_corrections=$((total_corrections + corrections))
                ;;
            "FAILED"|"TIMEOUT"|"MISSING") 
                failed_enforcers=$((failed_enforcers + 1))
                ;;
        esac
    done
    
    # Generate HTML dashboard
    cat > "$REPORT_FILE" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Claude Code Framework - Enforcement Dashboard</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 40px; background: #f8f9fa; }
        .header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 30px; border-radius: 10px; margin-bottom: 30px; }
        .summary { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .metric-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .metric-value { font-size: 2.5em; font-weight: bold; margin-bottom: 10px; }
        .metric-label { color: #666; font-size: 0.9em; text-transform: uppercase; letter-spacing: 1px; }
        .results-table { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; font-weight: 600; }
        .status-success { color: #28a745; font-weight: bold; }
        .status-failed { color: #dc3545; font-weight: bold; }
        .status-missing { color: #ffc107; font-weight: bold; }
        .backup-info { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .safety-notice { background: #e8f4f8; border: 1px solid #bee5eb; padding: 15px; border-radius: 5px; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🔧 Claude Code Framework Enforcement Dashboard</h1>
        <p><strong>Run ID:</strong> $RUN_ID | <strong>Generated:</strong> $(date)</p>
    </div>
    
    <div class="summary">
        <div class="metric-card">
            <div class="metric-value" style="color: #28a745;">$total_corrections</div>
            <div class="metric-label">Total Corrections</div>
        </div>
        <div class="metric-card">
            <div class="metric-value" style="color: #28a745;">$successful_enforcers</div>
            <div class="metric-label">Successful Enforcers</div>
        </div>
        <div class="metric-card">
            <div class="metric-value" style="color: #dc3545;">$failed_enforcers</div>
            <div class="metric-label">Failed Enforcers</div>
        </div>
        <div class="metric-card">
            <div class="metric-value" style="color: #17a2b8;">${ENFORCEMENT_METRICS[compliance_improvement]:-0}%</div>
            <div class="metric-label">Compliance Improvement</div>
        </div>
    </div>
    
    <div class="results-table">
        <table>
            <thead>
                <tr>
                    <th>Enforcement Domain</th>
                    <th>Status</th>
                    <th>Corrections Made</th>
                    <th>Priority</th>
                </tr>
            </thead>
            <tbody>
EOF
    
    # Add enforcement results to table
    for script_name in "${!ENFORCEMENT_RESULTS[@]}"; do
        local result="${ENFORCEMENT_RESULTS[$script_name]}"
        local corrections="${ENFORCEMENT_METRICS[$script_name]:-0}"
        local priority="${ENFORCEMENT_PRIORITIES[$script_name]:-N/A}"
        
        local status_class
        case "$result" in
            "SUCCESS") status_class="status-success" ;;
            "FAILED"|"TIMEOUT") status_class="status-failed" ;;
            "MISSING") status_class="status-missing" ;;
        esac
        
        cat >> "$REPORT_FILE" << EOF
                <tr>
                    <td>$(echo "$script_name" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')</td>
                    <td><span class="$status_class">$result</span></td>
                    <td>$corrections</td>
                    <td>$priority</td>
                </tr>
EOF
    done
    
    cat >> "$REPORT_FILE" << EOF
            </tbody>
        </table>
    </div>
    
    <div class="backup-info">
        <h3>🛡️ Safety & Backup Information</h3>
        <p><strong>Backup Location:</strong> <code>$BACKUP_DIR</code></p>
        <p><strong>Rollback Command:</strong> <code>$0 --rollback $RUN_ID</code></p>
        <p><strong>Log Files:</strong> <code>$LOGS_DIR/$RUN_ID-*.log</code></p>
        
        <div class="safety-notice">
            <strong>🔒 Safety Measures Active:</strong>
            <ul>
                <li>Comprehensive backup created before any changes</li>
                <li>Maximum $MAX_FILES_PER_RUN files processed per run</li>
                <li>Maximum $MAX_CHANGES_PER_FILE changes per file</li>
                <li>Emergency rollback capability available</li>
            </ul>
        </div>
    </div>
    
    <footer style="margin-top: 40px; text-align: center; color: #666; font-size: 0.9em;">
        <p>Generated by Claude Code Framework Master Enforcement Orchestrator v1.0.0</p>
    </footer>
</body>
</html>
EOF
    
    log_success "Enforcement dashboard generated: $REPORT_FILE"
}

generate_failure_report() {
    cat > "$REPORTS_DIR/$RUN_ID-failure-report.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Enforcement Orchestrator - Failure Report</title>
</head>
<body>
    <h1>❌ Enforcement Orchestrator Failed</h1>
    <p><strong>Run ID:</strong> $RUN_ID</p>
    <p><strong>Timestamp:</strong> $(date)</p>
    <p><strong>Backup Available:</strong> $BACKUP_DIR</p>
    
    <h2>Emergency Rollback</h2>
    <pre>$0 --rollback $RUN_ID</pre>
    
    <h2>Error Details</h2>
    <pre>$(tail -100 "$LOG_FILE" 2>/dev/null || echo "Log file not available")</pre>
</body>
</html>
EOF
}

#======================================================================
# CLEANUP AND MAINTENANCE
#======================================================================
cleanup_old_backups() {
    log_info "Cleaning up backups older than $BACKUP_RETENTION_DAYS days"
    
    find "$BACKUPS_DIR" -type d -name "enforcement-*" -mtime +$BACKUP_RETENTION_DAYS -exec rm -rf {} \; 2>/dev/null || true
    
    local remaining_backups
    remaining_backups=$(find "$BACKUPS_DIR" -type d -name "enforcement-*" | wc -l)
    log_info "Cleanup completed: $remaining_backups backups retained"
}

#======================================================================
# COMMAND LINE INTERFACE
#======================================================================
show_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Claude Code Framework Master Enforcement Orchestrator

OPTIONS:
    -h, --help              Show this help message
    -v, --version           Show version information
    --dry-run              Simulate enforcement without making changes
    --safe-mode            Enable additional safety checks
    --script SCRIPT        Run only specific enforcement script
    --rollback RUN_ID      Rollback changes from specified run
    --list-backups         List available backups
    --cleanup-backups      Remove old backups beyond retention period

EXAMPLES:
    $0                              # Run all enforcement scripts
    $0 --dry-run                    # Simulate enforcement run
    $0 --script yaml-frontmatter    # Run only YAML frontmatter enforcer
    $0 --rollback enforcement-20250819-143000  # Rollback specific run
    $0 --safe-mode                  # Run with additional safety checks

SAFETY FEATURES:
    - Comprehensive backup before any changes
    - Emergency rollback capability  
    - Configurable safety thresholds
    - Pre and post enforcement validation

For more information: scripts/enforcement/README.md
EOF
}

show_version() {
    echo "Claude Code Framework Master Enforcement Orchestrator v1.0.0"
    echo "Safety-first automated formatting compliance correction"
    echo "Progressive Thinking Applied: Think → Think Hard → Think Harder → UltraThink"
}

#======================================================================
# ROLLBACK FUNCTIONALITY
#======================================================================
perform_rollback() {
    local run_id="$1"
    local backup_path="$BACKUPS_DIR/$run_id"
    
    if [[ ! -d "$backup_path" ]]; then
        log_error "Backup not found for run ID: $run_id"
        log_info "Available backups:"
        ls -la "$BACKUPS_DIR" | grep "enforcement-" | awk '{print $9}' || echo "No backups available"
        return 1
    fi
    
    log_info "Performing rollback for run ID: $run_id"
    emergency_rollback "$backup_path"
    log_success "Rollback completed successfully"
}

list_available_backups() {
    echo "Available enforcement backups:"
    echo "=============================="
    
    if [[ ! -d "$BACKUPS_DIR" ]]; then
        echo "No backup directory found"
        return 1
    fi
    
    local backup_count=0
    for backup_dir in "$BACKUPS_DIR"/enforcement-*; do
        if [[ -d "$backup_dir" ]]; then
            local backup_name=$(basename "$backup_dir")
            local backup_date=$(echo "$backup_name" | grep -o '[0-9]\{8\}-[0-9]\{6\}')
            local formatted_date=$(date -d "${backup_date:0:8} ${backup_date:9:2}:${backup_date:11:2}:${backup_date:13:2}" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || echo "Unknown date")
            local backup_size=$(du -sh "$backup_dir" 2>/dev/null | cut -f1)
            
            echo "ID: $backup_name"
            echo "  Date: $formatted_date"
            echo "  Size: $backup_size"
            echo "  Path: $backup_dir"
            echo ""
            backup_count=$((backup_count + 1))
        fi
    done
    
    if [[ $backup_count -eq 0 ]]; then
        echo "No enforcement backups available"
    else
        echo "Total backups: $backup_count"
        echo ""
        echo "To rollback: $0 --rollback <backup-id>"
    fi
}

#======================================================================
# MAIN EXECUTION FLOW
#======================================================================
main() {
    local dry_run=false
    local safe_mode=false
    local specific_script=""
    local rollback_run_id=""
    local list_backups=false
    local cleanup_backups=false
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -v|--version)
                show_version
                exit 0
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            --safe-mode)
                safe_mode=true
                shift
                ;;
            --script)
                specific_script="$2"
                shift 2
                ;;
            --rollback)
                rollback_run_id="$2"
                shift 2
                ;;
            --list-backups)
                list_backups=true
                shift
                ;;
            --cleanup-backups)
                cleanup_backups=true
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    # Ensure required directories exist
    mkdir -p "$LOGS_DIR" "$REPORTS_DIR" "$CONFIG_DIR"
    
    # Handle special operations
    if [[ "$list_backups" == "true" ]]; then
        list_available_backups
        exit 0
    fi
    
    if [[ "$cleanup_backups" == "true" ]]; then
        cleanup_old_backups
        exit 0
    fi
    
    if [[ -n "$rollback_run_id" ]]; then
        perform_rollback "$rollback_run_id"
        exit 0
    fi
    
    # Set environment variables
    export DRY_RUN="$dry_run"
    export SAFE_MODE="$safe_mode"
    
    log_info "Starting Master Enforcement Orchestrator"
    log_info "Run ID: $RUN_ID"
    log_info "Mode: $([ "$dry_run" == "true" ] && echo "DRY RUN" || echo "LIVE")"
    log_info "Safe Mode: $([ "$safe_mode" == "true" ] && echo "ENABLED" || echo "DISABLED")"
    
    if [[ "$dry_run" == "true" ]]; then
        log_info "DRY RUN MODE: Simulating enforcement execution"
        for script_name in "${!ENFORCEMENT_SCRIPTS[@]}"; do
            log_info "Would execute: $script_name"
        done
        exit 0
    fi
    
    # Execute enforcement workflow
    if ! run_pre_enforcement_validation; then
        log_error "Pre-enforcement validation failed"
        exit 1
    fi
    
    if ! create_comprehensive_backup; then
        log_error "Backup creation failed"
        exit 1
    fi
    
    if ! verify_backup_integrity; then
        log_error "Backup integrity verification failed"
        exit 1
    fi
    
    # Execute enforcement scripts
    if [[ -n "$specific_script" ]]; then
        if [[ -n "${ENFORCEMENT_SCRIPTS[$specific_script]:-}" ]]; then
            log_info "Running specific enforcement: $specific_script"
            execute_enforcement_script "$specific_script"
        else
            log_error "Unknown enforcement script: $specific_script"
            log_info "Available scripts: ${!ENFORCEMENT_SCRIPTS[*]}"
            exit 1
        fi
    else
        execute_enforcement_by_priority
    fi
    
    # Post-enforcement validation
    run_post_enforcement_validation
    
    # Generate comprehensive dashboard
    generate_enforcement_dashboard
    
    # Final status
    local final_compliance="${ENFORCEMENT_METRICS[final_compliance]:-0}"
    local compliance_improvement="${ENFORCEMENT_METRICS[compliance_improvement]:-0}"
    
    log_success "🎉 ENFORCEMENT COMPLETED"
    log_success "Final compliance: ${final_compliance}%"
    log_success "Improvement: +${compliance_improvement}%"
    log_success "Dashboard: $REPORT_FILE"
    log_success "Backup: $BACKUP_DIR"
    
    exit 0
}

#======================================================================
# SCRIPT EXECUTION
#======================================================================
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi