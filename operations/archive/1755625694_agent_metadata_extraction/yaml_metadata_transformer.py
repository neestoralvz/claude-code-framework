#!/usr/bin/env python3
"""
YAML Metadata Transformer
Converts comprehensive JSON agent metadata to YAML template format
"""

import json
import yaml
from pathlib import Path
from typing import Dict, List, Any, Optional
from datetime import datetime

class YAMLMetadataTransformer:
    """Transform JSON metadata to YAML template format"""
    
    def __init__(self):
        self.category_colors = {
            "research": "purple",
            "specialization": "indigo", 
            "database": "blue",
            "design": "pink",
            "core-system": "red",
            "frontend": "green",
            "development": "blue",
            "project-management": "orange",
            "planning": "yellow",
            "content": "teal",
            "backend": "cyan",
            "operations": "gray",
            "iot": "purple",
            "testing": "lime",
            "blockchain": "amber",
            "ai-ml": "indigo",
            "user-experience": "pink",
            "business-analytics": "orange",
            "infrastructure": "slate",
            "analytics": "emerald",
            "strategy": "violet",
            "security-advanced": "red"
        }
        
        self.default_tools = ["Read", "Write", "Edit", "Bash", "Grep", "Glob"]
        self.analysis_tools = ["Read", "Grep", "Glob", "WebSearch", "WebFetch"]
        
    def extract_description(self, agent_data: Dict[str, Any]) -> str:
        """Extract concise description from agent metadata"""
        mission = agent_data.get("mission", "")
        responsibilities = agent_data.get("core_responsibilities", [])
        
        # Try to extract a concise description from mission
        if mission:
            # Clean up mission text - remove analysis-only text and markdown
            mission_clean = mission.replace("🔍 ANALYSIS-ONLY SPECIALIST: This agent performs analysis and delivers recommendations to the orchestrator. It does not execute deployments, manage systems, or perform direct implementations.", "")
            mission_clean = mission_clean.replace("You are ", "").replace("**", "").replace("*", "")
            mission_clean = mission_clean.replace("Your Mission: You analyze You ", "")
            mission_clean = mission_clean.replace(".", ". ").strip()
            
            # Find the core purpose description
            sentences = [s.strip() for s in mission_clean.split('.') if s.strip()]
            if sentences:
                # Take the first meaningful sentence that describes what the agent does
                for sentence in sentences:
                    if len(sentence) > 20 and any(keyword in sentence.lower() for keyword in [
                        'specialist', 'expert', 'agent', 'performs', 'analyzes', 'manages', 'coordinates', 'monitors'
                    ]):
                        if len(sentence) > 120:
                            sentence = sentence[:117] + "..."
                        return sentence.strip()
                
                # Fallback to first substantial sentence
                if sentences[0] and len(sentences[0]) > 15:
                    sentence = sentences[0]
                    if len(sentence) > 120:
                        sentence = sentence[:117] + "..."
                    return sentence.strip()
        
        # Fallback to first responsibility
        if responsibilities:
            desc = responsibilities[0][:120].strip()
            if not desc.endswith('...') and len(desc) == 120:
                desc += "..."
            return desc
            
        return "Specialized agent for domain-specific tasks"
    
    def extract_tools(self, agent_data: Dict[str, Any]) -> List[str]:
        """Extract or infer tools from agent metadata"""
        tools = []
        
        # Check if analysis-only
        if agent_data.get("is_analysis_only", False):
            tools = self.analysis_tools.copy()
        else:
            tools = self.default_tools.copy()
        
        # Add specialized tools based on technology stack
        tech_stack = agent_data.get("technology_stack", [])
        for tech in tech_stack:
            tech_lower = tech.lower()
            if "web" in tech_lower or "api" in tech_lower:
                if "WebSearch" not in tools:
                    tools.append("WebSearch")
                if "WebFetch" not in tools:
                    tools.append("WebFetch")
            if "git" in tech_lower:
                if "Bash" not in tools:
                    tools.append("Bash")
        
        # Add validation tools for core-system agents
        category = agent_data.get("categorization", {}).get("primary_category", "")
        if category == "core-system":
            specialized_tools = ["TodoWrite", "mcp__ide__getDiagnostics"]
            for tool in specialized_tools:
                if tool not in tools:
                    tools.append(tool)
        
        return tools
    
    def get_category_color(self, agent_data: Dict[str, Any]) -> str:
        """Get color based on category"""
        category = agent_data.get("categorization", {}).get("primary_category", "")
        return self.category_colors.get(category, "blue")
    
    def transform_agent_to_yaml(self, agent_id: str, agent_data: Dict[str, Any]) -> Dict[str, Any]:
        """Transform single agent to YAML template format"""
        
        # Extract name (clean agent_id)
        name = agent_id.replace("-", " ").replace("_", " ").title()
        
        return {
            "name": name,
            "description": self.extract_description(agent_data),
            "tools": self.extract_tools(agent_data),
            "model": "sonnet",  # Default as specified in template
            "color": self.get_category_color(agent_data)
        }
    
    def transform_json_to_yaml_registry(self, json_file_path: str) -> Dict[str, Any]:
        """Transform complete JSON registry to YAML template format"""
        
        # Load JSON metadata
        with open(json_file_path, 'r', encoding='utf-8') as f:
            json_data = json.load(f)
        
        # Initialize YAML registry
        yaml_registry = {
            "metadata": {
                "title": "Complete Agent Metadata Registry",
                "description": "Comprehensive YAML metadata for all framework agents",
                "version": "1.0.0",
                "generated": datetime.now().isoformat(),
                "source": "Transformed from comprehensive JSON metadata",
                "total_agents": json_data["extraction_metadata"]["total_agents"],
                "categories": len(json_data["extraction_metadata"]["categories"]),
                "template_version": "YAML Template v1.0"
            },
            "category_distribution": json_data["extraction_metadata"]["categories"],
            "agents": {}
        }
        
        # Transform each agent
        for agent_id, agent_data in json_data["agents"].items():
            if "error" not in agent_data:  # Skip errored agents
                yaml_agent = self.transform_agent_to_yaml(agent_id, agent_data)
                
                # Add additional metadata for comprehensive registry
                yaml_agent.update({
                    "id": agent_id,
                    "category": agent_data.get("categorization", {}).get("primary_category", "unknown"),
                    "subcategory": agent_data.get("categorization", {}).get("secondary_category"),
                    "file_path": agent_data.get("file_path", ""),
                    "is_analysis_only": agent_data.get("is_analysis_only", False)
                })
                
                yaml_registry["agents"][agent_id] = yaml_agent
        
        return yaml_registry
    
    def save_yaml_registry(self, registry: Dict[str, Any], output_path: str):
        """Save YAML registry to file"""
        with open(output_path, 'w', encoding='utf-8') as f:
            yaml.dump(registry, f, default_flow_style=False, indent=2, width=120, allow_unicode=True)
        
        print(f"YAML registry saved to: {output_path}")
    
    def generate_template_format_agents(self, registry: Dict[str, Any]) -> str:
        """Generate agents in exact YAML template format"""
        template_output = []
        template_output.append("---")
        template_output.append("# COMPREHENSIVE AGENT METADATA REGISTRY")
        template_output.append("# Generated from systematic agent analysis")
        template_output.append(f"# Total Agents: {registry['metadata']['total_agents']}")
        template_output.append(f"# Generated: {registry['metadata']['generated']}")
        template_output.append("")
        
        # Group agents by category for better organization
        agents_by_category = {}
        for agent_id, agent_data in registry["agents"].items():
            category = agent_data.get("category", "unknown")
            if category not in agents_by_category:
                agents_by_category[category] = []
            agents_by_category[category].append((agent_id, agent_data))
        
        # Generate template format for each category
        for category, agents in sorted(agents_by_category.items()):
            template_output.append(f"# === {category.upper().replace('-', ' ')} AGENTS ===")
            template_output.append("")
            
            for agent_id, agent_data in sorted(agents):
                template_output.append(f"{agent_id}:")
                template_output.append(f'  name: "{agent_data["name"]}"')
                template_output.append(f'  description: "{agent_data["description"]}"')
                
                # Format tools array
                tools_str = ", ".join(f'"{tool}"' for tool in agent_data["tools"])
                template_output.append(f'  tools: [{tools_str}]')
                
                template_output.append(f'  model: "{agent_data["model"]}"')
                template_output.append(f'  color: "{agent_data["color"]}"')
                template_output.append("")
        
        return "\n".join(template_output)

def main():
    """Main execution function"""
    print("=== YAML METADATA TRANSFORMATION ===")
    print("Progressive Thinking: UltraThink Level Applied")
    print()
    
    # Configuration
    json_file_path = "/Users/nalve/.claude/operations/1755625694_agent_metadata_extraction/comprehensive-agent-metadata.json"
    yaml_output_path = "/Users/nalve/.claude/operations/1755625694_agent_metadata_extraction/complete-agent-metadata-registry.yaml"
    template_output_path = "/Users/nalve/.claude/operations/1755625694_agent_metadata_extraction/agent-metadata-template-format.yaml"
    
    # Initialize transformer
    transformer = YAMLMetadataTransformer()
    
    # Transform JSON to YAML registry
    print("🔄 Transforming JSON metadata to YAML template format...")
    yaml_registry = transformer.transform_json_to_yaml_registry(json_file_path)
    
    # Save comprehensive YAML registry
    print("💾 Saving comprehensive YAML registry...")
    transformer.save_yaml_registry(yaml_registry, yaml_output_path)
    
    # Generate exact template format
    print("📋 Generating exact YAML template format...")
    template_format = transformer.generate_template_format_agents(yaml_registry)
    
    with open(template_output_path, 'w', encoding='utf-8') as f:
        f.write(template_format)
    
    print(f"📋 Template format saved to: {template_output_path}")
    
    # Summary
    print("\n=== TRANSFORMATION COMPLETE ===")
    print(f"✅ Total agents processed: {yaml_registry['metadata']['total_agents']}")
    print(f"✅ Categories covered: {yaml_registry['metadata']['categories']}")
    print(f"✅ YAML registry: {yaml_output_path}")
    print(f"✅ Template format: {template_output_path}")
    print()
    print("📊 Category Distribution:")
    for category, count in sorted(yaml_registry['category_distribution'].items()):
        print(f"   {category}: {count} agents")

if __name__ == "__main__":
    main()