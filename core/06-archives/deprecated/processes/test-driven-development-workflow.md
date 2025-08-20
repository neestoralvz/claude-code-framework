
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Test Driven Development Workflow

**Context**: Workflow process defining procedural steps and execution patterns


How to deploy specialized agents to implement TDD systematically for reliable, well-designed code.

**MANDATORY**: All TDD implementation must be done through specialized agent deployment. Never attempt direct implementation.

## Start with Requirements

**Deploy requirements-analysis-specialist** to understand exactly what behavior needs implementation. The agent will break it down into small, testable pieces and define success in clear, measurable terms.

**Agent Instructions**: "Analyze the requirements for [specific feature/function]. Break down into atomic, testable behaviors. Define clear success criteria for each behavior."

## Write the Failing Test

**Deploy testing-strategy-specialist** to create a test that describes the desired behavior. The agent will make it specific about inputs, outputs, and expected behavior, then verify it fails for the right reason.

**Agent Instructions**: "Write a failing test for [specific behavior]. Include specific inputs, expected outputs, and edge cases. Verify the test fails with the expected error message."

## Implement Minimal Code

**Deploy implementation-specialist** to write just enough code to make the test pass. The agent will focus on getting to green quickly without adding uncovered functionality.

**Agent Instructions**: "Implement minimal code to make the test [test name/description] pass. Do not add functionality beyond what the test requires. Focus on simplicity over perfection."

## Verify Test Passes

**Deploy validation-specialist** to run the test and confirm it passes. If it fails, deploy debugging-specialist to identify and fix issues in either the test or implementation.

**Agent Instructions**: "Run test [test name] and verify it passes. If it fails, analyze the failure reason and determine if the issue is in the test or implementation."

## Refactor with Confidence

**Deploy code-quality-specialist** to improve code structure, naming, and design while maintaining passing tests. The agent will run tests frequently during refactoring to catch regressions.

**Agent Instructions**: "Refactor [specific code/module] to improve structure and readability. Run tests after each change to ensure no regressions. Focus on clarity and maintainability."

## Repeat the Cycle

**Deploy strategic-orchestrator** to coordinate the next TDD cycle. The agent will manage the deployment of specialists for each phase: Red (failing test), Green (minimal code), Refactor (improve design).

**Agent Instructions**: "Coordinate the next TDD cycle for [next functionality]. Deploy appropriate specialists for each phase and ensure small, focused iterations."

---
