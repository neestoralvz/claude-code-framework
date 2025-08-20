import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import { Logger } from '../utils/Logger.js';

/**
 * Mock Math API Server for testing and demonstration
 * 
 * Provides a simple REST API for mathematical operations
 * Used for integration testing and examples
 */
export class MockMathServer {
  constructor(config = {}) {
    this.port = config.port || 3001;
    this.logger = new Logger('MockMathServer');
    
    this.app = express();
    this.server = null;
    this.history = [];
    this.stats = {
      requests: 0,
      errors: 0,
      startTime: Date.now()
    };
    
    this.setupMiddleware();
    this.setupRoutes();
  }

  /**
   * Setup Express middleware
   */
  setupMiddleware() {
    // Security
    this.app.use(helmet());
    this.app.use(cors());
    
    // Body parsing
    this.app.use(express.json({ limit: '10mb' }));
    this.app.use(express.urlencoded({ extended: true }));
    
    // Request logging
    this.app.use((req, res, next) => {
      this.stats.requests++;
      this.logger.debug('Request received', {
        method: req.method,
        url: req.url,
        headers: req.headers,
        body: req.body
      });
      next();
    });
  }

  /**
   * Setup API routes
   */
  setupRoutes() {
    const router = express.Router();
    
    // Health check
    router.get('/health', (req, res) => {
      res.json({
        status: 'healthy',
        timestamp: new Date().toISOString(),
        uptime: Date.now() - this.stats.startTime
      });
    });
    
    // Basic arithmetic operations
    router.post('/math/add', (req, res) => {
      this.handleOperation(req, res, 'add', (a, b) => a + b);
    });
    
    router.post('/math/subtract', (req, res) => {
      this.handleOperation(req, res, 'subtract', (a, b) => a - b);
    });
    
    router.post('/math/multiply', (req, res) => {
      this.handleOperation(req, res, 'multiply', (a, b) => a * b);
    });
    
    router.post('/math/divide', (req, res) => {
      this.handleOperation(req, res, 'divide', (a, b) => {
        if (b === 0) {
          throw new Error('Division by zero is not allowed');
        }
        return a / b;
      });
    });
    
    router.post('/math/power', (req, res) => {
      try {
        const { base, exponent, precision } = req.body;
        
        if (typeof base !== 'number' || typeof exponent !== 'number') {
          return res.status(400).json({
            error: 'Base and exponent must be numbers'
          });
        }
        
        let result = Math.pow(base, exponent);
        if (typeof precision === 'number') {
          result = parseFloat(result.toFixed(precision));
        }
        
        this.addToHistory('power', { base, exponent }, result);
        
        res.json({
          result,
          operation: 'power',
          operands: { base, exponent },
          timestamp: new Date().toISOString()
        });
      } catch (error) {
        this.handleError(res, error, 'power');
      }
    });
    
    router.post('/math/sqrt', (req, res) => {
      try {
        const { number, precision } = req.body;
        
        if (typeof number !== 'number') {
          return res.status(400).json({
            error: 'Number must be a valid number'
          });
        }
        
        if (number < 0) {
          return res.status(400).json({
            error: 'Cannot calculate square root of negative number'
          });
        }
        
        let result = Math.sqrt(number);
        if (typeof precision === 'number') {
          result = parseFloat(result.toFixed(precision));
        }
        
        this.addToHistory('sqrt', { number }, result);
        
        res.json({
          result,
          operation: 'sqrt',
          operands: { number },
          timestamp: new Date().toISOString()
        });
      } catch (error) {
        this.handleError(res, error, 'sqrt');
      }
    });
    
    // Advanced operations
    router.post('/math/advanced', (req, res) => {
      try {
        const { numbers, operation } = req.body;
        
        if (!Array.isArray(numbers) || numbers.length === 0) {
          return res.status(400).json({
            error: 'Numbers must be a non-empty array'
          });
        }
        
        if (!numbers.every(n => typeof n === 'number')) {
          return res.status(400).json({
            error: 'All elements must be numbers'
          });
        }
        
        let result;
        
        switch (operation) {
          case 'sum':
            result = numbers.reduce((a, b) => a + b, 0);
            break;
          case 'product':
            result = numbers.reduce((a, b) => a * b, 1);
            break;
          case 'average':
            result = numbers.reduce((a, b) => a + b, 0) / numbers.length;
            break;
          case 'median':
            const sorted = [...numbers].sort((a, b) => a - b);
            const mid = Math.floor(sorted.length / 2);
            result = sorted.length % 2 === 0
              ? (sorted[mid - 1] + sorted[mid]) / 2
              : sorted[mid];
            break;
          case 'mode':
            const frequency = {};
            numbers.forEach(n => frequency[n] = (frequency[n] || 0) + 1);
            const maxFreq = Math.max(...Object.values(frequency));
            result = Object.keys(frequency).find(n => frequency[n] === maxFreq);
            result = parseFloat(result);
            break;
          default:
            return res.status(400).json({
              error: 'Invalid operation. Supported: sum, product, average, median, mode'
            });
        }
        
        this.addToHistory(operation, { numbers }, result);
        
        res.json({
          result,
          operation,
          operands: { numbers },
          timestamp: new Date().toISOString()
        });
      } catch (error) {
        this.handleError(res, error, 'advanced');
      }
    });
    
    // Equation solver (simplified)
    router.post('/math/solve', (req, res) => {
      try {
        const { expression, variables = {} } = req.body;
        
        if (typeof expression !== 'string') {
          return res.status(400).json({
            error: 'Expression must be a string'
          });
        }
        
        // Simple expression evaluation (for demo purposes)
        // In production, use a proper math expression parser
        let result;
        try {
          // Replace variables in expression
          let processedExpression = expression;
          Object.entries(variables).forEach(([key, value]) => {
            processedExpression = processedExpression.replace(
              new RegExp(`\\b${key}\\b`, 'g'),
              value.toString()
            );
          });
          
          // Simple evaluation (unsafe in production - use a proper parser)
          result = Function(`"use strict"; return (${processedExpression})`)();
        } catch (error) {
          return res.status(400).json({
            error: 'Invalid mathematical expression'
          });
        }
        
        this.addToHistory('solve', { expression, variables }, result);
        
        res.json({
          result,
          operation: 'solve',
          operands: { expression, variables },
          timestamp: new Date().toISOString()
        });
      } catch (error) {
        this.handleError(res, error, 'solve');
      }
    });
    
    // History endpoints
    router.get('/math/history', (req, res) => {
      const limit = parseInt(req.query.limit) || 10;
      const offset = parseInt(req.query.offset) || 0;
      
      const items = this.history.slice(offset, offset + limit);
      
      res.json({
        items,
        pagination: {
          total: this.history.length,
          limit,
          offset,
          hasMore: offset + limit < this.history.length
        }
      });
    });
    
    router.delete('/math/history', (req, res) => {
      const count = this.history.length;
      this.history = [];
      
      res.json({
        message: 'History cleared',
        deletedCount: count
      });
    });
    
    // Statistics
    router.get('/math/stats', (req, res) => {
      res.json({
        ...this.stats,
        historyCount: this.history.length,
        uptime: Date.now() - this.stats.startTime,
        operationCounts: this.getOperationCounts()
      });
    });
    
    // Mount routes
    this.app.use('/api/v1', router);
    
    // Error handling middleware
    this.app.use((err, req, res, next) => {
      this.stats.errors++;
      this.logger.error('Server error', {
        error: err.message,
        stack: err.stack,
        url: req.url,
        method: req.method
      });
      
      res.status(500).json({
        error: 'Internal server error',
        message: err.message
      });
    });
    
    // 404 handler
    this.app.use((req, res) => {
      res.status(404).json({
        error: 'Endpoint not found',
        path: req.path,
        method: req.method
      });
    });
  }

  /**
   * Handle basic arithmetic operations
   */
  handleOperation(req, res, operation, calculator) {
    try {
      const { a, b, precision } = req.body;
      
      if (typeof a !== 'number' || typeof b !== 'number') {
        return res.status(400).json({
          error: 'Both operands must be numbers'
        });
      }
      
      let result = calculator(a, b);
      
      if (typeof precision === 'number') {
        result = parseFloat(result.toFixed(precision));
      }
      
      this.addToHistory(operation, { a, b }, result);
      
      res.json({
        result,
        operation,
        operands: { a, b },
        timestamp: new Date().toISOString()
      });
    } catch (error) {
      this.handleError(res, error, operation);
    }
  }

  /**
   * Handle errors
   */
  handleError(res, error, operation) {
    this.stats.errors++;
    
    this.logger.error('Operation error', {
      operation,
      error: error.message
    });
    
    res.status(400).json({
      error: error.message,
      operation
    });
  }

  /**
   * Add operation to history
   */
  addToHistory(operation, operands, result) {
    this.history.unshift({
      id: Date.now().toString(),
      operation,
      operands,
      result,
      timestamp: new Date().toISOString()
    });
    
    // Keep only last 1000 operations
    if (this.history.length > 1000) {
      this.history = this.history.slice(0, 1000);
    }
  }

  /**
   * Get operation counts for statistics
   */
  getOperationCounts() {
    const counts = {};
    this.history.forEach(item => {
      counts[item.operation] = (counts[item.operation] || 0) + 1;
    });
    return counts;
  }

  /**
   * Start the server
   */
  async start() {
    return new Promise((resolve, reject) => {
      this.server = this.app.listen(this.port, (error) => {
        if (error) {
          this.logger.error('Failed to start server', { error: error.message });
          reject(error);
        } else {
          this.logger.info('Mock math server started', {
            port: this.port,
            url: `http://localhost:${this.port}`
          });
          resolve();
        }
      });
    });
  }

  /**
   * Stop the server
   */
  async stop() {
    if (this.server) {
      return new Promise((resolve) => {
        this.server.close(() => {
          this.logger.info('Mock math server stopped');
          resolve();
        });
      });
    }
  }

  /**
   * Get server info
   */
  getInfo() {
    return {
      port: this.port,
      running: !!this.server,
      stats: this.stats,
      historyCount: this.history.length
    };
  }
}