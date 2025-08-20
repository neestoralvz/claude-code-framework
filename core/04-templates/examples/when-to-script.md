
---

**IF reading individually** → READ [EXAMPLES.md](../EXAMPLES.md#implementation-examples) for context, THEN navigate to this specific example


# When to Script

**Context**: Practical example demonstrating framework implementation patterns



Real example of recognizing when manual work should be automated.

## The Situation
We needed to remove breadcrumb navigation from all files in our system to keep content clean and maintainable.

## Initial Approach
Started editing files manually one by one.

## Recognition Point
Realized this was:
- Systematic pattern across many files
- Repetitive identical operations
- Error-prone when done manually
- Unsustainable for future changes

## Better Approach
Create script to handle systematic changes automatically.

## Decision Criteria
Use scripts when you have:
- More than 5 similar files to change
- Identical pattern to apply everywhere
- Risk of human error or inconsistency
- Need to repeat this operation later

## Key Insight
Recognize systematic tasks early and automate rather than manually grinding through them.

---
