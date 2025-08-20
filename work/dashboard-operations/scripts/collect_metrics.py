#!/usr/bin/env python3
"""
Claude Framework Metrics Collection Script

Collects metrics from various framework components and generates data
for the dashboard display.
"""

import json
import os
import subprocess
import glob
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Any
import re

class FrameworkMetricsCollector:
    def __init__(self, framework_root: str = "/Users/nalve/.claude"):
        self.framework_root = Path(framework_root)
        self.system_root = self.framework_root / "system"
        self.hooks_root = self.framework_root / "hooks"
        self.operations_root = self.framework_root / "operations"
        self.projects_root = self.framework_root / "projects"
        
    def collect_all_metrics(self) -> Dict[str, Any]:
        """Collect comprehensive metrics from all framework components."""
        metrics = {
            "timestamp": datetime.now().isoformat(),
            "health": self.collect_health_metrics(),
            "components": self.collect_component_metrics(),
            "usage": self.collect_usage_metrics(),
            "operations": self.collect_operations_metrics(),
            "git": self.collect_git_metrics(),
            "performance": self.collect_performance_metrics()
        }
        
        return metrics
    
    def collect_health_metrics(self) -> Dict[str, Any]:
        """Collect system health indicators."""
        health = {
            "framework_integrity": self.check_framework_integrity(),
            "hooks_status": self.check_hooks_status(),
            "file_permissions": self.check_file_permissions(),
            "directory_structure": self.check_directory_structure(),
            "overall_score": 0
        }
        
        # Calculate overall health score
        scores = [v for k, v in health.items() if k != "overall_score" and isinstance(v, (int, float))]
        health["overall_score"] = sum(scores) / len(scores) if scores else 0
        
        return health
    
    def check_framework_integrity(self) -> int:
        """Check integrity of framework files."""
        essential_files = [
            "CLAUDE.md",
            "system/INDEX.md",
            "system/PRINCIPLES.md",
            "system/PERSONALITIES.md",
            "system/PROCESSES.md",
            "system/STANDARDS.md",
            "hooks/README.md"
        ]
        
        score = 0
        total = len(essential_files)
        
        for file_path in essential_files:
            full_path = self.framework_root / file_path
            if full_path.exists() and full_path.stat().st_size > 0:
                score += 1
        
        return int((score / total) * 100)
    
    def check_hooks_status(self) -> int:
        """Check status of hook files."""
        hook_files = list(self.hooks_root.glob("*.py"))
        executable_count = 0
        
        for hook_file in hook_files:
            if os.access(hook_file, os.X_OK):
                executable_count += 1
        
        if not hook_files:
            return 0
            
        return int((executable_count / len(hook_files)) * 100)
    
    def check_file_permissions(self) -> int:
        """Check file permissions are correct."""
        # Check that hook files are executable
        hook_files = list(self.hooks_root.glob("*.py"))
        correct_permissions = 0
        
        for hook_file in hook_files:
            if os.access(hook_file, os.X_OK):
                correct_permissions += 1
        
        if not hook_files:
            return 100  # No hooks to check
            
        return int((correct_permissions / len(hook_files)) * 100)
    
    def check_directory_structure(self) -> int:
        """Check that required directories exist."""
        required_dirs = [
            "system",
            "system/principles",
            "system/personalities", 
            "system/processes",
            "system/standards",
            "hooks",
            "operations"
        ]
        
        existing_dirs = 0
        for dir_path in required_dirs:
            full_path = self.framework_root / dir_path
            if full_path.exists() and full_path.is_dir():
                existing_dirs += 1
        
        return int((existing_dirs / len(required_dirs)) * 100)
    
    def collect_component_metrics(self) -> Dict[str, Any]:
        """Collect metrics about framework components."""
        return {
            "principles": self.count_principles(),
            "personalities": self.count_personalities(),
            "processes": self.count_processes(),
            "standards": self.count_standards(),
            "examples": self.count_examples(),
            "tools": self.count_tools(),
            "hooks": self.count_hooks()
        }
    
    def count_principles(self) -> int:
        """Count number of principles."""
        principles_file = self.system_root / "PRINCIPLES.md"
        if not principles_file.exists():
            return 0
        
        content = principles_file.read_text()
        # Count numbered principles (e.g., "1. ", "2. ", etc.)
        principle_count = len(re.findall(r'^\d+\.\s', content, re.MULTILINE))
        return principle_count
    
    def count_personalities(self) -> int:
        """Count number of personalities."""
        personalities_dir = self.system_root / "personalities"
        if not personalities_dir.exists():
            return 0
        
        personality_files = list(personalities_dir.glob("*.md"))
        return len(personality_files)
    
    def count_processes(self) -> int:
        """Count number of processes."""
        processes_dir = self.system_root / "processes"
        if not processes_dir.exists():
            return 0
        
        process_files = list(processes_dir.glob("*.md"))
        return len(process_files)
    
    def count_standards(self) -> int:
        """Count number of standards."""
        standards_dir = self.system_root / "standards"
        if not standards_dir.exists():
            return 0
        
        standard_files = list(standards_dir.glob("*.md"))
        return len(standard_files)
    
    def count_examples(self) -> int:
        """Count number of examples."""
        examples_dir = self.system_root / "examples"
        if not examples_dir.exists():
            return 0
        
        example_files = list(examples_dir.glob("*.md"))
        return len(example_files)
    
    def count_tools(self) -> int:
        """Count number of tools."""
        tools_dir = self.system_root / "tools"
        if not tools_dir.exists():
            return 0
        
        tool_files = list(tools_dir.glob("*.md"))
        return len(tool_files)
    
    def count_hooks(self) -> int:
        """Count number of hook files."""
        if not self.hooks_root.exists():
            return 0
        
        hook_files = list(self.hooks_root.glob("*.py"))
        return len(hook_files)
    
    def collect_usage_metrics(self) -> Dict[str, Any]:
        """Collect usage statistics."""
        return {
            "project_sessions": self.count_project_sessions(),
            "recent_activity": self.get_recent_activity(),
            "session_patterns": self.analyze_session_patterns(),
            "operation_frequency": self.analyze_operation_frequency()
        }
    
    def count_project_sessions(self) -> int:
        """Count number of project sessions."""
        if not self.projects_root.exists():
            return 0
        
        session_files = list(self.projects_root.glob("**/*.jsonl"))
        return len(session_files)
    
    def get_recent_activity(self) -> Dict[str, Any]:
        """Get recent activity metrics."""
        recent_sessions = self.get_recent_sessions(days=7)
        return {
            "sessions_last_7_days": len(recent_sessions),
            "avg_session_length": self.calculate_avg_session_length(recent_sessions),
            "most_active_day": self.find_most_active_day(recent_sessions)
        }
    
    def get_recent_sessions(self, days: int = 7) -> List[Path]:
        """Get session files modified in the last N days."""
        if not self.projects_root.exists():
            return []
        
        cutoff_date = datetime.now() - timedelta(days=days)
        recent_sessions = []
        
        for session_file in self.projects_root.glob("**/*.jsonl"):
            mtime = datetime.fromtimestamp(session_file.stat().st_mtime)
            if mtime > cutoff_date:
                recent_sessions.append(session_file)
        
        return recent_sessions
    
    def calculate_avg_session_length(self, sessions: List[Path]) -> float:
        """Calculate average session length in minutes."""
        if not sessions:
            return 0.0
        
        total_length = 0.0
        session_count = 0
        
        for session_file in sessions:
            try:
                # Simple heuristic: file size / 1000 for rough session length
                size_kb = session_file.stat().st_size / 1000
                total_length += min(size_kb, 60)  # Cap at 60 minutes
                session_count += 1
            except Exception:
                continue
        
        return total_length / session_count if session_count > 0 else 0.0
    
    def find_most_active_day(self, sessions: List[Path]) -> str:
        """Find the most active day of the week."""
        day_counts = {}
        
        for session_file in sessions:
            mtime = datetime.fromtimestamp(session_file.stat().st_mtime)
            day = mtime.strftime("%A")
            day_counts[day] = day_counts.get(day, 0) + 1
        
        if not day_counts:
            return "N/A"
        
        return max(day_counts, key=day_counts.get)
    
    def analyze_session_patterns(self) -> Dict[str, Any]:
        """Analyze session usage patterns."""
        return {
            "peak_hours": self.find_peak_hours(),
            "session_distribution": self.get_session_distribution(),
            "framework_engagement": self.measure_framework_engagement()
        }
    
    def find_peak_hours(self) -> List[int]:
        """Find peak usage hours."""
        recent_sessions = self.get_recent_sessions(days=30)
        hour_counts = {}
        
        for session_file in recent_sessions:
            mtime = datetime.fromtimestamp(session_file.stat().st_mtime)
            hour = mtime.hour
            hour_counts[hour] = hour_counts.get(hour, 0) + 1
        
        if not hour_counts:
            return []
        
        # Return top 3 peak hours
        sorted_hours = sorted(hour_counts.items(), key=lambda x: x[1], reverse=True)
        return [hour for hour, count in sorted_hours[:3]]
    
    def get_session_distribution(self) -> Dict[str, int]:
        """Get session distribution by time period."""
        recent_sessions = self.get_recent_sessions(days=30)
        
        return {
            "morning": len([s for s in recent_sessions if 6 <= datetime.fromtimestamp(s.stat().st_mtime).hour < 12]),
            "afternoon": len([s for s in recent_sessions if 12 <= datetime.fromtimestamp(s.stat().st_mtime).hour < 18]),
            "evening": len([s for s in recent_sessions if 18 <= datetime.fromtimestamp(s.stat().st_mtime).hour < 24]),
            "night": len([s for s in recent_sessions if 0 <= datetime.fromtimestamp(s.stat().st_mtime).hour < 6])
        }
    
    def measure_framework_engagement(self) -> float:
        """Measure how actively the framework is being used."""
        # Simple heuristic based on operations and sessions
        operations_count = len(list(self.operations_root.glob("*"))) if self.operations_root.exists() else 0
        sessions_count = self.count_project_sessions()
        
        # Engagement score based on activity
        if sessions_count == 0:
            return 0.0
        
        engagement = min((operations_count / sessions_count) * 100, 100)
        return round(engagement, 1)
    
    def analyze_operation_frequency(self) -> Dict[str, int]:
        """Analyze how frequently different operations are performed."""
        if not self.operations_root.exists():
            return {}
        
        operation_types = {}
        
        for operation_dir in self.operations_root.iterdir():
            if operation_dir.is_dir():
                operation_name = operation_dir.name
                # Extract operation type from name
                if '-' in operation_name:
                    parts = operation_name.split('-')
                    if len(parts) > 1:
                        operation_type = '-'.join(parts[1:])  # Skip timestamp
                        operation_types[operation_type] = operation_types.get(operation_type, 0) + 1
        
        return operation_types
    
    def collect_operations_metrics(self) -> List[Dict[str, Any]]:
        """Collect metrics about recent operations."""
        if not self.operations_root.exists():
            return []
        
        operations = []
        
        for operation_dir in self.operations_root.iterdir():
            if operation_dir.is_dir():
                try:
                    stat = operation_dir.stat()
                    operations.append({
                        "name": operation_dir.name,
                        "created": datetime.fromtimestamp(stat.st_ctime).isoformat(),
                        "modified": datetime.fromtimestamp(stat.st_mtime).isoformat(),
                        "files_count": len(list(operation_dir.glob("*.md"))),
                        "size_mb": sum(f.stat().st_size for f in operation_dir.rglob("*") if f.is_file()) / (1024 * 1024)
                    })
                except Exception:
                    continue
        
        # Sort by creation time, most recent first
        operations.sort(key=lambda x: x["created"], reverse=True)
        return operations[:10]  # Return last 10 operations
    
    def collect_git_metrics(self) -> Dict[str, Any]:
        """Collect git-related metrics."""
        try:
            os.chdir(self.framework_root)
            
            # Get git status
            status_result = subprocess.run(['git', 'status', '--porcelain'], 
                                         capture_output=True, text=True, timeout=10)
            
            # Count changes
            changes = len(status_result.stdout.strip().split('\n')) if status_result.stdout.strip() else 0
            
            # Get recent commits
            log_result = subprocess.run(['git', 'log', '--oneline', '-10'], 
                                      capture_output=True, text=True, timeout=10)
            
            recent_commits = log_result.stdout.strip().split('\n') if log_result.stdout.strip() else []
            
            # Get branch info
            branch_result = subprocess.run(['git', 'rev-parse', '--abbrev-ref', 'HEAD'], 
                                         capture_output=True, text=True, timeout=10)
            
            current_branch = branch_result.stdout.strip() if branch_result.returncode == 0 else "unknown"
            
            return {
                "current_branch": current_branch,
                "uncommitted_changes": changes,
                "recent_commits": recent_commits,
                "repository_healthy": status_result.returncode == 0,
                "last_commit_date": self.get_last_commit_date()
            }
            
        except Exception as e:
            return {
                "current_branch": "unknown",
                "uncommitted_changes": 0,
                "recent_commits": [],
                "repository_healthy": False,
                "error": str(e),
                "last_commit_date": None
            }
    
    def get_last_commit_date(self) -> str:
        """Get the date of the last commit."""
        try:
            result = subprocess.run(['git', 'log', '-1', '--format=%cd', '--date=iso'], 
                                  capture_output=True, text=True, timeout=10)
            return result.stdout.strip() if result.returncode == 0 else None
        except Exception:
            return None
    
    def collect_performance_metrics(self) -> Dict[str, Any]:
        """Collect performance-related metrics."""
        return {
            "framework_size": self.calculate_framework_size(),
            "file_counts": self.count_files_by_type(),
            "disk_usage": self.calculate_disk_usage(),
            "cache_size": self.calculate_cache_size()
        }
    
    def calculate_framework_size(self) -> Dict[str, int]:
        """Calculate size of framework components."""
        sizes = {}
        
        for component in ["system", "hooks", "operations"]:
            component_path = self.framework_root / component
            if component_path.exists():
                total_size = sum(f.stat().st_size for f in component_path.rglob("*") if f.is_file())
                sizes[component] = total_size
        
        return sizes
    
    def count_files_by_type(self) -> Dict[str, int]:
        """Count files by extension."""
        file_counts = {}
        
        for file_path in self.framework_root.rglob("*"):
            if file_path.is_file():
                ext = file_path.suffix.lower() or "no_extension"
                file_counts[ext] = file_counts.get(ext, 0) + 1
        
        return file_counts
    
    def calculate_disk_usage(self) -> int:
        """Calculate total disk usage in bytes."""
        total_size = 0
        
        for file_path in self.framework_root.rglob("*"):
            if file_path.is_file():
                total_size += file_path.stat().st_size
        
        return total_size
    
    def calculate_cache_size(self) -> int:
        """Calculate size of cache/temp files."""
        cache_patterns = ["*.log", "*.tmp", "*.cache", "**/logs/**/*"]
        cache_size = 0
        
        for pattern in cache_patterns:
            for file_path in self.framework_root.glob(pattern):
                if file_path.is_file():
                    cache_size += file_path.stat().st_size
        
        return cache_size
    
    def save_metrics(self, metrics: Dict[str, Any], output_file: str = None) -> str:
        """Save metrics to JSON file."""
        if output_file is None:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            output_file = f"claude_metrics_{timestamp}.json"
        
        output_path = self.framework_root / "system" / "dashboard" / "data" / output_file
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(output_path, 'w') as f:
            json.dump(metrics, f, indent=2, default=str)
        
        return str(output_path)

def main():
    """Main function to collect and save metrics."""
    collector = FrameworkMetricsCollector()
    
    print("🔍 Collecting Claude Framework metrics...")
    metrics = collector.collect_all_metrics()
    
    print("💾 Saving metrics data...")
    output_file = collector.save_metrics(metrics)
    
    print(f"✅ Metrics collected and saved to: {output_file}")
    print(f"📊 Overall health score: {metrics['health']['overall_score']:.1f}%")
    print(f"🔄 Total operations: {len(metrics['operations'])}")
    print(f"📁 Project sessions: {metrics['usage']['project_sessions']}")

if __name__ == "__main__":
    main()