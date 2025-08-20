# Quality Gates Validation Examples

**Context**: Practical examples demonstrating TDD/BDD quality gate validation in real development scenarios

---

## TDD Quality Gate Examples

### Example 1: Unit Test Coverage Validation

**Scenario**: Implementing a user authentication service using TDD

**Quality Gate Requirements**:
- 90% minimum line coverage
- 100% coverage for security functions
- Maximum cyclomatic complexity of 10

**TDD Implementation**:

```javascript
// Step 1: RED - Write failing test
describe('AuthenticationService', () => {
  it('should authenticate user with valid credentials', () => {
    // Arrange
    const service = new AuthenticationService();
    const credentials = { username: 'user', password: 'valid123' };
    
    // Act & Assert
    expect(() => service.authenticate(credentials)).not.toThrow();
    expect(service.authenticate(credentials)).toBe(true);
  });
});

// Quality Gate Check: Test fails (RED) ✓
// Coverage: 0% (no implementation) ✗
```

```javascript
// Step 2: GREEN - Minimal implementation
class AuthenticationService {
  authenticate(credentials) {
    if (credentials.username === 'user' && credentials.password === 'valid123') {
      return true;
    }
    return false;
  }
}

// Quality Gate Check: Test passes (GREEN) ✓
// Coverage: 100% (simple function) ✓  
// Complexity: 2 (within limit) ✓
```

```javascript
// Step 3: REFACTOR - Improve with security validation
class AuthenticationService {
  /**
   * Authenticates user credentials against security policy
   * @param {Object} credentials - User credentials
   * @returns {boolean} Authentication result
   */
  authenticate(credentials) {
    if (!this._validateCredentials(credentials)) {
      return false;
    }
    
    return this._verifyPassword(credentials);
  }
  
  _validateCredentials(credentials) {
    return credentials && 
           credentials.username && 
           credentials.password &&
           credentials.username.length >= 3 &&
           credentials.password.length >= 8;
  }
  
  _verifyPassword(credentials) {
    // Secure password verification logic
    return this._hashPassword(credentials.password) === 
           this._getStoredPasswordHash(credentials.username);
  }
}

// Quality Gate Validation Results:
// ✓ Test Coverage: 95% (exceeds 90% threshold)
// ✓ Security Coverage: 100% (meets critical path requirement) 
// ✓ Complexity: authenticate=3, _validateCredentials=4, _verifyPassword=2
// ✓ Documentation: JSDoc present for public methods
```

### Example 2: TDD Cycle Compliance Monitoring

**Quality Gate**: 100% adherence to Red-Green-Refactor cycle

**Validation Method**: Git commit analysis

```bash
# Quality Gate Validation Script
#!/bin/bash

# Check TDD cycle compliance
function validate_tdd_cycle() {
    local feature_branch=$1
    local commits=$(git log main..${feature_branch} --oneline)
    
    # Pattern: RED commit -> GREEN commit -> REFACTOR commit
    local red_pattern="(RED|FAIL|failing test)"
    local green_pattern="(GREEN|PASS|minimal|implementation)"
    local refactor_pattern="(REFACTOR|refactor|improve|cleanup)"
    
    local tdd_cycles=0
    local total_features=0
    
    # Analyze commit messages for TDD patterns
    while IFS= read -r commit; do
        if [[ $commit =~ $red_pattern ]]; then
            ((tdd_cycles++))
        fi
        if [[ $commit =~ "feat:" ]] || [[ $commit =~ "feature:" ]]; then
            ((total_features++))
        fi
    done <<< "$commits"
    
    local compliance_rate=$((tdd_cycles * 100 / total_features))
    
    if [ $compliance_rate -ge 100 ]; then
        echo "✓ TDD Compliance: ${compliance_rate}% (PASSED)"
        return 0
    else
        echo "✗ TDD Compliance: ${compliance_rate}% (FAILED - requires 100%)"
        return 1
    fi
}

# Example usage in CI/CD pipeline
validate_tdd_cycle "feature/user-authentication"
```

## BDD Quality Gate Examples

### Example 3: Scenario Quality Validation

**Quality Gate Requirements**:
- All scenarios in Given-When-Then format
- Business language (no technical jargon)
- 100% acceptance criteria coverage

**BDD Implementation**:

```gherkin
# High-Quality Scenario Example
Feature: User Shopping Cart
  As a customer
  I want to manage items in my shopping cart
  So that I can purchase products efficiently

  Scenario: Adding product to empty cart
    Given I am a registered customer
    And I have an empty shopping cart
    And a product "Laptop" is available with price $999.99
    When I add the "Laptop" to my cart
    Then my cart should contain 1 item
    And the cart total should be $999.99
    And I should see a confirmation message "Product added successfully"

  Scenario: Removing item from cart
    Given I have a shopping cart with "Laptop" ($999.99)
    When I remove the "Laptop" from my cart  
    Then my cart should be empty
    And the cart total should be $0.00
    And I should see "Cart is now empty"
```

**Quality Validation**:

```javascript
// Automated scenario quality checks
const scenarioQualityValidator = {
  validateScenarioStructure(scenario) {
    const requiredKeywords = ['Given', 'When', 'Then'];
    const hasAllKeywords = requiredKeywords.every(keyword => 
      scenario.includes(keyword)
    );
    
    return {
      structureValid: hasAllKeywords,
      message: hasAllKeywords ? 
        'Scenario follows Given-When-Then structure' :
        'Scenario missing required keywords'
    };
  },
  
  validateBusinessLanguage(scenario) {
    const technicalTerms = [
      'API', 'endpoint', 'HTTP', 'JSON', 'database', 
      'query', 'method', 'function', 'variable'
    ];
    
    const hasTechnicalTerms = technicalTerms.some(term => 
      scenario.toLowerCase().includes(term.toLowerCase())
    );
    
    return {
      businessLanguageUsed: !hasTechnicalTerms,
      message: hasTechnicalTerms ? 
        'Scenario contains technical jargon' :
        'Scenario uses business language'
    };
  },
  
  validateSpecificity(scenario) {
    const vagueWords = ['some', 'many', 'few', 'several', 'appropriate'];
    const hasVagueWords = vagueWords.some(word => 
      scenario.toLowerCase().includes(word)
    );
    
    return {
      specific: !hasVagueWords,
      message: hasVagueWords ?
        'Scenario uses vague terminology' :
        'Scenario uses specific, concrete language'
    };
  }
};

// Quality Gate Validation Results:
// ✓ Structure: Given-When-Then format present
// ✓ Business Language: No technical jargon detected
// ✓ Specificity: Concrete examples and values used
// ✓ Testability: All steps can be automated
```

### Example 4: Living Documentation Quality

**Quality Gate**: Documentation accuracy matches system behavior

**Implementation**:

```javascript
// Automated documentation synchronization test
describe('Living Documentation Validation', () => {
  it('should verify scenario documentation matches actual behavior', async () => {
    // Arrange - Parse BDD scenarios
    const scenarios = await parseFeatureFiles('./features/*.feature');
    
    // Act - Execute scenarios against actual system
    const executionResults = await Promise.all(
      scenarios.map(async (scenario) => {
        const result = await executeScenario(scenario);
        return {
          scenario: scenario.name,
          expected: scenario.expectedOutcome,
          actual: result.actualOutcome,
          matches: scenario.expectedOutcome === result.actualOutcome
        };
      })
    );
    
    // Assert - All scenarios match actual behavior
    const allScenariosAccurate = executionResults.every(result => result.matches);
    const accuracyRate = executionResults.filter(r => r.matches).length / 
                        executionResults.length * 100;
    
    expect(accuracyRate).toBeGreaterThanOrEqual(100);
    expect(allScenariosAccurate).toBe(true);
    
    // Quality Gate Results logged
    console.log(`Documentation Accuracy: ${accuracyRate}%`);
  });
});
```

## Integration Quality Gate Examples

### Example 5: External Dependency Testing

**Quality Gate**: 100% external integration test coverage

**Implementation**:

```javascript
// Integration test with quality gate validation
describe('Payment Service Integration', () => {
  let paymentService;
  let mockPaymentGateway;
  
  beforeEach(() => {
    mockPaymentGateway = new MockPaymentGateway();
    paymentService = new PaymentService(mockPaymentGateway);
  });
  
  describe('Quality Gate: External Integration Coverage', () => {
    it('should handle successful payment processing', async () => {
      // Arrange
      const paymentData = {
        amount: 99.99,
        currency: 'USD',
        cardToken: 'tok_test_12345'
      };
      
      mockPaymentGateway.setResponse({
        status: 'success',
        transactionId: 'txn_12345',
        chargedAmount: 99.99
      });
      
      // Act
      const result = await paymentService.processPayment(paymentData);
      
      // Assert
      expect(result.success).toBe(true);
      expect(result.transactionId).toBe('txn_12345');
      expect(mockPaymentGateway.getLastRequest()).toEqual(paymentData);
    });
    
    it('should handle payment gateway timeout', async () => {
      // Arrange - Simulate timeout
      mockPaymentGateway.setDelay(5000);
      paymentService.setTimeout(2000);
      
      const paymentData = { amount: 50.00, currency: 'USD' };
      
      // Act & Assert
      await expect(paymentService.processPayment(paymentData))
        .rejects
        .toThrow('Payment gateway timeout');
      
      // Verify proper error handling
      expect(paymentService.getLastError()).toContain('timeout');
    });
    
    it('should handle network connectivity issues', async () => {
      // Arrange - Simulate network error
      mockPaymentGateway.simulateNetworkError();
      
      // Act & Assert
      await expect(paymentService.processPayment({ amount: 25.00 }))
        .rejects
        .toThrow('Network connectivity error');
    });
  });
  
  // Quality Gate Validation
  afterAll(async () => {
    const coverageReport = await generateIntegrationCoverage();
    
    // Quality Gate: 100% integration endpoint coverage
    expect(coverageReport.endpointCoverage).toBe(100);
    
    // Quality Gate: All error scenarios tested
    expect(coverageReport.errorScenariosCovered).toBe(100);
    
    console.log('Integration Quality Gates: PASSED');
  });
});
```

## Performance Quality Gate Examples

### Example 6: Test Execution Performance

**Quality Gate**: Unit tests complete under 30 seconds

**Monitoring Implementation**:

```javascript
// Performance monitoring for test suite
const performanceMonitor = {
  testSuiteTimer: null,
  testExecutionTimes: [],
  
  startSuiteTimer() {
    this.testSuiteTimer = performance.now();
  },
  
  endSuiteTimer() {
    const executionTime = performance.now() - this.testSuiteTimer;
    this.testExecutionTimes.push(executionTime);
    return executionTime;
  },
  
  validatePerformanceGate() {
    const totalTime = this.testExecutionTimes.reduce((sum, time) => sum + time, 0);
    const averageTime = totalTime / this.testExecutionTimes.length;
    
    const unitTestThreshold = 30000; // 30 seconds
    const integrationTestThreshold = 300000; // 5 minutes
    
    return {
      unitTestsWithinThreshold: averageTime <= unitTestThreshold,
      totalExecutionTime: totalTime,
      averageExecutionTime: averageTime,
      recommendation: averageTime > unitTestThreshold ? 
        'Consider optimizing slow tests or improving test isolation' :
        'Performance within acceptable limits'
    };
  }
};

// Jest setup for performance monitoring
beforeAll(() => {
  performanceMonitor.startSuiteTimer();
});

afterAll(() => {
  const executionTime = performanceMonitor.endSuiteTimer();
  const performance = performanceMonitor.validatePerformanceGate();
  
  if (!performance.unitTestsWithinThreshold) {
    console.warn(`⚠ Performance Quality Gate Failed: ${executionTime}ms exceeds 30s threshold`);
  } else {
    console.log(`✓ Performance Quality Gate Passed: ${executionTime}ms`);
  }
});
```

## Quality Gate Failure Examples

### Example 7: Quality Gate Failure Handling

**Scenario**: Quality gate failure with remediation

```javascript
// Quality gate failure detection and remediation
const qualityGateValidator = {
  async validateAllGates(codebase) {
    const results = {
      coverage: await this.validateCoverage(),
      complexity: await this.validateComplexity(),
      tddCompliance: await this.validateTDDCompliance(),
      performance: await this.validatePerformance()
    };
    
    const failures = Object.entries(results)
      .filter(([gate, result]) => !result.passed)
      .map(([gate, result]) => ({
        gate,
        issue: result.issue,
        remediation: result.remediation
      }));
    
    if (failures.length > 0) {
      await this.handleQualityGateFailures(failures);
      return false;
    }
    
    return true;
  },
  
  async handleQualityGateFailures(failures) {
    // Block deployment
    process.env.DEPLOYMENT_BLOCKED = 'true';
    
    // Generate failure report
    const failureReport = {
      timestamp: new Date().toISOString(),
      failures: failures,
      remediationPlan: failures.map(f => ({
        gate: f.gate,
        action: f.remediation,
        priority: this.getPriority(f.gate),
        estimatedTime: this.getEstimatedFixTime(f.gate)
      }))
    };
    
    // Notify team
    await this.notifyTeam(failureReport);
    
    // Log for tracking
    console.error('Quality Gate Failures:', JSON.stringify(failureReport, null, 2));
    
    // Exit with failure code
    process.exit(1);
  },
  
  getPriority(gate) {
    const priorities = {
      coverage: 'HIGH',
      complexity: 'MEDIUM', 
      tddCompliance: 'HIGH',
      performance: 'MEDIUM'
    };
    return priorities[gate] || 'LOW';
  }
};

// Example usage in CI/CD pipeline
module.exports = qualityGateValidator;
```

## Compliance Reporting Examples

### Example 8: Regulatory Compliance Integration

**Quality Gate**: Maintain audit trail for all quality decisions

```javascript
// Compliance reporting system
const complianceReporter = {
  generateComplianceReport() {
    return {
      reportDate: new Date().toISOString(),
      qualityMetrics: {
        testCoverage: this.getCoverageMetrics(),
        codeQuality: this.getCodeQualityMetrics(),
        processCompliance: this.getProcessComplianceMetrics()
      },
      auditTrail: this.getAuditTrail(),
      riskAssessment: this.getRiskAssessment(),
      evidence: this.collectEvidence()
    };
  },
  
  collectEvidence() {
    return {
      testReports: glob.sync('./test-results/*.xml'),
      coverageReports: glob.sync('./coverage/*.json'),
      codeAnalysisReports: glob.sync('./quality-reports/*.json'),
      buildLogs: glob.sync('./logs/build-*.log'),
      deploymentRecords: this.getDeploymentHistory()
    };
  },
  
  getAuditTrail() {
    return {
      qualityGateChanges: this.getQualityGateHistory(),
      processChanges: this.getProcessChangeHistory(),
      exceptionRequests: this.getQualityExceptions(),
      approvals: this.getQualityApprovals()
    };
  }
};
```

These examples demonstrate comprehensive quality gate validation across all aspects of TDD/BDD development, ensuring maintainable, reliable, and compliant code delivery.