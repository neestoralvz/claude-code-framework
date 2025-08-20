import { Logger } from '../utils/Logger.js';

/**
 * API Metrics Collection and Monitoring
 * 
 * Collects and aggregates metrics for API calls
 * Features:
 * - Request/response timing
 * - Error rates and types
 * - Status code distribution
 * - Performance percentiles
 * - Custom metrics
 */
export class ApiMetrics {
  constructor(config = {}) {
    this.enabled = config.enabled !== false;
    this.metricsWindow = config.metricsWindow || 300000; // 5 minutes
    this.maxDataPoints = config.maxDataPoints || 1000;
    
    this.metrics = {
      requests: {
        total: 0,
        success: 0,
        errors: 0,
        byStatus: {},
        byMethod: {},
        byEndpoint: {}
      },
      timing: {
        responseTimes: [],
        averageResponseTime: 0,
        minResponseTime: Infinity,
        maxResponseTime: 0,
        percentiles: {}
      },
      errors: {
        byType: {},
        byStatus: {},
        byEndpoint: {},
        recent: []
      },
      throughput: {
        requestsPerSecond: 0,
        requestsPerMinute: 0,
        dataPoints: []
      }
    };
    
    this.logger = new Logger('ApiMetrics');
    
    // Start metrics aggregation if enabled
    if (this.enabled) {
      this.startMetricsAggregation();
      this.logger.info('API metrics initialized', {
        metricsWindow: this.metricsWindow,
        maxDataPoints: this.maxDataPoints
      });
    }
  }

  /**
   * Record request metrics
   */
  recordRequest(config) {
    if (!this.enabled) return;
    
    const now = Date.now();
    const method = config.method?.toUpperCase() || 'UNKNOWN';
    const endpoint = this.normalizeEndpoint(config.url);
    
    // Increment counters
    this.metrics.requests.total++;
    this.metrics.requests.byMethod[method] = (this.metrics.requests.byMethod[method] || 0) + 1;
    this.metrics.requests.byEndpoint[endpoint] = (this.metrics.requests.byEndpoint[endpoint] || 0) + 1;
    
    // Record for throughput calculation
    this.metrics.throughput.dataPoints.push({ timestamp: now, type: 'request' });
    
    // Clean old data points
    this.cleanOldDataPoints();
  }

  /**
   * Record response metrics
   */
  recordResponse(response, responseTime) {
    if (!this.enabled) return;
    
    const status = response.status;
    const endpoint = this.normalizeEndpoint(response.config?.url);
    
    // Record success/error
    if (status >= 200 && status < 400) {
      this.metrics.requests.success++;
    } else {
      this.metrics.requests.errors++;
    }
    
    // Record by status code
    this.metrics.requests.byStatus[status] = (this.metrics.requests.byStatus[status] || 0) + 1;
    
    // Record response time
    this.recordResponseTime(responseTime);
    
    this.logger.debug('Response metrics recorded', {
      status,
      responseTime,
      endpoint
    });
  }

  /**
   * Record error metrics
   */
  recordError(type, error) {
    if (!this.enabled) return;
    
    const now = Date.now();
    const errorType = this.getErrorType(error);
    const status = error.response?.status || 'network';
    const endpoint = this.normalizeEndpoint(error.config?.url);
    
    // Record by error type
    this.metrics.errors.byType[errorType] = (this.metrics.errors.byType[errorType] || 0) + 1;
    
    // Record by status code
    this.metrics.errors.byStatus[status] = (this.metrics.errors.byStatus[status] || 0) + 1;
    
    // Record by endpoint
    this.metrics.errors.byEndpoint[endpoint] = (this.metrics.errors.byEndpoint[endpoint] || 0) + 1;
    
    // Add to recent errors
    this.metrics.errors.recent.push({
      timestamp: now,
      type: errorType,
      status,
      endpoint,
      message: error.message
    });
    
    // Keep only recent errors (last 100)
    if (this.metrics.errors.recent.length > 100) {
      this.metrics.errors.recent = this.metrics.errors.recent.slice(-100);
    }
    
    this.logger.debug('Error metrics recorded', {
      type: errorType,
      status,
      endpoint,
      message: error.message
    });
  }

  /**
   * Record response time
   */
  recordResponseTime(responseTime) {
    this.metrics.timing.responseTimes.push({
      time: responseTime,
      timestamp: Date.now()
    });
    
    // Update min/max
    this.metrics.timing.minResponseTime = Math.min(this.metrics.timing.minResponseTime, responseTime);
    this.metrics.timing.maxResponseTime = Math.max(this.metrics.timing.maxResponseTime, responseTime);
    
    // Keep only recent response times
    if (this.metrics.timing.responseTimes.length > this.maxDataPoints) {
      this.metrics.timing.responseTimes = this.metrics.timing.responseTimes.slice(-this.maxDataPoints);
    }
    
    // Recalculate average
    this.updateAverageResponseTime();
    
    // Update percentiles
    this.updatePercentiles();
  }

  /**
   * Update average response time
   */
  updateAverageResponseTime() {
    const times = this.metrics.timing.responseTimes.map(item => item.time);
    if (times.length > 0) {
      this.metrics.timing.averageResponseTime = times.reduce((a, b) => a + b, 0) / times.length;
    }
  }

  /**
   * Update response time percentiles
   */
  updatePercentiles() {
    const times = this.metrics.timing.responseTimes
      .map(item => item.time)
      .sort((a, b) => a - b);
    
    if (times.length === 0) return;
    
    const percentiles = [50, 75, 90, 95, 99];
    
    percentiles.forEach(p => {
      const index = Math.ceil((p / 100) * times.length) - 1;
      this.metrics.timing.percentiles[`p${p}`] = times[Math.max(0, index)];
    });
  }

  /**
   * Get error type from error object
   */
  getErrorType(error) {
    if (error.code) {
      return error.code;
    }
    
    if (error.response?.status) {
      const status = error.response.status;
      if (status >= 400 && status < 500) {
        return 'client_error';
      }
      if (status >= 500) {
        return 'server_error';
      }
    }
    
    if (error.message?.includes('timeout')) {
      return 'timeout';
    }
    
    if (error.message?.includes('Network Error')) {
      return 'network_error';
    }
    
    return 'unknown_error';
  }

  /**
   * Normalize endpoint for metrics grouping
   */
  normalizeEndpoint(url) {
    if (!url) return 'unknown';
    
    // Remove query parameters
    let path = url.split('?')[0];
    
    // Remove base URL
    path = path.replace(/^https?:\/\/[^\/]+/, '');
    
    // Replace IDs with placeholders for grouping
    path = path.replace(/\/\d+/g, '/:id');
    path = path.replace(/\/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/gi, '/:uuid');
    
    return path || '/';
  }

  /**
   * Start metrics aggregation
   */
  startMetricsAggregation() {
    // Calculate throughput every 10 seconds
    this.throughputInterval = setInterval(() => {
      this.calculateThroughput();
    }, 10000);
    
    // Clean old metrics every minute
    this.cleanupInterval = setInterval(() => {
      this.cleanOldMetrics();
    }, 60000);
  }

  /**
   * Calculate throughput metrics
   */
  calculateThroughput() {
    const now = Date.now();
    const oneSecondAgo = now - 1000;
    const oneMinuteAgo = now - 60000;
    
    const recentRequests = this.metrics.throughput.dataPoints.filter(
      point => point.timestamp >= oneMinuteAgo
    );
    
    const lastSecondRequests = recentRequests.filter(
      point => point.timestamp >= oneSecondAgo
    );
    
    this.metrics.throughput.requestsPerSecond = lastSecondRequests.length;
    this.metrics.throughput.requestsPerMinute = recentRequests.length;
  }

  /**
   * Clean old data points
   */
  cleanOldDataPoints() {
    const cutoff = Date.now() - this.metricsWindow;
    
    // Clean throughput data points
    this.metrics.throughput.dataPoints = this.metrics.throughput.dataPoints.filter(
      point => point.timestamp >= cutoff
    );
    
    // Clean response times
    this.metrics.timing.responseTimes = this.metrics.timing.responseTimes.filter(
      item => item.timestamp >= cutoff
    );
  }

  /**
   * Clean old metrics data
   */
  cleanOldMetrics() {
    const cutoff = Date.now() - this.metricsWindow;
    
    // Clean recent errors
    this.metrics.errors.recent = this.metrics.errors.recent.filter(
      error => error.timestamp >= cutoff
    );
    
    // Clean old data points
    this.cleanOldDataPoints();
    
    // Recalculate derived metrics
    this.updateAverageResponseTime();
    this.updatePercentiles();
  }

  /**
   * Get all metrics
   */
  getMetrics() {
    const now = Date.now();
    const uptime = now - (this.startTime || now);
    
    return {
      timestamp: now,
      uptime,
      requests: {
        ...this.metrics.requests,
        errorRate: this.metrics.requests.total > 0 
          ? (this.metrics.requests.errors / this.metrics.requests.total) * 100 
          : 0,
        successRate: this.metrics.requests.total > 0
          ? (this.metrics.requests.success / this.metrics.requests.total) * 100
          : 0
      },
      timing: {
        ...this.metrics.timing,
        averageResponseTime: Math.round(this.metrics.timing.averageResponseTime)
      },
      errors: this.metrics.errors,
      throughput: this.metrics.throughput
    };
  }

  /**
   * Get metrics summary
   */
  getSummary() {
    const metrics = this.getMetrics();
    
    return {
      totalRequests: metrics.requests.total,
      successRate: `${metrics.requests.successRate.toFixed(2)}%`,
      errorRate: `${metrics.requests.errorRate.toFixed(2)}%`,
      averageResponseTime: `${metrics.timing.averageResponseTime}ms`,
      requestsPerMinute: metrics.throughput.requestsPerMinute,
      topErrors: this.getTopErrors(),
      slowestEndpoints: this.getSlowestEndpoints()
    };
  }

  /**
   * Get top error types
   */
  getTopErrors() {
    return Object.entries(this.metrics.errors.byType)
      .sort(([,a], [,b]) => b - a)
      .slice(0, 5)
      .map(([type, count]) => ({ type, count }));
  }

  /**
   * Get slowest endpoints (placeholder - would need request-level timing)
   */
  getSlowestEndpoints() {
    // This would need more detailed timing per endpoint
    return Object.entries(this.metrics.requests.byEndpoint)
      .sort(([,a], [,b]) => b - a)
      .slice(0, 5)
      .map(([endpoint, requests]) => ({ endpoint, requests }));
  }

  /**
   * Reset all metrics
   */
  reset() {
    this.metrics = {
      requests: {
        total: 0,
        success: 0,
        errors: 0,
        byStatus: {},
        byMethod: {},
        byEndpoint: {}
      },
      timing: {
        responseTimes: [],
        averageResponseTime: 0,
        minResponseTime: Infinity,
        maxResponseTime: 0,
        percentiles: {}
      },
      errors: {
        byType: {},
        byStatus: {},
        byEndpoint: {},
        recent: []
      },
      throughput: {
        requestsPerSecond: 0,
        requestsPerMinute: 0,
        dataPoints: []
      }
    };
    
    this.startTime = Date.now();
    this.logger.info('Metrics reset');
  }

  /**
   * Stop metrics collection
   */
  stop() {
    if (this.throughputInterval) {
      clearInterval(this.throughputInterval);
    }
    
    if (this.cleanupInterval) {
      clearInterval(this.cleanupInterval);
    }
    
    this.logger.info('Metrics collection stopped');
  }
}