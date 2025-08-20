#!/usr/bin/env node
/**
 * Execute Performance Test and Generate Actual Metrics
 */

const sum = require('./sum.js');
const { performance } = require('perf_hooks');
const fs = require('fs');

console.log('🔍 EXECUTING COMPREHENSIVE PERFORMANCE ANALYSIS');
console.log('='.repeat(70));

// Establish actual performance baseline
function measureActualPerformance() {
  console.log('📊 Measuring Actual Performance...\n');
  
  const operations = 1000000;
  const startTime = performance.now();
  
  for (let i = 0; i < operations; i++) {
    sum(Math.random() * 1000, Math.random() * 1000);
  }
  
  const endTime = performance.now();
  const duration = endTime - startTime;
  const opsPerSecond = operations / (duration / 1000);
  
  console.log(`Operations: ${operations.toLocaleString()}`);
  console.log(`Duration: ${duration.toFixed(2)}ms`);
  console.log(`Operations per second: ${opsPerSecond.toLocaleString()}`);
  console.log(`Average time per operation: ${(duration * 1000 / operations).toFixed(4)}μs`);
  
  return {
    operations,
    duration,
    opsPerSecond,
    avgTimePerOp: duration * 1000 / operations
  };
}

// Memory analysis
function measureMemoryUsage() {
  console.log('\n🧠 Measuring Memory Usage...\n');
  
  const beforeMemory = process.memoryUsage();
  const results = [];
  
  for (let i = 0; i < 100000; i++) {
    results.push(sum(Math.random() * 1000, Math.random() * 1000));
  }
  
  const afterMemory = process.memoryUsage();
  
  const memoryDelta = {
    rss: afterMemory.rss - beforeMemory.rss,
    heapUsed: afterMemory.heapUsed - beforeMemory.heapUsed,
    heapTotal: afterMemory.heapTotal - beforeMemory.heapTotal
  };
  
  console.log(`Operations: 100,000`);
  console.log(`RSS Delta: ${formatBytes(memoryDelta.rss)}`);
  console.log(`Heap Used Delta: ${formatBytes(memoryDelta.heapUsed)}`);
  console.log(`Memory per operation: ${(memoryDelta.heapUsed / 100000).toFixed(8)} bytes`);
  
  return {
    before: beforeMemory,
    after: afterMemory,
    delta: memoryDelta,
    operationsCount: 100000,
    memoryPerOperation: memoryDelta.heapUsed / 100000
  };
}

// Test different scenarios
function benchmarkScenarios() {
  console.log('\n⚡ Benchmarking Different Scenarios...\n');
  
  const scenarios = [
    { name: 'Basic Addition', testFn: () => sum(5, 10), operations: 1000000 },
    { name: 'Floating Point', testFn: () => sum(3.14159, 2.71828), operations: 1000000 },
    { name: 'Large Numbers', testFn: () => sum(1000000, 2000000), operations: 1000000 },
    { name: 'Negative Numbers', testFn: () => sum(-1000, -2000), operations: 1000000 },
    { name: 'Zero Operations', testFn: () => sum(0, 0), operations: 1000000 }
  ];
  
  const results = {};
  
  scenarios.forEach(scenario => {
    const startTime = performance.now();
    
    for (let i = 0; i < scenario.operations; i++) {
      scenario.testFn();
    }
    
    const endTime = performance.now();
    const duration = endTime - startTime;
    const opsPerSecond = scenario.operations / (duration / 1000);
    
    results[scenario.name] = {
      operations: scenario.operations,
      duration,
      opsPerSecond,
      avgTimePerOp: duration * 1000 / scenario.operations
    };
    
    console.log(`${scenario.name}:`);
    console.log(`  Operations/sec: ${opsPerSecond.toLocaleString()}`);
    console.log(`  Duration: ${duration.toFixed(2)}ms`);
    console.log(`  Avg time/op: ${(duration * 1000 / scenario.operations).toFixed(4)}μs`);
    console.log();
  });
  
  return results;
}

// Compare testing approaches
function compareTestingApproaches() {
  console.log('🧪 Comparing Testing Approaches...\n');
  
  const operations = 10000;
  
  // Direct execution
  const directStart = performance.now();
  for (let i = 0; i < operations; i++) {
    sum(i, i + 1);
  }
  const directEnd = performance.now();
  const directTime = directEnd - directStart;
  
  // Simulated Jest overhead
  const jestStart = performance.now();
  for (let i = 0; i < operations; i++) {
    const result = sum(i, i + 1);
    const expected = i + (i + 1);
    if (result !== expected) throw new Error('Test failed');
  }
  const jestEnd = performance.now();
  const jestTime = jestEnd - jestStart;
  
  const overhead = ((jestTime - directTime) / directTime * 100).toFixed(1);
  
  console.log(`Direct execution: ${directTime.toFixed(2)}ms`);
  console.log(`Jest simulation: ${jestTime.toFixed(2)}ms`);
  console.log(`Testing overhead: ${overhead}%`);
  
  return {
    directExecution: directTime,
    jestSimulation: jestTime,
    overhead: overhead + '%'
  };
}

// Utility function
function formatBytes(bytes) {
  if (bytes === 0) return '0 Bytes';
  const k = 1024;
  const sizes = ['Bytes', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

// Execute all tests and generate report
function executePerformanceAnalysis() {
  const startTime = new Date();
  
  const baseline = measureActualPerformance();
  const memory = measureMemoryUsage();
  const scenarios = benchmarkScenarios();
  const testingComparison = compareTestingApproaches();
  
  const report = {
    timestamp: new Date().toISOString(),
    testDuration: ((new Date() - startTime) / 1000).toFixed(2) + 's',
    nodeVersion: process.version,
    platform: process.platform,
    arch: process.arch,
    
    performanceBaseline: baseline,
    memoryAnalysis: memory,
    scenarioBenchmarks: scenarios,
    testingApproaches: testingComparison,
    
    summary: {
      peakPerformance: Math.max(...Object.values(scenarios).map(s => s.opsPerSecond)),
      averagePerformance: Object.values(scenarios).reduce((sum, s) => sum + s.opsPerSecond, 0) / Object.keys(scenarios).length,
      memoryEfficiency: memory.memoryPerOperation,
      testingOverhead: testingComparison.overhead,
      performanceRating: baseline.opsPerSecond > 1000000 ? 'Excellent' : baseline.opsPerSecond > 500000 ? 'Good' : 'Needs Optimization'
    }
  };
  
  // Save report
  const reportPath = '/Users/nalve/.claude/actual-performance-results.json';
  fs.writeFileSync(reportPath, JSON.stringify(report, null, 2));
  
  console.log('\n✅ PERFORMANCE ANALYSIS COMPLETE');
  console.log('='.repeat(50));
  console.log('ACTUAL PERFORMANCE METRICS:');
  console.log(`  Peak Performance: ${report.summary.peakPerformance.toLocaleString()} ops/sec`);
  console.log(`  Average Performance: ${report.summary.averagePerformance.toLocaleString()} ops/sec`);
  console.log(`  Memory per Operation: ${(report.summary.memoryEfficiency * 1000000).toFixed(2)} bytes per million ops`);
  console.log(`  Testing Overhead: ${report.summary.testingOverhead}`);
  console.log(`  Performance Rating: ${report.summary.performanceRating}`);
  console.log(`  Test Duration: ${report.testDuration}`);
  console.log(`\n📋 Detailed results saved to: ${reportPath}`);
  
  return report;
}

// Execute analysis
if (require.main === module) {
  try {
    executePerformanceAnalysis();
  } catch (error) {
    console.error('Error during performance analysis:', error);
    process.exit(1);
  }
}

module.exports = { executePerformanceAnalysis };