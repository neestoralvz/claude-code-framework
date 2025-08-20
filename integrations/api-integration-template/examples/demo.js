import { MathApiService } from '../src/services/MathApiService.js';
import { MockMathServer } from '../src/mock/MockMathServer.js';
import { Logger } from '../src/utils/Logger.js';

/**
 * Comprehensive API Integration Demo
 * 
 * Demonstrates all features of the REST API integration solution
 * Shows real-world usage patterns and best practices
 */
class ApiIntegrationDemo {
  constructor() {
    this.logger = new Logger('ApiIntegrationDemo');
    this.server = null;
    this.mathService = null;
  }

  /**
   * Run the complete demonstration
   */
  async run() {
    try {
      this.logger.info('Starting API Integration Demo');
      
      await this.startServer();
      await this.initializeService();
      
      await this.demonstrateBasicOperations();
      await this.demonstrateAdvancedOperations();
      await this.demonstrateErrorHandling();
      await this.demonstrateRetryLogic();
      await this.demonstrateValidation();
      await this.demonstrateMonitoring();
      await this.demonstrateHealthChecks();
      
      await this.displayFinalMetrics();
      
    } catch (error) {
      this.logger.error('Demo failed', { error: error.message });
    } finally {
      await this.cleanup();
    }
  }

  /**
   * Start the mock math server
   */
  async startServer() {
    this.logger.info('Starting mock math server...');
    
    this.server = new MockMathServer({ port: 3005 });
    await this.server.start();
    
    this.logger.info('Mock server started on port 3005');
  }

  /**
   * Initialize the math service with comprehensive configuration
   */
  async initializeService() {
    this.logger.info('Initializing math service with production configuration...');
    
    this.mathService = new MathApiService({
      baseURL: 'http://localhost:3005/api/v1',
      timeout: 10000,
      retry: {
        enabled: true,
        maxAttempts: 3,
        baseDelay: 500,
        backoffMultiplier: 2,
        jitterFactor: 0.1
      },
      circuitBreaker: {
        enabled: true,
        failureThreshold: 5,
        resetTimeout: 15000,
        monitoringPeriod: 10000,
        volumeThreshold: 10,
        errorPercentageThreshold: 50
      }
    });
    
    this.logger.info('Math service initialized successfully');
  }

  /**
   * Demonstrate basic arithmetic operations
   */
  async demonstrateBasicOperations() {
    this.logger.info('=== Demonstrating Basic Operations ===');
    
    try {
      // Addition
      const addResult = await this.mathService.add(15, 25);
      this.logger.info('Addition result', { result: addResult.result });
      
      // Subtraction
      const subResult = await this.mathService.subtract(50, 30);
      this.logger.info('Subtraction result', { result: subResult.result });
      
      // Multiplication
      const mulResult = await this.mathService.multiply(7, 8);
      this.logger.info('Multiplication result', { result: mulResult.result });
      
      // Division with precision
      const divResult = await this.mathService.divide(22, 7, { precision: 3 });
      this.logger.info('Division result', { result: divResult.result });
      
      // Power calculation
      const powResult = await this.mathService.power(2, 10);
      this.logger.info('Power result', { result: powResult.result });
      
      // Square root
      const sqrtResult = await this.mathService.sqrt(144);
      this.logger.info('Square root result', { result: sqrtResult.result });
      
    } catch (error) {
      this.logger.error('Basic operations failed', { error: error.message });
    }
  }

  /**
   * Demonstrate advanced mathematical operations
   */
  async demonstrateAdvancedOperations() {
    this.logger.info('=== Demonstrating Advanced Operations ===');
    
    try {
      const numbers = [10, 20, 30, 40, 50, 25, 35];
      
      // Sum
      const sumResult = await this.mathService.advancedOperation(numbers, 'sum');
      this.logger.info('Sum result', { numbers, result: sumResult.result });
      
      // Average
      const avgResult = await this.mathService.advancedOperation(numbers, 'average');
      this.logger.info('Average result', { result: avgResult.result });
      
      // Median
      const medianResult = await this.mathService.advancedOperation(numbers, 'median');
      this.logger.info('Median result', { result: medianResult.result });
      
      // Product
      const smallNumbers = [2, 3, 4];
      const productResult = await this.mathService.advancedOperation(smallNumbers, 'product');
      this.logger.info('Product result', { numbers: smallNumbers, result: productResult.result });
      
      // Equation solving
      const equationResult = await this.mathService.solveEquation('x * 2 + y * 3', {
        x: 10,
        y: 5
      });
      this.logger.info('Equation result', { result: equationResult.result });
      
      // Complex equation
      const complexResult = await this.mathService.solveEquation('Math.pow(a, 2) + Math.sqrt(b)', {
        a: 5,
        b: 36
      });
      this.logger.info('Complex equation result', { result: complexResult.result });
      
    } catch (error) {
      this.logger.error('Advanced operations failed', { error: error.message });
    }
  }

  /**
   * Demonstrate error handling and recovery
   */
  async demonstrateErrorHandling() {
    this.logger.info('=== Demonstrating Error Handling ===');
    
    // Division by zero
    try {
      await this.mathService.divide(10, 0);
    } catch (error) {
      this.logger.info('Handled division by zero', { 
        error: error.message, 
        code: error.code 
      });
    }
    
    // Invalid input validation
    try {
      await this.mathService.add('invalid', 5);
    } catch (error) {
      this.logger.info('Handled validation error', { 
        error: error.message 
      });
    }
    
    // Negative square root
    try {
      await this.mathService.sqrt(-16);
    } catch (error) {
      this.logger.info('Handled negative square root', { 
        error: error.message 
      });
    }
    
    // Invalid advanced operation
    try {
      await this.mathService.advancedOperation([1, 2, 3], 'invalid_operation');
    } catch (error) {
      this.logger.info('Handled invalid operation', { 
        error: error.message,
        operation: error.operation 
      });
    }
    
    // Invalid equation
    try {
      await this.mathService.solveEquation('invalid + + equation');
    } catch (error) {
      this.logger.info('Handled invalid equation', { 
        error: error.message 
      });
    }
  }

  /**
   * Demonstrate retry logic with network simulation
   */
  async demonstrateRetryLogic() {
    this.logger.info('=== Demonstrating Retry Logic ===');
    
    // Create a service with shorter timeouts to simulate network issues
    const testService = new MathApiService({
      baseURL: 'http://localhost:3005/api/v1',
      timeout: 2000,
      retry: {
        enabled: true,
        maxAttempts: 3,
        baseDelay: 100,
        backoffMultiplier: 1.5
      }
    });
    
    try {
      // This should succeed normally
      const result = await testService.add(5, 5);
      this.logger.info('Operation succeeded', { result: result.result });
      
      // Check retry statistics
      const metrics = testService.getMetrics();
      if (metrics.retryStats.totalRetries > 0) {
        this.logger.info('Retries occurred', { 
          retries: metrics.retryStats.totalRetries,
          attempts: metrics.retryStats.totalAttempts
        });
      }
      
    } catch (error) {
      this.logger.error('Retry demonstration failed', { error: error.message });
    } finally {
      testService.close();
    }
  }

  /**
   * Demonstrate input validation
   */
  async demonstrateValidation() {
    this.logger.info('=== Demonstrating Input Validation ===');
    
    const validationTests = [
      // Valid inputs
      { description: 'Valid addition', operation: () => this.mathService.add(10, 20) },
      { description: 'Valid precision', operation: () => this.mathService.divide(10, 3, { precision: 2 }) },
      
      // Invalid inputs
      { description: 'Invalid number type', operation: () => this.mathService.add('abc', 20), shouldFail: true },
      { description: 'Missing parameters', operation: () => this.mathService.add(), shouldFail: true },
      { description: 'Invalid precision', operation: () => this.mathService.add(1, 2, { precision: -1 }), shouldFail: true },
      { description: 'Empty array', operation: () => this.mathService.advancedOperation([], 'sum'), shouldFail: true },
      { description: 'Invalid array element', operation: () => this.mathService.advancedOperation([1, 'two'], 'sum'), shouldFail: true }
    ];
    
    for (const test of validationTests) {
      try {
        const result = await test.operation();
        if (test.shouldFail) {
          this.logger.warn('Expected validation error but operation succeeded', { 
            description: test.description 
          });
        } else {
          this.logger.info('Validation passed', { 
            description: test.description,
            result: result.result 
          });
        }
      } catch (error) {
        if (test.shouldFail) {
          this.logger.info('Validation correctly failed', { 
            description: test.description,
            error: error.message 
          });
        } else {
          this.logger.error('Unexpected validation failure', { 
            description: test.description,
            error: error.message 
          });
        }
      }
    }
  }

  /**
   * Demonstrate monitoring and metrics
   */
  async demonstrateMonitoring() {
    this.logger.info('=== Demonstrating Monitoring and Metrics ===');
    
    // Perform various operations to generate metrics
    await this.mathService.add(1, 1);
    await this.mathService.multiply(2, 2);
    await this.mathService.advancedOperation([1, 2, 3, 4], 'average');
    
    // Try some operations that might fail
    try {
      await this.mathService.divide(1, 0);
    } catch (e) {
      // Expected
    }
    
    // Get comprehensive metrics
    const metrics = this.mathService.getMetrics();
    
    this.logger.info('Request Metrics', {
      totalRequests: metrics.requests.total,
      successfulRequests: metrics.requests.success,
      failedRequests: metrics.requests.errors,
      successRate: `${metrics.requests.successRate.toFixed(2)}%`,
      errorRate: `${metrics.requests.errorRate.toFixed(2)}%`
    });
    
    this.logger.info('Response Time Metrics', {
      averageResponseTime: `${metrics.timing.averageResponseTime}ms`,
      minResponseTime: `${metrics.timing.minResponseTime}ms`,
      maxResponseTime: `${metrics.timing.maxResponseTime}ms`,
      p50: `${metrics.timing.percentiles.p50 || 'N/A'}ms`,
      p95: `${metrics.timing.percentiles.p95 || 'N/A'}ms`
    });
    
    this.logger.info('Throughput Metrics', {
      requestsPerMinute: metrics.throughput.requestsPerMinute,
      requestsPerSecond: metrics.throughput.requestsPerSecond
    });
    
    if (metrics.requests.byMethod) {
      this.logger.info('Requests by Method', metrics.requests.byMethod);
    }
    
    if (metrics.requests.byStatus) {
      this.logger.info('Requests by Status', metrics.requests.byStatus);
    }
  }

  /**
   * Demonstrate health checks and service monitoring
   */
  async demonstrateHealthChecks() {
    this.logger.info('=== Demonstrating Health Checks ===');
    
    // Service health check
    const serviceHealth = await this.mathService.healthCheck();
    this.logger.info('Service Health Check', {
      service: serviceHealth.service,
      client: serviceHealth.client.status,
      uptime: serviceHealth.uptime
    });
    
    // Get service statistics
    const stats = await this.mathService.getStats();
    this.logger.info('Service Statistics', {
      totalRequests: stats.requests,
      uptime: `${Math.round(stats.uptime / 1000)}s`,
      historyCount: stats.historyCount,
      operationCounts: stats.operationCounts
    });
    
    // Circuit breaker state
    if (stats.clientMetrics && stats.clientMetrics.circuitBreaker) {
      this.logger.info('Circuit Breaker State', {
        state: stats.clientMetrics.circuitBreaker.state,
        failureCount: stats.clientMetrics.circuitBreaker.failureCount,
        successCount: stats.clientMetrics.circuitBreaker.successCount
      });
    }
  }

  /**
   * Display final comprehensive metrics
   */
  async displayFinalMetrics() {
    this.logger.info('=== Final Metrics Summary ===');
    
    const metrics = this.mathService.getMetrics();
    const serverInfo = this.server.getInfo();
    
    // Client-side metrics
    this.logger.info('Client Metrics Summary', {
      totalRequests: metrics.requests.total,
      successRate: `${metrics.requests.successRate.toFixed(2)}%`,
      averageResponseTime: `${metrics.timing.averageResponseTime}ms`,
      totalRetries: metrics.retryStats?.totalRetries || 0,
      circuitBreakerState: metrics.circuitBreaker?.state || 'N/A'
    });
    
    // Server-side metrics
    this.logger.info('Server Metrics Summary', {
      serverRequests: serverInfo.stats.requests,
      serverErrors: serverInfo.stats.errors,
      historyEntries: serverInfo.historyCount,
      uptime: `${Math.round((Date.now() - serverInfo.stats.startTime) / 1000)}s`
    });
    
    // Get calculation history
    try {
      const history = await this.mathService.getHistory(5);
      this.logger.info('Recent Calculations', {
        count: history.items.length,
        operations: history.items.map(item => ({
          operation: item.operation,
          result: item.result
        }))
      });
    } catch (error) {
      this.logger.warn('Could not retrieve history', { error: error.message });
    }
  }

  /**
   * Clean up resources
   */
  async cleanup() {
    this.logger.info('Cleaning up resources...');
    
    if (this.mathService) {
      this.mathService.close();
    }
    
    if (this.server) {
      await this.server.stop();
    }
    
    this.logger.info('Demo completed successfully');
  }
}

// Run the demo
const demo = new ApiIntegrationDemo();
demo.run().catch(console.error);