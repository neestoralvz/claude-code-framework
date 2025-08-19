#!/usr/bin/env python3
"""
Agent Metadata Extraction Processor
Systematically extracts metadata from all agent files and builds comprehensive JSON registry
"""

import json
import re
import yaml
from pathlib import Path
from typing import Dict, List, Any, Optional
from datetime import datetime
import os

class AgentMetadataExtractor:
    """Extract comprehensive metadata from agent markdown files"""
    
    def __init__(self, base_path: str):
        self.base_path = Path(base_path)
        self.agents_dir = self.base_path / "agents"
        self.metadata_registry = {
            "extraction_metadata": {
                "timestamp": datetime.now().isoformat(),
                "total_agents": 0,
                "categories": {},
                "extraction_method": "systematic_file_analysis",
                "progressive_thinking_level": "UltraThink"
            },
            "agents": {}
        }
    
    def extract_frontmatter(self, content: str) -> tuple[Dict[str, Any], str]:
        """Extract YAML frontmatter if present"""
        frontmatter = {}
        main_content = content
        
        if content.startswith('---'):
            parts = content.split('---', 2)
            if len(parts) >= 3:
                try:
                    frontmatter = yaml.safe_load(parts[1])
                    main_content = parts[2].strip()
                except yaml.YAMLError:
                    pass
        
        return frontmatter, main_content
    
    def extract_agent_name(self, content: str) -> str:
        """Extract agent name from title"""
        lines = content.split('\n')
        for line in lines:
            if line.startswith('# '):
                return line[2:].strip()
        return "Unknown Agent"
    
    def extract_analysis_only_designation(self, content: str) -> bool:
        """Check if agent is analysis-only specialist"""
        return "**🔍 ANALYSIS-ONLY SPECIALIST**" in content
    
    def extract_mission(self, content: str) -> str:
        """Extract agent mission/purpose description"""
        lines = content.split('\n')
        mission_started = False
        mission_lines = []
        
        for line in lines:
            line = line.strip()
            if mission_started:
                if line.startswith('#') or line.startswith('## '):
                    break
                if line:
                    mission_lines.append(line)
            elif line.startswith('You are ') or 'specialist' in line.lower() or 'expert' in line.lower():
                mission_started = True
                mission_lines.append(line)
        
        return ' '.join(mission_lines)[:500] if mission_lines else ""
    
    def extract_core_responsibilities(self, content: str) -> List[str]:
        """Extract core responsibilities/competencies"""
        responsibilities = []
        lines = content.split('\n')
        in_responsibilities = False
        
        for line in lines:
            line = line.strip()
            if 'Core Responsibilities' in line or 'Core Competencies' in line:
                in_responsibilities = True
                continue
            elif in_responsibilities:
                if line.startswith('##') and 'Core' not in line:
                    break
                if line.startswith(('1.', '2.', '3.', '4.', '5.', '-')):
                    clean_line = re.sub(r'^\d+\.\s*\*\*|\*\*:?|\-\s*\*\*', '', line)
                    clean_line = re.sub(r'\*\*.*?\*\*:', '', clean_line)
                    responsibilities.append(clean_line.strip()[:200])
        
        return responsibilities[:5]  # Limit to top 5
    
    def extract_technology_stack(self, content: str) -> List[str]:
        """Extract technology stack and tools"""
        technologies = []
        lines = content.split('\n')
        in_tech_section = False
        
        for line in lines:
            line = line.strip()
            if any(keyword in line.lower() for keyword in ['technology', 'stack', 'tools', 'frameworks']):
                in_tech_section = True
                continue
            elif in_tech_section:
                if line.startswith('##') and not any(keyword in line.lower() for keyword in ['technology', 'integration']):
                    break
                if line.startswith(('- **', '* **')):
                    tech = re.sub(r'^\-\s*\*\*|\*\*:.*', '', line).strip()
                    if tech:
                        technologies.append(tech[:100])
        
        return technologies[:10]  # Limit to top 10
    
    def extract_integration_points(self, content: str) -> List[str]:
        """Extract integration points with other agents"""
        integrations = []
        lines = content.split('\n')
        
        for line in lines:
            if 'integrates with' in line.lower() or 'works with' in line.lower() or 'coordinates with' in line.lower():
                # Extract agent names mentioned
                agent_matches = re.findall(r'(\w+[-\w]*-specialist|\w+[-\w]*-architect|\w+[-\w]*-coordinator|\w+[-\w]*-engineer)', line.lower())
                integrations.extend(agent_matches)
        
        return list(set(integrations))[:5]  # Unique integrations, limit to 5
    
    def extract_validation_protocols(self, content: str) -> Dict[str, List[str]]:
        """Extract validation protocols and checklists"""
        protocols = {
            "pre_execution": [],
            "execution": [],
            "post_execution": [],
            "completion_checklist": []
        }
        
        lines = content.split('\n')
        current_section = None
        
        for line in lines:
            line = line.strip()
            if 'Pre-Execution Validation' in line or 'Pre-Development Validation' in line:
                current_section = "pre_execution"
            elif 'Execution Validation' in line or 'Model Development Validation' in line:
                current_section = "execution"
            elif 'Post-Execution Validation' in line or 'Deployment Validation' in line:
                current_section = "post_execution"
            elif 'Completion Checklist' in line:
                current_section = "completion_checklist"
            elif current_section and line.startswith('- [ ]'):
                item = re.sub(r'^\-\s*\[\s*\]\s*', '', line)
                protocols[current_section].append(item[:150])
        
        return protocols
    
    def get_category_from_path(self, file_path: Path) -> Dict[str, str]:
        """Extract category information from file path"""
        parts = file_path.relative_to(self.agents_dir).parts
        return {
            "primary_category": parts[0] if len(parts) > 1 else "general",
            "secondary_category": parts[1] if len(parts) > 2 else None,
            "tertiary_category": parts[2] if len(parts) > 3 else None,
            "full_path": str(file_path.relative_to(self.base_path))
        }
    
    def process_agent_file(self, file_path: Path) -> Dict[str, Any]:
        """Process a single agent file and extract comprehensive metadata"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            frontmatter, main_content = self.extract_frontmatter(content)
            
            metadata = {
                "agent_id": file_path.stem,
                "file_path": str(file_path.relative_to(self.base_path)),
                "agent_name": self.extract_agent_name(main_content),
                "is_analysis_only": self.extract_analysis_only_designation(main_content),
                "mission": self.extract_mission(main_content),
                "core_responsibilities": self.extract_core_responsibilities(main_content),
                "technology_stack": self.extract_technology_stack(main_content),
                "integration_points": self.extract_integration_points(main_content),
                "validation_protocols": self.extract_validation_protocols(main_content),
                "categorization": self.get_category_from_path(file_path),
                "frontmatter": frontmatter,
                "file_size": len(content),
                "extraction_timestamp": datetime.now().isoformat()
            }
            
            return metadata
            
        except Exception as e:
            return {
                "agent_id": file_path.stem,
                "file_path": str(file_path.relative_to(self.base_path)),
                "error": f"Failed to process: {str(e)}",
                "extraction_timestamp": datetime.now().isoformat()
            }
    
    def process_all_agents(self) -> Dict[str, Any]:
        """Process all agent files and build comprehensive registry"""
        agent_files = list(self.agents_dir.rglob("*.md"))
        self.metadata_registry["extraction_metadata"]["total_agents"] = len(agent_files)
        
        print(f"Processing {len(agent_files)} agent files...")
        
        for i, file_path in enumerate(agent_files, 1):
            print(f"Processing {i}/{len(agent_files)}: {file_path.name}")
            
            agent_metadata = self.process_agent_file(file_path)
            self.metadata_registry["agents"][agent_metadata["agent_id"]] = agent_metadata
            
            # Update category statistics
            category = agent_metadata.get("categorization", {}).get("primary_category", "unknown")
            if category not in self.metadata_registry["extraction_metadata"]["categories"]:
                self.metadata_registry["extraction_metadata"]["categories"][category] = 0
            self.metadata_registry["extraction_metadata"]["categories"][category] += 1
        
        return self.metadata_registry
    
    def save_registry(self, output_path: str):
        """Save the complete metadata registry to JSON file"""
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(self.metadata_registry, f, indent=2, ensure_ascii=False)
        
        print(f"Metadata registry saved to: {output_path}")

if __name__ == "__main__":
    # Configuration
    base_path = "/Users/nalve/.claude"
    output_path = "/Users/nalve/.claude/operations/1755625694_agent_metadata_extraction/comprehensive-agent-metadata.json"
    
    # Execute extraction
    extractor = AgentMetadataExtractor(base_path)
    registry = extractor.process_all_agents()
    extractor.save_registry(output_path)
    
    # Print summary
    print(f"\n=== EXTRACTION COMPLETE ===")
    print(f"Total agents processed: {registry['extraction_metadata']['total_agents']}")
    print(f"Categories found: {list(registry['extraction_metadata']['categories'].keys())}")
    print(f"Registry saved to: {output_path}")