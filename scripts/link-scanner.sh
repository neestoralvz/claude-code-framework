#!/bin/bash
# Automated Link Scanner Script
# Comprehensive link validation for Claude Code Framework

set -euo pipefail

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_ROOT="/Users/nalve/.claude"
CONFIG_FILE="$SCRIPT_DIR/config/scan-config.json"
EXCLUDE_FILE="$SCRIPT_DIR/config/exclude-patterns.txt"

# Load configuration
if [[ -f "$CONFIG_FILE" ]]; then
    OUTPUT_DIR=$(grep -o '"output_dir": "[^"]*"' "$CONFIG_FILE" | cut -d'"' -f4)
    MAX_JOBS=$(grep -o '"max_parallel_jobs": [0-9]*' "$CONFIG_FILE" | grep -o '[0-9]*')
else
    OUTPUT_DIR="$FRAMEWORK_ROOT/operations/link-validation"
    MAX_JOBS=4
fi

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Set up temporary directory
TEMP_DIR="$OUTPUT_DIR/temp-$$"
mkdir -p "$TEMP_DIR"

# Output files
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
OUTPUT_PREFIX="$OUTPUT_DIR/${TIMESTAMP}-link-scan"
LOG_FILE="$OUTPUT_DIR/${TIMESTAMP}-link-scan.log"

# Export for libraries
export FRAMEWORK_ROOT MAX_JOBS TEMP_DIR

# Load library functions
source "$SCRIPT_DIR/lib/link-extractor.sh"
source "$SCRIPT_DIR/lib/link-validator.sh"
source "$SCRIPT_DIR/lib/link-categorizer.sh"
source "$SCRIPT_DIR/lib/report-generator.sh"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Clean up function
cleanup() {
    log "Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"
}

# Set up cleanup trap
trap cleanup EXIT

# Help function
show_help() {
    cat << EOF
Automated Link Scanner - Claude Code Framework

USAGE:
    $0 [OPTIONS]

OPTIONS:
    --help              Show this help message
    --config FILE       Use custom configuration file
    --output-dir DIR    Override output directory
    --format FORMAT     Output format: json,csv,md,all (default: all)
    --category CAT      Scan specific category only
    --incremental       Scan only changed files (requires git)
    --max-jobs N        Maximum parallel jobs (default: 4)
    --verbose           Enable verbose logging
    --dry-run           Show what would be scanned without executing

EXAMPLES:
    $0                              # Full scan with all outputs
    $0 --format=json               # JSON output only
    $0 --category=command           # Scan command links only
    $0 --incremental               # Scan changed files since last commit
    $0 --output-dir=/tmp/scan      # Custom output directory

EOF
}

# Parse command line arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help)
                show_help
                exit 0
                ;;
            --config)
                CONFIG_FILE="$2"
                shift 2
                ;;
            --output-dir)
                OUTPUT_DIR="$2"
                shift 2
                ;;
            --format)
                OUTPUT_FORMAT="$2"
                shift 2
                ;;
            --category)
                SCAN_CATEGORY="$2"
                shift 2
                ;;
            --incremental)
                INCREMENTAL_SCAN=true
                shift
                ;;
            --max-jobs)
                MAX_JOBS="$2"
                shift 2
                ;;
            --verbose)
                VERBOSE=true
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            *)
                echo "Unknown option: $1" >&2
                show_help
                exit 1
                ;;
        esac
    done
}

# Initialize environment
initialize_environment() {
    log "Initializing automated link scanner..."
    log "Framework root: $FRAMEWORK_ROOT"
    log "Output directory: $OUTPUT_DIR"
    log "Temporary directory: $TEMP_DIR"
    log "Max parallel jobs: $MAX_JOBS"
    
    # Validate framework directory
    if [[ ! -d "$FRAMEWORK_ROOT" ]]; then
        log "ERROR: Framework root directory not found: $FRAMEWORK_ROOT"
        exit 1
    fi
    
    # Validate configuration file
    if [[ ! -f "$CONFIG_FILE" ]]; then
        log "WARNING: Configuration file not found: $CONFIG_FILE"
        log "Using default configuration"
    fi
}

# Find all markdown files to scan
find_markdown_files() {
    log "Finding markdown files to scan..."
    
    local file_list="$TEMP_DIR/files_to_scan.txt"
    
    if [[ "${INCREMENTAL_SCAN:-false}" == "true" ]] && [[ -d "$FRAMEWORK_ROOT/.git" ]]; then
        log "Performing incremental scan (git-based)..."
        # Find files changed since last commit
        cd "$FRAMEWORK_ROOT"
        git diff --name-only HEAD~ | grep '\.md$' > "$file_list" || true
        git ls-files --others --exclude-standard | grep '\.md$' >> "$file_list" || true
    else
        log "Performing full framework scan..."
        # Find all markdown files with exclusions
        find "$FRAMEWORK_ROOT" -name "*.md" -type f \
            -not -path "*/.git/*" \
            -not -path "*/node_modules/*" \
            -not -path "*/docker-volumes/*" \
            -not -path "*/statsig/*" \
            -not -path "*/shell-snapshots/*" \
            -not -path "*/todos/*" \
            -not -path "*/logs/*" \
            -not -path "*/cache/*" \
            > "$file_list"
    fi
    
    local file_count
    file_count=$(wc -l < "$file_list" | tr -d ' ')
    log "Found $file_count markdown files to scan"
    
    if [[ "${DRY_RUN:-false}" == "true" ]]; then
        log "DRY RUN: Would scan these files:"
        head -20 "$file_list" | while IFS= read -r file; do
            log "  $file"
        done
        [[ "$file_count" -gt 20 ]] && log "  ... and $((file_count - 20)) more files"
        exit 0
    fi
    
    echo "$file_list"
}

# Scan and extract links
scan_markdown_files() {
    local file_list="$1"
    log "Extracting links from markdown files..."
    
    local all_links_file="$TEMP_DIR/all_links.txt"
    
    # Extract links from all files
    > "$all_links_file"
    
    local processed=0
    local total
    total=$(wc -l < "$file_list" | tr -d ' ')
    
    while IFS= read -r file_path; do
        ((processed++))
        
        if [[ "${VERBOSE:-false}" == "true" ]]; then
            log "Processing ($processed/$total): $file_path"
        fi
        
        # Extract links with file context
        if [[ -f "$file_path" ]]; then
            grep -n '\[.*\](.*\.md\|[^)]*[^/]\/[^)]*\|docs\/\|commands\/\|agents\/\|tickets\/\|playbook\/)' "$file_path" 2>/dev/null | \
            sed "s|^|$file_path:|" >> "$all_links_file" || true
        fi
        
        # Progress indicator for large scans
        if [[ $((processed % 100)) -eq 0 ]]; then
            log "Progress: $processed/$total files processed"
        fi
    done < "$file_list"
    
    local link_count
    link_count=$(wc -l < "$all_links_file" | tr -d ' ')
    log "Extracted $link_count total links"
    
    echo "$all_links_file"
}

# Extract and validate internal links
extract_internal_links() {
    local all_links_file="$1"
    log "Parsing and normalizing internal links..."
    
    local parsed_links_file="$TEMP_DIR/parsed_links.txt"
    
    # Parse link format: file:line:[text](target)
    > "$parsed_links_file"
    
    while IFS= read -r link_entry; do
        # Parse: file_path:line_number:content
        local file_path=$(echo "$link_entry" | cut -d: -f1)
        local line_number=$(echo "$link_entry" | cut -d: -f2)
        local content=$(echo "$link_entry" | cut -d: -f3-)
        
        # Extract link components: [text](target)
        local link_text
        local link_target
        
        if [[ "$content" =~ \[([^\]]*)\]\(([^\)]+)\) ]]; then
            link_text="${BASH_REMATCH[1]}"
            link_target="${BASH_REMATCH[2]}"
            
            # Normalize target
            link_target=$(normalize_link_target "$link_target")
            
            # Skip external links
            if [[ ! "$link_target" =~ ^[a-zA-Z][a-zA-Z0-9+.-]*: ]]; then
                echo "$file_path|$line_number|$content|$link_text|$link_target" >> "$parsed_links_file"
            fi
        fi
    done < "$all_links_file"
    
    local internal_count
    internal_count=$(wc -l < "$parsed_links_file" | tr -d ' ')
    log "Found $internal_count internal links to validate"
    
    echo "$parsed_links_file"
}

# Validate link targets
validate_link_targets() {
    local parsed_links_file="$1"
    log "Validating link targets..."
    
    local broken_links_file="$TEMP_DIR/broken_links.txt"
    validate_all_links "$parsed_links_file" "$broken_links_file"
    
    local broken_count
    broken_count=$(wc -l < "$broken_links_file" | tr -d ' ')
    log "Found $broken_count broken links"
    
    echo "$broken_links_file"
}

# Categorize and prioritize broken links
categorize_broken_links() {
    local broken_links_file="$1"
    log "Categorizing and prioritizing broken links..."
    
    local categorized_links_file="$TEMP_DIR/categorized_links.txt"
    local summary_file="$TEMP_DIR/summary.txt"
    local suggestions_file="$TEMP_DIR/suggestions.txt"
    
    # Categorize broken links
    categorize_broken_links "$broken_links_file" "$categorized_links_file"
    
    # Generate summary statistics
    generate_summary_stats "$categorized_links_file" "$summary_file"
    
    # Generate fix suggestions
    suggest_link_fixes "$categorized_links_file" "$suggestions_file"
    
    log "Categorization complete"
    
    echo "$categorized_links_file|$summary_file|$suggestions_file"
}

# Generate reports
generate_reports() {
    local categorized_links_file="$1"
    local summary_file="$2"
    local suggestions_file="$3"
    
    log "Generating reports..."
    
    local output_format="${OUTPUT_FORMAT:-all}"
    
    case "$output_format" in
        json)
            generate_json_report "$categorized_links_file" "$summary_file" "$suggestions_file" "${OUTPUT_PREFIX}.json"
            ;;
        csv)
            generate_csv_report "$categorized_links_file" "${OUTPUT_PREFIX}.csv"
            ;;
        md)
            generate_human_report "$categorized_links_file" "$summary_file" "${OUTPUT_PREFIX}.md"
            ;;
        all|*)
            generate_all_reports "$categorized_links_file" "$summary_file" "$suggestions_file" "$OUTPUT_PREFIX"
            ;;
    esac
    
    log "Reports generated successfully"
}

# Display execution summary
display_summary() {
    local summary_file="$1"
    
    log "=== EXECUTION SUMMARY ==="
    
    if [[ -f "$summary_file" ]]; then
        local total_broken
        total_broken=$(grep "SUMMARY_TOTAL_BROKEN=" "$summary_file" | cut -d'=' -f2)
        log "Total broken links found: $total_broken"
        
        log "Breakdown by category:"
        grep -A 10 "SUMMARY_BY_CATEGORY:" "$summary_file" | grep "  " | while IFS='=' read -r category count; do
            category=$(echo "$category" | sed 's/^[[:space:]]*//')
            log "  $category: $count"
        done
        
        log "Breakdown by priority:"
        grep -A 10 "SUMMARY_BY_PRIORITY:" "$summary_file" | grep "  " | while IFS='=' read -r priority count; do
            priority=$(echo "$priority" | sed 's/^[[:space:]]*//')
            log "  $priority: $count"
        done
    fi
    
    log "Output files:"
    log "  Reports: ${OUTPUT_PREFIX}.*"
    log "  Log file: $LOG_FILE"
    log "Execution completed successfully"
}

# Main execution function
main() {
    local start_time
    start_time=$(date +%s)
    
    # Parse command line arguments
    parse_arguments "$@"
    
    # Initialize environment
    initialize_environment
    
    # Find files to scan
    local file_list
    file_list=$(find_markdown_files)
    
    # Scan and extract links
    local all_links_file
    all_links_file=$(scan_markdown_files "$file_list")
    
    # Extract internal links
    local parsed_links_file
    parsed_links_file=$(extract_internal_links "$all_links_file")
    
    # Validate link targets
    local broken_links_file
    broken_links_file=$(validate_link_targets "$parsed_links_file")
    
    # Categorize broken links
    local categorization_result
    categorization_result=$(categorize_broken_links "$broken_links_file")
    IFS='|' read -r categorized_links_file summary_file suggestions_file <<< "$categorization_result"
    
    # Generate reports
    generate_reports "$categorized_links_file" "$summary_file" "$suggestions_file"
    
    # Display summary
    display_summary "$summary_file"
    
    # Calculate execution time
    local end_time
    end_time=$(date +%s)
    local execution_time=$((end_time - start_time))
    log "Total execution time: ${execution_time} seconds"
    
    # Performance validation
    if [[ $execution_time -gt 30 ]]; then
        log "WARNING: Execution time exceeded 30-second target ($execution_time seconds)"
    else
        log "Performance target met: execution completed in $execution_time seconds"
    fi
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi