#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values from JSON
model_name=$(echo "$input" | jq -r '.model.display_name')
model_id=$(echo "$input" | jq -r '.model.id')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
output_style=$(echo "$input" | jq -r '.output_style.name')
session_id=$(echo "$input" | jq -r '.session_id')
transcript_path=$(echo "$input" | jq -r '.transcript_path')

# Get short current directory path (replace /Users/nalve with ~)
short_path=$(echo "$current_dir" | sed 's|^/Users/nalve|~|')

# Get session name from transcript path (extract just the filename without extension)
session_name=$(basename "$transcript_path" .md)

# Get directory metrics
file_count=$(find "$current_dir" -maxdepth 1 -type f 2>/dev/null | wc -l | tr -d ' ')
dir_size=$(du -sh "$current_dir" 2>/dev/null | cut -f1)

# Get git status with detailed info
git_info=""
git_color=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        # Check for changes
        changes=""
        if ! git diff --quiet 2>/dev/null; then
            changes="${changes}M"
        fi
        if ! git diff --cached --quiet 2>/dev/null; then
            changes="${changes}S"
        fi
        if [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
            changes="${changes}U"
        fi
        
        # Get ahead/behind info
        ahead_behind=""
        if git rev-parse --abbrev-ref @{upstream} > /dev/null 2>&1; then
            ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null || echo "0")
            behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null || echo "0")
            if [ "$ahead" -gt 0 ] || [ "$behind" -gt 0 ]; then
                ahead_behind=" ↑${ahead}↓${behind}"
            fi
        fi
        
        # Build git status
        status_indicator=""
        if [ -n "$changes" ]; then
            status_indicator="[$changes]"
            git_color="\033[1;31m"  # Bold red for changes
        else
            git_color="\033[1;32m"  # Bold green for clean
        fi
        
        git_info="󰊢 ${branch}${status_indicator}${ahead_behind}"
    fi
fi

# Get compact date (MM/dd HH:MM)
current_datetime=$(date +"%m/%d %H:%M")

# Model-specific color and icon with basic colors
model_color=""
model_icon=""
case "$model_id" in
    *sonnet*)
        model_color="\033[1;34m"  # Bold blue for Sonnet
        model_icon="󰚩"
        ;;
    *haiku*)
        model_color="\033[1;32m"  # Bold green for Haiku
        model_icon="󰚩"
        ;;
    *opus*)
        model_color="\033[1;33m"  # Bold yellow for Opus
        model_icon="󰚩"
        ;;
    *)
        model_color="\033[1;34m"  # Bold blue for others
        model_icon="󰚩"
        ;;
esac

# Build comprehensive status line with proper colors
printf "%s%s %s\033[0m \033[2m•\033[0m \033[1;34m%s\033[0m \033[2m•\033[0m \033[1;37m%s\033[0m \033[2m•\033[0m \033[1;31m%s\033[0m \033[2m•\033[0m %s%s\033[0m \033[2m•\033[0m \033[1;32m%s\033[0m \033[2m•\033[0m \033[1;33m%s files, %s\033[0m\n" \
    "$model_color" \
    "$model_icon" \
    "$model_name" \
    "$short_path" \
    "$session_name" \
    "$output_style" \
    "$git_color" \
    "$git_info" \
    "$current_datetime" \
    "$file_count" \
    "$dir_size"