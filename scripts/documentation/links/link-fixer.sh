#!/bin/bash

# Claude Code Framework Link Fixer
# Automatically fixes broken links based on new folder structure

DOCS_DIR="/Users/nalve/.claude/docs"
ROOT_DIR="/Users/nalve/.claude"

echo "🔧 CLAUDE CODE LINK FIXER"
echo "========================"
echo "Fixing broken links based on new folder structure..."
echo ""

# Function to fix links in a file
fix_links_in_file() {
    local file="$1"
    local backup_file="${file}.backup-$(date +%Y%m%d-%H%M%S)"
    
    # Create backup
    cp "$file" "$backup_file"
    
    echo "🔧 Fixing links in: ${file#$ROOT_DIR/}"
    
    # Fix common broken link patterns
    sed -i '' \
        -e 's|\.\./PRINCIPLES\.md|principles/PRINCIPLES.md|g' \
        -e 's|\.\./\.\./docs/principles/|../../docs/principles/|g' \
        -e 's|principles/agent-definition\.md|principles/agent-definition.md|g' \
        -e 's|principles/engineering\.md|principles/engineering.md|g' \
        -e 's|principles/workflow\.md|principles/workflow.md|g' \
        -e 's|principles/organization\.md|principles/organization.md|g' \
        -e 's|principles/simplicity\.md|principles/simplicity.md|g' \
        -e 's|principles/communication\.md|principles/communication.md|g' \
        -e 's|principles/validation\.md|principles/validation.md|g' \
        -e 's|principles/agent-selection\.md|principles/agent-selection.md|g' \
        -e 's|principles/task-orchestration\.md|principles/task-orchestration.md|g' \
        -e 's|principles/dynamic-adaptation\.md|principles/dynamic-adaptation.md|g' \
        -e 's|\.\./components/|../templates/components/|g' \
        -e 's|\.\./\.\./components/|../../templates/components/|g' \
        -e 's|/docs/components/|/docs/templates/components/|g' \
        -e 's|components/|templates/components/|g' \
        -e 's|agent-capability-matrix\.md|architecture/agent-capability-matrix.md|g' \
        -e 's|\.\./agent-capability-matrix\.md|../architecture/agent-capability-matrix.md|g' \
        -e 's|\.\./\.\./agent-capability-matrix\.md|../../architecture/agent-capability-matrix.md|g' \
        "$file"
        
    # Check if changes were made
    if ! diff -q "$file" "$backup_file" > /dev/null 2>&1; then
        echo "   ✅ Updated: ${file#$ROOT_DIR/}"
        rm "$backup_file"  # Remove backup if changes made
    else
        mv "$backup_file" "$file"  # Restore original if no changes
    fi
}

# Fix all markdown files in docs directory
find "$DOCS_DIR" -name "*.md" -type f | while read -r file; do
    fix_links_in_file "$file"
done

# Fix CLAUDE.md
if [[ -f "$ROOT_DIR/CLAUDE.md" ]]; then
    fix_links_in_file "$ROOT_DIR/CLAUDE.md"
fi

echo ""
echo "========================"
echo "✅ Link fixing complete!"
echo "Run link-scanner.sh again to verify fixes"
