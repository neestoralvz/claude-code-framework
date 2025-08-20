#!/usr/bin/env node
/**
 * Load Testing and Stress Testing Suite
 * Created by Performance Optimizer Specialist
 * 
 * Comprehensive load testing scenarios to validate performance
 * under various load conditions and identify breaking points.
 */

const sum = require('./sum.js');
const { Worker, isMainThread, parentPort, workerData } = require('worker_threads');
const { performance } = require('perf_hooks');
const os = require('os');
const fs = require('fs');
const path = require('path');

class LoadTester {
  constructor(options = {}) {
    this.config = {
      maxConcurrentUsers: 1000,
      testDurationMs: 30000, // 30 seconds
      rampUpTimeMs: 5000,     // 5 seconds
      operationsPerUser: 10000,
      reportInterval: 1000,   // 1 second
      ...options
    };
    
    this.results = {
      totalOperations: 0,
      totalTime: 0,
      errors: [],
      metrics: []
    };
  }

  // Single-threaded load test
  async runSingleThreadedLoadTest() {
    console.log('\n🔥 SINGLE-THREADED LOAD TEST');
    console.log('='.repeat(50));

    const concurrencyLevels = [1, 10, 50, 100, 500, 1000];
    const results = [];

    for (const concurrency of concurrencyLevels) {
      console.log(`\nTesting with ${concurrency} concurrent operations:`);
      
      const startTime = performance.now();
      const promises = [];

      for (let i = 0; i < concurrency; i++) {
        promises.push(this.simulateUserSession(1000)); // 1000 ops per "user"
      }

      const sessionResults = await Promise.all(promises);
      const endTime = performance.now();
      
      const totalTime = endTime - startTime;
      const totalOps = sessionResults.reduce((sum, result) => sum + result.operations, 0);
      const throughput = totalOps / (totalTime / 1000);
      
      const result = {
        concurrency,
        totalOperations: totalOps,
        totalTime,
        throughput,
        avgResponseTime: totalTime / totalOps,
        errors: sessionResults.reduce((sum, result) => sum + result.errors, 0)
      };

      results.push(result);

      console.log(`  Operations: ${totalOps.toLocaleString()}`);
      console.log(`  Duration: ${totalTime.toFixed(2)}ms`);
      console.log(`  Throughput: ${throughput.toLocaleString()} ops/sec`);
      console.log(`  Avg response time: ${(totalTime / totalOps * 1000).toFixed(4)}μs`);
      console.log(`  Errors: ${result.errors}`);
    }

    return results;
  }

  // Multi-threaded worker-based load test
  async runMultiThreadedLoadTest() {
    console.log('\n⚡ MULTI-THREADED LOAD TEST');
    console.log('='.repeat(50));

    const cpuCount = os.cpus().length;
    console.log(`Available CPU cores: ${cpuCount}`);

    const workerCounts = [1, 2, 4, Math.min(8, cpuCount), cpuCount];
    const results = [];

    for (const workerCount of workerCounts) {
      console.log(`\nTesting with ${workerCount} worker threads:`);
      
      const result = await this.runWorkerTest(workerCount);
      results.push(result);

      console.log(`  Total operations: ${result.totalOperations.toLocaleString()}`);
      console.log(`  Duration: ${result.duration.toFixed(2)}ms`);
      console.log(`  Throughput: ${result.throughput.toLocaleString()} ops/sec`);
      console.log(`  Operations per worker: ${(result.totalOperations / workerCount).toLocaleString()}`);
    }

    return results;
  }

  // Run test with worker threads
  async runWorkerTest(workerCount) {
    const operationsPerWorker = 100000;
    
    const startTime = performance.now();
    const workers = [];
    const promises = [];

    for (let i = 0; i < workerCount; i++) {
      const worker = new Worker(__filename, {
        workerData: { operationsPerWorker, workerId: i }
      });

      workers.push(worker);
      
      promises.push(new Promise((resolve, reject) => {
        worker.on('message', resolve);
        worker.on('error', reject);
      }));
    }

    const workerResults = await Promise.all(promises);
    const endTime = performance.now();

    // Cleanup workers
    workers.forEach(worker => worker.terminate());

    const totalOperations = workerResults.reduce((sum, result) => sum + result.operations, 0);
    const duration = endTime - startTime;
    const throughput = totalOperations / (duration / 1000);

    return {
      workerCount,
      totalOperations,
      duration,
      throughput,
      workerResults
    };
  }

  // Simulate user session
  async simulateUserSession(operations) {
    const startTime = performance.now();
    let errors = 0;

    for (let i = 0; i < operations; i++) {
      try {
        // Simulate realistic usage patterns
        const testCase = i % 5;
        switch (testCase) {
          case 0: sum(Math.random() * 1000, Math.random() * 1000); break;
          case 1: sum(-Math.random() * 1000, Math.random() * 1000); break;
          case 2: sum(0, Math.random() * 1000); break;
          case 3: sum(Math.random() * 1000000, Math.random() * 1000000); break;
          case 4: sum(Math.random() * 0.001, Math.random() * 0.001); break;
        }
      } catch (error) {
        errors++;
      }
    }

    const endTime = performance.now();
    
    return {
      operations,
      duration: endTime - startTime,
      errors
    };
  }

  // Stress test to find breaking point
  async runStressTest() {
    console.log('\n💥 STRESS TEST - Finding Breaking Point');
    console.log('='.repeat(50));

    let currentLoad = 100;
    let maxSuccessfulLoad = 0;
    const maxAttempts = 10;
    let attempts = 0;

    while (attempts < maxAttempts) {
      console.log(`\nTesting load level: ${currentLoad.toLocaleString()} operations`);
      
      try {
        const startTime = performance.now();
        
        // Attempt high-load test
        const promises = [];
        const concurrency = Math.min(100, Math.ceil(currentLoad / 1000));
        const opsPerSession = Math.ceil(currentLoad / concurrency);

        for (let i = 0; i < concurrency; i++) {
          promises.push(this.simulateUserSession(opsPerSession));
        }

        const results = await Promise.all(promises);
        const endTime = performance.now();
        
        const totalOps = results.reduce((sum, result) => sum + result.operations, 0);
        const duration = endTime - startTime;
        const throughput = totalOps / (duration / 1000);

        console.log(`  ✅ Success: ${throughput.toLocaleString()} ops/sec`);
        maxSuccessfulLoad = currentLoad;
        currentLoad *= 2; // Double the load

      } catch (error) {
        console.log(`  ❌ Failed at ${currentLoad.toLocaleString()} operations: ${error.message}`);
        break;
      }

      attempts++;
    }

    console.log(`\n🏆 Maximum successful load: ${maxSuccessfulLoad.toLocaleString()} operations`);
    return maxSuccessfulLoad;
  }

  // Memory pressure test
  async runMemoryPressureTest() {
    console.log('\n🧠 MEMORY PRESSURE TEST');
    console.log('='.repeat(50));

    const initialMemory = process.memoryUsage();
    console.log('Initial memory usage:');
    console.log(`  RSS: ${this.formatBytes(initialMemory.rss)}`);
    console.log(`  Heap Used: ${this.formatBytes(initialMemory.heapUsed)}`);

    // Create memory pressure by storing results
    const results = [];
    const batchSize = 100000;
    const maxBatches = 50;

    for (let batch = 0; batch < maxBatches; batch++) {
      const batchResults = [];
      
      for (let i = 0; i < batchSize; i++) {
        const a = Math.random() * 1000;
        const b = Math.random() * 1000;
        const result = sum(a, b);
        batchResults.push({ a, b, result });
      }
      
      results.push(batchResults);
      
      const currentMemory = process.memoryUsage();
      const memoryDelta = currentMemory.heapUsed - initialMemory.heapUsed;
      
      console.log(`Batch ${batch + 1}/${maxBatches}:`);
      console.log(`  Operations: ${((batch + 1) * batchSize).toLocaleString()}`);
      console.log(`  Memory delta: ${this.formatBytes(memoryDelta)}`);
      console.log(`  Memory per operation: ${(memoryDelta / ((batch + 1) * batchSize)).toFixed(6)} bytes`);

      // Stop if memory usage becomes excessive
      if (memoryDelta > 100 * 1024 * 1024) { // 100MB threshold
        console.log('  🛑 Memory limit reached, stopping test');
        break;
      }
    }

    return results.length * batchSize;
  }

  // Generate load test report
  generateLoadTestReport(singleThreadResults, multiThreadResults, stressTestResult) {
    const report = {
      timestamp: new Date().toISOString(),
      nodeVersion: process.version,
      platform: process.platform,
      arch: process.arch,
      cpuCount: os.cpus().length,
      testResults: {
        singleThreaded: singleThreadResults,
        multiThreaded: multiThreadResults,
        maxLoad: stressTestResult
      },
      recommendations: this.generateLoadTestRecommendations(singleThreadResults, multiThreadResults)
    };

    const reportPath = path.join(__dirname, 'load-test-report.json');
    fs.writeFileSync(reportPath, JSON.stringify(report, null, 2));
    
    console.log('\n📋 LOAD TEST REPORT');
    console.log('='.repeat(50));
    console.log(`Report saved to: ${reportPath}`);
    
    return report;
  }

  // Generate load testing recommendations
  generateLoadTestRecommendations(singleResults, multiResults) {
    const recommendations = [];
    
    // Analyze single-threaded results
    const bestSingle = singleResults.reduce((best, current) => 
      current.throughput > best.throughput ? current : best);
    
    recommendations.push({
      category: 'Single-threaded Performance',
      finding: `Peak throughput: ${bestSingle.throughput.toLocaleString()} ops/sec at ${bestSingle.concurrency} concurrent operations`,
      recommendation: bestSingle.concurrency < 1000 ? 
        'Consider increasing concurrency for better throughput' :
        'Current concurrency level is optimal'
    });

    // Analyze multi-threaded results
    if (multiResults && multiResults.length > 0) {
      const bestMulti = multiResults.reduce((best, current) => 
        current.throughput > best.throughput ? current : best);
      
      recommendations.push({
        category: 'Multi-threaded Performance',
        finding: `Peak throughput: ${bestMulti.throughput.toLocaleString()} ops/sec with ${bestMulti.workerCount} workers`,
        recommendation: bestMulti.workerCount === os.cpus().length ?
          'Optimal worker count matches CPU cores' :
          `Consider adjusting worker count (optimal appears to be ${bestMulti.workerCount})`
      });
    }

    return recommendations;
  }

  // Format bytes utility
  formatBytes(bytes) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  }
}

// Worker thread code
if (!isMainThread) {
  const { operationsPerWorker, workerId } = workerData;
  
  // Perform operations in worker thread
  const startTime = performance.now();
  let operations = 0;
  
  for (let i = 0; i < operationsPerWorker; i++) {
    sum(Math.random() * 1000, Math.random() * 1000);
    operations++;
  }
  
  const endTime = performance.now();
  
  parentPort.postMessage({
    workerId,
    operations,
    duration: endTime - startTime
  });
}

// Main execution function
async function runLoadTesting() {
  console.log('🚀 COMPREHENSIVE LOAD TESTING SUITE');
  console.log('='.repeat(70));
  console.log('Performance Optimizer Specialist - Load Testing Analysis');
  console.log('='.repeat(70));

  const loadTester = new LoadTester();
  
  try {
    // Run all load tests
    const singleThreadResults = await loadTester.runSingleThreadedLoadTest();
    const multiThreadResults = await loadTester.runMultiThreadedLoadTest();
    const stressTestResult = await loadTester.runStressTest();
    await loadTester.runMemoryPressureTest();
    
    // Generate comprehensive report
    const report = loadTester.generateLoadTestReport(
      singleThreadResults, 
      multiThreadResults, 
      stressTestResult
    );
    
    console.log('\n✅ LOAD TESTING COMPLETE');
    console.log('='.repeat(50));
    console.log('Key Findings:');
    console.log(`  Peak single-thread throughput: ${Math.max(...singleThreadResults.map(r => r.throughput)).toLocaleString()} ops/sec`);
    if (multiThreadResults.length > 0) {
      console.log(`  Peak multi-thread throughput: ${Math.max(...multiThreadResults.map(r => r.throughput)).toLocaleString()} ops/sec`);
    }
    console.log(`  Maximum load handled: ${stressTestResult.toLocaleString()} operations`);
    
  } catch (error) {
    console.error('Load testing error:', error);
  }
}

// Export for programmatic use
module.exports = { LoadTester };

// Run if called directly
if (require.main === module) {
  runLoadTesting().catch(console.error);
}