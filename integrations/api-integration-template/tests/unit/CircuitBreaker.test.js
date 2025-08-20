import { describe, test, expect, beforeEach, afterEach, jest } from '@jest/globals';
import { CircuitBreaker } from '../../src/core/CircuitBreaker.js';

/**
 * Unit tests for CircuitBreaker
 * 
 * Tests the circuit breaker pattern implementation
 * Covers all states, transitions, and configuration options
 */
describe('CircuitBreaker Unit Tests', () => {
  let circuitBreaker;
  let mockOperation;

  beforeEach(() => {
    // Mock operation that can succeed or fail
    mockOperation = jest.fn();
    
    circuitBreaker = new CircuitBreaker({
      enabled: true,
      failureThreshold: 3,
      resetTimeout: 1000,
      monitoringPeriod: 5000,
      volumeThreshold: 5,
      errorPercentageThreshold: 50
    });
  });

  afterEach(() => {
    jest.clearAllMocks();
    circuitBreaker.reset();
  });

  describe('Initialization', () => {
    test('should initialize with default configuration', () => {
      const cb = new CircuitBreaker();
      const state = cb.getState();
      
      expect(state.enabled).toBe(true);
      expect(state.state).toBe('CLOSED');
      expect(state.failureCount).toBe(0);
      expect(state.config.failureThreshold).toBe(5);
    });

    test('should initialize with custom configuration', () => {
      const config = {
        failureThreshold: 2,
        resetTimeout: 5000,
        volumeThreshold: 3
      };
      
      const cb = new CircuitBreaker(config);
      const state = cb.getState();
      
      expect(state.config.failureThreshold).toBe(2);
      expect(state.config.resetTimeout).toBe(5000);
      expect(state.config.volumeThreshold).toBe(3);
    });

    test('should be disabled when configured', () => {
      const cb = new CircuitBreaker({ enabled: false });
      expect(cb.getState().enabled).toBe(false);
    });
  });

  describe('CLOSED State Operations', () => {
    test('should execute operation successfully when closed', async () => {
      mockOperation.mockResolvedValue('success');
      
      const result = await circuitBreaker.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(1);
      expect(circuitBreaker.getState().state).toBe('CLOSED');
    });

    test('should handle single failure without opening', async () => {
      const error = new Error('Test failure');
      mockOperation.mockRejectedValue(error);
      
      try {
        await circuitBreaker.execute(mockOperation);
        fail('Should have thrown error');
      } catch (thrownError) {
        expect(thrownError).toBe(error);
      }
      
      const state = circuitBreaker.getState();
      expect(state.state).toBe('CLOSED');
      expect(state.failureCount).toBe(1);
    });

    test('should remain closed if failure count is below threshold', async () => {
      const error = new Error('Test failure');
      mockOperation.mockRejectedValue(error);
      
      // Execute 2 failures (below threshold of 3)
      for (let i = 0; i < 2; i++) {
        try {
          await circuitBreaker.execute(mockOperation);
        } catch (e) {
          // Expected
        }
      }
      
      const state = circuitBreaker.getState();
      expect(state.state).toBe('CLOSED');
      expect(state.failureCount).toBe(2);
    });
  });

  describe('State Transitions', () => {
    test('should transition to OPEN after reaching failure threshold', async () => {
      const error = new Error('Test failure');
      mockOperation.mockRejectedValue(error);
      
      // Execute failures to meet volume threshold first
      for (let i = 0; i < 5; i++) {
        try {
          await circuitBreaker.execute(mockOperation);
        } catch (e) {
          // Expected
        }
      }
      
      const state = circuitBreaker.getState();
      expect(state.state).toBe('OPEN');
      expect(state.nextAttemptTime).toBeGreaterThan(Date.now());
    });

    test('should transition to OPEN based on error percentage', async () => {
      // Mix of successes and failures to test percentage logic
      mockOperation
        .mockResolvedValueOnce('success')
        .mockResolvedValueOnce('success')
        .mockResolvedValueOnce('success')
        .mockRejectedValueOnce(new Error('failure'))
        .mockRejectedValueOnce(new Error('failure'))
        .mockRejectedValueOnce(new Error('failure'))
        .mockRejectedValueOnce(new Error('failure'));
      
      // Execute operations to meet volume threshold (5)
      // 3 successes, then 4 failures = 57% error rate (above 50% threshold)
      for (let i = 0; i < 7; i++) {
        try {
          await circuitBreaker.execute(mockOperation);
        } catch (e) {
          // Expected for failures
        }
      }
      
      const state = circuitBreaker.getState();
      expect(state.state).toBe('OPEN');
    });

    test('should transition to HALF_OPEN after reset timeout', async () => {
      // Force to OPEN state
      circuitBreaker.forceOpen();
      expect(circuitBreaker.getState().state).toBe('OPEN');
      
      // Wait for reset timeout (mocking time passage)
      circuitBreaker.nextAttemptTime = Date.now() - 1000; // Past time
      
      // Should transition to HALF_OPEN on next execution attempt
      mockOperation.mockResolvedValue('success');
      await circuitBreaker.execute(mockOperation);
      
      expect(circuitBreaker.getState().state).toBe('CLOSED'); // Should go directly to CLOSED on success
    });

    test('should transition from HALF_OPEN to CLOSED on success', async () => {
      // Manually set to HALF_OPEN state
      circuitBreaker.transitionToHalfOpen();
      expect(circuitBreaker.getState().state).toBe('HALF_OPEN');
      
      mockOperation.mockResolvedValue('success');
      const result = await circuitBreaker.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(circuitBreaker.getState().state).toBe('CLOSED');
    });

    test('should transition from HALF_OPEN to OPEN on failure', async () => {
      // Manually set to HALF_OPEN state
      circuitBreaker.transitionToHalfOpen();
      expect(circuitBreaker.getState().state).toBe('HALF_OPEN');
      
      const error = new Error('Test failure');
      mockOperation.mockRejectedValue(error);
      
      try {
        await circuitBreaker.execute(mockOperation);
        fail('Should have thrown error');
      } catch (thrownError) {
        expect(thrownError).toBe(error);
      }
      
      expect(circuitBreaker.getState().state).toBe('OPEN');
    });
  });

  describe('OPEN State Behavior', () => {
    test('should reject requests immediately when OPEN', async () => {
      circuitBreaker.forceOpen();
      
      try {
        await circuitBreaker.execute(mockOperation);
        fail('Should have thrown circuit breaker error');
      } catch (error) {
        expect(error.code).toBe('CIRCUIT_BREAKER_OPEN');
        expect(error.message).toContain('Circuit breaker is OPEN');
        expect(error.state).toBe('OPEN');
      }
      
      expect(mockOperation).not.toHaveBeenCalled();
    });

    test('should include retry information in OPEN state error', async () => {
      circuitBreaker.forceOpen();
      
      try {
        await circuitBreaker.execute(mockOperation);
        fail('Should have thrown error');
      } catch (error) {
        expect(error.nextAttemptTime).toBeDefined();
        expect(error.nextAttemptTime).toBeGreaterThan(Date.now());
      }
    });
  });

  describe('Disabled Circuit Breaker', () => {
    test('should execute operations normally when disabled', async () => {
      const disabledCB = new CircuitBreaker({ enabled: false });
      mockOperation.mockResolvedValue('success');
      
      const result = await disabledCB.execute(mockOperation);
      
      expect(result).toBe('success');
      expect(mockOperation).toHaveBeenCalledTimes(1);
    });

    test('should pass through errors when disabled', async () => {
      const disabledCB = new CircuitBreaker({ enabled: false });
      const error = new Error('Test error');
      mockOperation.mockRejectedValue(error);
      
      try {
        await disabledCB.execute(mockOperation);
        fail('Should have thrown error');
      } catch (thrownError) {
        expect(thrownError).toBe(error);
      }
      
      expect(mockOperation).toHaveBeenCalledTimes(1);
    });
  });

  describe('Metrics and State', () => {
    test('should provide detailed state information', () => {
      const state = circuitBreaker.getState();
      
      expect(state).toHaveProperty('enabled');
      expect(state).toHaveProperty('state');
      expect(state).toHaveProperty('failureCount');
      expect(state).toHaveProperty('successCount');
      expect(state).toHaveProperty('requestCount');
      expect(state).toHaveProperty('config');
      expect(state.config).toHaveProperty('failureThreshold');
      expect(state.config).toHaveProperty('resetTimeout');
    });

    test('should track success and failure counts', async () => {
      mockOperation.mockResolvedValue('success');
      await circuitBreaker.execute(mockOperation);
      
      const error = new Error('failure');
      mockOperation.mockRejectedValue(error);
      try {
        await circuitBreaker.execute(mockOperation);
      } catch (e) {
        // Expected
      }
      
      const state = circuitBreaker.getState();
      expect(state.successCount).toBe(1);
      expect(state.failureCount).toBe(1);
      expect(state.requestCount).toBe(2);
    });

    test('should provide metrics including error rates', () => {
      // Execute some operations to generate metrics
      circuitBreaker.onSuccess();
      circuitBreaker.onSuccess();
      circuitBreaker.onFailure(new Error('test'));
      
      const metrics = circuitBreaker.getMetrics();
      
      expect(metrics).toHaveProperty('state');
      expect(metrics).toHaveProperty('errorRate');
      expect(metrics).toHaveProperty('failureCount');
      expect(metrics).toHaveProperty('successCount');
      expect(metrics.errorRate).toBe(33.33); // 1 failure out of 3 requests
    });
  });

  describe('Reset and Force Operations', () => {
    test('should reset to initial state', async () => {
      // Generate some failures
      const error = new Error('failure');
      mockOperation.mockRejectedValue(error);
      
      for (let i = 0; i < 3; i++) {
        try {
          await circuitBreaker.execute(mockOperation);
        } catch (e) {
          // Expected
        }
      }
      
      expect(circuitBreaker.getState().failureCount).toBe(3);
      
      circuitBreaker.reset();
      
      const state = circuitBreaker.getState();
      expect(state.state).toBe('CLOSED');
      expect(state.failureCount).toBe(0);
      expect(state.successCount).toBe(0);
      expect(state.requestCount).toBe(0);
    });

    test('should force OPEN state', () => {
      expect(circuitBreaker.getState().state).toBe('CLOSED');
      
      circuitBreaker.forceOpen();
      
      expect(circuitBreaker.getState().state).toBe('OPEN');
    });
  });

  describe('Edge Cases', () => {
    test('should handle rapid state transitions', async () => {
      const error = new Error('failure');
      
      // Rapidly execute failing operations
      const promises = [];
      for (let i = 0; i < 10; i++) {
        mockOperation.mockRejectedValueOnce(error);
        promises.push(
          circuitBreaker.execute(mockOperation).catch(e => e)
        );
      }
      
      await Promise.all(promises);
      
      // Should eventually be in OPEN state
      const finalState = circuitBreaker.getState();
      expect(['OPEN', 'CLOSED']).toContain(finalState.state);
    });

    test('should handle zero thresholds gracefully', () => {
      const cb = new CircuitBreaker({
        failureThreshold: 0,
        volumeThreshold: 0
      });
      
      const state = cb.getState();
      expect(state.config.failureThreshold).toBe(0);
      expect(state.config.volumeThreshold).toBe(0);
    });

    test('should handle missing context parameter', async () => {
      mockOperation.mockResolvedValue('success');
      
      // Execute without context
      const result = await circuitBreaker.execute(mockOperation);
      
      expect(result).toBe('success');
    });
  });

  describe('Time-based Behavior', () => {
    test('should respect monitoring period for counter reset', () => {
      const cb = new CircuitBreaker({
        monitoringPeriod: 1000
      });
      
      // Simulate failure
      cb.onFailure(new Error('test'));
      expect(cb.getState().failureCount).toBe(1);
      
      // Mock time passage beyond monitoring period
      cb.lastFailureTime = Date.now() - 2000;
      
      // Should reset counters
      cb.resetCountersIfNeeded();
      expect(cb.getState().failureCount).toBe(0);
    });

    test('should calculate time to next attempt correctly', () => {
      circuitBreaker.forceOpen();
      
      const metrics = circuitBreaker.getMetrics();
      expect(metrics.timeToNextAttempt).toBeGreaterThan(0);
      expect(metrics.timeToNextAttempt).toBeLessThanOrEqual(1000); // Reset timeout
    });
  });
});