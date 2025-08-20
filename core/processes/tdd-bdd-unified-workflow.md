---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# TDD/BDD Unified Workflow

**Context**: Comprehensive workflow process that integrates Test-Driven Development and Behavior-Driven Development for all actions with mandatory validation

---

This workflow ensures every action is behavior-driven, test-validated, and demonstrably correct through systematic TDD/BDD integration using specialized agent deployment.

**MANDATORY AGENT DEPLOYMENT**: All TDD/BDD activities must be performed by deploying specialized agents. Direct implementation is strictly prohibited.

## Phase 1: Behavior Discovery (BDD)

### Understand the Requirement

**Deploy business-analysis-specialist** to understand and document requirements in BDD format.

**Agent Instructions**: "Analyze requirements for [feature/behavior] and create Given-When-Then scenarios that are specific, measurable, and testable."

```gherkin
Given [current system state]
When [user performs action] 
Then [expected system behavior]
And [success criteria are met]
```

**Validation**: Deploy validation-specialist to verify scenarios are specific, measurable, and testable

### Define Success Criteria

**Deploy requirements-analysis-specialist** to define comprehensive success criteria.

**Agent Instructions**: "Define success criteria for [feature] including:
- Business Value: What problem does this solve?
- User Outcome: What can the user accomplish?
- System Behavior: How should the system respond?
- Acceptance Criteria: When is it considered complete?"

## Phase 2: Test Design (TDD Setup)

### Red Phase: Write Failing Tests

**Deploy testing-strategy-specialist** to create comprehensive test suite.

**Agent Instructions**: "Create failing tests for [feature] including:
1. Acceptance Test: High-level test validating the BDD scenario
2. Unit Tests: Granular tests for each component needed
3. Integration Tests: Tests for component interactions"

```javascript
// Example structure:
describe('User Authentication Behavior', () => {
  it('should allow valid users to log in successfully', () => {
    // Given: valid user credentials
    // When: user attempts to log in  
    // Then: user should be authenticated
  });
});
```

**Validation**: Deploy validation-specialist to confirm all tests fail initially (Red phase confirmed)

## Phase 3: Minimal Implementation (Green Phase)

### Implement Just Enough Code

**Deploy implementation-specialist** to write minimal code that makes tests pass.

**Agent Instructions**: "Implement minimal code for [feature] to make all tests pass. Focus on behavior, not perfect design. Avoid over-engineering or premature optimization."

**Validation**: Deploy validation-specialist to confirm all tests pass (Green phase confirmed)

## Phase 4: Quality Improvement (Refactor Phase)

### Improve Code Quality

**Deploy code-quality-specialist** to refactor code while maintaining test coverage.

**Agent Instructions**: "Refactor [code/module] to:
- Improve clarity, maintainability, and performance
- Apply design patterns and best practices
- Ensure code follows project conventions
- Remove duplication and improve naming
Run tests after each change to prevent regressions."

**Validation**: Deploy validation-specialist to confirm all tests remain passing after refactoring

## Phase 5: Behavior Verification (BDD Validation)

### Demonstrate Behavior

**Deploy demonstration-specialist** to verify and document behavior implementation.

**Agent Instructions**: "Verify [feature] behavior by:
1. Running acceptance tests to prove BDD scenario is implemented
2. Executing manual validation in real context
3. Documenting evidence with test results and system behavior"

### Validation Checklist
- [ ] All unit tests pass
- [ ] All integration tests pass  
- [ ] Acceptance test validates BDD scenario
- [ ] Manual verification confirms expected behavior
- [ ] Documentation shows evidence of success

## Phase 6: Regression Protection

### Continuous Validation
- Add tests to test suite for future runs
- Document test execution process
- Set up automated validation where possible

## Workflow Application Examples

### Code Implementation
```gherkin
Given I need to implement a new feature
When I follow the TDD/BDD workflow
Then I should:
1. Write BDD scenario first
2. Create failing tests (Red)
3. Implement minimal code (Green)  
4. Refactor for quality
5. Validate all tests pass
6. Demonstrate working behavior
```

### Bug Fixing
```gherkin
Given I encounter a bug in the system
When I apply TDD/BDD workflow
Then I should:
1. Write BDD scenario describing correct behavior
2. Write test that reproduces the bug (Red)
3. Fix the bug with minimal changes (Green)
4. Refactor if needed
5. Validate fix works and doesn't break existing functionality
```

### Documentation Updates
```gherkin
Given documentation needs updating
When I follow TDD/BDD workflow
Then I should:
1. Define what accurate documentation looks like (BDD)
2. Create tests to validate documentation accuracy (Red)
3. Update documentation (Green)
4. Validate all links work and content is correct
```

## Mandatory Validation Process

### Pre-Commit Validation
Every change must pass:
1. **Behavior Tests**: BDD scenarios execute successfully
2. **Unit Tests**: All granular tests pass
3. **Integration Tests**: Component interactions work
4. **Regression Tests**: No existing functionality broken

### Evidence Requirements
For every completed action, provide:
- **Test Results**: Screenshot or log of all tests passing
- **Behavior Demo**: Evidence that BDD scenario works
- **Code Coverage**: Validation of test coverage levels
- **Manual Verification**: Confirmation of real-world behavior

## Tools and Commands

### Test Execution
```bash
# Run all tests with coverage
npm test -- --coverage

# Run specific test suite
npm test -- --testNamePattern="User Authentication"

# Run in watch mode for TDD
npm test -- --watch
```

### Validation Commands
```bash
# Lint code quality
npm run lint

# Type checking
npm run type-check

# Build validation
npm run build

# Integration tests
npm run test:integration
```

## Success Metrics

### Quality Gates
- **Test Coverage**: Minimum 80% for new code
- **Test Execution**: All tests must pass
- **Behavior Coverage**: All BDD scenarios implemented
- **Documentation**: Evidence provided for all claims

### Deliverable Requirements
Every completed action must include:
1. **BDD Scenario**: Clear behavior specification
2. **Passing Tests**: All levels of testing validated
3. **Working Code**: Demonstrably correct implementation  
4. **Evidence Package**: Screenshots, logs, and verification

## Integration with Existing Processes

### With TodoWrite Tool
```markdown
- [ ] Write BDD scenario for [feature]
- [ ] Create failing tests (Red phase)
- [ ] Implement minimal code (Green phase)
- [ ] Refactor for quality
- [ ] Validate all tests pass
- [ ] Demonstrate working behavior
- [ ] Document evidence of success
```

### With Git Workflow
```bash
# Create feature branch
git checkout -b feature/user-authentication-tdd-bdd

# Commit after each phase
git commit -m "Red: Add failing tests for user authentication behavior"
git commit -m "Green: Implement minimal authentication logic"  
git commit -m "Refactor: Improve authentication code structure"
git commit -m "Validate: All tests pass, behavior demonstrated"
```

---
