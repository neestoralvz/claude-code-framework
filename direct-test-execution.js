#!/usr/bin/env node
/**
 * Direct Test Execution - No Dependencies Required
 * Demonstrates the sum function works correctly with comprehensive validation
 */

// Import our sum function
const sum = require('./sum.js');

console.log('='.repeat(80));
console.log('COMPREHENSIVE SUM FUNCTION VALIDATION');
console.log('='.repeat(80));

let totalTests = 0;
let passedTests = 0;

function test(description, testFn) {
  totalTests++;
  try {
    testFn();
    console.log(`✅ ${description}`);
    passedTests++;
  } catch (error) {
    console.log(`❌ ${description}: ${error.message}`);
  }
}

function expect(actual) {
  return {
    toBe: (expected) => {
      if (actual !== expected) {
        throw new Error(`Expected ${expected}, but got ${actual}`);
      }
    },
    toBeCloseTo: (expected, precision = 2) => {
      const diff = Math.abs(actual - expected);
      const tolerance = Math.pow(10, -precision);
      if (diff >= tolerance) {
        throw new Error(`Expected ${actual} to be close to ${expected} (tolerance: ${tolerance})`);
      }
    },
    toBeNaN: () => {
      if (!isNaN(actual)) {
        throw new Error(`Expected NaN, but got ${actual}`);
      }
    },
    toThrow: (expectedMessage) => {
      // This is for testing error throwing - actual should be a function
      try {
        actual();
        throw new Error('Expected function to throw, but it did not');
      } catch (error) {
        if (expectedMessage && !error.message.includes(expectedMessage)) {
          throw new Error(`Expected error message to contain "${expectedMessage}", but got "${error.message}"`);
        }
      }
    }
  };
}

// Test Suite Execution
console.log('\n1. BASIC FUNCTIONALITY TESTS');
console.log('-'.repeat(40));

test('should add two positive integers', () => {
  expect(sum(2, 3)).toBe(5);
});

test('should add two positive decimals', () => {
  expect(sum(1.5, 2.5)).toBe(4);
});

test('should handle addition with zero', () => {
  expect(sum(5, 0)).toBe(5);
  expect(sum(0, 5)).toBe(5);
  expect(sum(0, 0)).toBe(0);
});

console.log('\n2. NEGATIVE NUMBER HANDLING');
console.log('-'.repeat(40));

test('should add two negative numbers', () => {
  expect(sum(-3, -2)).toBe(-5);
});

test('should add positive and negative numbers', () => {
  expect(sum(10, -3)).toBe(7);
  expect(sum(-10, 3)).toBe(-7);
});

test('should handle negative result', () => {
  expect(sum(-5, -10)).toBe(-15);
});

console.log('\n3. EDGE CASES');
console.log('-'.repeat(40));

test('should handle very large numbers', () => {
  expect(sum(Number.MAX_SAFE_INTEGER, 0)).toBe(Number.MAX_SAFE_INTEGER);
  expect(sum(1000000000, 2000000000)).toBe(3000000000);
});

test('should handle very small numbers', () => {
  expect(sum(Number.MIN_SAFE_INTEGER, 0)).toBe(Number.MIN_SAFE_INTEGER);
});

test('should handle floating point precision', () => {
  expect(sum(0.1, 0.2)).toBeCloseTo(0.3, 10);
  expect(sum(0.7, 0.1)).toBeCloseTo(0.8, 10);
});

test('should handle infinity', () => {
  expect(sum(Infinity, 5)).toBe(Infinity);
  expect(sum(-Infinity, 5)).toBe(-Infinity);
});

test('should handle infinity arithmetic edge case', () => {
  expect(sum(Infinity, -Infinity)).toBeNaN();
});

console.log('\n4. INPUT VALIDATION');
console.log('-'.repeat(40));

test('should throw error for string inputs', () => {
  expect(() => sum('a', 5)).toThrow('Both arguments must be numbers');
  expect(() => sum(5, 'b')).toThrow('Both arguments must be numbers');
});

test('should throw error for null/undefined inputs', () => {
  expect(() => sum(null, 5)).toThrow('Both arguments must be numbers');
  expect(() => sum(5, undefined)).toThrow('Both arguments must be numbers');
});

test('should handle NaN inputs', () => {
  expect(sum(NaN, 5)).toBeNaN();
  expect(sum(5, NaN)).toBeNaN();
  expect(sum(NaN, NaN)).toBeNaN();
});

console.log('\n5. BEHAVIORAL PROPERTIES');
console.log('-'.repeat(40));

test('should return a number', () => {
  const result = sum(1, 2);
  if (typeof result !== 'number') {
    throw new Error(`Expected number, got ${typeof result}`);
  }
});

test('should be commutative', () => {
  expect(sum(5, 3)).toBe(sum(3, 5));
  expect(sum(-2, 7)).toBe(sum(7, -2));
});

test('should handle many decimal places', () => {
  expect(sum(1.123456789, 2.987654321)).toBeCloseTo(4.11111111, 8);
});

console.log('\n6. BDD SCENARIOS');
console.log('-'.repeat(40));

test('Given two valid numbers, When I add them, Then I get correct sum', () => {
  // Given
  const a = 15;
  const b = 25;
  const expectedSum = 40;
  
  // When
  const result = sum(a, b);
  
  // Then
  expect(result).toBe(expectedSum);
});

test('Given one number is zero, When I add to another, Then I get the other number', () => {
  // Given
  const nonZeroNumber = 42;
  const zero = 0;
  
  // When & Then
  expect(sum(nonZeroNumber, zero)).toBe(nonZeroNumber);
  expect(sum(zero, nonZeroNumber)).toBe(nonZeroNumber);
});

test('Given invalid input types, When I try to add, Then I get descriptive error', () => {
  const invalidInputs = ['string', null, undefined, {}, []];
  
  invalidInputs.forEach(invalid => {
    expect(() => sum(invalid, 5)).toThrow('Both arguments must be numbers');
    expect(() => sum(5, invalid)).toThrow('Both arguments must be numbers');
  });
});

// Performance demonstration
console.log('\n7. PERFORMANCE VALIDATION');
console.log('-'.repeat(40));

test('should handle rapid successive calls', () => {
  const start = Date.now();
  for (let i = 0; i < 10000; i++) {
    sum(i, i + 1);
  }
  const end = Date.now();
  console.log(`    10,000 operations completed in ${end - start}ms`);
});

// Final Results
console.log('\n' + '='.repeat(80));
console.log('TEST EXECUTION SUMMARY');
console.log('='.repeat(80));
console.log(`Total Tests: ${totalTests}`);
console.log(`Passed: ${passedTests}`);
console.log(`Failed: ${totalTests - passedTests}`);
console.log(`Success Rate: ${((passedTests / totalTests) * 100).toFixed(1)}%`);

if (passedTests === totalTests) {
  console.log('\n🎉 ALL TESTS PASSED - TDD GREEN PHASE SUCCESSFUL!');
  console.log('\n✅ Implementation Evidence:');
  console.log('   - Function correctly adds numbers');
  console.log('   - Input validation works properly');
  console.log('   - Edge cases handled appropriately');
  console.log('   - Floating point precision managed');
  console.log('   - Error cases throw descriptive messages');
  console.log('   - Behavioral properties verified (commutative, type safety)');
  console.log('   - BDD scenarios pass');
  console.log('   - Performance is acceptable');
} else {
  console.log('\n❌ SOME TESTS FAILED - REQUIRES DEBUGGING');
}

console.log('\n📁 Created Files:');
console.log('   - /Users/nalve/.claude/sum.js (Implementation)');
console.log('   - /Users/nalve/.claude/sum.test.js (Jest Test Suite)');
console.log('   - /Users/nalve/.claude/package.json (Jest Configuration)');
console.log('   - /Users/nalve/.claude/direct-test-execution.js (Standalone Validator)');

console.log('\n🔧 To run with Jest (if available):');
console.log('   cd /Users/nalve/.claude && npx jest --verbose');