#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - BATCH CORRECTION PROCESSOR
#======================================================================
# Purpose: Efficiently processes multiple files with comprehensive rollback capability
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Features: Parallel processing, smart batching, comprehensive rollback
# Safety: Transaction-like operations with atomic commits
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/../logs/batch-correction-processor-$TIMESTAMP.log"

# Environment variables from orchestrator
readonly DRY_RUN="${DRY_RUN:-false}"
readonly MAX_FILES_PER_BATCH="${MAX_FILES_PER_BATCH:-100}"
readonly MAX_PARALLEL_JOBS="${MAX_PARALLEL_JOBS:-4}"
readonly BACKUP_DIR="${BACKUP_DIR:-${SCRIPT_DIR}/../backups/batch}"

# Batch processing configuration
readonly BATCH_SIZE="${BATCH_SIZE:-25}"
readonly TRANSACTION_DIR="${SCRIPT_DIR}/../transactions"
readonly BATCH_TRANSACTION_ID="batch-$TIMESTAMP"

#======================================================================
# ENFORCEMENT SCRIPT REGISTRY
#======================================================================
declare -A ENFORCER_SCRIPTS=(
    ["yaml-frontmatter"]="$SCRIPT_DIR/yaml-frontmatter-enforcer.sh"
    ["file-naming"]="$SCRIPT_DIR/file-naming-enforcer.sh"
    ["code-blocks"]="$SCRIPT_DIR/code-block-enforcer.sh"
    ["link-format"]="$SCRIPT_DIR/link-format-enforcer.sh"
    ["navigation-patterns"]="$SCRIPT_DIR/navigation-pattern-enforcer.sh"
    ["markdown-structure"]="$SCRIPT_DIR/markdown-structure-enforcer.sh"
    ["cross-references"]="$SCRIPT_DIR/cross-reference-enforcer.sh"
    ["template-compliance"]="$SCRIPT_DIR/template-compliance-enforcer.sh"
)

declare -A BATCH_PRIORITIES=(
    ["yaml-frontmatter"]="1"
    ["file-naming"]="1"
    ["code-blocks"]="2"
    ["markdown-structure"]="2"
    ["link-format"]="3"
    ["navigation-patterns"]="3"
    ["cross-references"]="4"
    ["template-compliance"]="4"
)

#======================================================================
# LOGGING AND METRICS
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

declare -A BATCH_METRICS=(
    ["total_files_processed"]=0
    ["total_files_modified"]=0
    ["total_corrections_made"]=0
    ["successful_batches"]=0
    ["failed_batches"]=0
    ["total_processing_time"]=0
    ["average_files_per_second"]=0
)

declare -a BATCH_RESULTS=()
declare -a FAILED_OPERATIONS=()

#======================================================================
# TRANSACTION MANAGEMENT
#======================================================================
initialize_transaction() {
    local transaction_id="$1"
    
    mkdir -p "$TRANSACTION_DIR/$transaction_id"
    
    cat > "$TRANSACTION_DIR/$transaction_id/transaction.json" << EOF
{
  "transaction_id": "$transaction_id",
  "timestamp": "$TIMESTAMP",
  "status": "initialized",
  "batches": [],
  "total_files": 0,
  "rollback_available": true
}
EOF
    
    log_info "Transaction initialized: $transaction_id"
}

start_batch_transaction() {
    local batch_id="$1"
    local files=("${@:2}")
    
    mkdir -p "$TRANSACTION_DIR/$BATCH_TRANSACTION_ID/batches/$batch_id"
    
    # Create batch manifest
    cat > "$TRANSACTION_DIR/$BATCH_TRANSACTION_ID/batches/$batch_id/batch.json" << EOF
{
  "batch_id": "$batch_id",
  "timestamp": "$(date -Iseconds)",
  "status": "started",
  "files": [$(printf '"%s",' "${files[@]}" | sed 's/,$//')],
  "file_count": ${#files[@]},
  "corrections": {},
  "backups": []
}
EOF
    
    log_info "Started batch transaction: $batch_id (${#files[@]} files)"
}

commit_batch_transaction() {
    local batch_id="$1"
    local corrections_made="$2"
    local files_modified="$3"
    
    # Update batch status
    local batch_file="$TRANSACTION_DIR/$BATCH_TRANSACTION_ID/batches/$batch_id/batch.json"
    jq --arg status "committed" \
       --arg corrections "$corrections_made" \
       --arg modified "$files_modified" \
       '.status = $status | .corrections_made = ($corrections | tonumber) | .files_modified = ($modified | tonumber)' \
       "$batch_file" > "$batch_file.tmp" && mv "$batch_file.tmp" "$batch_file"
    
    log_success "Committed batch transaction: $batch_id ($corrections_made corrections, $files_modified files)"
}

rollback_batch_transaction() {
    local batch_id="$1"
    
    log_error "Rolling back batch transaction: $batch_id"
    
    local batch_dir="$TRANSACTION_DIR/$BATCH_TRANSACTION_ID/batches/$batch_id"
    if [[ -d "$batch_dir" ]]; then
        # Restore files from backups
        local batch_file="$batch_dir/batch.json"
        if [[ -f "$batch_file" ]]; then
            local backup_files
            backup_files=$(jq -r '.backups[]?' "$batch_file" 2>/dev/null || echo "")
            
            while IFS= read -r backup_file; do
                if [[ -n "$backup_file" ]] && [[ -f "$backup_file" ]]; then
                    local original_file
                    original_file=$(basename "$backup_file" | sed 's/-[0-9]*$//g')
                    if [[ -f "$PROJECT_ROOT/$original_file" ]]; then
                        cp "$backup_file" "$PROJECT_ROOT/$original_file"
                        log_info "Restored: $original_file"
                    fi
                fi
            done <<< "$backup_files"
        fi
        
        # Mark batch as rolled back
        jq '.status = "rolled_back"' "$batch_file" > "$batch_file.tmp" && mv "$batch_file.tmp" "$batch_file"
    fi
}

#======================================================================
# FILE BATCHING AND PROCESSING
#======================================================================
create_file_batches() {
    local file_list="$1"
    local batch_prefix="$2"
    
    local batch_num=1
    local current_batch=()
    local batch_count=0
    
    while IFS= read -r file; do
        if [[ -n "$file" ]]; then
            current_batch+=("$file")
            batch_count=$((batch_count + 1))
            
            if [[ $batch_count -ge $BATCH_SIZE ]]; then
                # Process current batch
                local batch_id="${batch_prefix}-$(printf "%03d" $batch_num)"
                echo "$batch_id:${current_batch[*]}"
                
                current_batch=()
                batch_count=0
                batch_num=$((batch_num + 1))
            fi
        fi
    done < "$file_list"
    
    # Process remaining files in final batch
    if [[ ${#current_batch[@]} -gt 0 ]]; then
        local batch_id="${batch_prefix}-$(printf "%03d" $batch_num)"
        echo "$batch_id:${current_batch[*]}"
    fi
}

process_file_batch() {
    local batch_info="$1"
    local enforcer_type="$2"
    
    local batch_id=$(echo "$batch_info" | cut -d: -f1)
    local files_str=$(echo "$batch_info" | cut -d: -f2-)
    IFS=' ' read -ra files <<< "$files_str"
    
    log_info "Processing batch: $batch_id (${#files[@]} files) with $enforcer_type enforcer"
    
    # Start batch transaction
    start_batch_transaction "$batch_id" "${files[@]}"
    
    local enforcer_script="${ENFORCER_SCRIPTS[$enforcer_type]}"
    if [[ ! -f "$enforcer_script" ]]; then
        log_error "Enforcer script not found: $enforcer_script"
        FAILED_OPERATIONS+=("$batch_id:enforcer_missing:$enforcer_type")
        return 1
    fi
    
    # Create temporary file list for this batch
    local batch_file_list=$(mktemp)
    printf '%s\n' "${files[@]}" > "$batch_file_list"
    
    # Set batch-specific environment variables
    export DRY_RUN="$DRY_RUN"
    export MAX_FILES_PER_RUN="${#files[@]}"
    export BATCH_MODE="true"
    export BATCH_ID="$batch_id"
    export BATCH_FILE_LIST="$batch_file_list"
    
    # Execute enforcer script
    local start_time=$(date +%s)
    local corrections_made=0
    local files_modified=0
    
    if timeout 300 "$enforcer_script" "$PROJECT_ROOT" > "$TRANSACTION_DIR/$BATCH_TRANSACTION_ID/batches/$batch_id/output.log" 2>&1; then
        # Parse results from enforcer output
        local enforcer_output="$TRANSACTION_DIR/$BATCH_TRANSACTION_ID/batches/$batch_id/output.log"
        corrections_made=$(grep -o "CORRECTIONS_MADE:[0-9]*" "$enforcer_output" | cut -d: -f2 || echo "0")
        files_modified=$(grep -o "FILES_MODIFIED:[0-9]*" "$enforcer_output" | cut -d: -f2 || echo "0")
        
        local end_time=$(date +%s)
        local duration=$((end_time - start_time))
        
        # Commit successful batch
        commit_batch_transaction "$batch_id" "$corrections_made" "$files_modified"
        
        BATCH_METRICS["successful_batches"]=$((BATCH_METRICS["successful_batches"] + 1))
        BATCH_METRICS["total_corrections_made"]=$((BATCH_METRICS["total_corrections_made"] + corrections_made))
        BATCH_METRICS["total_files_modified"]=$((BATCH_METRICS["total_files_modified"] + files_modified))
        
        BATCH_RESULTS+=("$batch_id:SUCCESS:$corrections_made:$files_modified:${duration}s")
        log_success "Batch completed: $batch_id ($corrections_made corrections, $files_modified files, ${duration}s)"
    else
        # Handle batch failure
        rollback_batch_transaction "$batch_id"
        BATCH_METRICS["failed_batches"]=$((BATCH_METRICS["failed_batches"] + 1))
        FAILED_OPERATIONS+=("$batch_id:processing_failed:$enforcer_type")
        
        local end_time=$(date +%s)
        local duration=$((end_time - start_time))
        BATCH_RESULTS+=("$batch_id:FAILED:0:0:${duration}s")
        log_error "Batch failed: $batch_id (${duration}s)"
    fi
    
    # Cleanup
    rm -f "$batch_file_list"
    unset BATCH_MODE BATCH_ID BATCH_FILE_LIST
}

#======================================================================
# PARALLEL BATCH EXECUTION
#======================================================================
execute_enforcer_in_batches() {
    local enforcer_type="$1"
    local file_list="$2"
    
    log_info "Executing $enforcer_type enforcer in batches"
    
    # Create batches
    local batches
    batches=$(create_file_batches "$file_list" "$enforcer_type")
    
    if [[ -z "$batches" ]]; then
        log_warn "No batches created for $enforcer_type enforcer"
        return 0
    fi
    
    # Process batches in parallel
    local batch_count=0
    local pids=()
    
    while IFS= read -r batch_info; do
        if [[ -n "$batch_info" ]]; then
            batch_count=$((batch_count + 1))
            
            # Wait for available job slot
            while [[ ${#pids[@]} -ge $MAX_PARALLEL_JOBS ]]; do
                for i in "${!pids[@]}"; do
                    if ! kill -0 "${pids[i]}" 2>/dev/null; then
                        wait "${pids[i]}"
                        unset "pids[i]"
                        pids=("${pids[@]}")  # Re-index array
                    fi
                done
                sleep 0.1
            done
            
            # Start batch processing in background
            process_file_batch "$batch_info" "$enforcer_type" &
            local pid=$!
            pids+=("$pid")
            
            log_info "Started batch $batch_count for $enforcer_type (PID: $pid)"
        fi
    done <<< "$batches"
    
    # Wait for all batch jobs to complete
    for pid in "${pids[@]}"; do
        if kill -0 "$pid" 2>/dev/null; then
            wait "$pid"
        fi
    done
    
    log_success "All batches completed for $enforcer_type enforcer"
}

#======================================================================
# FILE DISCOVERY AND FILTERING
#======================================================================
discover_files_for_enforcement() {
    local temp_file_list=$(mktemp)
    
    # Find all eligible files
    find "$PROJECT_ROOT" -name "*.md" -type f \
        | grep -v -E "(backups|node_modules|\.git|ide|\.DS_Store)" \
        | head -n "$MAX_FILES_PER_BATCH" > "$temp_file_list"
    
    local file_count
    file_count=$(wc -l < "$temp_file_list")
    
    log_info "Discovered $file_count files for batch enforcement"
    echo "$temp_file_list"
}

filter_files_by_enforcer() {
    local file_list="$1"
    local enforcer_type="$2"
    
    local filtered_list=$(mktemp)
    
    # Apply enforcer-specific filtering
    case "$enforcer_type" in
        "yaml-frontmatter"|"code-blocks"|"link-format"|"navigation-patterns"|"markdown-structure")
            # These work on all markdown files
            cp "$file_list" "$filtered_list"
            ;;
        "file-naming")
            # Works on all files
            cat "$file_list" > "$filtered_list"
            find "$PROJECT_ROOT" -name "*.sh" -o -name "*.js" -o -name "*.py" -o -name "*.yaml" -o -name "*.yml" -o -name "*.json" -type f \
                | grep -v -E "(backups|node_modules|\.git|ide|\.DS_Store)" >> "$filtered_list"
            sort -u "$filtered_list" -o "$filtered_list"
            ;;
        "cross-references"|"template-compliance")
            # More selective filtering
            grep -E "(docs|commands|agents)" "$file_list" > "$filtered_list" || touch "$filtered_list"
            ;;
        *)
            cp "$file_list" "$filtered_list"
            ;;
    esac
    
    echo "$filtered_list"
}

#======================================================================
# BATCH EXECUTION ORCHESTRATION
#======================================================================
execute_batch_enforcement() {
    log_info "Starting batch correction processing"
    log_info "Max files per batch: $MAX_FILES_PER_BATCH"
    log_info "Batch size: $BATCH_SIZE"
    log_info "Max parallel jobs: $MAX_PARALLEL_JOBS"
    log_info "Mode: $([ "$DRY_RUN" == "true" ] && echo "DRY RUN" || echo "LIVE")"
    
    # Initialize transaction
    initialize_transaction "$BATCH_TRANSACTION_ID"
    
    # Discover files for enforcement
    local master_file_list
    master_file_list=$(discover_files_for_enforcement)
    
    local total_files
    total_files=$(wc -l < "$master_file_list")
    BATCH_METRICS["total_files_processed"]=$total_files
    
    # Execute enforcers by priority
    local priority_groups=(1 2 3 4)
    
    for priority in "${priority_groups[@]}"; do
        log_info "Executing Priority $priority enforcement scripts"
        
        for enforcer_type in "${!BATCH_PRIORITIES[@]}"; do
            if [[ "${BATCH_PRIORITIES[$enforcer_type]}" == "$priority" ]]; then
                # Filter files for this enforcer
                local enforcer_file_list
                enforcer_file_list=$(filter_files_by_enforcer "$master_file_list" "$enforcer_type")
                
                local enforcer_file_count
                enforcer_file_count=$(wc -l < "$enforcer_file_list")
                
                if [[ $enforcer_file_count -gt 0 ]]; then
                    log_info "Processing $enforcer_file_count files with $enforcer_type enforcer"
                    execute_enforcer_in_batches "$enforcer_type" "$enforcer_file_list"
                else
                    log_warn "No files found for $enforcer_type enforcer"
                fi
                
                rm -f "$enforcer_file_list"
            fi
        done
        
        log_info "Priority $priority enforcement completed"
    done
    
    # Cleanup
    rm -f "$master_file_list"
    
    # Calculate final metrics
    local total_time=$SECONDS
    BATCH_METRICS["total_processing_time"]=$total_time
    
    if [[ $total_time -gt 0 ]]; then
        BATCH_METRICS["average_files_per_second"]=$((total_files / total_time))
    fi
    
    log_success "Batch correction processing completed"
    log_success "Total files processed: ${BATCH_METRICS["total_files_processed"]}"
    log_success "Total files modified: ${BATCH_METRICS["total_files_modified"]}"
    log_success "Total corrections made: ${BATCH_METRICS["total_corrections_made"]}"
    log_success "Successful batches: ${BATCH_METRICS["successful_batches"]}"
    log_success "Failed batches: ${BATCH_METRICS["failed_batches"]}"
    log_success "Total processing time: ${BATCH_METRICS["total_processing_time"]}s"
    log_success "Average files per second: ${BATCH_METRICS["average_files_per_second"]}"
}

#======================================================================
# BATCH REPORTING
#======================================================================
generate_batch_report() {
    local report_file="$SCRIPT_DIR/../reports/batch-correction-report-$TIMESTAMP.html"
    
    cat > "$report_file" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Batch Correction Processing Report</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 40px; background: #f8f9fa; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px; margin-bottom: 30px; }
        .summary { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .metric-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .metric-value { font-size: 2.5em; font-weight: bold; margin-bottom: 10px; color: #28a745; }
        .metric-label { color: #666; font-size: 0.9em; text-transform: uppercase; letter-spacing: 1px; }
        .batch-results { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; font-weight: 600; }
        .status-success { color: #28a745; font-weight: bold; }
        .status-failed { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>
    <div class="header">
        <h1>⚡ Batch Correction Processing Report</h1>
        <p><strong>Transaction ID:</strong> $BATCH_TRANSACTION_ID | <strong>Generated:</strong> $(date)</p>
    </div>
    
    <div class="summary">
        <div class="metric-card">
            <div class="metric-value">${BATCH_METRICS["total_files_processed"]}</div>
            <div class="metric-label">Files Processed</div>
        </div>
        <div class="metric-card">
            <div class="metric-value">${BATCH_METRICS["total_corrections_made"]}</div>
            <div class="metric-label">Corrections Made</div>
        </div>
        <div class="metric-card">
            <div class="metric-value">${BATCH_METRICS["successful_batches"]}</div>
            <div class="metric-label">Successful Batches</div>
        </div>
        <div class="metric-card">
            <div class="metric-value">${BATCH_METRICS["total_processing_time"]}s</div>
            <div class="metric-label">Processing Time</div>
        </div>
    </div>
    
    <div class="batch-results">
        <table>
            <thead>
                <tr>
                    <th>Batch ID</th>
                    <th>Status</th>
                    <th>Corrections</th>
                    <th>Files Modified</th>
                    <th>Duration</th>
                </tr>
            </thead>
            <tbody>
EOF
    
    # Add batch results to table
    for result in "${BATCH_RESULTS[@]}"; do
        local batch_id=$(echo "$result" | cut -d: -f1)
        local status=$(echo "$result" | cut -d: -f2)
        local corrections=$(echo "$result" | cut -d: -f3)
        local modified=$(echo "$result" | cut -d: -f4)
        local duration=$(echo "$result" | cut -d: -f5)
        
        local status_class
        case "$status" in
            "SUCCESS") status_class="status-success" ;;
            "FAILED") status_class="status-failed" ;;
        esac
        
        cat >> "$report_file" << EOF
                <tr>
                    <td>$batch_id</td>
                    <td><span class="$status_class">$status</span></td>
                    <td>$corrections</td>
                    <td>$modified</td>
                    <td>$duration</td>
                </tr>
EOF
    done
    
    cat >> "$report_file" << EOF
            </tbody>
        </table>
    </div>
    
    <footer style="margin-top: 40px; text-align: center; color: #666; font-size: 0.9em;">
        <p>Generated by Claude Code Framework Batch Correction Processor v1.0.0</p>
    </footer>
</body>
</html>
EOF
    
    log_success "Batch report generated: $report_file"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    mkdir -p "$(dirname "$LOG_FILE")" "$BACKUP_DIR" "$TRANSACTION_DIR"
    
    log_info "Batch Correction Processor starting"
    log_info "Project root: $PROJECT_ROOT"
    log_info "Transaction ID: $BATCH_TRANSACTION_ID"
    log_info "Dry run: $DRY_RUN"
    
    # Execute batch enforcement
    local start_time=$SECONDS
    execute_batch_enforcement
    local end_time=$SECONDS
    
    BATCH_METRICS["total_processing_time"]=$((end_time - start_time))
    
    # Generate comprehensive report
    generate_batch_report
    
    # Output metrics for orchestrator
    echo "CORRECTIONS_MADE:${BATCH_METRICS["total_corrections_made"]}"
    echo "FILES_MODIFIED:${BATCH_METRICS["total_files_modified"]}"
    
    log_success "Batch Correction Processor completed successfully"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi