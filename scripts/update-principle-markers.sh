#!/bin/bash

# Principle Marker Update Script
# Updates principle markers to standardized format

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Update counters
FILES_UPDATED=0
MARKERS_UPDATED=0

echo -e "${BLUE}🔄 PRINCIPLE MARKER STANDARDIZATION${NC}"
echo "==================================="

# Dry run flag
DRY_RUN=false
if [ "$1" = "--dry-run" ]; then
    DRY_RUN=true
    echo -e "${YELLOW}🔍 DRY RUN MODE - No changes will be made${NC}"
    echo ""
fi

# Find all markdown files with principle markers
MARKER_FILES=$(find . -name "*.md" -exec grep -l "⏺.*\*\*Principle\*\*" {} \;)

if [ -z "$MARKER_FILES" ]; then
    echo -e "${YELLOW}⚠️  No principle markers found${NC}"
    exit 0
fi

echo -e "${BLUE}📋 Files to process: $(echo "$MARKER_FILES" | wc -l)${NC}"
echo ""

# Process each file
for file in $MARKER_FILES; do
    echo -e "${BLUE}📄 Processing: $file${NC}"
    
    # Check if file needs updates
    FILE_CHANGED=false
    TEMP_FILE=$(mktemp)
    
    # Read file line by line and fix principle markers
    while IFS= read -r line; do
        if echo "$line" | grep -q "⏺.*\*\*Principle\*\*"; then
            ORIGINAL_LINE="$line"
            
            # Fix common formatting issues
            FIXED_LINE="$line"
            
            # Ensure proper spacing after colon (standardize to single space)
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/⏺ \*\*Principle\*\*:/⏺ **Principle**: /')
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/⏺ \*\*Principle\*\*  :/⏺ **Principle**: /')
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/⏺ \*\*Principle\*\*   :/⏺ **Principle**: /')
            
            # Fix spacing after marker symbol
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/⏺\*\*Principle\*\*/⏺ **Principle**/')
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/⏺  \*\*Principle\*\*/⏺ **Principle**/')
            
            # Standardize "This [component/section] implements" pattern
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/This component implements/This component implements/')
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/This section implements/This section implements/')
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/This command implements/This command implements/')
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/This framework implements/This framework implements/')
            FIXED_LINE=$(echo "$FIXED_LINE" | sed 's/This methodology implements/This methodology implements/')
            
            # Check if line was changed
            if [ "$ORIGINAL_LINE" != "$FIXED_LINE" ]; then
                echo -e "  ${YELLOW}📝 Updating marker:${NC}"
                echo -e "  ${RED}❌ Old: $ORIGINAL_LINE${NC}"
                echo -e "  ${GREEN}✅ New: $FIXED_LINE${NC}"
                FILE_CHANGED=true
                MARKERS_UPDATED=$((MARKERS_UPDATED + 1))
            else
                echo -e "  ${GREEN}✅ Already standardized${NC}"
            fi
            
            echo "$FIXED_LINE" >> "$TEMP_FILE"
        else
            echo "$line" >> "$TEMP_FILE"
        fi
    done < "$file"
    
    # Apply changes if file was modified and not in dry run mode
    if [ "$FILE_CHANGED" = true ]; then
        if [ "$DRY_RUN" = false ]; then
            mv "$TEMP_FILE" "$file"
            echo -e "  ${GREEN}💾 File updated${NC}"
            FILES_UPDATED=$((FILES_UPDATED + 1))
        else
            echo -e "  ${YELLOW}🔍 Would update file (dry run)${NC}"
            rm "$TEMP_FILE"
        fi
    else
        rm "$TEMP_FILE"
        echo -e "  ${BLUE}ℹ️  No changes needed${NC}"
    fi
    
    echo ""
done

# Summary report
echo -e "${BLUE}📊 UPDATE SUMMARY${NC}"
echo "=================="
if [ "$DRY_RUN" = true ]; then
    echo -e "Mode: ${YELLOW}DRY RUN${NC}"
else
    echo -e "Mode: ${GREEN}LIVE UPDATE${NC}"
fi
echo -e "Files updated: ${GREEN}$FILES_UPDATED${NC}"
echo -e "Markers updated: ${GREEN}$MARKERS_UPDATED${NC}"

if [ "$DRY_RUN" = true ] && [ $MARKERS_UPDATED -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}💡 To apply changes, run without --dry-run flag${NC}"
fi

echo -e "${GREEN}✅ Standardization complete${NC}"