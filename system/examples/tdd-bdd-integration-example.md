[🏠 System Hub](../INDEX.md) | [📁 Examples](../EXAMPLES.md) | [📖 Current Section](#)

---

# TDD/BDD Integration Example

**Context**: Practical demonstration of combining Test-Driven Development with Behavior-Driven Development for user authentication feature

---

## Complete TDD/BDD Workflow

This example shows how to integrate TDD and BDD using a real user authentication feature, following current Jest and Node.js best practices.

### Phase 1: BDD - Define User Behavior

Start with business behavior specifications:

```gherkin
Feature: User Authentication
  As a website user
  I want to log in with my credentials
  So that I can access my personal dashboard

Scenario: Successful login with valid credentials
  Given a registered user with username "john@example.com" and password "secure123"
  When they submit their login credentials
  Then they should be redirected to their dashboard
  And they should see a welcome message

Scenario: Failed login with invalid credentials
  Given an unregistered email "invalid@example.com"
  When they submit login credentials
  Then they should see an error message "Invalid credentials"
  And they should remain on the login page
```

### Phase 2: BDD - Write Acceptance Test

```javascript
// auth.integration.test.js
describe('User Authentication Feature', () => {
  let app;
  let testUser;

  beforeEach(async () => {
    // Arrange - Fresh data for each test (best practice)
    testUser = await UserService.createUser({
      email: 'john@example.com',
      password: 'secure123'
    });
    app = await createTestApp();
  });

  describe('Login Process', () => {
    it('When user submits valid credentials, then they access dashboard with welcome message', async () => {
      // Arrange - Following AAA pattern
      const loginData = {
        email: 'john@example.com',
        password: 'secure123'
      };

      // Act
      const response = await request(app)
        .post('/auth/login')
        .send(loginData)
        .expect(302); // Redirect status

      // Assert
      expect(response.headers.location).toBe('/dashboard');
      
      // Verify dashboard contains welcome message
      const dashboardResponse = await request(app)
        .get('/dashboard')
        .set('Cookie', response.headers['set-cookie'])
        .expect(200);
      
      expect(dashboardResponse.text).toContain('Welcome, john@example.com');
    });

    it('When user submits invalid credentials, then they see error and remain on login page', async () => {
      // Arrange
      const invalidLoginData = {
        email: 'invalid@example.com',
        password: 'wrongpassword'
      };

      // Act
      const response = await request(app)
        .post('/auth/login')
        .send(invalidLoginData)
        .expect(400);

      // Assert
      expect(response.body.error).toBe('Invalid credentials');
      expect(response.body.redirectTo).toBeUndefined();
    });
  });
});
```

### Phase 3: TDD - Implement with Red-Green-Refactor

#### Step 1: Red - Write Failing Unit Tests

```javascript
// auth.service.test.js
describe('AuthService', () => {
  let authService;
  let userRepositoryStub;
  let passwordUtilStub;

  beforeEach(() => {
    // Arrange - Mock dependencies
    userRepositoryStub = {
      findByEmail: jest.fn(),
    };
    passwordUtilStub = {
      compare: jest.fn(),
    };
    
    authService = new AuthService(userRepositoryStub, passwordUtilStub);
  });

  describe('authenticateUser', () => {
    it('When valid credentials provided, then returns user with success status', async () => {
      // Arrange
      const email = 'john@example.com';
      const password = 'secure123';
      const mockUser = { id: 1, email, hashedPassword: 'hashed123' };
      
      userRepositoryStub.findByEmail.mockResolvedValue(mockUser);
      passwordUtilStub.compare.mockResolvedValue(true);

      // Act
      const result = await authService.authenticateUser(email, password);

      // Assert
      expect(result.success).toBe(true);
      expect(result.user).toEqual({ id: 1, email });
      expect(result.user.hashedPassword).toBeUndefined(); // Security: no password in response
    });

    it('When user not found, then throws operational error with specific message', async () => {
      // Arrange
      const email = 'nonexistent@example.com';
      const password = 'anypassword';
      
      userRepositoryStub.findByEmail.mockResolvedValue(null);

      // Act & Assert - Testing error throwing pattern
      await expect(authService.authenticateUser(email, password))
        .rejects
        .toThrow(AppError);
      
      // Verify error details
      try {
        await authService.authenticateUser(email, password);
      } catch (error) {
        expect(error.message).toBe('Invalid credentials');
        expect(error.isOperational).toBe(true);
        expect(error.httpCode).toBe(400);
      }
    });

    it('When password invalid, then throws operational error', async () => {
      // Arrange
      const email = 'john@example.com';
      const password = 'wrongpassword';
      const mockUser = { id: 1, email, hashedPassword: 'hashed123' };
      
      userRepositoryStub.findByEmail.mockResolvedValue(mockUser);
      passwordUtilStub.compare.mockResolvedValue(false);

      // Act & Assert
      await expect(authService.authenticateUser(email, password))
        .rejects
        .toThrow('Invalid credentials');
    });
  });
});
```

#### Step 2: Green - Minimal Implementation

```javascript
// auth.service.js
const { AppError } = require('../utils/app-error');

class AuthService {
  constructor(userRepository, passwordUtil) {
    this.userRepository = userRepository;
    this.passwordUtil = passwordUtil;
  }

  async authenticateUser(email, password) {
    // Input validation (fail-fast principle)
    if (!email || !password) {
      throw new AppError(
        'ValidationError',
        400,
        'Email and password are required',
        true
      );
    }

    // Find user
    const user = await this.userRepository.findByEmail(email);
    if (!user) {
      throw new AppError(
        'AuthenticationError',
        400,
        'Invalid credentials',
        true
      );
    }

    // Verify password
    const isPasswordValid = await this.passwordUtil.compare(password, user.hashedPassword);
    if (!isPasswordValid) {
      throw new AppError(
        'AuthenticationError',
        400,
        'Invalid credentials',
        true
      );
    }

    // Return success (excluding sensitive data)
    return {
      success: true,
      user: {
        id: user.id,
        email: user.email
      }
    };
  }
}

module.exports = { AuthService };
```

#### Step 3: Refactor - Improve Design

```javascript
// auth.service.js (refactored)
const { AppError } = require('../utils/app-error');
const { validateEmail } = require('../utils/validation');

class AuthService {
  constructor(userRepository, passwordUtil, logger) {
    this.userRepository = userRepository;
    this.passwordUtil = passwordUtil;
    this.logger = logger;
  }

  async authenticateUser(email, password) {
    try {
      // Enhanced validation
      this._validateLoginInput(email, password);

      const user = await this._findUserByEmail(email);
      await this._verifyPassword(password, user.hashedPassword);

      this.logger.info('User authenticated successfully', { userId: user.id });

      return this._createSuccessResponse(user);
    } catch (error) {
      this.logger.warn('Authentication failed', { email, error: error.message });
      throw error;
    }
  }

  _validateLoginInput(email, password) {
    if (!email || !password) {
      throw new AppError(
        'ValidationError',
        400,
        'Email and password are required',
        true
      );
    }

    if (!validateEmail(email)) {
      throw new AppError(
        'ValidationError',
        400,
        'Invalid email format',
        true
      );
    }
  }

  async _findUserByEmail(email) {
    const user = await this.userRepository.findByEmail(email);
    if (!user) {
      throw new AppError(
        'AuthenticationError',
        400,
        'Invalid credentials',
        true
      );
    }
    return user;
  }

  async _verifyPassword(password, hashedPassword) {
    const isValid = await this.passwordUtil.compare(password, hashedPassword);
    if (!isValid) {
      throw new AppError(
        'AuthenticationError',
        400,
        'Invalid credentials',
        true
      );
    }
  }

  _createSuccessResponse(user) {
    return {
      success: true,
      user: {
        id: user.id,
        email: user.email,
        // Only include safe user data
      }
    };
  }
}

module.exports = { AuthService };
```

### Phase 4: Integration - Controller Implementation

```javascript
// auth.controller.js
const { AuthService } = require('../services/auth.service');

class AuthController {
  constructor(authService, sessionManager) {
    this.authService = authService;
    this.sessionManager = sessionManager;
  }

  async login(req, res, next) {
    try {
      // Arrange
      const { email, password } = req.body;

      // Act
      const authResult = await this.authService.authenticateUser(email, password);
      
      // Create session
      await this.sessionManager.createSession(req, authResult.user);

      // Assert/Respond
      res.redirect('/dashboard');
    } catch (error) {
      if (error.isOperational) {
        res.status(error.httpCode).json({
          error: error.message
        });
      } else {
        next(error); // Let error handler deal with unexpected errors
      }
    }
  }
}

module.exports = { AuthController };
```

## Key Best Practices Demonstrated

### TDD Best Practices
- **Red-Green-Refactor cycle**: Clear progression from failing test to working code
- **Test names with 3 parts**: Unit under test, scenario, expected outcome
- **AAA pattern**: Arrange, Act, Assert structure in every test
- **Fail-fast validation**: Input validation with clear error messages

### BDD Best Practices
- **Outside-in development**: Start with user scenarios, work inward
- **Given-When-Then**: Clear scenario structure
- **Living documentation**: Tests serve as executable specifications
- **Business language**: Tests readable by non-technical stakeholders

### Node.js Best Practices
- **Error handling**: Operational vs programmer errors
- **Input validation**: Fail-fast with meaningful messages
- **Security**: No sensitive data in responses
- **Logging**: Structured logging for debugging
- **Separation of concerns**: Clear service/controller boundaries

### Testing Best Practices
- **Per-test data**: Fresh test data for each test
- **No global fixtures**: Independent, predictable tests
- **Descriptive test names**: Clear intent without reading implementation
- **Proper mocking**: Isolate units under test

## Success Metrics

- ✅ **BDD scenarios pass**: User requirements are met
- ✅ **Unit tests pass**: Individual components work correctly
- ✅ **Integration tests pass**: Components work together
- ✅ **Error scenarios covered**: Graceful failure handling
- ✅ **Security requirements met**: No data leaks, proper validation

This example demonstrates how TDD and BDD complement each other, with BDD defining *what* to build and TDD defining *how* to build it reliably.

---

**Navigation:** [↑ System Hub](../INDEX.md) | [← Examples](../EXAMPLES.md)