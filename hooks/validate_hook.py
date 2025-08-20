#!/usr/bin/env python3
"""Validation script for hook functionality"""

# Import the main functions from the hook to test them directly
import sys
from pathlib import Path

# Add the hooks directory to the path
hooks_dir = Path(__file__).parent
sys.path.insert(0, str(hooks_dir))

try:
    from user_prompt_agent_enforcer import (
        contains_implementation_request,
        should_enforce_agents,
        get_implementation_keywords
    )
    
    print("✅ Successfully imported hook functions")
    
    # Test keyword detection
    print("\n--- Testing keyword detection ---")
    test_prompts = [
        ("Crear una función", True),
        ("Implementar algoritmo", True), 
        ("Generate Python code", True),
        ("What is Python?", False),
        ("Use Task tool with agent", False),
        ("How does this work?", False),
    ]
    
    for prompt, expected in test_prompts:
        result = contains_implementation_request(prompt)
        status = "✅ PASS" if result == expected else "❌ FAIL"
        print(f"{status}: '{prompt}' -> {result} (expected {expected})")
    
    # Test enforcement logic
    print("\n--- Testing enforcement logic ---")
    test_data = [
        ({"prompt": "Crear una app"}, True),
        ({"prompt": "Use Task tool to create app"}, False),
        ({"prompt": "What is an agent?"}, False),
    ]
    
    for data, expected in test_data:
        result = should_enforce_agents(data)
        status = "✅ PASS" if result == expected else "❌ FAIL"
        print(f"{status}: '{data['prompt']}' -> {result} (expected {expected})")
    
    # Test keywords list
    keywords = get_implementation_keywords()
    print(f"\n--- Keywords loaded: {len(keywords)} total ---")
    print("Spanish keywords:", [k for k in keywords if k in ['crear', 'implementar', 'generar', 'desarrollar']])
    print("English keywords:", [k for k in keywords if k in ['create', 'implement', 'generate', 'develop']])
    
    print("\n🎉 All validation tests completed!")
    
except ImportError as e:
    print(f"❌ Failed to import hook functions: {e}")
except Exception as e:
    print(f"❌ Validation error: {e}")