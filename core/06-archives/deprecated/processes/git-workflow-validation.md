---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Git Workflow with Validation

**Context**: TDD/BDD-integrated Git workflow ensuring all commits are validated, tested, and include evidence of success

---

This workflow ensures every Git operation follows TDD/BDD principles with mandatory validation, testing, and evidence documentation.

## BDD Scenario: Git Operations

```gherkin
Given I need to commit changes to the repository
When I follow Git Workflow with Validation
Then I should:
- Validate all changes pass tests before committing
- Include evidence of validation in commit messages
- Follow consistent commit patterns with BDD scenarios
- Ensure commits are atomic and reversible
```

## Phase 1: Pre-Commit Validation (BDD)

### Change Analysis
```gherkin
Given I have made changes to the codebase
When I prepare to commit
Then I must first:
- Run all relevant tests to ensure they pass
- Validate changes don't break existing functionality
- Confirm changes meet quality standards
- Document what was changed and why
```

**Pre-Commit Validation Checklist:**
- [ ] All existing tests pass (regression prevention)
- [ ] New functionality has tests (TDD compliance)
- [ ] Code meets quality standards (linting, formatting)
- [ ] Changes are atomic and focused
- [ ] Commit message describes BDD scenario

### Pre-Commit Tests
```javascript
describe('Pre-Commit Validation', () => {
  it('should have all tests passing', () => {
    // Test that test suite completes successfully
  });
  
  it('should maintain code quality standards', () => {
    // Test linting and formatting requirements
  });
  
  it('should be atomic and focused', () => {
    // Test commit contains related changes only
  });
  
  it('should include proper documentation', () => {
    // Test commit message and code documentation
  });
});
```

## Phase 2: Commit Preparation (TDD)

### Atomic Commit Creation
```gherkin
Given I have validated changes
When I create the commit
Then it should:
- Include only related changes (atomic principle)
- Have clear, descriptive commit message with BDD scenario
- Include evidence of validation in message
- Reference any related issues or tickets
```

**Commit Message Pattern:**
```
[type]: [description]

BDD Scenario:
Given [context]
When [action]
Then [outcome]

✅ Validation:
- Tests: [X/X] passing
- Coverage: [X]%
- Linting: ✅ passed
- Manual: [validation method]

Evidence: [location of proof/documentation]

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>
```

### Commit Validation Tests
```javascript
describe('Commit Creation', () => {
  it('should have descriptive commit message', () => {
    // Test commit message follows pattern and is informative
  });
  
  it('should include BDD scenario', () => {
    // Test commit message contains Given-When-Then structure
  });
  
  it('should include validation evidence', () => {
    // Test commit message shows proof of testing
  });
  
  it('should be atomic and reversible', () => {
    // Test commit can be safely reverted if needed
  });
});
```

## Phase 3: Branch Management (BDD)

### Feature Branch Workflow
```gherkin
Given I need to work on a feature or fix
When I create a branch
Then I should:
- Use descriptive branch names following convention
- Keep branches focused on single feature/fix
- Regularly sync with main branch
- Validate branch is ready for merge
```

**Branch Naming Convention:**
- `feature/user-authentication-tdd-bdd`
- `fix/login-validation-error`
- `refactor/user-service-cleanup`
- `test/integration-user-flow`

### Branch Quality Gates
```gherkin
Given I have a feature branch
When I prepare for merge
Then the branch must:
- Have all tests passing
- Include comprehensive test coverage for new code
- Have commits following validation pattern
- Be up-to-date with main branch
- Include documentation for new features
```

## Phase 4: Merge Validation (TDD/BDD)

### Pull Request Preparation
```gherkin
Given I have completed feature development
When I create a pull request
Then I must include:
- Comprehensive validation report
- Test execution evidence
- Manual verification confirmation
- Performance impact assessment
```

**Pull Request Template:**
```markdown
## BDD Scenario
```gherkin
Given [initial state]
When [changes implemented]
Then [expected outcome]
```

## Changes Summary
- [List of specific changes]

## Validation Report
✅ **Tests**: [X/X] passing  
✅ **Coverage**: [X]% (above minimum threshold)  
✅ **Linting**: No issues  
✅ **Type Check**: Passed  
✅ **Manual Validation**: [Method used]  

## Evidence
- Test execution: [screenshot/log location]
- Coverage report: [link]
- Manual validation: [documentation]
- Performance metrics: [if applicable]

## Checklist
- [ ] All tests pass
- [ ] Code reviewed by team member
- [ ] Documentation updated
- [ ] No regressions detected
- [ ] Performance acceptable
```

### Merge Validation Tests
```javascript
describe('Pull Request Validation', () => {
  it('should have comprehensive test coverage', () => {
    // Test new code has adequate test coverage
  });
  
  it('should not introduce regressions', () => {
    // Test existing functionality still works
  });
  
  it('should meet performance requirements', () => {
    // Test changes don't degrade performance
  });
  
  it('should include proper documentation', () => {
    // Test documentation was updated appropriately
  });
});
```

## Phase 5: Post-Merge Validation (BDD)

### Integration Verification
```gherkin
Given changes have been merged to main
When I verify the integration
Then I should:
- Confirm all CI/CD checks pass
- Validate deployed changes work correctly
- Monitor for any issues or regressions
- Document successful deployment
```

**Post-Merge Checklist:**
- [ ] CI/CD pipeline completes successfully
- [ ] Automated tests pass in target environment
- [ ] Manual smoke tests confirm functionality
- [ ] Monitoring shows no degradation
- [ ] Team notified of successful deployment

## Git Command Patterns with Validation

### Commit with Evidence
```bash
# Run comprehensive validation first
npm test && npm run lint && npm run type-check

# Create commit with evidence
git add .
git commit -m "$(cat <<'EOF'
feat: implement user authentication with TDD validation

BDD Scenario:
Given a user wants to create an account
When they provide valid email and password
Then they should be registered and logged in

✅ Validation:
- Tests: 15/15 passing
- Coverage: 87%
- Linting: ✅ passed
- Manual: Tested registration flow in Chrome/Firefox

Evidence: docs/validation/auth-implementation.md

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### Branch Creation with Purpose
```bash
# Create feature branch with descriptive name
git checkout -b feature/user-authentication-tdd-bdd

# Work with validation at each commit
# ... make changes ...
npm test  # Validate before each commit
git add . && git commit -m "[commit message with BDD scenario]"
```

### Merge with Validation
```bash
# Ensure branch is current
git checkout main
git pull origin main
git checkout feature/user-authentication-tdd-bdd
git rebase main  # Keep history clean

# Final validation before merge
npm test && npm run build && npm run e2e-test

# Create PR with comprehensive documentation
gh pr create --title "Implement user authentication with TDD/BDD validation" \
--body "$(cat <<'EOF'
## BDD Scenario
[Complete BDD scenario and validation report]
EOF
)"
```

## Integration with TDD/BDD Workflows

### With Development Workflow
```gherkin
Given I am developing a feature with TDD/BDD
When I reach commit points
Then Git workflow should:
- Support Red-Green-Refactor cycles with commits
- Document BDD scenarios in commit messages
- Include test evidence in validation reports
- Enable safe rollback if issues arise
```

### With Validation Workflow
```gherkin
Given I am using Validation and Demonstration workflow
When I commit changes
Then Git workflow should:
- Require evidence before commits
- Document validation methods used
- Include proof of successful testing
- Support audit trail for compliance
```

## Quality Assurance Integration

### Commit Quality Metrics
- **Test Coverage**: New code must meet coverage thresholds
- **Message Quality**: Commits follow BDD scenario pattern
- **Evidence Inclusion**: Validation proof included in commits
- **Atomic Focus**: Each commit has single, clear purpose

### Branch Quality Metrics
- **Test Success Rate**: 100% test pass rate required
- **Integration Success**: No merge conflicts or issues
- **Documentation Coverage**: New features fully documented
- **Performance Impact**: No significant degradation

## Error Recovery Patterns

### Failed Validation Recovery
```gherkin
Given validation fails before commit
When I encounter test failures or quality issues
Then I should:
1. Stop commit process immediately
2. Analyze and fix issues systematically
3. Re-run full validation suite
4. Document lessons learned
```

### Rollback Procedures
```gherkin
Given a commit causes issues in production
When I need to rollback changes
Then I should:
1. Create failing test reproducing the issue
2. Revert problematic commit
3. Validate rollback fixes issue
4. Plan fix with proper TDD/BDD approach
```

## Success Metrics

### Git Workflow Success
- **Commit Quality**: 100% of commits follow validation pattern
- **Test Coverage**: All commits include test validation evidence
- **Clean History**: Atomic commits with clear BDD scenarios
- **Zero Regressions**: No functionality broken by changes

### Quality Gates
- **Pre-Commit Validation**: All tests must pass before commit
- **Message Standards**: All commits include BDD scenarios and evidence
- **Branch Quality**: Feature branches validated before merge
- **Integration Success**: Merges don't break main branch

---