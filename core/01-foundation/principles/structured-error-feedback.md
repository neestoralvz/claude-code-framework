
---

**IF reading individually** → READ [PRINCIPLES.md](../PRINCIPLES.md#work-approach) for context, THEN navigate to this specific principle


# Structured Error Feedback

**Context**: Fundamental principle defining framework behavior and decision-making


Provide clear, actionable error messages that tell users exactly what went wrong and how to fix it.

## Why This Matters

Generic error messages waste time and frustrate users. Structured errors with specific details help people understand problems quickly and know exactly what to change.

## How to Apply

Include the specific field that failed, the value that was problematic, what was expected instead, and suggestions for fixing it. Structure error information consistently so tools can process it automatically.

## Real Examples

Pydantic validation errors show the exact field path, the invalid value, the expected type, and an error code. This makes it easy to programmatically handle errors or display helpful messages to users.

## Error Structure

Good errors include location, actual value, expected value, error type, and human readable message. This allows both humans and systems to understand and respond appropriately.

---
