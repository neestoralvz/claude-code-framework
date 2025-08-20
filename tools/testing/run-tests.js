#!/usr/bin/env node
/**
 * Test Runner Script
 * Demonstrates TDD Red-Green-Refactor cycle with evidence collection
 */

const { execSync } = require('child_process');
const fs = require('fs');

console.log('='.repeat(80));
console.log('TDD DEMONSTRATION: Sum Function Test Suite');
console.log('='.repeat(80));

function runCommand(command, phase) {
  console.log(`\n${phase.toUpperCase()} PHASE:`);
  console.log('-'.repeat(40));
  try {
    const output = execSync(command, { 
      encoding: 'utf8', 
      cwd: '/Users/nalve/.claude',
      stdio: 'pipe'
    });
    console.log(output);
    return { success: true, output };
  } catch (error) {
    console.log(error.stdout || error.message);
    return { success: false, output: error.stdout || error.message };
  }
}

// Check if npm is available, if not, use npx jest directly
console.log('Checking test environment...');

try {
  // Try to install jest if not available
  if (!fs.existsSync('/Users/nalve/.claude/node_modules')) {
    console.log('Installing Jest...');
    runCommand('npm install', 'Setup');
  }
} catch (error) {
  console.log('Using npx for Jest execution');
}

// Run tests to demonstrate current state
const testResult = runCommand('npx jest --no-cache', 'Current Test State');

console.log('\n' + '='.repeat(80));
console.log('TEST EXECUTION COMPLETE');
console.log('='.repeat(80));

if (!testResult.success) {
  console.log('\n✅ RED PHASE CONFIRMED: Tests are failing as expected in TDD');
  console.log('Next step: Implement the sum function to make tests pass (GREEN phase)');
} else {
  console.log('\n✅ Tests are passing');
}