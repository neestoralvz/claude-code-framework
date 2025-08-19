#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - ENFORCEMENT DASHBOARD GENERATOR
#======================================================================
# Purpose: Generates comprehensive enforcement activity dashboard with metrics and analytics
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Features: Real-time metrics, trend analysis, success rates, rollback capabilities
# Safety: Read-only dashboard generation with comprehensive analytics
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly LOG_FILE="${SCRIPT_DIR}/logs/enforcement-dashboard-$TIMESTAMP.log"

# Dashboard configuration
readonly DASHBOARD_FILE="${SCRIPT_DIR}/reports/enforcement-dashboard-$TIMESTAMP.html"
readonly LIVE_DASHBOARD_FILE="${SCRIPT_DIR}/reports/enforcement-dashboard-live.html"
readonly ANALYTICS_DAYS="${ANALYTICS_DAYS:-30}"
readonly MAX_RECENT_RUNS="${MAX_RECENT_RUNS:-50}"

# Directories for data collection
readonly ENFORCEMENT_LOGS_DIR="${SCRIPT_DIR}/logs"
readonly ENFORCEMENT_REPORTS_DIR="${SCRIPT_DIR}/reports"
readonly ENFORCEMENT_BACKUPS_DIR="${SCRIPT_DIR}/backups"
readonly VALIDATION_LOGS_DIR="${SCRIPT_DIR}/../validation/logs"
readonly VALIDATION_REPORTS_DIR="${SCRIPT_DIR}/../validation/reports"

#======================================================================
# LOGGING AND METRICS
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

declare -A DASHBOARD_METRICS=(
    ["total_enforcement_runs"]=0
    ["successful_runs"]=0
    ["failed_runs"]=0
    ["total_corrections_made"]=0
    ["total_files_processed"]=0
    ["total_files_modified"]=0
    ["average_corrections_per_run"]=0
    ["success_rate_percentage"]=0
    ["most_active_enforcer"]=""
    ["compliance_improvement_total"]=0
)

declare -A ENFORCEMENT_STATISTICS=()
declare -a RECENT_ENFORCEMENT_RUNS=()
declare -a TREND_DATA=()

#======================================================================
# DATA COLLECTION FUNCTIONS
#======================================================================
collect_enforcement_run_data() {
    log "Collecting enforcement run data from the last $ANALYTICS_DAYS days"
    
    local cutoff_date
    cutoff_date=$(date -d "$ANALYTICS_DAYS days ago" +%Y%m%d)
    
    # Collect data from enforcement logs
    if [[ -d "$ENFORCEMENT_LOGS_DIR" ]]; then
        while IFS= read -r -d '' log_file; do
            if [[ -f "$log_file" ]]; then
                local log_date
                log_date=$(basename "$log_file" | grep -o '[0-9]\{8\}' | head -n 1)
                
                if [[ -n "$log_date" ]] && [[ "$log_date" -ge "$cutoff_date" ]]; then
                    analyze_enforcement_log "$log_file"
                fi
            fi
        done < <(find "$ENFORCEMENT_LOGS_DIR" -name "*.log" -type f -print0)
    fi
    
    # Collect data from enforcement reports  
    if [[ -d "$ENFORCEMENT_REPORTS_DIR" ]]; then
        while IFS= read -r -d '' report_file; do
            if [[ -f "$report_file" ]]; then
                local report_date
                report_date=$(basename "$report_file" | grep -o '[0-9]\{8\}' | head -n 1)
                
                if [[ -n "$report_date" ]] && [[ "$report_date" -ge "$cutoff_date" ]]; then
                    analyze_enforcement_report "$report_file"
                fi
            fi
        done < <(find "$ENFORCEMENT_REPORTS_DIR" -name "*.html" -type f -print0)
    done
    
    log "Enforcement run data collection completed"
}

analyze_enforcement_log() {
    local log_file="$1"
    
    # Extract key metrics from log file
    local run_id
    run_id=$(basename "$log_file" .log)
    
    # Determine if run was successful
    local status="UNKNOWN"
    if grep -q "completed successfully" "$log_file"; then
        status="SUCCESS"
        DASHBOARD_METRICS["successful_runs"]=$((DASHBOARD_METRICS["successful_runs"] + 1))
    elif grep -q -E "(failed|error|timeout)" "$log_file"; then
        status="FAILED" 
        DASHBOARD_METRICS["failed_runs"]=$((DASHBOARD_METRICS["failed_runs"] + 1))
    fi
    
    # Extract corrections made
    local corrections_made
    corrections_made=$(grep -o "CORRECTIONS_MADE:[0-9]*" "$log_file" | cut -d: -f2 | tail -n 1 || echo "0")
    
    # Extract files modified
    local files_modified
    files_modified=$(grep -o "FILES_MODIFIED:[0-9]*" "$log_file" | cut -d: -f2 | tail -n 1 || echo "0")
    
    # Extract timestamp
    local timestamp
    timestamp=$(head -n 5 "$log_file" | grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\} [0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}" | head -n 1 || echo "Unknown")
    
    # Add to recent runs (if within limit)
    if [[ ${#RECENT_ENFORCEMENT_RUNS[@]} -lt $MAX_RECENT_RUNS ]]; then
        RECENT_ENFORCEMENT_RUNS+=("$run_id|$timestamp|$status|$corrections_made|$files_modified")
    fi
    
    # Update cumulative metrics
    DASHBOARD_METRICS["total_enforcement_runs"]=$((DASHBOARD_METRICS["total_enforcement_runs"] + 1))
    DASHBOARD_METRICS["total_corrections_made"]=$((DASHBOARD_METRICS["total_corrections_made"] + corrections_made))
    DASHBOARD_METRICS["total_files_modified"]=$((DASHBOARD_METRICS["total_files_modified"] + files_modified))
}

analyze_enforcement_report() {
    local report_file="$1"
    
    if [[ -f "$report_file" ]]; then
        # Extract compliance improvement from HTML report
        local improvement
        improvement=$(grep -o "Compliance Improvement.*[0-9]*%" "$report_file" | grep -o "[0-9]*" | tail -n 1 || echo "0")
        
        if [[ "$improvement" =~ ^[0-9]+$ ]]; then
            DASHBOARD_METRICS["compliance_improvement_total"]=$((DASHBOARD_METRICS["compliance_improvement_total"] + improvement))
        fi
    fi
}

collect_enforcer_statistics() {
    log "Collecting individual enforcer statistics"
    
    # Initialize enforcer counters
    local enforcer_types=(
        "yaml-frontmatter"
        "file-naming"
        "code-blocks"
        "link-format"
        "navigation-patterns"
        "markdown-structure"
        "cross-references"
        "template-compliance"
    )
    
    for enforcer in "${enforcer_types[@]}"; do
        ENFORCEMENT_STATISTICS["${enforcer}_runs"]=0
        ENFORCEMENT_STATISTICS["${enforcer}_corrections"]=0
        ENFORCEMENT_STATISTICS["${enforcer}_files_modified"]=0
    done
    
    # Analyze enforcer-specific logs
    for enforcer in "${enforcer_types[@]}"; do
        while IFS= read -r -d '' log_file; do
            if [[ -f "$log_file" ]]; then
                local corrections
                corrections=$(grep -o "CORRECTIONS_MADE:[0-9]*" "$log_file" | cut -d: -f2 | tail -n 1 || echo "0")
                
                local files_modified
                files_modified=$(grep -o "FILES_MODIFIED:[0-9]*" "$log_file" | cut -d: -f2 | tail -n 1 || echo "0")
                
                ENFORCEMENT_STATISTICS["${enforcer}_runs"]=$((ENFORCEMENT_STATISTICS["${enforcer}_runs"] + 1))
                ENFORCEMENT_STATISTICS["${enforcer}_corrections"]=$((ENFORCEMENT_STATISTICS["${enforcer}_corrections"] + corrections))
                ENFORCEMENT_STATISTICS["${enforcer}_files_modified"]=$((ENFORCEMENT_STATISTICS["${enforcer}_files_modified"] + files_modified))
            fi
        done < <(find "$ENFORCEMENT_LOGS_DIR" -name "*${enforcer}*" -type f -print0 2>/dev/null || true)
    done
    
    # Determine most active enforcer
    local max_corrections=0
    local most_active=""
    
    for enforcer in "${enforcer_types[@]}"; do
        local corrections=${ENFORCEMENT_STATISTICS["${enforcer}_corrections"]}
        if [[ $corrections -gt $max_corrections ]]; then
            max_corrections=$corrections
            most_active="$enforcer"
        fi
    done
    
    DASHBOARD_METRICS["most_active_enforcer"]="$most_active"
    
    log "Enforcer statistics collection completed"
}

calculate_dashboard_metrics() {
    log "Calculating dashboard metrics"
    
    # Calculate success rate
    local total_runs=${DASHBOARD_METRICS["total_enforcement_runs"]}
    local successful_runs=${DASHBOARD_METRICS["successful_runs"]}
    
    if [[ $total_runs -gt 0 ]]; then
        DASHBOARD_METRICS["success_rate_percentage"]=$(( (successful_runs * 100) / total_runs ))
        DASHBOARD_METRICS["average_corrections_per_run"]=$(( DASHBOARD_METRICS["total_corrections_made"] / total_runs ))
    fi
    
    # Generate trend data (last 7 days)
    for i in {6..0}; do
        local trend_date
        trend_date=$(date -d "$i days ago" +%Y-%m-%d)
        
        local daily_corrections=0
        local daily_files=0
        
        # Count corrections and files for this day
        for run in "${RECENT_ENFORCEMENT_RUNS[@]}"; do
            local run_date=$(echo "$run" | cut -d'|' -f2 | cut -d' ' -f1)
            if [[ "$run_date" == "$trend_date" ]]; then
                local corrections=$(echo "$run" | cut -d'|' -f4)
                local files=$(echo "$run" | cut -d'|' -f5)
                daily_corrections=$((daily_corrections + corrections))
                daily_files=$((daily_files + files))
            fi
        done
        
        TREND_DATA+=("$trend_date|$daily_corrections|$daily_files")
    done
    
    log "Dashboard metrics calculation completed"
}

get_system_health_status() {
    local validation_health="UNKNOWN"
    local enforcement_health="UNKNOWN"
    
    # Check validation system health
    if [[ -d "$VALIDATION_LOGS_DIR" ]]; then
        local recent_validation
        recent_validation=$(find "$VALIDATION_LOGS_DIR" -name "*.log" -type f -mtime -1 | head -n 1)
        
        if [[ -n "$recent_validation" ]] && grep -q "completed successfully" "$recent_validation" 2>/dev/null; then
            validation_health="HEALTHY"
        elif [[ -n "$recent_validation" ]]; then
            validation_health="WARNING"
        else
            validation_health="NO_RECENT_ACTIVITY"
        fi
    fi
    
    # Check enforcement system health
    local recent_enforcement
    recent_enforcement=$(find "$ENFORCEMENT_LOGS_DIR" -name "*.log" -type f -mtime -1 | head -n 1)
    
    if [[ -n "$recent_enforcement" ]] && grep -q "completed successfully" "$recent_enforcement" 2>/dev/null; then
        enforcement_health="HEALTHY"
    elif [[ -n "$recent_enforcement" ]]; then
        enforcement_health="WARNING"
    else
        enforcement_health="NO_RECENT_ACTIVITY"
    fi
    
    echo "$validation_health|$enforcement_health"
}

get_backup_status() {
    local backup_count=0
    local backup_size="0"
    local oldest_backup=""
    local newest_backup=""
    
    if [[ -d "$ENFORCEMENT_BACKUPS_DIR" ]]; then
        backup_count=$(find "$ENFORCEMENT_BACKUPS_DIR" -type d -name "enforcement-*" | wc -l)
        
        if [[ $backup_count -gt 0 ]]; then
            backup_size=$(du -sh "$ENFORCEMENT_BACKUPS_DIR" 2>/dev/null | cut -f1 || echo "Unknown")
            oldest_backup=$(find "$ENFORCEMENT_BACKUPS_DIR" -type d -name "enforcement-*" | head -n 1 | xargs basename 2>/dev/null || echo "Unknown")
            newest_backup=$(find "$ENFORCEMENT_BACKUPS_DIR" -type d -name "enforcement-*" | tail -n 1 | xargs basename 2>/dev/null || echo "Unknown")
        fi
    fi
    
    echo "$backup_count|$backup_size|$oldest_backup|$newest_backup"
}

#======================================================================
# DASHBOARD GENERATION
#======================================================================
generate_enforcement_dashboard() {
    log "Generating enforcement dashboard"
    
    # Collect system health and backup status
    local system_health
    system_health=$(get_system_health_status)
    local validation_health=$(echo "$system_health" | cut -d'|' -f1)
    local enforcement_health=$(echo "$system_health" | cut -d'|' -f2)
    
    local backup_status
    backup_status=$(get_backup_status)
    local backup_count=$(echo "$backup_status" | cut -d'|' -f1)
    local backup_size=$(echo "$backup_status" | cut -d'|' -f2)
    local oldest_backup=$(echo "$backup_status" | cut -d'|' -f3)
    local newest_backup=$(echo "$backup_status" | cut -d'|' -f4)
    
    # Generate comprehensive HTML dashboard
    cat > "$DASHBOARD_FILE" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Claude Code Framework - Enforcement Dashboard</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0; 
            padding: 20px; 
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        .container { max-width: 1400px; margin: 0 auto; }
        
        .header { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            color: white; 
            padding: 30px; 
            border-radius: 15px; 
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .header h1 { margin: 0; font-size: 2.5em; }
        .header .subtitle { opacity: 0.9; margin-top: 10px; }
        
        .metrics-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); 
            gap: 20px; 
            margin-bottom: 30px; 
        }
        .metric-card { 
            background: white; 
            padding: 25px; 
            border-radius: 12px; 
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }
        .metric-card:hover { transform: translateY(-5px); }
        .metric-value { 
            font-size: 3em; 
            font-weight: bold; 
            margin-bottom: 10px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .metric-label { 
            color: #666; 
            font-size: 0.9em; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            font-weight: 500;
        }
        
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .panel { 
            background: white; 
            border-radius: 12px; 
            overflow: hidden; 
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .panel-header { 
            background: #f8f9fa; 
            padding: 20px; 
            border-bottom: 1px solid #eee;
            font-weight: 600;
            font-size: 1.1em;
        }
        .panel-content { padding: 20px; }
        
        .status-indicator {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8em;
            font-weight: 600;
            text-transform: uppercase;
        }
        .status-healthy { background: #d4edda; color: #155724; }
        .status-warning { background: #fff3cd; color: #856404; }
        .status-error { background: #f8d7da; color: #721c24; }
        
        .recent-runs-table {
            width: 100%;
            border-collapse: collapse;
        }
        .recent-runs-table th,
        .recent-runs-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .recent-runs-table th {
            background: #f8f9fa;
            font-weight: 600;
        }
        
        .enforcer-stats {
            display: grid;
            gap: 15px;
        }
        .enforcer-stat {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }
        
        .trend-chart {
            height: 200px;
            background: #f8f9fa;
            border-radius: 8px;
            display: flex;
            align-items: end;
            justify-content: space-around;
            padding: 20px;
        }
        .trend-bar {
            background: linear-gradient(to top, #667eea, #764ba2);
            border-radius: 4px 4px 0 0;
            min-height: 10px;
            width: 30px;
            position: relative;
        }
        .trend-label {
            position: absolute;
            bottom: -25px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 0.8em;
            color: #666;
        }
        
        .actions-panel {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-top: 30px;
        }
        .action-button {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            text-decoration: none;
            margin-right: 15px;
            margin-bottom: 10px;
            font-weight: 500;
            transition: transform 0.3s ease;
        }
        .action-button:hover { transform: translateY(-2px); }
        
        .footer {
            text-align: center;
            color: #666;
            font-size: 0.9em;
            margin-top: 40px;
            padding: 20px;
        }
    </style>
    
    <script>
        // Auto-refresh dashboard every 5 minutes
        setTimeout(function() {
            location.reload();
        }, 300000);
        
        // Add interactive elements
        document.addEventListener('DOMContentLoaded', function() {
            // Add tooltips to metric cards
            const metricCards = document.querySelectorAll('.metric-card');
            metricCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.boxShadow = '0 10px 25px rgba(0,0,0,0.15)';
                });
                card.addEventListener('mouseleave', function() {
                    this.style.boxShadow = '0 5px 15px rgba(0,0,0,0.1)';
                });
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔧 Enforcement Dashboard</h1>
            <div class="subtitle">Claude Code Framework Automated Correction System</div>
            <div style="margin-top: 15px;">
                <span style="opacity: 0.8;">Last Updated: $(date)</span> |
                <span style="opacity: 0.8;">Analysis Period: Last $ANALYTICS_DAYS days</span>
            </div>
        </div>
        
        <div class="metrics-grid">
            <div class="metric-card">
                <div class="metric-value">${DASHBOARD_METRICS["total_enforcement_runs"]}</div>
                <div class="metric-label">Total Runs</div>
            </div>
            <div class="metric-card">
                <div class="metric-value">${DASHBOARD_METRICS["total_corrections_made"]}</div>
                <div class="metric-label">Corrections Made</div>
            </div>
            <div class="metric-card">
                <div class="metric-value">${DASHBOARD_METRICS["success_rate_percentage"]}%</div>
                <div class="metric-label">Success Rate</div>
            </div>
            <div class="metric-card">
                <div class="metric-value">${DASHBOARD_METRICS["total_files_modified"]}</div>
                <div class="metric-label">Files Modified</div>
            </div>
        </div>
        
        <div class="content-grid">
            <div class="panel">
                <div class="panel-header">📊 Recent Enforcement Runs</div>
                <div class="panel-content">
                    <table class="recent-runs-table">
                        <thead>
                            <tr>
                                <th>Run ID</th>
                                <th>Timestamp</th>
                                <th>Status</th>
                                <th>Corrections</th>
                                <th>Files</th>
                            </tr>
                        </thead>
                        <tbody>
EOF
    
    # Add recent runs to table (limit to 10 most recent)
    local run_count=0
    for run in "${RECENT_ENFORCEMENT_RUNS[@]}"; do
        if [[ $run_count -lt 10 ]]; then
            local run_id=$(echo "$run" | cut -d'|' -f1)
            local timestamp=$(echo "$run" | cut -d'|' -f2)
            local status=$(echo "$run" | cut -d'|' -f3)
            local corrections=$(echo "$run" | cut -d'|' -f4)
            local files=$(echo "$run" | cut -d'|' -f5)
            
            local status_class
            case "$status" in
                "SUCCESS") status_class="status-healthy" ;;
                "FAILED") status_class="status-error" ;;
                *) status_class="status-warning" ;;
            esac
            
            cat >> "$DASHBOARD_FILE" << EOF
                            <tr>
                                <td>$run_id</td>
                                <td>$timestamp</td>
                                <td><span class="status-indicator $status_class">$status</span></td>
                                <td>$corrections</td>
                                <td>$files</td>
                            </tr>
EOF
            run_count=$((run_count + 1))
        fi
    done
    
    cat >> "$DASHBOARD_FILE" << EOF
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div>
                <div class="panel" style="margin-bottom: 20px;">
                    <div class="panel-header">💊 System Health</div>
                    <div class="panel-content">
                        <div style="margin-bottom: 15px;">
                            <strong>Validation System:</strong>
                            <span class="status-indicator $(case "$validation_health" in
                                "HEALTHY") echo "status-healthy" ;;
                                "WARNING") echo "status-warning" ;;
                                *) echo "status-error" ;;
                            esac)">$validation_health</span>
                        </div>
                        <div>
                            <strong>Enforcement System:</strong>
                            <span class="status-indicator $(case "$enforcement_health" in
                                "HEALTHY") echo "status-healthy" ;;
                                "WARNING") echo "status-warning" ;;
                                *) echo "status-error" ;;
                            esac)">$enforcement_health</span>
                        </div>
                    </div>
                </div>
                
                <div class="panel">
                    <div class="panel-header">📦 Backup Status</div>
                    <div class="panel-content">
                        <div><strong>Available Backups:</strong> $backup_count</div>
                        <div><strong>Total Size:</strong> $backup_size</div>
                        <div><strong>Oldest:</strong> $(echo "$oldest_backup" | cut -d'-' -f2- || echo "None")</div>
                        <div><strong>Newest:</strong> $(echo "$newest_backup" | cut -d'-' -f2- || echo "None")</div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="panel">
            <div class="panel-header">⚡ Enforcer Statistics</div>
            <div class="panel-content">
                <div class="enforcer-stats">
EOF
    
    # Add enforcer statistics
    local enforcer_types=(
        "yaml-frontmatter:YAML Frontmatter"
        "file-naming:File Naming"
        "code-blocks:Code Blocks"
        "link-format:Link Format"
        "navigation-patterns:Navigation Patterns"
        "markdown-structure:Markdown Structure"
        "cross-references:Cross References"
        "template-compliance:Template Compliance"
    )
    
    for enforcer_info in "${enforcer_types[@]}"; do
        local enforcer_key=$(echo "$enforcer_info" | cut -d':' -f1)
        local enforcer_name=$(echo "$enforcer_info" | cut -d':' -f2)
        local runs=${ENFORCEMENT_STATISTICS["${enforcer_key}_runs"]:-0}
        local corrections=${ENFORCEMENT_STATISTICS["${enforcer_key}_corrections"]:-0}
        
        cat >> "$DASHBOARD_FILE" << EOF
                    <div class="enforcer-stat">
                        <div>
                            <strong>$enforcer_name</strong><br>
                            <small>$runs runs, $corrections corrections</small>
                        </div>
                        <div style="font-size: 1.5em; font-weight: bold; color: #667eea;">$corrections</div>
                    </div>
EOF
    done
    
    cat >> "$DASHBOARD_FILE" << EOF
                </div>
            </div>
        </div>
        
        <div class="panel" style="margin-top: 30px;">
            <div class="panel-header">📈 Activity Trend (Last 7 Days)</div>
            <div class="panel-content">
                <div class="trend-chart">
EOF
    
    # Add trend data visualization
    local max_corrections=1
    for trend in "${TREND_DATA[@]}"; do
        local corrections=$(echo "$trend" | cut -d'|' -f2)
        if [[ $corrections -gt $max_corrections ]]; then
            max_corrections=$corrections
        fi
    done
    
    for trend in "${TREND_DATA[@]}"; do
        local date=$(echo "$trend" | cut -d'|' -f1 | cut -d'-' -f2-)
        local corrections=$(echo "$trend" | cut -d'|' -f2)
        local height_percent=$(( (corrections * 150) / max_corrections ))
        
        cat >> "$DASHBOARD_FILE" << EOF
                    <div class="trend-bar" style="height: ${height_percent}px;">
                        <div class="trend-label">$date</div>
                    </div>
EOF
    done
    
    cat >> "$DASHBOARD_FILE" << EOF
                </div>
            </div>
        </div>
        
        <div class="actions-panel">
            <h3>🚀 Quick Actions</h3>
            <a href="javascript:location.reload()" class="action-button">🔄 Refresh Dashboard</a>
            <a href="../validation/validation-dashboard-live.html" class="action-button">📊 Validation Dashboard</a>
            <a href="#" onclick="window.open('master-enforcement-orchestrator.sh', '_blank')" class="action-button">⚡ Run Enforcement</a>
            <a href="../logs/" class="action-button">📜 View Logs</a>
            <a href="../backups/" class="action-button">💾 Browse Backups</a>
        </div>
        
        <div class="footer">
            Generated by Claude Code Framework Enforcement Dashboard Generator v1.0.0<br>
            Progressive Thinking Applied: Think → Think Hard → Think Harder → UltraThink<br>
            <em>Dashboard automatically refreshes every 5 minutes</em>
        </div>
    </div>
</body>
</html>
EOF
    
    # Create symbolic link for live dashboard
    ln -sf "$(basename "$DASHBOARD_FILE")" "$LIVE_DASHBOARD_FILE" 2>/dev/null || cp "$DASHBOARD_FILE" "$LIVE_DASHBOARD_FILE"
    
    log "Enforcement dashboard generated: $DASHBOARD_FILE"
    log "Live dashboard available: $LIVE_DASHBOARD_FILE"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    mkdir -p "$(dirname "$LOG_FILE")" "$(dirname "$DASHBOARD_FILE")"
    
    log "Enforcement Dashboard Generator starting"
    log "Analytics period: $ANALYTICS_DAYS days"
    log "Max recent runs: $MAX_RECENT_RUNS"
    
    # Collect all enforcement data
    collect_enforcement_run_data
    collect_enforcer_statistics
    calculate_dashboard_metrics
    
    # Generate comprehensive dashboard
    generate_enforcement_dashboard
    
    log "Dashboard generation completed successfully"
    log "Dashboard file: $DASHBOARD_FILE"
    log "Live dashboard: $LIVE_DASHBOARD_FILE"
    
    # Output summary metrics
    echo "Total enforcement runs: ${DASHBOARD_METRICS["total_enforcement_runs"]}"
    echo "Success rate: ${DASHBOARD_METRICS["success_rate_percentage"]}%"
    echo "Total corrections made: ${DASHBOARD_METRICS["total_corrections_made"]}"
    echo "Most active enforcer: ${DASHBOARD_METRICS["most_active_enforcer"]}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi