#!/usr/bin/env python3
import subprocess
import os

print("=== TDD RED PHASE EXECUTION ===")

print("\n1. Bash Syntax Check:")
result = subprocess.run(
    ["bash", "-n", "/Users/nalve/.claude/system/dashboard/start_dashboard.sh"],
    capture_output=True, text=True
)
print(f"Return code: {result.returncode}")
if result.stderr:
    print(f"STDERR: {result.stderr}")
    
print("\n2. Python Import Check:")
os.chdir("/Users/nalve/.claude/system/dashboard/scripts")
result = subprocess.run([
    "python3", "-c", 
    "import dashboard_api; print('Import successful')"
], capture_output=True, text=True)
print(f"Return code: {result.returncode}")
print(f"STDOUT: {result.stdout.strip()}")
if result.stderr:
    print(f"STDERR: {result.stderr}")

print("\nRED phase tests complete. Proceeding to GREEN phase fixes...")