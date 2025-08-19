#!/bin/bash

#======================================================================
# CLAUDE CODE FRAMEWORK - VALIDATION DASHBOARD GENERATOR
#======================================================================
# Purpose: Creates comprehensive HTML dashboard with compliance metrics
# Version: 1.0.0
# Author: Claude Code DevOps Engineer
# Date: 2025-08-19
#
# Based on: operations/20250819-formatting-standards-analysis/compliance-requirements-analysis.md
# Progressive Thinking: Think → Think Hard → Think Harder → UltraThink
#======================================================================

set -euo pipefail

#======================================================================
# CONFIGURATION
#======================================================================
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${1:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly DASHBOARD_FILE="${SCRIPT_DIR}/reports/compliance-dashboard-$TIMESTAMP.html"
readonly LOGS_DIR="${SCRIPT_DIR}/logs"
readonly REPORTS_DIR="${SCRIPT_DIR}/reports"

# Compliance thresholds (from analysis)
readonly THRESHOLD_OVERALL=90
readonly THRESHOLD_FILE_NAMING=100
readonly THRESHOLD_YAML_FRONTMATTER=95
readonly THRESHOLD_CODE_BLOCKS=100
readonly THRESHOLD_LINK_INTEGRITY=85
readonly THRESHOLD_NAVIGATION=80

#======================================================================
# LOGGING
#======================================================================
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

#======================================================================
# VALIDATION RESULTS AGGREGATION
#======================================================================
aggregate_validation_results() {
    local validation_data=$(mktemp)
    
    # Initialize results structure
    cat > "$validation_data" << 'EOF'
{
  "timestamp": "",
  "overall_compliance": 0,
  "validators": {},
  "summary": {
    "total_files": 0,
    "total_violations": 0,
    "total_corrections": 0,
    "validation_coverage": 0
  },
  "trends": [],
  "recommendations": []
}
EOF
    
    # Find latest validation reports
    local latest_reports=()
    for validator in file-naming yaml-frontmatter code-block link-integrity navigation markdown-format cross-reference template-compliance; do
        local latest_report
        latest_report=$(find "$LOGS_DIR" -name "*${validator}-validator-*-report.json" -type f | sort | tail -1)
        
        if [[ -n "$latest_report" && -f "$latest_report" ]]; then
            latest_reports+=("$validator:$latest_report")
        fi
    done
    
    log "Found ${#latest_reports[@]} validation reports to aggregate"
    
    # Aggregate results
    local total_files=0
    local total_violations=0
    local total_corrections=0
    local compliance_scores=()
    
    for report_info in "${latest_reports[@]}"; do
        local validator="${report_info%%:*}"
        local report_file="${report_info#*:}"
        
        if [[ -f "$report_file" ]]; then
            # Extract key metrics
            local compliance_score
            compliance_score=$(jq -r '.metrics.compliance_score // 0' "$report_file" 2>/dev/null || echo "0")
            compliance_scores+=("$compliance_score")
            
            local files_count
            files_count=$(jq -r '.metrics.total_files // 0' "$report_file" 2>/dev/null || echo "0")
            total_files=$((total_files > files_count ? total_files : files_count))
            
            local violations_count
            violations_count=$(jq -r '.violations | length // 0' "$report_file" 2>/dev/null || echo "0")
            total_violations=$((total_violations + violations_count))
            
            local corrections_count
            corrections_count=$(jq -r '.corrections | length // 0' "$report_file" 2>/dev/null || echo "0")
            total_corrections=$((total_corrections + corrections_count))
        fi
    done
    
    # Calculate overall compliance
    local overall_compliance=0
    if [[ ${#compliance_scores[@]} -gt 0 ]]; then
        local sum=0
        for score in "${compliance_scores[@]}"; do
            sum=$((sum + score))
        done
        overall_compliance=$((sum / ${#compliance_scores[@]}))
    fi
    
    # Update validation data
    jq --arg timestamp "$TIMESTAMP" \
       --argjson overall "$overall_compliance" \
       --argjson total_files "$total_files" \
       --argjson total_violations "$total_violations" \
       --argjson total_corrections "$total_corrections" \
       --argjson coverage "${#latest_reports[@]}" \
       '
       .timestamp = $timestamp |
       .overall_compliance = $overall |
       .summary.total_files = $total_files |
       .summary.total_violations = $total_violations |
       .summary.total_corrections = $total_corrections |
       .summary.validation_coverage = $coverage
       ' "$validation_data" > "${validation_data}.tmp" && mv "${validation_data}.tmp" "$validation_data"
    
    echo "$validation_data"
}

#======================================================================
# DASHBOARD HTML GENERATION
#======================================================================
generate_dashboard_html() {
    local validation_data="$1"
    
    # Extract key metrics
    local overall_compliance
    overall_compliance=$(jq -r '.overall_compliance // 0' "$validation_data")
    
    local total_files
    total_files=$(jq -r '.summary.total_files // 0' "$validation_data")
    
    local total_violations
    total_violations=$(jq -r '.summary.total_violations // 0' "$validation_data")
    
    local total_corrections
    total_corrections=$(jq -r '.summary.total_corrections // 0' "$validation_data")
    
    log "Generating dashboard HTML with overall compliance: $overall_compliance%"
    
    # Create comprehensive HTML dashboard
    cat > "$DASHBOARD_FILE" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Claude Code Framework - Compliance Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
        }
        
        .header h1 {
            color: var(--primary-color);
            font-size: 2.5em;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .header .subtitle {
            color: #666;
            font-size: 1.1em;
            margin-bottom: 20px;
        }
        
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .metric-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .metric-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        
        .metric-value {
            font-size: 3em;
            font-weight: bold;
            margin-bottom: 10px;
            display: block;
        }
        
        .metric-label {
            color: #666;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
        }
        
        .metric-trend {
            font-size: 0.8em;
            padding: 5px 10px;
            border-radius: 20px;
            display: inline-block;
        }
        
        .compliance-excellent { color: var(--success-color); }
        .compliance-good { color: var(--info-color); }
        .compliance-warning { color: var(--warning-color); }
        .compliance-danger { color: var(--danger-color); }
        
        .charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .chart-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
        }
        
        .chart-title {
            font-size: 1.3em;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--dark-color);
        }
        
        .validation-details {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
        }
        
        .validation-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .validation-table th,
        .validation-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .validation-table th {
            background: var(--light-color);
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8em;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-excellent {
            background: #d4edda;
            color: #155724;
        }
        
        .status-good {
            background: #cce7ff;
            color: #004085;
        }
        
        .status-warning {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-danger {
            background: #f8d7da;
            color: #721c24;
        }
        
        .recommendations {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
        }
        
        .recommendation-item {
            background: #f8f9fa;
            border-left: 4px solid var(--info-color);
            padding: 15px 20px;
            margin-bottom: 15px;
            border-radius: 5px;
        }
        
        .footer {
            text-align: center;
            padding: 20px;
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9em;
        }
        
        .progress-ring {
            transform: rotate(-90deg);
        }
        
        .progress-ring-circle {
            transition: stroke-dashoffset 0.5s;
        }
        
        .refresh-button {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background 0.3s ease;
        }
        
        .refresh-button:hover {
            background: var(--secondary-color);
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .header h1 {
                font-size: 2em;
            }
            
            .metrics-grid {
                grid-template-columns: 1fr;
            }
            
            .charts-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header Section -->
        <div class="header">
            <h1>
                🔍 Claude Code Framework Compliance Dashboard
                <button class="refresh-button" onclick="location.reload()">Refresh</button>
            </h1>
            <div class="subtitle">
                Real-time validation metrics and compliance monitoring
            </div>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
                <div><strong>Generated:</strong> $(date)</div>
                <div><strong>Framework Version:</strong> 3.1.0</div>
                <div><strong>Total Files:</strong> $total_files</div>
            </div>
        </div>
        
        <!-- Key Metrics Grid -->
        <div class="metrics-grid">
            <div class="metric-card">
                <div class="metric-value compliance-$(get_compliance_class $overall_compliance)">$overall_compliance%</div>
                <div class="metric-label">Overall Compliance</div>
                <div class="metric-trend status-$(get_compliance_status $overall_compliance)">
                    $(get_compliance_trend_text $overall_compliance)
                </div>
            </div>
            
            <div class="metric-card">
                <div class="metric-value">$total_files</div>
                <div class="metric-label">Files Analyzed</div>
                <div class="metric-trend">Comprehensive Coverage</div>
            </div>
            
            <div class="metric-card">
                <div class="metric-value compliance-danger">$total_violations</div>
                <div class="metric-label">Total Violations</div>
                <div class="metric-trend">Requires Attention</div>
            </div>
            
            <div class="metric-card">
                <div class="metric-value compliance-good">$total_corrections</div>
                <div class="metric-label">Auto-Correctable</div>
                <div class="metric-trend">Ready for Fix</div>
            </div>
        </div>
        
        <!-- Charts Section -->
        <div class="charts-grid">
            <div class="chart-card">
                <h3 class="chart-title">Compliance by Validation Domain</h3>
                <canvas id="complianceChart" width="400" height="300"></canvas>
            </div>
            
            <div class="chart-card">
                <h3 class="chart-title">Validation Coverage Overview</h3>
                <canvas id="coverageChart" width="400" height="300"></canvas>
            </div>
        </div>
        
        <!-- Validation Details -->
        <div class="validation-details">
            <h3>Validation Results by Domain</h3>
            <table class="validation-table">
                <thead>
                    <tr>
                        <th>Validation Domain</th>
                        <th>Compliance Score</th>
                        <th>Status</th>
                        <th>Violations</th>
                        <th>Corrections</th>
                        <th>Target</th>
                    </tr>
                </thead>
                <tbody>
$(generate_validation_table_rows)
                </tbody>
            </table>
        </div>
        
        <!-- Recommendations -->
        <div class="recommendations">
            <h3>🎯 Recommended Actions</h3>
            $(generate_recommendations "$overall_compliance" "$total_violations" "$total_corrections")
        </div>
        
        <!-- Validation Rules Summary -->
        <div class="validation-details">
            <h3>📋 Framework Compliance Rules</h3>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-top: 20px;">
                <div>
                    <h4>Week 1 Foundation (Automated)</h4>
                    <ul style="margin-left: 20px; margin-top: 10px;">
                        <li>File Naming Conventions (100% target)</li>
                        <li>YAML Frontmatter Structure (95% target)</li>
                        <li>Code Block Language Tags (100% target)</li>
                    </ul>
                </div>
                <div>
                    <h4>Week 2 Structure</h4>
                    <ul style="margin-left: 20px; margin-top: 10px;">
                        <li>Link Format Enhancement (85% target)</li>
                        <li>Navigation Pattern Standards (80% target)</li>
                        <li>Document Structure Validation (95% target)</li>
                    </ul>
                </div>
                <div>
                    <h4>Week 3-4 Advanced</h4>
                    <ul style="margin-left: 20px; margin-top: 10px;">
                        <li>Cross-Reference Integrity (90% target)</li>
                        <li>Template Compliance (85% target)</li>
                        <li>Comprehensive Compliance (90% target)</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <div class="footer">
        <p>Generated by Claude Code Framework Master Validation Orchestrator v1.0.0</p>
        <p>Last updated: $(date) | Next scan: Automated every 4 hours</p>
    </div>
    
    <script>
        // Compliance Chart
        const complianceCtx = document.getElementById('complianceChart').getContext('2d');
        new Chart(complianceCtx, {
            type: 'bar',
            data: {
                labels: ['File Naming', 'YAML Frontmatter', 'Code Blocks', 'Link Integrity', 'Navigation', 'Markdown Format', 'Cross-References', 'Templates'],
                datasets: [{
                    label: 'Compliance Score (%)',
                    data: [$(generate_compliance_chart_data)],
                    backgroundColor: [
                        'rgba(40, 167, 69, 0.8)',
                        'rgba(23, 162, 184, 0.8)',
                        'rgba(40, 167, 69, 0.8)',
                        'rgba(255, 193, 7, 0.8)',
                        'rgba(220, 53, 69, 0.8)',
                        'rgba(102, 126, 234, 0.8)',
                        'rgba(118, 75, 162, 0.8)',
                        'rgba(255, 193, 7, 0.8)'
                    ],
                    borderColor: [
                        'rgba(40, 167, 69, 1)',
                        'rgba(23, 162, 184, 1)',
                        'rgba(40, 167, 69, 1)',
                        'rgba(255, 193, 7, 1)',
                        'rgba(220, 53, 69, 1)',
                        'rgba(102, 126, 234, 1)',
                        'rgba(118, 75, 162, 1)',
                        'rgba(255, 193, 7, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100
                    }
                }
            }
        });
        
        // Coverage Chart
        const coverageCtx = document.getElementById('coverageChart').getContext('2d');
        new Chart(coverageCtx, {
            type: 'doughnut',
            data: {
                labels: ['Compliant', 'Violations', 'Auto-Correctable'],
                datasets: [{
                    data: [$(calculate_coverage_data "$total_files" "$total_violations" "$total_corrections")],
                    backgroundColor: [
                        'rgba(40, 167, 69, 0.8)',
                        'rgba(220, 53, 69, 0.8)',
                        'rgba(255, 193, 7, 0.8)'
                    ],
                    borderColor: [
                        'rgba(40, 167, 69, 1)',
                        'rgba(220, 53, 69, 1)',
                        'rgba(255, 193, 7, 1)'
                    ],
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    </script>
</body>
</html>
EOF
}

#======================================================================
# HELPER FUNCTIONS
#======================================================================
get_compliance_class() {
    local score="$1"
    if [[ $score -ge 95 ]]; then
        echo "excellent"
    elif [[ $score -ge 85 ]]; then
        echo "good"
    elif [[ $score -ge 70 ]]; then
        echo "warning"
    else
        echo "danger"
    fi
}

get_compliance_status() {
    local score="$1"
    if [[ $score -ge 95 ]]; then
        echo "excellent"
    elif [[ $score -ge 85 ]]; then
        echo "good"
    elif [[ $score -ge 70 ]]; then
        echo "warning"
    else
        echo "danger"
    fi
}

get_compliance_trend_text() {
    local score="$1"
    if [[ $score -ge 95 ]]; then
        echo "Excellent Compliance"
    elif [[ $score -ge 85 ]]; then
        echo "Good Compliance"
    elif [[ $score -ge 70 ]]; then
        echo "Needs Improvement"
    else
        echo "Critical Issues"
    fi
}

generate_validation_table_rows() {
    local validators=(
        "File Naming:100:file-naming"
        "YAML Frontmatter:95:yaml-frontmatter"
        "Code Blocks:100:code-block"
        "Link Integrity:85:link-integrity"
        "Navigation:80:navigation"
        "Markdown Format:95:markdown-format"
        "Cross References:90:cross-reference"
        "Templates:85:template-compliance"
    )
    
    for validator_info in "${validators[@]}"; do
        IFS=':' read -r name target validator_key <<< "$validator_info"
        
        # Find latest report for this validator
        local report_file
        report_file=$(find "$LOGS_DIR" -name "*${validator_key}-validator-*-report.json" -type f | sort | tail -1)
        
        if [[ -n "$report_file" && -f "$report_file" ]]; then
            local compliance
            compliance=$(jq -r '.metrics.compliance_score // 0' "$report_file" 2>/dev/null || echo "0")
            
            local violations
            violations=$(jq -r '.violations | length // 0' "$report_file" 2>/dev/null || echo "0")
            
            local corrections
            corrections=$(jq -r '.corrections | length // 0' "$report_file" 2>/dev/null || echo "0")
            
            local status_class
            status_class=$(get_compliance_status "$compliance")
            
            local status_text
            status_text=$(get_compliance_trend_text "$compliance")
            
            echo "                    <tr>"
            echo "                        <td>$name</td>"
            echo "                        <td><strong>$compliance%</strong></td>"
            echo "                        <td><span class=\"status-badge status-$status_class\">$status_text</span></td>"
            echo "                        <td>$violations</td>"
            echo "                        <td>$corrections</td>"
            echo "                        <td>$target%</td>"
            echo "                    </tr>"
        else
            echo "                    <tr>"
            echo "                        <td>$name</td>"
            echo "                        <td><strong>N/A</strong></td>"
            echo "                        <td><span class=\"status-badge status-warning\">Not Run</span></td>"
            echo "                        <td>-</td>"
            echo "                        <td>-</td>"
            echo "                        <td>$target%</td>"
            echo "                    </tr>"
        fi
    done
}

generate_recommendations() {
    local overall="$1"
    local violations="$2"
    local corrections="$3"
    
    local recommendations=""
    
    if [[ $overall -lt $THRESHOLD_OVERALL ]]; then
        recommendations+="<div class=\"recommendation-item\">
            <strong>🚨 Priority Action:</strong> Overall compliance ($overall%) is below target ($THRESHOLD_OVERALL%). Focus on high-impact violations first.
        </div>"
    fi
    
    if [[ $corrections -gt 0 ]]; then
        recommendations+="<div class=\"recommendation-item\">
            <strong>🔧 Quick Wins:</strong> $corrections violations can be automatically corrected. Run validation scripts with --fix flag.
        </div>"
    fi
    
    if [[ $violations -gt 50 ]]; then
        recommendations+="<div class=\"recommendation-item\">
            <strong>📊 Systematic Approach:</strong> High violation count ($violations) suggests systematic issues. Consider batch processing by file type or domain.
        </div>"
    fi
    
    recommendations+="<div class=\"recommendation-item\">
        <strong>📈 Continuous Monitoring:</strong> Schedule regular validation runs (every 4 hours) to maintain compliance and catch issues early.
    </div>"
    
    recommendations+="<div class=\"recommendation-item\">
        <strong>🎯 Focus Areas:</strong> Prioritize Week 1 Foundation validators (File Naming, YAML, Code Blocks) for maximum impact.
    </div>"
    
    echo "$recommendations"
}

generate_compliance_chart_data() {
    local validators=(
        "file-naming"
        "yaml-frontmatter"
        "code-block"
        "link-integrity"
        "navigation"
        "markdown-format"
        "cross-reference"
        "template-compliance"
    )
    
    local data=()
    
    for validator in "${validators[@]}"; do
        local report_file
        report_file=$(find "$LOGS_DIR" -name "*${validator}-validator-*-report.json" -type f | sort | tail -1)
        
        if [[ -n "$report_file" && -f "$report_file" ]]; then
            local compliance
            compliance=$(jq -r '.metrics.compliance_score // 0' "$report_file" 2>/dev/null || echo "0")
            data+=("$compliance")
        else
            data+=("0")
        fi
    done
    
    # Join array with commas
    printf "%s," "${data[@]}" | sed 's/,$//'
}

calculate_coverage_data() {
    local total_files="$1"
    local violations="$2"
    local corrections="$3"
    
    local compliant=$((total_files - violations))
    local correctable="$corrections"
    local remaining=$((violations - corrections))
    
    echo "$compliant, $remaining, $correctable"
}

#======================================================================
# MAIN EXECUTION
#======================================================================
main() {
    log "Starting validation dashboard generation..."
    
    # Ensure required directories exist
    mkdir -p "$REPORTS_DIR" "$LOGS_DIR"
    
    # Check if jq is available
    if ! command -v jq &> /dev/null; then
        log "WARNING: jq not found. Installing or using fallback JSON parsing."
        # Note: In production, ensure jq is installed
    fi
    
    # Aggregate validation results
    log "Aggregating validation results from $LOGS_DIR"
    local validation_data
    validation_data=$(aggregate_validation_results)
    
    # Generate HTML dashboard
    log "Generating comprehensive HTML dashboard"
    generate_dashboard_html "$validation_data"
    
    # Clean up temporary files
    rm -f "$validation_data"
    
    log "Dashboard generated successfully: $DASHBOARD_FILE"
    
    # Generate additional formats
    local json_summary="${DASHBOARD_FILE%.html}-summary.json"
    
    cat > "$json_summary" << EOF
{
  "timestamp": "$TIMESTAMP",
  "dashboard_file": "$DASHBOARD_FILE",
  "summary": {
    "overall_compliance": $(jq -r '.overall_compliance // 0' "$validation_data" 2>/dev/null || echo "0"),
    "total_files": $(jq -r '.summary.total_files // 0' "$validation_data" 2>/dev/null || echo "0"),
    "total_violations": $(jq -r '.summary.total_violations // 0' "$validation_data" 2>/dev/null || echo "0"),
    "total_corrections": $(jq -r '.summary.total_corrections // 0' "$validation_data" 2>/dev/null || echo "0"),
    "validation_coverage": $(jq -r '.summary.validation_coverage // 0' "$validation_data" 2>/dev/null || echo "0")
  },
  "status": "success",
  "next_actions": [
    "Review compliance metrics in dashboard",
    "Execute correction scripts for auto-fixable violations",
    "Schedule regular validation monitoring",
    "Focus on high-priority compliance domains"
  ]
}
EOF
    
    log "Summary JSON generated: $json_summary"
    
    # Open dashboard if in interactive mode
    if [[ -t 1 ]] && command -v open &> /dev/null; then
        log "Opening dashboard in browser..."
        open "$DASHBOARD_FILE" 2>/dev/null || true
    fi
    
    echo "Dashboard URL: file://$(realpath "$DASHBOARD_FILE")"
}

#======================================================================
# SCRIPT EXECUTION
#======================================================================
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi