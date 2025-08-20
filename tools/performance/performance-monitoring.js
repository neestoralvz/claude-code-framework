#!/usr/bin/env node
/**
 * Performance Monitoring and Alerting System
 * Created by Performance Optimizer Specialist
 * 
 * Provides continuous performance monitoring, regression detection,
 * and automated performance validation for the sum function.
 */

const sum = require('./sum.js');
const { performance } = require('perf_hooks');
const fs = require('fs');
const path = require('path');

class PerformanceMonitor {
  constructor(options = {}) {
    this.config = {
      performanceThresholds: {
        maxOperationTime: 0.001, // 1μs per operation
        minOpsPerSecond: 1000000, // 1M ops/sec minimum
        maxMemoryPerOperation: 0.0001, // 0.1 bytes per operation
        alertThreshold: 0.2 // 20% performance degradation triggers alert
      },
      samplingInterval: 1000, // Monitor every 1 second
      historyLength: 100, // Keep 100 samples
      ...options
    };
    
    this.performanceHistory = [];
    this.alerts = [];
    this.isMonitoring = false;
    this.baseline = null;
  }

  // Establish performance baseline
  establishBaseline() {
    console.log('\n📊 ESTABLISHING PERFORMANCE BASELINE');
    console.log('='.repeat(50));

    const benchmarks = [
      { name: 'basic', testFn: () => sum(5, 10) },
      { name: 'floating', testFn: () => sum(3.14, 2.71) },
      { name: 'large', testFn: () => sum(1000000, 2000000) },
      { name: 'negative', testFn: () => sum(-100, -200) }
    ];

    const baseline = {};

    benchmarks.forEach(bench => {
      const operations = 100000;
      const startTime = performance.now();
      
      for (let i = 0; i < operations; i++) {
        bench.testFn();
      }
      
      const endTime = performance.now();
      const duration = endTime - startTime;
      const opsPerSecond = operations / (duration / 1000);
      
      baseline[bench.name] = {
        operations,
        duration,
        opsPerSecond,
        avgTimePerOp: duration * 1000 / operations
      };
      
      console.log(`${bench.name}: ${opsPerSecond.toLocaleString()} ops/sec`);
    });

    this.baseline = baseline;
    this.saveBaseline();
    
    console.log('\n✅ Baseline established and saved');
    return baseline;
  }

  // Load baseline from file
  loadBaseline() {
    const baselinePath = path.join(__dirname, 'performance-baseline.json');
    try {
      if (fs.existsSync(baselinePath)) {
        this.baseline = JSON.parse(fs.readFileSync(baselinePath, 'utf8'));
        console.log('📊 Performance baseline loaded');
        return this.baseline;
      }
    } catch (error) {
      console.log('⚠️  Could not load baseline, establishing new one');
    }
    return this.establishBaseline();
  }

  // Save baseline to file
  saveBaseline() {
    const baselinePath = path.join(__dirname, 'performance-baseline.json');
    const data = {
      timestamp: new Date().toISOString(),
      nodeVersion: process.version,
      platform: process.platform,
      baseline: this.baseline
    };
    fs.writeFileSync(baselinePath, JSON.stringify(data, null, 2));
  }

  // Run single performance sample
  performanceSample() {
    const sample = {
      timestamp: new Date().toISOString(),
      measurements: {}
    };

    // Test basic addition performance
    const operations = 50000;
    const startTime = performance.now();
    
    for (let i = 0; i < operations; i++) {
      sum(Math.random() * 1000, Math.random() * 1000);
    }
    
    const endTime = performance.now();
    const duration = endTime - startTime;
    const opsPerSecond = operations / (duration / 1000);

    sample.measurements.basic = {
      operations,
      duration,
      opsPerSecond,
      avgTimePerOp: duration * 1000 / operations
    };

    return sample;
  }

  // Check for performance regressions
  checkPerformanceRegression(currentSample) {
    if (!this.baseline) {
      return { hasRegression: false, alerts: [] };
    }

    const alerts = [];
    const current = currentSample.measurements.basic;
    const baseline = this.baseline.basic;
    
    const performanceDelta = (baseline.opsPerSecond - current.opsPerSecond) / baseline.opsPerSecond;
    
    if (performanceDelta > this.config.performanceThresholds.alertThreshold) {
      const alert = {
        type: 'PERFORMANCE_REGRESSION',
        severity: performanceDelta > 0.5 ? 'CRITICAL' : 'WARNING',
        timestamp: new Date().toISOString(),
        details: {
          baselineOpsPerSec: baseline.opsPerSecond,
          currentOpsPerSec: current.opsPerSecond,
          performanceDelta: (performanceDelta * 100).toFixed(1) + '%',
          threshold: (this.config.performanceThresholds.alertThreshold * 100) + '%'
        }
      };
      alerts.push(alert);
    }

    return {
      hasRegression: alerts.length > 0,
      alerts,
      performanceDelta
    };
  }

  // Start continuous monitoring
  startMonitoring() {
    if (this.isMonitoring) {
      console.log('⚠️  Monitoring already active');
      return;
    }

    console.log('\n🔍 STARTING CONTINUOUS PERFORMANCE MONITORING');
    console.log('='.repeat(50));
    
    if (!this.baseline) {
      this.loadBaseline();
    }

    this.isMonitoring = true;
    
    this.monitoringInterval = setInterval(() => {
      const sample = this.performanceSample();
      const regression = this.checkPerformanceRegression(sample);
      
      // Add to history
      this.performanceHistory.push({
        ...sample,
        regression
      });
      
      // Maintain history length
      if (this.performanceHistory.length > this.config.historyLength) {
        this.performanceHistory.shift();
      }

      // Handle alerts
      if (regression.hasRegression) {
        this.alerts.push(...regression.alerts);
        regression.alerts.forEach(alert => {
          console.log(`🚨 ${alert.severity}: ${alert.type}`);
          console.log(`   Performance degraded by ${alert.details.performanceDelta}`);
          console.log(`   Current: ${alert.details.currentOpsPerSec.toLocaleString()} ops/sec`);
          console.log(`   Baseline: ${alert.details.baselineOpsPerSec.toLocaleString()} ops/sec`);
        });
      }

      // Log current performance
      const current = sample.measurements.basic;
      console.log(`📈 Current Performance: ${current.opsPerSecond.toLocaleString()} ops/sec (${current.avgTimePerOp.toFixed(4)}μs per op)`);
      
    }, this.config.samplingInterval);

    console.log(`✅ Monitoring started (interval: ${this.config.samplingInterval}ms)`);
    console.log('Press Ctrl+C to stop monitoring');
  }

  // Stop monitoring
  stopMonitoring() {
    if (this.monitoringInterval) {
      clearInterval(this.monitoringInterval);
      this.monitoringInterval = null;
    }
    this.isMonitoring = false;
    console.log('\n🛑 Performance monitoring stopped');
  }

  // Generate monitoring report
  generateMonitoringReport() {
    const report = {
      timestamp: new Date().toISOString(),
      baseline: this.baseline,
      monitoringDuration: this.performanceHistory.length * this.config.samplingInterval / 1000,
      samples: this.performanceHistory.length,
      alerts: this.alerts,
      performance: {
        current: this.performanceHistory[this.performanceHistory.length - 1],
        average: this.calculateAveragePerformance(),
        min: this.findMinPerformance(),
        max: this.findMaxPerformance()
      }
    };

    const reportPath = path.join(__dirname, 'performance-monitoring-report.json');
    fs.writeFileSync(reportPath, JSON.stringify(report, null, 2));
    
    console.log('\n📋 MONITORING REPORT');
    console.log('='.repeat(50));
    console.log(`Report saved to: ${reportPath}`);
    console.log(`Monitoring duration: ${report.monitoringDuration.toFixed(1)}s`);
    console.log(`Samples collected: ${report.samples}`);
    console.log(`Alerts triggered: ${report.alerts.length}`);
    
    if (report.performance.average) {
      console.log(`Average performance: ${report.performance.average.opsPerSecond.toLocaleString()} ops/sec`);
    }
    
    return report;
  }

  // Calculate average performance from history
  calculateAveragePerformance() {
    if (this.performanceHistory.length === 0) return null;
    
    const totalOpsPerSec = this.performanceHistory.reduce((sum, sample) => 
      sum + sample.measurements.basic.opsPerSecond, 0);
    
    return {
      opsPerSecond: totalOpsPerSec / this.performanceHistory.length
    };
  }

  // Find minimum performance
  findMinPerformance() {
    if (this.performanceHistory.length === 0) return null;
    
    return this.performanceHistory.reduce((min, sample) => 
      sample.measurements.basic.opsPerSecond < min.measurements.basic.opsPerSecond ? sample : min);
  }

  // Find maximum performance
  findMaxPerformance() {
    if (this.performanceHistory.length === 0) return null;
    
    return this.performanceHistory.reduce((max, sample) => 
      sample.measurements.basic.opsPerSecond > max.measurements.basic.opsPerSecond ? sample : max);
  }

  // Performance dashboard summary
  displayDashboard() {
    console.log('\n📊 PERFORMANCE DASHBOARD');
    console.log('='.repeat(50));
    
    if (this.baseline) {
      console.log('Baseline Performance:');
      Object.entries(this.baseline).forEach(([name, perf]) => {
        console.log(`  ${name}: ${perf.opsPerSecond.toLocaleString()} ops/sec`);
      });
    }

    if (this.performanceHistory.length > 0) {
      const latest = this.performanceHistory[this.performanceHistory.length - 1];
      const avg = this.calculateAveragePerformance();
      
      console.log('\nCurrent Session:');
      console.log(`  Latest: ${latest.measurements.basic.opsPerSecond.toLocaleString()} ops/sec`);
      console.log(`  Average: ${avg.opsPerSecond.toLocaleString()} ops/sec`);
      console.log(`  Samples: ${this.performanceHistory.length}`);
      console.log(`  Alerts: ${this.alerts.length}`);
    }

    console.log(`\nMonitoring Status: ${this.isMonitoring ? '🟢 Active' : '🔴 Inactive'}`);
  }
}

// CLI interface for monitoring
function runMonitoring() {
  const monitor = new PerformanceMonitor();
  
  console.log('🔍 PERFORMANCE MONITORING SYSTEM');
  console.log('='.repeat(50));
  console.log('Performance Optimizer Specialist - Monitoring Tools');
  console.log();

  monitor.loadBaseline();
  monitor.displayDashboard();
  monitor.startMonitoring();

  // Handle graceful shutdown
  process.on('SIGINT', () => {
    console.log('\n\n🛑 Shutting down monitoring...');
    monitor.stopMonitoring();
    monitor.generateMonitoringReport();
    process.exit(0);
  });
}

// Export for programmatic use
module.exports = { PerformanceMonitor };

// Run if called directly
if (require.main === module) {
  runMonitoring();
}