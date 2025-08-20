
---

**IF reading individually** → READ [PRINCIPLES.md](../PRINCIPLES.md#work-approach) for context, THEN navigate to this specific principle


# Test Driven Development

**Context**: Fundamental principle defining framework behavior and decision-making


Write tests first, then implement code to make them pass.

## Why This Works

Writing tests first forces you to think about what you want the code to do before you write it. This leads to better design, clearer requirements, and more reliable code. Tests become your specification and safety net.

## How to Apply

Start by writing a failing test that describes the behavior you want. Run it to confirm it fails. Then write the minimal code needed to make the test pass. Run the test again to confirm it passes. Finally, refactor the code while keeping tests passing.

## Red Green Refactor Cycle

Red - Write a failing test that captures your intent. Green - Write the simplest code that makes the test pass. Refactor - Improve the code structure while maintaining passing tests.

## Benefits Proven in Practice

Better code design because you think about interfaces first. Fewer bugs because behavior is specified and verified. Easier refactoring because tests catch regressions. More confidence when making changes.

## Key Patterns

Use descriptive test names that explain the expected behavior. Keep tests simple and focused on one behavior. Use fixtures for test setup and teardown. Group related tests in classes with descriptive names.

---
