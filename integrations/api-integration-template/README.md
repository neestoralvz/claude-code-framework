# REST API Integration Template

A comprehensive, production-ready REST API integration solution demonstrating best practices for API connectivity, resilience patterns, monitoring, and error handling.

## Features

### 🚀 Core Integration Components
- **Robust HTTP Client**: Production-ready API client with request/response interceptors
- **Circuit Breaker Pattern**: Prevents cascading failures with configurable failure thresholds
- **Intelligent Retry Logic**: Exponential backoff with jitter for transient failure recovery
- **Request/Response Validation**: Schema-based validation with custom rules
- **Response Transformation**: Flexible data transformation and normalization pipelines

### 🛡️ Resilience & Error Handling
- **Comprehensive Error Handling**: Meaningful error messages with operation context
- **Authentication Integration**: Support for Bearer, API Key, and Basic authentication
- **Timeout Management**: Configurable timeouts with fallback strategies
- **Graceful Degradation**: Fallback mechanisms for service failures

### 📊 Monitoring & Observability
- **Real-time Metrics**: Request/response timing, success rates, error tracking
- **Performance Analytics**: Response time percentiles, throughput monitoring
- **Health Checks**: Service availability and client health monitoring
- **Structured Logging**: JSON-formatted logs with correlation IDs

### 🧪 Testing & Quality Assurance
- **Comprehensive Test Suite**: Unit and integration tests with 80%+ coverage
- **Mock Server**: Fully functional mock API for testing and development
- **Load Testing**: Performance testing with burst and sustained load scenarios
- **Edge Case Testing**: Comprehensive validation of error conditions

## Quick Start

### Installation

```bash
npm install
```

### Run Demo

```bash
# Basic functionality demo
npm run demo

# Comprehensive monitoring demo
npm run monitor

# Run all tests
npm test

# Run with coverage
npm run test:coverage
```

### Basic Usage

```javascript
import { MathApiService } from './src/services/MathApiService.js';

// Initialize service with production configuration
const mathService = new MathApiService({
  baseURL: 'https://api.example.com/v1',
  timeout: 10000,
  retry: {
    enabled: true,
    maxAttempts: 3,
    baseDelay: 1000,
    backoffMultiplier: 2
  },
  circuitBreaker: {
    enabled: true,
    failureThreshold: 5,
    resetTimeout: 30000
  },
  auth: {
    type: 'bearer',
    token: 'your-api-token'
  }
});

// Perform operations with automatic retry and error handling
try {
  const result = await mathService.add(10, 20, { precision: 2 });
  console.log('Result:', result.result);
} catch (error) {
  console.error('Operation failed:', error.message);
  console.error('Error code:', error.code);
}

// Monitor service health
const health = await mathService.healthCheck();
console.log('Service status:', health.service);

// Get comprehensive metrics
const metrics = mathService.getMetrics();
console.log('Success rate:', `${metrics.requests.successRate}%`);
console.log('Average response time:', `${metrics.timing.averageResponseTime}ms`);
```

## Architecture

### Core Components

```
src/
├── core/                    # Core integration components
│   ├── ApiClient.js        # Main HTTP client with interceptors
│   ├── CircuitBreaker.js   # Circuit breaker implementation
│   ├── RetryManager.js     # Retry logic with exponential backoff
│   ├── RequestValidator.js # Request validation and schemas
│   ├── ResponseTransformer.js # Response transformation pipeline
│   └── ApiMetrics.js       # Metrics collection and aggregation
├── services/               # Service implementations
│   └── MathApiService.js   # Example math API service
├── utils/                  # Utilities
│   └── Logger.js           # Structured logging
└── mock/                   # Mock server for testing
    └── MockMathServer.js   # Express-based mock API server
```

### Integration Patterns

#### 1. Circuit Breaker Pattern
```javascript
const client = new ApiClient({
  circuitBreaker: {
    enabled: true,
    failureThreshold: 5,      // Open after 5 failures
    resetTimeout: 30000,      // Try again after 30s
    monitoringPeriod: 10000,  // Monitor over 10s windows
    volumeThreshold: 10,      // Minimum requests to evaluate
    errorPercentageThreshold: 50 // Open at 50% error rate
  }
});
```

#### 2. Retry with Exponential Backoff
```javascript
const client = new ApiClient({
  retry: {
    enabled: true,
    maxAttempts: 3,           // Maximum retry attempts
    baseDelay: 1000,          # Base delay in ms
    maxDelay: 30000,          # Maximum delay cap
    backoffMultiplier: 2,     # Exponential multiplier
    jitterFactor: 0.1         # Add randomness to prevent thundering herd
  }
});
```

#### 3. Request/Response Validation
```javascript
// Custom validation rules
const validator = new RequestValidator({
  validationRules: {
    customRule: (config) => {
      if (config.data?.amount > 1000000) {
        return { error: 'Amount exceeds limit' };
      }
    }
  }
});

// Endpoint-specific schemas
const schema = RequestValidator.createEndpointSchema('/users', {
  requiredHeaders: ['Authorization'],
  allowedMethods: ['GET', 'POST'],
  bodySchema: Joi.object({
    name: Joi.string().required(),
    email: Joi.string().email().required()
  })
});
```

#### 4. Response Transformation
```javascript
// Global transformations
transformer.addGlobalTransformation('camelCase');
transformer.addGlobalTransformation('timestamps');

// Endpoint-specific transformations
transformer.addTransformation('GET /users', (response) => {
  response.data.users = response.data.users.map(user => ({
    ...user,
    fullName: `${user.firstName} ${user.lastName}`
  }));
  return response;
});
```

## Configuration Options

### ApiClient Configuration
```javascript
const config = {
  // Base configuration
  baseURL: 'https://api.example.com/v1',
  timeout: 10000,
  
  // Authentication
  auth: {
    type: 'bearer',           // 'bearer', 'apikey', 'basic'
    token: 'token',           # For bearer
    key: 'api-key',          # For apikey
    header: 'X-API-Key',     # Custom header for apikey
    username: 'user',        # For basic
    password: 'pass'         # For basic
  },
  
  // Retry configuration
  retry: {
    enabled: true,
    maxAttempts: 3,
    baseDelay: 1000,
    maxDelay: 30000,
    backoffMultiplier: 2,
    jitterFactor: 0.1,
    retryCondition: (error, attempt) => boolean
  },
  
  // Circuit breaker configuration
  circuitBreaker: {
    enabled: true,
    failureThreshold: 5,
    resetTimeout: 30000,
    monitoringPeriod: 10000,
    volumeThreshold: 10,
    errorPercentageThreshold: 50
  },
  
  // Request validation
  requestValidator: {
    enabled: true,
    strictMode: false,
    validationRules: {}
  },
  
  // Response transformation
  responseTransformer: {
    enabled: true,
    globalTransformations: ['camelCase', 'timestamps'],
    transformations: {},
    errorTransformations: {}
  }
};
```

## Testing

### Unit Tests
```bash
# Run all unit tests
npm test

# Run specific test file
npm test CircuitBreaker.test.js

# Watch mode
npm run test:watch
```

### Integration Tests
```bash
# Run integration tests
npm run test:integration

# Run with coverage
npm run test:coverage
```

### Mock Server
The included mock server provides a realistic API for testing:

```bash
# Start standalone mock server
node src/mock/MockMathServer.js

# Server runs on http://localhost:3001
# Available endpoints:
# POST /api/v1/math/add
# POST /api/v1/math/subtract
# POST /api/v1/math/multiply
# POST /api/v1/math/divide
# GET /api/v1/health
```

## Examples

### Error Handling
```javascript
try {
  const result = await mathService.divide(10, 0);
} catch (error) {
  switch (error.code) {
    case 'VALIDATION_ERROR':
      console.log('Invalid input:', error.message);
      break;
    case 'SERVICE_UNAVAILABLE':
      console.log('Service temporarily down, retry after:', error.retryAfter);
      break;
    case 'RATE_LIMIT_EXCEEDED':
      console.log('Rate limited, retry after:', error.retryAfter);
      break;
    case 'TIMEOUT':
      console.log('Request timed out, service may be overloaded');
      break;
    default:
      console.log('Unexpected error:', error.message);
  }
}
```

### Monitoring and Metrics
```javascript
// Get comprehensive metrics
const metrics = service.getMetrics();

console.log('Request Metrics:', {
  total: metrics.requests.total,
  success: metrics.requests.success,
  errors: metrics.requests.errors,
  successRate: `${metrics.requests.successRate}%`,
  errorRate: `${metrics.requests.errorRate}%`
});

console.log('Performance Metrics:', {
  avgResponseTime: `${metrics.timing.averageResponseTime}ms`,
  p50: `${metrics.timing.percentiles.p50}ms`,
  p95: `${metrics.timing.percentiles.p95}ms`,
  p99: `${metrics.timing.percentiles.p99}ms`
});

console.log('Throughput:', {
  requestsPerSecond: metrics.throughput.requestsPerSecond,
  requestsPerMinute: metrics.throughput.requestsPerMinute
});
```

### Custom Service Implementation
```javascript
import { ApiClient } from './src/core/ApiClient.js';

class CustomApiService {
  constructor(config) {
    this.client = new ApiClient({
      baseURL: config.baseURL,
      auth: config.auth,
      retry: { enabled: true, maxAttempts: 3 },
      circuitBreaker: { enabled: true }
    });
  }

  async getUsers(params = {}) {
    try {
      const response = await this.client.get('/users', { params });
      return response.data;
    } catch (error) {
      throw this.handleError(error, 'getUsers');
    }
  }

  async createUser(userData) {
    // Validate input
    const schema = Joi.object({
      name: Joi.string().required(),
      email: Joi.string().email().required()
    });

    const { error, value } = schema.validate(userData);
    if (error) {
      throw new Error(`Validation error: ${error.message}`);
    }

    try {
      const response = await this.client.post('/users', value);
      return response.data;
    } catch (error) {
      throw this.handleError(error, 'createUser');
    }
  }

  handleError(error, operation) {
    // Custom error handling logic
    const customError = new Error();
    customError.operation = operation;
    customError.originalError = error;

    if (error.response?.status === 400) {
      customError.message = `Invalid input for ${operation}`;
      customError.code = 'INVALID_INPUT';
    } else if (error.response?.status === 409) {
      customError.message = `Resource conflict in ${operation}`;
      customError.code = 'CONFLICT';
    } else {
      customError.message = `Service error in ${operation}: ${error.message}`;
      customError.code = 'SERVICE_ERROR';
    }

    return customError;
  }
}
```

## Best Practices

### 1. Error Handling
- Always provide meaningful error messages with context
- Use specific error codes for different failure types
- Include operation context in errors for better debugging
- Implement proper fallback strategies

### 2. Resilience Patterns
- Configure circuit breakers based on service SLAs
- Use exponential backoff with jitter for retries
- Set appropriate timeout values for different operations
- Monitor and alert on circuit breaker state changes

### 3. Security
- Never log sensitive authentication tokens
- Validate all inputs before sending requests
- Use HTTPS for all production communications
- Implement proper token refresh mechanisms

### 4. Performance
- Use connection pooling for high-throughput scenarios
- Monitor response time percentiles, not just averages
- Set appropriate cache headers for cacheable responses
- Implement request deduplication for idempotent operations

### 5. Monitoring
- Track success rates, error rates, and response times
- Monitor circuit breaker and retry metrics
- Implement health checks for all dependencies
- Use structured logging with correlation IDs

## Production Deployment

### Environment Variables
```bash
# API Configuration
API_BASE_URL=https://api.production.com/v1
API_TIMEOUT=10000
API_AUTH_TOKEN=prod-token

# Logging
LOG_LEVEL=info
NODE_ENV=production

# Monitoring
ENABLE_METRICS=true
METRICS_PORT=9090
```

### Docker Support
```dockerfile
FROM node:18-alpine

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

COPY src/ ./src/
COPY examples/ ./examples/

EXPOSE 3000 9090
CMD ["npm", "start"]
```

### Health Checks
```bash
# Application health
curl http://localhost:3000/health

# Metrics endpoint
curl http://localhost:9090/metrics
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Write tests for your changes
4. Ensure all tests pass (`npm test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Setup
```bash
# Install dependencies
npm install

# Run tests in watch mode
npm run test:watch

# Run linter
npm run lint

# Fix linting issues
npm run lint:fix
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions, issues, or contributions, please:
1. Check existing issues in the GitHub repository
2. Create a new issue with detailed description and reproduction steps
3. Include relevant logs and configuration details
4. Provide environment information (Node.js version, OS, etc.)

---

**Built with ❤️ for reliable API integrations**