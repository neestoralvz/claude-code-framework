/**
 * Sum Function Implementation
 * Developed using Test-Driven Development (TDD) methodology
 * 
 * This function adds two numbers together with comprehensive input validation
 * and edge case handling as defined by the test suite.
 */

/**
 * Adds two numbers together
 * @param {number} a - First number to add
 * @param {number} b - Second number to add
 * @returns {number} The sum of a and b
 * @throws {Error} When either argument is not a number (excluding NaN)
 */
function sum(a, b) {
  // Input validation - check if arguments are numbers
  // Note: typeof NaN === 'number', so we handle NaN separately
  if (typeof a !== 'number' || typeof b !== 'number') {
    throw new Error('Both arguments must be numbers');
  }

  // Handle NaN cases - if either input is NaN, return NaN
  if (isNaN(a) || isNaN(b)) {
    return NaN;
  }

  // Perform the addition
  return a + b;
}

module.exports = sum;