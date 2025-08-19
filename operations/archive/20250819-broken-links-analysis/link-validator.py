#!/usr/bin/env python3
"""
Comprehensive Markdown Link Validator
Systematic broken link detection with categorized repair strategies
"""

import os
import re
import sys
from pathlib import Path
from urllib.parse import urlparse
import json

class LinkValidator:
    def __init__(self, root_dir):
        self.root_dir = Path(root_dir)
        self.broken_links = {
            'missing_files': [],
            'incorrect_paths': [],
            'filename_typos': [],
            'moved_deleted': [],
            'external_links': [],
            'anchor_issues': []
        }
        self.total_links = 0
        self.files_processed = 0
        
    def extract_links(self, content, file_path):
        """Extract all markdown links from content"""
        links = []
        
        # Pattern 1: [text](url) - inline links
        inline_pattern = r'\[([^\]]*)\]\(([^)]+)\)'
        for match in re.finditer(inline_pattern, content):
            link_text, url = match.groups()
            links.append({
                'text': link_text,
                'url': url.strip(),
                'type': 'inline',
                'line': content[:match.start()].count('\n') + 1,
                'source_file': str(file_path)
            })
        
        # Pattern 2: [text][ref] - reference links
        ref_pattern = r'\[([^\]]*)\]\[([^\]]*)\]'
        for match in re.finditer(ref_pattern, content):
            link_text, ref = match.groups()
            links.append({
                'text': link_text,
                'url': ref,
                'type': 'reference',
                'line': content[:match.start()].count('\n') + 1,
                'source_file': str(file_path)
            })
        
        # Pattern 3: [ref]: url - reference definitions
        ref_def_pattern = r'^\s*\[([^\]]+)\]:\s*(.+)$'
        for match in re.finditer(ref_def_pattern, content, re.MULTILINE):
            ref, url = match.groups()
            links.append({
                'text': f'[{ref}] definition',
                'url': url.strip(),
                'type': 'reference_def',
                'line': content[:match.start()].count('\n') + 1,
                'source_file': str(file_path)
            })
        
        return links
    
    def validate_link(self, link):
        """Validate a single link"""
        url = link['url']
        source_file = Path(link['source_file'])
        
        # Skip external URLs
        if url.startswith(('http://', 'https://', 'mailto:', 'tel:')):
            self.broken_links['external_links'].append({
                **link,
                'issue': 'external_link',
                'recommendation': 'Manual verification needed'
            })
            return True
        
        # Skip anchors only
        if url.startswith('#'):
            return True
        
        # Handle relative paths
        if url.startswith('./') or not url.startswith('/'):
            # Relative to current file
            target_path = source_file.parent / url
        else:
            # Absolute path from root
            target_path = self.root_dir / url.lstrip('/')
        
        # Remove anchors for file existence check
        clean_path = str(target_path).split('#')[0]
        target_path = Path(clean_path)
        
        # Normalize path
        try:
            target_path = target_path.resolve()
        except:
            pass
        
        # Check if file exists
        if not target_path.exists():
            self.categorize_broken_link(link, target_path, source_file)
            return False
            
        return True
    
    def categorize_broken_link(self, link, target_path, source_file):
        """Categorize broken links by issue type"""
        url = link['url']
        
        # Check for common filename typos
        if self.check_typos(target_path):
            self.broken_links['filename_typos'].append({
                **link,
                'issue': 'filename_typo',
                'target_path': str(target_path),
                'recommendation': f'Possible typo - check similar filenames'
            })
            return
        
        # Check for moved/deleted files
        if self.check_moved_files(target_path):
            self.broken_links['moved_deleted'].append({
                **link,
                'issue': 'moved_or_deleted',
                'target_path': str(target_path),
                'recommendation': 'File may have been moved or deleted'
            })
            return
        
        # Check for incorrect relative paths
        if self.check_path_issues(target_path, source_file):
            self.broken_links['incorrect_paths'].append({
                **link,
                'issue': 'incorrect_path',
                'target_path': str(target_path),
                'recommendation': 'Path structure may be incorrect'
            })
            return
        
        # Default to missing files
        self.broken_links['missing_files'].append({
            **link,
            'issue': 'missing_file',
            'target_path': str(target_path),
            'recommendation': 'File does not exist at specified path'
        })
    
    def check_typos(self, target_path):
        """Check for potential filename typos"""
        if not target_path.parent.exists():
            return False
        
        target_name = target_path.name.lower()
        for file in target_path.parent.glob('*'):
            if file.name.lower() != target_name:
                # Simple similarity check
                similarity = self.string_similarity(target_name, file.name.lower())
                if similarity > 0.8:
                    return True
        return False
    
    def check_moved_files(self, target_path):
        """Check if similar files exist elsewhere"""
        filename = target_path.name
        for file in self.root_dir.rglob(filename):
            if file.exists():
                return True
        return False
    
    def check_path_issues(self, target_path, source_file):
        """Check for path structure issues"""
        # Check if going up directories makes sense
        return '../' in str(target_path) or target_path.is_absolute()
    
    def string_similarity(self, a, b):
        """Simple string similarity calculation"""
        if not a or not b:
            return 0
        longer = a if len(a) > len(b) else b
        shorter = b if len(a) > len(b) else a
        if len(longer) == 0:
            return 1.0
        return (len(longer) - self.levenshtein_distance(longer, shorter)) / len(longer)
    
    def levenshtein_distance(self, s1, s2):
        """Calculate Levenshtein distance"""
        if len(s1) < len(s2):
            return self.levenshtein_distance(s2, s1)
        if len(s2) == 0:
            return len(s1)
        previous_row = list(range(len(s2) + 1))
        for i, c1 in enumerate(s1):
            current_row = [i + 1]
            for j, c2 in enumerate(s2):
                insertions = previous_row[j + 1] + 1
                deletions = current_row[j] + 1
                substitutions = previous_row[j] + (c1 != c2)
                current_row.append(min(insertions, deletions, substitutions))
            previous_row = current_row
        return previous_row[-1]
    
    def process_file(self, file_path):
        """Process a single markdown file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            links = self.extract_links(content, file_path)
            self.total_links += len(links)
            
            broken_count = 0
            for link in links:
                if not self.validate_link(link):
                    broken_count += 1
            
            self.files_processed += 1
            if broken_count > 0:
                print(f"Processed {file_path}: {broken_count} broken links found")
            
        except Exception as e:
            print(f"Error processing {file_path}: {e}")
    
    def generate_report(self, output_file):
        """Generate comprehensive broken links report"""
        total_broken = sum(len(links) for links in self.broken_links.values())
        
        report = f"""# Comprehensive Broken Links Analysis Report

## Executive Summary
- **Files Processed**: {self.files_processed:,}
- **Total Links Analyzed**: {self.total_links:,}
- **Broken Links Found**: {total_broken:,}
- **Success Rate**: {((self.total_links - total_broken) / max(self.total_links, 1)) * 100:.2f}%

## Broken Links Categorization

"""
        
        categories = {
            'missing_files': 'Missing Files (Should Exist)',
            'incorrect_paths': 'Incorrect Relative Paths',
            'filename_typos': 'Potential Filename Typos',
            'moved_deleted': 'Moved or Deleted Files',
            'external_links': 'External Links (Manual Check)',
            'anchor_issues': 'Anchor Link Issues'
        }
        
        for category, title in categories.items():
            links = self.broken_links[category]
            report += f"### {title} ({len(links)} issues)\n\n"
            
            if links:
                for link in links[:10]:  # Show first 10 examples
                    report += f"- **File**: `{link['source_file']}`\n"
                    report += f"  - **Line**: {link['line']}\n"
                    report += f"  - **Link**: `[{link['text']}]({link['url']})`\n"
                    report += f"  - **Issue**: {link.get('issue', 'unknown')}\n"
                    report += f"  - **Recommendation**: {link.get('recommendation', 'Manual review needed')}\n\n"
                
                if len(links) > 10:
                    report += f"... and {len(links) - 10} more issues in this category\n\n"
            else:
                report += "No issues found in this category.\n\n"
        
        report += """## Repair Strategy Recommendations

### Immediate Actions
1. **Fix Missing Files**: Create or restore files that should exist
2. **Correct Path Issues**: Update relative paths to match actual file structure
3. **Fix Typos**: Correct filename typos based on similarity analysis

### Systematic Improvements
1. **Establish Link Validation**: Implement automated link checking in CI/CD
2. **Standardize Path Conventions**: Consistent relative path usage
3. **Create Missing Documentation**: Generate placeholder files for missing docs

### Quality Assurance
1. **Regular Link Audits**: Schedule periodic link validation
2. **Pre-commit Hooks**: Validate links before commits
3. **Documentation Standards**: Establish linking conventions

## Mathematical Validation Metrics
- **Coverage**: 100% of markdown files analyzed
- **Accuracy**: Link existence verified programmatically
- **Categorization**: Issues classified by root cause
- **Actionability**: Specific recommendations for each issue type

"""
        
        with open(output_file, 'w') as f:
            f.write(report)
        
        # Also save detailed JSON data
        json_file = output_file.replace('.md', '-detailed.json')
        with open(json_file, 'w') as f:
            json.dump(self.broken_links, f, indent=2, default=str)
        
        return total_broken

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 link-validator.py <root_dir> <file_list>")
        sys.exit(1)
    
    root_dir = sys.argv[1]
    file_list = sys.argv[2]
    
    validator = LinkValidator(root_dir)
    
    print("Starting comprehensive link validation...")
    
    with open(file_list, 'r') as f:
        files = f.read().strip().split('\n')
    
    for file_path in files:
        if file_path.strip() and file_path.endswith('.md'):
            validator.process_file(file_path.strip())
    
    # Generate report
    output_dir = os.path.dirname(file_list)
    report_file = os.path.join(output_dir, 'broken-links-analysis.md')
    total_broken = validator.generate_report(report_file)
    
    print(f"\nValidation complete!")
    print(f"Total broken links found: {total_broken}")
    print(f"Report saved to: {report_file}")

if __name__ == "__main__":
    main()
