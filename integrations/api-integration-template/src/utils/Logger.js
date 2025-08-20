import pino from 'pino';

/**
 * Logger utility for API integration
 * 
 * Provides structured logging with different levels
 * Features:
 * - Structured JSON logging
 * - Log levels (debug, info, warn, error)
 * - Request/response correlation
 * - Performance logging
 * - Pretty printing for development
 */
export class Logger {
  constructor(name = 'ApiIntegration') {
    this.name = name;
    this.logger = this.createLogger();
  }

  /**
   * Create pino logger instance
   */
  createLogger() {
    const isDevelopment = process.env.NODE_ENV === 'development';
    
    const config = {
      name: this.name,
      level: process.env.LOG_LEVEL || (isDevelopment ? 'debug' : 'info'),
      formatters: {
        level: (label) => ({ level: label }),
        bindings: (bindings) => ({
          pid: bindings.pid,
          hostname: bindings.hostname,
          service: this.name
        })
      }
    };
    
    // Pretty printing for development
    if (isDevelopment) {
      config.transport = {
        target: 'pino-pretty',
        options: {
          colorize: true,
          translateTime: 'SYS:standard',
          ignore: 'pid,hostname'
        }
      };
    }
    
    return pino(config);
  }

  /**
   * Debug level logging
   */
  debug(message, data = {}) {
    this.logger.debug({
      ...data,
      timestamp: new Date().toISOString()
    }, message);
  }

  /**
   * Info level logging
   */
  info(message, data = {}) {
    this.logger.info({
      ...data,
      timestamp: new Date().toISOString()
    }, message);
  }

  /**
   * Warning level logging
   */
  warn(message, data = {}) {
    this.logger.warn({
      ...data,
      timestamp: new Date().toISOString()
    }, message);
  }

  /**
   * Error level logging
   */
  error(message, data = {}) {
    this.logger.error({
      ...data,
      timestamp: new Date().toISOString(),
      stack: data.error?.stack
    }, message);
  }

  /**
   * Log HTTP request
   */
  logRequest(requestId, method, url, headers = {}, body = null) {
    this.info('HTTP Request', {
      requestId,
      method: method?.toUpperCase(),
      url,
      headers: this.sanitizeHeaders(headers),
      hasBody: !!body,
      bodySize: body ? JSON.stringify(body).length : 0
    });
  }

  /**
   * Log HTTP response
   */
  logResponse(requestId, status, headers = {}, body = null, responseTime = 0) {
    const logLevel = status >= 400 ? 'warn' : 'info';
    
    this[logLevel]('HTTP Response', {
      requestId,
      status,
      headers: this.sanitizeHeaders(headers),
      hasBody: !!body,
      bodySize: body ? JSON.stringify(body).length : 0,
      responseTime: `${responseTime}ms`
    });
  }

  /**
   * Log performance metrics
   */
  logPerformance(operation, duration, metadata = {}) {
    this.info('Performance', {
      operation,
      duration: `${duration}ms`,
      ...metadata
    });
  }

  /**
   * Log API error with context
   */
  logApiError(error, context = {}) {
    this.error('API Error', {
      message: error.message,
      status: error.response?.status,
      statusText: error.response?.statusText,
      url: error.config?.url,
      method: error.config?.method?.toUpperCase(),
      code: error.code,
      ...context,
      error: error
    });
  }

  /**
   * Log circuit breaker state change
   */
  logCircuitBreakerStateChange(oldState, newState, context = {}) {
    this.warn('Circuit Breaker State Change', {
      oldState,
      newState,
      ...context
    });
  }

  /**
   * Log retry attempt
   */
  logRetryAttempt(attempt, maxAttempts, delay, error, context = {}) {
    this.warn('Retry Attempt', {
      attempt,
      maxAttempts,
      delay: `${delay}ms`,
      error: error.message,
      ...context
    });
  }

  /**
   * Log authentication events
   */
  logAuth(event, data = {}) {
    // Sanitize sensitive data
    const sanitizedData = { ...data };
    delete sanitizedData.token;
    delete sanitizedData.password;
    delete sanitizedData.secret;
    
    this.info(`Auth: ${event}`, sanitizedData);
  }

  /**
   * Log validation errors
   */
  logValidationError(errors, context = {}) {
    this.warn('Validation Error', {
      errors: Array.isArray(errors) ? errors : [errors],
      ...context
    });
  }

  /**
   * Sanitize headers for logging
   */
  sanitizeHeaders(headers) {
    const sanitized = { ...headers };
    const sensitiveHeaders = [
      'authorization', 'x-api-key', 'cookie', 'x-auth-token',
      'Authorization', 'X-API-Key', 'Cookie', 'X-Auth-Token'
    ];
    
    sensitiveHeaders.forEach(header => {
      if (sanitized[header]) {
        sanitized[header] = '[REDACTED]';
      }
    });
    
    return sanitized;
  }

  /**
   * Create child logger with additional context
   */
  child(bindings) {
    const childLogger = this.logger.child(bindings);
    
    return {
      debug: (message, data = {}) => childLogger.debug(data, message),
      info: (message, data = {}) => childLogger.info(data, message),
      warn: (message, data = {}) => childLogger.warn(data, message),
      error: (message, data = {}) => childLogger.error(data, message)
    };
  }

  /**
   * Create correlation logger for request tracing
   */
  correlationLogger(requestId) {
    return this.child({ requestId });
  }

  /**
   * Log with custom level
   */
  log(level, message, data = {}) {
    if (this.logger[level]) {
      this.logger[level]({
        ...data,
        timestamp: new Date().toISOString()
      }, message);
    }
  }

  /**
   * Get current log level
   */
  getLevel() {
    return this.logger.level;
  }

  /**
   * Set log level
   */
  setLevel(level) {
    this.logger.level = level;
  }

  /**
   * Check if level is enabled
   */
  isLevelEnabled(level) {
    return this.logger.isLevelEnabled(level);
  }
}

// Export default logger instance
export const defaultLogger = new Logger();