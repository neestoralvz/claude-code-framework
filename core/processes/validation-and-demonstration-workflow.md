---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Validation and Demonstration Workflow

**Context**: Systematic process for proving, checking, and validating that all actions pass required tests and demonstrate correct behavior

---

This workflow defines the mandatory validation and demonstration process that must be followed for every action, ensuring all work is verifiably correct.

## Core Validation Principles

### Every Action Must Be Provable
- **No Exceptions**: Every change, feature, or fix must be validated
- **Evidence Required**: Proof must be provided, not just claimed
- **Reproducible**: Validation must be repeatable by others
- **Documented**: All validation steps must be recorded

## Validation Framework

### 1. Pre-Action Validation (Setup)

**Before starting any work:**

```gherkin
Given I am about to begin work on [action]
When I prepare my validation environment
Then I should have:
- Working test environment
- Baseline measurements
- Clear success criteria
- Validation checklist prepared
```

**Required Setup:**
- [ ] Test environment is functional
- [ ] All existing tests pass (baseline)
- [ ] Success criteria are documented
- [ ] Validation tools are available

### 2. Development Validation (During Work)

**Throughout the development process:**

```gherkin
Given I am working on implementing [action]
When I complete each development phase
Then I must validate:
- Tests still pass
- New functionality works
- No regressions introduced
- Code quality maintained
```

**Continuous Validation:**
- [ ] Run tests after each significant change
- [ ] Validate behavior matches expectations
- [ ] Check for unintended side effects
- [ ] Maintain code quality standards

### 3. Completion Validation (Final Check)

**Before marking any action as complete:**

```gherkin
Given I believe [action] is complete
When I perform final validation
Then I must demonstrate:
- All tests pass (Red-Green cycle complete)
- BDD scenarios execute successfully  
- Manual verification confirms behavior
- Documentation shows evidence
```

## Evidence Requirements

### Test Execution Evidence
```bash
# Example command execution
npm test

# Required evidence:
✓ Screenshot or log showing all tests pass
✓ Test coverage report showing adequate coverage
✓ No failing tests or warnings
✓ Execution time within acceptable limits
```

### Behavior Demonstration Evidence
```gherkin
# Example BDD validation:
Given a user wants to log in with valid credentials
When they enter username "test@example.com" and password "validpass"
Then they should see the dashboard
And their session should be authenticated

# Required evidence:
✓ Screenshot of successful login
✓ Browser dev tools showing authentication token
✓ Dashboard page loading correctly
✓ Session persistence validation
```

### Code Quality Evidence
```bash
# Linting validation
npm run lint
# ✓ No linting errors

# Type checking
npm run type-check  
# ✓ No type errors

# Build validation
npm run build
# ✓ Successful build
```

## Demonstration Process

### 1. Automated Demonstration
```bash
# Execute all relevant tests
npm test -- --testNamePattern="[feature-name]"

# Run integration tests
npm run test:integration

# Generate coverage report
npm test -- --coverage --coverageReporters=html
```

**Required Screenshots:**
- [ ] Test execution results
- [ ] Coverage report summary
- [ ] Build success confirmation
- [ ] Lint/type-check passing

### 2. Manual Demonstration

**For User Interface Changes:**
- [ ] Screenshot of before state
- [ ] Screenshot of after state
- [ ] Video of functionality working (if complex)
- [ ] Different browser/device validation (if relevant)

**For API/Backend Changes:**
- [ ] API request/response examples
- [ ] Database state before/after (if relevant)
- [ ] Performance metrics comparison
- [ ] Error handling demonstration

**For Documentation Changes:**
- [ ] Link validation confirmation
- [ ] Rendering verification
- [ ] Content accuracy validation
- [ ] Cross-reference checking

### 3. Integration Demonstration
```bash
# Full system validation
npm run test:e2e

# Performance validation
npm run test:performance

# Security validation  
npm run test:security
```

## Validation Documentation Template

### Action Validation Report
```markdown
# Validation Report: [Action Name]

## BDD Scenario
```gherkin
Given [initial state]
When [action performed]
Then [expected outcome]
```

## Test Results
- **Unit Tests**: ✅ 15/15 passing
- **Integration Tests**: ✅ 8/8 passing  
- **E2E Tests**: ✅ 5/5 passing
- **Coverage**: ✅ 87% (above 80% threshold)

## Evidence
- Test execution screenshot: [link]
- Coverage report: [link]
- Manual validation video: [link]
- Code quality report: [link]

## Verification Checklist
- [ ] All tests pass
- [ ] BDD scenario validated
- [ ] Manual verification complete
- [ ] No regressions detected
- [ ] Code quality maintained
- [ ] Documentation updated

## Sign-off
Validated by: [Name]
Date: [Date]
Evidence location: [Path/URL]
```

## Failure Handling

### When Tests Fail
```gherkin
Given tests are failing
When I encounter test failures
Then I must:
1. Stop all development work
2. Analyze the failure root cause
3. Fix the failing tests
4. Re-run validation process
5. Document what was learned
```

### When Manual Validation Fails
```gherkin
Given manual validation reveals issues
When expected behavior doesn't match actual behavior
Then I must:
1. Create failing test reproducing the issue
2. Fix the implementation
3. Validate fix works
4. Update documentation if needed
```

## Quality Gates

### Minimum Requirements (Non-negotiable)
- [ ] **100% Test Pass Rate**: No failing tests allowed
- [ ] **BDD Scenario Validation**: All scenarios must execute successfully
- [ ] **Manual Verification**: Real-world behavior must match expectations
- [ ] **Evidence Documentation**: All claims must have supporting evidence
- [ ] **No Regressions**: Existing functionality must remain intact

### Quality Metrics
- **Test Coverage**: Minimum 80% for new code
- **Build Time**: Must not significantly increase
- **Performance**: Must not degrade existing performance
- **Security**: Must not introduce security vulnerabilities

## Integration with Git Workflow

### Commit Requirements
```bash
# Every commit must include validation evidence
git add .
git commit -m "feat: implement user authentication

✅ Tests: 15/15 passing
✅ Coverage: 87% 
✅ BDD: Login scenario validated
✅ Manual: Tested in Chrome/Firefox
✅ Evidence: docs/validation/auth-validation.md"
```

### Pull Request Requirements
Every PR must include:
- [ ] Validation report with evidence
- [ ] Test execution screenshots
- [ ] Manual verification confirmation
- [ ] Performance impact assessment
- [ ] Security review checklist

## Continuous Validation

### Automated Checks
```bash
# Pre-commit hooks
npm run validate  # runs tests, linting, type-checking

# CI/CD pipeline validation
npm run ci-validate  # comprehensive validation suite

# Post-deployment validation
npm run smoke-test  # basic functionality verification
```

### Monitoring and Alerting
- Set up alerts for test failures
- Monitor coverage trends
- Track validation completion rates
- Report validation bottlenecks

---