import { ApiClient } from '../core/ApiClient.js';
import { Logger } from '../utils/Logger.js';
import Joi from 'joi';

/**
 * Math API Service
 * 
 * Demonstrates REST API integration for a simple math service
 * Features:
 * - Basic arithmetic operations
 * - Input validation
 * - Error handling
 * - Response transformation
 * - Performance monitoring
 */
export class MathApiService {
  constructor(config = {}) {
    this.logger = new Logger('MathApiService');
    
    // Initialize API client with math service specific configuration
    this.apiClient = new ApiClient({
      baseURL: config.baseURL || 'http://localhost:3001/api/v1',
      timeout: config.timeout || 15000,
      retry: {
        enabled: true,
        maxAttempts: 3,
        baseDelay: 1000,
        backoffMultiplier: 2
      },
      circuitBreaker: {
        enabled: true,
        failureThreshold: 5,
        resetTimeout: 30000,
        monitoringPeriod: 10000
      },
      auth: config.auth,
      ...config
    });
    
    // Setup request validation schemas
    this.setupValidationSchemas();
    
    // Setup response transformations
    this.setupResponseTransformations();
    
    this.logger.info('Math API service initialized', {
      baseURL: this.apiClient.baseURL
    });
  }

  /**
   * Setup validation schemas for different operations
   */
  setupValidationSchemas() {
    this.schemas = {
      basicOperation: Joi.object({
        a: Joi.number().required().description('First operand'),
        b: Joi.number().required().description('Second operand'),
        precision: Joi.number().integer().min(0).max(10).optional().description('Decimal precision')
      }),
      
      advancedOperation: Joi.object({
        numbers: Joi.array().items(Joi.number()).min(1).required().description('Array of numbers'),
        operation: Joi.string().valid('sum', 'product', 'average', 'median', 'mode').required()
      }),
      
      equation: Joi.object({
        expression: Joi.string().required().description('Mathematical expression'),
        variables: Joi.object().pattern(Joi.string(), Joi.number()).optional()
      })
    };
  }

  /**
   * Setup response transformations
   */
  setupResponseTransformations() {
    // Add transformation to convert result to specified precision
    this.apiClient.responseTransformer.addGlobalTransformation((response) => {
      if (response.data && typeof response.data.result === 'number') {
        const precision = response.config?.data?.precision;
        if (typeof precision === 'number') {
          response.data.result = parseFloat(response.data.result.toFixed(precision));
        }
      }
      return response;
    });
  }

  /**
   * Add two numbers
   */
  async add(a, b, options = {}) {
    const { precision } = options;
    
    // Validate input
    const { error, value } = this.schemas.basicOperation.validate({ a, b, precision });
    if (error) {
      throw new Error(`Validation error: ${error.message}`);
    }
    
    try {
      this.logger.debug('Adding numbers', { a, b, precision });
      
      const response = await this.apiClient.post('/math/add', {
        a: value.a,
        b: value.b,
        precision: value.precision
      });
      
      this.logger.info('Addition completed', {
        a: value.a,
        b: value.b,
        result: response.data.result
      });
      
      return response.data;
    } catch (error) {
      this.logger.error('Addition failed', {
        a, b, precision,
        error: error.message
      });
      throw this.handleApiError(error, 'add');
    }
  }

  /**
   * Subtract two numbers
   */
  async subtract(a, b, options = {}) {
    const { precision } = options;
    
    const { error, value } = this.schemas.basicOperation.validate({ a, b, precision });
    if (error) {
      throw new Error(`Validation error: ${error.message}`);
    }
    
    try {
      this.logger.debug('Subtracting numbers', { a, b, precision });
      
      const response = await this.apiClient.post('/math/subtract', {
        a: value.a,
        b: value.b,
        precision: value.precision
      });
      
      return response.data;
    } catch (error) {
      this.logger.error('Subtraction failed', {
        a, b, precision,
        error: error.message
      });
      throw this.handleApiError(error, 'subtract');
    }
  }

  /**
   * Multiply two numbers
   */
  async multiply(a, b, options = {}) {
    const { precision } = options;
    
    const { error, value } = this.schemas.basicOperation.validate({ a, b, precision });
    if (error) {
      throw new Error(`Validation error: ${error.message}`);
    }
    
    try {
      const response = await this.apiClient.post('/math/multiply', {
        a: value.a,
        b: value.b,
        precision: value.precision
      });
      
      return response.data;
    } catch (error) {
      throw this.handleApiError(error, 'multiply');
    }
  }

  /**
   * Divide two numbers
   */
  async divide(a, b, options = {}) {
    const { precision } = options;
    
    // Additional validation for division
    if (b === 0) {
      throw new Error('Division by zero is not allowed');
    }
    
    const { error, value } = this.schemas.basicOperation.validate({ a, b, precision });
    if (error) {
      throw new Error(`Validation error: ${error.message}`);
    }
    
    try {
      const response = await this.apiClient.post('/math/divide', {
        a: value.a,
        b: value.b,
        precision: value.precision
      });
      
      return response.data;
    } catch (error) {
      throw this.handleApiError(error, 'divide');
    }
  }

  /**
   * Calculate power (a^b)
   */
  async power(a, b, options = {}) {
    const { precision } = options;
    
    const { error, value } = this.schemas.basicOperation.validate({ a, b, precision });
    if (error) {
      throw new Error(`Validation error: ${error.message}`);
    }
    
    try {
      const response = await this.apiClient.post('/math/power', {
        base: value.a,
        exponent: value.b,
        precision: value.precision
      });
      
      return response.data;
    } catch (error) {
      throw this.handleApiError(error, 'power');
    }
  }

  /**
   * Calculate square root
   */
  async sqrt(number, options = {}) {
    const { precision } = options;
    
    if (number < 0) {
      throw new Error('Cannot calculate square root of negative number');
    }
    
    const { error, value } = Joi.object({
      number: Joi.number().min(0).required(),
      precision: Joi.number().integer().min(0).max(10).optional()
    }).validate({ number, precision });
    
    if (error) {
      throw new Error(`Validation error: ${error.message}`);
    }
    
    try {
      const response = await this.apiClient.post('/math/sqrt', {
        number: value.number,
        precision: value.precision
      });
      
      return response.data;
    } catch (error) {
      throw this.handleApiError(error, 'sqrt');
    }
  }

  /**
   * Perform advanced operations on array of numbers
   */
  async advancedOperation(numbers, operation, options = {}) {
    const { error, value } = this.schemas.advancedOperation.validate({
      numbers,
      operation
    });
    
    if (error) {
      throw new Error(`Validation error: ${error.message}`);
    }
    
    try {
      this.logger.debug('Performing advanced operation', {
        operation,
        numbersCount: numbers.length
      });
      
      const response = await this.apiClient.post('/math/advanced', {
        numbers: value.numbers,
        operation: value.operation,
        ...options
      });
      
      this.logger.info('Advanced operation completed', {
        operation,
        result: response.data.result
      });
      
      return response.data;
    } catch (error) {
      this.logger.error('Advanced operation failed', {
        operation,
        numbersCount: numbers.length,
        error: error.message
      });
      throw this.handleApiError(error, 'advancedOperation');
    }
  }

  /**
   * Solve mathematical equation
   */
  async solveEquation(expression, variables = {}, options = {}) {
    const { error, value } = this.schemas.equation.validate({
      expression,
      variables
    });
    
    if (error) {
      throw new Error(`Validation error: ${error.message}`);
    }
    
    try {
      this.logger.debug('Solving equation', {
        expression,
        variables
      });
      
      const response = await this.apiClient.post('/math/solve', {
        expression: value.expression,
        variables: value.variables,
        ...options
      });
      
      return response.data;
    } catch (error) {
      this.logger.error('Equation solving failed', {
        expression,
        error: error.message
      });
      throw this.handleApiError(error, 'solveEquation');
    }
  }

  /**
   * Get calculation history
   */
  async getHistory(limit = 10, offset = 0) {
    try {
      const response = await this.apiClient.get('/math/history', {
        params: { limit, offset }
      });
      
      return response.data;
    } catch (error) {
      throw this.handleApiError(error, 'getHistory');
    }
  }

  /**
   * Clear calculation history
   */
  async clearHistory() {
    try {
      const response = await this.apiClient.delete('/math/history');
      return response.data;
    } catch (error) {
      throw this.handleApiError(error, 'clearHistory');
    }
  }

  /**
   * Get service statistics
   */
  async getStats() {
    try {
      const response = await this.apiClient.get('/math/stats');
      return {
        ...response.data,
        clientMetrics: this.apiClient.getMetrics()
      };
    } catch (error) {
      throw this.handleApiError(error, 'getStats');
    }
  }

  /**
   * Health check
   */
  async healthCheck() {
    try {
      const response = await this.apiClient.get('/health');
      return {
        service: 'healthy',
        ...response.data,
        client: await this.apiClient.healthCheck()
      };
    } catch (error) {
      return {
        service: 'unhealthy',
        error: error.message,
        client: await this.apiClient.healthCheck()
      };
    }
  }

  /**
   * Handle API errors and provide meaningful error messages
   */
  handleApiError(error, operation) {
    const enhancedError = new Error();
    enhancedError.operation = operation;
    enhancedError.originalError = error;
    
    if (error.code === 'CIRCUIT_BREAKER_OPEN') {
      enhancedError.message = `Math service is temporarily unavailable (Circuit breaker open). Please try again later.`;
      enhancedError.code = 'SERVICE_UNAVAILABLE';
      enhancedError.retryAfter = error.nextAttemptTime;
    } else if (error.response) {
      // HTTP error response
      const status = error.response.status;
      const data = error.response.data;
      
      if (status === 400) {
        enhancedError.message = `Invalid input for ${operation}: ${data?.message || 'Bad request'}`;
        enhancedError.code = 'INVALID_INPUT';
      } else if (status === 429) {
        enhancedError.message = `Rate limit exceeded for ${operation}. Please try again later.`;
        enhancedError.code = 'RATE_LIMIT_EXCEEDED';
        enhancedError.retryAfter = error.response.headers?.['retry-after'];
      } else if (status >= 500) {
        enhancedError.message = `Math service error during ${operation}: ${data?.message || 'Internal server error'}`;
        enhancedError.code = 'SERVICE_ERROR';
      } else {
        enhancedError.message = `HTTP ${status} error during ${operation}: ${data?.message || error.message}`;
        enhancedError.code = 'HTTP_ERROR';
      }
      
      enhancedError.status = status;
    } else if (error.code === 'ETIMEDOUT' || error.code === 'ECONNABORTED') {
      enhancedError.message = `Request timeout during ${operation}. The service may be overloaded.`;
      enhancedError.code = 'TIMEOUT';
    } else if (error.code === 'ECONNREFUSED' || error.code === 'ENOTFOUND') {
      enhancedError.message = `Cannot connect to math service for ${operation}. Service may be down.`;
      enhancedError.code = 'CONNECTION_ERROR';
    } else {
      enhancedError.message = `Unexpected error during ${operation}: ${error.message}`;
      enhancedError.code = 'UNKNOWN_ERROR';
    }
    
    return enhancedError;
  }

  /**
   * Get service metrics
   */
  getMetrics() {
    return this.apiClient.getMetrics();
  }

  /**
   * Close service and cleanup resources
   */
  close() {
    this.logger.info('Closing math API service');
    this.apiClient.close();
  }
}