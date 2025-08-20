#!/usr/bin/env python3
"""
Dashboard Metrics Updater

Called by hooks to update dashboard metrics in real-time.
Handles incremental updates and maintains metrics cache.
"""

import json
import os
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, Optional, List

class DashboardMetricsUpdater:
    def __init__(self, framework_root: str = "/Users/nalve/.claude"):
        self.framework_root = Path(framework_root)
        self.dashboard_data_dir = self.framework_root / "system" / "dashboard" / "data"
        self.dashboard_data_dir.mkdir(parents=True, exist_ok=True)
        
        self.metrics_cache_file = self.dashboard_data_dir / "metrics_cache.json"
        self.activity_log_file = self.dashboard_data_dir / "activity_log.jsonl"
        
    def update_from_hook_data(self, hook_data: Dict[str, Any]):
        """Update dashboard metrics based on hook execution data."""
        try:
            # Load current metrics cache
            metrics_cache = self.load_metrics_cache()
            
            # Update metrics based on hook event
            event_type = hook_data.get('event', 'unknown')
            
            if event_type == 'post_tool_use':
                self.handle_post_tool_use(hook_data, metrics_cache)
            elif event_type == 'session_start':
                self.handle_session_start(hook_data, metrics_cache)
            elif event_type == 'user_prompt_submit':
                self.handle_user_prompt(hook_data, metrics_cache)
            elif event_type == 'pre_tool_use':
                self.handle_pre_tool_use(hook_data, metrics_cache)
            
            # Log the activity
            self.log_activity(hook_data)
            
            # Save updated cache
            self.save_metrics_cache(metrics_cache)
            
            return True
            
        except Exception as e:
            # Log error but don't fail
            error_log = {
                "timestamp": datetime.now().isoformat(),
                "error": str(e),
                "hook_data": hook_data,
                "event_type": "metrics_update_error"
            }
            self.log_activity(error_log)
            return False
    
    def load_metrics_cache(self) -> Dict[str, Any]:
        """Load existing metrics cache or create new one."""
        if not self.metrics_cache_file.exists():
            return self.create_empty_cache()
        
        try:
            with open(self.metrics_cache_file, 'r') as f:
                cache = json.load(f)
            
            # Ensure cache has required structure
            if 'last_updated' not in cache:
                cache['last_updated'] = datetime.now().isoformat()
            
            return cache
            
        except Exception:
            return self.create_empty_cache()
    
    def create_empty_cache(self) -> Dict[str, Any]:
        """Create empty metrics cache structure."""
        return {
            "last_updated": datetime.now().isoformat(),
            "tool_usage": {
                "total_executions": 0,
                "tool_counts": {},
                "recent_tools": []
            },
            "session_data": {
                "total_sessions": 0,
                "session_starts_today": 0,
                "last_session_start": None
            },
            "file_modifications": {
                "total_modifications": 0,
                "files_modified_today": 0,
                "recent_modifications": []
            },
            "hook_performance": {
                "total_hook_executions": 0,
                "hook_success_rate": 100.0,
                "average_execution_time": 0.0
            },
            "framework_health": {
                "last_health_check": None,
                "health_score": 0,
                "issues_detected": 0
            },
            "agent_activity": {
                "agent_mentions": {},
                "total_agent_deployments": 0,
                "recent_agent_activity": []
            }
        }
    
    def handle_post_tool_use(self, hook_data: Dict[str, Any], cache: Dict[str, Any]):
        """Handle post_tool_use hook data."""
        tool_data = hook_data.get('tool', {})
        tool_name = tool_data.get('name', 'unknown')
        
        # Update tool usage statistics
        cache['tool_usage']['total_executions'] += 1
        cache['tool_usage']['tool_counts'][tool_name] = cache['tool_usage']['tool_counts'].get(tool_name, 0) + 1
        
        # Update recent tools list (keep last 10)
        recent_tools = cache['tool_usage'].get('recent_tools', [])
        recent_tools.insert(0, {
            "tool": tool_name,
            "timestamp": hook_data.get('timestamp', datetime.now().isoformat()),
            "parameters": tool_data.get('parameters', {})
        })
        cache['tool_usage']['recent_tools'] = recent_tools[:10]
        
        # Track file modifications
        modified_files = hook_data.get('modified_files', [])
        if modified_files:
            cache['file_modifications']['total_modifications'] += len(modified_files)
            
            # Check if today
            today = datetime.now().date().isoformat()
            last_update = cache.get('last_updated', '')
            if today in last_update:
                cache['file_modifications']['files_modified_today'] += len(modified_files)
            else:
                cache['file_modifications']['files_modified_today'] = len(modified_files)
            
            # Update recent modifications
            for file_path in modified_files:
                cache['file_modifications']['recent_modifications'].insert(0, {
                    "file": file_path,
                    "tool": tool_name,
                    "timestamp": hook_data.get('timestamp', datetime.now().isoformat())
                })
            
            # Keep only recent 20 modifications
            cache['file_modifications']['recent_modifications'] = cache['file_modifications']['recent_modifications'][:20]
        
        # Update framework health if validation data available
        if 'warnings' in hook_data:
            warnings = hook_data.get('warnings', [])
            cache['framework_health']['issues_detected'] = len(warnings)
            
            # Simple health score calculation
            if warnings:
                cache['framework_health']['health_score'] = max(0, 100 - len(warnings) * 10)
            else:
                cache['framework_health']['health_score'] = 100
        
        # Update hook performance
        cache['hook_performance']['total_hook_executions'] += 1
        
        # Check for agent mentions in tool parameters or results
        self.detect_agent_activity(hook_data, cache)
    
    def handle_session_start(self, hook_data: Dict[str, Any], cache: Dict[str, Any]):
        """Handle session_start hook data."""
        cache['session_data']['total_sessions'] += 1
        
        # Check if today
        today = datetime.now().date().isoformat()
        timestamp = hook_data.get('timestamp', datetime.now().isoformat())
        
        if today in timestamp:
            cache['session_data']['session_starts_today'] += 1
        else:
            cache['session_data']['session_starts_today'] = 1
        
        cache['session_data']['last_session_start'] = timestamp
    
    def handle_user_prompt(self, hook_data: Dict[str, Any], cache: Dict[str, Any]):
        """Handle user_prompt_submit hook data."""
        # This hook provides context about user activity
        # Can be used to track engagement patterns
        pass
    
    def handle_pre_tool_use(self, hook_data: Dict[str, Any], cache: Dict[str, Any]):
        """Handle pre_tool_use hook data."""
        # Track tool preparation/validation events
        pass
    
    def detect_agent_activity(self, hook_data: Dict[str, Any], cache: Dict[str, Any]):
        """Detect agent-related activity in hook data."""
        # Look for agent mentions in tool parameters and results
        text_content = json.dumps(hook_data).lower()
        
        # Common agent indicators
        agent_indicators = [
            'strategic', 'orchestrator', 'guardian', 'collaborative',
            'action-oriented', 'research', 'specialist', 'deep-thinker',
            'knowledge-curator', 'dashboard-management', 'api-design',
            'code-quality', 'performance-optimization', 'testing-strategy',
            'claude-hooks', 'agent-template'
        ]
        
        for indicator in agent_indicators:
            if indicator in text_content:
                # Increment agent activity counter
                cache['agent_activity']['agent_mentions'][indicator] = cache['agent_activity']['agent_mentions'].get(indicator, 0) + 1
                cache['agent_activity']['total_agent_deployments'] += 1
                
                # Add to recent activity
                cache['agent_activity']['recent_agent_activity'].insert(0, {
                    "agent_type": indicator,
                    "timestamp": hook_data.get('timestamp', datetime.now().isoformat()),
                    "context": "tool_execution"
                })
                
                # Keep only recent 10 activities
                cache['agent_activity']['recent_agent_activity'] = cache['agent_activity']['recent_agent_activity'][:10]
                
                break  # Only count once per hook execution
    
    def log_activity(self, data: Dict[str, Any]):
        """Log activity to activity log file."""
        try:
            log_entry = {
                "timestamp": datetime.now().isoformat(),
                **data
            }
            
            with open(self.activity_log_file, 'a') as f:
                f.write(json.dumps(log_entry) + '\n')
                
        except Exception:
            # Silently fail on logging errors
            pass
    
    def save_metrics_cache(self, cache: Dict[str, Any]):
        """Save metrics cache to file."""
        cache['last_updated'] = datetime.now().isoformat()
        
        try:
            # Write to temporary file first, then rename (atomic operation)
            temp_file = self.metrics_cache_file.with_suffix('.tmp')
            
            with open(temp_file, 'w') as f:
                json.dump(cache, f, indent=2)
            
            temp_file.rename(self.metrics_cache_file)
            
        except Exception as e:
            # Log error but continue
            error_data = {
                "event_type": "cache_save_error",
                "error": str(e),
                "timestamp": datetime.now().isoformat()
            }
            self.log_activity(error_data)
    
    def get_current_metrics(self) -> Dict[str, Any]:
        """Get current dashboard metrics for API endpoints."""
        cache = self.load_metrics_cache()
        
        # Add computed metrics
        cache['computed'] = {
            "tools_per_day": self.calculate_tools_per_day(cache),
            "files_per_day": self.calculate_files_per_day(cache),
            "session_frequency": self.calculate_session_frequency(cache),
            "top_tools": self.get_top_tools(cache),
            "recent_activity_summary": self.get_recent_activity_summary(cache)
        }
        
        return cache
    
    def calculate_tools_per_day(self, cache: Dict[str, Any]) -> float:
        """Calculate average tools executed per day."""
        total_tools = cache.get('tool_usage', {}).get('total_executions', 0)
        
        # Rough estimation based on cache age
        if total_tools == 0:
            return 0.0
        
        # Assume data covers last 30 days (rough approximation)
        return round(total_tools / 30, 1)
    
    def calculate_files_per_day(self, cache: Dict[str, Any]) -> float:
        """Calculate average files modified per day."""
        total_files = cache.get('file_modifications', {}).get('total_modifications', 0)
        
        if total_files == 0:
            return 0.0
        
        return round(total_files / 30, 1)
    
    def calculate_session_frequency(self, cache: Dict[str, Any]) -> float:
        """Calculate session frequency."""
        total_sessions = cache.get('session_data', {}).get('total_sessions', 0)
        
        if total_sessions == 0:
            return 0.0
        
        return round(total_sessions / 30, 1)
    
    def get_top_tools(self, cache: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Get top 5 most used tools."""
        tool_counts = cache.get('tool_usage', {}).get('tool_counts', {})
        
        if not tool_counts:
            return []
        
        sorted_tools = sorted(tool_counts.items(), key=lambda x: x[1], reverse=True)[:5]
        
        return [{"tool": tool, "count": count} for tool, count in sorted_tools]
    
    def get_recent_activity_summary(self, cache: Dict[str, Any]) -> Dict[str, Any]:
        """Get summary of recent activity."""
        recent_tools = cache.get('tool_usage', {}).get('recent_tools', [])
        recent_files = cache.get('file_modifications', {}).get('recent_modifications', [])
        recent_agents = cache.get('agent_activity', {}).get('recent_agent_activity', [])
        
        return {
            "recent_tools_count": len(recent_tools),
            "recent_files_count": len(recent_files),
            "recent_agents_count": len(recent_agents),
            "last_activity": recent_tools[0]['timestamp'] if recent_tools else None
        }

def main():
    """Main function for testing metrics updater."""
    updater = DashboardMetricsUpdater()
    
    # Test with sample hook data
    sample_hook_data = {
        "event": "post_tool_use",
        "tool": {
            "name": "Edit",
            "parameters": {
                "file_path": "/Users/nalve/.claude/system/test.md"
            }
        },
        "result": {},
        "timestamp": datetime.now().isoformat(),
        "modified_files": ["/Users/nalve/.claude/system/test.md"]
    }
    
    success = updater.update_from_hook_data(sample_hook_data)
    print(f"Metrics update: {'Success' if success else 'Failed'}")
    
    # Get current metrics
    metrics = updater.get_current_metrics()
    print(f"Current tool executions: {metrics['tool_usage']['total_executions']}")

if __name__ == "__main__":
    main()