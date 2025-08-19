---
title: "Engineering Principles"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["fundamental.md", "forbidden.md", "organization.md", "workflow.md"]
prerequisites: ["Understanding of fundamental approach", "Knowledge of design principles"]
audience: "Developers and engineers"
purpose: "Define engineering design principles, standards, and methodologies"
keywords: ["engineering", "design", "standards", "methodologies", "patterns"]
last_review: "2025-08-18"
---

[Previous: Study fundamental.md for basic methodology](fundamental.md) | [Return to documentation hub for navigation](../index.md) | [Study PRINCIPLES.md for framework](../PRINCIPLES.md) | [Next: Study communication.md for writing standards](communication.md)

# ENGINEERING

## Table of Contents
- [Design Principles](#design-principles)
- [Complexity Management](#complexity-management)
- [Decision Frameworks](#decision-frameworks)
- [Simplicity Maintenance](#simplicity-maintenance)
- [Standards](#standards)
- [Methodologies](#methodologies)
- [Detection and Prevention](#detection-and-prevention)
- [Review Criteria](#review-criteria)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Design Principles

⏺ **Principle**: These principles implement [fundamental.md#simplicity](fundamental.md#simplicity) by maintaining minimal, effective solutions.

### Core Design Rules
- **Solve the actual problem**: Address real requirements, not imagined future needs
- **Start with the simplest solution**: Add complexity only when simple fails
- **Prefer composition over inheritance**: Build from simple, reusable parts
- **Optimize for readability**: Code is read 10x more than written
- **Write code, not frameworks**: Avoid creating unnecessary abstractions
- **Delete before adding**: Remove unused code before adding new features

### Anti-Patterns to Avoid
- Premature abstractions without proven need
- Gold-plating solutions beyond requirements
- Creating frameworks for single use cases
- Over-generalizing specific solutions
- Building for theoretical future requirements
- Adding layers without clear benefit

### Validation Questions
Before adding complexity, ask:
- Does this solve a current, real problem?
- Can the existing simple solution be improved instead?
- Will this abstraction be used in at least 3 places?
- Does this make the code easier to understand and maintain?

[⬆ Return to top](#engineering)

## Complexity Management

⏺ **Principle**: Complexity management follows [fundamental.md#simplicity](fundamental.md#simplicity) by establishing clear boundaries and budgets for system complexity.

### Complexity Budget Framework
Each system component has a complexity budget that must not be exceeded:

- **Single Function**: Maximum 20 lines, single responsibility
- **Single Class**: Maximum 200 lines, cohesive purpose
- **Single File**: Maximum 500 lines, related functionality
- **Single Module**: Maximum 10 files, clear interface
- **Single System**: Maximum 50 modules, well-defined boundaries

### Complexity Indicators
Monitor these warning signs of excessive complexity:

#### Code Metrics
- **Cyclomatic Complexity**: >10 indicates refactoring needed
- **Nesting Depth**: >3 levels suggests simplification needed
- **Parameter Count**: >5 parameters indicates interface problems
- **Class Dependencies**: >7 dependencies suggests tight coupling

#### System Metrics  
- **Build Time**: >2 minutes suggests architectural issues
- **Test Time**: >10 minutes indicates over-testing or slow tests
- **Onboarding Time**: >1 week suggests system complexity issues
- **Bug Fix Time**: >1 day suggests unclear code structure

### Complexity Reduction Strategies
When complexity exceeds budgets:

1. **Extract Methods**: Break large functions into smaller, named pieces
2. **Extract Classes**: Separate concerns into focused classes  
3. **Extract Modules**: Group related functionality into cohesive modules
4. **Simplify Interfaces**: Reduce parameter counts and return complexity
5. **Remove Abstractions**: Eliminate unnecessary layers and indirection
6. **Delete Unused Code**: Remove features and code paths no longer needed

### Decision Matrix for Complexity
Use this matrix to decide when complexity is justified:

| Benefit Type | Low Impact | Medium Impact | High Impact |
|--------------|------------|---------------|-------------|
| **Low Complexity** | Add | Add | Add |
| **Medium Complexity** | Skip | Consider | Add |
| **High Complexity** | Skip | Skip | Consider |

- **Low Complexity**: <10 lines, no new concepts, uses existing patterns
- **Medium Complexity**: 10-50 lines, 1 new concept, extends patterns  
- **High Complexity**: >50 lines, multiple concepts, new patterns required

[⬆ Return to top](#engineering)

## Decision Frameworks

⏺ **Principle**: Decision frameworks support [workflow.md#analysis](workflow.md#3-analysis) by providing systematic approaches to complexity trade-offs.

### The SIMPLE Framework
Before adding any complexity, apply this framework:

- **S**pecific: Does this solve a specific, current problem?
- **I**mmediate: Is this needed now, not hypothetically later?
- **M**easurable: Can we measure the benefit objectively?
- **P**ractical: Does this make daily work easier?
- **L**ean: Is this the minimum viable solution?
- **E**videnced: Do we have proof this approach works?

### Refactor vs Rebuild Decision Tree

```
Is the current solution broken? → YES → Refactor if <100 lines, Rebuild if >100 lines
                               ↓ NO
Is adding the feature complex? → YES → Consider rebuilding simpler
                               ↓ NO  
Will this change affect >3 files? → YES → Design review required
                                   ↓ NO
Proceed with simple addition
```

### Abstraction Threshold Rules
Create abstractions only when:

1. **Rule of Three**: Pattern appears in 3+ places
2. **Clear Interface**: Abstraction has obvious, stable interface
3. **Reduced Complexity**: Total system complexity decreases
4. **Team Understanding**: All team members understand the abstraction
5. **Maintenance Benefit**: Abstraction reduces long-term maintenance

### Technology Choice Framework
When choosing between technologies:

1. **Boring Technology**: Prefer well-established, team-familiar tools
2. **One New Thing**: Limit new technology to one per project
3. **Local Maximum**: Choose technology that maximizes team productivity now
4. **Exit Strategy**: Ensure migration path exists if technology fails
5. **Community Support**: Verify active community and documentation

[⬆ Return to top](#engineering)

## Simplicity Maintenance

⏺ **Principle**: Simplicity maintenance implements [fundamental.md#context](fundamental.md#context) by continuously monitoring and improving system clarity.

### Daily Simplicity Practices

#### Code Review Checklist
For every code change, verify:
- [ ] **Single Purpose**: Each function does one thing well
- [ ] **Clear Naming**: Names explain intent without comments
- [ ] **Minimal Dependencies**: Uses fewest external dependencies possible
- [ ] **Obvious Logic**: Control flow is straightforward to follow
- [ ] **No Premature Optimization**: Performance optimization only where measured
- [ ] **Deletion Considered**: Evaluated removing code instead of adding

#### Architecture Review Process
Monthly review for:
- **Dead Code Removal**: Identify and delete unused functionality
- **Abstraction Audit**: Remove abstractions used in <3 places
- **Dependency Review**: Eliminate unused or redundant dependencies
- **Interface Simplification**: Reduce parameter counts and return complexity
- **Documentation Sync**: Ensure docs match actual implementation

### Simplicity Metrics Dashboard
Track these metrics weekly:

#### Quantitative Measures
- **Lines of Code**: Should grow slower than features
- **File Count**: Should stabilize as system matures  
- **Dependency Count**: Should decrease over time
- **Test Coverage**: Should remain >80% with simple tests
- **Build Complexity**: Time and steps should remain constant

#### Qualitative Measures
- **New Developer Onboarding**: Time to first productive contribution
- **Bug Investigation**: Average time to understand and locate bugs
- **Feature Development**: Time from idea to working implementation
- **Code Confidence**: Team confidence in making changes safely

### Simplicity Debt Management
Like technical debt, but for complexity:

#### Identifying Simplicity Debt
- Code that requires extensive comments to understand
- Functions with multiple responsibilities
- Classes that change for multiple reasons
- Modules with unclear boundaries
- Systems requiring specialized knowledge

#### Paying Down Simplicity Debt
1. **Refactor First**: Choose refactoring over new features
2. **Extract and Simplify**: Break complex code into simple pieces
3. **Delete Aggressively**: Remove features that add complexity without value
4. **Standardize Patterns**: Reduce the number of ways to do things
5. **Document Decisions**: Capture why complexity was necessary

[⬆ Return to top](#engineering)

## Standards

⏺ **Principle**: Standards support [workflow.md#implementation](workflow.md#5-implementation) by providing technical excellence guidelines.

- Apply SOLID
- Apply DRY
- Apply YAGNI
- Apply KISS
- Maintain Single Source of Truth
- Separate Concerns
- Use organization.md for structure: [Apply organizational principles](organization.md)
- Follow implementation phase for execution: [Execute implementation methods](workflow.md#5-implementation)

[⬆ Return to top](#engineering)

## Methodologies

⏺ **Principle**: Methodologies ensure [workflow.md#validation](workflow.md#7-validation) through systematic testing and development practices that maintain simplicity.

### Development Methodologies
- **Test-Driven Development**: Write tests first to define simple interfaces
- **Behavior-Driven Development**: Focus on user value over technical complexity
- **Continuous Integration**: Maintain simple, fast build processes
- **Pair Programming**: Share knowledge and prevent over-engineering
- **Code Reviews**: Enforce simplicity standards consistently

### Testing Strategies for Simplicity
- **Unit Tests**: Test single functions with clear inputs and outputs
- **Integration Tests**: Verify simple interfaces between components
- **End-to-End Tests**: Validate user workflows without testing implementation details
- **Property-Based Tests**: Find edge cases without complex test scenarios
- **Mutation Testing**: Ensure tests are simple but effective

### Agile Practices for Complexity Management
- **Sprint Planning**: Include complexity budget in story estimation
- **Daily Standups**: Identify complexity blockers early
- **Sprint Retrospectives**: Review complexity decisions and outcomes
- **Backlog Grooming**: Break complex features into simple components
- **Definition of Done**: Include simplicity criteria in completion requirements

[⬆ Return to top](#engineering)

## Detection and Prevention

⏺ **Principle**: Detection systems implement [workflow.md#validation](workflow.md#7-validation) by providing automated and manual checks for over-engineering patterns.

### Automated Detection Tools

#### Static Analysis Rules
Configure tools to detect:
- **Function Length**: Flag functions >20 lines
- **Class Size**: Alert when classes exceed 200 lines  
- **Cyclomatic Complexity**: Warn at complexity >7, error at >10
- **Nesting Depth**: Flag code with >3 levels of nesting
- **Parameter Count**: Warn when functions have >4 parameters
- **Import Count**: Alert when files import >10 modules

#### Build-Time Checks
Integrate into CI/CD pipeline:
- **Dependency Analysis**: Track and limit external dependencies
- **Dead Code Detection**: Identify and flag unused code paths
- **Duplication Detection**: Find and report code duplication >3 lines
- **Architecture Tests**: Verify layer dependencies and module boundaries
- **Performance Budgets**: Ensure build and test times stay within limits

### Manual Detection Techniques

#### Code Review Red Flags
Watch for these patterns during reviews:
- **Premature Abstractions**: Interfaces with only one implementation
- **Gold Plating**: Features not requested by users or stakeholders
- **Framework Building**: Creating abstractions for single use cases
- **Future Proofing**: Adding complexity for hypothetical future needs
- **Technology Showcasing**: Using new tech without clear benefit

#### Design Review Questions
Ask these questions during design sessions:
- What is the simplest solution that could work?
- What would we build if we had 1/10th the time?
- How would a junior developer approach this problem?
- What assumptions are we making about future requirements?
- Can we solve this without adding any new abstractions?

### Prevention Strategies

#### Team Practices
- **Simplicity Champions**: Designate team members to advocate for simplicity
- **Complexity Budgets**: Allocate complexity points per sprint/project
- **Refactoring First**: Address complexity debt before new features
- **Regular Deletion**: Schedule time for removing unused code
- **Architecture Decision Records**: Document why complexity was added

#### Process Controls
- **Definition of Done**: Include "solution is as simple as possible"
- **Story Estimation**: Factor complexity into story point estimates
- **Spike Solutions**: Build throwaway prototypes for complex problems
- **Walking Skeleton**: Start with minimal working solution
- **Evolutionary Design**: Let architecture emerge from simple solutions

### Early Warning System
Implement alerts for complexity accumulation:

#### Weekly Metrics
- Lines of code per feature ratio trending upward
- Test execution time increasing without new functionality
- Build time growing faster than codebase size
- New developer onboarding time increasing
- Bug fix time trending upward consistently

#### Monthly Reviews
- Architecture complexity assessment
- Abstraction usage analysis (remove if <3 usages)
- Dependency audit and cleanup
- Dead code removal session
- Team complexity retrospective

[⬆ Return to top](#engineering)

## Review Criteria

⏺ **Principle**: Review criteria support [fundamental.md#evidence](fundamental.md#evidence) by providing measurable standards for complexity decisions.

### Pre-Development Review

#### Problem Definition Checklist
Before writing any code:
- [ ] **Problem Statement**: Clear, specific problem description exists
- [ ] **Success Criteria**: Measurable definition of "done" defined
- [ ] **Constraint Identification**: Technical and business constraints documented
- [ ] **User Value**: Direct benefit to end users articulated
- [ ] **Alternative Analysis**: At least 2 different approaches considered

#### Solution Design Review
Before implementation:
- [ ] **Simplest Solution**: Chosen approach is demonstrably simplest viable option
- [ ] **Existing Patterns**: Solution uses established team patterns where possible
- [ ] **Interface Design**: APIs have ≤4 parameters and single return type
- [ ] **Error Handling**: Simple, consistent error handling strategy defined
- [ ] **Testing Strategy**: Clear plan for testing without complex mocking

### During Development Review

#### Code Quality Gates
For every pull request:
- [ ] **Single Responsibility**: Each class/function has one clear purpose
- [ ] **Naming Clarity**: Names explain purpose without additional comments
- [ ] **Logic Simplicity**: Control flow is linear and obvious
- [ ] **Minimal Dependencies**: Uses fewest possible external dependencies
- [ ] **Test Simplicity**: Tests are straightforward and don't test implementation details

#### Architecture Compliance
For changes affecting system design:
- [ ] **Layer Respect**: Changes respect established architectural boundaries
- [ ] **Interface Stability**: Public interfaces remain backward compatible
- [ ] **Dependency Direction**: Dependencies flow toward stable, core components
- [ ] **Abstraction Justification**: New abstractions solve problems in ≥3 places
- [ ] **Complexity Budget**: Change fits within established complexity limits

### Post-Development Review

#### Success Measurement
After feature completion:
- [ ] **User Value Delivered**: Feature provides measurable user benefit
- [ ] **Complexity Target Met**: Implementation complexity matches design estimates
- [ ] **Maintenance Burden**: Code is maintainable by any team member
- [ ] **Documentation Minimal**: Solution is self-explanatory or simply documented
- [ ] **Performance Adequate**: Performance meets requirements without optimization

#### Long-term Impact Assessment
After 1 month in production:
- [ ] **Bug Rate**: Defect rate is equal to or lower than team baseline
- [ ] **Change Velocity**: Subsequent changes in area are equally fast to implement
- [ ] **Team Understanding**: All team members can work with the code confidently
- [ ] **User Satisfaction**: Feature adoption and satisfaction meet expectations
- [ ] **Complexity Debt**: No additional complexity accumulated unexpectedly

### Review Escalation Criteria

#### Automatic Architecture Review Required
Trigger broader review when:
- Adding >100 lines of code in single change
- Creating new abstraction layers or design patterns
- Introducing new external dependencies
- Changing core system interfaces
- Performance impact affects user experience

#### Complexity Review Board
Escalate to senior review when:
- Solution complexity exceeds story point estimate by >50%
- Multiple team members express confusion about approach
- Implementation requires specialized knowledge to maintain
- Change affects >5 different system components
- Technical debt paydown would take >1 sprint

### Review Documentation Standards

#### Decision Records
Document these complexity decisions:
- Why complexity was necessary (what simpler approaches failed)
- What specific benefits the complexity provides
- How the complexity will be maintained or reduced over time
- What metrics will track the success of the complex solution
- When the complexity should be re-evaluated for simplification

#### Simplicity Artifacts
Maintain these documents:
- **Complexity Budget Tracking**: Current usage vs limits per component
- **Abstraction Registry**: All abstractions with usage counts and justifications
- **Dead Code Candidates**: Code scheduled for removal with timelines
- **Simplification Opportunities**: Known areas where complexity could be reduced
- **Architecture Decision Log**: History of complexity trade-offs and outcomes

[⬆ Return to top](#engineering)

## Principle References

⏺ **Relationship**: This engineering principle provides comprehensive technical standards and complexity management frameworks that support systematic execution:
- **[fundamental.md](fundamental.md)**: Supplies core simplicity approaches for design decisions and complexity evaluation
- **[workflow.md](workflow.md)**: Provides systematic phases for implementation, validation, and complexity review
- **[organization.md](organization.md)**: Ensures structured technical approaches and complexity budget management
- **[forbidden.md](forbidden.md)**: Prevents over-engineering violations and technical anti-patterns
- **[simplicity.md](simplicity.md)**: Defines essential standards for maintaining minimal complexity in all implementations

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../index.md)
- [Study Principles for framework](../PRINCIPLES.md)
- [Return to fundamental.md for basic approach](fundamental.md)
- [Continue to communication.md for standards](communication.md)

### Related Principles
- [Apply fundamental.md for simplicity approach](fundamental.md#simplicity)
- [Execute workflow.md for systematic validation phases](workflow.md#7-validation)
- [Use organization.md for structural principles](organization.md)
- [Check forbidden.md for technical restrictions](forbidden.md)
- [Follow simplicity.md for minimal complexity standards](simplicity.md)

### Complexity Management Resources
- [Reference complexity budget framework](#complexity-budget-framework)
- [Apply SIMPLE decision framework](#the-simple-framework)
- [Use refactor vs rebuild decision tree](#refactor-vs-rebuild-decision-tree)
- [Execute automated detection tools](#automated-detection-tools)
- [Follow review criteria checklists](#review-criteria)

[⬆ Return to top](#engineering)