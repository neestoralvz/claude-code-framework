/**
 * ESLint Configuration for TDD/BDD Quality Gates
 * 
 * Code quality rules implementing complexity thresholds,
 * maintainability standards, and TDD/BDD best practices.
 */

module.exports = {
  env: {
    browser: true,
    node: true,
    es2021: true,
    jest: true
  },
  
  extends: [
    'eslint:recommended',
    '@typescript-eslint/recommended',
    'plugin:jest/recommended',
    'plugin:jest/style'
  ],
  
  parser: '@typescript-eslint/parser',
  
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module',
    ecmaFeatures: {
      jsx: true
    }
  },
  
  plugins: [
    '@typescript-eslint',
    'jest',
    'complexity',
    'sonarjs'
  ],
  
  // Quality Gate Rules
  rules: {
    // Complexity Quality Gates
    'complexity': ['error', { max: 10 }],  // Quality Gate: Max cyclomatic complexity 10
    'max-lines-per-function': ['error', { max: 50, skipBlankLines: true, skipComments: true }],
    'max-depth': ['error', { max: 4 }],    // Quality Gate: Max nesting depth
    'max-params': ['error', { max: 4 }],   // Quality Gate: Max function parameters
    'max-statements': ['error', { max: 20 }], // Quality Gate: Max statements per function
    'max-lines': ['error', { max: 300, skipBlankLines: true, skipComments: true }],
    
    // Cognitive Complexity (SonarJS)
    'sonarjs/cognitive-complexity': ['error', 15], // Quality Gate: Max cognitive complexity 15
    'sonarjs/no-identical-functions': 'error',
    'sonarjs/no-duplicate-string': ['error', { threshold: 3 }],
    'sonarjs/prefer-immediate-return': 'error',
    'sonarjs/prefer-object-literal': 'error',
    'sonarjs/no-small-switch': 'error',
    
    // Code Quality Gates
    'no-console': ['warn'],  // Allow console for debugging, warn to review
    'no-debugger': 'error',
    'no-alert': 'error',
    'no-eval': 'error',
    'no-implied-eval': 'error',
    'no-new-func': 'error',
    
    // Variable and Function Quality
    'no-var': 'error',
    'prefer-const': 'error',
    'prefer-arrow-callback': 'error',
    'arrow-spacing': 'error',
    'no-unused-vars': 'off', // Handled by TypeScript
    '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    
    // TDD/BDD Test Quality Gates
    'jest/consistent-test-it': ['error', { fn: 'test', withinDescribe: 'it' }],
    'jest/expect-expect': 'error',
    'jest/no-disabled-tests': 'warn',
    'jest/no-focused-tests': 'error',
    'jest/no-identical-title': 'error',
    'jest/prefer-to-have-length': 'error',
    'jest/prefer-to-be': 'error',
    'jest/prefer-strict-equal': 'error',
    'jest/require-top-level-describe': 'error',
    'jest/valid-describe-callback': 'error',
    'jest/valid-expect': 'error',
    
    // Test Organization Quality
    'jest/prefer-expect-assertions': 'warn',
    'jest/prefer-to-contain': 'error',
    'jest/no-test-return-statement': 'error',
    'jest/no-try-expect': 'error',
    'jest/no-conditional-expect': 'error',
    
    // Documentation Quality Gates
    'require-jsdoc': ['error', {
      require: {
        FunctionDeclaration: true,
        MethodDefinition: true,
        ClassDeclaration: true,
        ArrowFunctionExpression: false,
        FunctionExpression: false
      }
    }],
    
    'valid-jsdoc': ['error', {
      prefer: {
        return: 'returns',
        arg: 'param'
      },
      preferType: {
        Boolean: 'boolean',
        Number: 'number',
        String: 'string',
        Object: 'object'
      },
      requireReturn: false,
      requireParamDescription: true,
      requireReturnDescription: false
    }],
    
    // TypeScript Quality Gates
    '@typescript-eslint/explicit-function-return-type': ['error', {
      allowExpressions: true,
      allowTypedFunctionExpressions: true
    }],
    '@typescript-eslint/no-explicit-any': 'error',
    '@typescript-eslint/no-non-null-assertion': 'error',
    '@typescript-eslint/prefer-optional-chain': 'error',
    '@typescript-eslint/prefer-nullish-coalescing': 'error',
    
    // Import/Export Quality
    'import/no-unresolved': 'off', // Handled by TypeScript
    'import/order': ['error', {
      groups: [
        'builtin',
        'external', 
        'internal',
        'parent',
        'sibling',
        'index'
      ],
      'newlines-between': 'always'
    }],
    
    // Security Quality Gates
    'no-new-object': 'error',
    'no-array-constructor': 'error',
    'no-new-wrappers': 'error',
    'no-script-url': 'error',
    
    // Performance Quality Gates  
    'no-loop-func': 'error',
    'no-extend-native': 'error',
    'no-proto': 'error',
    
    // Maintainability Quality Gates
    'no-magic-numbers': ['error', {
      ignore: [-1, 0, 1, 2],
      ignoreArrayIndexes: true,
      enforceConst: true
    }],
    'prefer-template': 'error',
    'template-curly-spacing': 'error',
    'object-shorthand': ['error', 'always'],
    
    // Error Handling Quality
    'no-throw-literal': 'error',
    'prefer-promise-reject-errors': 'error'
  },
  
  // Environment-specific overrides
  overrides: [
    {
      // Test file specific rules
      files: ['**/*.test.{js,ts,jsx,tsx}', '**/*.spec.{js,ts,jsx,tsx}'],
      rules: {
        'no-magic-numbers': 'off', // Allow magic numbers in tests
        'max-lines-per-function': 'off', // Allow longer test functions
        'max-statements': 'off', // Allow more statements in tests
        '@typescript-eslint/explicit-function-return-type': 'off'
      }
    },
    {
      // Integration test specific rules
      files: ['**/*.integration.{js,ts,jsx,tsx}'],
      rules: {
        'jest/require-top-level-describe': 'off', // More flexible for integration tests
        'max-lines-per-function': ['error', { max: 100 }] // Allow longer integration tests
      }
    },
    {
      // BDD feature file specific rules
      files: ['**/*.steps.{js,ts}', '**/*.feature.{js,ts}'],
      rules: {
        'max-lines-per-function': 'off', // BDD steps can be longer
        'no-magic-numbers': 'off', // Allow magic numbers in BDD scenarios
        'jest/expect-expect': 'off' // BDD assertions may be in step definitions
      }
    },
    {
      // Configuration file rules
      files: ['*.config.{js,ts}', '**/*.config.{js,ts}'],
      rules: {
        'no-magic-numbers': 'off',
        'require-jsdoc': 'off',
        '@typescript-eslint/no-var-requires': 'off'
      }
    }
  ],
  
  // Quality Gate Ignore Patterns
  ignorePatterns: [
    'node_modules/',
    'dist/',
    'build/',
    'coverage/',
    '*.min.js',
    'vendor/',
    'generated/'
  ],
  
  // Parser and Plugin Settings
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.js', '.jsx', '.ts', '.tsx']
      }
    },
    jest: {
      version: 'detect'
    }
  },
  
  // Report unused ESLint disable comments
  reportUnusedDisableDirectives: true
};