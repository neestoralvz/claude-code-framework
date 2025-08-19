#!/bin/bash

# NAV Migration Link Fixer
# Fixes links pointing to moved NAV tickets from planning/tickets/ to tickets/

ROOT_DIR="/Users/nalve/.claude"
BACKUP_DIR="$ROOT_DIR/scripts/backups/nav-migration-$(date +%Y%m%d-%H%M%S)"

echo "🔧 NAV MIGRATION LINK FIXER"
echo "==========================="
echo "Fixing NAV ticket migration links..."
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Counter for changes
changes_made=0

# Function to process a file
fix_nav_links() {
    local file="$1"
    local relative_file="${file#$ROOT_DIR/}"
    local backup_file="$BACKUP_DIR/$(basename "$file")"
    
    # Create backup
    cp "$file" "$backup_file"
    
    # Apply NAV migration fixes - correct relative path changes
    sed -i '' \
        -e 's|../../planning/TICKET_REGISTRY\.md|../planning/TICKET_REGISTRY.md|g' \
        -e 's|"planning/TICKET_REGISTRY\.md"|"../planning/TICKET_REGISTRY.md"|g' \
        -e 's|planning/TICKET_REGISTRY\.md|../planning/TICKET_REGISTRY.md|g' \
        "$file"
        
    # Check if changes were made
    if ! diff -q "$file" "$backup_file" > /dev/null 2>&1; then
        echo "✅ Updated: $relative_file"
        changes_made=$((changes_made + 1))
    fi
}

# Find all files in the moved tickets directory that need path corrections
echo "📁 Scanning tickets/ directory for TICKET_REGISTRY references..."

find "$ROOT_DIR/tickets" -name "*.md" -type f | while read -r file; do
    # Check if file contains references that need fixing
    if grep -q -E "(../../planning/TICKET_REGISTRY|planning/TICKET_REGISTRY)" "$file" 2>/dev/null; then
        fix_nav_links "$file"
    fi
done

echo ""
echo "========================="
echo "✅ NAV migration fixes complete!"
echo "Backups saved to: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "1. Run link-scanner.sh to verify fixes"
echo "2. Test critical navigation paths"
echo "3. Validate NAV ticket accessibility"