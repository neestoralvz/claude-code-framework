# Development Workflow
**Context**: Comprehensive development methodology integrating TDD/BDD, quality standards, and systematic validation
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


## When To Use
- Development work (coding, implementation)
- Building new features or functionality
- Code quality assurance and validation
- Test-driven development scenarios

## Test Driven Development
Proven effective approach - write tests first, then implement to pass them - significantly improves development quality and design.

## Research Before Acting
Always research current best practices and gather evidence before implementing solutions - leads to better decisions and reusable knowledge.

## Document Research Findings
Capture research results systematically so knowledge builds over time rather than being rediscovered repeatedly.

## Development Process

### 1. Discovery and Planning
Before implementing any feature, initiate exploratory dialogue to define requirements:
1. **Exploratory Dialogue** - Interactive conversation to understand real needs and context
2. **Feature Definition** - What exactly needs to be built, why, and what success looks like
3. **Technical Planning** - Architecture, technology choices, implementation approach
4. **Documentation Capture** - Record entire discovery process and decisions
5. **Implementation Roadmap** - Clear execution plan with measurable success criteria

This prevents solution assumption errors and ensures we build what's actually needed.

### 2. Test-First Implementation
- Write tests first that define expected behavior
- Implement minimal code to pass tests
- Refactor while maintaining test coverage
- Validate behavior meets requirements

### 3. Quality Validation
- Follow established coding standards and patterns
- Use available tools and libraries in codebase
- Maintain consistency with existing patterns
- Document approach and decisions

### 4. Script-Based Success Metrics
Use automated scripts for validation and evidence-based measurement of success criteria rather than subjective assessment.

## Development Standards

### Code Organization
- Edit existing files before creating new ones
- Follow established patterns and conventions
- Use existing libraries and utilities
- Maintain clean, organized code structure

### Testing Standards
- READ system/processes/test-driven-development-workflow.md for detailed TDD methodology
- READ system/processes/behavior-driven-development-workflow.md for user-focused behavior validation
- Comprehensive test coverage for new functionality
- Integration tests for system behavior validation

### Quality Assurance
- Follow framework principles and standards
- Validate against established quality criteria
- Use automated validation tools when available
- Document quality decisions and trade-offs

## Time-Agnostic Planning
Never use time-based objectives, metrics, or roadmaps when planning. Use milestone-based progression: "After completing X capability, Y becomes possible" rather than "Complete X by date Y". Focus on outcome achievement and capability dependencies, not calendar compliance.

## Related Documentation
When doing development work, READ these files as needed:
- **TDD Process**: READ system/processes/test-driven-development-workflow.md for systematic TDD implementation
- **BDD Process**: READ system/processes/behavior-driven-development-workflow.md for behavior validation
- **Quality Standards**: READ system/STANDARDS.md for technical and content standards
