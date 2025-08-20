---

**IF formatting evidence** → READ [evidence-patterns.md](evidence-patterns.md) for collection standards, THEN follow these format guidelines for consistent evidence presentation


# Evidence Format Guidelines

**Context**: Standardized formatting specifications for screenshots, logs, metrics, and other evidence types with integrated TDD/BDD validation patterns

---

These guidelines ensure evidence is consistently formatted, easily interpretable, and supports systematic validation through Given-When-Then scenarios and Red-Green-Refactor cycles.

## Core Formatting Principles

### Evidence Readability Standards
- **Self-Contained**: Evidence can be understood without external context
- **Timestamped**: All evidence includes clear temporal information
- **Traceable**: Evidence links directly to requirements and test cases
- **Structured**: Evidence follows consistent organizational patterns
- **Actionable**: Evidence enables clear decision-making

### TDD/BDD Integration Requirements
- **Phase Identification**: Evidence clearly indicates TDD phase (Red/Green/Refactor)
- **Scenario Mapping**: Evidence maps to specific BDD scenarios
- **Validation Chain**: Evidence supports end-to-end validation traceability
- **Quality Gate Alignment**: Evidence format supports automated quality gate evaluation

---

## Screenshot Format Guidelines

### BDD Scenario for Screenshot Evidence
```gherkin
Feature: Screenshot Evidence Collection
  As a validator reviewing evidence
  I want consistently formatted screenshots
  So that I can quickly understand system behavior and validate requirements

Scenario: Creating Validation Screenshots
  Given I need to capture visual evidence of system behavior
  When I take screenshots for validation purposes
  Then screenshots must include:
    - Clear timestamp and environment context
    - Relevant UI elements with sufficient detail
    - Navigation breadcrumbs or context indicators
    - Success/failure indicators where applicable
    - Consistent naming and organization
  And screenshots must support traceability to test scenarios
```

### Screenshot Naming Convention
```bash
# Format: [phase]-[scenario-id]-[step]-[timestamp]
# Examples:
red-phase-login-001-step-01-20250820-143000.png
green-phase-login-001-step-02-20250820-143015.png
refactor-phase-login-001-validation-20250820-143030.png

# BDD Scenario Screenshots:
# Format: [feature]-[scenario]-[step]-[timestamp]
user-authentication-valid-login-step-01-20250820-143000.png
user-authentication-invalid-password-error-20250820-143045.png
user-authentication-password-reset-confirmation-20250820-143100.png
```

### Screenshot Content Requirements
```yaml
screenshot_content:
  mandatory_elements:
    - timestamp_visible: "System clock or application timestamp"
    - environment_indicator: "Development/Staging/Production badge"
    - context_navigation: "Breadcrumbs or URL showing location"
    - relevant_ui_elements: "All elements referenced in test scenario"
    - status_indicators: "Success/error/loading states as applicable"
  
  quality_standards:
    - resolution: "Minimum 1920x1080 or native resolution"
    - format: "PNG for UI, JPEG for photographs, SVG for diagrams"
    - compression: "Lossless for text, optimized for file size"
    - annotations: "Callouts and highlights where needed"
  
  annotation_standards:
    - highlight_color: "#FF6B35 (red-orange) for failures"
    - success_color: "#4CAF50 (green) for successes"
    - attention_color: "#2196F3 (blue) for important elements"
    - text_style: "Arial 14pt, high contrast background"
```

### Screenshot Organization Structure
```
screenshots/
├── tdd-phases/
│   ├── red-phase/
│   │   ├── [feature]/
│   │   │   ├── failing-test-evidence/
│   │   │   └── test-setup/
│   ├── green-phase/
│   │   ├── [feature]/
│   │   │   ├── passing-test-evidence/
│   │   │   └── implementation-verification/
│   └── refactor-phase/
│       ├── [feature]/
│           ├── code-quality-improvements/
│           └── performance-validation/
├── bdd-scenarios/
│   ├── [feature]/
│   │   ├── happy-path/
│   │   ├── edge-cases/
│   │   └── error-scenarios/
└── integration-testing/
    ├── api-responses/
    ├── database-states/
    └── system-integration/
```

### Screenshot Metadata Template
```yaml
screenshot_metadata:
  filename: "[screenshot filename]"
  capture_timestamp: "YYYY-MM-DD HH:MM:SS.mmm"
  tdd_phase: [red|green|refactor|validation]
  bdd_scenario: "[scenario identifier]"
  test_case_id: "[test case reference]"
  environment:
    type: [development|staging|production]
    version: "[application version]"
    browser: "[browser name and version]"
    resolution: "[screen resolution]"
  content_description: "[Brief description of what the screenshot shows]"
  validation_purpose: "[What this screenshot validates]"
  annotations:
    - type: [highlight|callout|arrow|text]
      coordinates: "x,y"
      description: "[What the annotation indicates]"
  traceability:
    requirements: ["req-001", "req-002"]
    acceptance_criteria: ["ac-001", "ac-002"]
    quality_gates: ["gate-001"]
```

---

## Log Format Guidelines

### BDD Scenario for Log Evidence
```gherkin
Feature: Log Evidence Collection
  As a developer debugging system behavior
  I want consistently formatted log evidence
  So that I can trace system behavior and validate correct operation

Scenario: Capturing System Logs for Validation
  Given I am validating system behavior through log analysis
  When I collect log evidence for validation purposes
  Then logs must include:
    - Structured format with consistent fields
    - Appropriate log levels for different types of events
    - Correlation IDs for tracing related events
    - Performance metrics where applicable
    - Clear error messages and stack traces
    - Contextual information for debugging
  And logs must support automated analysis and filtering
```

### Log Entry Format Standard
```json
{
  "timestamp": "2025-08-20T14:30:00.123Z",
  "level": "INFO|DEBUG|WARN|ERROR|FATAL",
  "component": "[component/service name]",
  "correlation_id": "[unique request/session identifier]",
  "tdd_phase": "red|green|refactor|validation",
  "bdd_scenario": "[scenario identifier]",
  "message": "[human-readable log message]",
  "details": {
    "request_id": "[request identifier]",
    "user_id": "[user identifier if applicable]",
    "session_id": "[session identifier]",
    "performance_metrics": {
      "duration_ms": 123,
      "memory_usage_mb": 45.6,
      "cpu_usage_percent": 12.3
    },
    "validation_context": {
      "test_case": "[test case identifier]",
      "expected_behavior": "[what should happen]",
      "actual_behavior": "[what actually happened]",
      "validation_result": "PASS|FAIL|PARTIAL"
    }
  },
  "stack_trace": "[stack trace if error]",
  "environment": {
    "type": "development|staging|production",
    "version": "[application version]",
    "instance_id": "[instance identifier]"
  }
}
```

### Log Aggregation and Filtering
```bash
# TDD Phase Filtering
# Red Phase - Capture failing test execution
jq '.[] | select(.tdd_phase == "red" and .level == "ERROR")' logs.json

# Green Phase - Capture successful implementation
jq '.[] | select(.tdd_phase == "green" and .validation_context.validation_result == "PASS")' logs.json

# Refactor Phase - Capture quality improvements
jq '.[] | select(.tdd_phase == "refactor" and .details.performance_metrics)' logs.json

# BDD Scenario Filtering
# Filter logs for specific scenario validation
jq '.[] | select(.bdd_scenario == "user-authentication-valid-login")' logs.json

# Performance Analysis
jq '.[] | select(.details.performance_metrics.duration_ms > 1000)' logs.json
```

### Log Organization Structure
```
logs/
├── tdd-phases/
│   ├── red-phase/
│   │   ├── failing-tests-YYYYMMDD.json
│   │   ├── test-setup-errors-YYYYMMDD.json
│   │   └── environment-setup-YYYYMMDD.json
│   ├── green-phase/
│   │   ├── passing-tests-YYYYMMDD.json
│   │   ├── implementation-logs-YYYYMMDD.json
│   │   └── integration-validation-YYYYMMDD.json
│   └── refactor-phase/
│       ├── refactoring-activities-YYYYMMDD.json
│       ├── performance-improvements-YYYYMMDD.json
│       └── quality-validations-YYYYMMDD.json
├── bdd-scenarios/
│   ├── user-authentication/
│   ├── data-validation/
│   └── error-handling/
├── system-logs/
│   ├── application-YYYYMMDD.json
│   ├── database-YYYYMMDD.json
│   └── infrastructure-YYYYMMDD.json
└── analysis/
    ├── performance-analysis-YYYYMMDD.json
    ├── error-analysis-YYYYMMDD.json
    └── trend-analysis-YYYYMMDD.json
```

---

## Metrics Format Guidelines

### BDD Scenario for Metrics Evidence
```gherkin
Feature: Metrics Evidence Collection
  As a quality engineer measuring system performance
  I want consistently formatted metrics evidence
  So that I can validate performance requirements and track quality trends

Scenario: Collecting Performance and Quality Metrics
  Given I am validating system performance and quality
  When I collect metrics evidence for validation purposes
  Then metrics must include:
    - Baseline measurements before changes
    - Continuous measurements during implementation
    - Comparative analysis showing impact
    - Trend analysis over time
    - Quality gate threshold comparisons
    - Statistical significance validation
  And metrics must support automated quality gate evaluation
```

### Metrics Data Format Standard
```yaml
metrics_collection:
  collection_metadata:
    collection_id: "metrics-YYYYMMDD-HHMMSS"
    collection_timestamp: "YYYY-MM-DD HH:MM:SS"
    tdd_phase: [red|green|refactor|validation]
    bdd_scenario: "[scenario identifier]"
    environment: [development|staging|production]
    collector: "[tool/person collecting metrics]"
    
  baseline_metrics:
    collection_timestamp: "YYYY-MM-DD HH:MM:SS"
    performance:
      response_time_ms:
        min: 45
        max: 890
        mean: 156.7
        median: 123.0
        p95: 287.3
        p99: 654.2
      throughput:
        requests_per_second: 145.6
        transactions_per_minute: 8736
      resource_usage:
        cpu_percent:
          min: 12.3
          max: 67.8
          mean: 34.5
        memory_mb:
          min: 456.7
          max: 789.2
          mean: 623.4
        disk_io_mbps: 23.4
        network_io_mbps: 45.6
    
    quality:
      test_coverage_percent: 87.3
      code_complexity:
        cyclomatic_complexity: 8.2
        maintainability_index: 72.4
      defect_density: 0.23  # defects per KLOC
      technical_debt_hours: 45.6
      
  current_metrics:
    # Same structure as baseline_metrics
    collection_timestamp: "YYYY-MM-DD HH:MM:SS"
    # ... metrics data ...
    
  comparative_analysis:
    performance_impact:
      response_time_change_percent: -12.3  # negative is improvement
      throughput_change_percent: +8.7     # positive is improvement
      resource_efficiency_change_percent: +5.2
    
    quality_impact:
      test_coverage_change_percent: +4.1
      complexity_change_percent: -2.8     # negative is improvement
      defect_density_change: -0.05        # negative is improvement
    
    statistical_significance:
      confidence_level: 0.95
      p_value: 0.023
      sample_size: 1000
      significance_test: "t-test"
      
  quality_gate_evaluation:
    - gate_id: "performance-response-time"
      threshold: "< 200ms (p95)"
      actual_value: "187.3ms"
      status: "PASS"
      margin: "12.7ms under threshold"
      
    - gate_id: "quality-test-coverage"
      threshold: ">= 90%"
      actual_value: "91.4%"
      status: "PASS"
      margin: "1.4% above threshold"
      
    - gate_id: "quality-complexity"
      threshold: "< 10 (cyclomatic)"
      actual_value: "8.0"
      status: "PASS"
      margin: "2.0 under threshold"
```

### Metrics Visualization Standards
```yaml
visualization_requirements:
  chart_types:
    - type: "time_series"
      use_case: "Performance trends over time"
      format: "Line chart with confidence intervals"
      colors: ["#2196F3", "#4CAF50", "#FF6B35"]
      
    - type: "comparison"
      use_case: "Before/after comparisons"
      format: "Bar chart with baseline reference"
      colors: ["#757575", "#4CAF50", "#FF6B35"]
      
    - type: "distribution"
      use_case: "Performance distribution analysis"
      format: "Histogram with percentile markers"
      markers: ["p50", "p95", "p99"]
      
  annotation_standards:
    - quality_gates: "Horizontal lines at threshold values"
    - tdd_phases: "Vertical lines at phase transitions"
    - significant_events: "Markers with explanatory text"
    - confidence_intervals: "Shaded areas around trend lines"
    
  export_formats:
    - interactive: "HTML with JavaScript (Chart.js/D3)"
    - static: "PNG/SVG for reports"
    - data: "CSV/JSON for further analysis"
```

### Metrics Organization Structure
```
metrics/
├── raw-data/
│   ├── tdd-phases/
│   │   ├── red-phase-baseline-YYYYMMDD.json
│   │   ├── green-phase-implementation-YYYYMMDD.json
│   │   └── refactor-phase-optimization-YYYYMMDD.json
│   ├── continuous-monitoring/
│   │   ├── performance-YYYYMMDD-HHMMSS.json
│   │   └── quality-YYYYMMDD-HHMMSS.json
│   └── bdd-scenario-metrics/
│       ├── [scenario-id]-metrics-YYYYMMDD.json
├── analysis/
│   ├── comparative-analysis-YYYYMMDD.json
│   ├── trend-analysis-YYYYMMDD.json
│   ├── statistical-analysis-YYYYMMDD.json
│   └── quality-gate-evaluation-YYYYMMDD.json
├── visualizations/
│   ├── performance-trends-YYYYMMDD.html
│   ├── quality-comparisons-YYYYMMDD.html
│   ├── tdd-phase-analysis-YYYYMMDD.html
│   └── dashboard-YYYYMMDD.html
└── reports/
    ├── metrics-summary-YYYYMMDD.pdf
    ├── quality-gate-report-YYYYMMDD.pdf
    └── performance-analysis-YYYYMMDD.pdf
```

---

## Integration Testing Evidence Format

### API Testing Evidence Format
```yaml
api_test_evidence:
  test_execution_id: "api-test-YYYYMMDD-HHMMSS"
  tdd_phase: [red|green|refactor|validation]
  bdd_scenario: "[scenario identifier]"
  
  endpoint_tests:
    - endpoint: "/api/v1/users"
      method: "POST"
      test_case: "Create new user with valid data"
      
      request:
        headers:
          Content-Type: "application/json"
          Authorization: "Bearer [token]"
        body: |
          {
            "username": "testuser",
            "email": "test@example.com",
            "password": "securepassword123"
          }
      
      expected_response:
        status_code: 201
        headers:
          Content-Type: "application/json"
        body_schema: "user_creation_response.json"
        body_contains:
          - "id"
          - "username": "testuser"
          - "email": "test@example.com"
      
      actual_response:
        status_code: 201
        headers:
          Content-Type: "application/json; charset=utf-8"
          Location: "/api/v1/users/12345"
        body: |
          {
            "id": 12345,
            "username": "testuser",
            "email": "test@example.com",
            "created_at": "2025-08-20T14:30:00Z"
          }
        response_time_ms: 145
      
      validation_result: "PASS"
      assertions:
        - assertion: "Status code equals 201"
          result: "PASS"
        - assertion: "Response contains user ID"
          result: "PASS"
        - assertion: "Response time under 200ms"
          result: "PASS"
```

### Database State Evidence Format
```sql
-- Database Evidence Collection Template
-- File: database-state-evidence-YYYYMMDD-HHMMSS.sql

-- Evidence Metadata
-- TDD Phase: [red|green|refactor|validation]
-- BDD Scenario: [scenario identifier]
-- Collection Timestamp: YYYY-MM-DD HH:MM:SS
-- Database: [database name and version]

-- Pre-Test State Capture
-- Purpose: Establish baseline before test execution
SELECT 'PRE_TEST_STATE' as evidence_type, 
       NOW() as timestamp,
       COUNT(*) as user_count 
FROM users;

SELECT 'PRE_TEST_CONSTRAINTS' as evidence_type,
       constraint_name,
       table_name,
       constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'test_database';

-- Test Execution State Capture
-- Purpose: Capture state during test execution
SELECT 'TEST_EXECUTION_STATE' as evidence_type,
       'User creation test' as test_description,
       id, username, email, created_at
FROM users 
WHERE username = 'testuser'
ORDER BY created_at DESC
LIMIT 1;

-- Post-Test State Validation
-- Purpose: Verify expected database changes
SELECT 'POST_TEST_VALIDATION' as evidence_type,
       CASE 
         WHEN COUNT(*) = 1 THEN 'PASS'
         ELSE 'FAIL'
       END as validation_result,
       COUNT(*) as matching_records
FROM users 
WHERE username = 'testuser' 
  AND email = 'test@example.com'
  AND created_at >= '2025-08-20 14:30:00';

-- Data Integrity Validation
-- Purpose: Verify referential integrity maintained
SELECT 'INTEGRITY_CHECK' as evidence_type,
       'Foreign key constraints' as check_type,
       CASE 
         WHEN COUNT(*) = 0 THEN 'PASS'
         ELSE 'FAIL'
       END as validation_result
FROM information_schema.referential_constraints rc
JOIN information_schema.table_constraints tc
  ON rc.constraint_name = tc.constraint_name
WHERE tc.table_schema = 'test_database'
  AND rc.constraint_name NOT IN (
    SELECT constraint_name 
    FROM information_schema.table_constraints
    WHERE constraint_type = 'FOREIGN KEY'
  );

-- Performance Evidence
-- Purpose: Capture query performance metrics
SELECT 'PERFORMANCE_EVIDENCE' as evidence_type,
       query_time,
       lock_time,
       rows_sent,
       rows_examined
FROM mysql.slow_log
WHERE sql_text LIKE '%testuser%'
  AND start_time >= '2025-08-20 14:30:00'
ORDER BY start_time DESC
LIMIT 10;
```

---

## Evidence Validation Automation

### Automated Evidence Validation Script
```bash
#!/bin/bash
# evidence-validator.sh
# Automated evidence format validation script

set -e

EVIDENCE_DIR="$1"
REPORT_FILE="evidence-validation-report-$(date +%Y%m%d-%H%M%S).json"

if [ -z "$EVIDENCE_DIR" ]; then
    echo "Usage: $0 <evidence-directory>"
    exit 1
fi

echo "Starting evidence validation for directory: $EVIDENCE_DIR"
echo "Report will be generated: $REPORT_FILE"

# Initialize validation report
cat > "$REPORT_FILE" << EOF
{
  "validation_timestamp": "$(date -Iseconds)",
  "evidence_directory": "$EVIDENCE_DIR",
  "validation_results": {
    "screenshots": [],
    "logs": [],
    "metrics": [],
    "api_tests": [],
    "database_evidence": []
  },
  "summary": {
    "total_files": 0,
    "valid_files": 0,
    "invalid_files": 0,
    "validation_errors": []
  }
}
EOF

# Validate Screenshots
echo "Validating screenshot evidence..."
find "$EVIDENCE_DIR" -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" | while read -r screenshot; do
    # Check naming convention
    filename=$(basename "$screenshot")
    if [[ ! "$filename" =~ ^(red|green|refactor|validation)-phase-.+-[0-9]{8}-[0-9]{6}\.(png|jpg|jpeg)$ ]]; then
        echo "WARNING: Screenshot naming convention violation: $filename"
    fi
    
    # Check file size (reasonable limits)
    filesize=$(stat -c%s "$screenshot")
    if [ "$filesize" -gt 10485760 ]; then  # 10MB
        echo "WARNING: Screenshot file size too large: $filename ($filesize bytes)"
    fi
    
    # Check for metadata file
    metadata_file="${screenshot%.*}.yml"
    if [ ! -f "$metadata_file" ]; then
        echo "WARNING: Missing metadata file: $metadata_file"
    fi
done

# Validate Log Files
echo "Validating log evidence..."
find "$EVIDENCE_DIR" -name "*.json" -path "*/logs/*" | while read -r logfile; do
    # Validate JSON structure
    if ! jq empty "$logfile" 2>/dev/null; then
        echo "ERROR: Invalid JSON in log file: $logfile"
        continue
    fi
    
    # Check for required fields
    required_fields=("timestamp" "level" "component" "message")
    for field in "${required_fields[@]}"; do
        if ! jq -e ".[0].$field" "$logfile" >/dev/null 2>&1; then
            echo "WARNING: Missing required field '$field' in: $logfile"
        fi
    done
    
    # Validate timestamp format
    if ! jq -e '.[0].timestamp | test("^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\\.[0-9]{3}Z$")' "$logfile" >/dev/null 2>&1; then
        echo "WARNING: Invalid timestamp format in: $logfile"
    fi
done

# Validate Metrics Files
echo "Validating metrics evidence..."
find "$EVIDENCE_DIR" -name "*.json" -path "*/metrics/*" | while read -r metricsfile; do
    # Validate JSON structure
    if ! jq empty "$metricsfile" 2>/dev/null; then
        echo "ERROR: Invalid JSON in metrics file: $metricsfile"
        continue
    fi
    
    # Check for baseline metrics
    if ! jq -e '.baseline_metrics' "$metricsfile" >/dev/null 2>&1; then
        echo "WARNING: Missing baseline metrics in: $metricsfile"
    fi
    
    # Check for current metrics
    if ! jq -e '.current_metrics' "$metricsfile" >/dev/null 2>&1; then
        echo "WARNING: Missing current metrics in: $metricsfile"
    fi
    
    # Check for comparative analysis
    if ! jq -e '.comparative_analysis' "$metricsfile" >/dev/null 2>&1; then
        echo "WARNING: Missing comparative analysis in: $metricsfile"
    fi
done

echo "Evidence validation complete. Report generated: $REPORT_FILE"
```

### Evidence Quality Scoring
```python
#!/usr/bin/env python3
# evidence-quality-scorer.py
# Automated evidence quality scoring system

import json
import os
import sys
from datetime import datetime
from pathlib import Path

def calculate_evidence_quality_score(evidence_dir):
    """Calculate comprehensive quality score for evidence collection."""
    
    score_components = {
        'completeness': 0,      # 30 points max
        'consistency': 0,       # 25 points max  
        'traceability': 0,      # 20 points max
        'automation': 0,        # 15 points max
        'documentation': 0      # 10 points max
    }
    
    evidence_path = Path(evidence_dir)
    
    # Completeness scoring (30 points)
    required_evidence_types = [
        'screenshots/tdd-phases',
        'logs/tdd-phases', 
        'metrics/raw-data',
        'validation/test-results'
    ]
    
    for evidence_type in required_evidence_types:
        if (evidence_path / evidence_type).exists():
            score_components['completeness'] += 7.5
    
    # Consistency scoring (25 points)
    # Check naming conventions
    naming_consistency_score = 0
    for screenshot in evidence_path.glob('**/*.png'):
        if validate_screenshot_naming(screenshot.name):
            naming_consistency_score += 1
    
    # Normalize to 0-25 range
    max_screenshots = len(list(evidence_path.glob('**/*.png')))
    if max_screenshots > 0:
        score_components['consistency'] = min(25, 
            (naming_consistency_score / max_screenshots) * 25)
    
    # Traceability scoring (20 points)
    traceability_score = 0
    metadata_files = list(evidence_path.glob('**/*.yml'))
    json_files = list(evidence_path.glob('**/*.json'))
    
    for metadata_file in metadata_files:
        if validate_traceability_metadata(metadata_file):
            traceability_score += 1
    
    if metadata_files:
        score_components['traceability'] = min(20,
            (traceability_score / len(metadata_files)) * 20)
    
    # Automation scoring (15 points)
    automation_indicators = [
        'validation/automated-tests',
        'metrics/continuous-monitoring',
        'logs/structured-format'
    ]
    
    for indicator in automation_indicators:
        if (evidence_path / indicator).exists():
            score_components['automation'] += 5
    
    # Documentation scoring (10 points)
    doc_files = list(evidence_path.glob('**/*.md'))
    if doc_files:
        score_components['documentation'] = min(10, len(doc_files) * 2.5)
    
    total_score = sum(score_components.values())
    
    return {
        'total_score': round(total_score, 1),
        'max_possible': 100,
        'percentage': round((total_score / 100) * 100, 1),
        'components': score_components,
        'grade': calculate_grade(total_score),
        'recommendations': generate_recommendations(score_components)
    }

def validate_screenshot_naming(filename):
    """Validate screenshot follows naming convention."""
    import re
    pattern = r'^(red|green|refactor|validation)-phase-.+-\d{8}-\d{6}\.(png|jpg|jpeg)$'
    return bool(re.match(pattern, filename))

def validate_traceability_metadata(metadata_file):
    """Validate metadata contains required traceability information."""
    try:
        import yaml
        with open(metadata_file, 'r') as f:
            metadata = yaml.safe_load(f)
        
        required_fields = ['tdd_phase', 'bdd_scenario', 'traceability']
        return all(field in metadata for field in required_fields)
    except:
        return False

def calculate_grade(score):
    """Convert numeric score to letter grade."""
    if score >= 90:
        return 'A'
    elif score >= 80:
        return 'B'
    elif score >= 70:
        return 'C'
    elif score >= 60:
        return 'D'
    else:
        return 'F'

def generate_recommendations(components):
    """Generate improvement recommendations based on component scores."""
    recommendations = []
    
    if components['completeness'] < 20:
        recommendations.append(
            "Improve evidence completeness by ensuring all required evidence types are collected")
    
    if components['consistency'] < 15:
        recommendations.append(
            "Improve naming consistency by following established conventions")
    
    if components['traceability'] < 10:
        recommendations.append(
            "Enhance traceability by adding comprehensive metadata to all evidence")
    
    if components['automation'] < 8:
        recommendations.append(
            "Increase automation by implementing automated evidence collection tools")
    
    if components['documentation'] < 5:
        recommendations.append(
            "Improve documentation by adding explanatory documentation for evidence")
    
    return recommendations

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python3 evidence-quality-scorer.py <evidence-directory>")
        sys.exit(1)
    
    evidence_dir = sys.argv[1]
    
    if not os.path.exists(evidence_dir):
        print(f"Error: Evidence directory does not exist: {evidence_dir}")
        sys.exit(1)
    
    quality_score = calculate_evidence_quality_score(evidence_dir)
    
    # Generate quality report
    report = {
        'assessment_timestamp': datetime.now().isoformat(),
        'evidence_directory': evidence_dir,
        'quality_assessment': quality_score
    }
    
    report_file = f"evidence-quality-report-{datetime.now().strftime('%Y%m%d-%H%M%S')}.json"
    with open(report_file, 'w') as f:
        json.dump(report, f, indent=2)
    
    print(f"Evidence Quality Assessment Complete")
    print(f"Total Score: {quality_score['total_score']}/100 ({quality_score['percentage']}%)")
    print(f"Grade: {quality_score['grade']}")
    print(f"Report saved: {report_file}")
    
    if quality_score['recommendations']:
        print("\nRecommendations for improvement:")
        for i, rec in enumerate(quality_score['recommendations'], 1):
            print(f"{i}. {rec}")
```

---

**Format consistently. Validate systematically. Evidence comprehensively.**