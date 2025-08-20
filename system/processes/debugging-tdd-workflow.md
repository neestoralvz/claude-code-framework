# Debugging Workflow with TDD

## Overview

This workflow applies Test-Driven Development principles to debugging, ensuring systematic problem resolution through evidence-based testing. Every bug fix must be validated through reproducible tests before implementation.

## Core Principles

- **Test First**: Create failing test that reproduces the bug
- **Minimal Fix**: Implement smallest change to make test pass
- **Refactor Safely**: Improve code while maintaining test coverage
- **Evidence Required**: All debugging steps must be verifiable

## TDD Debugging Cycle

### Phase 1: RED - Reproduce the Problem

**Given** a bug report or unexpected behavior  
**When** starting debugging process  
**Then** create failing test that demonstrates the issue:

1. **Problem Definition**
   ```
   BUG REPORT:
   - Description: [What is happening]
   - Expected: [What should happen]
   - Actual: [What actually happens]
   - Environment: [System, version, conditions]
   - Reproducibility: [Always/Sometimes/Rare]
   
   IMPACT ASSESSMENT:
   - Severity: [Critical/High/Medium/Low]
   - Users Affected: [Number/Percentage]
   - Business Impact: [Revenue/Experience/Security]
   - Workaround Available: [Yes/No + Description]
   ```

2. **Reproduction Test Creation**
   ```python
   def test_bug_reproduction():
       # Arrange: Set up the exact conditions
       setup_conditions()
       
       # Act: Perform the action that triggers the bug
       result = perform_problematic_action()
       
       # Assert: Verify the bug occurs
       assert result == expected_correct_behavior
       # This test SHOULD FAIL initially
   ```

3. **Evidence Collection**
   - Logs capturing the failure
   - Stack traces and error messages
   - System state before/during/after failure
   - Network requests/responses if applicable
   - Database queries and results
   - Memory/CPU usage during failure

### Phase 2: GREEN - Fix the Problem

**Given** a failing test that reproduces the bug  
**When** implementing the fix  
**Then** make minimal changes to pass the test:

1. **Root Cause Analysis**
   ```
   INVESTIGATION:
   - Hypothesis 1: [Theory + Evidence For/Against]
   - Hypothesis 2: [Theory + Evidence For/Against]
   - Root Cause: [Confirmed cause + Evidence]
   
   VERIFICATION:
   - Test modified conditions
   - Confirm hypothesis with additional tests
   - Document causal relationship
   ```

2. **Minimal Fix Implementation**
   - Change only what's necessary to fix the root cause
   - Avoid "while we're here" improvements (save for refactor phase)
   - Ensure fix doesn't break existing functionality
   - Add logging/monitoring if needed for future debugging

3. **Fix Validation**
   ```bash
   # Run the reproduction test
   pytest test_bug_reproduction.py -v
   
   # Run full test suite to ensure no regressions
   pytest --coverage --failed-first
   
   # Test edge cases related to the fix
   pytest test_edge_cases_for_bug_fix.py -v
   ```

### Phase 3: REFACTOR - Improve and Prevent

**Given** the bug is fixed and tests are passing  
**When** refactoring for improvement  
**Then** enhance code quality while maintaining functionality:

1. **Code Quality Improvement**
   - Simplify complex logic that contributed to bug
   - Add error handling and input validation
   - Improve variable/function names for clarity
   - Extract functions to reduce complexity

2. **Prevention Measures**
   ```python
   def test_regression_prevention():
       """Test to ensure this bug type doesn't return"""
       # Test boundary conditions
       # Test invalid inputs
       # Test concurrent access if relevant
       # Test resource exhaustion scenarios
   ```

3. **Documentation and Learning**
   - Document the bug and fix in commit message
   - Update code comments explaining the fix
   - Add to team knowledge base
   - Update error handling patterns if needed

## Debugging Scenarios

### Scenario 1: Performance Regression

**Given** application performance has degraded  
**When** debugging performance issue  
**Then** apply TDD debugging:

```python
def test_performance_regression():
    # RED: Create test that fails due to slow performance
    start_time = time.time()
    result = slow_function(large_dataset)
    execution_time = time.time() - start_time
    
    # This should pass but currently fails
    assert execution_time < 2.0  # Expected under 2 seconds
    assert result == expected_output
```

**Investigation**:
- Profile code to identify bottlenecks
- Compare with baseline performance metrics
- Analyze recent changes that might impact performance

**Fix**: Optimize the identified bottleneck with minimal changes

**Refactor**: Improve overall algorithm or add caching if appropriate

### Scenario 2: Data Corruption Bug

**Given** data is being corrupted during processing  
**When** debugging data integrity issue  
**Then** create comprehensive test:

```python
def test_data_integrity():
    # RED: Test that should pass but fails due to corruption
    original_data = create_test_data()
    processed_data = process_data(original_data)
    
    # Verify data integrity
    assert len(processed_data) == len(original_data)
    assert sum(processed_data.values) == sum(original_data.values)
    assert all(validate_record(record) for record in processed_data)
```

**Investigation**:
- Trace data flow through processing pipeline
- Check for race conditions or concurrent access
- Validate input data format and constraints
- Review recent changes to data processing logic

### Scenario 3: Integration Failure

**Given** external service integration is failing  
**When** debugging integration issue  
**Then** test all integration points:

```python
def test_external_service_integration():
    # RED: Test actual integration behavior
    with mock_external_service() as mock_service:
        mock_service.configure_response(expected_response)
        
        result = call_external_service(test_data)
        
        assert result.status_code == 200
        assert result.data == expected_data
        mock_service.assert_called_with(expected_params)
```

## Quality Gates

### Before Fixing (RED Phase)
- [ ] Bug is reproducible with test
- [ ] Test fails consistently
- [ ] All evidence is documented
- [ ] Impact assessment is complete
- [ ] Root cause hypothesis formed

### After Fixing (GREEN Phase)
- [ ] Reproduction test now passes
- [ ] All existing tests still pass
- [ ] No new test failures introduced
- [ ] Fix addresses root cause, not symptoms
- [ ] Performance impact assessed

### After Refactoring (REFACTOR Phase)
- [ ] Code quality improved
- [ ] Test coverage maintained or increased
- [ ] Documentation updated
- [ ] Prevention tests added
- [ ] Knowledge shared with team

## Advanced Debugging Techniques

### Binary Search Debugging

**Given** a bug introduced in recent changes  
**When** many commits to investigate  
**Then** use binary search with tests:

```bash
# Start git bisect
git bisect start
git bisect bad  # Current broken state
git bisect good <last_known_good_commit>

# At each step, run reproduction test
while git bisect run pytest test_bug_reproduction.py; do
    echo "Testing commit $(git rev-parse HEAD)"
done
```

### Hypothesis-Driven Debugging

**Given** complex system with unclear failure  
**When** root cause is not obvious  
**Then** test hypotheses systematically:

```python
class DebugHypothesis:
    def __init__(self, description, test_method):
        self.description = description
        self.test_method = test_method
        self.result = None
    
    def test(self):
        try:
            self.result = self.test_method()
            return True
        except Exception as e:
            self.result = str(e)
            return False

# Test each hypothesis
hypotheses = [
    DebugHypothesis("Memory leak in data processing", test_memory_usage),
    DebugHypothesis("Race condition in concurrent access", test_concurrency),
    DebugHypothesis("Input validation bypass", test_input_validation)
]

for hypothesis in hypotheses:
    if hypothesis.test():
        print(f"Confirmed: {hypothesis.description}")
        break
```

### Fault Injection Testing

**Given** system needs resilience testing  
**When** debugging failure scenarios  
**Then** inject controlled failures:

```python
def test_network_failure_handling():
    with network_failure_injection():
        result = robust_network_operation()
        assert result.success == False
        assert result.error_handled == True
        assert result.retry_attempted == True

def test_database_timeout_handling():
    with database_timeout_injection(delay=30):
        result = database_operation_with_timeout()
        assert result.timed_out == True
        assert result.fallback_used == True
```

## Debugging Tools Integration

### Static Analysis Integration
```bash
# Run static analysis as part of debugging
pylint src/ --errors-only
mypy src/ --strict
bandit -r src/ -ll  # Security issues
```

### Dynamic Analysis Integration
```bash
# Memory debugging
valgrind --tool=memcheck python script.py

# Performance profiling
python -m cProfile -o profile.out script.py
python -c "import pstats; pstats.Stats('profile.out').sort_stats('cumulative').print_stats(20)"

# Coverage analysis
pytest --cov=src --cov-report=html
```

### Logging and Monitoring Integration
```python
import logging
import structlog

# Structured logging for debugging
logger = structlog.get_logger()

def debug_operation(data):
    logger.info("Starting operation", 
                data_size=len(data), 
                operation="debug_operation")
    try:
        result = process_data(data)
        logger.info("Operation successful", 
                   result_size=len(result))
        return result
    except Exception as e:
        logger.error("Operation failed", 
                    error=str(e), 
                    stack_trace=traceback.format_exc())
        raise
```

## Success Metrics

- **Time to Resolution**: Average time from bug report to fix deployment
- **Fix Quality**: % of fixes that don't introduce regressions
- **Test Coverage**: % of bugs caught by automated tests after fix
- **Recurrence Rate**: % of bugs that reoccur after being fixed
- **Root Cause Accuracy**: % of fixes that address actual root cause

## Integration with Other Workflows

### Evidence-Based Decision Workflow
- Use evidence collection techniques for debugging data
- Apply validation framework to verify fixes
- Document debugging decisions with evidence

### Development Workflow
- Integrate debugging tests into regular test suite
- Use debugging insights to improve development practices
- Apply TDD principles learned from debugging to new features

### Web Research Workflow
- Research similar bugs and solutions
- Gather external evidence for root cause theories
- Validate fixes against industry best practices

---

**Remember**: Every bug is a failing test waiting to be written. Fix the test, fix the code.