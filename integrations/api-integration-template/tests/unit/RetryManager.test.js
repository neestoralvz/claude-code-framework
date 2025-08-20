import { describe, test, expect, beforeEach, afterEach, jest } from '@jest/globals';
import { RetryManager } from '../../src/core/RetryManager.js';

/**
 * Unit tests for RetryManager
 * 
 * Tests retry logic with exponential backoff and jitter
 * Covers all retry conditions and configuration options
 */
describe('RetryManager Unit Tests', () => {
  let retryManager;
  let mockOperation;

  beforeEach(() => {
    // Mock operation that can succeed or fail
    mockOperation = jest.fn();
    
    retryManager = new RetryManager({
      enabled: true,
      maxAttempts: 3,
      baseDelay: 100,
      maxDelay: 5000,
      backoffMultiplier: 2,
      jitterFactor: 0.1
    });

    // Mock Date.now() and setTimeout for time-based tests
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.clearAllMocks();
    jest.useRealTimers();
    retryManager.resetStats();
  });

  describe('Initialization', () => {
    test('should initialize with default configuration', () => {
      const rm = new RetryManager();
      const stats = rm.getStats();
      
      expect(stats.enabled).toBe(true);
      expect(stats.config.maxAttempts).toBe(3);
      expect(stats.config.baseDelay).toBe(1000);
      expect(stats.config.backoffMultiplier).toBe(2);
    });

    test('should initialize with custom configuration', () => {
      const config = {
        maxAttempts: 5,
        baseDelay: 500,
        maxDelay: 10000,
        backoffMultiplier: 1.5
      };
      
      const rm = new RetryManager(config);
      const stats = rm.getStats();
      
      expect(stats.config.maxAttempts).toBe(5);
      expect(stats.config.baseDelay).toBe(500);
      expect(stats.config.maxDelay).toBe(10000);
      expect(stats.config.backoffMultiplier).toBe(1.5);
    });

    test('should be disabled when configured', () => {
      const rm = new RetryManager({ enabled: false });
      expect(rm.getStats().enabled).toBe(false);
    });
  });

  describe('Successful Operations', () => {
    test('should execute operation once when it succeeds', async () => {
      mockOperation.mockResolvedValue('success');
      
      const result = await retryManager.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(1);
    });

    test('should not retry successful operations', async () => {
      mockOperation.mockResolvedValue('success');
      
      await retryManager.execute(mockOperation);
      
      const stats = retryManager.getStats();
      expect(stats.totalRetries).toBe(0);
      expect(stats.totalAttempts).toBe(1);
    });
  });

  describe('Failed Operations', () => {
    test('should retry on network errors', async () => {
      const networkError = new Error('Network Error');
      networkError.code = 'ECONNRESET';
      
      mockOperation
        .mockRejectedValueOnce(networkError)
        .mockRejectedValueOnce(networkError)
        .mockResolvedValueOnce('success');
      
      const result = await retryManager.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(3);
    });

    test('should retry on timeout errors', async () => {
      const timeoutError = new Error('Timeout');
      timeoutError.code = 'ETIMEDOUT';
      
      mockOperation
        .mockRejectedValueOnce(timeoutError)
        .mockResolvedValueOnce('success');
      
      const result = await retryManager.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(2);
    });

    test('should retry on 5xx server errors', async () => {
      const serverError = new Error('Internal Server Error');
      serverError.response = { status: 500 };
      
      mockOperation
        .mockRejectedValueOnce(serverError)
        .mockResolvedValueOnce('success');
      
      const result = await retryManager.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(2);
    });

    test('should retry on 429 rate limit errors', async () => {
      const rateLimitError = new Error('Too Many Requests');
      rateLimitError.response = { status: 429 };
      
      mockOperation
        .mockRejectedValueOnce(rateLimitError)
        .mockResolvedValueOnce('success');
      
      const result = await retryManager.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(2);
    });

    test('should NOT retry on 4xx client errors (except 429, 408)', async () => {
      const clientError = new Error('Bad Request');
      clientError.response = { status: 400 };
      
      mockOperation.mockRejectedValue(clientError);
      
      try {
        await retryManager.execute(mockOperation);
        fail('Should have thrown error');
      } catch (error) {
        expect(error).toBe(clientError);
      }
      
      expect(mockOperation).toHaveBeenCalledTimes(1);
      
      const stats = retryManager.getStats();
      expect(stats.totalRetries).toBe(0);
    });

    test('should exhaust all retry attempts and throw final error', async () => {
      const persistentError = new Error('Persistent failure');
      persistentError.code = 'ECONNRESET';
      
      mockOperation.mockRejectedValue(persistentError);
      
      try {
        await retryManager.execute(mockOperation);
        fail('Should have thrown error');
      } catch (error) {
        expect(error).toBe(persistentError);
      }
      
      expect(mockOperation).toHaveBeenCalledTimes(3); // maxAttempts
      
      const stats = retryManager.getStats();
      expect(stats.totalRetries).toBe(2); // 3 attempts - 1 initial = 2 retries
      expect(stats.permanentFailures).toBe(1);
    });
  });

  describe('Delay Calculation', () => {
    test('should calculate exponential backoff delays', () => {
      const delays = [];
      for (let attempt = 1; attempt <= 4; attempt++) {
        const delay = retryManager.calculateDelay(attempt);
        delays.push(delay);
      }
      
      // Each delay should be roughly double the previous (with jitter)
      expect(delays[1]).toBeGreaterThan(delays[0]);
      expect(delays[2]).toBeGreaterThan(delays[1]);
      expect(delays[3]).toBeGreaterThan(delays[2]);
      
      // Should respect max delay
      expect(delays[3]).toBeLessThanOrEqual(retryManager.maxDelay);
    });

    test('should apply jitter to delays', () => {
      const delays = [];
      for (let i = 0; i < 10; i++) {
        delays.push(retryManager.calculateDelay(2));
      }
      
      // With jitter, delays should vary
      const uniqueDelays = new Set(delays);
      expect(uniqueDelays.size).toBeGreaterThan(1);
    });

    test('should respect maximum delay limit', () => {
      const rm = new RetryManager({
        baseDelay: 1000,
        maxDelay: 2000,
        backoffMultiplier: 10
      });
      
      const delay = rm.calculateDelay(5); // Would be very large without max
      expect(delay).toBeLessThanOrEqual(2000);
    });
  });

  describe('Custom Retry Conditions', () => {
    test('should use custom retry condition', async () => {
      const customRetryManager = new RetryManager({
        maxAttempts: 2,
        retryCondition: (error, attempt) => {
          return error.message === 'CUSTOM_RETRY' && attempt < 2;
        }
      });
      
      const customError = new Error('CUSTOM_RETRY');
      mockOperation
        .mockRejectedValueOnce(customError)
        .mockResolvedValueOnce('success');
      
      const result = await customRetryManager.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(2);
    });

    test('should create custom retry condition with static method', () => {
      const customCondition = RetryManager.createRetryCondition({
        maxAttempts: 2,
        retryOnStatus: [503, 504],
        retryOnNetworkError: false
      });
      
      // Should retry on 503
      const error503 = new Error('Service Unavailable');
      error503.response = { status: 503 };
      expect(customCondition(error503, 1)).toBe(true);
      
      // Should not retry on network error
      const networkError = new Error('Network Error');
      networkError.code = 'ECONNRESET';
      expect(customCondition(networkError, 1)).toBe(false);
      
      // Should not retry beyond max attempts
      expect(customCondition(error503, 2)).toBe(false);
    });
  });

  describe('Disabled Retry Manager', () => {
    test('should execute operation once when disabled', async () => {
      const disabledRM = new RetryManager({ enabled: false });
      mockOperation.mockResolvedValue('success');
      
      const result = await disabledRM.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(1);
    });

    test('should pass through errors when disabled', async () => {
      const disabledRM = new RetryManager({ enabled: false });
      const error = new Error('Test error');
      mockOperation.mockRejectedValue(error);
      
      try {
        await disabledRM.execute(mockOperation);
        fail('Should have thrown error');
      } catch (thrownError) {
        expect(thrownError).toBe(error);
      }
      
      expect(mockOperation).toHaveBeenCalledTimes(1);
    });
  });

  describe('Statistics and Metrics', () => {
    test('should track retry statistics', async () => {
      const networkError = new Error('Network Error');
      networkError.code = 'ECONNRESET';
      
      // Test successful retry
      mockOperation
        .mockRejectedValueOnce(networkError)
        .mockResolvedValueOnce('success');
      
      await retryManager.execute(mockOperation);
      
      // Test permanent failure
      mockOperation.mockRejectedValue(networkError);
      try {
        await retryManager.execute(mockOperation);
      } catch (e) {
        // Expected
      }
      
      const stats = retryManager.getStats();
      expect(stats.totalAttempts).toBe(5); // 2 + 3 attempts
      expect(stats.totalRetries).toBe(3); // 1 + 2 retries
      expect(stats.successAfterRetry).toBe(1);
      expect(stats.permanentFailures).toBe(1);
      expect(stats.retryRate).toBeGreaterThan(0);
      expect(stats.successAfterRetryRate).toBeGreaterThan(0);
    });

    test('should calculate retry rate correctly', async () => {
      // Execute operations to generate meaningful statistics
      const error = new Error('Test');
      error.code = 'ECONNRESET';
      
      // 1 successful operation (no retry)
      mockOperation.mockResolvedValueOnce('success');
      await retryManager.execute(mockOperation);
      
      // 1 operation that succeeds after retry
      mockOperation
        .mockRejectedValueOnce(error)
        .mockResolvedValueOnce('success');
      await retryManager.execute(mockOperation);
      
      const stats = retryManager.getStats();
      expect(stats.totalAttempts).toBe(3); // 1 + 2 attempts
      expect(stats.totalRetries).toBe(1); // 0 + 1 retries
      expect(stats.retryRate).toBeCloseTo(33.33); // 1/3 * 100
    });

    test('should reset statistics', async () => {
      const error = new Error('Test');
      error.code = 'ECONNRESET';
      
      mockOperation.mockRejectedValue(error);
      
      try {
        await retryManager.execute(mockOperation);
      } catch (e) {
        // Expected
      }
      
      expect(retryManager.getStats().totalAttempts).toBeGreaterThan(0);
      
      retryManager.resetStats();
      
      const stats = retryManager.getStats();
      expect(stats.totalAttempts).toBe(0);
      expect(stats.totalRetries).toBe(0);
      expect(stats.successAfterRetry).toBe(0);
      expect(stats.permanentFailures).toBe(0);
    });
  });

  describe('Edge Cases', () => {
    test('should handle immediate success on first retry', async () => {
      const error = new Error('One-time failure');
      error.code = 'ECONNRESET';
      
      mockOperation
        .mockRejectedValueOnce(error)
        .mockResolvedValue('success');
      
      const result = await retryManager.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(2);
      
      const stats = retryManager.getStats();
      expect(stats.successAfterRetry).toBe(1);
    });

    test('should handle zero max attempts', async () => {
      const zeroRetryRM = new RetryManager({ maxAttempts: 0 });
      const error = new Error('Test');
      error.code = 'ECONNRESET';
      
      mockOperation.mockRejectedValue(error);
      
      try {
        await zeroRetryRM.execute(mockOperation);
        fail('Should have thrown error');
      } catch (thrownError) {
        expect(thrownError).toBe(error);
      }
      
      expect(mockOperation).toHaveBeenCalledTimes(0);
    });

    test('should handle missing error properties gracefully', async () => {
      const basicError = new Error('Basic error');
      // No code or response properties
      
      mockOperation.mockRejectedValue(basicError);
      
      try {
        await retryManager.execute(mockOperation);
        fail('Should have thrown error');
      } catch (thrownError) {
        expect(thrownError).toBe(basicError);
      }
      
      // Should not retry basic errors without specific conditions
      expect(mockOperation).toHaveBeenCalledTimes(1);
    });

    test('should handle context parameter', async () => {
      mockOperation.mockResolvedValue('success');
      
      const context = { url: 'http://example.com/test' };
      const result = await retryManager.execute(mockOperation, context);
      
      expect(result).toBe('success');
    });
  });

  describe('Sleep Function', () => {
    test('should sleep for specified duration', async () => {
      const sleepPromise = retryManager.sleep(1000);
      
      // Advance timers
      jest.advanceTimersByTime(1000);
      
      await expect(sleepPromise).resolves.toBeUndefined();
    });

    test('should not resolve before specified duration', async () => {
      const sleepPromise = retryManager.sleep(1000);
      
      // Advance timers by less than sleep duration
      jest.advanceTimersByTime(500);
      
      let resolved = false;
      sleepPromise.then(() => { resolved = true; });
      
      // Should not have resolved yet
      await Promise.resolve(); // Allow promise to settle if it would
      expect(resolved).toBe(false);
      
      // Complete the sleep
      jest.advanceTimersByTime(500);
      await sleepPromise;
      expect(resolved).toBe(true);
    });
  });

  describe('Integration with Real Delays', () => {
    beforeEach(() => {
      // Use real timers for this test suite
      jest.useRealTimers();
    });

    test('should actually wait between retries', async () => {
      const shortDelayRM = new RetryManager({
        maxAttempts: 2,
        baseDelay: 10, // Very short delay
        backoffMultiplier: 1
      });
      
      const error = new Error('Network Error');
      error.code = 'ECONNRESET';
      
      const startTime = Date.now();
      
      mockOperation
        .mockRejectedValueOnce(error)
        .mockResolvedValueOnce('success');
      
      const result = await shortDelayRM.execute(mockOperation);
      
      const elapsed = Date.now() - startTime;
      
      expect(result).toBe('success');
      expect(elapsed).toBeGreaterThanOrEqual(10); // Should have waited at least base delay
      expect(mockOperation).toHaveBeenCalledTimes(2);
    });
  });
});