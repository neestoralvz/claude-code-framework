import { Logger } from '../utils/Logger.js';

/**
 * Circuit Breaker Pattern Implementation
 * 
 * Prevents cascading failures by temporarily stopping requests to failing services
 * States: CLOSED (normal), OPEN (blocking), HALF_OPEN (testing)
 */
export class CircuitBreaker {
  constructor(config = {}) {
    this.enabled = config.enabled !== false;
    this.failureThreshold = config.failureThreshold || 5;
    this.resetTimeout = config.resetTimeout || 60000; // 1 minute
    this.monitoringPeriod = config.monitoringPeriod || 10000; // 10 seconds
    this.volumeThreshold = config.volumeThreshold || 10;
    this.errorPercentageThreshold = config.errorPercentageThreshold || 50;
    
    this.state = 'CLOSED';
    this.failureCount = 0;
    this.successCount = 0;
    this.requestCount = 0;
    this.lastFailureTime = null;
    this.nextAttemptTime = null;
    
    this.logger = new Logger('CircuitBreaker');
    
    if (this.enabled) {
      this.logger.info('Circuit breaker initialized', {
        failureThreshold: this.failureThreshold,
        resetTimeout: this.resetTimeout,
        monitoringPeriod: this.monitoringPeriod
      });
    }
  }

  /**
   * Execute operation with circuit breaker protection
   */
  async execute(operation, context = {}) {
    if (!this.enabled) {
      return await operation();
    }

    const canExecute = this.canExecute();
    
    if (!canExecute) {
      const error = new Error('Circuit breaker is OPEN');
      error.code = 'CIRCUIT_BREAKER_OPEN';
      error.state = this.state;
      error.nextAttemptTime = this.nextAttemptTime;
      
      this.logger.warn('Request blocked by circuit breaker', {
        state: this.state,
        failureCount: this.failureCount,
        nextAttemptTime: this.nextAttemptTime,
        context
      });
      
      throw error;
    }

    try {
      const result = await operation();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure(error);
      throw error;
    }
  }

  /**
   * Check if requests can be executed
   */
  canExecute() {
    const now = Date.now();

    switch (this.state) {
      case 'CLOSED':
        return true;
        
      case 'OPEN':
        if (now >= this.nextAttemptTime) {
          this.transitionToHalfOpen();
          return true;
        }
        return false;
        
      case 'HALF_OPEN':
        return true;
        
      default:
        return false;
    }
  }

  /**
   * Handle successful operation
   */
  onSuccess() {
    this.successCount++;
    this.requestCount++;

    if (this.state === 'HALF_OPEN') {
      this.transitionToClosed();
    } else if (this.state === 'CLOSED') {
      this.resetCountersIfNeeded();
    }
  }

  /**
   * Handle failed operation
   */
  onFailure(error) {
    this.failureCount++;
    this.requestCount++;
    this.lastFailureTime = Date.now();

    this.logger.debug('Operation failed', {
      error: error.message,
      failureCount: this.failureCount,
      state: this.state
    });

    if (this.state === 'HALF_OPEN') {
      this.transitionToOpen();
    } else if (this.state === 'CLOSED' && this.shouldOpen()) {
      this.transitionToOpen();
    }
  }

  /**
   * Check if circuit breaker should open
   */
  shouldOpen() {
    // Check minimum volume threshold
    if (this.requestCount < this.volumeThreshold) {
      return false;
    }

    // Check failure threshold
    if (this.failureCount >= this.failureThreshold) {
      return true;
    }

    // Check error percentage
    const errorPercentage = (this.failureCount / this.requestCount) * 100;
    return errorPercentage >= this.errorPercentageThreshold;
  }

  /**
   * Transition to CLOSED state
   */
  transitionToClosed() {
    this.state = 'CLOSED';
    this.failureCount = 0;
    this.successCount = 0;
    this.requestCount = 0;
    this.lastFailureTime = null;
    this.nextAttemptTime = null;

    this.logger.info('Circuit breaker transitioned to CLOSED', {
      state: this.state
    });
  }

  /**
   * Transition to OPEN state
   */
  transitionToOpen() {
    this.state = 'OPEN';
    this.nextAttemptTime = Date.now() + this.resetTimeout;

    this.logger.warn('Circuit breaker transitioned to OPEN', {
      state: this.state,
      failureCount: this.failureCount,
      requestCount: this.requestCount,
      nextAttemptTime: this.nextAttemptTime,
      resetTimeout: this.resetTimeout
    });
  }

  /**
   * Transition to HALF_OPEN state
   */
  transitionToHalfOpen() {
    this.state = 'HALF_OPEN';
    this.successCount = 0;
    this.failureCount = 0;
    this.requestCount = 0;

    this.logger.info('Circuit breaker transitioned to HALF_OPEN', {
      state: this.state
    });
  }

  /**
   * Reset counters if monitoring period has passed
   */
  resetCountersIfNeeded() {
    const now = Date.now();
    const timeSinceLastFailure = this.lastFailureTime ? now - this.lastFailureTime : Infinity;

    if (timeSinceLastFailure > this.monitoringPeriod) {
      this.failureCount = 0;
      this.successCount = 0;
      this.requestCount = 0;
      this.lastFailureTime = null;
    }
  }

  /**
   * Get current circuit breaker state
   */
  getState() {
    return {
      enabled: this.enabled,
      state: this.state,
      failureCount: this.failureCount,
      successCount: this.successCount,
      requestCount: this.requestCount,
      lastFailureTime: this.lastFailureTime,
      nextAttemptTime: this.nextAttemptTime,
      config: {
        failureThreshold: this.failureThreshold,
        resetTimeout: this.resetTimeout,
        monitoringPeriod: this.monitoringPeriod,
        volumeThreshold: this.volumeThreshold,
        errorPercentageThreshold: this.errorPercentageThreshold
      }
    };
  }

  /**
   * Reset circuit breaker to initial state
   */
  reset() {
    this.transitionToClosed();
    this.logger.info('Circuit breaker reset');
  }

  /**
   * Force circuit breaker to OPEN state
   */
  forceOpen() {
    this.transitionToOpen();
    this.logger.warn('Circuit breaker forced to OPEN state');
  }

  /**
   * Get metrics for monitoring
   */
  getMetrics() {
    const now = Date.now();
    const errorRate = this.requestCount > 0 ? (this.failureCount / this.requestCount) * 100 : 0;
    
    return {
      state: this.state,
      errorRate: parseFloat(errorRate.toFixed(2)),
      failureCount: this.failureCount,
      successCount: this.successCount,
      requestCount: this.requestCount,
      timeToNextAttempt: this.nextAttemptTime ? Math.max(0, this.nextAttemptTime - now) : 0,
      timeSinceLastFailure: this.lastFailureTime ? now - this.lastFailureTime : null
    };
  }
}