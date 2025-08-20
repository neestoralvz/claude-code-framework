---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Context7 Integration Workflow

**Context**: TDD/BDD workflow for systematic use of Context7 for library documentation, best practices, and current examples

---

This workflow ensures Context7 is used effectively with validation at every step, providing current, accurate documentation and examples for development tasks.

## BDD Scenario: Context7 Usage

```gherkin
Given I need current library documentation or examples
When I use Context7 integration workflow
Then I should:
- Identify the specific library and use case
- Resolve correct Context7 library ID
- Retrieve relevant, current documentation
- Validate information accuracy with tests
- Apply knowledge with evidence-based implementation
```

## Phase 1: Requirement Discovery (BDD)

### Identify Documentation Needs
```gherkin
Given I need to work with libraries or frameworks
When I analyze my documentation requirements
Then I must:
- Define specific library/framework needed
- Identify exact use case or functionality
- Specify current version requirements
- Plan validation of retrieved information
```

**Actions:**
1. Write BDD scenario for the documentation need
2. Document specific questions to answer
3. Define success criteria for information quality
4. Plan validation tests for retrieved docs

### Library Identification Test
```javascript
describe('Library Identification', () => {
  it('should identify exact library needed', () => {
    // Test that library name is specific and resolvable
  });
  
  it('should define specific use case', () => {
    // Test that use case is clear and actionable
  });
  
  it('should specify version requirements', () => {
    // Test that version needs are documented
  });
});
```

## Phase 2: Context7 Resolution (TDD)

### Library ID Resolution
```gherkin
Given I have identified needed library
When I resolve Context7 library ID
Then I should:
- Use resolve-library-id function first
- Validate returned library ID format
- Confirm library matches my needs
- Document resolution for future use
```

**TDD Process:**
1. **Red Phase**: Write test expecting specific library ID format
2. **Green Phase**: Use Context7 resolve-library-id to get actual ID
3. **Refactor Phase**: Validate and document the resolved ID

### Resolution Validation Test
```javascript
describe('Context7 Library Resolution', () => {
  it('should resolve to valid Context7 ID format', () => {
    // Test ID follows /org/project or /org/project/version pattern
  });
  
  it('should match intended library', () => {
    // Test resolved library is the one we actually need
  });
  
  it('should provide current version', () => {
    // Test library version is recent and relevant
  });
});
```

## Phase 3: Documentation Retrieval (TDD/BDD)

### Focused Documentation Retrieval
```gherkin
Given I have valid Context7 library ID
When I retrieve documentation
Then I should:
- Specify focused topic for relevance
- Set appropriate token limit for depth
- Validate documentation completeness
- Test examples for accuracy
```

**TDD Approach:**
1. **Red Phase**: Write test for expected documentation structure
2. **Green Phase**: Retrieve docs with Context7 get-library-docs
3. **Refactor Phase**: Process and organize information

### Documentation Quality Tests
```javascript
describe('Retrieved Documentation', () => {
  it('should contain relevant examples', () => {
    // Test that docs include working code examples
  });
  
  it('should be current and up-to-date', () => {
    // Test that information reflects current best practices
  });
  
  it('should answer specific questions', () => {
    // Test that retrieved docs address our use case
  });
  
  it('should include API documentation', () => {
    // Test that API usage patterns are documented
  });
});
```

## Phase 4: Information Validation (BDD)

### Accuracy Verification
```gherkin
Given I have retrieved Context7 documentation
When I validate the information
Then I must:
- Test code examples in real environment
- Verify API signatures are current
- Validate best practices against community standards
- Cross-reference with official documentation
```

**Validation Process:**
- [ ] Code examples execute without errors
- [ ] API calls work with current library version
- [ ] Dependencies are correctly specified
- [ ] Performance recommendations are current

### Example Validation Test
```javascript
describe('Context7 Documentation Validation', () => {
  it('should have working code examples', () => {
    // Test that provided examples actually execute
  });
  
  it('should use current API patterns', () => {
    // Test that API usage matches library version
  });
  
  it('should include error handling', () => {
    // Test that examples show proper error handling
  });
});
```

## Phase 5: Implementation Application (TDD)

### Evidence-Based Implementation
```gherkin
Given I have validated Context7 documentation
When I implement the solution
Then I should:
- Follow documented patterns exactly
- Test implementation against examples
- Validate performance characteristics
- Document any adaptations needed
```

**Implementation TDD:**
1. **Red Phase**: Write tests based on Context7 examples
2. **Green Phase**: Implement following documented patterns
3. **Refactor Phase**: Optimize while maintaining documented approach

## Context7 Integration Patterns

### Library Research Pattern
```gherkin
Scenario: Researching new library integration
Given I need to integrate a new library
When I follow Context7 workflow
Then I should:
1. Use resolve-library-id with library name
2. Get focused documentation with specific topic
3. Validate examples in test environment
4. Implement with TDD following patterns
5. Document integration patterns for team
```

### Best Practices Discovery
```gherkin
Scenario: Finding current best practices
Given I need to improve existing code
When I use Context7 for best practices
Then I should:
1. Identify specific improvement areas
2. Research current patterns with Context7
3. Compare existing code against best practices
4. Test improvements incrementally
5. Validate performance and maintainability gains
```

### API Integration Pattern
```gherkin
Scenario: Implementing API integration
Given I need to work with external APIs
When I use Context7 for API documentation
Then I should:
1. Get current API documentation and examples
2. Test authentication patterns
3. Validate request/response formats
4. Implement error handling as documented
5. Test edge cases and error scenarios
```

## Quality Assurance Integration

### Context7 Information Validation
- **Source Verification**: Confirm information is from official sources
- **Recency Check**: Validate documentation reflects current versions
- **Example Testing**: All code examples must execute successfully
- **Pattern Validation**: Implementation follows documented patterns

### Documentation Quality Metrics
- **Completeness**: Addresses all aspects of the use case
- **Accuracy**: Information matches actual library behavior
- **Currency**: Reflects latest stable version practices
- **Applicability**: Examples are relevant to specific needs

## Integration with Other Workflows

### With TDD/BDD Unified Workflow
```gherkin
Given I am following TDD/BDD workflow
When I need library documentation
Then Context7 integration should:
- Support behavior specification with current examples
- Provide test patterns for library usage
- Enable validation of implementation against best practices
```

### With Progressive Thinking
```gherkin
Given I am using Progressive Thinking workflow
When I need to understand complex libraries
Then Context7 should:
- Support incremental learning with focused topics
- Provide examples building from simple to complex
- Enable step-by-step validation of understanding
```

## Evidence Requirements

### Context7 Usage Evidence
- **Library Resolution Log**: Record of successful ID resolution
- **Documentation Retrieval Log**: What was requested and received
- **Validation Test Results**: Proof that examples work
- **Implementation Success**: Evidence of successful integration

### Quality Evidence
- **Example Execution**: Screenshots/logs of working examples
- **Version Verification**: Proof of current version usage
- **Pattern Compliance**: Evidence following best practices
- **Performance Validation**: Metrics showing expected behavior

## Common Use Cases

### Framework Integration
```gherkin
Given I need to integrate React/Vue/Angular components
When I use Context7 integration workflow
Then I should:
1. Resolve framework-specific library ID
2. Get component patterns and lifecycle methods
3. Test patterns in isolated environment
4. Implement following documented architecture
5. Validate performance and accessibility
```

### Database Integration
```gherkin
Given I need to implement database operations
When I follow Context7 workflow
Then I should:
1. Get current ORM/database library docs
2. Review connection and query patterns
3. Test transaction and error handling examples
4. Implement with proper security practices
5. Validate performance and connection pooling
```

### Testing Library Integration
```gherkin
Given I need to set up testing frameworks
When I use Context7 for testing docs
Then I should:
1. Get current testing library documentation
2. Review test structure and mocking patterns
3. Test async and integration test examples
4. Implement comprehensive test suites
5. Validate coverage and performance metrics
```

## Success Metrics

### Context7 Integration Success
- **Resolution Rate**: 100% successful library ID resolution
- **Example Validation**: All retrieved examples execute successfully
- **Implementation Success**: Code works following documented patterns
- **Currency Validation**: Documentation reflects current best practices

### Quality Gates
- **Information Accuracy**: All Context7 info validated against reality
- **Pattern Compliance**: Implementation follows documented patterns
- **Version Compatibility**: Works with specified library versions
- **Performance Validation**: Meets documented performance characteristics

---