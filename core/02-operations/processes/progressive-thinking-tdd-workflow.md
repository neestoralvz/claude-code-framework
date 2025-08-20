---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Progressive Thinking TDD Workflow

**Context**: TDD/BDD-integrated workflow for systematically breaking down complex problems with validation at every step

---

This workflow applies Test-Driven Development principles to progressive thinking, ensuring every step is validated and builds toward verified outcomes.

## BDD Scenario: Progressive Problem Solving

```gherkin
Given I have a complex problem that needs systematic breakdown
When I apply Progressive Thinking TDD Workflow
Then I should:
- Define clear success criteria for each step
- Create validation tests before each action
- Build understanding progressively with evidence
- Deliver validated solutions incrementally
```

## Phase 1: Problem Discovery (BDD)

### Understand the Challenge
```gherkin
Given I encounter a complex task
When I begin progressive thinking
Then I must first:
- Document what I currently understand
- Identify what I don't know yet  
- Define specific success criteria
- Create validation scenarios
```

**Actions:**
1. Write BDD scenario describing the overall goal
2. List known facts vs assumptions
3. Define measurable success criteria
4. Identify validation checkpoints

### Map Current State (Test-First)
```gherkin
Given I need to understand the current state
When I analyze what exists now
Then I should:
- Create tests that validate my understanding
- Verify assumptions with evidence
- Document findings with proof
- Identify gaps systematically
```

**TDD Approach:**
1. **Red Phase**: Write tests that validate current state understanding
2. **Green Phase**: Gather evidence to make tests pass
3. **Refactor Phase**: Organize findings clearly

## Phase 2: Target Definition (BDD)

### Define Success Criteria
```gherkin
Given I understand the current state
When I define the target state
Then I must:
- Create specific, measurable outcomes
- Write acceptance tests for success
- Identify intermediate milestones
- Plan validation at each step
```

**Validation Requirements:**
- [ ] Success criteria are specific and measurable
- [ ] Acceptance tests can verify achievement
- [ ] Milestones build toward final goal
- [ ] Each step has clear validation

## Phase 3: Path Planning (TDD)

### Break Down Into Testable Steps
```gherkin
Given I have clear success criteria
When I plan the path forward
Then I should:
- Identify smallest valuable increments
- Create tests for each increment
- Sequence steps by dependencies
- Plan parallel execution opportunities
```

**TDD Planning Process:**
1. **Red Phase**: Write failing tests for each planned step
2. **Green Phase**: Verify steps are achievable
3. **Refactor Phase**: Optimize sequence and dependencies

### Dependency Analysis
```gherkin
Given I have identified steps
When I analyze dependencies
Then I must:
- Test that dependencies are correct
- Validate parallel execution possibilities
- Create tests for integration points
- Plan for dependency failures
```

## Phase 4: Incremental Execution (TDD/BDD)

### Execute With Continuous Validation
```gherkin
Given I have a validated plan
When I execute each step
Then I must:
- Run step-specific validation tests
- Prove step completion with evidence
- Update understanding based on results
- Adjust plan based on new learning
```

**Per-Step TDD Cycle:**
1. **Red Phase**: Run pre-step validation (should fail)
2. **Green Phase**: Execute step until validation passes
3. **Refactor Phase**: Improve based on learning
4. **Document**: Record evidence and learning

### Progress Tracking
```gherkin
Given I am executing steps
When I complete each increment
Then I should:
- Update TodoWrite with evidence of completion
- Run regression tests on previous steps
- Validate integrated system still works
- Document new insights for future steps
```

## Phase 5: Learning Integration (BDD)

### Adapt Based on Evidence
```gherkin
Given I complete each step with evidence
When new information emerges
Then I must:
- Update BDD scenarios based on learning
- Revise tests to match new understanding  
- Adjust remaining steps accordingly
- Document pattern discoveries
```

**Learning Validation:**
- [ ] New understanding is evidence-based
- [ ] Changes improve overall outcome
- [ ] Previous work remains valid
- [ ] Future steps are better informed

## Progressive Thinking Test Framework

### Step Validation Template
```javascript
describe('Progressive Thinking Step', () => {
  describe('Pre-Step State', () => {
    it('should have clear success criteria', () => {
      // Test that success criteria are defined
    });
    
    it('should have validation method', () => {
      // Test that we can measure success
    });
  });
  
  describe('Step Execution', () => {
    it('should move from current to target state', () => {
      // Test the step actually progresses toward goal
    });
    
    it('should provide evidence of completion', () => {
      // Test that completion is verifiable
    });
  });
  
  describe('Post-Step State', () => {
    it('should meet step success criteria', () => {
      // Test that step was successful
    });
    
    it('should not break previous work', () => {
      // Regression test
    });
    
    it('should inform future steps', () => {
      // Test that learning is captured
    });
  });
});
```

## Integration with TodoWrite

### Task Creation with Validation
```gherkin
Given I break down complex work
When I create TodoWrite tasks  
Then each task should:
- Have clear BDD scenario
- Include validation method
- Specify evidence requirements
- Connect to overall goal
```

**TodoWrite Template:**
```markdown
- [ ] [Task Name] - BDD: Given [context] When [action] Then [outcome]
  - Validation: [How to verify completion]
  - Evidence: [What proves it's done]
  - Tests: [Specific validation tests]
```

## Evidence Requirements

### Per-Step Evidence
- **Understanding Tests**: Proof of current state analysis
- **Planning Tests**: Validation of step sequence
- **Execution Evidence**: Proof step was completed correctly
- **Learning Documentation**: New insights with supporting evidence

### Overall Progress Evidence
- **BDD Scenarios**: Updated based on learning
- **Test Results**: All validation tests passing
- **Completion Proof**: Evidence of incremental progress
- **Integration Tests**: Proof that parts work together

## Common Patterns

### Complex Development Tasks
```gherkin
Given I need to implement a complex feature
When I use Progressive Thinking TDD
Then I should:
1. Write BDD scenario for overall feature
2. Break into testable user stories
3. Implement with TDD cycles
4. Validate integration continuously
5. Document patterns discovered
```

### System Analysis
```gherkin
Given I need to understand a complex system
When I apply Progressive Thinking TDD
Then I should:
1. Write tests for my understanding
2. Gather evidence to make tests pass
3. Build mental model incrementally
4. Validate model against reality
5. Document findings with evidence
```

### Problem Debugging
```gherkin
Given I have a complex bug
When I use Progressive Thinking TDD
Then I should:
1. Write test reproducing the problem
2. Create hypotheses about causes
3. Test each hypothesis systematically
4. Build understanding progressively
5. Verify fix with comprehensive tests
```

## Success Metrics

### Quality Gates
- **Understanding Validation**: All current state tests pass
- **Planning Validation**: All step tests are achievable
- **Execution Validation**: All completion tests pass
- **Learning Validation**: New insights are evidence-based

### Deliverable Requirements
- **Progressive Understanding**: Each step builds on previous
- **Validated Steps**: Each increment has passing tests
- **Evidence Trail**: Clear proof of progress and decisions
- **Integrated Solution**: All parts work together correctly

---