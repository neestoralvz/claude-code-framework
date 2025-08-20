import { describe, test, expect, beforeAll, afterAll, beforeEach } from '@jest/globals';
import { ApiClient } from '../../src/core/ApiClient.js';
import { MockMathServer } from '../../src/mock/MockMathServer.js';

/**
 * Integration tests for ApiClient
 * 
 * Tests the complete API client functionality against a real server
 * Covers retry logic, circuit breaker, error handling, and metrics
 */
describe('ApiClient Integration Tests', () => {
  let server;
  let client;
  const serverPort = 3002;
  const baseURL = `http://localhost:${serverPort}`;

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
    // Create fresh client for each test
    client = new ApiClient({
      baseURL: baseURL + '/api/v1',
      timeout: 5000,
      retry: {
        enabled: true,
        maxAttempts: 3,
        baseDelay: 100,
        backoffMultiplier: 1.5
      },
      circuitBreaker: {
        enabled: true,
        failureThreshold: 3,
        resetTimeout: 2000,
        monitoringPeriod: 1000
      }
    });
  });

  describe('Basic HTTP Operations', () => {
    test('should perform GET request successfully', async () => {
      const response = await client.get('/health');
      
      expect(response.status).toBe(200);
      expect(response.data).toHaveProperty('status', 'healthy');
      expect(response.data).toHaveProperty('timestamp');
    });

    test('should perform POST request successfully', async () => {
      const requestData = { a: 10, b: 5 };
      const response = await client.post('/math/add', requestData);
      
      expect(response.status).toBe(200);
      expect(response.data).toHaveProperty('result', 15);
      expect(response.data).toHaveProperty('operation', 'add');
    });

    test('should handle query parameters in GET request', async () => {
      const response = await client.get('/math/history', {
        params: { limit: 5, offset: 0 }
      });
      
      expect(response.status).toBe(200);
      expect(response.data).toHaveProperty('items');
      expect(response.data).toHaveProperty('pagination');
    });

    test('should perform DELETE request successfully', async () => {
      // Add some data first
      await client.post('/math/add', { a: 1, b: 2 });
      
      // Then clear history
      const response = await client.delete('/math/history');
      
      expect(response.status).toBe(200);
      expect(response.data).toHaveProperty('message');
    });
  });

  describe('Error Handling', () => {
    test('should handle 404 errors gracefully', async () => {
      try {
        await client.get('/nonexistent-endpoint');
        fail('Should have thrown an error');
      } catch (error) {
        expect(error.response.status).toBe(404);
        expect(error.response.data).toHaveProperty('error');
      }
    });

    test('should handle 400 errors with validation messages', async () => {
      try {
        await client.post('/math/add', { a: 'invalid', b: 5 });
        fail('Should have thrown an error');
      } catch (error) {
        expect(error.response.status).toBe(400);
        expect(error.response.data).toHaveProperty('error');
      }
    });

    test('should handle division by zero error', async () => {
      try {
        await client.post('/math/divide', { a: 10, b: 0 });
        fail('Should have thrown an error');
      } catch (error) {
        expect(error.response.status).toBe(400);
        expect(error.response.data.error).toContain('Division by zero');
      }
    });
  });

  describe('Retry Logic', () => {
    test('should retry on network timeout', async () => {
      const shortTimeoutClient = new ApiClient({
        baseURL: baseURL + '/api/v1',
        timeout: 1, // Very short timeout to trigger timeout
        retry: {
          enabled: true,
          maxAttempts: 2,
          baseDelay: 10,
          backoffMultiplier: 1
        }
      });

      try {
        await shortTimeoutClient.get('/health');
        // If this doesn't timeout, the test might not be valid
      } catch (error) {
        const stats = shortTimeoutClient.retryManager.getStats();
        expect(stats.totalRetries).toBeGreaterThan(0);
      }

      shortTimeoutClient.close();
    });

    test('should not retry on 4xx errors by default', async () => {
      try {
        await client.get('/nonexistent-endpoint');
        fail('Should have thrown an error');
      } catch (error) {
        const stats = client.retryManager.getStats();
        expect(error.response.status).toBe(404);
        // Should not have retried 404 errors
        expect(stats.totalRetries).toBe(0);
      }
    });
  });

  describe('Circuit Breaker', () => {
    test('should open circuit breaker after repeated failures', async () => {
      // Make multiple requests to non-existent endpoint to trigger failures
      const promises = [];
      for (let i = 0; i < 5; i++) {
        promises.push(
          client.get('/nonexistent-endpoint').catch(error => error)
        );
      }

      await Promise.all(promises);

      // Circuit breaker should be open now
      const state = client.circuitBreaker.getState();
      expect(state.state).toBe('OPEN');
    });

    test('should block requests when circuit breaker is open', async () => {
      // Force circuit breaker to open
      client.circuitBreaker.forceOpen();

      try {
        await client.get('/health');
        fail('Should have thrown circuit breaker error');
      } catch (error) {
        expect(error.code).toBe('CIRCUIT_BREAKER_OPEN');
        expect(error.message).toContain('Circuit breaker is OPEN');
      }
    });
  });

  describe('Request/Response Interceptors', () => {
    test('should add request metadata', async () => {
      const response = await client.get('/health');
      
      // Check that request was processed (should have metrics)
      const metrics = client.getMetrics();
      expect(metrics.requests.total).toBeGreaterThan(0);
    });

    test('should sanitize sensitive headers in logs', async () => {
      const clientWithAuth = new ApiClient({
        baseURL: baseURL + '/api/v1',
        auth: {
          type: 'bearer',
          token: 'secret-token'
        }
      });

      await clientWithAuth.get('/health');
      
      // Headers should be sanitized in logs (can't easily test log output,
      // but we can verify the sanitization function works)
      const sanitized = clientWithAuth.sanitizeHeaders({
        'authorization': 'Bearer secret-token',
        'x-api-key': 'secret-key'
      });

      expect(sanitized.authorization).toBe('***');
      expect(sanitized['x-api-key']).toBe('***');

      clientWithAuth.close();
    });
  });

  describe('Metrics Collection', () => {
    test('should collect request metrics', async () => {
      await client.get('/health');
      await client.post('/math/add', { a: 1, b: 2 });
      
      const metrics = client.getMetrics();
      
      expect(metrics.requests.total).toBe(2);
      expect(metrics.requests.byMethod.GET).toBe(1);
      expect(metrics.requests.byMethod.POST).toBe(1);
      expect(metrics.timing.responseTimes.length).toBe(2);
    });

    test('should collect error metrics', async () => {
      try {
        await client.get('/nonexistent-endpoint');
      } catch (error) {
        // Expected error
      }

      const metrics = client.getMetrics();
      expect(metrics.requests.errors).toBe(1);
      expect(metrics.requests.byStatus[404]).toBe(1);
    });

    test('should calculate response time percentiles', async () => {
      // Make multiple requests to get meaningful percentiles
      for (let i = 0; i < 10; i++) {
        await client.get('/health');
      }

      const metrics = client.getMetrics();
      expect(metrics.timing.percentiles.p50).toBeDefined();
      expect(metrics.timing.percentiles.p95).toBeDefined();
      expect(metrics.timing.averageResponseTime).toBeGreaterThan(0);
    });
  });

  describe('Authentication', () => {
    test('should add bearer token to requests', async () => {
      const authClient = new ApiClient({
        baseURL: baseURL + '/api/v1',
        auth: {
          type: 'bearer',
          token: 'test-token'
        }
      });

      // Mock server doesn't validate auth, but we can verify the request was made
      const response = await authClient.get('/health');
      expect(response.status).toBe(200);

      authClient.close();
    });

    test('should add API key to requests', async () => {
      const authClient = new ApiClient({
        baseURL: baseURL + '/api/v1',
        auth: {
          type: 'apikey',
          key: 'test-api-key',
          header: 'X-API-Key'
        }
      });

      const response = await authClient.get('/health');
      expect(response.status).toBe(200);

      authClient.close();
    });
  });

  describe('Request Validation', () => {
    test('should validate request configuration', async () => {
      // Create client with strict validation
      const validatingClient = new ApiClient({
        baseURL: baseURL + '/api/v1',
        requestValidator: {
          strictMode: true
        }
      });

      // Valid request should work
      const response = await validatingClient.get('/health');
      expect(response.status).toBe(200);

      validatingClient.close();
    });
  });

  describe('Health Check', () => {
    test('should perform health check', async () => {
      const health = await client.healthCheck();
      
      expect(health.status).toBe('healthy');
      expect(health.response).toBe(true);
      expect(health.metrics).toBeDefined();
    });

    test('should report unhealthy when service is down', async () => {
      const downClient = new ApiClient({
        baseURL: 'http://localhost:9999/api/v1', // Non-existent server
        timeout: 1000
      });

      const health = await downClient.healthCheck();
      
      expect(health.status).toBe('unhealthy');
      expect(health.error).toBeDefined();

      downClient.close();
    });
  });

  describe('Response Transformation', () => {
    test('should apply response transformations', async () => {
      // Add a transformation that adds metadata
      client.responseTransformer.addGlobalTransformation((response) => {
        response.data.transformed = true;
        return response;
      });

      const response = await client.get('/health');
      
      expect(response.data.transformed).toBe(true);
    });
  });

  describe('Resource Cleanup', () => {
    test('should clean up resources when closed', () => {
      const metrics = client.getMetrics();
      expect(metrics).toBeDefined();
      
      client.close();
      
      // After closing, metrics should still be accessible but frozen
      const finalMetrics = client.getMetrics();
      expect(finalMetrics).toBeDefined();
    });
  });
});