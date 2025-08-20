
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Behavior-Driven Development Workflow

**Context**: User-focused development process that defines system behavior before implementation

---

BDD ensures we build the right thing by deploying specialized agents to analyze user behavior and business value, then connect to technical implementation through TDD agent deployment.

**MANDATORY**: All BDD activities must be performed through specialized agent deployment. Never attempt direct implementation or analysis.

## Discover: Understand the Business Value

**Deploy business-analysis-specialist** to facilitate conversations about user needs. The agent will use the "Three Amigos" approach - product owner, developer, and tester perspectives.

**Agent Instructions**: "Analyze the business requirements for [feature/story]. Identify the problem being solved, why it matters, and who benefits. Document user goals and business value."

**Outcome**: Clear understanding of business value and user goals.

## Formulate: Write Behavior Scenarios

**Deploy scenario-writing-specialist** to create scenarios in Given-When-Then format that describe user behavior.

**Agent Instructions**: "Write BDD scenarios for [feature/behavior] using Given-When-Then format. Include happy path, edge cases, and error scenarios. Make them concrete and testable."

```gherkin
Given [initial context]
When [action/event occurs]  
Then [expected outcome]
```

Example:
```gherkin
Given a user has an empty shopping cart
When they add a product to the cart
Then the cart should show 1 item and the total price
```

**Outcome**: Concrete, testable behavior specifications.

## Automate: Connect to TDD Cycle

**Deploy test-automation-specialist** to transform scenarios into executable tests. The agent will coordinate with testing-strategy-specialist for TDD implementation.

**Agent Instructions**: "Convert BDD scenario [scenario name] into executable tests. Coordinate the TDD cycle:"

1. **Red**: Deploy testing-strategy-specialist to write failing acceptance test
2. **Red-Green-Refactor**: Deploy implementation-specialist for TDD implementation
3. **Green**: Deploy validation-specialist to verify scenario passes

**Outcome**: Working software that matches specified behavior.

## Integration with TDD

BDD provides the "what" and "why" - TDD provides the "how":

1. **BDD Scenario** → Defines user behavior
2. **Acceptance Test** → Validates behavior end-to-end  
3. **TDD Cycle** → Implements behavior through unit tests
4. **Integration** → Confirms behavior works in real context

## Practical Examples

### Feature: User Authentication
```gherkin
Scenario: Successful login
Given a registered user with valid credentials
When they enter their username and password
Then they should be logged in and see their dashboard
```

### Feature: Data Validation
```gherkin
Scenario: Invalid input handling
Given a form with required fields
When a user submits with missing information
Then they should see clear error messages for each field
```

## BDD Tools and Practices

### Scenario Writing
- Use business language, not technical jargon
- Focus on user outcomes, not implementation details
- Keep scenarios independent and focused
- Include both happy path and edge cases

### Living Documentation
- Scenarios serve as executable specifications
- Keep scenarios updated as behavior evolves
- Use scenarios to communicate with stakeholders
- Generate reports showing behavior coverage

## Benefits

### User-Centered Development
- Ensures features solve real user problems
- Validates business value before implementation
- Improves communication between team members

### Quality Assurance
- Reduces defects through behavior specification
- Catches misunderstandings early in development
- Creates comprehensive test coverage

### Documentation
- Scenarios document system behavior clearly
- Tests serve as living examples for future developers
- Business rules are captured and maintained

## Common Patterns

### Outside-In Development
1. Start with user scenarios (BDD)
2. Create acceptance tests
3. Use TDD to implement supporting code
4. Confirm scenarios pass

### Specification by Example
- Use concrete examples to clarify requirements
- Turn examples into automated tests
- Collaborate on examples to build shared understanding

---

