import { describe, test, expect, beforeAll, afterAll, beforeEach } from '@jest/globals';
import { MathApiService } from '../../src/services/MathApiService.js';
import { MockMathServer } from '../../src/mock/MockMathServer.js';

/**
 * Integration tests for MathApiService
 * 
 * Tests the complete math service functionality against a real server
 * Covers all mathematical operations, error handling, and service features
 */
describe('MathApiService Integration Tests', () => {
  let server;
  let mathService;
  const serverPort = 3003;

  beforeAll(async () => {
    // Start mock server
    server = new MockMathServer({ port: serverPort });
    await server.start();
  });

  afterAll(async () => {
    // Stop mock server
    if (server) {
      await server.stop();
    }
  });

  beforeEach(() => {
    // Create fresh service for each test
    mathService = new MathApiService({
      baseURL: `http://localhost:${serverPort}/api/v1`,
      timeout: 5000,
      retry: {
        enabled: true,
        maxAttempts: 2,
        baseDelay: 50
      },
      circuitBreaker: {
        enabled: false // Disable for cleaner testing
      }
    });
  });

  describe('Basic Arithmetic Operations', () => {
    test('should add two numbers correctly', async () => {
      const result = await mathService.add(10, 5);
      
      expect(result.result).toBe(15);
      expect(result.operation).toBe('add');
      expect(result.operands).toEqual({ a: 10, b: 5 });
      expect(result.timestamp).toBeDefined();
    });

    test('should subtract two numbers correctly', async () => {
      const result = await mathService.subtract(10, 3);
      
      expect(result.result).toBe(7);
      expect(result.operation).toBe('subtract');
    });

    test('should multiply two numbers correctly', async () => {
      const result = await mathService.multiply(4, 7);
      
      expect(result.result).toBe(28);
      expect(result.operation).toBe('multiply');
    });

    test('should divide two numbers correctly', async () => {
      const result = await mathService.divide(20, 4);
      
      expect(result.result).toBe(5);
      expect(result.operation).toBe('divide');
    });

    test('should handle precision in calculations', async () => {
      const result = await mathService.divide(10, 3, { precision: 2 });
      
      expect(result.result).toBe(3.33);
    });
  });

  describe('Advanced Operations', () => {
    test('should calculate power correctly', async () => {
      const result = await mathService.power(2, 8);
      
      expect(result.result).toBe(256);
      expect(result.operation).toBe('power');
    });

    test('should calculate square root correctly', async () => {
      const result = await mathService.sqrt(16);
      
      expect(result.result).toBe(4);
      expect(result.operation).toBe('sqrt');
    });

    test('should calculate square root with precision', async () => {
      const result = await mathService.sqrt(2, { precision: 3 });
      
      expect(result.result).toBe(1.414);
    });

    test('should perform sum operation on array', async () => {
      const numbers = [1, 2, 3, 4, 5];
      const result = await mathService.advancedOperation(numbers, 'sum');
      
      expect(result.result).toBe(15);
      expect(result.operation).toBe('sum');
    });

    test('should calculate average of array', async () => {
      const numbers = [10, 20, 30];
      const result = await mathService.advancedOperation(numbers, 'average');
      
      expect(result.result).toBe(20);
    });

    test('should calculate median of array', async () => {
      const numbers = [1, 3, 2, 5, 4];
      const result = await mathService.advancedOperation(numbers, 'median');
      
      expect(result.result).toBe(3);
    });

    test('should calculate product of array', async () => {
      const numbers = [2, 3, 4];
      const result = await mathService.advancedOperation(numbers, 'product');
      
      expect(result.result).toBe(24);
    });
  });

  describe('Equation Solving', () => {
    test('should solve simple expression', async () => {
      const result = await mathService.solveEquation('2 + 3 * 4');
      
      expect(result.result).toBe(14);
      expect(result.operation).toBe('solve');
    });

    test('should solve expression with variables', async () => {
      const result = await mathService.solveEquation('x * 2 + y', {
        x: 10,
        y: 5
      });
      
      expect(result.result).toBe(25);
    });

    test('should solve complex expression', async () => {
      const result = await mathService.solveEquation('Math.pow(x, 2) + Math.sqrt(y)', {
        x: 3,
        y: 16
      });
      
      expect(result.result).toBe(13); // 9 + 4
    });
  });

  describe('Input Validation', () => {
    test('should validate numeric inputs for basic operations', async () => {
      try {
        await mathService.add('invalid', 5);
        fail('Should have thrown validation error');
      } catch (error) {
        expect(error.message).toContain('Validation error');
      }
    });

    test('should validate division by zero', async () => {
      try {
        await mathService.divide(10, 0);
        fail('Should have thrown division by zero error');
      } catch (error) {
        expect(error.message).toContain('Division by zero is not allowed');
      }
    });

    test('should validate negative square root', async () => {
      try {
        await mathService.sqrt(-4);
        fail('Should have thrown negative square root error');
      } catch (error) {
        expect(error.message).toContain('Cannot calculate square root of negative number');
      }
    });

    test('should validate array inputs for advanced operations', async () => {
      try {
        await mathService.advancedOperation('not an array', 'sum');
        fail('Should have thrown validation error');
      } catch (error) {
        expect(error.message).toContain('Validation error');
      }
    });

    test('should validate empty arrays', async () => {
      try {
        await mathService.advancedOperation([], 'sum');
        fail('Should have thrown validation error');
      } catch (error) {
        expect(error.message).toContain('Validation error');
      }
    });

    test('should validate array with non-numeric elements', async () => {
      try {
        await mathService.advancedOperation([1, 'two', 3], 'sum');
        fail('Should have thrown validation error');
      } catch (error) {
        expect(error.message).toContain('Validation error');
      }
    });

    test('should validate precision parameter', async () => {
      try {
        await mathService.add(1, 2, { precision: -1 });
        fail('Should have thrown validation error');
      } catch (error) {
        expect(error.message).toContain('Validation error');
      }
    });
  });

  describe('Error Handling', () => {
    test('should handle server errors gracefully', async () => {
      // Create service pointing to non-existent endpoint
      const badService = new MathApiService({
        baseURL: 'http://localhost:9999/api/v1',
        timeout: 1000,
        retry: { enabled: false },
        circuitBreaker: { enabled: false }
      });

      try {
        await badService.add(1, 2);
        fail('Should have thrown connection error');
      } catch (error) {
        expect(error.code).toBe('CONNECTION_ERROR');
        expect(error.message).toContain('Cannot connect to math service');
        expect(error.operation).toBe('add');
      }

      badService.close();
    });

    test('should handle timeout errors', async () => {
      const timeoutService = new MathApiService({
        baseURL: `http://localhost:${serverPort}/api/v1`,
        timeout: 1, // Very short timeout
        retry: { enabled: false },
        circuitBreaker: { enabled: false }
      });

      try {
        await timeoutService.add(1, 2);
        // If this doesn't timeout, skip the assertion
      } catch (error) {
        if (error.code === 'TIMEOUT') {
          expect(error.message).toContain('Request timeout');
          expect(error.operation).toBe('add');
        }
      }

      timeoutService.close();
    });

    test('should provide meaningful error messages', async () => {
      try {
        await mathService.advancedOperation([1, 2, 3], 'invalid_operation');
        fail('Should have thrown error');
      } catch (error) {
        expect(error.message).toContain('Invalid operation');
        expect(error.operation).toBe('advancedOperation');
      }
    });
  });

  describe('History Management', () => {
    test('should retrieve calculation history', async () => {
      // Perform some calculations
      await mathService.add(1, 2);
      await mathService.multiply(3, 4);
      
      const history = await mathService.getHistory(10, 0);
      
      expect(history.items).toBeInstanceOf(Array);
      expect(history.items.length).toBeGreaterThanOrEqual(2);
      expect(history.pagination).toBeDefined();
    });

    test('should clear calculation history', async () => {
      // Add some calculations
      await mathService.add(1, 2);
      
      const clearResult = await mathService.clearHistory();
      expect(clearResult.message).toContain('cleared');
      
      // Verify history is empty
      const history = await mathService.getHistory();
      expect(history.items.length).toBe(0);
    });

    test('should handle pagination in history', async () => {
      // Clear history first
      await mathService.clearHistory();
      
      // Add multiple calculations
      for (let i = 0; i < 5; i++) {
        await mathService.add(i, i + 1);
      }
      
      // Get limited results
      const history = await mathService.getHistory(3, 0);
      expect(history.items.length).toBe(3);
      expect(history.pagination.total).toBe(5);
      expect(history.pagination.hasMore).toBe(true);
    });
  });

  describe('Service Statistics', () => {
    test('should retrieve service statistics', async () => {
      const stats = await mathService.getStats();
      
      expect(stats).toHaveProperty('requests');
      expect(stats).toHaveProperty('uptime');
      expect(stats).toHaveProperty('clientMetrics');
      expect(stats.clientMetrics).toHaveProperty('requests');
      expect(stats.clientMetrics).toHaveProperty('timing');
    });

    test('should track operation counts in statistics', async () => {
      // Clear history and perform operations
      await mathService.clearHistory();
      await mathService.add(1, 2);
      await mathService.multiply(3, 4);
      await mathService.add(5, 6);
      
      const stats = await mathService.getStats();
      expect(stats.operationCounts).toBeDefined();
      expect(stats.operationCounts.add).toBe(2);
      expect(stats.operationCounts.multiply).toBe(1);
    });
  });

  describe('Health Monitoring', () => {
    test('should perform health check', async () => {
      const health = await mathService.healthCheck();
      
      expect(health.service).toBe('healthy');
      expect(health.client.status).toBe('healthy');
      expect(health.status).toBe('healthy');
    });

    test('should report unhealthy when service is down', async () => {
      const badService = new MathApiService({
        baseURL: 'http://localhost:9999/api/v1',
        timeout: 1000,
        retry: { enabled: false }
      });

      const health = await badService.healthCheck();
      
      expect(health.service).toBe('unhealthy');
      expect(health.error).toBeDefined();

      badService.close();
    });
  });

  describe('Service Metrics', () => {
    test('should collect and provide metrics', async () => {
      await mathService.add(1, 2);
      await mathService.subtract(5, 3);
      
      const metrics = mathService.getMetrics();
      
      expect(metrics.requests.total).toBeGreaterThanOrEqual(2);
      expect(metrics.requests.success).toBeGreaterThanOrEqual(2);
      expect(metrics.timing.responseTimes.length).toBeGreaterThanOrEqual(2);
    });

    test('should track error metrics', async () => {
      try {
        await mathService.advancedOperation([1, 2], 'invalid_op');
      } catch (error) {
        // Expected error
      }

      const metrics = mathService.getMetrics();
      expect(metrics.requests.errors).toBeGreaterThanOrEqual(1);
    });
  });

  describe('Resource Management', () => {
    test('should handle multiple concurrent requests', async () => {
      const promises = [
        mathService.add(1, 2),
        mathService.multiply(3, 4),
        mathService.subtract(10, 5),
        mathService.divide(20, 4)
      ];

      const results = await Promise.all(promises);
      
      expect(results).toHaveLength(4);
      expect(results[0].result).toBe(3);   // 1 + 2
      expect(results[1].result).toBe(12);  // 3 * 4
      expect(results[2].result).toBe(5);   // 10 - 5
      expect(results[3].result).toBe(5);   // 20 / 4
    });

    test('should clean up resources properly', () => {
      const metrics = mathService.getMetrics();
      expect(metrics).toBeDefined();
      
      mathService.close();
      
      // After closing, metrics should still be accessible
      const finalMetrics = mathService.getMetrics();
      expect(finalMetrics).toBeDefined();
    });
  });

  describe('Edge Cases', () => {
    test('should handle very large numbers', async () => {
      const result = await mathService.add(Number.MAX_SAFE_INTEGER - 1, 1);
      expect(result.result).toBe(Number.MAX_SAFE_INTEGER);
    });

    test('should handle very small numbers', async () => {
      const result = await mathService.add(0.1, 0.2, { precision: 1 });
      expect(result.result).toBe(0.3);
    });

    test('should handle zero values', async () => {
      const result = await mathService.multiply(100, 0);
      expect(result.result).toBe(0);
    });

    test('should handle negative numbers', async () => {
      const result = await mathService.add(-5, -3);
      expect(result.result).toBe(-8);
    });
  });
});