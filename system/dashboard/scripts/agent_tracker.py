#!/usr/bin/env python3
"""
Claude Framework Agent Usage Tracker

Tracks agent deployments, usage patterns, and performance metrics
for the dashboard analytics system.
"""

import json
import os
import re
import glob
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Any, Tuple
from collections import defaultdict, Counter

class AgentUsageTracker:
    def __init__(self, framework_root: str = "/Users/nalve/.claude"):
        self.framework_root = Path(framework_root)
        self.projects_root = self.framework_root / "projects"
        self.operations_root = self.framework_root / "operations"
        self.agents_root = self.framework_root / "agents"  # Future use
        
        # Agent patterns for detection in logs/operations
        self.agent_patterns = {
            "strategic-orchestrator": [
                r"strategic.orchestrator",
                r"strategic.coordination",
                r"parallel.coordination",
                r"strategic.planning"
            ],
            "system-guardian": [
                r"system.guardian",
                r"validation.specialist",
                r"framework.maintenance",
                r"quality.validation"
            ],
            "collaborative-partner": [
                r"collaborative.partner",
                r"exploration.together",
                r"iterative.development"
            ],
            "action-oriented-assistant": [
                r"action.oriented",
                r"task.execution",
                r"direct.implementation"
            ],
            "research-specialist": [
                r"research.specialist",
                r"deep.research",
                r"information.gathering",
                r"analysis.specialist"
            ],
            "deep-thinker": [
                r"deep.thinker",
                r"complex.analysis",
                r"systematic.reasoning",
                r"progressive.thinking"
            ],
            "knowledge-curator": [
                r"knowledge.curator",
                r"documentation.specialist",
                r"content.organization"
            ]
        }
        
        # Specialized agents from operations
        self.specialized_agents = {
            "dashboard-management-specialist": [
                r"dashboard.management",
                r"metrics.dashboard",
                r"system.monitoring"
            ],
            "api-design-specialist": [
                r"api.design",
                r"schema.driven",
                r"validation.patterns"
            ],
            "code-quality-specialist": [
                r"code.quality",
                r"tdd.bdd",
                r"quality.assessment"
            ],
            "performance-optimization-specialist": [
                r"performance.optimization",
                r"bottleneck.analysis",
                r"resource.optimization"
            ],
            "testing-strategy-specialist": [
                r"testing.strategy",
                r"test.coverage",
                r"quality.gates"
            ],
            "claude-hooks-developer": [
                r"claude.hooks",
                r"hook.development",
                r"pep.723"
            ],
            "agent-template-architect": [
                r"agent.template",
                r"template.architect",
                r"agent.creation"
            ]
        }
    
    def analyze_agent_usage(self) -> Dict[str, Any]:
        """Analyze comprehensive agent usage patterns."""
        return {
            "timestamp": datetime.now().isoformat(),
            "usage_summary": self.get_usage_summary(),
            "agent_patterns": self.analyze_agent_patterns(),
            "deployment_trends": self.analyze_deployment_trends(),
            "performance_metrics": self.analyze_agent_performance(),
            "recommendations": self.generate_usage_recommendations()
        }
    
    def get_usage_summary(self) -> Dict[str, Any]:
        """Get overall usage summary statistics."""
        # Analyze recent operations for agent deployments
        recent_ops = self.get_recent_operations(days=30)
        agent_mentions = self.count_agent_mentions(recent_ops)
        
        # Analyze session data if available
        session_data = self.analyze_session_data()
        
        total_deployments = sum(agent_mentions.values())
        unique_agents = len([a for a, count in agent_mentions.items() if count > 0])
        
        return {
            "total_deployments": total_deployments,
            "unique_agents_used": unique_agents,
            "most_used_agent": max(agent_mentions.items(), key=lambda x: x[1]) if agent_mentions else ("none", 0),
            "least_used_agent": min(agent_mentions.items(), key=lambda x: x[1]) if agent_mentions else ("none", 0),
            "average_deployments_per_session": self.calculate_avg_deployments_per_session(recent_ops),
            "agent_diversity_score": self.calculate_diversity_score(agent_mentions)
        }
    
    def get_recent_operations(self, days: int = 30) -> List[Tuple[Path, Dict[str, Any]]]:
        """Get recent operations with their metadata."""
        if not self.operations_root.exists():
            return []
        
        cutoff_date = datetime.now() - timedelta(days=days)
        recent_operations = []
        
        for op_dir in self.operations_root.iterdir():
            if op_dir.is_dir():
                try:
                    mtime = datetime.fromtimestamp(op_dir.stat().st_mtime)
                    if mtime > cutoff_date:
                        metadata = {
                            "name": op_dir.name,
                            "created": datetime.fromtimestamp(op_dir.stat().st_ctime),
                            "modified": mtime,
                            "files": list(op_dir.glob("*.md"))
                        }
                        recent_operations.append((op_dir, metadata))
                except Exception:
                    continue
        
        return sorted(recent_operations, key=lambda x: x[1]["modified"], reverse=True)
    
    def count_agent_mentions(self, operations: List[Tuple[Path, Dict[str, Any]]]) -> Dict[str, int]:
        """Count mentions of agents in operation files."""
        agent_counts = defaultdict(int)
        all_agents = {**self.agent_patterns, **self.specialized_agents}
        
        for op_dir, metadata in operations:
            # Read all markdown files in the operation
            for md_file in metadata["files"]:
                try:
                    content = md_file.read_text().lower()
                    
                    # Check for each agent pattern
                    for agent_name, patterns in all_agents.items():
                        for pattern in patterns:
                            if re.search(pattern, content, re.IGNORECASE):
                                agent_counts[agent_name] += 1
                                break  # Count once per file per agent
                
                except Exception:
                    continue
        
        # Ensure all agents are represented
        for agent_name in all_agents.keys():
            if agent_name not in agent_counts:
                agent_counts[agent_name] = 0
        
        return dict(agent_counts)
    
    def analyze_session_data(self) -> Dict[str, Any]:
        """Analyze session data from projects directory."""
        if not self.projects_root.exists():
            return {"sessions_analyzed": 0, "agent_references": {}}
        
        # Sample a few recent session files
        session_files = list(self.projects_root.glob("**/*.jsonl"))
        recent_sessions = sorted(session_files, key=lambda x: x.stat().st_mtime, reverse=True)[:10]
        
        agent_references = defaultdict(int)
        
        for session_file in recent_sessions:
            try:
                content = session_file.read_text()
                
                # Look for agent-related keywords in session logs
                for agent_name in {**self.agent_patterns, **self.specialized_agents}.keys():
                    # Convert agent name to searchable patterns
                    search_terms = [
                        agent_name.replace("-", "[ -]"),
                        agent_name.replace("-", "."),
                        agent_name.replace("-", " ")
                    ]
                    
                    for term in search_terms:
                        if re.search(term, content, re.IGNORECASE):
                            agent_references[agent_name] += 1
                            break
            
            except Exception:
                continue
        
        return {
            "sessions_analyzed": len(recent_sessions),
            "agent_references": dict(agent_references)
        }
    
    def analyze_agent_patterns(self) -> Dict[str, Any]:
        """Analyze patterns in agent usage."""
        recent_ops = self.get_recent_operations(days=60)
        
        # Group operations by time periods
        daily_usage = defaultdict(lambda: defaultdict(int))
        weekly_usage = defaultdict(lambda: defaultdict(int))
        
        for op_dir, metadata in recent_ops:
            date_key = metadata["modified"].strftime("%Y-%m-%d")
            week_key = metadata["modified"].strftime("%Y-W%W")
            
            # Count agent mentions for this operation
            agent_mentions = self.count_agent_mentions([(op_dir, metadata)])
            
            for agent, count in agent_mentions.items():
                if count > 0:
                    daily_usage[date_key][agent] += count
                    weekly_usage[week_key][agent] += count
        
        return {
            "daily_patterns": self.summarize_usage_patterns(daily_usage),
            "weekly_patterns": self.summarize_usage_patterns(weekly_usage),
            "usage_consistency": self.calculate_usage_consistency(daily_usage),
            "peak_usage_periods": self.find_peak_usage_periods(daily_usage)
        }
    
    def summarize_usage_patterns(self, usage_data: Dict[str, Dict[str, int]]) -> Dict[str, Any]:
        """Summarize usage patterns from time-series data."""
        if not usage_data:
            return {"total_periods": 0, "average_agents_per_period": 0, "most_active_period": None}
        
        total_periods = len(usage_data)
        agents_per_period = [len([a for a, c in period_data.items() if c > 0]) 
                           for period_data in usage_data.values()]
        avg_agents = sum(agents_per_period) / len(agents_per_period) if agents_per_period else 0
        
        # Find most active period
        most_active = max(usage_data.items(), 
                         key=lambda x: sum(x[1].values())) if usage_data else (None, {})
        
        return {
            "total_periods": total_periods,
            "average_agents_per_period": round(avg_agents, 1),
            "most_active_period": most_active[0],
            "peak_deployments": sum(most_active[1].values()) if most_active[1] else 0
        }
    
    def calculate_usage_consistency(self, daily_usage: Dict[str, Dict[str, int]]) -> float:
        """Calculate how consistently agents are used across days."""
        if len(daily_usage) < 2:
            return 0.0
        
        # Calculate standard deviation of daily total deployments
        daily_totals = [sum(day_data.values()) for day_data in daily_usage.values()]
        
        if not daily_totals:
            return 0.0
        
        mean_daily = sum(daily_totals) / len(daily_totals)
        variance = sum((x - mean_daily) ** 2 for x in daily_totals) / len(daily_totals)
        std_dev = variance ** 0.5
        
        # Convert to consistency score (lower std_dev = higher consistency)
        consistency = max(0, 100 - (std_dev / mean_daily * 100)) if mean_daily > 0 else 0
        return round(consistency, 1)
    
    def find_peak_usage_periods(self, daily_usage: Dict[str, Dict[str, int]]) -> List[Dict[str, Any]]:
        """Find periods of peak agent usage."""
        if not daily_usage:
            return []
        
        # Calculate total deployments per day
        daily_totals = {date: sum(agents.values()) for date, agents in daily_usage.items()}
        
        # Find top 3 peak days
        peak_days = sorted(daily_totals.items(), key=lambda x: x[1], reverse=True)[:3]
        
        peak_periods = []
        for date, total in peak_days:
            if total > 0:
                top_agents = sorted(daily_usage[date].items(), 
                                  key=lambda x: x[1], reverse=True)[:3]
                
                peak_periods.append({
                    "date": date,
                    "total_deployments": total,
                    "top_agents": [{"agent": agent, "deployments": count} 
                                 for agent, count in top_agents if count > 0]
                })
        
        return peak_periods
    
    def analyze_deployment_trends(self) -> Dict[str, Any]:
        """Analyze trends in agent deployment over time."""
        recent_ops = self.get_recent_operations(days=90)
        
        # Group by weeks
        weekly_data = defaultdict(lambda: {"total": 0, "agents": defaultdict(int)})
        
        for op_dir, metadata in recent_ops:
            week_key = metadata["modified"].strftime("%Y-W%W")
            agent_mentions = self.count_agent_mentions([(op_dir, metadata)])
            
            weekly_data[week_key]["total"] += sum(agent_mentions.values())
            for agent, count in agent_mentions.items():
                weekly_data[week_key]["agents"][agent] += count
        
        # Calculate trends
        weeks = sorted(weekly_data.keys())
        if len(weeks) < 2:
            return {"trend": "insufficient_data", "growth_rate": 0, "trending_agents": []}
        
        # Calculate growth rate (last 4 weeks vs previous 4 weeks)
        recent_weeks = weeks[-4:] if len(weeks) >= 4 else weeks
        earlier_weeks = weeks[-8:-4] if len(weeks) >= 8 else weeks[:-4] if len(weeks) > 4 else []
        
        recent_total = sum(weekly_data[week]["total"] for week in recent_weeks)
        earlier_total = sum(weekly_data[week]["total"] for week in earlier_weeks) if earlier_weeks else 0
        
        growth_rate = ((recent_total - earlier_total) / earlier_total * 100) if earlier_total > 0 else 0
        
        # Find trending agents
        trending_agents = self.find_trending_agents(weekly_data, weeks)
        
        return {
            "trend": "growing" if growth_rate > 10 else "declining" if growth_rate < -10 else "stable",
            "growth_rate": round(growth_rate, 1),
            "trending_agents": trending_agents,
            "weekly_summary": {
                "recent_4_weeks": recent_total,
                "previous_4_weeks": earlier_total
            }
        }
    
    def find_trending_agents(self, weekly_data: Dict, weeks: List[str]) -> List[Dict[str, Any]]:
        """Find agents with increasing usage trends."""
        if len(weeks) < 4:
            return []
        
        recent_weeks = weeks[-4:]
        earlier_weeks = weeks[-8:-4] if len(weeks) >= 8 else weeks[:-4]
        
        agent_trends = []
        
        for agent_name in {**self.agent_patterns, **self.specialized_agents}.keys():
            recent_usage = sum(weekly_data[week]["agents"][agent_name] for week in recent_weeks)
            earlier_usage = sum(weekly_data[week]["agents"][agent_name] for week in earlier_weeks) if earlier_weeks else 0
            
            if recent_usage > 0:  # Only include agents with recent activity
                trend_score = recent_usage - earlier_usage
                growth_rate = ((recent_usage - earlier_usage) / earlier_usage * 100) if earlier_usage > 0 else 100
                
                agent_trends.append({
                    "agent": agent_name,
                    "recent_usage": recent_usage,
                    "trend_score": trend_score,
                    "growth_rate": round(growth_rate, 1)
                })
        
        # Return top 5 trending agents
        return sorted(agent_trends, key=lambda x: x["trend_score"], reverse=True)[:5]
    
    def analyze_agent_performance(self) -> Dict[str, Any]:
        """Analyze agent performance and effectiveness."""
        recent_ops = self.get_recent_operations(days=30)
        
        performance_data = {}
        
        for agent_name in {**self.agent_patterns, **self.specialized_agents}.keys():
            # Find operations where this agent was used
            agent_operations = []
            
            for op_dir, metadata in recent_ops:
                agent_mentions = self.count_agent_mentions([(op_dir, metadata)])
                if agent_mentions.get(agent_name, 0) > 0:
                    agent_operations.append((op_dir, metadata))
            
            if agent_operations:
                performance_data[agent_name] = self.calculate_agent_performance(agent_operations)
        
        return performance_data
    
    def calculate_agent_performance(self, operations: List[Tuple[Path, Dict[str, Any]]]) -> Dict[str, Any]:
        """Calculate performance metrics for a specific agent."""
        if not operations:
            return {"usage_count": 0, "avg_files_generated": 0, "success_indicators": []}
        
        total_files = 0
        total_size = 0
        success_indicators = []
        
        for op_dir, metadata in operations:
            files_count = len(metadata["files"])
            total_files += files_count
            
            # Calculate operation size as indicator of complexity/output
            try:
                op_size = sum(f.stat().st_size for f in metadata["files"])
                total_size += op_size
            except Exception:
                pass
            
            # Look for success indicators in file names
            for file_path in metadata["files"]:
                if any(indicator in file_path.name.lower() 
                      for indicator in ["summary", "completion", "success", "final"]):
                    success_indicators.append(file_path.name)
        
        return {
            "usage_count": len(operations),
            "avg_files_generated": round(total_files / len(operations), 1),
            "avg_output_size_kb": round(total_size / len(operations) / 1024, 1),
            "success_indicators_count": len(success_indicators),
            "productivity_score": self.calculate_productivity_score(len(operations), total_files, total_size)
        }
    
    def calculate_productivity_score(self, usage_count: int, total_files: int, total_size: int) -> float:
        """Calculate a productivity score for an agent."""
        if usage_count == 0:
            return 0.0
        
        # Base score on files per usage and size per usage
        files_per_usage = total_files / usage_count
        size_per_usage_kb = (total_size / usage_count) / 1024
        
        # Normalize and combine metrics
        file_score = min(files_per_usage * 10, 50)  # Cap at 50
        size_score = min(size_per_usage_kb / 10, 50)  # Cap at 50
        
        return round(file_score + size_score, 1)
    
    def calculate_avg_deployments_per_session(self, operations: List[Tuple[Path, Dict[str, Any]]]) -> float:
        """Calculate average agent deployments per session."""
        if not operations:
            return 0.0
        
        total_deployments = 0
        for op_dir, metadata in operations:
            agent_mentions = self.count_agent_mentions([(op_dir, metadata)])
            total_deployments += sum(agent_mentions.values())
        
        return round(total_deployments / len(operations), 1)
    
    def calculate_diversity_score(self, agent_mentions: Dict[str, int]) -> float:
        """Calculate how diverse agent usage is (Shannon entropy)."""
        total_mentions = sum(agent_mentions.values())
        
        if total_mentions == 0:
            return 0.0
        
        # Calculate Shannon entropy
        entropy = 0.0
        for count in agent_mentions.values():
            if count > 0:
                probability = count / total_mentions
                entropy -= probability * (probability.bit_length() - 1 if probability > 0 else 0)
        
        # Normalize to 0-100 scale
        max_entropy = (len(agent_mentions).bit_length() - 1) if len(agent_mentions) > 1 else 1
        diversity_score = (entropy / max_entropy * 100) if max_entropy > 0 else 0
        
        return round(diversity_score, 1)
    
    def generate_usage_recommendations(self) -> List[Dict[str, str]]:
        """Generate recommendations for improving agent usage."""
        recent_ops = self.get_recent_operations(days=30)
        agent_mentions = self.count_agent_mentions(recent_ops)
        
        recommendations = []
        
        # Check for underused agents
        total_usage = sum(agent_mentions.values())
        if total_usage > 0:
            underused_agents = [agent for agent, count in agent_mentions.items() 
                              if count / total_usage < 0.02 and count > 0]  # Less than 2% usage
            
            if underused_agents:
                recommendations.append({
                    "type": "underutilization",
                    "priority": "medium",
                    "title": "Explore Underused Agents",
                    "description": f"Consider using {', '.join(underused_agents[:3])} more frequently for specialized tasks"
                })
        
        # Check for overuse of single agent
        if agent_mentions:
            most_used = max(agent_mentions.items(), key=lambda x: x[1])
            if total_usage > 0 and most_used[1] / total_usage > 0.4:  # More than 40% usage
                recommendations.append({
                    "type": "overuse",
                    "priority": "low",
                    "title": "Diversify Agent Usage",
                    "description": f"{most_used[0]} is heavily used ({most_used[1]} times). Consider diversifying with other specialized agents"
                })
        
        # Check for missing specialized agents
        specialized_used = sum(1 for agent in self.specialized_agents.keys() 
                             if agent_mentions.get(agent, 0) > 0)
        
        if specialized_used < len(self.specialized_agents) * 0.3:  # Less than 30% of specialized agents used
            recommendations.append({
                "type": "specialization",
                "priority": "medium", 
                "title": "Increase Specialized Agent Usage",
                "description": "Consider using more specialized agents for specific tasks to improve efficiency"
            })
        
        # Productivity recommendations
        if total_usage < 10:  # Low overall usage
            recommendations.append({
                "type": "adoption",
                "priority": "high",
                "title": "Increase Agent Adoption",
                "description": "Consider using agents more frequently for complex tasks to improve productivity"
            })
        
        if not recommendations:
            recommendations.append({
                "type": "maintenance",
                "priority": "low", 
                "title": "Maintain Current Usage Patterns",
                "description": "Agent usage patterns appear balanced and effective"
            })
        
        return recommendations
    
    def export_usage_data(self, output_file: str = None) -> str:
        """Export agent usage data to JSON file."""
        usage_data = self.analyze_agent_usage()
        
        if output_file is None:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            output_file = f"agent_usage_{timestamp}.json"
        
        output_path = self.framework_root / "system" / "dashboard" / "data" / output_file
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(output_path, 'w') as f:
            json.dump(usage_data, f, indent=2, default=str)
        
        return str(output_path)

def main():
    """Main function to analyze and report agent usage."""
    tracker = AgentUsageTracker()
    
    print("🤖 Analyzing Claude Framework agent usage...")
    usage_data = tracker.analyze_agent_usage()
    
    # Print summary
    summary = usage_data["usage_summary"]
    print(f"\n📊 Agent Usage Summary:")
    print(f"  Total Deployments: {summary['total_deployments']}")
    print(f"  Unique Agents Used: {summary['unique_agents_used']}")
    print(f"  Most Used Agent: {summary['most_used_agent'][0]} ({summary['most_used_agent'][1]} times)")
    print(f"  Agent Diversity Score: {summary['agent_diversity_score']}%")
    
    # Print top recommendations
    print(f"\n🎯 Top Recommendations:")
    for rec in usage_data["recommendations"][:3]:
        priority_icon = "🔴" if rec['priority'] == 'high' else "🟡" if rec['priority'] == 'medium' else "🟢"
        print(f"  {priority_icon} {rec['title']}: {rec['description']}")
    
    # Export data
    output_file = tracker.export_usage_data()
    print(f"\n💾 Usage data exported to: {output_file}")

if __name__ == "__main__":
    main()