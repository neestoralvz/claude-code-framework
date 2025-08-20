import Joi from 'joi';
import { Logger } from '../utils/Logger.js';

/**
 * Request Validator for API requests
 * 
 * Validates request parameters, headers, and body data
 * Provides schema-based validation with custom rules
 */
export class RequestValidator {
  constructor(config = {}) {
    this.enabled = config.enabled !== false;
    this.validationRules = config.validationRules || {};
    this.strictMode = config.strictMode || false;
    
    this.logger = new Logger('RequestValidator');
    
    // Default validation schemas
    this.schemas = {
      headers: this.createHeadersSchema(),
      queryParams: this.createQueryParamsSchema(),
      body: this.createBodySchema()
    };
    
    if (this.enabled) {
      this.logger.info('Request validator initialized', {
        strictMode: this.strictMode,
        customRules: Object.keys(this.validationRules).length
      });
    }
  }

  /**
   * Check if request should be validated
   */
  shouldValidate(config) {
    if (!this.enabled) return false;
    
    // Skip validation for certain endpoints if configured
    const skipValidation = config.skipValidation || 
                          config.headers?.['x-skip-validation'] === 'true';
    
    return !skipValidation;
  }

  /**
   * Validate request configuration
   */
  validate(config) {
    const errors = [];
    
    try {
      // Validate URL
      this.validateUrl(config.url, errors);
      
      // Validate HTTP method
      this.validateMethod(config.method, errors);
      
      // Validate headers
      if (config.headers) {
        this.validateHeaders(config.headers, errors);
      }
      
      // Validate query parameters
      if (config.params) {
        this.validateQueryParams(config.params, errors);
      }
      
      // Validate request body
      if (config.data) {
        this.validateBody(config.data, config.method, errors);
      }
      
      // Validate timeout
      if (config.timeout) {
        this.validateTimeout(config.timeout, errors);
      }
      
      // Apply custom validation rules
      this.applyCustomValidation(config, errors);
      
      if (errors.length > 0) {
        const validationError = new Error(`Request validation failed: ${errors.join(', ')}`);
        validationError.code = 'VALIDATION_ERROR';
        validationError.errors = errors;
        
        this.logger.error('Request validation failed', {
          url: config.url,
          method: config.method,
          errors
        });
        
        throw validationError;
      }
      
      this.logger.debug('Request validation passed', {
        url: config.url,
        method: config.method
      });
      
    } catch (error) {
      if (error.code === 'VALIDATION_ERROR') {
        throw error;
      }
      
      this.logger.error('Validation error', { error: error.message });
      throw new Error(`Validation process failed: ${error.message}`);
    }
  }

  /**
   * Validate URL
   */
  validateUrl(url, errors) {
    if (!url || typeof url !== 'string') {
      errors.push('URL is required and must be a string');
      return;
    }
    
    if (url.trim().length === 0) {
      errors.push('URL cannot be empty');
      return;
    }
    
    // Basic URL format validation for relative and absolute URLs
    const urlPattern = /^(https?:\/\/[^\s/$.?#].[^\s]*|\/[^\s]*)$/i;
    if (!urlPattern.test(url)) {
      errors.push('URL format is invalid');
    }
  }

  /**
   * Validate HTTP method
   */
  validateMethod(method, errors) {
    const validMethods = ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'HEAD', 'OPTIONS'];
    
    if (!method) {
      errors.push('HTTP method is required');
      return;
    }
    
    if (!validMethods.includes(method.toUpperCase())) {
      errors.push(`Invalid HTTP method: ${method}. Allowed: ${validMethods.join(', ')}`);
    }
  }

  /**
   * Validate headers
   */
  validateHeaders(headers, errors) {
    const schema = this.schemas.headers;
    
    const { error } = schema.validate(headers);
    if (error) {
      errors.push(`Headers validation: ${error.message}`);
    }
  }

  /**
   * Validate query parameters
   */
  validateQueryParams(params, errors) {
    const schema = this.schemas.queryParams;
    
    const { error } = schema.validate(params);
    if (error) {
      errors.push(`Query parameters validation: ${error.message}`);
    }
  }

  /**
   * Validate request body
   */
  validateBody(data, method, errors) {
    // Methods that typically don't have body
    const noBodyMethods = ['GET', 'DELETE', 'HEAD', 'OPTIONS'];
    
    if (noBodyMethods.includes(method?.toUpperCase()) && data) {
      if (this.strictMode) {
        errors.push(`${method} requests should not have a body`);
        return;
      } else {
        this.logger.warn(`${method} request has body data`, { method });
      }
    }
    
    // Validate body structure
    const schema = this.schemas.body;
    const { error } = schema.validate(data);
    if (error) {
      errors.push(`Request body validation: ${error.message}`);
    }
  }

  /**
   * Validate timeout
   */
  validateTimeout(timeout, errors) {
    if (typeof timeout !== 'number' || timeout <= 0) {
      errors.push('Timeout must be a positive number');
    }
    
    if (timeout > 300000) { // 5 minutes
      errors.push('Timeout should not exceed 300000ms (5 minutes)');
    }
  }

  /**
   * Apply custom validation rules
   */
  applyCustomValidation(config, errors) {
    Object.entries(this.validationRules).forEach(([ruleName, ruleFunction]) => {
      try {
        const result = ruleFunction(config);
        if (result && result.error) {
          errors.push(`${ruleName}: ${result.error}`);
        }
      } catch (error) {
        this.logger.warn('Custom validation rule failed', {
          ruleName,
          error: error.message
        });
      }
    });
  }

  /**
   * Create headers validation schema
   */
  createHeadersSchema() {
    return Joi.object().pattern(
      Joi.string(),
      Joi.alternatives().try(
        Joi.string(),
        Joi.number(),
        Joi.boolean()
      )
    ).unknown(true);
  }

  /**
   * Create query parameters validation schema
   */
  createQueryParamsSchema() {
    return Joi.object().pattern(
      Joi.string(),
      Joi.alternatives().try(
        Joi.string(),
        Joi.number(),
        Joi.boolean(),
        Joi.array().items(Joi.string())
      )
    ).unknown(true);
  }

  /**
   * Create body validation schema
   */
  createBodySchema() {
    return Joi.alternatives().try(
      Joi.object().unknown(true),
      Joi.array(),
      Joi.string(),
      Joi.number(),
      Joi.boolean(),
      Joi.any().allow(null)
    );
  }

  /**
   * Add custom validation rule
   */
  addValidationRule(name, ruleFunction) {
    if (typeof ruleFunction !== 'function') {
      throw new Error('Validation rule must be a function');
    }
    
    this.validationRules[name] = ruleFunction;
    this.logger.info('Added custom validation rule', { name });
  }

  /**
   * Remove custom validation rule
   */
  removeValidationRule(name) {
    delete this.validationRules[name];
    this.logger.info('Removed custom validation rule', { name });
  }

  /**
   * Create validation schema for specific endpoint
   */
  static createEndpointSchema(endpoint, options = {}) {
    const {
      requiredHeaders = [],
      allowedMethods = ['GET', 'POST', 'PUT', 'DELETE'],
      bodySchema = null,
      querySchema = null
    } = options;

    return {
      endpoint,
      validate: (config) => {
        const errors = [];

        // Validate method
        if (!allowedMethods.includes(config.method?.toUpperCase())) {
          errors.push(`Method ${config.method} not allowed for ${endpoint}`);
        }

        // Validate required headers
        requiredHeaders.forEach(header => {
          if (!config.headers?.[header]) {
            errors.push(`Required header missing: ${header}`);
          }
        });

        // Validate body with custom schema
        if (bodySchema && config.data) {
          const { error } = bodySchema.validate(config.data);
          if (error) {
            errors.push(`Body validation: ${error.message}`);
          }
        }

        // Validate query parameters with custom schema
        if (querySchema && config.params) {
          const { error } = querySchema.validate(config.params);
          if (error) {
            errors.push(`Query validation: ${error.message}`);
          }
        }

        return errors.length > 0 ? { error: errors.join(', ') } : { valid: true };
      }
    };
  }

  /**
   * Get validation statistics
   */
  getStats() {
    return {
      enabled: this.enabled,
      strictMode: this.strictMode,
      customRules: Object.keys(this.validationRules).length,
      ruleNames: Object.keys(this.validationRules)
    };
  }
}