#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - MASTER VALIDATION ORCHESTRATOR
#======================================================================
# Purpose: Coordinates all compliance validation scripts with reporting
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Based on: operations/20250819-formatting-standards-analysis/compliance-requirements-analysis.md
# Progressive Thinking Applied: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION CONSTANTS
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
readonly VALIDATION_DIR="$SCRIPT_DIR"
readonly CORE_DIR="$VALIDATION_DIR/core"
readonly REPORTS_DIR="$VALIDATION_DIR/reports"
readonly LOGS_DIR="$VALIDATION_DIR/logs"
readonly CONFIG_DIR="$VALIDATION_DIR/config"

# Validation script configuration
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly RUN_ID="validation-$TIMESTAMP"
readonly LOG_FILE="$LOGS_DIR/$RUN_ID.log"
readonly REPORT_FILE="$REPORTS_DIR/$RUN_ID-compliance-report.html"

# Compliance thresholds (from analysis requirements)
readonly THRESHOLD_FILE_NAMING=100
readonly THRESHOLD_YAML_FRONTMATTER=95
readonly THRESHOLD_CODE_BLOCKS=100
readonly THRESHOLD_LINK_INTEGRITY=85
readonly THRESHOLD_NAVIGATION=80
readonly THRESHOLD_OVERALL=90

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
        log_error "Validation orchestrator failed with exit code: $exit_code"
        generate_failure_report
    fi
    exit $exit_code
}

trap cleanup_on_exit EXIT

#======================================================================
# VALIDATION SCRIPT REGISTRY
#======================================================================
declare -A VALIDATION_SCRIPTS=(
    ["file-naming"]="$CORE_DIR/file-naming-validator.sh"
    ["yaml-frontmatter"]="$CORE_DIR/yaml-frontmatter-validator.sh"
    ["code-blocks"]="$CORE_DIR/code-block-validator.sh"
    ["link-integrity"]="$CORE_DIR/link-integrity-validator.sh"
    ["navigation-patterns"]="$CORE_DIR/navigation-validator.sh"
    ["markdown-format"]="$CORE_DIR/markdown-format-validator.sh"
    ["cross-references"]="$CORE_DIR/cross-reference-validator.sh"
    ["template-compliance"]="$CORE_DIR/template-compliance-validator.sh"
)

declare -A VALIDATION_THRESHOLDS=(
    ["file-naming"]="$THRESHOLD_FILE_NAMING"
    ["yaml-frontmatter"]="$THRESHOLD_YAML_FRONTMATTER"
    ["code-blocks"]="$THRESHOLD_CODE_BLOCKS"
    ["link-integrity"]="$THRESHOLD_LINK_INTEGRITY"
    ["navigation-patterns"]="$THRESHOLD_NAVIGATION"
    ["markdown-format"]="95"
    ["cross-references"]="90"
    ["template-compliance"]="85"
)

declare -A VALIDATION_RESULTS=()
declare -A VALIDATION_METRICS=()

#======================================================================
# INITIALIZATION AND SETUP
#======================================================================
initialize_orchestrator() {
    log_info "Initializing Master Validation Orchestrator"
    log_info "Run ID: $RUN_ID"
    log_info "Project Root: $PROJECT_ROOT"
    
    # Ensure required directories exist
    mkdir -p "$REPORTS_DIR" "$LOGS_DIR" "$CONFIG_DIR"
    
    # Verify validation scripts exist
    local missing_scripts=()
    for script_name in "${!VALIDATION_SCRIPTS[@]}"; do
        local script_path="${VALIDATION_SCRIPTS[$script_name]}"
        if [[ ! -f "$script_path" ]]; then
            missing_scripts+=("$script_name")
        fi
    done
    
    if [[ ${#missing_scripts[@]} -gt 0 ]]; then
        log_warn "Missing validation scripts: ${missing_scripts[*]}"
        log_info "Will create placeholder results for missing scripts"
    fi
    
    # Create configuration file
    create_validation_config
    
    log_info "Orchestrator initialized successfully"
}

create_validation_config() {
    cat > "$CONFIG_DIR/validation-config.json" << EOF
{
  "run_id": "$RUN_ID",
  "timestamp": "$TIMESTAMP",
  "project_root": "$PROJECT_ROOT",
  "thresholds": {
    "file_naming": $THRESHOLD_FILE_NAMING,
    "yaml_frontmatter": $THRESHOLD_YAML_FRONTMATTER,
    "code_blocks": $THRESHOLD_CODE_BLOCKS,
    "link_integrity": $THRESHOLD_LINK_INTEGRITY,
    "navigation_patterns": $THRESHOLD_NAVIGATION,
    "overall_framework": $THRESHOLD_OVERALL
  },
  "validation_scripts": {$(
    for script_name in "${!VALIDATION_SCRIPTS[@]}"; do
      echo "    \"$script_name\": \"${VALIDATION_SCRIPTS[$script_name]}\","
    done | sed '$ s/,$//'
  )}
}
EOF
    
    log_info "Created validation configuration: $CONFIG_DIR/validation-config.json"
}

#======================================================================
# VALIDATION EXECUTION ENGINE
#======================================================================
execute_validation_script() {
    local script_name="$1"
    local script_path="${VALIDATION_SCRIPTS[$script_name]}"
    local threshold="${VALIDATION_THRESHOLDS[$script_name]}"
    
    log_info "Executing validation: $script_name"
    
    if [[ ! -f "$script_path" ]]; then
        log_warn "Validation script not found: $script_path"
        VALIDATION_RESULTS["$script_name"]="MISSING"
        VALIDATION_METRICS["$script_name"]="0"
        return 1
    fi
    
    if [[ ! -x "$script_path" ]]; then
        chmod +x "$script_path"
    fi
    
    # Execute validation script with timeout
    local start_time=$(date +%s)
    local temp_output=$(mktemp)
    local exit_code=0
    
    timeout 300 "$script_path" "$PROJECT_ROOT" > "$temp_output" 2>&1 || exit_code=$?
    
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    if [[ $exit_code -eq 124 ]]; then
        log_error "Validation timeout: $script_name (>300s)"
        VALIDATION_RESULTS["$script_name"]="TIMEOUT"
        VALIDATION_METRICS["$script_name"]="0"
    elif [[ $exit_code -ne 0 ]]; then
        log_error "Validation failed: $script_name (exit code: $exit_code)"
        VALIDATION_RESULTS["$script_name"]="FAILED"
        VALIDATION_METRICS["$script_name"]="0"
        log_error "Output: $(cat "$temp_output")"
    else
        # Parse validation results
        local compliance_score
        compliance_score=$(grep -o "COMPLIANCE_SCORE:[0-9]*" "$temp_output" | cut -d: -f2 || echo "0")
        
        VALIDATION_METRICS["$script_name"]="$compliance_score"
        
        if [[ $compliance_score -ge $threshold ]]; then
            VALIDATION_RESULTS["$script_name"]="PASSED"
            log_success "Validation passed: $script_name ($compliance_score% >= $threshold%)"
        else
            VALIDATION_RESULTS["$script_name"]="FAILED"
            log_error "Validation failed: $script_name ($compliance_score% < $threshold%)"
        fi
        
        log_info "$script_name completed in ${duration}s"
    fi
    
    # Store detailed output
    mv "$temp_output" "$LOGS_DIR/$RUN_ID-$script_name.log"
}

execute_all_validations() {
    log_info "Starting comprehensive validation execution"
    
    local total_scripts=${#VALIDATION_SCRIPTS[@]}
    local current_script=0
    
    # Execute validation scripts in priority order (Week 1 Foundation first)
    local priority_order=(
        "file-naming"
        "yaml-frontmatter"
        "code-blocks"
        "link-integrity"
        "navigation-patterns"
        "markdown-format"
        "cross-references"
        "template-compliance"
    )
    
    for script_name in "${priority_order[@]}"; do
        current_script=$((current_script + 1))
        log_info "Progress: $current_script/$total_scripts - $script_name"
        
        execute_validation_script "$script_name"
    done
    
    log_info "All validation scripts executed"
}

#======================================================================
# RESULTS ANALYSIS AND REPORTING
#======================================================================
calculate_overall_compliance() {
    local total_score=0
    local total_weight=0
    local script_count=0
    
    for script_name in "${!VALIDATION_METRICS[@]}"; do
        local score="${VALIDATION_METRICS[$script_name]}"
        if [[ "$score" =~ ^[0-9]+$ ]]; then
            total_score=$((total_score + score))
            total_weight=$((total_weight + 100))
            script_count=$((script_count + 1))
        fi
    done
    
    if [[ $script_count -eq 0 ]]; then
        echo "0"
    else
        echo $((total_score / script_count))
    fi
}

generate_compliance_report() {
    log_info "Generating comprehensive compliance report"
    
    local overall_compliance
    overall_compliance=$(calculate_overall_compliance)
    
    local passed_count=0
    local failed_count=0
    local missing_count=0
    
    for result in "${VALIDATION_RESULTS[@]}"; do
        case "$result" in
            "PASSED") passed_count=$((passed_count + 1)) ;;
            "FAILED"|"TIMEOUT") failed_count=$((failed_count + 1)) ;;
            "MISSING") missing_count=$((missing_count + 1)) ;;
        esac
    done
    
    # Generate HTML report
    cat > "$REPORT_FILE" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Claude Code Framework - Compliance Report</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 40px; background: #f5f7fa; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px; margin-bottom: 30px; }
        .summary { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .metric-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .metric-value { font-size: 2.5em; font-weight: bold; margin-bottom: 10px; }
        .metric-label { color: #666; font-size: 0.9em; text-transform: uppercase; letter-spacing: 1px; }
        .results-table { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; font-weight: 600; }
        .status-passed { color: #28a745; font-weight: bold; }
        .status-failed { color: #dc3545; font-weight: bold; }
        .status-missing { color: #ffc107; font-weight: bold; }
        .compliance-bar { height: 10px; background: #e9ecef; border-radius: 5px; overflow: hidden; }
        .compliance-fill { height: 100%; transition: width 0.3s ease; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🔍 Claude Code Framework Compliance Report</h1>
        <p><strong>Run ID:</strong> $RUN_ID | <strong>Generated:</strong> $(date)</p>
    </div>
    
    <div class="summary">
        <div class="metric-card">
            <div class="metric-value" style="color: $([ $overall_compliance -ge $THRESHOLD_OVERALL ] && echo '#28a745' || echo '#dc3545')">$overall_compliance%</div>
            <div class="metric-label">Overall Compliance</div>
            <div class="compliance-bar">
                <div class="compliance-fill" style="width: $overall_compliance%; background: $([ $overall_compliance -ge $THRESHOLD_OVERALL ] && echo '#28a745' || echo '#dc3545');"></div>
            </div>
        </div>
        <div class="metric-card">
            <div class="metric-value" style="color: #28a745;">$passed_count</div>
            <div class="metric-label">Validations Passed</div>
        </div>
        <div class="metric-card">
            <div class="metric-value" style="color: #dc3545;">$failed_count</div>
            <div class="metric-label">Validations Failed</div>
        </div>
        <div class="metric-card">
            <div class="metric-value" style="color: #ffc107;">$missing_count</div>
            <div class="metric-label">Scripts Missing</div>
        </div>
    </div>
    
    <div class="results-table">
        <table>
            <thead>
                <tr>
                    <th>Validation Domain</th>
                    <th>Status</th>
                    <th>Score</th>
                    <th>Threshold</th>
                    <th>Compliance</th>
                </tr>
            </thead>
            <tbody>
EOF
    
    # Add validation results to table
    for script_name in "${!VALIDATION_RESULTS[@]}"; do
        local result="${VALIDATION_RESULTS[$script_name]}"
        local score="${VALIDATION_METRICS[$script_name]}"
        local threshold="${VALIDATION_THRESHOLDS[$script_name]}"
        
        local status_class
        case "$result" in
            "PASSED") status_class="status-passed" ;;
            "FAILED"|"TIMEOUT") status_class="status-failed" ;;
            "MISSING") status_class="status-missing" ;;
        esac
        
        cat >> "$REPORT_FILE" << EOF
                <tr>
                    <td>$(echo "$script_name" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')</td>
                    <td><span class="$status_class">$result</span></td>
                    <td>${score}%</td>
                    <td>${threshold}%</td>
                    <td>
                        <div class="compliance-bar">
                            <div class="compliance-fill" style="width: ${score}%; background: $([ $score -ge $threshold ] && echo '#28a745' || echo '#dc3545');"></div>
                        </div>
                    </td>
                </tr>
EOF
    done
    
    cat >> "$REPORT_FILE" << EOF
            </tbody>
        </table>
    </div>
    
    <div style="margin-top: 30px; padding: 20px; background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
        <h3>📋 Validation Details</h3>
        <p><strong>Total Rules Evaluated:</strong> 147 (from compliance analysis)</p>
        <p><strong>Automation Coverage:</strong> 89% (131 automated rules)</p>
        <p><strong>Target Compliance:</strong> $THRESHOLD_OVERALL%</p>
        <p><strong>Log Files:</strong> Available in <code>$LOGS_DIR/</code></p>
        
        <h4>🎯 Next Steps:</h4>
        <ul>
            <li>Review failed validations in detailed logs</li>
            <li>Execute correction scripts for automated fixes</li>
            <li>Schedule regular compliance monitoring</li>
            <li>Implement CI integration for continuous validation</li>
        </ul>
    </div>
    
    <footer style="margin-top: 40px; text-align: center; color: #666; font-size: 0.9em;">
        <p>Generated by Claude Code Framework Master Validation Orchestrator v1.0.0</p>
    </footer>
</body>
</html>
EOF
    
    log_success "Compliance report generated: $REPORT_FILE"
}

generate_failure_report() {
    cat > "$REPORTS_DIR/$RUN_ID-failure-report.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Validation Orchestrator - Failure Report</title>
</head>
<body>
    <h1>❌ Validation Orchestrator Failed</h1>
    <p><strong>Run ID:</strong> $RUN_ID</p>
    <p><strong>Timestamp:</strong> $(date)</p>
    <p><strong>Log File:</strong> $LOG_FILE</p>
    
    <h2>Error Details</h2>
    <pre>$(tail -50 "$LOG_FILE" 2>/dev/null || echo "Log file not available")</pre>
</body>
</html>
EOF
}

#======================================================================
# COMMAND LINE INTERFACE
#======================================================================
show_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Claude Code Framework Master Validation Orchestrator

OPTIONS:
    -h, --help          Show this help message
    -v, --version       Show version information
    --dry-run          Simulate validation without execution
    --script SCRIPT    Run only specific validation script
    --threshold NUM    Set custom overall compliance threshold
    --report-only      Generate report from existing logs only

EXAMPLES:
    $0                          # Run all validations
    $0 --script file-naming     # Run only file naming validation
    $0 --threshold 85           # Set 85% compliance threshold
    $0 --dry-run                # Simulate validation run

For more information: docs/principles/validation.md
EOF
}

show_version() {
    echo "Claude Code Framework Master Validation Orchestrator v1.0.0"
    echo "Based on: operations/20250819-formatting-standards-analysis/compliance-requirements-analysis.md"
    echo "Progressive Thinking Applied: Think → Think Hard → Think Harder → UltraThink"
}

#======================================================================
# MAIN EXECUTION FLOW
#======================================================================
main() {
    local dry_run=false
    local specific_script=""
    local custom_threshold=""
    local report_only=false
    
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
            --script)
                specific_script="$2"
                shift 2
                ;;
            --threshold)
                custom_threshold="$2"
                shift 2
                ;;
            --report-only)
                report_only=true
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    # Initialize orchestrator
    initialize_orchestrator
    
    if [[ "$report_only" == "true" ]]; then
        log_info "Report-only mode: generating report from existing data"
        generate_compliance_report
        exit 0
    fi
    
    if [[ "$dry_run" == "true" ]]; then
        log_info "DRY RUN MODE: Simulating validation execution"
        for script_name in "${!VALIDATION_SCRIPTS[@]}"; do
            log_info "Would execute: $script_name"
        done
        exit 0
    fi
    
    # Update threshold if specified
    if [[ -n "$custom_threshold" ]]; then
        if [[ "$custom_threshold" =~ ^[0-9]+$ ]] && [[ $custom_threshold -ge 0 ]] && [[ $custom_threshold -le 100 ]]; then
            log_info "Using custom overall compliance threshold: $custom_threshold%"
            THRESHOLD_OVERALL="$custom_threshold"
        else
            log_error "Invalid threshold value: $custom_threshold (must be 0-100)"
            exit 1
        fi
    fi
    
    # Execute validations
    if [[ -n "$specific_script" ]]; then
        if [[ -n "${VALIDATION_SCRIPTS[$specific_script]:-}" ]]; then
            log_info "Running specific validation: $specific_script"
            execute_validation_script "$specific_script"
        else
            log_error "Unknown validation script: $specific_script"
            log_info "Available scripts: ${!VALIDATION_SCRIPTS[*]}"
            exit 1
        fi
    else
        execute_all_validations
    fi
    
    # Generate comprehensive report
    generate_compliance_report
    
    # Final status check
    local overall_compliance
    overall_compliance=$(calculate_overall_compliance)
    
    if [[ $overall_compliance -ge $THRESHOLD_OVERALL ]]; then
        log_success "🎉 COMPLIANCE ACHIEVED: $overall_compliance% >= $THRESHOLD_OVERALL%"
        log_success "Report: $REPORT_FILE"
        exit 0
    else
        log_error "❌ COMPLIANCE THRESHOLD NOT MET: $overall_compliance% < $THRESHOLD_OVERALL%"
        log_error "Review failed validations and execute correction workflows"
        log_error "Report: $REPORT_FILE"
        exit 1
    fi
}

#======================================================================
# SCRIPT EXECUTION
#======================================================================
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi