#!/usr/bin/env python3
"""
Breadcrumb Cleanup Script

Systematically removes manual breadcrumb navigation from all markdown files
in the system directory to keep content clean and focused.

Based on our "automate vs manual" decision process.
"""

import os
import re
from pathlib import Path
from robocorp.tasks import task


def find_markdown_files(directory):
    """Find all markdown files in the directory and subdirectories."""
    md_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.md'):
                md_files.append(Path(root) / file)
    return md_files


def remove_breadcrumbs(content):
    """Remove breadcrumb navigation patterns from content."""
    
    # Remove breadcrumb navigation at top like:
    # **[System](../INDEX.md) › [Standards](../STANDARDS.md) › File Name**
    breadcrumb_pattern = r'\*\*\[.*?\]\(.*?\).*?\*\*\n*'
    content = re.sub(breadcrumb_pattern, '', content)
    
    # Remove navigation sections at bottom like:
    # ---
    # **Navigation:** [← Back to...] | [↑ System Home]
    nav_section_pattern = r'\n*---\n\*\*Navigation:\*\*.*?\n*'
    content = re.sub(nav_section_pattern, '', content, flags=re.DOTALL)
    
    # Clean up multiple newlines
    content = re.sub(r'\n{3,}', '\n\n', content)
    
    return content.strip() + '\n'


def process_file(file_path):
    """Process a single markdown file to remove breadcrumbs."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            original_content = f.read()
        
        cleaned_content = remove_breadcrumbs(original_content)
        
        # Only write if content changed
        if cleaned_content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(cleaned_content)
            return True
        return False
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return False


@task
def cleanup_breadcrumbs():
    """Main task to clean up breadcrumbs from all system files."""
    
    # Start from the system directory
    system_dir = Path(__file__).parent.parent
    
    print(f"Scanning for markdown files in {system_dir}")
    md_files = find_markdown_files(system_dir)
    
    print(f"Found {len(md_files)} markdown files")
    
    processed_count = 0
    for file_path in md_files:
        if process_file(file_path):
            print(f"Cleaned: {file_path.relative_to(system_dir)}")
            processed_count += 1
    
    print(f"\nCompleted! Processed {processed_count} files.")
    print("All files now have clean content without manual navigation.")


if __name__ == "__main__":
    cleanup_breadcrumbs()