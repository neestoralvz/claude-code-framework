#!/usr/bin/env python3
"""
Claude Framework Health Check Script

Performs comprehensive health checks on the framework components
and reports any issues or recommendations.
"""

import json
import os
import subprocess
from pathlib import Path
from typing import Dict, List, Tuple, Any
from datetime import datetime

class FrameworkHealthChecker:
    def __init__(self, framework_root: str = "/Users/nalve/.claude"):
        self.framework_root = Path(framework_root)
        self.system_root = self.framework_root / "system"
        self.hooks_root = self.framework_root / "hooks"
        self.operations_root = self.framework_root / "operations"
        
        self.checks = []
        self.warnings = []
        self.errors = []
        
    def run_all_checks(self) -> Dict[str, Any]:
        """Run all health checks and return comprehensive report."""
        print("🏥 Running Claude Framework Health Check...")
        
        # Essential file checks
        self.check_essential_files()
        
        # Directory structure checks
        self.check_directory_structure()
        
        # Hook functionality checks
        self.check_hooks_health()
        
        # Permission checks
        self.check_file_permissions()
        
        # Git repository health
        self.check_git_health()
        
        # Framework consistency checks
        self.check_framework_consistency()
        
        # Performance checks
        self.check_performance_issues()
        
        # Generate health score
        health_score = self.calculate_health_score()
        
        report = {
            "timestamp": datetime.now().isoformat(),
            "health_score": health_score,
            "status": self.get_overall_status(health_score),
            "checks_passed": len(self.checks),
            "warnings": len(self.warnings),
            "errors": len(self.errors),
            "details": {
                "checks": self.checks,
                "warnings": self.warnings,
                "errors": self.errors
            },
            "recommendations": self.generate_recommendations()
        }
        
        return report
    
    def check_essential_files(self):
        """Check that essential framework files exist and are valid."""
        essential_files = {
            "CLAUDE.md": "Main framework configuration",
            "system/INDEX.md": "System navigation index",
            "system/PRINCIPLES.md": "Framework principles",
            "system/PERSONALITIES.md": "Personality definitions",
            "system/PROCESSES.md": "Process documentation",
            "system/STANDARDS.md": "Quality standards",
            "hooks/README.md": "Hooks documentation",
            "hooks/config.json": "Hook configuration"
        }
        
        for file_path, description in essential_files.items():
            full_path = self.framework_root / file_path
            
            if not full_path.exists():
                self.errors.append({
                    "type": "missing_file",
                    "file": file_path,
                    "description": description,
                    "severity": "error"
                })
            elif full_path.stat().st_size == 0:
                self.warnings.append({
                    "type": "empty_file",
                    "file": file_path,
                    "description": f"Empty file: {description}",
                    "severity": "warning"
                })
            else:
                self.checks.append({
                    "type": "file_exists",
                    "file": file_path,
                    "description": f"✅ {description}",
                    "status": "passed"
                })
    
    def check_directory_structure(self):
        """Check that required directories exist."""
        required_dirs = [
            ("system", "Core system directory"),
            ("system/principles", "Principles directory"),
            ("system/personalities", "Personalities directory"),
            ("system/processes", "Processes directory"),
            ("system/standards", "Standards directory"),
            ("system/examples", "Examples directory"),
            ("hooks", "Hooks directory"),
            ("operations", "Operations directory")
        ]
        
        for dir_path, description in required_dirs:
            full_path = self.framework_root / dir_path
            
            if not full_path.exists():
                self.warnings.append({
                    "type": "missing_directory",
                    "directory": dir_path,
                    "description": f"Missing directory: {description}",
                    "severity": "warning"
                })
            elif not full_path.is_dir():
                self.errors.append({
                    "type": "not_directory",
                    "path": dir_path,
                    "description": f"Path exists but is not a directory: {description}",
                    "severity": "error"
                })
            else:
                self.checks.append({
                    "type": "directory_exists",
                    "directory": dir_path,
                    "description": f"✅ {description}",
                    "status": "passed"
                })
    
    def check_hooks_health(self):
        """Check hook files and their configuration."""
        if not self.hooks_root.exists():
            self.errors.append({
                "type": "missing_hooks",
                "description": "Hooks directory does not exist",
                "severity": "error"
            })
            return
        
        # Check for essential hook files
        essential_hooks = [
            "session_start.py",
            "user_prompt_submit.py", 
            "pre_tool_use.py",
            "post_tool_use.py"
        ]
        
        for hook_file in essential_hooks:
            hook_path = self.hooks_root / hook_file
            
            if not hook_path.exists():
                self.warnings.append({
                    "type": "missing_hook",
                    "hook": hook_file,
                    "description": f"Missing hook file: {hook_file}",
                    "severity": "warning"
                })
            elif not os.access(hook_path, os.X_OK):
                self.warnings.append({
                    "type": "non_executable_hook",
                    "hook": hook_file,
                    "description": f"Hook file is not executable: {hook_file}",
                    "severity": "warning"
                })
            else:
                self.checks.append({
                    "type": "hook_ready",
                    "hook": hook_file,
                    "description": f"✅ Hook ready: {hook_file}",
                    "status": "passed"
                })
        
        # Check hook configuration
        config_file = self.hooks_root / "config.json"
        if config_file.exists():
            try:
                with open(config_file, 'r') as f:
                    json.load(f)
                self.checks.append({
                    "type": "config_valid",
                    "description": "✅ Hook configuration is valid JSON",
                    "status": "passed"
                })
            except json.JSONDecodeError as e:
                self.errors.append({
                    "type": "invalid_config",
                    "description": f"Hook configuration contains invalid JSON: {e}",
                    "severity": "error"
                })
    
    def check_file_permissions(self):
        """Check that files have correct permissions."""
        # Check hook executability
        hook_files = list(self.hooks_root.glob("*.py")) if self.hooks_root.exists() else []
        
        executable_hooks = 0
        for hook_file in hook_files:
            if os.access(hook_file, os.X_OK):
                executable_hooks += 1
            else:
                self.warnings.append({
                    "type": "permission_issue",
                    "file": str(hook_file.relative_to(self.framework_root)),
                    "description": f"Hook file is not executable: {hook_file.name}",
                    "severity": "warning"
                })
        
        if executable_hooks == len(hook_files) and hook_files:
            self.checks.append({
                "type": "permissions_correct",
                "description": f"✅ All {len(hook_files)} hook files are executable",
                "status": "passed"
            })
    
    def check_git_health(self):
        """Check git repository health."""
        try:
            os.chdir(self.framework_root)
            
            # Check if it's a git repository
            result = subprocess.run(['git', 'rev-parse', '--git-dir'], 
                                  capture_output=True, text=True, timeout=10)
            
            if result.returncode != 0:
                self.warnings.append({
                    "type": "not_git_repo",
                    "description": "Framework directory is not a git repository",
                    "severity": "warning"
                })
                return
            
            # Check git status
            status_result = subprocess.run(['git', 'status', '--porcelain'], 
                                         capture_output=True, text=True, timeout=10)
            
            if status_result.returncode == 0:
                changes = len(status_result.stdout.strip().split('\n')) if status_result.stdout.strip() else 0
                
                if changes == 0:
                    self.checks.append({
                        "type": "git_clean",
                        "description": "✅ Git working directory is clean",
                        "status": "passed"
                    })
                elif changes <= 5:
                    self.warnings.append({
                        "type": "git_changes",
                        "description": f"Git has {changes} uncommitted changes",
                        "severity": "info"
                    })
                else:
                    self.warnings.append({
                        "type": "many_git_changes",
                        "description": f"Git has many uncommitted changes ({changes})",
                        "severity": "warning"
                    })
            
            # Check for recent commits
            log_result = subprocess.run(['git', 'log', '--oneline', '-1'], 
                                      capture_output=True, text=True, timeout=10)
            
            if log_result.returncode == 0 and log_result.stdout.strip():
                self.checks.append({
                    "type": "git_active",
                    "description": "✅ Git repository shows recent activity",
                    "status": "passed"
                })
        
        except subprocess.TimeoutExpired:
            self.warnings.append({
                "type": "git_timeout",
                "description": "Git commands timed out",
                "severity": "warning"
            })
        except Exception as e:
            self.warnings.append({
                "type": "git_error",
                "description": f"Git health check failed: {e}",
                "severity": "warning"
            })
    
    def check_framework_consistency(self):
        """Check framework internal consistency."""
        # Check that indices match actual files
        self.check_index_consistency()
        
        # Check for broken internal links
        self.check_internal_links()
        
        # Check naming conventions
        self.check_naming_conventions()
    
    def check_index_consistency(self):
        """Check that index files match actual directory contents."""
        # Check system index
        system_index = self.system_root / "INDEX.md"
        if system_index.exists():
            try:
                content = system_index.read_text()
                
                # Check if referenced files exist
                import re
                links = re.findall(r'\[([^\]]+)\]\(([^)]+)\)', content)
                
                broken_links = 0
                for link_text, link_path in links:
                    # Handle relative paths
                    if not link_path.startswith('http') and not link_path.startswith('#'):
                        full_link_path = self.system_root / link_path
                        if not full_link_path.exists():
                            broken_links += 1
                
                if broken_links == 0:
                    self.checks.append({
                        "type": "index_consistent",
                        "description": "✅ System index links are consistent",
                        "status": "passed"
                    })
                else:
                    self.warnings.append({
                        "type": "broken_index_links",
                        "description": f"System index has {broken_links} broken links",
                        "severity": "warning"
                    })
            
            except Exception as e:
                self.warnings.append({
                    "type": "index_check_failed",
                    "description": f"Could not check index consistency: {e}",
                    "severity": "warning"
                })
    
    def check_internal_links(self):
        """Check for broken internal links in markdown files."""
        markdown_files = list(self.framework_root.rglob("*.md"))
        broken_links_total = 0
        
        for md_file in markdown_files[:10]:  # Limit to avoid too much processing
            try:
                content = md_file.read_text()
                import re
                
                # Find markdown links
                links = re.findall(r'\[([^\]]+)\]\(([^)]+)\)', content)
                
                for link_text, link_path in links:
                    if not link_path.startswith('http') and not link_path.startswith('#'):
                        # Resolve relative to file location
                        full_link_path = (md_file.parent / link_path).resolve()
                        if not full_link_path.exists():
                            broken_links_total += 1
            
            except Exception:
                continue
        
        if broken_links_total == 0:
            self.checks.append({
                "type": "links_healthy",
                "description": "✅ Internal links appear healthy",
                "status": "passed"
            })
        elif broken_links_total <= 3:
            self.warnings.append({
                "type": "some_broken_links",
                "description": f"Found {broken_links_total} potentially broken internal links",
                "severity": "info"
            })
        else:
            self.warnings.append({
                "type": "many_broken_links", 
                "description": f"Found {broken_links_total} potentially broken internal links",
                "severity": "warning"
            })
    
    def check_naming_conventions(self):
        """Check that files follow naming conventions."""
        # Check that directories use lowercase with hyphens
        # Check that markdown files use appropriate naming
        
        convention_violations = 0
        
        for path in self.framework_root.rglob("*"):
            if path.is_dir() and path != self.framework_root:
                name = path.name
                if name.isupper() or ' ' in name:
                    convention_violations += 1
        
        if convention_violations == 0:
            self.checks.append({
                "type": "naming_consistent",
                "description": "✅ Naming conventions are followed",
                "status": "passed"
            })
        else:
            self.warnings.append({
                "type": "naming_violations",
                "description": f"Found {convention_violations} naming convention violations",
                "severity": "info"
            })
    
    def check_performance_issues(self):
        """Check for potential performance issues."""
        # Check for very large files
        large_files = []
        
        for file_path in self.framework_root.rglob("*"):
            if file_path.is_file():
                size_mb = file_path.stat().st_size / (1024 * 1024)
                if size_mb > 10:  # Files larger than 10MB
                    large_files.append((file_path.name, size_mb))
        
        if large_files:
            self.warnings.append({
                "type": "large_files",
                "description": f"Found {len(large_files)} files larger than 10MB",
                "files": large_files,
                "severity": "info"
            })
        else:
            self.checks.append({
                "type": "file_sizes_reasonable",
                "description": "✅ No unusually large files detected",
                "status": "passed"
            })
        
        # Check total framework size
        total_size = sum(f.stat().st_size for f in self.framework_root.rglob("*") if f.is_file())
        total_size_mb = total_size / (1024 * 1024)
        
        if total_size_mb > 100:  # Framework larger than 100MB
            self.warnings.append({
                "type": "framework_size_large",
                "description": f"Framework size is large: {total_size_mb:.1f}MB",
                "severity": "info"
            })
        else:
            self.checks.append({
                "type": "framework_size_reasonable",
                "description": f"✅ Framework size is reasonable: {total_size_mb:.1f}MB",
                "status": "passed"
            })
    
    def calculate_health_score(self) -> float:
        """Calculate overall health score."""
        total_checks = len(self.checks) + len(self.warnings) + len(self.errors)
        
        if total_checks == 0:
            return 0.0
        
        # Weight: passed checks = 100%, warnings = 50%, errors = 0%
        score = (len(self.checks) * 100 + len(self.warnings) * 50) / total_checks
        return round(score, 1)
    
    def get_overall_status(self, health_score: float) -> str:
        """Get overall status based on health score."""
        if health_score >= 90:
            return "excellent"
        elif health_score >= 80:
            return "good"
        elif health_score >= 70:
            return "fair"
        elif health_score >= 50:
            return "poor"
        else:
            return "critical"
    
    def generate_recommendations(self) -> List[Dict[str, str]]:
        """Generate recommendations based on findings."""
        recommendations = []
        
        if self.errors:
            recommendations.append({
                "priority": "high",
                "action": "Fix Critical Issues",
                "description": f"Address {len(self.errors)} critical errors that could prevent framework operation"
            })
        
        if len(self.warnings) > 5:
            recommendations.append({
                "priority": "medium",
                "action": "Address Warnings",
                "description": f"Review and fix {len(self.warnings)} warnings to improve framework health"
            })
        
        # Check for specific patterns
        missing_hooks = [e for e in self.errors + self.warnings if e.get("type") == "missing_hook"]
        if missing_hooks:
            recommendations.append({
                "priority": "medium",
                "action": "Restore Missing Hooks",
                "description": "Some hook files are missing which may impact automation"
            })
        
        permission_issues = [e for e in self.warnings if e.get("type") == "permission_issue"]
        if permission_issues:
            recommendations.append({
                "priority": "low",
                "action": "Fix File Permissions",
                "description": "Run 'chmod +x /Users/nalve/.claude/hooks/*.py' to fix hook permissions"
            })
        
        if not recommendations:
            recommendations.append({
                "priority": "low",
                "action": "Maintain Excellence",
                "description": "Framework health is excellent. Continue regular monitoring."
            })
        
        return recommendations
    
    def print_report(self, report: Dict[str, Any]):
        """Print a formatted health check report."""
        print(f"\n🏥 Claude Framework Health Report")
        print(f"{'=' * 50}")
        print(f"Overall Health Score: {report['health_score']}% ({report['status'].title()})")
        print(f"Timestamp: {report['timestamp']}")
        print(f"\n📊 Summary:")
        print(f"  ✅ Checks Passed: {report['checks_passed']}")
        print(f"  ⚠️  Warnings: {report['warnings']}")
        print(f"  ❌ Errors: {report['errors']}")
        
        if report['details']['errors']:
            print(f"\n❌ Critical Issues:")
            for error in report['details']['errors'][:5]:
                print(f"  • {error['description']}")
        
        if report['details']['warnings']:
            print(f"\n⚠️  Warnings:")
            for warning in report['details']['warnings'][:5]:
                print(f"  • {warning['description']}")
        
        print(f"\n🎯 Recommendations:")
        for rec in report['recommendations']:
            priority_icon = "🔴" if rec['priority'] == 'high' else "🟡" if rec['priority'] == 'medium' else "🟢"
            print(f"  {priority_icon} {rec['action']}: {rec['description']}")
        
        print(f"\n✅ Recent Successes:")
        for check in report['details']['checks'][-3:]:
            print(f"  • {check['description']}")

def main():
    """Main function to run health check."""
    checker = FrameworkHealthChecker()
    report = checker.run_all_checks()
    
    # Print report to console
    checker.print_report(report)
    
    # Save report to file
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    report_file = f"/Users/nalve/.claude/system/dashboard/data/health_report_{timestamp}.json"
    
    os.makedirs(os.path.dirname(report_file), exist_ok=True)
    
    with open(report_file, 'w') as f:
        json.dump(report, f, indent=2, default=str)
    
    print(f"\n💾 Full report saved to: {report_file}")
    
    # Return exit code based on health
    if report['errors'] > 0:
        exit(2)  # Critical errors
    elif report['warnings'] > 10:
        exit(1)  # Many warnings
    else:
        exit(0)  # Healthy

if __name__ == "__main__":
    main()