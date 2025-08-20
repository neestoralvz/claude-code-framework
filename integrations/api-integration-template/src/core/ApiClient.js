import axios from 'axios';
import { CircuitBreaker } from './CircuitBreaker.js';
import { RetryManager } from './RetryManager.js';
import { RequestValidator } from './RequestValidator.js';
import { ResponseTransformer } from './ResponseTransformer.js';
import { ApiMetrics } from './ApiMetrics.js';
import { Logger } from '../utils/Logger.js';

/**
 * Production-ready REST API client with comprehensive integration patterns
 * 
 * Features:
 * - Circuit breaker pattern for fault tolerance
 * - Retry logic with exponential backoff
 * - Request/response validation and transformation
 * - Authentication handling
 * - Comprehensive monitoring and metrics
 * - Error handling and logging
 */
export class ApiClient {
  constructor(config = {}) {
    this.baseURL = config.baseURL || 'http://localhost:3000';
    this.timeout = config.timeout || 10000;
    this.retryConfig = config.retry || {};
    this.circuitBreakerConfig = config.circuitBreaker || {};
    this.authConfig = config.auth || {};
    
    // Initialize components
    this.logger = new Logger('ApiClient');
    this.retryManager = new RetryManager(this.retryConfig);
    this.circuitBreaker = new CircuitBreaker(this.circuitBreakerConfig);
    this.requestValidator = new RequestValidator();
    this.responseTransformer = new ResponseTransformer();
    this.metrics = new ApiMetrics();
    
    // Initialize HTTP client
    this.httpClient = this.createHttpClient();
    
    // Setup interceptors
    this.setupInterceptors();
    
    this.logger.info('ApiClient initialized', {
      baseURL: this.baseURL,
      timeout: this.timeout,
      retryEnabled: !!this.retryConfig.enabled,
      circuitBreakerEnabled: !!this.circuitBreakerConfig.enabled
    });
  }

  /**
   * Create and configure HTTP client
   */
  createHttpClient() {
    return axios.create({
      baseURL: this.baseURL,
      timeout: this.timeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'API-Integration-Client/1.0.0'
      }
    });
  }

  /**
   * Setup request and response interceptors
   */
  setupInterceptors() {
    // Request interceptor
    this.httpClient.interceptors.request.use(
      (config) => this.handleRequest(config),
      (error) => this.handleRequestError(error)
    );

    // Response interceptor
    this.httpClient.interceptors.response.use(
      (response) => this.handleResponse(response),
      (error) => this.handleResponseError(error)
    );
  }

  /**
   * Handle outgoing requests
   */
  async handleRequest(config) {
    const startTime = Date.now();
    
    // Add request ID for tracing
    config.metadata = {
      requestId: this.generateRequestId(),
      startTime
    };

    // Add authentication
    await this.addAuthentication(config);

    // Validate request
    if (this.requestValidator.shouldValidate(config)) {
      this.requestValidator.validate(config);
    }

    // Log request
    this.logger.debug('Outgoing request', {
      requestId: config.metadata.requestId,
      method: config.method?.toUpperCase(),
      url: config.url,
      headers: this.sanitizeHeaders(config.headers)
    });

    // Record request metrics
    this.metrics.recordRequest(config);

    return config;
  }

  /**
   * Handle request errors
   */
  async handleRequestError(error) {
    this.logger.error('Request error', { error: error.message });
    this.metrics.recordError('request', error);
    return Promise.reject(error);
  }

  /**
   * Handle incoming responses
   */
  async handleResponse(response) {
    const { requestId, startTime } = response.config.metadata || {};
    const responseTime = Date.now() - (startTime || Date.now());

    // Log response
    this.logger.debug('Incoming response', {
      requestId,
      status: response.status,
      responseTime,
      dataSize: JSON.stringify(response.data || {}).length
    });

    // Transform response if needed
    const transformedResponse = await this.responseTransformer.transform(response);

    // Record metrics
    this.metrics.recordResponse(response, responseTime);

    return transformedResponse;
  }

  /**
   * Handle response errors
   */
  async handleResponseError(error) {
    const { requestId, startTime } = error.config?.metadata || {};
    const responseTime = Date.now() - (startTime || Date.now());

    // Log error
    this.logger.error('Response error', {
      requestId,
      status: error.response?.status,
      message: error.message,
      responseTime,
      url: error.config?.url
    });

    // Record error metrics
    this.metrics.recordError('response', error);

    return Promise.reject(error);
  }

  /**
   * Add authentication to request
   */
  async addAuthentication(config) {
    if (!this.authConfig.type) return;

    switch (this.authConfig.type) {
      case 'bearer':
        config.headers.Authorization = `Bearer ${await this.getToken()}`;
        break;
      case 'apikey':
        config.headers[this.authConfig.header || 'X-API-Key'] = this.authConfig.key;
        break;
      case 'basic':
        const credentials = Buffer.from(`${this.authConfig.username}:${this.authConfig.password}`).toString('base64');
        config.headers.Authorization = `Basic ${credentials}`;
        break;
    }
  }

  /**
   * Get authentication token (implement token refresh logic)
   */
  async getToken() {
    // Implement token management logic here
    return this.authConfig.token;
  }

  /**
   * Execute HTTP request with circuit breaker and retry logic
   */
  async request(config) {
    const operation = async () => {
      return await this.httpClient.request(config);
    };

    // Apply circuit breaker if enabled
    if (this.circuitBreakerConfig.enabled) {
      return await this.circuitBreaker.execute(operation, config);
    }

    // Apply retry logic if enabled
    if (this.retryConfig.enabled) {
      return await this.retryManager.execute(operation, config);
    }

    return await operation();
  }

  /**
   * GET request
   */
  async get(url, config = {}) {
    return await this.request({
      method: 'GET',
      url,
      ...config
    });
  }

  /**
   * POST request
   */
  async post(url, data, config = {}) {
    return await this.request({
      method: 'POST',
      url,
      data,
      ...config
    });
  }

  /**
   * PUT request
   */
  async put(url, data, config = {}) {
    return await this.request({
      method: 'PUT',
      url,
      data,
      ...config
    });
  }

  /**
   * DELETE request
   */
  async delete(url, config = {}) {
    return await this.request({
      method: 'DELETE',
      url,
      ...config
    });
  }

  /**
   * PATCH request
   */
  async patch(url, data, config = {}) {
    return await this.request({
      method: 'PATCH',
      url,
      data,
      ...config
    });
  }

  /**
   * Generate unique request ID for tracing
   */
  generateRequestId() {
    return `req_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  /**
   * Sanitize headers for logging (remove sensitive data)
   */
  sanitizeHeaders(headers) {
    const sanitized = { ...headers };
    const sensitiveHeaders = ['authorization', 'x-api-key', 'cookie', 'x-auth-token'];
    
    sensitiveHeaders.forEach(header => {
      if (sanitized[header]) {
        sanitized[header] = '***';
      }
      if (sanitized[header.toLowerCase()]) {
        sanitized[header.toLowerCase()] = '***';
      }
    });

    return sanitized;
  }

  /**
   * Get client metrics
   */
  getMetrics() {
    return {
      ...this.metrics.getMetrics(),
      circuitBreaker: this.circuitBreaker.getState(),
      retryStats: this.retryManager.getStats()
    };
  }

  /**
   * Health check
   */
  async healthCheck() {
    try {
      const response = await this.get('/health', { timeout: 5000 });
      return {
        status: 'healthy',
        response: response.status === 200,
        metrics: this.getMetrics()
      };
    } catch (error) {
      return {
        status: 'unhealthy',
        error: error.message,
        metrics: this.getMetrics()
      };
    }
  }

  /**
   * Close client and cleanup resources
   */
  close() {
    this.logger.info('Closing API client');
    this.circuitBreaker.reset();
    this.metrics.reset();
  }
}