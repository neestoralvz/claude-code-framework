import { MathApiService } from '../src/services/MathApiService.js';
import { MockMathServer } from '../src/mock/MockMathServer.js';
import { Logger } from '../src/utils/Logger.js';

/**
 * API Monitoring and Observability Demo
 * 
 * Demonstrates comprehensive monitoring, metrics collection,
 * and observability features of the API integration solution
 */
class MonitoringDemo {
  constructor() {
    this.logger = new Logger('MonitoringDemo');
    this.server = null;
    this.services = [];
    this.monitoringInterval = null;
  }

  /**
   * Run the monitoring demonstration
   */
  async run() {
    try {
      this.logger.info('Starting API Monitoring Demo');
      
      await this.setupEnvironment();
      await this.simulateTrafficPatterns();
      await this.demonstrateCircuitBreaker();
      await this.demonstrateErrorScenarios();
      await this.monitorPerformance();
      
    } catch (error) {
      this.logger.error('Monitoring demo failed', { error: error.message });
    } finally {
      await this.cleanup();
    }
  }

  /**
   * Setup monitoring environment
   */
  async setupEnvironment() {
    this.logger.info('Setting up monitoring environment...');
    
    // Start mock server
    this.server = new MockMathServer({ port: 3006 });
    await this.server.start();
    
    // Create multiple service instances with different configurations
    this.services = [
      new MathApiService({
        baseURL: 'http://localhost:3006/api/v1',
        timeout: 5000,
        retry: { enabled: true, maxAttempts: 3 },
        circuitBreaker: { enabled: true, failureThreshold: 3 }
      }),
      new MathApiService({
        baseURL: 'http://localhost:3006/api/v1',
        timeout: 2000,
        retry: { enabled: true, maxAttempts: 2 },
        circuitBreaker: { enabled: true, failureThreshold: 5 }
      }),
      new MathApiService({
        baseURL: 'http://localhost:3006/api/v1',
        timeout: 10000,
        retry: { enabled: false },
        circuitBreaker: { enabled: false }
      })
    ];
    
    this.logger.info('Environment setup complete', {
      serverPort: 3006,
      serviceInstances: this.services.length
    });
  }

  /**
   * Simulate different traffic patterns
   */
  async simulateTrafficPatterns() {
    this.logger.info('=== Simulating Traffic Patterns ===');
    
    // Start real-time monitoring
    this.startRealTimeMonitoring();
    
    await this.simulateNormalTraffic();
    await this.simulateBurstTraffic();
    await this.simulateSustainedLoad();
    
    // Stop monitoring
    this.stopRealTimeMonitoring();
  }

  /**
   * Start real-time metrics monitoring
   */
  startRealTimeMonitoring() {
    this.logger.info('Starting real-time monitoring...');
    
    this.monitoringInterval = setInterval(() => {
      this.services.forEach((service, index) => {
        const metrics = service.getMetrics();
        
        this.logger.info(`Service ${index + 1} Metrics`, {
          requests: metrics.requests.total,
          successRate: `${metrics.requests.successRate.toFixed(2)}%`,
          avgResponseTime: `${metrics.timing.averageResponseTime.toFixed(2)}ms`,
          requestsPerMinute: metrics.throughput.requestsPerMinute,
          circuitBreakerState: metrics.circuitBreaker?.state || 'N/A'
        });
      });
    }, 5000); // Report every 5 seconds
  }

  /**
   * Stop real-time monitoring
   */
  stopRealTimeMonitoring() {
    if (this.monitoringInterval) {
      clearInterval(this.monitoringInterval);
      this.monitoringInterval = null;
    }
    this.logger.info('Stopped real-time monitoring');
  }

  /**
   * Simulate normal traffic patterns
   */
  async simulateNormalTraffic() {
    this.logger.info('Simulating normal traffic...');
    
    const operations = [
      () => this.services[0].add(Math.random() * 100, Math.random() * 100),
      () => this.services[1].multiply(Math.random() * 10, Math.random() * 10),
      () => this.services[2].divide(Math.random() * 100 + 1, Math.random() * 10 + 1),
      () => this.services[0].sqrt(Math.random() * 100)
    ];
    
    // Execute operations at regular intervals
    for (let i = 0; i < 20; i++) {
      const operation = operations[i % operations.length];
      
      try {
        await operation();
        await this.sleep(200); // 200ms between requests
      } catch (error) {
        // Log errors but continue
        this.logger.debug('Operation failed during normal traffic', {
          error: error.message
        });
      }
    }
    
    this.logger.info('Normal traffic simulation complete');
  }

  /**
   * Simulate burst traffic
   */
  async simulateBurstTraffic() {
    this.logger.info('Simulating burst traffic...');
    
    // Create a burst of concurrent requests
    const burstPromises = [];
    
    for (let i = 0; i < 15; i++) {
      const serviceIndex = i % this.services.length;
      const service = this.services[serviceIndex];
      
      burstPromises.push(
        service.add(i, i * 2).catch(error => ({
          error: error.message,
          service: serviceIndex
        }))
      );
    }
    
    const results = await Promise.all(burstPromises);
    
    const successCount = results.filter(r => !r.error).length;
    const errorCount = results.filter(r => r.error).length;
    
    this.logger.info('Burst traffic results', {
      totalRequests: results.length,
      successful: successCount,
      errors: errorCount,
      successRate: `${(successCount / results.length * 100).toFixed(2)}%`
    });
  }

  /**
   * Simulate sustained load
   */
  async simulateSustainedLoad() {
    this.logger.info('Simulating sustained load...');
    
    const startTime = Date.now();
    const duration = 10000; // 10 seconds
    let requestCount = 0;
    
    while (Date.now() - startTime < duration) {
      const promises = this.services.map((service, index) => 
        service.advancedOperation([1, 2, 3, 4, 5], 'average')
          .catch(error => ({ error: error.message, service: index }))
      );
      
      await Promise.all(promises);
      requestCount += promises.length;
      
      await this.sleep(100); // 100ms between batches
    }
    
    const actualDuration = Date.now() - startTime;
    const requestsPerSecond = (requestCount / actualDuration * 1000).toFixed(2);
    
    this.logger.info('Sustained load complete', {
      duration: `${actualDuration}ms`,
      totalRequests: requestCount,
      requestsPerSecond
    });
  }

  /**
   * Demonstrate circuit breaker behavior
   */
  async demonstrateCircuitBreaker() {
    this.logger.info('=== Demonstrating Circuit Breaker Behavior ===');
    
    // Create a service with aggressive circuit breaker settings
    const testService = new MathApiService({
      baseURL: 'http://localhost:9999/api/v1', // Non-existent server
      timeout: 1000,
      retry: { enabled: false }, // Disable retry for cleaner circuit breaker demo
      circuitBreaker: {
        enabled: true,
        failureThreshold: 3,
        resetTimeout: 5000,
        monitoringPeriod: 2000,
        volumeThreshold: 3
      }
    });
    
    // Generate failures to trigger circuit breaker
    this.logger.info('Generating failures to trigger circuit breaker...');
    
    for (let i = 0; i < 8; i++) {
      try {
        await testService.add(1, 2);
      } catch (error) {
        const cbState = testService.getMetrics().circuitBreaker;
        this.logger.info(`Attempt ${i + 1}`, {
          error: error.code || 'UNKNOWN',
          circuitBreakerState: cbState.state,
          failureCount: cbState.failureCount
        });
        
        // If circuit breaker is open, wait a bit to show blocking behavior
        if (error.code === 'CIRCUIT_BREAKER_OPEN') {
          await this.sleep(1000);
        }
      }
    }
    
    // Show circuit breaker metrics
    const finalMetrics = testService.getMetrics();
    this.logger.info('Final circuit breaker state', {
      state: finalMetrics.circuitBreaker.state,
      failureCount: finalMetrics.circuitBreaker.failureCount,
      requestCount: finalMetrics.circuitBreaker.requestCount,
      errorRate: `${finalMetrics.circuitBreaker.errorRate}%`
    });
    
    testService.close();
  }

  /**
   * Demonstrate error scenario monitoring
   */
  async demonstrateErrorScenarios() {
    this.logger.info('=== Demonstrating Error Scenario Monitoring ===');
    
    const service = this.services[0];
    
    // Clear history to start fresh
    try {
      await service.clearHistory();
    } catch (e) {
      // Ignore if not supported
    }
    
    const errorScenarios = [
      {
        name: 'Division by zero',
        operation: () => service.divide(10, 0)
      },
      {
        name: 'Invalid input type',
        operation: () => service.add('invalid', 5)
      },
      {
        name: 'Negative square root',
        operation: () => service.sqrt(-16)
      },
      {
        name: 'Empty array operation',
        operation: () => service.advancedOperation([], 'sum')
      },
      {
        name: 'Invalid operation type',
        operation: () => service.advancedOperation([1, 2, 3], 'invalid')
      }
    ];
    
    for (const scenario of errorScenarios) {
      try {
        await scenario.operation();
        this.logger.warn('Expected error but operation succeeded', {
          scenario: scenario.name
        });
      } catch (error) {
        this.logger.info('Error scenario captured', {
          scenario: scenario.name,
          errorCode: error.code,
          errorMessage: error.message,
          operation: error.operation
        });
      }
    }
    
    // Show error metrics
    const metrics = service.getMetrics();
    this.logger.info('Error metrics summary', {
      totalErrors: metrics.requests.errors,
      errorRate: `${metrics.requests.errorRate.toFixed(2)}%`,
      errorsByType: metrics.errors?.byType || 'N/A',
      recentErrors: metrics.errors?.recent?.length || 0
    });
  }

  /**
   * Monitor performance characteristics
   */
  async monitorPerformance() {
    this.logger.info('=== Performance Monitoring ===');
    
    // Create service for performance testing
    const perfService = new MathApiService({
      baseURL: 'http://localhost:3006/api/v1',
      timeout: 30000
    });
    
    // Test different operation types and their performance
    const performanceTests = [
      {
        name: 'Simple Addition',
        operation: () => perfService.add(Math.random() * 1000, Math.random() * 1000),
        iterations: 50
      },
      {
        name: 'Complex Calculation',
        operation: () => perfService.power(Math.random() * 10 + 1, Math.random() * 5 + 1),
        iterations: 30
      },
      {
        name: 'Array Operations',
        operation: () => {
          const numbers = Array.from({ length: 100 }, () => Math.random() * 100);
          return perfService.advancedOperation(numbers, 'average');
        },
        iterations: 20
      }
    ];
    
    for (const test of performanceTests) {
      this.logger.info(`Running performance test: ${test.name}`);
      
      const startTime = Date.now();
      const promises = [];
      
      for (let i = 0; i < test.iterations; i++) {
        promises.push(test.operation());
      }
      
      try {
        await Promise.all(promises);
        const duration = Date.now() - startTime;
        const avgTime = duration / test.iterations;
        
        this.logger.info(`Performance test results: ${test.name}`, {
          totalTime: `${duration}ms`,
          iterations: test.iterations,
          averageTime: `${avgTime.toFixed(2)}ms`,
          throughput: `${(test.iterations / duration * 1000).toFixed(2)} req/s`
        });
      } catch (error) {
        this.logger.error(`Performance test failed: ${test.name}`, {
          error: error.message
        });
      }
    }
    
    // Show final performance metrics
    const perfMetrics = perfService.getMetrics();
    this.logger.info('Performance metrics summary', {
      totalRequests: perfMetrics.requests.total,
      averageResponseTime: `${perfMetrics.timing.averageResponseTime.toFixed(2)}ms`,
      minResponseTime: `${perfMetrics.timing.minResponseTime}ms`,
      maxResponseTime: `${perfMetrics.timing.maxResponseTime}ms`,
      p50: `${perfMetrics.timing.percentiles.p50 || 'N/A'}ms`,
      p95: `${perfMetrics.timing.percentiles.p95 || 'N/A'}ms`,
      p99: `${perfMetrics.timing.percentiles.p99 || 'N/A'}ms`
    });
    
    perfService.close();
  }

  /**
   * Generate comprehensive monitoring report
   */
  async generateMonitoringReport() {
    this.logger.info('=== Comprehensive Monitoring Report ===');
    
    // Aggregate metrics from all services
    const aggregatedMetrics = this.services.reduce((acc, service, index) => {
      const metrics = service.getMetrics();
      
      acc.totalRequests += metrics.requests.total;
      acc.totalSuccesses += metrics.requests.success;
      acc.totalErrors += metrics.requests.errors;
      acc.responseTimesSum += metrics.timing.averageResponseTime * metrics.requests.total;
      
      acc.serviceMetrics[index] = {
        requests: metrics.requests.total,
        successRate: metrics.requests.successRate,
        avgResponseTime: metrics.timing.averageResponseTime,
        circuitBreakerState: metrics.circuitBreaker?.state || 'N/A'
      };
      
      return acc;
    }, {
      totalRequests: 0,
      totalSuccesses: 0,
      totalErrors: 0,
      responseTimesSum: 0,
      serviceMetrics: {}
    });
    
    // Calculate aggregate statistics
    const overallSuccessRate = aggregatedMetrics.totalRequests > 0
      ? (aggregatedMetrics.totalSuccesses / aggregatedMetrics.totalRequests * 100)
      : 0;
    
    const overallAvgResponseTime = aggregatedMetrics.totalRequests > 0
      ? (aggregatedMetrics.responseTimesSum / aggregatedMetrics.totalRequests)
      : 0;
    
    this.logger.info('Aggregate Performance Report', {
      totalRequests: aggregatedMetrics.totalRequests,
      successRate: `${overallSuccessRate.toFixed(2)}%`,
      errorRate: `${((aggregatedMetrics.totalErrors / aggregatedMetrics.totalRequests) * 100).toFixed(2)}%`,
      averageResponseTime: `${overallAvgResponseTime.toFixed(2)}ms`,
      serviceCount: this.services.length
    });
    
    // Individual service reports
    Object.entries(aggregatedMetrics.serviceMetrics).forEach(([index, metrics]) => {
      this.logger.info(`Service ${parseInt(index) + 1} Report`, metrics);
    });
    
    // Server-side metrics
    const serverInfo = this.server.getInfo();
    this.logger.info('Server Performance Report', {
      totalRequests: serverInfo.stats.requests,
      errors: serverInfo.stats.errors,
      uptime: `${Math.round((Date.now() - serverInfo.stats.startTime) / 1000)}s`,
      historySize: serverInfo.historyCount
    });
  }

  /**
   * Utility function to sleep
   */
  async sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  /**
   * Clean up resources
   */
  async cleanup() {
    this.logger.info('Generating final monitoring report...');
    await this.generateMonitoringReport();
    
    this.logger.info('Cleaning up monitoring demo resources...');
    
    // Stop real-time monitoring if still running
    this.stopRealTimeMonitoring();
    
    // Close all service instances
    this.services.forEach((service, index) => {
      service.close();
      this.logger.debug(`Closed service ${index + 1}`);
    });
    
    // Stop mock server
    if (this.server) {
      await this.server.stop();
    }
    
    this.logger.info('Monitoring demo completed successfully');
  }
}

// Run the monitoring demo
const demo = new MonitoringDemo();
demo.run().catch(console.error);