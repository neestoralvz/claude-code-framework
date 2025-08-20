/**
 * Jest Configuration - Testing Strategy Specialist Implementation
 * 
 * This configuration demonstrates comprehensive Jest optimization following
 * testing strategy best practices for performance, coverage, and reporting.
 */

module.exports = {
  // Test Environment Configuration
  testEnvironment: 'node',
  
  // Test Discovery Patterns
  testMatch: [
    '**/__tests__/**/*.(js|ts|jsx|tsx)',
    '**/?(*.)+(spec|test).(js|ts|jsx|tsx)'
  ],
  
  // Coverage Configuration
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: [
    'text',           // Console output
    'text-summary',   // Brief summary
    'lcov',          // For CI/CD integration
    'html',          // Detailed HTML report
    'json'           // Machine-readable format
  ],
  
  // Coverage Collection Patterns
  collectCoverageFrom: [
    'src/**/*.{js,ts,jsx,tsx}',
    '!src/**/*.d.ts',
    '!src/**/*.config.{js,ts}',
    '!src/**/index.{js,ts}',
    '!**/node_modules/**',
    '!**/coverage/**'
  ],
  
  // Quality Gates - Coverage Thresholds
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    },
    // Per-file thresholds for critical components
    './src/core/': {
      branches: 90,
      functions: 90,
      lines: 90,
      statements: 90
    }
  },
  
  // Performance Optimization
  maxWorkers: '50%',  // Use half of available CPU cores
  cache: true,
  cacheDirectory: '<rootDir>/.jest-cache',
  
  // Setup and Teardown
  setupFilesAfterEnv: ['<rootDir>/tests/setup.js'],
  setupFiles: ['<rootDir>/tests/global-setup.js'],
  
  // Mock Configuration
  clearMocks: true,      // Clear mock calls between tests
  resetMocks: true,      // Reset mock implementations
  restoreMocks: true,    // Restore original implementations
  
  // Module Resolution
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1',
    '^@tests/(.*)$': '<rootDir>/tests/$1',
    '\\.(css|less|scss|sass)$': 'identity-obj-proxy'
  },
  
  // Transform Configuration
  transform: {
    '^.+\\.(js|jsx|ts|tsx)$': [
      '@swc/jest',  // Fast TypeScript/JavaScript transformation
      {
        jsc: {
          parser: {
            syntax: 'typescript',
            decorators: true
          },
          transform: {
            react: {
              runtime: 'automatic'
            }
          }
        }
      }
    ]
  },
  
  // Reporter Configuration
  reporters: [
    'default',
    [
      'jest-junit',
      {
        outputDirectory: 'coverage/junit',
        outputName: 'junit.xml',
        classNameTemplate: '{classname}',
        titleTemplate: '{title}',
        ancestorSeparator: ' › ',
        usePathForSuiteName: true
      }
    ],
    [
      'jest-html-reporters',
      {
        publicPath: 'coverage/html-report',
        filename: 'report.html',
        openReport: false,
        pageTitle: 'Test Results'
      }
    ]
  ],
  
  // Timeout Configuration
  testTimeout: 10000,  // 10 seconds for individual tests
  
  // Watch Mode Configuration
  watchPlugins: [
    'jest-watch-typeahead/filename',
    'jest-watch-typeahead/testname'
  ],
  
  // Global Configuration
  globals: {
    'ts-jest': {
      useESM: true
    }
  },
  
  // Error Handling
  errorOnDeprecated: true,
  verbose: true,
  
  // Test Results Processing
  testResultsProcessor: './tests/processors/results-processor.js',
  
  // Snapshot Configuration
  snapshotSerializers: [
    'enzyme-to-json/serializer'
  ],
  
  // Test Environment Options
  testEnvironmentOptions: {
    url: 'http://localhost',
    userAgent: 'jest-test-runner'
  },
  
  // Notification Configuration (for development)
  notify: false,
  notifyMode: 'failure-change',
  
  // Bail Configuration (stop on first failure in CI)
  bail: process.env.CI ? 1 : false,
  
  // Silent Mode (reduce output in CI)
  silent: process.env.CI ? true : false
};