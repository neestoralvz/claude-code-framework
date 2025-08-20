#!/bin/bash
# Core Folder Reorganization Migration Script
# Version: 1.0
# Date: 2025-08-20

set -e  # Exit on error

# Configuration
CORE_DIR="/Users/nalve/.claude/core"
BACKUP_DIR="/Users/nalve/.claude/core_backup_$(date +%Y%m%d_%H%M%S)"
DRY_RUN=${1:-true}  # Pass 'false' as first argument to execute

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Core Folder Reorganization Script${NC}"
echo "====================================="

if [ "$DRY_RUN" = "true" ]; then
    echo -e "${YELLOW}DRY RUN MODE - No changes will be made${NC}"
    echo "Run with 'false' parameter to execute: $0 false"
    echo ""
fi

# Function to create directory structure
create_new_structure() {
    echo -e "${GREEN}Creating new directory structure...${NC}"
    
    local dirs=(
        "00-system"
        "01-foundation/principles"
        "01-foundation/standards" 
        "01-foundation/personalities"
        "02-operations/workflows"
        "02-operations/processes"
        "02-operations/agents"
        "03-tools/checks"
        "03-tools/utilities"
        "03-tools/registries"
        "04-templates/project-templates"
        "04-templates/examples"
        "04-templates/patterns"
        "05-dashboard/configuration"
        "05-dashboard/operations"
        "05-dashboard/assets"
        "06-archives/deprecated"
        "06-archives/backups"
    )
    
    for dir in "${dirs[@]}"; do
        if [ "$DRY_RUN" = "false" ]; then
            mkdir -p "$CORE_DIR/$dir"
            echo "  Created: $dir"
        else
            echo "  Would create: $dir"
        fi
    done
}

# Function to migrate files
migrate_files() {
    echo -e "\n${GREEN}Migrating files to new locations...${NC}"
    
    # Define file migrations as "source:destination" pairs
    local migrations=(
        "INDEX.md:00-system/index.md"
        "VISION.md:00-system/vision.md"
        "ROADMAP.md:00-system/roadmap.md"
        "CORE.md:00-system/core.md"
        "PRINCIPLES.md:01-foundation/principles/README.md"
        "STANDARDS.md:01-foundation/standards/README.md"
        "PERSONALITIES.md:01-foundation/personalities/README.md"
        "PROCESSES.md:02-operations/processes/README.md"
        "EXAMPLES.md:04-templates/examples/README.md"
        "CHECKS.md:03-tools/checks/README.md"
        "TOOLS.md:03-tools/utilities/README.md"
        "PROJECT-DOCUMENTATION-TEMPLATE.md:04-templates/project-templates/project-documentation.md"
        "organization-workflow.md:02-operations/workflows/organization-workflow.md"
        "agents-specialization-system.md:02-operations/agents/specialization-system.md"
    )
    
    for migration in "${migrations[@]}"; do
        IFS=':' read -r source dest <<< "$migration"
        
        if [ -f "$CORE_DIR/$source" ]; then
            if [ "$DRY_RUN" = "false" ]; then
                cp "$CORE_DIR/$source" "$CORE_DIR/$dest"
                echo "  Migrated: $source → $dest"
            else
                echo "  Would migrate: $source → $dest"
            fi
        else
            echo -e "  ${YELLOW}Skip (not found): $source${NC}"
        fi
    done
}

# Function to migrate directories
migrate_directories() {
    echo -e "\n${GREEN}Migrating directories...${NC}"
    
    # Define directory migrations
    local dir_migrations=(
        "principles:01-foundation/principles"
        "standards:01-foundation/standards"
        "personalities:01-foundation/personalities"
        "processes:02-operations/processes"
        "workflows:02-operations/workflows"
        "agents:02-operations/agents"
        "checks:03-tools/checks"
        "tools:03-tools/utilities"
        "registries:03-tools/registries"
        "templates:04-templates/project-templates"
        "examples:04-templates/examples"
        "behaviors_backup:06-archives/backups/behaviors"
    )
    
    for migration in "${dir_migrations[@]}"; do
        IFS=':' read -r source dest <<< "$migration"
        
        if [ -d "$CORE_DIR/$source" ]; then
            if [ "$DRY_RUN" = "false" ]; then
                cp -r "$CORE_DIR/$source/"* "$CORE_DIR/$dest/" 2>/dev/null || true
                echo "  Migrated: $source/* → $dest/"
            else
                echo "  Would migrate: $source/* → $dest/"
            fi
        else
            echo -e "  ${YELLOW}Skip (not found): $source${NC}"
        fi
    done
}

# Function to migrate dashboard (special handling due to complexity)
migrate_dashboard() {
    echo -e "\n${GREEN}Migrating dashboard structure...${NC}"
    
    if [ -d "$CORE_DIR/dashboard" ]; then
        local dashboard_dirs=("assets" "data" "hooks" "operations" "scripts")
        
        for dir in "${dashboard_dirs[@]}"; do
            if [ -d "$CORE_DIR/dashboard/$dir" ]; then
                local target=""
                case $dir in
                    "data"|"hooks"|"scripts")
                        target="05-dashboard/configuration"
                        ;;
                    "operations")
                        target="05-dashboard/operations"
                        ;;
                    "assets")
                        target="05-dashboard/assets"
                        ;;
                esac
                
                if [ -n "$target" ]; then
                    if [ "$DRY_RUN" = "false" ]; then
                        cp -r "$CORE_DIR/dashboard/$dir" "$CORE_DIR/$target/"
                        echo "  Migrated: dashboard/$dir → $target/"
                    else
                        echo "  Would migrate: dashboard/$dir → $target/"
                    fi
                fi
            fi
        done
        
        # Copy any root dashboard files
        if [ "$DRY_RUN" = "false" ]; then
            find "$CORE_DIR/dashboard" -maxdepth 1 -type f -exec cp {} "$CORE_DIR/05-dashboard/" \;
        else
            echo "  Would migrate: dashboard root files → 05-dashboard/"
        fi
    fi
}

# Function to create compatibility links
create_compatibility_links() {
    echo -e "\n${GREEN}Creating compatibility symbolic links...${NC}"
    
    local links=(
        "INDEX.md:00-system/index.md"
        "VISION.md:00-system/vision.md"
        "PRINCIPLES.md:01-foundation/principles/README.md"
        "STANDARDS.md:01-foundation/standards/README.md"
        "PROCESSES.md:02-operations/processes/README.md"
    )
    
    for link in "${links[@]}"; do
        IFS=':' read -r linkname target <<< "$link"
        
        if [ "$DRY_RUN" = "false" ]; then
            ln -sf "$target" "$CORE_DIR/$linkname"
            echo "  Created link: $linkname → $target"
        else
            echo "  Would create link: $linkname → $target"
        fi
    done
}

# Function to update CLAUDE.md references
update_claude_references() {
    echo -e "\n${GREEN}Updating CLAUDE.md references...${NC}"
    
    local claude_file="/Users/nalve/.claude/CLAUDE.md"
    
    if [ ! -f "$claude_file" ]; then
        echo -e "  ${YELLOW}CLAUDE.md not found${NC}"
        return
    fi
    
    # Define replacements
    local replacements=(
        "s|core/index\.md|core/00-system/index.md|g"
        "s|core/VISION\.md|core/00-system/vision.md|g"
        "s|core/ROADMAP\.md|core/00-system/roadmap.md|g"
        "s|core/PRINCIPLES\.md|core/01-foundation/principles/README.md|g"
        "s|core/STANDARDS\.md|core/01-foundation/standards/README.md|g"
        "s|core/PERSONALITIES\.md|core/01-foundation/personalities/README.md|g"
        "s|core/PROCESSES\.md|core/02-operations/processes/README.md|g"
        "s|core/EXAMPLES\.md|core/04-templates/examples/README.md|g"
        "s|core/organization-workflow\.md|core/02-operations/workflows/organization-workflow.md|g"
        "s|core/PROJECT-DOCUMENTATION-TEMPLATE\.md|core/04-templates/project-templates/project-documentation.md|g"
    )
    
    if [ "$DRY_RUN" = "false" ]; then
        # Create backup
        cp "$claude_file" "${claude_file}.backup"
        
        # Apply replacements
        for replacement in "${replacements[@]}"; do
            sed -i.tmp "$replacement" "$claude_file"
        done
        rm -f "${claude_file}.tmp"
        
        echo "  Updated CLAUDE.md references"
        echo "  Backup saved as CLAUDE.md.backup"
    else
        echo "  Would update references in CLAUDE.md"
        echo "  Sample replacements:"
        echo "    core/VISION.md → core/00-system/vision.md"
        echo "    core/PRINCIPLES.md → core/01-foundation/principles/README.md"
    fi
}

# Function to generate migration report
generate_report() {
    echo -e "\n${GREEN}Generating migration report...${NC}"
    
    local report_file="$CORE_DIR/migration-report-$(date +%Y%m%d-%H%M%S).md"
    
    if [ "$DRY_RUN" = "false" ]; then
        cat > "$report_file" << EOF
# Core Folder Migration Report

Date: $(date)
Status: Completed

## Actions Taken

1. Created new directory structure
2. Migrated root-level files
3. Migrated subdirectories
4. Created compatibility links
5. Updated CLAUDE.md references

## Next Steps

1. Verify all references work correctly
2. Test agent deployments
3. Run system checks
4. Remove old structure after validation

## Backup Location

$BACKUP_DIR

EOF
        echo "  Report saved to: $report_file"
    else
        echo "  Would generate report: migration-report-[timestamp].md"
    fi
}

# Main execution
main() {
    # Create backup if not dry run
    if [ "$DRY_RUN" = "false" ]; then
        echo -e "${YELLOW}Creating backup...${NC}"
        cp -r "$CORE_DIR" "$BACKUP_DIR"
        echo "Backup created at: $BACKUP_DIR"
        echo ""
    fi
    
    # Execute migration steps
    create_new_structure
    migrate_files
    migrate_directories
    migrate_dashboard
    create_compatibility_links
    update_claude_references
    generate_report
    
    echo -e "\n${GREEN}Migration process complete!${NC}"
    
    if [ "$DRY_RUN" = "true" ]; then
        echo -e "\n${YELLOW}This was a DRY RUN. No actual changes were made.${NC}"
        echo "To execute the migration, run: $0 false"
    else
        echo -e "\n${GREEN}Migration completed successfully!${NC}"
        echo "Backup location: $BACKUP_DIR"
        echo -e "\n${YELLOW}Important: Please verify all references and test the system before removing the old structure.${NC}"
    fi
}

# Run main function
main
