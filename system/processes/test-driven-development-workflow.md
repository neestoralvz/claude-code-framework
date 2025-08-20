[🏠 System Hub](../INDEX.md) | [📁 Parent Directory](./) | [📖 Current Section](#)

---

# Test Driven Development Workflow

**Context**: Workflow process defining procedural steps and execution patterns


How to implement TDD systematically for reliable, well-designed code.

## Start with Requirements

Begin by understanding exactly what behavior you want to implement. Break it down into small, testable pieces. Write out what success looks like in clear, measurable terms.

## Write the Failing Test

Create a test that describes the behavior you want. Make it as specific as possible about inputs, outputs, and expected behavior. Run the test to confirm it fails for the right reason.

## Implement Minimal Code

Write just enough code to make the test pass. Don't worry about perfect design yet - focus on getting to green as quickly as possible. Avoid adding functionality not covered by tests.

## Verify Test Passes

Run your test to confirm it now passes. If it doesn't, debug why and fix either the test or the implementation. Only move forward when you have a passing test.

## Refactor with Confidence

Now improve the code structure, naming, and design while keeping the test passing. Run the test frequently during refactoring to catch any regressions immediately.

## Repeat the Cycle

Move to the next piece of functionality and repeat: Red (failing test), Green (minimal code), Refactor (improve design). Each cycle should be small and focused.

---
**Navigation:** [↑ System Home](../INDEX.md)
