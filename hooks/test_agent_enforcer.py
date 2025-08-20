#!/usr/bin/env python3
"""
Test script for user_prompt_agent_enforcer.py hook
"""

import json
import subprocess
import sys
from pathlib import Path


def test_hook(prompt: str, expected_enforcement: bool = True) -> bool:
    """
    Test the hook with a given prompt.
    
    Args:
        prompt: The test prompt
        expected_enforcement: Whether enforcement should be applied
        
    Returns:
        bool: True if test passes
    """
    # Prepare test data
    test_data = {"prompt": prompt}
    input_json = json.dumps(test_data)
    
    # Get hook script path
    hook_path = Path(__file__).parent / "user_prompt_agent_enforcer.py"
    
    try:
        # Run the hook
        result = subprocess.run(
            [sys.executable, str(hook_path)],
            input=input_json,
            text=True,
            capture_output=True,
            timeout=10
        )
        
        if result.returncode != 0:
            print(f"❌ Hook failed with exit code {result.returncode}")
            print(f"stderr: {result.stderr}")
            return False
        
        # Parse output
        try:
            output_data = json.loads(result.stdout)
        except json.JSONDecodeError:
            print(f"❌ Invalid JSON output: {result.stdout}")
            return False
        
        # Check enforcement
        enforcement_applied = output_data.get("metadata", {}).get("agent_enforcement_applied", False)
        
        if expected_enforcement and not enforcement_applied:
            print(f"❌ Expected enforcement but it wasn't applied")
            print(f"Input: {prompt}")
            print(f"Output: {output_data.get('prompt', '')}")
            return False
        
        if not expected_enforcement and enforcement_applied:
            print(f"❌ Unexpected enforcement applied")
            print(f"Input: {prompt}")
            return False
        
        if expected_enforcement:
            # Check if enforcement message is in the output
            output_prompt = output_data.get("prompt", "")
            if "MANDATORY: Must use Task tool" not in output_prompt:
                print(f"❌ Enforcement message not found in output")
                return False
        
        print(f"✅ Test passed: '{prompt[:50]}...' (enforcement={enforcement_applied})")
        return True
        
    except subprocess.TimeoutExpired:
        print(f"❌ Hook timed out")
        return False
    except Exception as e:
        print(f"❌ Test error: {e}")
        return False


def main():
    """Run all tests."""
    print("Testing user_prompt_agent_enforcer.py hook...")
    print("=" * 50)
    
    # Test cases that should trigger enforcement
    enforcement_tests = [
        "Crear una función para calcular la suma",
        "Implementar un algoritmo de búsqueda",
        "Generate a Python script for data processing",
        "Write code to handle API requests",
        "Build a React component",
        "Create a new service class",
        "Develop a machine learning model",
        "Make a database connection",
    ]
    
    # Test cases that should NOT trigger enforcement
    no_enforcement_tests = [
        "What is the difference between lists and tuples?",
        "Explain how async/await works",
        "Use Task tool with data-processing-agent to analyze the CSV",
        "Deploy agent for this specialized task",
        "How does the agent framework work?",
        "Can you help me understand this error message?",
        "What are the best practices for testing?",
    ]
    
    passed = 0
    total = 0
    
    print("\nTesting enforcement cases:")
    for prompt in enforcement_tests:
        total += 1
        if test_hook(prompt, expected_enforcement=True):
            passed += 1
    
    print("\nTesting non-enforcement cases:")
    for prompt in no_enforcement_tests:
        total += 1
        if test_hook(prompt, expected_enforcement=False):
            passed += 1
    
    print("\n" + "=" * 50)
    print(f"Results: {passed}/{total} tests passed")
    
    if passed == total:
        print("🎉 All tests passed!")
        return 0
    else:
        print("❌ Some tests failed!")
        return 1


if __name__ == "__main__":
    sys.exit(main())