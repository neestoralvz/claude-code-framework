#!/usr/bin/env python3
"""
Simple hook validation test
"""

import os
import sys
from pathlib import Path

def main():
    hooks_dir = Path("/Users/nalve/.claude/hooks")
    
    print("CLAUDE CODE HOOKS VALIDATION")
    print("=" * 40)
    
    # 1. Check if hooks directory exists
    if not hooks_dir.exists():
        print(f"✗ Hooks directory not found: {hooks_dir}")
        return False
    
    print(f"✓ Hooks directory found: {hooks_dir}")
    
    # 2. Check for required hook files
    required_hooks = [
        "session_start.py",
        "user_prompt_submit.py", 
        "pre_tool_use.py",
        "post_tool_use.py"
    ]
    
    print("\nHOOK FILES:")
    print("-" * 20)
    
    missing_hooks = []
    for hook_file in required_hooks:
        hook_path = hooks_dir / hook_file
        if hook_path.exists():
            size = hook_path.stat().st_size
            print(f"✓ {hook_file} ({size} bytes)")
        else:
            print(f"✗ {hook_file} - MISSING")
            missing_hooks.append(hook_file)
    
    if missing_hooks:
        print(f"\nMissing hooks: {', '.join(missing_hooks)}")
        return False
    
    # 3. Check syntax for each hook
    print("\nSYNTAX VALIDATION:")
    print("-" * 20)
    
    syntax_errors = []
    for hook_file in required_hooks:
        hook_path = hooks_dir / hook_file
        try:
            with open(hook_path, 'r') as f:
                code = f.read()
            compile(code, str(hook_path), 'exec')
            print(f"✓ {hook_file} - Syntax OK")
        except SyntaxError as e:
            print(f"✗ {hook_file} - Syntax Error: {e}")
            syntax_errors.append((hook_file, str(e)))
        except Exception as e:
            print(f"✗ {hook_file} - Error: {e}")
            syntax_errors.append((hook_file, str(e)))
    
    if syntax_errors:
        print(f"\nSyntax errors found in {len(syntax_errors)} files")
        return False
    
    # 4. Check executable permissions
    print("\nPERMISSIONS:")
    print("-" * 20)
    
    permission_issues = []
    for hook_file in required_hooks:
        hook_path = hooks_dir / hook_file
        if os.access(hook_path, os.X_OK):
            print(f"✓ {hook_file} - Executable")
        else:
            print(f"✗ {hook_file} - Not executable")
            permission_issues.append(hook_file)
    
    # 5. Check PEP 723 compliance
    print("\nPEP 723 COMPLIANCE:")
    print("-" * 20)
    
    pep723_issues = []
    for hook_file in required_hooks:
        hook_path = hooks_dir / hook_file
        try:
            with open(hook_path, 'r') as f:
                content = f.read()
            
            has_shebang = content.startswith('#!')
            has_script_block = '# /// script' in content
            has_dependencies = 'dependencies' in content
            
            if has_shebang and has_script_block and has_dependencies:
                print(f"✓ {hook_file} - PEP 723 compliant")
            else:
                missing = []
                if not has_shebang: missing.append("shebang")
                if not has_script_block: missing.append("script block")  
                if not has_dependencies: missing.append("dependencies")
                print(f"✗ {hook_file} - Missing: {', '.join(missing)}")
                pep723_issues.append((hook_file, missing))
                
        except Exception as e:
            print(f"✗ {hook_file} - Error checking: {e}")
            pep723_issues.append((hook_file, [str(e)]))
    
    # Summary
    print("\n" + "=" * 40)
    print("VALIDATION SUMMARY")
    print("=" * 40)
    
    all_good = not (missing_hooks or syntax_errors or pep723_issues)
    
    if all_good:
        print("✓ All hooks are properly implemented and ready for use!")
        if permission_issues:
            print(f"\nNote: {len(permission_issues)} files need executable permissions")
            print("Run: chmod +x /Users/nalve/.claude/hooks/*.py")
    else:
        print("✗ Issues found that need to be addressed:")
        if missing_hooks:
            print(f"  - {len(missing_hooks)} missing hook files")
        if syntax_errors:
            print(f"  - {len(syntax_errors)} syntax errors")
        if pep723_issues:
            print(f"  - {len(pep723_issues)} PEP 723 compliance issues")
    
    return all_good

if __name__ == "__main__":
    success = main()
    print(f"\nValidation {'PASSED' if success else 'FAILED'}")
    sys.exit(0 if success else 1)