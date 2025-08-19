#!/usr/bin/env python3
"""
Automated Link Repair System
Systematic repair of broken markdown links based on validation analysis
"""

import os
import re
import json
from pathlib import Path

class LinkRepairer:
    def __init__(self, root_dir, broken_links_file):
        self.root_dir = Path(root_dir)
        self.file_mapping = self.create_file_mapping()
        
        with open(broken_links_file, 'r') as f:
            self.broken_links = json.load(f)
        
        self.repairs_made = 0
        self.repairs_log = []
    
    def create_file_mapping(self):
        """Create comprehensive file location mapping"""
        mapping = {}
        for md_file in self.root_dir.rglob('*.md'):
            filename = md_file.name
            if filename not in mapping:
                mapping[filename] = []
            mapping[filename].append(md_file)
        return mapping
    
    def find_best_match(self, broken_url, source_file):
        """Find best matching file for broken URL"""
        # Extract filename from broken URL
        url_parts = broken_url.strip('./').split('/')
        target_filename = url_parts[-1]
        
        if target_filename in self.file_mapping:
            # Calculate best relative path
            source_path = Path(source_file)
            candidates = self.file_mapping[target_filename]
            
            # Prefer files in similar directory structure
            best_match = None
            best_score = float('inf')
            
            for candidate in candidates:
                try:
                    rel_path = os.path.relpath(candidate, source_path.parent)
                    # Score based on path simplicity
                    score = rel_path.count('../') + rel_path.count('/')
                    if score < best_score:
                        best_score = score
                        best_match = rel_path
                except:
                    continue
            
            return best_match
        return None
    
    def repair_file(self, file_path):
        """Repair all broken links in a specific file"""
        repairs_in_file = 0
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            
            # Get broken links for this file
            file_broken_links = []
            for category in ['moved_deleted', 'incorrect_paths', 'filename_typos']:
                for link in self.broken_links.get(category, []):
                    if link['source_file'] == str(file_path):
                        file_broken_links.append(link)
            
            # Sort by line number (descending) to avoid offset issues
            file_broken_links.sort(key=lambda x: x['line'], reverse=True)
            
            for link in file_broken_links:
                old_url = link['url']
                new_url = self.find_best_match(old_url, file_path)
                
                if new_url:
                    # Create regex pattern for the specific link
                    escaped_text = re.escape(link['text'])
                    escaped_url = re.escape(old_url)
                    pattern = f'\\[{escaped_text}\\]\\({escaped_url}\\)'
                    replacement = f'[{link["text"]}]({new_url})'
                    
                    new_content = re.sub(pattern, replacement, content, count=1)
                    if new_content != content:
                        content = new_content
                        repairs_in_file += 1
                        self.repairs_log.append({
                            'file': str(file_path),
                            'line': link['line'],
                            'old_url': old_url,
                            'new_url': new_url,
                            'text': link['text']
                        })
            
            # Write back if changes made
            if repairs_in_file > 0:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f"Repaired {repairs_in_file} links in {file_path}")
            
            self.repairs_made += repairs_in_file
            
        except Exception as e:
            print(f"Error processing {file_path}: {e}")
    
    def repair_all(self):
        """Repair broken links across all files"""
        print("Starting automated link repair...")
        
        # Get unique files with broken links
        files_to_repair = set()
        for category in ['moved_deleted', 'incorrect_paths', 'filename_typos']:
            for link in self.broken_links.get(category, []):
                files_to_repair.add(link['source_file'])
        
        for file_path in files_to_repair:
            self.repair_file(file_path)
        
        print(f"\nRepair complete! {self.repairs_made} links repaired across {len(files_to_repair)} files.")
        
        # Generate repair report
        self.generate_repair_report()
    
    def generate_repair_report(self):
        """Generate detailed repair report"""
        report_path = self.root_dir / 'operations' / f'{Path().resolve().name.split("-")[-1]}' / 'link-repair-report.md'
        
        with open(report_path, 'w') as f:
            f.write(f"""# Automated Link Repair Report
Date: {Path().resolve().name}
Total Repairs Made: {self.repairs_made}

## Repair Summary
""")
            
            for repair in self.repairs_log[:20]:  # Show first 20 repairs
                f.write(f"""
### File: {repair['file']}
- **Line**: {repair['line']}
- **Text**: `{repair['text']}`
- **Old URL**: `{repair['old_url']}`
- **New URL**: `{repair['new_url']}`
""")
            
            if len(self.repairs_log) > 20:
                f.write(f"\n... and {len(self.repairs_log) - 20} more repairs\n")

def main():
    root_dir = "/Users/nalve/.claude"
    broken_links_file = "/Users/nalve/.claude/operations/20250819-broken-links-analysis/broken-links-analysis-detailed.json"
    
    repairer = LinkRepairer(root_dir, broken_links_file)
    repairer.repair_all()

if __name__ == "__main__":
    main()
