[🏠 System Hub](../INDEX.md) | [📁 Examples](../EXAMPLES.md) | [📖 Current Section](#)

---

# Validation Pattern Example

**Context**: Robust validation with clear error feedback following Node.js best practices and fail-fast principles

---

## Complete Validation Implementation

This example demonstrates comprehensive input validation patterns using JSON Schema, middleware, and fail-fast principles from Node.js best practices.

### Product Validation System

#### Schema Definition

```javascript
// schemas/product.schema.js
const productSchema = {
  type: 'object',
  required: ['name', 'price', 'category'],
  properties: {
    name: {
      type: 'string',
      minLength: 2,
      maxLength: 100,
      pattern: '^[a-zA-Z0-9\\s\\-_]+$'
    },
    price: {
      type: 'number',
      minimum: 0.01,
      maximum: 999999.99
    },
    category: {
      type: 'string',
      enum: ['electronics', 'clothing', 'books', 'home', 'sports']
    },
    description: {
      type: 'string',
      maxLength: 1000
    },
    tags: {
      type: 'array',
      items: {
        type: 'string',
        minLength: 1,
        maxLength: 30
      },
      maxItems: 10
    },
    sku: {
      type: 'string',
      pattern: '^[A-Z]{2}[0-9]{4}$'
    }
  },
  additionalProperties: false
};

module.exports = { productSchema };
```

#### Validation Service with Tests

```javascript
// services/validation.service.test.js
const { ValidationService } = require('./validation.service');
const { productSchema } = require('../schemas/product.schema');

describe('ValidationService', () => {
  let validationService;

  beforeEach(() => {
    validationService = new ValidationService();
  });

  describe('validateProduct', () => {
    it('When valid product data provided, then validation passes with no errors', () => {
      // Arrange
      const validProduct = {
        name: 'iPhone 15',
        price: 999.99,
        category: 'electronics',
        description: 'Latest iPhone model',
        tags: ['smartphone', 'apple'],
        sku: 'IP1234'
      };

      // Act
      const result = validationService.validate(validProduct, productSchema);

      // Assert
      expect(result.isValid).toBe(true);
      expect(result.errors).toEqual([]);
    });

    it('When required field missing, then validation fails with specific error message', () => {
      // Arrange
      const invalidProduct = {
        price: 999.99,
        category: 'electronics'
        // name is missing
      };

      // Act
      const result = validationService.validate(invalidProduct, productSchema);

      // Assert
      expect(result.isValid).toBe(false);
      expect(result.errors).toContain('name is required');
    });

    it('When price is negative, then validation fails with business rule error', () => {
      // Arrange
      const invalidProduct = {
        name: 'Test Product',
        price: -10.99, // Invalid negative price
        category: 'electronics'
      };

      // Act
      const result = validationService.validate(invalidProduct, productSchema);

      // Assert
      expect(result.isValid).toBe(false);
      expect(result.errors).toContain('price must be greater than or equal to 0.01');
    });
  });
});
```

#### Validation Service Implementation

```javascript
// services/validation.service.js
const Ajv = require('ajv');
const addFormats = require('ajv-formats');

class ValidationService {
  constructor() {
    this.ajv = new Ajv({ allErrors: true });
    addFormats(this.ajv);
  }

  validate(data, schema) {
    const validator = this.ajv.compile(schema);
    const isValid = validator(data);

    if (isValid) {
      return {
        isValid: true,
        errors: []
      };
    }

    return {
      isValid: false,
      errors: this._formatErrors(validator.errors)
    };
  }

  _formatErrors(ajvErrors) {
    return ajvErrors.map(error => {
      switch (error.keyword) {
        case 'required':
          return `${error.params.missingProperty} is required`;
        case 'minimum':
          return `${error.instancePath.substring(1)} must be greater than or equal to ${error.params.limit}`;
        case 'enum':
          return `${error.instancePath.substring(1)} must be one of: ${error.params.allowedValues.join(', ')}`;
        default:
          return `${error.instancePath.substring(1)} ${error.message}`;
      }
    });
  }
}

module.exports = { ValidationService };
```

## Key Validation Patterns Demonstrated

### 1. **Fail-Fast Principle**
- Validate input immediately upon receipt
- Stop processing at first validation failure
- Provide clear, specific error messages

### 2. **Layered Validation**
- **Schema validation**: Structure and data types
- **Business rule validation**: Domain-specific constraints
- **Security validation**: Prevent injection attacks

### 3. **Comprehensive Error Reporting**
- All validation errors returned together
- User-friendly error messages
- Machine-readable error structure

This validation pattern ensures robust, secure, and user-friendly input handling following Node.js best practices.

---

**Navigation:** [↑ System Hub](../INDEX.md) | [← Examples](../EXAMPLES.md)