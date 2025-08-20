
---

**IF reading individually** → READ [EXAMPLES.md](../EXAMPLES.md#implementation-examples) for context, THEN navigate to this specific example


# Automation Decision Example

**Context**: Practical example demonstrating framework implementation patterns


Real example of choosing automation over manual work for systematic tasks.

## The Problem
Manual breadcrumb navigation was added to all files, creating maintenance overhead and violating our clean content standard.

## Manual Approach Considered
Edit each file individually to remove breadcrumb patterns. Problems with this approach:
- 20+ files to modify
- Identical pattern removal in each
- High risk of missing files or being inconsistent
- Would need repeating if breadcrumbs got added again

## Automation Solution
Created Python script using Robocorp automation framework to:
- Find all markdown files systematically
- Remove breadcrumb patterns with regex
- Remove navigation sections automatically  
- Process all files consistently
- Provide clear completion report

## Results
- All files processed in seconds instead of manual hours
- Zero risk of missed files or inconsistency
- Reusable for future similar cleanup tasks
- Demonstrates our automation principles in practice

## Key Learning
When you find yourself doing repetitive identical edits, stop and automate instead.

---

