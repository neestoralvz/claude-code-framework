#!/bin/bash

# Claude Code Framework Link Scanner (macOS Compatible)
# Finds all markdown links and checks if target files exist

DOCS_DIR="/Users/nalve/.claude/docs"
COMMANDS_DIR="/Users/nalve/.claude/commands"
ROOT_DIR="/Users/nalve/.claude"

echo "🔍 CLAUDE CODE LINK SCANNER"
echo "=========================="
echo "Scanning for broken links in documentation..."
echo ""

# Function to resolve relative paths (macOS compatible)
resolve_path() {
    local current_dir="$1"
    local link="$2"
    
    # Remove anchors (#section)
    link="${link%%#*}"
    
    # Skip external links (http/https)
    if [[ "$link" =~ ^https?:// ]]; then
        return 0
    fi
    
    # Skip empty links
    if [[ -z "$link" ]]; then
        return 0
    fi
    
    # Resolve relative path using python for cross-platform compatibility
    python3 -c "
import os
import sys
current_dir = sys.argv[1]
link = sys.argv[2]
if link.startswith('/'):
    print('$ROOT_DIR' + link)
else:
    print(os.path.normpath(os.path.join(current_dir, link)))
" "$current_dir" "$link"
}

# Function to check if file exists
check_file() {
    local file_path="$1"
    if [[ -f "$file_path" || -d "$file_path" ]]; then
        return 0
    else
        return 1
    fi
}

# Function to scan directory
scan_directory() {
    local dir="$1"
    local label="$2"
    
    echo "📁 Scanning $label..."
    
    find "$dir" -name "*.md" -type f | while read -r file; do
        local file_dir=$(dirname "$file")
        local relative_file="${file#$ROOT_DIR/}"
        
        grep -oE '\[[^]]*\]\([^)]+\)' "$file" 2>/dev/null | while read -r match; do
            link=$(echo "$match" | sed -n 's/.*](\([^)]*\)).*/\1/p')
            
            # Skip if link is empty or an anchor only
            if [[ -z "$link" || "$link" =~ ^# ]]; then
                continue
            fi
            
            target_path=$(resolve_path "$file_dir" "$link")
            
            if ! check_file "$target_path"; then
                echo "❌ BROKEN: $relative_file"
                echo "   Link: $match"
                echo "   Target: $target_path"
                echo ""
            fi
        done
    done
}

# Check if python3 is available
if ! command -v python3 &> /dev/null; then
    echo "❌ ERROR: python3 is required for path resolution"
    exit 1
fi

# Main scanning
scan_directory "$DOCS_DIR" "Documentation"
scan_directory "$COMMANDS_DIR" "Commands"

# Scan CLAUDE.md
if [[ -f "$ROOT_DIR/CLAUDE.md" ]]; then
    echo "📄 Scanning CLAUDE.md..."
    file_dir="$ROOT_DIR"
    
    grep -oE '\[[^]]*\]\([^)]+\)' "$ROOT_DIR/CLAUDE.md" 2>/dev/null | while read -r match; do
        link=$(echo "$match" | sed -n 's/.*](\([^)]*\)).*/\1/p')
        
        if [[ -z "$link" || "$link" =~ ^# ]]; then
            continue
        fi
        
        target_path=$(resolve_path "$file_dir" "$link")
        
        if ! check_file "$target_path"; then
            echo "❌ BROKEN: CLAUDE.md"
            echo "   Link: $match"
            echo "   Target: $target_path"
            echo ""
        fi
    done
fi

echo "=========================="
echo "📊 SCAN COMPLETE"
echo "Check output above for broken links"
