#!/usr/bin/env python3
"""Manual test of the hook functionality"""

import json
import subprocess
import sys
from pathlib import Path

# Test the hook with sample data
test_cases = [
    {"prompt": "Crear una función que calcule la suma", "should_enforce": True},
    {"prompt": "Implement a sorting algorithm", "should_enforce": True},
    {"prompt": "What is Python?", "should_enforce": False},
    {"prompt": "Use Task tool with specialized agent", "should_enforce": False},
]

hook_path = Path(__file__).parent / "user_prompt_agent_enforcer.py"

for i, test_case in enumerate(test_cases, 1):
    print(f"\n--- Test Case {i} ---")
    print(f"Input: {test_case['prompt']}")
    print(f"Expected enforcement: {test_case['should_enforce']}")
    
    # Prepare input
    input_data = json.dumps({"prompt": test_case['prompt']})
    
    try:
        # Run hook
        result = subprocess.run(
            [sys.executable, str(hook_path)],
            input=input_data,
            text=True,
            capture_output=True,
            timeout=5
        )
        
        print(f"Exit code: {result.returncode}")
        
        if result.returncode == 0:
            try:
                output = json.loads(result.stdout)
                enforcement_applied = output.get("metadata", {}).get("agent_enforcement_applied", False)
                print(f"Enforcement applied: {enforcement_applied}")
                
                if enforcement_applied:
                    print("Output prompt preview:")
                    print(output.get("prompt", "")[:200] + "...")
                
                # Check if expectation matches
                if enforcement_applied == test_case['should_enforce']:
                    print("✅ PASS")
                else:
                    print("❌ FAIL - Enforcement mismatch")
                    
            except json.JSONDecodeError:
                print(f"❌ FAIL - Invalid JSON output")
                print(f"stdout: {result.stdout}")
        else:
            print(f"❌ FAIL - Hook failed")
            print(f"stderr: {result.stderr}")
            
    except Exception as e:
        print(f"❌ FAIL - Exception: {e}")

print("\n--- Manual Test Complete ---")