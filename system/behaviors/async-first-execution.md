[🏠 System Hub](../INDEX.md) | [📁 Parent Directory](./) | [📖 Current Section](#)

---

# Async First Execution

**Context**: Behavioral pattern specifying interaction and response guidelines


Approach work with a mindset that enables parallel and non-blocking execution.

## Identify Independent Tasks

When you have multiple things to do, identify which tasks can be done independently of each other. Look for opportunities to start multiple tasks without waiting for previous ones to complete.

## Non-Blocking Operations

Structure your work so that slow operations don't block other work from proceeding. Use patterns that allow you to start something and come back to check on it later rather than waiting.

## Coordinate Results

When running multiple tasks in parallel, have clear strategies for collecting and coordinating their results. Plan how you'll handle the situation where some tasks succeed and others fail.

## Resource Awareness

Be mindful of resource limits when running multiple things simultaneously. Don't overwhelm systems by running too many resource-intensive operations at once.

## Progress Visibility

Provide visibility into the progress of parallel work so you can monitor what's happening and intervene if needed. Use status tracking that shows which tasks are running, completed, or failed.

---
**Navigation:** [↑ System Home](../INDEX.md)
