import { Logger } from '../utils/Logger.js';

/**
 * Response Transformer for API responses
 * 
 * Transforms and normalizes API responses
 * Features:
 * - Response data transformation
 * - Error response normalization
 * - Data type conversion
 * - Response validation
 * - Custom transformation pipelines
 */
export class ResponseTransformer {
  constructor(config = {}) {
    this.enabled = config.enabled !== false;
    this.transformations = config.transformations || {};
    this.errorTransformations = config.errorTransformations || {};
    this.globalTransformations = config.globalTransformations || [];
    
    this.logger = new Logger('ResponseTransformer');
    
    // Built-in transformations
    this.builtInTransformations = {
      camelCase: this.toCamelCase.bind(this),
      snakeCase: this.toSnakeCase.bind(this),
      timestamps: this.convertTimestamps.bind(this),
      pagination: this.normalizePagination.bind(this),
      errors: this.normalizeErrors.bind(this)
    };
    
    if (this.enabled) {
      this.logger.info('Response transformer initialized', {
        customTransformations: Object.keys(this.transformations).length,
        globalTransformations: this.globalTransformations.length
      });
    }
  }

  /**
   * Transform response
   */
  async transform(response) {
    if (!this.enabled) {
      return response;
    }

    try {
      let transformedResponse = { ...response };
      
      // Apply global transformations first
      for (const transformation of this.globalTransformations) {
        transformedResponse = await this.applyTransformation(transformedResponse, transformation);
      }
      
      // Apply endpoint-specific transformations
      const endpoint = this.getEndpointKey(response.config?.url, response.config?.method);
      if (this.transformations[endpoint]) {
        for (const transformation of this.transformations[endpoint]) {
          transformedResponse = await this.applyTransformation(transformedResponse, transformation);
        }
      }
      
      // Transform error responses
      if (response.status >= 400) {
        transformedResponse = await this.transformError(transformedResponse);
      }
      
      this.logger.debug('Response transformed', {
        url: response.config?.url,
        status: response.status,
        originalDataSize: JSON.stringify(response.data || {}).length,
        transformedDataSize: JSON.stringify(transformedResponse.data || {}).length
      });
      
      return transformedResponse;
      
    } catch (error) {
      this.logger.error('Response transformation failed', {
        error: error.message,
        url: response.config?.url,
        status: response.status
      });
      
      // Return original response if transformation fails
      return response;
    }
  }

  /**
   * Apply single transformation
   */
  async applyTransformation(response, transformation) {
    if (typeof transformation === 'string') {
      // Built-in transformation
      if (this.builtInTransformations[transformation]) {
        return this.builtInTransformations[transformation](response);
      } else {
        this.logger.warn('Unknown built-in transformation', { transformation });
        return response;
      }
    }
    
    if (typeof transformation === 'function') {
      // Custom transformation function
      return await transformation(response);
    }
    
    if (typeof transformation === 'object' && transformation.name && transformation.transform) {
      // Transformation object
      return await transformation.transform(response);
    }
    
    this.logger.warn('Invalid transformation format', { transformation });
    return response;
  }

  /**
   * Transform error response
   */
  async transformError(response) {
    const errorKey = `${response.status}`;
    
    if (this.errorTransformations[errorKey]) {
      return await this.applyTransformation(response, this.errorTransformations[errorKey]);
    }
    
    // Apply default error transformation
    return this.normalizeErrors(response);
  }

  /**
   * Convert object keys to camelCase
   */
  toCamelCase(response) {
    if (!response.data) return response;
    
    const camelCaseData = this.convertKeysToCamelCase(response.data);
    
    return {
      ...response,
      data: camelCaseData
    };
  }

  /**
   * Convert object keys to snake_case
   */
  toSnakeCase(response) {
    if (!response.data) return response;
    
    const snakeCaseData = this.convertKeysToSnakeCase(response.data);
    
    return {
      ...response,
      data: snakeCaseData
    };
  }

  /**
   * Convert timestamp strings to Date objects
   */
  convertTimestamps(response) {
    if (!response.data) return response;
    
    const timestampData = this.convertTimestampStrings(response.data);
    
    return {
      ...response,
      data: timestampData
    };
  }

  /**
   * Normalize pagination data
   */
  normalizePagination(response) {
    if (!response.data) return response;
    
    const data = response.data;
    
    // Common pagination patterns
    const paginationKeys = [
      'pagination', 'paging', 'meta', 'page_info', 'pageInfo'
    ];
    
    let pagination = null;
    let items = data;
    
    // Find pagination info
    for (const key of paginationKeys) {
      if (data[key]) {
        pagination = data[key];
        break;
      }
    }
    
    // Extract items array
    const itemKeys = ['items', 'data', 'results', 'records', 'list'];
    for (const key of itemKeys) {
      if (Array.isArray(data[key])) {
        items = data[key];
        break;
      }
    }
    
    // Normalize structure
    const normalized = {
      items: Array.isArray(items) ? items : data,
      pagination: pagination ? this.normalizePaginationInfo(pagination) : null
    };
    
    // Preserve other fields
    Object.keys(data).forEach(key => {
      if (!['items', 'data', 'results', 'records', 'list', 'pagination', 'paging', 'meta', 'page_info', 'pageInfo'].includes(key)) {
        normalized[key] = data[key];
      }
    });
    
    return {
      ...response,
      data: normalized
    };
  }

  /**
   * Normalize error responses
   */
  normalizeErrors(response) {
    if (response.status < 400) return response;
    
    const data = response.data || {};
    
    const normalizedError = {
      error: {
        status: response.status,
        statusText: response.statusText,
        message: this.extractErrorMessage(data),
        code: this.extractErrorCode(data),
        details: this.extractErrorDetails(data),
        timestamp: new Date().toISOString()
      }
    };
    
    // Preserve original data
    if (Object.keys(data).length > 0) {
      normalizedError.originalError = data;
    }
    
    return {
      ...response,
      data: normalizedError
    };
  }

  /**
   * Convert keys to camelCase recursively
   */
  convertKeysToCamelCase(obj) {
    if (Array.isArray(obj)) {
      return obj.map(item => this.convertKeysToCamelCase(item));
    }
    
    if (obj !== null && typeof obj === 'object') {
      const result = {};
      Object.keys(obj).forEach(key => {
        const camelKey = key.replace(/_([a-z])/g, (match, letter) => letter.toUpperCase());
        result[camelKey] = this.convertKeysToCamelCase(obj[key]);
      });
      return result;
    }
    
    return obj;
  }

  /**
   * Convert keys to snake_case recursively
   */
  convertKeysToSnakeCase(obj) {
    if (Array.isArray(obj)) {
      return obj.map(item => this.convertKeysToSnakeCase(item));
    }
    
    if (obj !== null && typeof obj === 'object') {
      const result = {};
      Object.keys(obj).forEach(key => {
        const snakeKey = key.replace(/([A-Z])/g, '_$1').toLowerCase();
        result[snakeKey] = this.convertKeysToSnakeCase(obj[key]);
      });
      return result;
    }
    
    return obj;
  }

  /**
   * Convert timestamp strings to Date objects recursively
   */
  convertTimestampStrings(obj) {
    if (Array.isArray(obj)) {
      return obj.map(item => this.convertTimestampStrings(item));
    }
    
    if (obj !== null && typeof obj === 'object') {
      const result = {};
      Object.keys(obj).forEach(key => {
        const value = obj[key];
        if (typeof value === 'string' && this.isTimestamp(key, value)) {
          result[key] = new Date(value);
        } else {
          result[key] = this.convertTimestampStrings(value);
        }
      });
      return result;
    }
    
    return obj;
  }

  /**
   * Check if value is a timestamp
   */
  isTimestamp(key, value) {
    // Common timestamp field names
    const timestampKeys = [
      'created_at', 'updated_at', 'deleted_at', 'timestamp', 'time',
      'createdAt', 'updatedAt', 'deletedAt', 'date', 'datetime',
      'created', 'updated', 'modified', 'published', 'expires'
    ];
    
    if (timestampKeys.some(k => key.toLowerCase().includes(k.toLowerCase()))) {
      // Check if it's a valid date string
      const date = new Date(value);
      return !isNaN(date.getTime()) && value.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/);
    }
    
    return false;
  }

  /**
   * Normalize pagination information
   */
  normalizePaginationInfo(pagination) {
    return {
      currentPage: pagination.current_page || pagination.currentPage || pagination.page || 1,
      totalPages: pagination.total_pages || pagination.totalPages || pagination.pages || null,
      totalItems: pagination.total || pagination.totalItems || pagination.count || null,
      itemsPerPage: pagination.per_page || pagination.perPage || pagination.limit || null,
      hasNext: pagination.has_next || pagination.hasNext || false,
      hasPrev: pagination.has_prev || pagination.hasPrev || false,
      nextPage: pagination.next_page || pagination.nextPage || null,
      prevPage: pagination.prev_page || pagination.prevPage || null
    };
  }

  /**
   * Extract error message from response data
   */
  extractErrorMessage(data) {
    const messageKeys = ['message', 'error', 'detail', 'description', 'msg'];
    
    for (const key of messageKeys) {
      if (data[key] && typeof data[key] === 'string') {
        return data[key];
      }
    }
    
    if (typeof data === 'string') {
      return data;
    }
    
    return 'An error occurred';
  }

  /**
   * Extract error code from response data
   */
  extractErrorCode(data) {
    const codeKeys = ['code', 'error_code', 'errorCode', 'type', 'error_type'];
    
    for (const key of codeKeys) {
      if (data[key]) {
        return data[key];
      }
    }
    
    return null;
  }

  /**
   * Extract error details from response data
   */
  extractErrorDetails(data) {
    const detailKeys = ['details', 'errors', 'validation_errors', 'fields'];
    
    for (const key of detailKeys) {
      if (data[key]) {
        return data[key];
      }
    }
    
    return null;
  }

  /**
   * Get endpoint key for transformation lookup
   */
  getEndpointKey(url, method) {
    if (!url || !method) return null;
    
    // Remove query parameters and base URL
    const path = url.split('?')[0].replace(/^https?:\/\/[^\/]+/, '');
    return `${method.toUpperCase()} ${path}`;
  }

  /**
   * Add transformation for specific endpoint
   */
  addTransformation(endpoint, transformation) {
    if (!this.transformations[endpoint]) {
      this.transformations[endpoint] = [];
    }
    
    this.transformations[endpoint].push(transformation);
    this.logger.info('Added transformation for endpoint', { endpoint });
  }

  /**
   * Add global transformation
   */
  addGlobalTransformation(transformation) {
    this.globalTransformations.push(transformation);
    this.logger.info('Added global transformation');
  }

  /**
   * Get transformation statistics
   */
  getStats() {
    return {
      enabled: this.enabled,
      endpointTransformations: Object.keys(this.transformations).length,
      globalTransformations: this.globalTransformations.length,
      errorTransformations: Object.keys(this.errorTransformations).length,
      builtInTransformations: Object.keys(this.builtInTransformations)
    };
  }
}