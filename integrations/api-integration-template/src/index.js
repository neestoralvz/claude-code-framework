#!/usr/bin/env node

import dotenv from 'dotenv';
import { MathApiService } from './services/MathApiService.js';
import { MockMathServer } from './mock/MockMathServer.js';
import { Logger } from './utils/Logger.js';

// Load environment variables
dotenv.config();

/**
 * Main application entry point
 * 
 * Demonstrates production usage of the REST API integration solution
 * Can run as a standalone service or integrate with existing applications
 */
class ApiIntegrationApp {
  constructor() {
    this.logger = new Logger('ApiIntegrationApp');
    this.server = null;
    this.mathService = null;
    this.gracefulShutdown = false;
  }

  /**
   * Initialize and start the application
   */
  async start() {
    try {
      this.logger.info('Starting API Integration Application');
      
      // Setup graceful shutdown handlers
      this.setupGracefulShutdown();
      
      // Initialize services
      await this.initializeServices();
      
      // Start application services
      await this.startServices();
      
      // Run application logic
      await this.runApplication();
      
    } catch (error) {
      this.logger.error('Application startup failed', { error: error.message });
      process.exit(1);
    }
  }

  /**
   * Setup graceful shutdown handlers
   */
  setupGracefulShutdown() {
    const shutdown = async (signal) => {
      if (this.gracefulShutdown) return;
      this.gracefulShutdown = true;
      
      this.logger.info(`Received ${signal}, starting graceful shutdown...`);
      await this.stop();
      process.exit(0);
    };

    process.on('SIGINT', () => shutdown('SIGINT'));
    process.on('SIGTERM', () => shutdown('SIGTERM'));
    
    // Handle uncaught exceptions
    process.on('uncaughtException', (error) => {
      this.logger.error('Uncaught exception', { error: error.message, stack: error.stack });
      shutdown('uncaughtException');
    });

    process.on('unhandledRejection', (reason, promise) => {
      this.logger.error('Unhandled rejection', { 
        reason: reason?.message || reason,
        promise: promise.toString()
      });
    });
  }

  /**
   * Initialize application services
   */
  async initializeServices() {
    this.logger.info('Initializing services...');
    
    // Initialize mock server if needed
    if (process.env.START_MOCK_SERVER === 'true') {
      this.server = new MockMathServer({
        port: parseInt(process.env.MOCK_SERVER_PORT) || 3001
      });
    }
    
    // Initialize math service with environment configuration
    this.mathService = new MathApiService({
      baseURL: process.env.API_BASE_URL || 'http://localhost:3001/api/v1',
      timeout: parseInt(process.env.API_TIMEOUT) || 10000,
      
      // Authentication configuration
      auth: this.getAuthConfig(),
      
      // Retry configuration
      retry: {
        enabled: process.env.RETRY_ENABLED !== 'false',
        maxAttempts: parseInt(process.env.RETRY_MAX_ATTEMPTS) || 3,
        baseDelay: parseInt(process.env.RETRY_BASE_DELAY) || 1000,
        maxDelay: parseInt(process.env.RETRY_MAX_DELAY) || 30000,
        backoffMultiplier: parseFloat(process.env.RETRY_BACKOFF_MULTIPLIER) || 2,
        jitterFactor: parseFloat(process.env.RETRY_JITTER_FACTOR) || 0.1
      },
      
      // Circuit breaker configuration
      circuitBreaker: {
        enabled: process.env.CIRCUIT_BREAKER_ENABLED !== 'false',
        failureThreshold: parseInt(process.env.CIRCUIT_BREAKER_FAILURE_THRESHOLD) || 5,
        resetTimeout: parseInt(process.env.CIRCUIT_BREAKER_RESET_TIMEOUT) || 30000,
        monitoringPeriod: parseInt(process.env.CIRCUIT_BREAKER_MONITORING_PERIOD) || 10000,
        volumeThreshold: parseInt(process.env.CIRCUIT_BREAKER_VOLUME_THRESHOLD) || 10,
        errorPercentageThreshold: parseInt(process.env.CIRCUIT_BREAKER_ERROR_PERCENTAGE_THRESHOLD) || 50
      }
    });

    this.logger.info('Services initialized successfully');
  }

  /**
   * Get authentication configuration from environment
   */
  getAuthConfig() {
    const authType = process.env.API_AUTH_TYPE;
    
    if (!authType || authType === 'none') {
      return null;
    }
    
    switch (authType.toLowerCase()) {
      case 'bearer':
        return {
          type: 'bearer',
          token: process.env.API_AUTH_TOKEN
        };
      
      case 'apikey':
        return {
          type: 'apikey',
          key: process.env.API_AUTH_KEY,
          header: process.env.API_AUTH_HEADER || 'X-API-Key'
        };
      
      case 'basic':
        return {
          type: 'basic',
          username: process.env.API_AUTH_USERNAME,
          password: process.env.API_AUTH_PASSWORD
        };
      
      default:
        this.logger.warn('Unknown authentication type', { type: authType });
        return null;
    }
  }

  /**
   * Start application services
   */
  async startServices() {
    this.logger.info('Starting services...');
    
    // Start mock server if configured
    if (this.server) {
      await this.server.start();
      this.logger.info('Mock server started');
    }
    
    // Verify service connectivity
    try {
      const health = await this.mathService.healthCheck();
      this.logger.info('Service health check', { status: health.service });
    } catch (error) {
      this.logger.warn('Service health check failed', { error: error.message });
    }
    
    this.logger.info('Services started successfully');
  }

  /**
   * Run main application logic
   */
  async runApplication() {
    this.logger.info('Running application logic...');
    
    // Example application workflow
    try {
      // Perform some calculations
      await this.performCalculations();
      
      // Monitor service metrics
      await this.monitorMetrics();
      
      // Keep application running
      await this.keepAlive();
      
    } catch (error) {
      this.logger.error('Application logic failed', { error: error.message });
      throw error;
    }
  }

  /**
   * Perform sample calculations
   */
  async performCalculations() {
    this.logger.info('Performing sample calculations...');
    
    const calculations = [
      { operation: 'add', a: 10, b: 20 },
      { operation: 'multiply', a: 7, b: 8 },
      { operation: 'divide', a: 100, b: 4, options: { precision: 2 } },
      { operation: 'sqrt', number: 144 },
      { operation: 'power', a: 2, b: 10 }
    ];
    
    for (const calc of calculations) {
      try {
        let result;
        
        switch (calc.operation) {
          case 'add':
            result = await this.mathService.add(calc.a, calc.b, calc.options);
            break;
          case 'multiply':
            result = await this.mathService.multiply(calc.a, calc.b, calc.options);
            break;
          case 'divide':
            result = await this.mathService.divide(calc.a, calc.b, calc.options);
            break;
          case 'sqrt':
            result = await this.mathService.sqrt(calc.number, calc.options);
            break;
          case 'power':
            result = await this.mathService.power(calc.a, calc.b, calc.options);
            break;
        }
        
        this.logger.info('Calculation completed', {
          operation: calc.operation,
          result: result.result
        });
        
      } catch (error) {
        this.logger.error('Calculation failed', {
          operation: calc.operation,
          error: error.message,
          code: error.code
        });
      }
    }
    
    // Advanced operations
    try {
      const numbers = [10, 20, 30, 40, 50];
      const avgResult = await this.mathService.advancedOperation(numbers, 'average');
      this.logger.info('Advanced calculation completed', {
        operation: 'average',
        numbers,
        result: avgResult.result
      });
    } catch (error) {
      this.logger.error('Advanced calculation failed', { error: error.message });
    }
  }

  /**
   * Monitor service metrics
   */
  async monitorMetrics() {
    this.logger.info('Collecting service metrics...');
    
    const metrics = this.mathService.getMetrics();
    
    this.logger.info('Service Metrics', {
      requests: {
        total: metrics.requests.total,
        success: metrics.requests.success,
        errors: metrics.requests.errors,
        successRate: `${metrics.requests.successRate.toFixed(2)}%`
      },
      timing: {
        average: `${metrics.timing.averageResponseTime.toFixed(2)}ms`,
        min: `${metrics.timing.minResponseTime}ms`,
        max: `${metrics.timing.maxResponseTime}ms`
      },
      throughput: {
        rpm: metrics.throughput.requestsPerMinute,
        rps: metrics.throughput.requestsPerSecond
      }
    });
    
    // Circuit breaker status
    if (metrics.circuitBreaker) {
      this.logger.info('Circuit Breaker Status', {
        state: metrics.circuitBreaker.state,
        failures: metrics.circuitBreaker.failureCount,
        successes: metrics.circuitBreaker.successCount
      });
    }
    
    // Retry statistics
    if (metrics.retryStats) {
      this.logger.info('Retry Statistics', {
        totalRetries: metrics.retryStats.totalRetries,
        successAfterRetry: metrics.retryStats.successAfterRetry,
        retryRate: `${metrics.retryStats.retryRate}%`
      });
    }
  }

  /**
   * Keep application running
   */
  async keepAlive() {
    this.logger.info('Application running. Press Ctrl+C to stop.');
    
    // Set up periodic health checks and metrics reporting
    const healthCheckInterval = setInterval(async () => {
      if (this.gracefulShutdown) {
        clearInterval(healthCheckInterval);
        return;
      }
      
      try {
        const health = await this.mathService.healthCheck();
        
        if (health.service !== 'healthy') {
          this.logger.warn('Service health degraded', { status: health.service });
        }
        
        // Log metrics every 30 seconds in production
        if (process.env.NODE_ENV === 'production') {
          await this.monitorMetrics();
        }
        
      } catch (error) {
        this.logger.error('Health check failed', { error: error.message });
      }
    }, 30000); // Every 30 seconds
    
    // Keep the application running until shutdown signal
    return new Promise((resolve) => {
      const checkShutdown = () => {
        if (this.gracefulShutdown) {
          clearInterval(healthCheckInterval);
          resolve();
        } else {
          setTimeout(checkShutdown, 1000);
        }
      };
      checkShutdown();
    });
  }

  /**
   * Stop application services
   */
  async stop() {
    this.logger.info('Stopping application services...');
    
    try {
      // Close math service
      if (this.mathService) {
        this.mathService.close();
        this.logger.info('Math service closed');
      }
      
      // Stop mock server
      if (this.server) {
        await this.server.stop();
        this.logger.info('Mock server stopped');
      }
      
      this.logger.info('Application shutdown complete');
      
    } catch (error) {
      this.logger.error('Error during shutdown', { error: error.message });
    }
  }
}

// Start the application if this file is run directly
if (import.meta.url === `file://${process.argv[1]}`) {
  const app = new ApiIntegrationApp();
  app.start().catch((error) => {
    console.error('Application failed to start:', error);
    process.exit(1);
  });
}

export { ApiIntegrationApp };