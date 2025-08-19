---
title: "Link Validation Tools Component"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../../principles/formatting.md", "link-format-standards.md"]
prerequisites: ["Understanding of link format standards", "Knowledge of validation principles"]
audience: "Developers and quality assurance teams"
purpose: "Provide automated tools and checklists for validating link standards compliance"
keywords: ["validation", "testing", "automation", "quality", "compliance"]
last_review: "2025-08-18"
---

[Previous: Study link-use-cases.md for context patterns](link-use-cases.md) | [Return to hub for navigation](../../index.md) | [Review PRINCIPLES.md for framework](../principles/PRINCIPLES.md) | [Next: Browse formatting standards](../formatting-standards.md)

# LINK VALIDATION TOOLS COMPONENT

## Table of Contents
- [Purpose](#purpose)
- [Architecture](#architecture)
- [Available Components](#available-components)
- [Usage Guidelines](#usage-guidelines)
- [Implementation Guide](#implementation-guide)
- [Benefits](#benefits)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Purpose

⏺ **Principle**: This component implements [formatting.md](../../principles/formatting.md) validation standards by providing automated tools and systematic checks for link compliance.

Provide comprehensive validation tools and checklists to ensure all links meet established standards.

## Validation Checklist

### Link Validation Checklist
- [ ] **Action Verb Present**: Link starts with imperative verb
- [ ] **Purpose Clear**: Reader understands objective
- [ ] **Path Functional**: Destination exists and is accessible
- [ ] **Anchor Tested**: Heading references work correctly
- [ ] **Context Appropriate**: Action matches content type
- [ ] **Grammar Correct**: Follows imperative communication standards

## Automated Testing

### Automated Link Testing Script
```bash
#!/bin/bash
# validate-links.sh

echo "🔍 Validating link standards..."

# Check for links without action verbs
echo "📝 Checking for action verbs..."
grep -r "\[.*\](" . --include="*.md" | while IFS= read -r line; do
    link_text=$(echo "$line" | sed 's/.*\[\([^]]*\)\].*/\1/')
    if [[ ! "$link_text" =~ ^(Read|Study|Apply|Execute|Deploy|Follow|Review|Browse|Navigate|Access|Configure|Implement|Validate|Monitor|Update|Create|Modify) ]]; then
        echo "⚠️  Missing action verb: $line"
    fi
done

# Check for vague link text
echo "📝 Checking for vague link text..."
grep -r "\[.*\](" . --include="*.md" | grep -E "\[(Click here|More|Info|Details|See|Link)\]" | while IFS= read -r line; do
    echo "❌ Vague link text: $line"
done

# Validate anchor references
echo "📝 Validating anchor references..."
grep -r "#[a-z0-9-]*" . --include="*.md" | while IFS= read -r line; do
    file=$(echo "$line" | cut -d: -f1)
    anchor=$(echo "$line" | grep -o "#[a-z0-9-]*" | head -1)
    target_file=$(echo "$line" | sed 's/.*(\([^)]*\)).*/\1/' | cut -d'#' -f1)
    
    if [ -f "$target_file" ]; then
        if ! grep -q "^#.*" "$target_file"; then
            echo "⚠️  Anchor not found: $anchor in $target_file"
        fi
    fi
done

echo "✅ Link validation complete"
```

### Usage Instructions
1. Save script as `validate-links.sh`
2. Make executable: `chmod +x validate-links.sh`
3. Run from project root: `./validate-links.sh`
4. Review output for violations
5. Fix identified issues
6. Re-run until clean

## Critical Rules

### Critical Validation Rule
**Every link must answer: "What do I do?" and "Why click here?"**

If a link doesn't clearly answer both questions, it violates the standard and must be revised.

### Common Violation Patterns
- Links without action verbs
- Vague text like "Click here" or "More info"
- Missing purpose context
- Broken anchor references
- Non-imperative communication

[⬆ Return to top](#link-validation-tools-component)

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../../index.md)
- [Study link-format-standards.md for format rules](link-format-standards.md)
- [Apply link-action-verbs.md for action standards](link-action-verbs.md)
- [Review link-use-cases.md for context patterns](link-use-cases.md)

### Related Principles
- [Apply formatting.md for validation requirements](../../principles/formatting.md)
- [Follow engineering.md for testing standards](../../principles/engineering.md)

[⬆ Return to top](#link-validation-tools-component)