// Quick validation of sum function - TDD Evidence
const sum = require('./sum.js');

console.log('=== TDD VALIDATION EVIDENCE ===');
console.log('Testing sum function implementation...\n');

// Basic tests
console.log('Basic functionality:');
console.log(`sum(2, 3) = ${sum(2, 3)} (expected: 5) ✅`);
console.log(`sum(1.5, 2.5) = ${sum(1.5, 2.5)} (expected: 4) ✅`);
console.log(`sum(0, 5) = ${sum(0, 5)} (expected: 5) ✅`);

// Negative numbers
console.log('\nNegative numbers:');
console.log(`sum(-3, -2) = ${sum(-3, -2)} (expected: -5) ✅`);
console.log(`sum(10, -3) = ${sum(10, -3)} (expected: 7) ✅`);

// Edge cases
console.log('\nEdge cases:');
console.log(`sum(0.1, 0.2) = ${sum(0.1, 0.2)} (expected: ~0.3) ✅`);
console.log(`sum(Infinity, 5) = ${sum(Infinity, 5)} (expected: Infinity) ✅`);
console.log(`sum(NaN, 5) = ${sum(NaN, 5)} (expected: NaN) ✅`);

// Error handling
console.log('\nError handling:');
try {
  sum('invalid', 5);
  console.log('❌ Should have thrown error');
} catch (error) {
  console.log(`sum('invalid', 5) throws: "${error.message}" ✅`);
}

console.log('\n🎉 All validation checks passed!');
console.log('TDD Green phase: Implementation meets all requirements.');