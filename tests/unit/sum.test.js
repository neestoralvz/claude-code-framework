/**
 * Comprehensive Test Suite for Sum Function
 * Demonstrates TDD/BDD best practices with complete edge case coverage
 * 
 * Test Strategy:
 * - Red: Write failing tests first
 * - Green: Implement minimal code to pass
 * - Refactor: Improve implementation while maintaining tests
 */

describe('sum function', () => {
  // Import the sum function (will fail initially - TDD Red phase)
  const sum = require('./sum.js');

  describe('basic functionality', () => {
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
  });

  describe('negative number handling', () => {
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
  });

  describe('edge cases', () => {
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
      expect(sum(Infinity, -Infinity)).toBeNaN();
    });
  });

  describe('input validation', () => {
    test('should throw error for non-numeric inputs', () => {
      expect(() => sum('a', 5)).toThrow('Both arguments must be numbers');
      expect(() => sum(5, 'b')).toThrow('Both arguments must be numbers');
      expect(() => sum(null, 5)).toThrow('Both arguments must be numbers');
      expect(() => sum(5, undefined)).toThrow('Both arguments must be numbers');
    });

    test('should handle NaN inputs', () => {
      expect(sum(NaN, 5)).toBeNaN();
      expect(sum(5, NaN)).toBeNaN();
      expect(sum(NaN, NaN)).toBeNaN();
    });
  });

  describe('performance and behavior', () => {
    test('should return a number', () => {
      expect(typeof sum(1, 2)).toBe('number');
    });

    test('should be commutative', () => {
      expect(sum(5, 3)).toBe(sum(3, 5));
      expect(sum(-2, 7)).toBe(sum(7, -2));
    });

    test('should handle many decimal places', () => {
      const result = sum(1.123456789, 2.987654321);
      expect(result).toBeCloseTo(4.11111111, 8);
    });
  });

  describe('BDD scenarios', () => {
    describe('Given two valid numbers', () => {
      test('When I add them together, Then I get the correct sum', () => {
        // Given
        const a = 15;
        const b = 25;
        const expectedSum = 40;

        // When
        const result = sum(a, b);

        // Then
        expect(result).toBe(expectedSum);
      });
    });

    describe('Given one number is zero', () => {
      test('When I add it to another number, Then I get the other number', () => {
        // Given
        const nonZeroNumber = 42;
        const zero = 0;

        // When
        const result1 = sum(nonZeroNumber, zero);
        const result2 = sum(zero, nonZeroNumber);

        // Then
        expect(result1).toBe(nonZeroNumber);
        expect(result2).toBe(nonZeroNumber);
      });
    });

    describe('Given invalid input types', () => {
      test('When I try to add them, Then I get a descriptive error', () => {
        // Given
        const invalidInputs = ['string', null, undefined, {}, []];

        invalidInputs.forEach(invalid => {
          // When & Then
          expect(() => sum(invalid, 5)).toThrow('Both arguments must be numbers');
          expect(() => sum(5, invalid)).toThrow('Both arguments must be numbers');
        });
      });
    });
  });
});