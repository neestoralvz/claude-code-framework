import { Logger } from '../utils/Logger.js';

/**
 * Retry Manager with exponential backoff and jitter
 * 
 * Implements intelligent retry logic for transient failures
 * Features:
 * - Exponential backoff with configurable multiplier
 * - Jitter to prevent thundering herd
 * - Configurable retry conditions
 * - Maximum retry attempts and timeout
 */
export class RetryManager {
  constructor(config = {}) {
    this.enabled = config.enabled !== false;
    this.maxAttempts = config.maxAttempts || 3;
    this.baseDelay = config.baseDelay || 1000; // 1 second
    this.maxDelay = config.maxDelay || 30000; // 30 seconds
    this.backoffMultiplier = config.backoffMultiplier || 2;
    this.jitterFactor = config.jitterFactor || 0.1;
    this.retryCondition = config.retryCondition || this.defaultRetryCondition;
    
    this.stats = {
      totalAttempts: 0,
      totalRetries: 0,
      successAfterRetry: 0,
      permanentFailures: 0
    };
    
    this.logger = new Logger('RetryManager');
    
    if (this.enabled) {
      this.logger.info('Retry manager initialized', {
        maxAttempts: this.maxAttempts,
        baseDelay: this.baseDelay,
        maxDelay: this.maxDelay,
        backoffMultiplier: this.backoffMultiplier
      });
    }
  }

  /**
   * Execute operation with retry logic
   */
  async execute(operation, context = {}) {
    if (!this.enabled) {
      return await operation();
    }

    let lastError;
    let attempt = 1;

    while (attempt <= this.maxAttempts) {
      this.stats.totalAttempts++;
      
      try {
        this.logger.debug('Executing operation', {
          attempt,
          maxAttempts: this.maxAttempts,
          context: context.url || 'unknown'
        });

        const result = await operation();
        
        if (attempt > 1) {
          this.stats.successAfterRetry++;
          this.logger.info('Operation succeeded after retry', {
            attempt,
            totalAttempts: attempt,
            context: context.url || 'unknown'
          });
        }
        
        return result;
      } catch (error) {
        lastError = error;
        
        this.logger.debug('Operation failed', {
          attempt,
          error: error.message,
          status: error.response?.status,
          context: context.url || 'unknown'
        });

        // Check if we should retry this error
        if (!this.shouldRetry(error, attempt)) {
          this.stats.permanentFailures++;
          this.logger.debug('Not retrying due to error condition', {
            error: error.message,
            status: error.response?.status,
            attempt
          });
          break;
        }

        // Don't delay on the last attempt
        if (attempt < this.maxAttempts) {
          const delay = this.calculateDelay(attempt);
          this.stats.totalRetries++;
          
          this.logger.debug('Retrying after delay', {
            attempt,
            nextAttempt: attempt + 1,
            delay,
            error: error.message
          });
          
          await this.sleep(delay);
        }
        
        attempt++;
      }
    }

    // All retries exhausted
    this.stats.permanentFailures++;
    this.logger.warn('All retry attempts exhausted', {
      totalAttempts: attempt - 1,
      finalError: lastError?.message,
      context: context.url || 'unknown'
    });

    throw lastError;
  }

  /**
   * Default retry condition
   */
  defaultRetryCondition(error, attempt) {
    // Don't retry on final attempt
    if (attempt >= this.maxAttempts) {
      return false;
    }

    // Retry on network errors
    if (error.code === 'ECONNRESET' || 
        error.code === 'ENOTFOUND' || 
        error.code === 'ECONNREFUSED' ||
        error.code === 'ETIMEDOUT') {
      return true;
    }

    // Retry on specific HTTP status codes
    if (error.response?.status) {
      const status = error.response.status;
      
      // Don't retry client errors (4xx) except for specific cases
      if (status >= 400 && status < 500) {
        // Retry rate limiting and request timeout
        return status === 429 || status === 408;
      }
      
      // Retry server errors (5xx)
      if (status >= 500) {
        return true;
      }
    }

    // Don't retry by default
    return false;
  }

  /**
   * Check if error should be retried
   */
  shouldRetry(error, attempt) {
    return this.retryCondition(error, attempt);
  }

  /**
   * Calculate delay with exponential backoff and jitter
   */
  calculateDelay(attempt) {
    // Exponential backoff: baseDelay * (backoffMultiplier ^ (attempt - 1))
    const exponentialDelay = this.baseDelay * Math.pow(this.backoffMultiplier, attempt - 1);
    
    // Apply jitter to prevent thundering herd
    const jitter = exponentialDelay * this.jitterFactor * Math.random();
    const delay = exponentialDelay + jitter;
    
    // Ensure delay doesn't exceed maximum
    return Math.min(delay, this.maxDelay);
  }

  /**
   * Sleep for specified milliseconds
   */
  async sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  /**
   * Get retry statistics
   */
  getStats() {
    const retryRate = this.stats.totalAttempts > 0 
      ? (this.stats.totalRetries / this.stats.totalAttempts) * 100 
      : 0;
    
    const successAfterRetryRate = this.stats.totalRetries > 0
      ? (this.stats.successAfterRetry / this.stats.totalRetries) * 100
      : 0;

    return {
      enabled: this.enabled,
      totalAttempts: this.stats.totalAttempts,
      totalRetries: this.stats.totalRetries,
      successAfterRetry: this.stats.successAfterRetry,
      permanentFailures: this.stats.permanentFailures,
      retryRate: parseFloat(retryRate.toFixed(2)),
      successAfterRetryRate: parseFloat(successAfterRetryRate.toFixed(2)),
      config: {
        maxAttempts: this.maxAttempts,
        baseDelay: this.baseDelay,
        maxDelay: this.maxDelay,
        backoffMultiplier: this.backoffMultiplier,
        jitterFactor: this.jitterFactor
      }
    };
  }

  /**
   * Reset statistics
   */
  resetStats() {
    this.stats = {
      totalAttempts: 0,
      totalRetries: 0,
      successAfterRetry: 0,
      permanentFailures: 0
    };
    
    this.logger.info('Retry statistics reset');
  }

  /**
   * Create custom retry condition
   */
  static createRetryCondition(options = {}) {
    const {
      maxAttempts = 3,
      retryOnStatus = [429, 408, 500, 502, 503, 504],
      retryOnNetworkError = true,
      retryOnTimeout = true
    } = options;

    return (error, attempt) => {
      if (attempt >= maxAttempts) {
        return false;
      }

      // Network errors
      if (retryOnNetworkError && (
        error.code === 'ECONNRESET' ||
        error.code === 'ENOTFOUND' ||
        error.code === 'ECONNREFUSED'
      )) {
        return true;
      }

      // Timeout errors
      if (retryOnTimeout && error.code === 'ETIMEDOUT') {
        return true;
      }

      // HTTP status codes
      if (error.response?.status && retryOnStatus.includes(error.response.status)) {
        return true;
      }

      return false;
    };
  }
}