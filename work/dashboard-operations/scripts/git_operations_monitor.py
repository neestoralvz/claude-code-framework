#!/usr/bin/env python3
"""
Git and Operations Monitor for Claude Framework Dashboard

Monitors git status, recent commits, and operations directory activity.
Provides real-time insights into framework development and usage.
"""

import json
import os
import subprocess
import glob
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
import re

class GitOperationsMonitor:
    def __init__(self, framework_root: str = "/Users/nalve/.claude"):
        self.framework_root = Path(framework_root)
        self.operations_root = self.framework_root / "operations"
        
    def get_comprehensive_status(self) -> Dict[str, Any]:
        """Get comprehensive git and operations status."""
        return {
            "timestamp": datetime.now().isoformat(),
            "git_status": self.get_git_status(),
            "operations_status": self.get_operations_status(),
            "activity_summary": self.get_activity_summary(),
            "health_indicators": self.get_health_indicators(),
            "recommendations": self.generate_recommendations()
        }
    
    def get_git_status(self) -> Dict[str, Any]:
        """Get detailed git repository status."""
        try:
            os.chdir(self.framework_root)
            
            status = {
                "repository_exists": self.check_git_repository(),
                "current_branch": self.get_current_branch(),
                "uncommitted_changes": self.get_uncommitted_changes(),
                "recent_commits": self.get_recent_commits(),
                "branch_info": self.get_branch_info(),
                "remote_status": self.get_remote_status(),
                "stash_info": self.get_stash_info(),
                "repository_size": self.get_repository_size()
            }
            
            return status
            
        except Exception as e:
            return {
                "repository_exists": False,
                "error": str(e),
                "current_branch": "unknown",
                "uncommitted_changes": {"count": 0, "files": []},
                "recent_commits": [],
                "branch_info": {},
                "remote_status": {},
                "stash_info": {"count": 0},
                "repository_size": {"total_mb": 0}
            }
    
    def check_git_repository(self) -> bool:
        """Check if current directory is a git repository."""
        try:
            result = subprocess.run(['git', 'rev-parse', '--git-dir'], 
                                  capture_output=True, text=True, timeout=5)
            return result.returncode == 0
        except Exception:
            return False
    
    def get_current_branch(self) -> str:
        """Get current git branch."""
        try:
            result = subprocess.run(['git', 'rev-parse', '--abbrev-ref', 'HEAD'], 
                                  capture_output=True, text=True, timeout=5)
            return result.stdout.strip() if result.returncode == 0 else "unknown"
        except Exception:
            return "unknown"
    
    def get_uncommitted_changes(self) -> Dict[str, Any]:
        """Get information about uncommitted changes."""
        try:
            # Get status in porcelain format
            result = subprocess.run(['git', 'status', '--porcelain'], 
                                  capture_output=True, text=True, timeout=10)
            
            if result.returncode != 0:
                return {"count": 0, "files": [], "types": {}}
            
            lines = result.stdout.strip().split('\n') if result.stdout.strip() else []
            
            files_info = []
            change_types = {"modified": 0, "added": 0, "deleted": 0, "renamed": 0, "untracked": 0}
            
            for line in lines:
                if len(line) >= 3:
                    status_code = line[:2]
                    file_path = line[3:]
                    
                    # Determine change type
                    if status_code == '??':
                        change_type = "untracked"
                    elif 'M' in status_code:
                        change_type = "modified"
                    elif 'A' in status_code:
                        change_type = "added"
                    elif 'D' in status_code:
                        change_type = "deleted"
                    elif 'R' in status_code:
                        change_type = "renamed"
                    else:
                        change_type = "other"
                    
                    change_types[change_type] = change_types.get(change_type, 0) + 1
                    
                    files_info.append({
                        "path": file_path,
                        "status": status_code,
                        "type": change_type
                    })
            
            return {
                "count": len(files_info),
                "files": files_info[:20],  # Limit to first 20 files
                "types": change_types,
                "total_files": len(files_info)
            }
            
        except Exception as e:
            return {"count": 0, "files": [], "types": {}, "error": str(e)}
    
    def get_recent_commits(self, limit: int = 10) -> List[Dict[str, Any]]:
        """Get recent commit information."""
        try:
            # Get commit log with custom format
            result = subprocess.run([
                'git', 'log', f'--max-count={limit}', 
                '--pretty=format:%H|%h|%s|%an|%ae|%ad|%ar',
                '--date=iso'
            ], capture_output=True, text=True, timeout=10)
            
            if result.returncode != 0:
                return []
            
            commits = []
            for line in result.stdout.strip().split('\n'):
                if line:
                    parts = line.split('|')
                    if len(parts) >= 7:
                        commits.append({
                            "hash": parts[0],
                            "short_hash": parts[1],
                            "subject": parts[2],
                            "author_name": parts[3],
                            "author_email": parts[4],
                            "date": parts[5],
                            "relative_date": parts[6]
                        })
            
            return commits
            
        except Exception as e:
            return []
    
    def get_branch_info(self) -> Dict[str, Any]:
        """Get branch information."""
        try:
            # Get all branches
            result = subprocess.run(['git', 'branch', '-a'], 
                                  capture_output=True, text=True, timeout=5)
            
            branches = []
            current_branch = ""
            
            if result.returncode == 0:
                for line in result.stdout.strip().split('\n'):
                    line = line.strip()
                    if line.startswith('* '):
                        current_branch = line[2:]
                        branches.append({"name": line[2:], "current": True})
                    elif line and not line.startswith('remotes/'):
                        branches.append({"name": line, "current": False})
            
            return {
                "current_branch": current_branch,
                "local_branches": branches,
                "total_branches": len(branches)
            }
            
        except Exception:
            return {"current_branch": "", "local_branches": [], "total_branches": 0}
    
    def get_remote_status(self) -> Dict[str, Any]:
        """Get remote repository status."""
        try:
            # Get remote URLs
            result = subprocess.run(['git', 'remote', '-v'], 
                                  capture_output=True, text=True, timeout=5)
            
            remotes = {}
            if result.returncode == 0:
                for line in result.stdout.strip().split('\n'):
                    if line:
                        parts = line.split()
                        if len(parts) >= 3:
                            remote_name = parts[0]
                            remote_url = parts[1]
                            remote_type = parts[2].strip('()')
                            
                            if remote_name not in remotes:
                                remotes[remote_name] = {}
                            remotes[remote_name][remote_type] = remote_url
            
            # Try to get ahead/behind status for main remote
            ahead_behind = self.get_ahead_behind_status()
            
            return {
                "remotes": remotes,
                "has_remote": len(remotes) > 0,
                "ahead_behind": ahead_behind
            }
            
        except Exception:
            return {"remotes": {}, "has_remote": False, "ahead_behind": {}}
    
    def get_ahead_behind_status(self) -> Dict[str, Any]:
        """Get ahead/behind status with remote."""
        try:
            result = subprocess.run(['git', 'status', '-b', '--porcelain'], 
                                  capture_output=True, text=True, timeout=5)
            
            if result.returncode != 0:
                return {}
            
            first_line = result.stdout.split('\n')[0] if result.stdout else ""
            
            ahead = 0
            behind = 0
            
            if 'ahead' in first_line:
                match = re.search(r'ahead (\d+)', first_line)
                if match:
                    ahead = int(match.group(1))
            
            if 'behind' in first_line:
                match = re.search(r'behind (\d+)', first_line)
                if match:
                    behind = int(match.group(1))
            
            return {
                "ahead": ahead,
                "behind": behind,
                "in_sync": ahead == 0 and behind == 0
            }
            
        except Exception:
            return {}
    
    def get_stash_info(self) -> Dict[str, Any]:
        """Get git stash information."""
        try:
            result = subprocess.run(['git', 'stash', 'list'], 
                                  capture_output=True, text=True, timeout=5)
            
            stash_count = 0
            stashes = []
            
            if result.returncode == 0:
                stash_lines = result.stdout.strip().split('\n') if result.stdout.strip() else []
                stash_count = len(stash_lines)
                
                for line in stash_lines[:5]:  # Get first 5 stashes
                    stashes.append(line)
            
            return {
                "count": stash_count,
                "stashes": stashes,
                "has_stashes": stash_count > 0
            }
            
        except Exception:
            return {"count": 0, "stashes": [], "has_stashes": False}
    
    def get_repository_size(self) -> Dict[str, Any]:
        """Get repository size information."""
        try:
            git_dir = self.framework_root / '.git'
            if git_dir.exists():
                total_size = sum(f.stat().st_size for f in git_dir.rglob('*') if f.is_file())
                total_size_mb = total_size / (1024 * 1024)
                
                return {
                    "total_bytes": total_size,
                    "total_mb": round(total_size_mb, 2),
                    "size_category": self.categorize_repo_size(total_size_mb)
                }
            else:
                return {"total_bytes": 0, "total_mb": 0, "size_category": "no_git"}
                
        except Exception:
            return {"total_bytes": 0, "total_mb": 0, "size_category": "unknown"}
    
    def categorize_repo_size(self, size_mb: float) -> str:
        """Categorize repository size."""
        if size_mb < 1:
            return "tiny"
        elif size_mb < 10:
            return "small"
        elif size_mb < 50:
            return "medium"
        elif size_mb < 200:
            return "large"
        else:
            return "very_large"
    
    def get_operations_status(self) -> Dict[str, Any]:
        """Get operations directory status."""
        if not self.operations_root.exists():
            return {
                "exists": False,
                "total_operations": 0,
                "recent_operations": [],
                "operation_types": {},
                "size_info": {"total_mb": 0}
            }
        
        try:
            # Get all operation directories
            operation_dirs = [d for d in self.operations_root.iterdir() if d.is_dir()]
            
            # Analyze recent operations (last 30 days)
            recent_operations = self.get_recent_operations(30)
            
            # Analyze operation types
            operation_types = self.analyze_operation_types(operation_dirs)
            
            # Calculate total size
            total_size = self.calculate_operations_size()
            
            # Get operation frequency
            operation_frequency = self.analyze_operation_frequency(operation_dirs)
            
            return {
                "exists": True,
                "total_operations": len(operation_dirs),
                "recent_operations": recent_operations,
                "operation_types": operation_types,
                "size_info": total_size,
                "frequency": operation_frequency,
                "oldest_operation": self.get_oldest_operation(operation_dirs),
                "newest_operation": self.get_newest_operation(operation_dirs)
            }
            
        except Exception as e:
            return {
                "exists": True,
                "error": str(e),
                "total_operations": 0,
                "recent_operations": [],
                "operation_types": {},
                "size_info": {"total_mb": 0}
            }
    
    def get_recent_operations(self, days: int = 30) -> List[Dict[str, Any]]:
        """Get operations from the last N days."""
        if not self.operations_root.exists():
            return []
        
        cutoff_date = datetime.now() - timedelta(days=days)
        recent_operations = []
        
        for op_dir in self.operations_root.iterdir():
            if op_dir.is_dir():
                try:
                    mtime = datetime.fromtimestamp(op_dir.stat().st_mtime)
                    if mtime > cutoff_date:
                        # Count files in operation
                        md_files = list(op_dir.glob("*.md"))
                        
                        recent_operations.append({
                            "name": op_dir.name,
                            "created": datetime.fromtimestamp(op_dir.stat().st_ctime).isoformat(),
                            "modified": mtime.isoformat(),
                            "files_count": len(md_files),
                            "size_kb": sum(f.stat().st_size for f in md_files) / 1024
                        })
                except Exception:
                    continue
        
        # Sort by modification time, most recent first
        recent_operations.sort(key=lambda x: x["modified"], reverse=True)
        return recent_operations[:10]  # Return last 10 operations
    
    def analyze_operation_types(self, operation_dirs: List[Path]) -> Dict[str, int]:
        """Analyze types of operations based on directory names."""
        operation_types = {}
        
        for op_dir in operation_dirs:
            name = op_dir.name
            
            # Extract operation type from name (skip timestamp prefix)
            if '-' in name:
                parts = name.split('-', 1)
                if len(parts) > 1:
                    # Look for operation type patterns
                    operation_name = parts[1]
                    
                    # Categorize based on common patterns
                    if any(keyword in operation_name for keyword in ['agent', 'template', 'orchestration']):
                        op_type = "agent_management"
                    elif any(keyword in operation_name for keyword in ['dashboard', 'metrics', 'monitoring']):
                        op_type = "monitoring_systems"
                    elif any(keyword in operation_name for keyword in ['framework', 'system', 'enhancement']):
                        op_type = "framework_development"
                    elif any(keyword in operation_name for keyword in ['planning', 'strategic', 'roadmap']):
                        op_type = "strategic_planning"
                    elif any(keyword in operation_name for keyword in ['validation', 'testing', 'quality']):
                        op_type = "quality_assurance"
                    elif any(keyword in operation_name for keyword in ['session', 'workflow', 'process']):
                        op_type = "workflow_management"
                    else:
                        op_type = "general"
                    
                    operation_types[op_type] = operation_types.get(op_type, 0) + 1
        
        return operation_types
    
    def calculate_operations_size(self) -> Dict[str, float]:
        """Calculate total size of operations directory."""
        if not self.operations_root.exists():
            return {"total_mb": 0, "average_mb": 0}
        
        try:
            total_size = 0
            operation_count = 0
            
            for op_dir in self.operations_root.iterdir():
                if op_dir.is_dir():
                    operation_count += 1
                    for file_path in op_dir.rglob("*"):
                        if file_path.is_file():
                            total_size += file_path.stat().st_size
            
            total_mb = total_size / (1024 * 1024)
            average_mb = total_mb / operation_count if operation_count > 0 else 0
            
            return {
                "total_bytes": total_size,
                "total_mb": round(total_mb, 2),
                "average_mb": round(average_mb, 2),
                "operation_count": operation_count
            }
            
        except Exception:
            return {"total_mb": 0, "average_mb": 0}
    
    def analyze_operation_frequency(self, operation_dirs: List[Path]) -> Dict[str, Any]:
        """Analyze operation creation frequency."""
        if not operation_dirs:
            return {"operations_per_day": 0, "peak_days": [], "trend": "no_data"}
        
        # Group operations by day
        daily_counts = {}
        
        for op_dir in operation_dirs:
            try:
                ctime = datetime.fromtimestamp(op_dir.stat().st_ctime)
                day_key = ctime.date().isoformat()
                daily_counts[day_key] = daily_counts.get(day_key, 0) + 1
            except Exception:
                continue
        
        if not daily_counts:
            return {"operations_per_day": 0, "peak_days": [], "trend": "no_data"}
        
        # Calculate average operations per day
        total_ops = sum(daily_counts.values())
        days_with_activity = len(daily_counts)
        avg_per_day = total_ops / days_with_activity
        
        # Find peak days
        peak_days = sorted(daily_counts.items(), key=lambda x: x[1], reverse=True)[:5]
        
        # Determine trend (simple: compare first half vs second half)
        sorted_days = sorted(daily_counts.keys())
        if len(sorted_days) > 4:
            mid_point = len(sorted_days) // 2
            first_half_avg = sum(daily_counts[day] for day in sorted_days[:mid_point]) / mid_point
            second_half_avg = sum(daily_counts[day] for day in sorted_days[mid_point:]) / (len(sorted_days) - mid_point)
            
            if second_half_avg > first_half_avg * 1.2:
                trend = "increasing"
            elif second_half_avg < first_half_avg * 0.8:
                trend = "decreasing"
            else:
                trend = "stable"
        else:
            trend = "insufficient_data"
        
        return {
            "operations_per_day": round(avg_per_day, 2),
            "peak_days": [{"date": day, "count": count} for day, count in peak_days],
            "trend": trend,
            "total_active_days": days_with_activity
        }
    
    def get_oldest_operation(self, operation_dirs: List[Path]) -> Optional[Dict[str, Any]]:
        """Get information about the oldest operation."""
        if not operation_dirs:
            return None
        
        oldest = min(operation_dirs, key=lambda x: x.stat().st_ctime)
        return {
            "name": oldest.name,
            "created": datetime.fromtimestamp(oldest.stat().st_ctime).isoformat(),
            "age_days": (datetime.now() - datetime.fromtimestamp(oldest.stat().st_ctime)).days
        }
    
    def get_newest_operation(self, operation_dirs: List[Path]) -> Optional[Dict[str, Any]]:
        """Get information about the newest operation."""
        if not operation_dirs:
            return None
        
        newest = max(operation_dirs, key=lambda x: x.stat().st_mtime)
        return {
            "name": newest.name,
            "modified": datetime.fromtimestamp(newest.stat().st_mtime).isoformat(),
            "age_hours": (datetime.now() - datetime.fromtimestamp(newest.stat().st_mtime)).total_seconds() / 3600
        }
    
    def get_activity_summary(self) -> Dict[str, Any]:
        """Get summary of recent activity across git and operations."""
        git_status = self.get_git_status()
        ops_status = self.get_operations_status()
        
        # Calculate activity score based on recent changes
        activity_score = 0
        
        # Git activity
        if git_status.get("uncommitted_changes", {}).get("count", 0) > 0:
            activity_score += 30
        
        recent_commits = git_status.get("recent_commits", [])
        if recent_commits:
            # Check if latest commit is recent (last 24 hours)
            latest_commit = recent_commits[0]
            if "relative_date" in latest_commit:
                relative = latest_commit["relative_date"]
                if any(keyword in relative for keyword in ["hour", "minute", "second"]):
                    activity_score += 40
                elif "day" in relative and "1 day" in relative:
                    activity_score += 20
        
        # Operations activity
        recent_ops = ops_status.get("recent_operations", [])
        if recent_ops:
            # Check if latest operation is recent
            latest_op = recent_ops[0]
            modified_time = datetime.fromisoformat(latest_op["modified"])
            hours_ago = (datetime.now() - modified_time).total_seconds() / 3600
            
            if hours_ago < 1:
                activity_score += 30
            elif hours_ago < 24:
                activity_score += 15
        
        return {
            "activity_score": min(activity_score, 100),
            "activity_level": self.categorize_activity_level(activity_score),
            "last_git_activity": recent_commits[0]["relative_date"] if recent_commits else "No recent commits",
            "last_operation": recent_ops[0]["name"] if recent_ops else "No recent operations",
            "summary": self.generate_activity_summary(activity_score, git_status, ops_status)
        }
    
    def categorize_activity_level(self, score: int) -> str:
        """Categorize activity level based on score."""
        if score >= 80:
            return "very_active"
        elif score >= 50:
            return "active"
        elif score >= 20:
            return "moderate"
        else:
            return "quiet"
    
    def generate_activity_summary(self, score: int, git_status: Dict, ops_status: Dict) -> str:
        """Generate human-readable activity summary."""
        if score >= 80:
            return "High activity: Recent commits and operations detected"
        elif score >= 50:
            return "Moderate activity: Some recent development work"
        elif score >= 20:
            return "Light activity: Occasional framework updates"
        else:
            return "Quiet period: No recent development activity"
    
    def get_health_indicators(self) -> Dict[str, Any]:
        """Get health indicators for git and operations."""
        git_status = self.get_git_status()
        ops_status = self.get_operations_status()
        
        indicators = {
            "git_health": self.assess_git_health(git_status),
            "operations_health": self.assess_operations_health(ops_status),
            "overall_health": "good"  # Will be calculated
        }
        
        # Calculate overall health
        git_score = indicators["git_health"]["score"]
        ops_score = indicators["operations_health"]["score"]
        overall_score = (git_score + ops_score) / 2
        
        if overall_score >= 80:
            overall_health = "excellent"
        elif overall_score >= 60:
            overall_health = "good"
        elif overall_score >= 40:
            overall_health = "fair"
        else:
            overall_health = "poor"
        
        indicators["overall_health"] = overall_health
        indicators["overall_score"] = round(overall_score, 1)
        
        return indicators
    
    def assess_git_health(self, git_status: Dict) -> Dict[str, Any]:
        """Assess git repository health."""
        score = 100
        issues = []
        
        if not git_status.get("repository_exists", False):
            score -= 50
            issues.append("Not a git repository")
        
        uncommitted = git_status.get("uncommitted_changes", {}).get("count", 0)
        if uncommitted > 10:
            score -= 20
            issues.append(f"Many uncommitted changes ({uncommitted})")
        elif uncommitted > 5:
            score -= 10
            issues.append(f"Some uncommitted changes ({uncommitted})")
        
        if not git_status.get("remote_status", {}).get("has_remote", False):
            score -= 15
            issues.append("No remote repository configured")
        
        stash_count = git_status.get("stash_info", {}).get("count", 0)
        if stash_count > 5:
            score -= 10
            issues.append(f"Many stashed changes ({stash_count})")
        
        return {
            "score": max(score, 0),
            "status": "healthy" if score >= 80 else "needs_attention" if score >= 60 else "poor",
            "issues": issues
        }
    
    def assess_operations_health(self, ops_status: Dict) -> Dict[str, Any]:
        """Assess operations directory health."""
        score = 100
        issues = []
        
        if not ops_status.get("exists", False):
            score -= 30
            issues.append("Operations directory does not exist")
            return {"score": score, "status": "poor", "issues": issues}
        
        total_ops = ops_status.get("total_operations", 0)
        if total_ops == 0:
            score -= 40
            issues.append("No operations found")
        elif total_ops > 100:
            score -= 10
            issues.append(f"Many operations ({total_ops}) - consider cleanup")
        
        size_mb = ops_status.get("size_info", {}).get("total_mb", 0)
        if size_mb > 500:  # More than 500MB
            score -= 15
            issues.append(f"Large operations directory ({size_mb:.1f} MB)")
        
        recent_ops = ops_status.get("recent_operations", [])
        if not recent_ops:
            score -= 20
            issues.append("No recent operations (last 30 days)")
        
        return {
            "score": max(score, 0),
            "status": "healthy" if score >= 80 else "needs_attention" if score >= 60 else "poor",
            "issues": issues
        }
    
    def generate_recommendations(self) -> List[Dict[str, str]]:
        """Generate recommendations based on current status."""
        git_status = self.get_git_status()
        ops_status = self.get_operations_status()
        health = self.get_health_indicators()
        
        recommendations = []
        
        # Git recommendations
        uncommitted = git_status.get("uncommitted_changes", {}).get("count", 0)
        if uncommitted > 5:
            recommendations.append({
                "category": "git",
                "priority": "medium",
                "title": "Commit Pending Changes",
                "description": f"You have {uncommitted} uncommitted changes. Consider committing your work."
            })
        
        if not git_status.get("remote_status", {}).get("has_remote", False):
            recommendations.append({
                "category": "git", 
                "priority": "low",
                "title": "Configure Remote Repository",
                "description": "Consider adding a remote repository for backup and collaboration."
            })
        
        # Operations recommendations
        total_ops = ops_status.get("total_operations", 0)
        if total_ops > 50:
            recommendations.append({
                "category": "operations",
                "priority": "low",
                "title": "Archive Old Operations",
                "description": f"Consider archiving or cleaning up old operations ({total_ops} total)."
            })
        
        size_mb = ops_status.get("size_info", {}).get("total_mb", 0)
        if size_mb > 200:
            recommendations.append({
                "category": "operations",
                "priority": "medium",
                "title": "Operations Directory Cleanup",
                "description": f"Operations directory is large ({size_mb:.1f} MB). Consider cleanup."
            })
        
        # General health recommendations
        if health.get("overall_score", 0) < 70:
            recommendations.append({
                "category": "health",
                "priority": "high",
                "title": "Improve Repository Health",
                "description": "Repository health could be improved. Review git and operations status."
            })
        
        if not recommendations:
            recommendations.append({
                "category": "general",
                "priority": "low",
                "title": "Maintain Current Status",
                "description": "Repository and operations are in good condition. Continue current practices."
            })
        
        return recommendations
    
    def export_status_report(self, output_file: str = None) -> str:
        """Export comprehensive status report to JSON file."""
        status_data = self.get_comprehensive_status()
        
        if output_file is None:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            output_file = f"git_operations_status_{timestamp}.json"
        
        output_path = self.framework_root / "system" / "dashboard" / "data" / output_file
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(output_path, 'w') as f:
            json.dump(status_data, f, indent=2, default=str)
        
        return str(output_path)

def main():
    """Main function to run git and operations monitoring."""
    monitor = GitOperationsMonitor()
    
    print("🔍 Monitoring Git and Operations Status...")
    status = monitor.get_comprehensive_status()
    
    # Print summary
    print(f"\n📊 Status Summary:")
    git_health = status["health_indicators"]["git_health"]
    ops_health = status["health_indicators"]["operations_health"]
    
    print(f"  Git Health: {git_health['status'].title()} ({git_health['score']}%)")
    print(f"  Operations Health: {ops_health['status'].title()} ({ops_health['score']}%)")
    print(f"  Overall Health: {status['health_indicators']['overall_health'].title()}")
    
    # Print activity
    activity = status["activity_summary"]
    print(f"  Activity Level: {activity['activity_level'].replace('_', ' ').title()}")
    print(f"  Activity Score: {activity['activity_score']}%")
    
    # Print top recommendations
    print(f"\n🎯 Top Recommendations:")
    for rec in status["recommendations"][:3]:
        priority_icon = "🔴" if rec['priority'] == 'high' else "🟡" if rec['priority'] == 'medium' else "🟢"
        print(f"  {priority_icon} {rec['title']}: {rec['description']}")
    
    # Export report
    output_file = monitor.export_status_report()
    print(f"\n💾 Status report exported to: {output_file}")

if __name__ == "__main__":
    main()