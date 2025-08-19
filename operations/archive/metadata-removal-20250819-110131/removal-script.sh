#!/bin/bash

# Metadata Removal Script
# Systematically removes YAML frontmatter from markdown files

cd /Users/nalve/.claude/docs

echo "Starting metadata removal process..."
echo "Processing files with YAML frontmatter..."

processed=0
total=$(find . -name "*.md" -exec grep -l "^---$" {} \; | wc -l)

echo "Total files to process: $total"

# Process each file with YAML frontmatter
find . -name "*.md" -exec grep -l "^---$" {} \; | while read file; do
    echo "Processing: $file"
    
    # Create backup
    cp "$file" "$file.backup"
    
    # Remove YAML frontmatter (from start of file to second ---)
    sed '/^---$/,/^---$/d' "$file.backup" > "$file.temp"
    
    # Remove any leading empty lines
    sed '/./,$!d' "$file.temp" > "$file"
    
    # Cleanup
    rm "$file.temp"
    
    processed=$((processed + 1))
    echo "Processed $processed/$total files"
done

echo "Metadata removal complete!"
echo "Backup files created with .backup extension"