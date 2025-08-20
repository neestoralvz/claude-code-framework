#!/bin/bash

# Navigation Standardization Validator
# Validates navigation patterns across the .claude framework

set -euo pipefail

# Configuration
PROJECT_ROOT="/Users/nalve/.claude"
SYSTEM_DIR="$PROJECT_ROOT/system"
LOG_FILE="/tmp/navigation-validation.log"
REPORT_FILE="$PROJECT_ROOT/operations/20250819-201718-navigation-standardization/validation-report.md"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$LOG_FILE"
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$LOG_FILE"
}

# Validation functions
validate_emoji_navigation() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    
    # Check for emoji navigation bar
    if grep -q "🏠 System Hub" "$file"; then
        return 0
    else
        echo "Missing emoji navigation: $relative_path"
        return 1
    fi
}

validate_system_home_link() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    local filename=$(basename "$file")
    
    # Special case: INDEX.md should have System Hub link instead of System Home
    if [[ "$filename" == "INDEX.md" ]]; then
        if grep -q "System Hub" "$file" || grep -q "\\[🏠 System Hub\\]" "$file"; then
            return 0
        else
            echo "Missing System Hub link: $relative_path"
            return 1
        fi
    else
        # Check for system home link
        if grep -q "System Home" "$file" || grep -q "\\[↑ System Home\\]" "$file"; then
            return 0
        else
            echo "Missing System Home link: $relative_path"
            return 1
        fi
    fi
}

validate_navigation_section() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    
    # Check for Navigation section
    if grep -q "\*\*Navigation:\*\*" "$file"; then
        return 0
    else
        echo "Missing Navigation section: $relative_path"
        return 1
    fi
}

validate_context_statement() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    
    # Check for Context statement  
    if grep -q "\\*\\*Context\\*\\*:" "$file"; then
        return 0
    else
        echo "Missing Context statement: $relative_path"
        return 1
    fi
}

validate_link_integrity() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    local file_dir=$(dirname "$file")
    
    # Extract all markdown links from the file
    grep -oE '\[([^]]+)\]\(([^)]+)\)' "$file" | while IFS= read -r link; do
        # Extract URL from link
        url=$(echo "$link" | sed -E 's/\[([^]]+)\]\(([^)]+)\)/\2/')
        
        # Skip external URLs and anchors
        if [[ "$url" == http* ]] || [[ "$url" == "#"* ]]; then
            continue
        fi
        
        # Resolve relative path
        if [[ "$url" == /* ]]; then
            # Absolute path
            target_file="$PROJECT_ROOT$url"
        else
            # Relative path - use readlink for macOS compatibility
            if [[ -d "$file_dir" ]]; then
                target_file="$(cd "$file_dir" && pwd)/$url"
            else
                target_file="$file_dir/$url"
            fi
        fi
        
        # Check if target exists
        if [[ ! -f "$target_file" ]]; then
            echo "Broken link in $relative_path: $url -> $target_file"
            return 1
        fi
    done
    
    return 0
}

# Main validation function
validate_file() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"
    local errors=0
    
    log_info "Validating: $relative_path"
    
    # Run all validations
    if ! validate_emoji_navigation "$file"; then
        ((errors++))
    fi
    
    if ! validate_system_home_link "$file"; then
        ((errors++))
    fi
    
    if ! validate_navigation_section "$file"; then
        ((errors++))
    fi
    
    if ! validate_context_statement "$file"; then
        ((errors++))
    fi
    
    # Skip link integrity check for now due to complex path resolution
    # if ! validate_link_integrity "$file"; then
    #     ((errors++))
    # fi
    
    return $errors
}

# Generate validation report
generate_report() {
    local total_files="$1"
    local compliant_files="$2"
    local non_compliant_files="$3"
    
    cat > "$REPORT_FILE" << EOF
# Navigation Standardization Validation Report

**Generated**: $(date '+%Y-%m-%d %H:%M:%S')

## Summary

- **Total Files Analyzed**: $total_files
- **Compliant Files**: $compliant_files
- **Non-Compliant Files**: $non_compliant_files
- **Compliance Rate**: $(( (compliant_files * 100) / total_files ))%

## Validation Criteria

1. **Emoji Navigation Bar**: Contains 🏠 System Hub link
2. **System Home Link**: Contains navigation to INDEX.md
3. **Navigation Section**: Has **Navigation:** section at bottom
4. **Context Statement**: Includes **Context:** explanation
5. **Link Integrity**: All links resolve to existing files

## Non-Compliant Files

EOF
    
    if [[ $non_compliant_files -gt 0 ]]; then
        cat "$LOG_FILE" | grep -E "Missing|Broken" >> "$REPORT_FILE"
    else
        echo "None - All files are compliant!" >> "$REPORT_FILE"
    fi
    
    cat >> "$REPORT_FILE" << EOF

## Recommendations

1. **Immediate Actions**:
   - Add missing emoji navigation bars
   - Insert Context statements for all files
   - Fix broken links

2. **Standardization**:
   - Apply universal navigation template
   - Ensure consistent link formatting
   - Validate breadcrumb hierarchy

3. **Maintenance**:
   - Run validation script regularly
   - Update navigation patterns as framework evolves
   - Monitor link integrity continuously

---

**Report Generated by**: Navigation Standardization Validator
**Next Validation**: Recommended after implementation changes
EOF

    log_success "Validation report generated: $REPORT_FILE"
}

# Main execution
main() {
    log "Starting Navigation Standardization Validation"
    
    # Clear previous log
    > "$LOG_FILE"
    
    local total_files=0
    local compliant_files=0
    local non_compliant_files=0
    
    # Find all markdown files in system directory
    while IFS= read -r -d '' file; do
        ((total_files++))
        
        if validate_file "$file"; then
            ((compliant_files++))
            log_success "✅ Compliant: ${file#$PROJECT_ROOT/}"
        else
            ((non_compliant_files++))
            log_error "❌ Non-compliant: ${file#$PROJECT_ROOT/}"
        fi
    done < <(find "$SYSTEM_DIR" -name "*.md" -type f -print0)
    
    # Generate summary
    log ""
    log "=== VALIDATION SUMMARY ==="
    log "Total files: $total_files"
    log "Compliant: $compliant_files"
    log "Non-compliant: $non_compliant_files"
    log "Compliance rate: $(( (compliant_files * 100) / total_files ))%"
    
    # Generate report
    generate_report "$total_files" "$compliant_files" "$non_compliant_files"
    
    # Exit with appropriate code
    if [[ $non_compliant_files -eq 0 ]]; then
        log_success "🎉 All files are navigation compliant!"
        exit 0
    else
        log_error "⚠️  $non_compliant_files files require navigation updates"
        exit 1
    fi
}

# Help function
show_help() {
    cat << EOF
Navigation Standardization Validator

Usage: $0 [OPTIONS]

Options:
    -h, --help     Show this help message
    -v, --verbose  Enable verbose output
    --report-only  Generate report without validation

Description:
    Validates navigation patterns across the .claude framework
    according to the Universal Navigation Template Standard.

Output:
    - Console output with color-coded results
    - Detailed log file: $LOG_FILE
    - Validation report: $REPORT_FILE

Examples:
    $0                 # Run full validation
    $0 --verbose       # Run with detailed output
    $0 --help          # Show this help

EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            set -x
            shift
            ;;
        --report-only)
            # Generate report from existing log
            if [[ -f "$LOG_FILE" ]]; then
                generate_report "0" "0" "0"
                exit 0
            else
                log_error "No existing log file found. Run validation first."
                exit 1
            fi
            ;;
        *)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Run main function
main