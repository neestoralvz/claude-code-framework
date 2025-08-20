/**
 * Jest Configuration for TDD/BDD Quality Gates
 * 
 * Comprehensive test configuration implementing quality gate thresholds
 * for test coverage, performance, and reliability standards.
 */

module.exports = {
  // Test Environment Configuration
  testEnvironment: 'node',
  
  // Coverage Configuration - Implements Quality Gates
  collectCoverage: true,
  collectCoverageFrom: [
    'src/**/*.{js,ts,jsx,tsx}',
    '!src/**/*.test.{js,ts,jsx,tsx}',
    '!src/**/*.spec.{js,ts,jsx,tsx}',
    '!src/**/__tests__/**',
    '!src/**/__mocks__/**',
    '!src/**/node_modules/**',
    '!src/**/*.d.ts',
    '!src/**/coverage/**'
  ],
  
  // Quality Gate: Coverage Thresholds
  coverageThreshold: {
    global: {
      branches: 90,      // Quality Gate: 90% branch coverage
      functions: 90,     // Quality Gate: 90% function coverage  
      lines: 90,         // Quality Gate: 90% line coverage
      statements: 90     // Quality Gate: 90% statement coverage
    },
    // Critical path requirements - 100% coverage
    './src/core/**/*.{js,ts}': {
      branches: 100,
      functions: 100,
      lines: 100,
      statements: 100
    },
    // Business logic requirements - higher threshold
    './src/business/**/*.{js,ts}': {
      branches: 95,
      functions: 95,
      lines: 95,
      statements: 95
    }
  },
  
  // Coverage Reporting
  coverageReporters: [
    'text',           // Console output
    'text-summary',   // Brief summary
    'html',           // Detailed HTML report
    'lcov',           // LCOV format for CI/CD
    'json-summary',   // JSON for programmatic access
    'cobertura'       // XML format for CI/CD integration
  ],
  
  coverageDirectory: 'coverage',
  
  // Test Discovery and Execution
  testMatch: [
    '<rootDir>/src/**/__tests__/**/*.(js|ts|jsx|tsx)',
    '<rootDir>/src/**/?(*.)(test|spec).(js|ts|jsx|tsx)',
    '<rootDir>/tests/**/*.(js|ts|jsx|tsx)'
  ],
  
  // Test Organization for TDD/BDD
  testPathIgnorePatterns: [
    '/node_modules/',
    '/dist/',
    '/build/',
    '/coverage/'
  ],
  
  // Performance Quality Gates
  // Quality Gate: Test execution under 30 seconds for unit tests
  testTimeout: 30000,
  
  // Module Resolution
  moduleFileExtensions: ['js', 'ts', 'jsx', 'tsx', 'json'],
  
  // Transform Configuration
  transform: {
    '^.+\\.(js|jsx|ts|tsx)$': 'babel-jest'
  },
  
  // Setup Configuration
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.js'],
  
  // Quality Gate: Test Reliability - Reduce Flakiness
  maxWorkers: '50%',  // Stable parallel execution
  
  // BDD Integration - Cucumber Support
  preset: undefined,  // Allow for custom configuration
  
  // Test Results Processing
  reporters: [
    'default',
    [
      'jest-junit',
      {
        outputDirectory: 'test-results',
        outputName: 'junit.xml',
        suiteName: 'TDD/BDD Test Suite'
      }
    ],
    [
      'jest-html-reporter',
      {
        pageTitle: 'Test Results - Quality Gates',
        outputPath: 'test-results/test-report.html',
        includeFailureMsg: true,
        includeSuiteFailure: true
      }
    ]
  ],
  
  // Quality Gate: Test Organization Standards
  collectCoverageFrom: [
    'src/**/*.{js,ts,jsx,tsx}',
    // Exclude test files from coverage
    '!src/**/*.{test,spec}.{js,ts,jsx,tsx}',
    '!src/**/__tests__/**',
    '!src/**/__mocks__/**',
    // Exclude generated files
    '!src/**/*.d.ts',
    '!src/**/generated/**',
    // Exclude configuration files
    '!src/**/config/**',
    '!src/**/*.config.{js,ts}'
  ],
  
  // Test Quality Gates - Specific Test Categories
  projects: [
    {
      displayName: 'Unit Tests',
      testMatch: ['<rootDir>/src/**/*.test.(js|ts|jsx|tsx)'],
      // Quality Gate: Unit tests must be fast
      testTimeout: 5000
    },
    {
      displayName: 'Integration Tests', 
      testMatch: ['<rootDir>/src/**/*.integration.(js|ts|jsx|tsx)'],
      // Quality Gate: Integration tests under 5 minutes total
      testTimeout: 30000,
      setupFilesAfterEnv: ['<rootDir>/src/setupIntegrationTests.js']
    },
    {
      displayName: 'BDD Scenarios',
      testMatch: ['<rootDir>/features/**/*.steps.(js|ts)'],
      testTimeout: 60000,
      setupFilesAfterEnv: ['<rootDir>/src/setupBDDTests.js']
    }
  ],
  
  // Quality Gate: Test Isolation
  clearMocks: true,
  resetMocks: true,
  restoreMocks: true,
  
  // Performance Monitoring
  verbose: false,  // Detailed output only when needed
  silent: false,   // Allow console output for debugging
  
  // Quality Gate: Test Naming and Organization
  testNamePattern: undefined,  // Allow all test names
  
  // Error Handling for Quality Gates
  bail: false,  // Run all tests to get complete picture
  
  // Watch Mode Configuration for Development
  watchPathIgnorePatterns: [
    '/node_modules/',
    '/coverage/',
    '/dist/',
    '/build/'
  ],
  
  // Quality Gate: Test Environment Consistency
  testEnvironmentOptions: {
    // Ensure consistent environment for all tests
    url: 'http://localhost'
  },
  
  // Global Test Configuration
  globals: {
    'ts-jest': {
      tsconfig: 'tsconfig.json'
    }
  },
  
  // Module Mocking for Test Isolation
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1',
    '^@tests/(.*)$': '<rootDir>/tests/$1'
  },
  
  // Test Data Management
  moduleDirectories: ['node_modules', '<rootDir>/src'],
  
  // Quality Gate Validation Functions
  globalSetup: '<rootDir>/scripts/test-quality-setup.js',
  globalTeardown: '<rootDir>/scripts/test-quality-teardown.js'
};