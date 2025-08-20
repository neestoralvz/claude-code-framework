[🏠 System Hub](../INDEX.md) | [📁 Processes](../PROCESSES.md) | [📖 Current Section](#)

---

# Behavior-Driven Development Workflow

**Context**: User-focused development process that defines system behavior before implementation

---

BDD ensures we build the right thing by starting with user behavior and business value, then connecting to technical implementation through TDD.

## Discover: Understand the Business Value

Start with conversations about what users actually need to accomplish. Use the "Three Amigos" approach - product owner, developer, and tester perspectives. Ask: "What problem are we solving and why does it matter?"

**Outcome**: Clear understanding of business value and user goals.

## Formulate: Write Behavior Scenarios

Write scenarios in Given-When-Then format that describe user behavior:

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

Transform scenarios into executable tests that drive your TDD workflow:

1. **Red**: Write failing acceptance test based on scenario
2. **Red-Green-Refactor**: Use TDD to implement the behavior
3. **Green**: Scenario test passes, behavior is complete

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

**Navigation:** [↑ System Hub](../INDEX.md) | [← Processes](../PROCESSES.md)