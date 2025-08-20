---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# TodoWrite Management Workflow

**Context**: TDD/BDD workflow for systematic task management using TodoWrite tool with validation and atomic task breakdown

---

This workflow ensures TodoWrite is used effectively with atomic tasks, proper status management, and evidence-based completion tracking.

## BDD Scenario: Task Management

```gherkin
Given I have complex work that requires task management
When I use TodoWrite Management Workflow
Then I should:
- Break work into atomic, testable tasks
- Maintain accurate task status in real-time
- Validate task completion with evidence
- Track progress systematically with clear milestones
```

## Phase 1: Task Analysis (BDD)

### Atomic Task Definition
```gherkin
Given I need to break down complex work
When I create TodoWrite tasks
Then each task must be:
- Indivisible: Cannot be broken down further meaningfully
- Actionable: Has clear action verb and deliverable
- Completable: Has definitive completion criteria
- Specific: Precisely describes what needs to be done
- Testable: Success can be objectively verified
```

**Atomic Task Validation:**
```javascript
describe('Task Atomicity', () => {
  it('should have single, clear action', () => {
    // Test task has one primary action verb
  });
  
  it('should be completable in one session', () => {
    // Test task can be finished without breaking down further
  });
  
  it('should have measurable outcome', () => {
    // Test success criteria are objective and verifiable
  });
  
  it('should not depend on other incomplete tasks', () => {
    // Test task can be started immediately when marked in_progress
  });
});
```

### Task Dependency Analysis
```gherkin
Given I have multiple tasks
When I analyze dependencies
Then I should:
- Identify tasks that can run in parallel
- Sequence dependent tasks correctly
- Create independent sub-workflows
- Plan for dependency failure scenarios
```

## Phase 2: TodoWrite Creation (TDD)

### Task Creation with BDD Scenarios
```gherkin
Given I create TodoWrite tasks
When I write each task
Then it should:
- Include BDD scenario in task description
- Specify validation criteria
- Define evidence requirements
- Connect to overall goal
```

**Task Format Pattern:**
```markdown
- [ ] [Action Verb] [Specific Deliverable] - BDD: Given [context] When [action] Then [outcome]
  - Validation: [How to verify completion]
  - Evidence: [What proves it's done]
  - Success Criteria: [Objective measures]
```

### Task Creation Tests
```javascript
describe('TodoWrite Task Creation', () => {
  it('should follow atomic task pattern', () => {
    // Test task follows indivisible, actionable, completable, specific format
  });
  
  it('should include BDD scenario', () => {
    // Test task has Given-When-Then structure
  });
  
  it('should specify validation method', () => {
    // Test task includes how to verify completion
  });
  
  it('should connect to overall goal', () => {
    // Test task contributes to larger objective
  });
});
```

## Phase 3: Status Management (TDD)

### Real-Time Status Updates
```gherkin
Given I am working on TodoWrite tasks
When I change task status
Then I must:
- Update status immediately when starting (pending → in_progress)
- Have only ONE task in_progress at any time
- Mark completed immediately when finished (in_progress → completed)
- Provide evidence for completed tasks
```

**Status Transition Rules:**
1. **pending**: Task not yet started, all dependencies met
2. **in_progress**: Currently working on this task (limit: 1 at a time)
3. **completed**: Task finished with evidence validated

### Status Management Tests
```javascript
describe('TodoWrite Status Management', () => {
  it('should have only one in_progress task at a time', () => {
    // Test maximum one task can be in_progress simultaneously
  });
  
  it('should update status immediately on state change', () => {
    // Test status changes happen in real-time
  });
  
  it('should require evidence for completion', () => {
    // Test completed tasks have supporting evidence
  });
  
  it('should maintain accurate progress tracking', () => {
    // Test status accurately reflects actual work state
  });
});
```

## Phase 4: Task Execution (TDD/BDD)

### Single-Task Focus
```gherkin
Given I have tasks in TodoWrite
When I begin work
Then I should:
- Mark exactly one task as in_progress
- Complete that task fully before starting another
- Validate completion with evidence
- Update status immediately upon completion
```

**Task Execution Cycle:**
1. **Start**: Mark task in_progress
2. **Execute**: Follow task's BDD scenario
3. **Validate**: Verify completion criteria met
4. **Evidence**: Document proof of completion
5. **Complete**: Mark task completed
6. **Next**: Select next pending task

### Execution Validation Tests
```javascript
describe('Task Execution', () => {
  it('should complete BDD scenario successfully', () => {
    // Test task execution achieves Given-When-Then outcome
  });
  
  it('should meet all success criteria', () => {
    // Test all specified criteria are satisfied
  });
  
  it('should provide required evidence', () => {
    // Test evidence supports completion claim
  });
  
  it('should not create regressions', () => {
    // Test task completion doesn't break previous work
  });
});
```

## Phase 5: Completion Validation (BDD)

### Evidence-Based Completion
```gherkin
Given I believe a task is complete
When I mark it as completed
Then I must provide:
- Objective evidence of completion
- Validation that BDD scenario was achieved
- Proof that success criteria were met
- Documentation for future reference
```

**Completion Validation Process:**
- [ ] BDD scenario outcome achieved
- [ ] Success criteria objectively met
- [ ] Evidence documented and verifiable
- [ ] No regressions introduced
- [ ] Dependencies for future tasks satisfied

## TodoWrite Integration Patterns

### Complex Development Tasks
```markdown
TodoWrite Example:
- [ ] Implement user authentication - BDD: Given new user When registers Then should create account with secure password
  - Validation: User can register and login successfully
  - Evidence: Screenshots of registration flow + test results
  - Success Criteria: Authentication works, passwords hashed, session management active

- [ ] Add input validation - BDD: Given invalid inputs When user submits Then should show clear error messages
  - Validation: All input edge cases handled gracefully
  - Evidence: Test results showing error handling + UI screenshots
  - Success Criteria: No crashes, clear error messages, proper UX
```

### Research Tasks
```markdown
TodoWrite Example:
- [ ] Research React testing best practices - BDD: Given need for testing strategy When research current practices Then should have actionable testing plan
  - Validation: Comprehensive testing strategy document created
  - Evidence: Document with sources, examples, and implementation plan
  - Success Criteria: Strategy covers unit, integration, e2e testing with specific tools
```

### Documentation Tasks
```markdown
TodoWrite Example:
- [ ] Create API documentation - BDD: Given API endpoints exist When create documentation Then developers should understand usage
  - Validation: Documentation tested by independent developer
  - Evidence: Documentation + feedback from test user
  - Success Criteria: All endpoints documented with examples, clear parameters, error responses
```

## Quality Assurance Integration

### Task Quality Metrics
- **Atomicity Score**: Can task be broken down further? (No = atomic)
- **Completability**: Can task be finished in single session?
- **Specificity**: Is the deliverable clearly defined?
- **Testability**: Can completion be objectively verified?

### Progress Quality Metrics
- **Status Accuracy**: Does status match actual work state?
- **Evidence Quality**: Does evidence support completion claims?
- **Timeline Adherence**: Are tasks completed within reasonable time?
- **Dependency Management**: Are prerequisites properly tracked?

## Integration with Other Workflows

### With TDD/BDD Unified Workflow
```gherkin
Given I am following TDD/BDD workflow
When I use TodoWrite
Then tasks should:
- Include BDD scenarios for behavior specification
- Support Red-Green-Refactor cycles
- Track testing milestones
- Validate evidence with tests
```

### With Progressive Thinking
```gherkin
Given I am using Progressive Thinking
When I create TodoWrite tasks
Then they should:
- Build understanding incrementally
- Support step-by-step validation
- Enable parallel execution where possible
- Document learning and insights
```

## Evidence Requirements

### Task Completion Evidence
- **Objective Proof**: Screenshots, logs, test results
- **BDD Validation**: Evidence that scenario was achieved
- **Success Criteria**: Proof all criteria were met
- **Integration Proof**: Evidence task works with existing system

### Progress Tracking Evidence
- **Status History**: Record of status changes with timestamps
- **Completion Rate**: Metrics on task completion efficiency
- **Quality Metrics**: Evidence of atomic task creation
- **Dependency Management**: Proof of proper task sequencing

## Common Anti-Patterns to Avoid

### Non-Atomic Tasks
```markdown
❌ Bad: "Improve the user interface"
✅ Good: "Add dark mode toggle to settings page - BDD: Given user in settings When clicks dark mode Then interface switches to dark theme"
```

### Vague Success Criteria
```markdown
❌ Bad: "Make it work better"
✅ Good: "Reduce page load time to under 2 seconds - Validation: Lighthouse performance score >90"
```

### Missing Evidence
```markdown
❌ Bad: Task marked complete without proof
✅ Good: Task marked complete with test results, screenshots, and performance metrics
```

### Multiple In-Progress Tasks
```markdown
❌ Bad: 3 tasks marked as in_progress simultaneously
✅ Good: Exactly 1 task in_progress, others pending or completed
```

## Success Metrics

### TodoWrite Management Success
- **Atomic Task Rate**: 100% of tasks follow atomic pattern
- **Status Accuracy**: Real-time status reflects actual work state
- **Completion Evidence**: All completed tasks have supporting proof
- **Single Focus**: Only one task in_progress at any time

### Quality Gates
- **Task Clarity**: All tasks have clear BDD scenarios
- **Evidence Quality**: Completion proof is objective and verifiable
- **Progress Tracking**: Status changes happen immediately
- **Goal Alignment**: All tasks contribute to overall objectives

---