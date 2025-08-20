[🏠 System Hub](../INDEX.md) | [📁 Parent Directory](./) | [📖 Current Section](#)

---

# Event Driven Workflows

**Context**: Fundamental principle defining framework behavior and decision-making


Design workflows that respond to events rather than running on fixed schedules.

## Why This Matters

Event driven workflows are more responsive and efficient. They react to what actually happens instead of checking constantly or running when nothing needs to be done.

## How to Apply

Set up your workflows to listen for specific events like file changes, user actions, or system status updates. Use webhooks, message queues, or event systems to trigger workflows when something meaningful happens.

## Real Examples

Workflows-py uses async event handling to control workflow execution. GitHub Actions trigger on code pushes or pull requests. Prefect can trigger flows based on external events or completion of other flows.

## Key Pattern

Instead of scheduling a workflow to run every hour to check for new files, set up a file watcher that triggers the workflow immediately when files arrive.

---
**Navigation:** [↑ System Home](../INDEX.md)
