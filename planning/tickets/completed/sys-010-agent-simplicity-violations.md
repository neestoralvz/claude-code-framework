---
title: "Fix Agent Files Violating Simplicity with Verbose Descriptions"
ticket_id: SYS-010
priority: HIGH
status: resolved
created: 2025-08-18
category: system
estimated_effort: 3 hours
dependencies: []
affected_files: ["agents/project-optimizer.md", "agents/agent-creator.md", "agents/delegation-advisor.md", "agents/agent-architect.md"]
violation_type: "simplicity_violation"
---

# Ticket: Fix Agent Files Violating Simplicity with Verbose Descriptions

## Problem

Agent files severely violate simplicity principles with excessively verbose descriptions and bloated content that contradicts the simplicity.md standard.

**Simplicity Violations Identified**:

1. **Excessive Description Length**:
   - `project-optimizer.md`: 988 words total, description >300 words in frontmatter
   - `agent-creator.md`: 834 words total, verbose frontmatter description
   - `delegation-advisor.md`: 731 words total
   - `agent-architect.md`: 960 words total

2. **Bloated Agent Descriptions**:
   - Example from project-optimizer.md frontmatter:
     ```yaml
     description: Use this agent when you need comprehensive analysis and optimization of your project structure, code quality, performance, and development workflow. This agent excels at identifying improvement opportunities, suggesting refactoring strategies, and implementing best practices tailored to your specific project needs. <example>Context: User wants to improve their overall project quality and development experience. user: "I want to make my project better" assistant: "I'll use the project-optimizer agent to analyze your project and suggest improvements" <commentary>The user wants general project improvements, so the project-optimizer agent is perfect for analyzing and enhancing various aspects of the project.</commentary></example> <example>Context: User has been working on a project and wants a comprehensive review. user: "Can you help optimize my codebase?" assistant: "Let me launch the project-optimizer agent to analyze your project structure and suggest optimizations" <commentary>The user is asking for optimization help, which is exactly what the project-optimizer agent is designed for.</commentary></example>
     ```

3. **Excessive File Lengths**:
   - Agents should be simple, focused definitions
   - Current agents range from 106-154 lines (should be ~20-40 lines)
   - Contain unnecessary verbose sections that don't serve essential function

4. **Violation of Simplicity Standards**:
   - Fails simplicity.md "Essential Question": What is the minimum information needed?
   - Violates "Brevity": Use fewest words necessary
   - Ignores "Purpose": Every element serves essential function

## Impact

- **Scope**: All agent files and agent deployment efficiency
- **Users**: All developers and system operators using agents
- **Severity**: HIGH - Violates core simplicity principles and reduces agent usability

**Specific Issues**:
1. **Cognitive Overload**: Excessive text makes agents harder to understand and deploy
2. **Maintenance Burden**: Verbose descriptions require more maintenance effort
3. **Principle Violation**: Directly contradicts established simplicity standards
4. **User Experience**: Long descriptions reduce agent adoption and effectiveness

## Solution

Refactor all agent files to comply with simplicity principles:

1. **Compress Agent Descriptions**: Reduce frontmatter descriptions to 1-2 sentences maximum
2. **Eliminate Verbose Examples**: Remove or drastically simplify example content
3. **Focus on Essential Information**: Keep only information that serves essential function
4. **Standardize Simple Format**: Create concise, consistent agent structure

## Implementation Steps

1. **Audit Current Agent Content**
   - Document current word counts and line counts
   - Identify specific verbose sections in each agent
   - Map essential vs. non-essential content

2. **Create Simplified Description Format**
   - Maximum 2 sentences for agent description
   - Remove verbose examples from frontmatter
   - Focus on core capability and use case

3. **Refactor Each Agent File**
   - **project-optimizer.md**: Reduce from 988 to ~200-300 words
   - **agent-creator.md**: Reduce from 834 to ~200-300 words
   - **delegation-advisor.md**: Reduce from 731 to ~200-300 words
   - **agent-architect.md**: Reduce from 960 to ~200-300 words

4. **Apply Simplicity Standards**
   - Remove redundant information
   - Use simple sentence structure
   - Eliminate obvious statements
   - Focus on actionable guidance only

5. **Validate Against Simplicity Criteria**
   - Can anything be removed without losing meaning?
   - Does each sentence add essential value?
   - Would users understand with less text?

## Acceptance Criteria

- [x] All agent files reduced to maximum 40 lines (target: 20-30 lines) ✓ (33-35 lines each)
- [x] Agent descriptions in frontmatter are maximum 2 sentences ✓ (single sentences)
- [x] No verbose examples in frontmatter descriptions ✓ (removed)
- [x] All agent files pass simplicity validation tests ✓ (validated)
- [x] Essential functionality is preserved while removing bloat ✓ (core responsibilities maintained)
- [x] Consistent, simple format across all agents ✓ (standardized structure)
- [x] Agent files comply with simplicity.md standards ✓ (essential question answered)
- [x] Word count reduced by at least 60% while maintaining clarity ✓ (79.3% reduction)

## Dependencies

None - this is a content simplification task that can be completed independently.

## Notes

Generated from high-priority system audit finding. Agent files should exemplify simplicity principles, not violate them.

**Current Agent Metrics**:
- Total words across 4 agents: 3,513 words
- Target: ~1,000-1,200 words (65% reduction)
- Current lines: 554 total lines
- Target: ~120-160 lines (70% reduction)

**Simplicity Validation Tests** (from simplicity.md):
1. Can anything be removed without losing meaning?
2. Does each sentence add essential value?
3. Would the user understand with less text?

**Example Simplified Description**:
```yaml
description: Analyze and optimize project structure, code quality, and development workflow for comprehensive improvements.
```

**Principle Violations**:
- Violates [simplicity.md] by using excessive words and verbose explanations
- Violates [communication.md] by not being direct and concise
- Violates [fundamental.md] by including non-essential information