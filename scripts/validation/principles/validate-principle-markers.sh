#!/bin/bash

# Principle Marker Validation Script
# Validates principle marker formatting and references across documentation

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validation counters
TOTAL_FILES=0
VALID_MARKERS=0
INVALID_MARKERS=0
MISSING_LINKS=0
BROKEN_LINKS=0

echo -e "${BLUE}🔍 PRINCIPLE MARKER VALIDATION${NC}"
echo "=================================="

# Find all markdown files with principle markers
MARKER_FILES=$(find . -name "*.md" -exec grep -l "⏺.*\*\*Principle\*\*" {} \;)

if [ -z "$MARKER_FILES" ]; then
    echo -e "${YELLOW}⚠️  No principle markers found${NC}"
    exit 0
fi

echo -e "${BLUE}📋 Files with principle markers:${NC}"
echo "$MARKER_FILES" | wc -l
echo ""

# Validate each file
for file in $MARKER_FILES; do
    TOTAL_FILES=$((TOTAL_FILES + 1))
    echo -e "${BLUE}📄 Checking: $file${NC}"
    
    # Extract all principle markers from file
    MARKERS=$(grep -n "⏺.*\*\*Principle\*\*" "$file")
    
    while IFS= read -r line; do
        if [ -n "$line" ]; then
            LINE_NUM=$(echo "$line" | cut -d: -f1)
            MARKER_TEXT=$(echo "$line" | cut -d: -f2-)
            
            echo -e "  ${YELLOW}Line $LINE_NUM:${NC} $MARKER_TEXT"
            
            # Validate marker format
            if echo "$MARKER_TEXT" | grep -q "⏺ \*\*Principle\*\*: "; then
                echo -e "    ${GREEN}✅ Format valid${NC}"
                VALID_MARKERS=$((VALID_MARKERS + 1))
                
                # Extract and validate links
                LINKS=$(echo "$MARKER_TEXT" | grep -oE '\[[^]]+\]\([^)]+\)')
                
                if [ -n "$LINKS" ]; then
                    while IFS= read -r link; do
                        if [ -n "$link" ]; then
                            # Extract path from link
                            LINK_PATH=$(echo "$link" | sed 's/.*](\([^)]*\)).*/\1/' | sed 's/#.*//')
                            
                            # Check if link target exists (relative to file directory)
                            FILE_DIR=$(dirname "$file")
                            FULL_PATH="$FILE_DIR/$LINK_PATH"
                            
                            if [ -f "$FULL_PATH" ]; then
                                echo -e "    ${GREEN}✅ Link valid: $link${NC}"
                            else
                                echo -e "    ${RED}❌ Broken link: $link${NC}"
                                echo -e "    ${RED}   Path: $FULL_PATH${NC}"
                                BROKEN_LINKS=$((BROKEN_LINKS + 1))
                            fi
                        fi
                    done <<< "$LINKS"
                else
                    echo -e "    ${YELLOW}⚠️  No principle links found${NC}"
                    MISSING_LINKS=$((MISSING_LINKS + 1))
                fi
            else
                echo -e "    ${RED}❌ Invalid format${NC}"
                INVALID_MARKERS=$((INVALID_MARKERS + 1))
                
                # Check specific format issues
                if ! echo "$MARKER_TEXT" | grep -q "⏺"; then
                    echo -e "    ${RED}   Missing marker symbol (⏺)${NC}"
                fi
                if ! echo "$MARKER_TEXT" | grep -q "\*\*Principle\*\*"; then
                    echo -e "    ${RED}   Missing or incorrect **Principle** label${NC}"
                fi
                if ! echo "$MARKER_TEXT" | grep -q ": "; then
                    echo -e "    ${RED}   Missing colon and space after Principle${NC}"
                fi
            fi
            echo ""
        fi
    done <<< "$MARKERS"
    echo ""
done

# Summary report
echo -e "${BLUE}📊 VALIDATION SUMMARY${NC}"
echo "===================="
echo -e "Files processed: ${BLUE}$TOTAL_FILES${NC}"
echo -e "Valid markers: ${GREEN}$VALID_MARKERS${NC}"
echo -e "Invalid markers: ${RED}$INVALID_MARKERS${NC}"
echo -e "Missing links: ${YELLOW}$MISSING_LINKS${NC}"
echo -e "Broken links: ${RED}$BROKEN_LINKS${NC}"
echo ""

# Calculate percentages
if [ $((VALID_MARKERS + INVALID_MARKERS)) -gt 0 ]; then
    TOTAL_MARKERS=$((VALID_MARKERS + INVALID_MARKERS))
    VALIDITY_PERCENT=$(( (VALID_MARKERS * 100) / TOTAL_MARKERS ))
    echo -e "Validity rate: ${BLUE}$VALIDITY_PERCENT%${NC}"
fi

# Exit with error if validation issues found
if [ $INVALID_MARKERS -gt 0 ] || [ $BROKEN_LINKS -gt 0 ]; then
    echo -e "${RED}❌ Validation failed${NC}"
    exit 1
else
    echo -e "${GREEN}✅ All principle markers valid${NC}"
    exit 0
fi