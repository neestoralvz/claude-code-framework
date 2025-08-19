#!/bin/bash

# Ticket Status Management Script
# Update ticket status and move files between directories

TICKET_BASE="/Users/nalve/.claude/docs/planning/tickets"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to display usage
usage() {
    echo -e "${BLUE}Ticket Status Management Tool${NC}"
    echo ""
    echo "Usage: $0 <ticket-id> <new-status> [options]"
    echo ""
    echo "Status options:"
    echo "  pending       - Move to pending queue"
    echo "  in-progress   - Mark as in progress"
    echo "  completed     - Mark as completed"
    echo "  blocked       - Mark as blocked"
    echo ""
    echo "Examples:"
    echo "  $0 MOD-001 completed"
    echo "  $0 MOD-002 in-progress"
    echo ""
    exit 1
}

# Check arguments
if [ $# -lt 2 ]; then
    usage
fi

TICKET_ID=$1
NEW_STATUS=$2
TIMESTAMP=$(date +%Y-%m-%d)

# Function to find ticket file
find_ticket() {
    local id=$1
    for dir in pending in-progress completed blocked; do
        for file in "$TICKET_BASE"/$dir/*.md; do
            if [ -f "$file" ] && grep -q "ticket_id: $id" "$file"; then
                echo "$file"
                return 0
            fi
        done
    done
    return 1
}

# Function to update ticket status
update_status() {
    local file=$1
    local status=$2
    local temp_file="/tmp/ticket_update.tmp"
    
    # Update status in file
    sed "s/^status: .*/status: $status/" "$file" > "$temp_file"
    
    # Add completion date if completing
    if [ "$status" = "completed" ]; then
        if ! grep -q "^completed:" "$temp_file"; then
            sed -i "/^status: completed/a completed: $TIMESTAMP" "$temp_file"
        else
            sed -i "s/^completed: .*/completed: $TIMESTAMP/" "$temp_file"
        fi
    fi
    
    # Add started date if starting
    if [ "$status" = "in-progress" ] || [ "$status" = "in_progress" ]; then
        if ! grep -q "^started:" "$temp_file"; then
            sed -i "/^status: in-progress/a started: $TIMESTAMP" "$temp_file"
        fi
    fi
    
    mv "$temp_file" "$file"
}

# Function to move ticket file
move_ticket() {
    local file=$1
    local new_status=$2
    local filename=$(basename "$file")
    local target_dir=""
    
    case "$new_status" in
        pending)
            target_dir="$TICKET_BASE/pending"
            ;;
        in-progress|in_progress)
            target_dir="$TICKET_BASE/in-progress"
            ;;
        completed)
            target_dir="$TICKET_BASE/completed"
            ;;
        blocked)
            target_dir="$TICKET_BASE/blocked"
            ;;
        *)
            echo -e "${RED}Error: Invalid status '$new_status'${NC}"
            exit 1
            ;;
    esac
    
    # Create target directory if it doesn't exist
    mkdir -p "$target_dir"
    
    # Move file
    mv "$file" "$target_dir/$filename"
    echo "$target_dir/$filename"
}

# Main execution
echo -e "${YELLOW}Updating ticket $TICKET_ID to status: $NEW_STATUS${NC}"

# Find ticket file
TICKET_FILE=$(find_ticket "$TICKET_ID")

if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Ticket $TICKET_ID not found${NC}"
    exit 1
fi

echo "Found ticket at: $TICKET_FILE"

# Update status in file
update_status "$TICKET_FILE" "$NEW_STATUS"

# Move file to appropriate directory
NEW_LOCATION=$(move_ticket "$TICKET_FILE" "$NEW_STATUS")

echo -e "${GREEN}✓ Ticket $TICKET_ID updated successfully${NC}"
echo "New location: $NEW_LOCATION"

# Update registry
echo -e "${YELLOW}Updating ticket registry...${NC}"
/Users/nalve/.claude/scripts/update-ticket-registry.sh

echo -e "${GREEN}✓ All updates complete!${NC}"