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

**MANDATORY**: Deploy testing-strategy-specialist for all TDD activities. Never attempt direct test writing or implementation.

Proven effective approach - deploy agents to write tests first, then deploy implementation agents to pass them - significantly improves development quality and design.

## Research Before Acting

**Deploy research-specialist** to investigate current best practices and gather evidence before implementation. Agent deployment leads to better decisions and reusable knowledge.

## Document Research Findings

**Deploy documentation-specialist** to capture research results systematically so knowledge builds over time rather than being rediscovered repeatedly.

## Development Process

### 1. Discovery and Planning

**Deploy requirements-analysis-specialist** to initiate exploratory dialogue and define requirements:

**Agent Instructions**: "Conduct discovery for [feature] including:
1. Exploratory Dialogue - Understand real needs and context
2. Feature Definition - Define what needs to be built, why, and success criteria
3. Technical Planning - Determine architecture and implementation approach
4. Documentation Capture - Record discovery process and decisions
5. Implementation Roadmap - Create execution plan with measurable criteria"

This prevents solution assumption errors and ensures we build what's actually needed.

### 2. Test-First Implementation

**Deploy testing-strategy-specialist** to coordinate TDD cycle:

**Agent Instructions**: "Implement [feature] using TDD methodology:
- Write tests first that define expected behavior
- Deploy implementation-specialist for minimal code to pass tests
- Deploy code-quality-specialist to refactor while maintaining coverage
- Deploy validation-specialist to validate behavior meets requirements"

### 3. Quality Validation

**Deploy code-quality-specialist** for comprehensive quality assurance:

**Agent Instructions**: "Validate [feature] quality by:
- Following established coding standards and patterns
- Using available tools and libraries in codebase
- Maintaining consistency with existing patterns
- Documenting approach and decisions"

### 4. Script-Based Success Metrics

**Deploy metrics-specialist** to create and run validation scripts:

**Agent Instructions**: "Create automated validation scripts for [feature] to provide evidence-based measurement of success criteria rather than subjective assessment."

## Development Standards

### Code Organization
- Edit existing files before creating new ones
- Follow established patterns and conventions
- Use existing libraries and utilities
- Maintain clean, organized code structure

### Testing Standards

**Deploy testing-strategy-specialist** to implement comprehensive testing:

**Agent Instructions**: "Implement testing standards for [feature]:
- Follow TDD methodology from test-driven-development-workflow.md
- Apply BDD for user-focused validation from behavior-driven-development-workflow.md
- Ensure comprehensive test coverage for new functionality
- Create integration tests for system behavior validation"

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
