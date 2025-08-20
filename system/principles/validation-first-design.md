[🏠 System Hub](../INDEX.md) | [📁 Parent Directory](./) | [📖 Current Section](#)

---

# Validation First Design

**Context**: Fundamental principle defining framework behavior and decision-making


Always validate inputs and outputs before processing them.

## Why This Matters

Data corruption and unexpected errors happen when we skip validation. By validating first, we catch problems early and provide clear feedback about what went wrong.

## How to Apply

Validate all inputs immediately when they arrive in your system. Use structured validation that gives specific error messages. Check outputs before sending them along to make sure they meet expectations.

## Real Examples

Pydantic models validate data as soon as it arrives and tell you exactly which field has problems. Prefect flows validate parameters before starting workflow execution. Our todo system validates that tasks have proper status values.

## When Not to Skip

Never skip validation for external data, user inputs, or data crossing system boundaries. Always validate when the cost of bad data is higher than the cost of validation.

---
**Navigation:** [↑ System Home](../INDEX.md)
