#!/usr/bin/env node

/**
 * Universal Mandate Monitor System Validation
 * 
 * Comprehensive validation script to test all monitoring system components
 * Verifies mandate tracking, compliance scoring, violation detection, and API functionality
 * 
 * Author: Universal Mandate Monitor Specialist
 * Version: 1.0.0
 * Created: 2025-08-20
 */

const fs = require('fs');
const path = require('path');
const { performance } = require('perf_hooks');
const { UniversalMandateMonitor } = require('./mandate-monitor-dashboard.js');

class MonitoringSystemValidator {
    constructor() {
        this.startTime = performance.now();
        this.testResults = [];
        this.monitor = null;
        this.validationErrors = [];
        this.validationWarnings = [];
        
        console.log('🧪 Universal Mandate Monitor System Validation');
        console.log('═══════════════════════════════════════════════════════════════════════════════════════');
        console.log('');
    }
    
    async runCompleteValidation() {
        console.log('📋 Starting comprehensive system validation...\n');
        
        try {
            // Core system validation
            await this.validateSystemFiles();
            await this.validateMandateDefinitions();
            await this.validateMonitoringEngine();
            
            // Functional validation
            await this.validateMandateActivation();
            await this.validateViolationDetection();
            await this.validateComplianceScoring();
            
            // Performance validation
            await this.validatePerformanceMetrics();
            await this.validateMemoryUsage();
            
            // Integration validation
            await this.validateAPIEndpoints();
            await this.validateDataExport();
            
            // Generate final report
            this.generateValidationReport();
            
        } catch (error) {
            this.logError('CRITICAL', 'System validation failed', error.message);
            throw error;
        }
    }
    
    async validateSystemFiles() {
        console.log('📁 Validating system files...');
        
        const requiredFiles = [
            'mandate-monitor-dashboard.js',
            'mandate-monitor-web.html', 
            'server.js',
            'mandate-definitions.json',
            'package.json',
            'README.md'
        ];
        
        for (const file of requiredFiles) {
            const filePath = path.join(__dirname, file);
            
            if (!fs.existsSync(filePath)) {
                this.logError('CRITICAL', 'Missing required file', `File not found: ${file}`);
                continue;
            }
            
            const stats = fs.statSync(filePath);
            if (stats.size === 0) {
                this.logError('HIGH', 'Empty file detected', `File is empty: ${file}`);
                continue;
            }
            
            this.logSuccess(`✅ File validated: ${file} (${(stats.size / 1024).toFixed(2)} KB)`);
        }
        
        console.log('');
    }
    
    async validateMandateDefinitions() {
        console.log('📊 Validating mandate definitions...');
        
        try {
            const definitionsPath = path.join(__dirname, 'mandate-definitions.json');
            const definitionsData = JSON.parse(fs.readFileSync(definitionsPath, 'utf8'));
            
            // Validate structure
            const requiredFields = ['version', 'mandates', 'complianceThresholds', 'alertRules'];
            for (const field of requiredFields) {
                if (!definitionsData[field]) {
                    this.logError('HIGH', 'Missing definition field', `Required field missing: ${field}`);
                }
            }
            
            // Validate mandate clusters
            const expectedClusters = ['core-methodology', 'research-preparation', 'workflow-automation', 'intelligence-amplification'];
            let totalMandates = 0;
            
            for (const cluster of expectedClusters) {
                if (!definitionsData.mandates[cluster]) {
                    this.logError('CRITICAL', 'Missing mandate cluster', `Cluster not found: ${cluster}`);
                    continue;
                }
                
                const clusterData = definitionsData.mandates[cluster];
                const mandateCount = Object.keys(clusterData.mandates || {}).length;
                totalMandates += mandateCount;
                
                this.logSuccess(`✅ Cluster validated: ${cluster} (${mandateCount} mandates)`);
                
                // Validate individual mandates in cluster
                for (const [mandateKey, mandate] of Object.entries(clusterData.mandates || {})) {
                    if (!mandate.id || !mandate.name || !mandate.trackingPoints) {
                        this.logError('HIGH', 'Invalid mandate structure', `Mandate missing required fields: ${mandateKey}`);
                    }
                    
                    if (!Array.isArray(mandate.trackingPoints) || mandate.trackingPoints.length === 0) {
                        this.logError('HIGH', 'Invalid tracking points', `Mandate has no tracking points: ${mandateKey}`);
                    }
                }
            }
            
            if (totalMandates !== 16) {
                this.logError('CRITICAL', 'Incorrect mandate count', `Expected 16 mandates, found ${totalMandates}`);
            } else {
                this.logSuccess(`✅ All 16 Universal Execution Mandates validated`);
            }
            
        } catch (error) {
            this.logError('CRITICAL', 'Definition validation failed', error.message);
        }
        
        console.log('');
    }
    
    async validateMonitoringEngine() {
        console.log('🔧 Validating monitoring engine...');
        
        try {
            this.monitor = new UniversalMandateMonitor();
            
            // Validate initialization
            if (!this.monitor.mandateDefinitions || !this.monitor.mandateStatus) {
                this.logError('CRITICAL', 'Monitor initialization failed', 'Core data structures not initialized');
                return;
            }
            
            const mandateCount = Object.keys(this.monitor.mandateDefinitions).length;
            if (mandateCount !== 16) {
                this.logError('HIGH', 'Incorrect mandate count in monitor', `Expected 16, got ${mandateCount}`);
            }
            
            // Validate mandate status tracking
            const statusCount = Object.keys(this.monitor.mandateStatus).length;
            if (statusCount !== mandateCount) {
                this.logError('HIGH', 'Status tracking mismatch', `Definitions: ${mandateCount}, Status: ${statusCount}`);
            }
            
            // Validate tracking points
            let totalTrackingPoints = 0;
            for (const [key, mandate] of Object.entries(this.monitor.mandateStatus)) {
                const trackingPoints = Object.keys(mandate.trackingData).length;
                totalTrackingPoints += trackingPoints;
                
                if (trackingPoints === 0) {
                    this.logError('HIGH', 'No tracking points', `Mandate has no tracking points: ${key}`);
                }
            }
            
            this.logSuccess(`✅ Monitor initialized with ${mandateCount} mandates and ${totalTrackingPoints} tracking points`);
            
            // Validate compliance metrics initialization
            this.monitor.updateComplianceMetrics();
            if (!this.monitor.complianceMetrics.overall) {
                this.logError('HIGH', 'Compliance metrics not initialized', 'Overall compliance metrics missing');
            }
            
            this.logSuccess(`✅ Compliance metrics system operational`);
            
        } catch (error) {
            this.logError('CRITICAL', 'Monitoring engine validation failed', error.message);
        }
        
        console.log('');
    }
    
    async validateMandateActivation() {
        console.log('🎯 Validating mandate activation...');
        
        const testCases = [
            { key: 'progressive-think', trackingPoint: 'think-level-1', metadata: { level: 1 } },
            { key: 'agent-deployment', trackingPoint: 'agent-deployed', metadata: { agent: 'test-agent' } },
            { key: 'todowrite-tracking', trackingPoint: 'task-atomized', metadata: { tasks: 3 } },
            { key: 'evidence-validation', trackingPoint: 'proof-provided', metadata: { type: 'test' } }
        ];
        
        for (const testCase of testCases) {
            try {
                const success = this.monitor.activateMandate(testCase.key, testCase.trackingPoint, testCase.metadata);
                
                if (!success) {
                    this.logError('HIGH', 'Mandate activation failed', `Failed to activate: ${testCase.key}`);
                    continue;
                }
                
                // Verify activation
                const mandate = this.monitor.mandateStatus[testCase.key];
                if (!mandate.isActive) {
                    this.logError('HIGH', 'Mandate not marked active', `Mandate not active after activation: ${testCase.key}`);
                    continue;
                }
                
                if (!mandate.trackingData[testCase.trackingPoint].triggered) {
                    this.logError('HIGH', 'Tracking point not triggered', `Tracking point not updated: ${testCase.trackingPoint}`);
                    continue;
                }
                
                this.logSuccess(`✅ Mandate activation successful: ${testCase.key} → ${testCase.trackingPoint}`);
                
            } catch (error) {
                this.logError('HIGH', 'Mandate activation error', `${testCase.key}: ${error.message}`);
            }
        }
        
        console.log('');
    }
    
    async validateViolationDetection() {
        console.log('🚨 Validating violation detection...');
        
        const testViolations = [
            { key: 'agent-deployment', type: 'DIRECT_WORK', description: 'Test direct work violation', severity: 'CRITICAL' },
            { key: 'context7-research', type: 'BYPASSED_RESEARCH', description: 'Test research bypass violation', severity: 'HIGH' },
            { key: 'todowrite-tracking', type: 'SKIPPED_BREAKDOWN', description: 'Test breakdown skip violation', severity: 'MEDIUM' }
        ];
        
        for (const violation of testViolations) {
            try {
                const initialCount = this.monitor.mandateStatus[violation.key].violations.length;
                
                this.monitor.recordViolation(violation.key, violation.type, violation.description, violation.severity);
                
                const finalCount = this.monitor.mandateStatus[violation.key].violations.length;
                
                if (finalCount !== initialCount + 1) {
                    this.logError('HIGH', 'Violation not recorded', `Violation count unchanged for: ${violation.key}`);
                    continue;
                }
                
                const recordedViolation = this.monitor.mandateStatus[violation.key].violations[finalCount - 1];
                if (recordedViolation.type !== violation.type) {
                    this.logError('HIGH', 'Violation data incorrect', `Wrong violation type recorded: ${recordedViolation.type}`);
                    continue;
                }
                
                this.logSuccess(`✅ Violation recorded: ${violation.key} → ${violation.type} (${violation.severity})`);
                
            } catch (error) {
                this.logError('HIGH', 'Violation recording error', `${violation.key}: ${error.message}`);
            }
        }
        
        console.log('');
    }
    
    async validateComplianceScoring() {
        console.log('📈 Validating compliance scoring...');
        
        try {
            // Test compliance calculation
            this.monitor.updateComplianceMetrics();
            
            const overallCompliance = this.monitor.complianceMetrics.overall?.averageCompliance;
            if (typeof overallCompliance !== 'number' || isNaN(overallCompliance)) {
                this.logError('HIGH', 'Invalid compliance score', `Overall compliance is not a valid number: ${overallCompliance}`);
            } else if (overallCompliance < 0 || overallCompliance > 100) {
                this.logError('HIGH', 'Compliance score out of range', `Compliance must be 0-100%: ${overallCompliance}`);
            } else {
                this.logSuccess(`✅ Overall compliance calculated: ${overallCompliance.toFixed(2)}%`);
            }
            
            // Test cluster compliance
            const clusters = this.monitor.complianceMetrics.clusters;
            if (!clusters) {
                this.logError('HIGH', 'Cluster compliance missing', 'No cluster compliance metrics found');
            } else {
                for (const [clusterName, metrics] of Object.entries(clusters)) {
                    if (typeof metrics.averageCompliance !== 'number') {
                        this.logError('MEDIUM', 'Invalid cluster compliance', `Cluster ${clusterName} has invalid compliance`);
                    } else {
                        this.logSuccess(`✅ Cluster compliance: ${clusterName} = ${metrics.averageCompliance.toFixed(2)}%`);
                    }
                }
            }
            
            // Test compliance history tracking
            const activationCount = this.monitor.patternActivationHistory.length;
            if (activationCount === 0) {
                this.logWarning('No activation history', 'Pattern activation history is empty');
            } else {
                this.logSuccess(`✅ Activation history tracked: ${activationCount} entries`);
            }
            
        } catch (error) {
            this.logError('HIGH', 'Compliance scoring validation failed', error.message);
        }
        
        console.log('');
    }
    
    async validatePerformanceMetrics() {
        console.log('⚡ Validating performance metrics...');
        
        try {
            const startTime = performance.now();
            
            // Test activation performance
            const activationStart = performance.now();
            this.monitor.activateMandate('progressive-think', 'think-level-2', { performance: 'test' });
            const activationTime = performance.now() - activationStart;
            
            if (activationTime > 10) { // 10ms threshold
                this.logWarning('Slow mandate activation', `Activation took ${activationTime.toFixed(2)}ms`);
            } else {
                this.logSuccess(`✅ Mandate activation performance: ${activationTime.toFixed(2)}ms`);
            }
            
            // Test compliance calculation performance  
            const complianceStart = performance.now();
            this.monitor.updateComplianceMetrics();
            const complianceTime = performance.now() - complianceStart;
            
            if (complianceTime > 5) { // 5ms threshold
                this.logWarning('Slow compliance calculation', `Calculation took ${complianceTime.toFixed(2)}ms`);
            } else {
                this.logSuccess(`✅ Compliance calculation performance: ${complianceTime.toFixed(2)}ms`);
            }
            
            // Test report generation performance
            const reportStart = performance.now();
            const report = this.monitor.generateComplianceReport();
            const reportTime = performance.now() - reportStart;
            
            if (!report || typeof report !== 'object') {
                this.logError('HIGH', 'Report generation failed', 'No report generated');
            } else if (reportTime > 50) { // 50ms threshold
                this.logWarning('Slow report generation', `Report generation took ${reportTime.toFixed(2)}ms`);
            } else {
                this.logSuccess(`✅ Report generation performance: ${reportTime.toFixed(2)}ms`);
            }
            
        } catch (error) {
            this.logError('HIGH', 'Performance validation failed', error.message);
        }
        
        console.log('');
    }
    
    async validateMemoryUsage() {
        console.log('💾 Validating memory usage...');
        
        try {
            const memBefore = process.memoryUsage();
            
            // Stress test with multiple activations
            for (let i = 0; i < 1000; i++) {
                this.monitor.activateMandate('progressive-think', 'think-level-1', { iteration: i });
            }
            
            const memAfter = process.memoryUsage();
            const heapIncrease = (memAfter.heapUsed - memBefore.heapUsed) / 1024 / 1024; // MB
            
            if (heapIncrease > 10) { // 10MB threshold
                this.logWarning('High memory usage', `Heap increased by ${heapIncrease.toFixed(2)}MB during stress test`);
            } else {
                this.logSuccess(`✅ Memory usage acceptable: +${heapIncrease.toFixed(2)}MB heap increase`);
            }
            
            // Test history cleanup
            const historyLength = this.monitor.patternActivationHistory.length;
            if (historyLength > 1000) {
                this.logWarning('Large history size', `Activation history has ${historyLength} entries`);
            } else {
                this.logSuccess(`✅ History size managed: ${historyLength} entries`);
            }
            
        } catch (error) {
            this.logError('HIGH', 'Memory usage validation failed', error.message);
        }
        
        console.log('');
    }
    
    async validateAPIEndpoints() {
        console.log('🔌 Validating API functionality...');
        
        try {
            // Test export functionality
            const exportData = this.monitor.exportMonitoringData();
            if (!exportData) {
                this.logError('HIGH', 'Export function failed', 'No data exported');
            } else {
                const parsedData = JSON.parse(exportData);
                if (!parsedData.mandateDefinitions || !parsedData.complianceReport) {
                    this.logError('HIGH', 'Incomplete export data', 'Missing required data in export');
                } else {
                    this.logSuccess(`✅ Export functionality verified: ${(exportData.length / 1024).toFixed(2)}KB data`);
                }
            }
            
            // Test report generation
            const report = this.monitor.generateComplianceReport();
            if (!report.mandateStatus || !report.complianceMetrics) {
                this.logError('HIGH', 'Incomplete compliance report', 'Missing required report sections');
            } else {
                this.logSuccess(`✅ Compliance report generation verified`);
            }
            
            // Test recommendations
            const recommendations = this.monitor.generateRecommendations();
            if (!Array.isArray(recommendations)) {
                this.logError('HIGH', 'Invalid recommendations', 'Recommendations is not an array');
            } else {
                this.logSuccess(`✅ Recommendations system verified: ${recommendations.length} recommendations`);
            }
            
        } catch (error) {
            this.logError('HIGH', 'API validation failed', error.message);
        }
        
        console.log('');
    }
    
    async validateDataExport() {
        console.log('📤 Validating data export...');
        
        try {
            const exportData = this.monitor.exportMonitoringData();
            const parsedData = JSON.parse(exportData);
            
            // Validate export structure
            const requiredFields = ['version', 'exportTimestamp', 'mandateDefinitions', 'complianceReport'];
            for (const field of requiredFields) {
                if (!parsedData[field]) {
                    this.logError('HIGH', 'Missing export field', `Export missing field: ${field}`);
                }
            }
            
            // Validate timestamp format
            const timestamp = new Date(parsedData.exportTimestamp);
            if (isNaN(timestamp.getTime())) {
                this.logError('MEDIUM', 'Invalid timestamp', 'Export timestamp is not a valid date');
            } else {
                this.logSuccess(`✅ Export timestamp valid: ${timestamp.toISOString()}`);
            }
            
            // Validate data completeness
            const mandateCount = Object.keys(parsedData.complianceReport.mandateStatus).length;
            if (mandateCount !== 16) {
                this.logError('HIGH', 'Incomplete mandate data', `Expected 16 mandates in export, found ${mandateCount}`);
            } else {
                this.logSuccess(`✅ Complete mandate data exported: ${mandateCount} mandates`);
            }
            
            this.logSuccess(`✅ Data export validation completed`);
            
        } catch (error) {
            this.logError('HIGH', 'Data export validation failed', error.message);
        }
        
        console.log('');
    }
    
    generateValidationReport() {
        const endTime = performance.now();
        const totalTime = (endTime - this.startTime) / 1000;
        
        console.log('📋 VALIDATION REPORT');
        console.log('═══════════════════════════════════════════════════════════════════════════════════════');
        
        const errorCount = this.validationErrors.length;
        const warningCount = this.validationWarnings.length;
        const successCount = this.testResults.filter(r => r.type === 'SUCCESS').length;
        
        console.log(`⏱️  Validation Time: ${totalTime.toFixed(2)} seconds`);
        console.log(`✅ Successful Tests: ${successCount}`);
        console.log(`⚠️  Warnings: ${warningCount}`);
        console.log(`❌ Errors: ${errorCount}`);
        console.log('');
        
        if (errorCount === 0 && warningCount === 0) {
            console.log('🎉 VALIDATION PASSED - All systems operational!');
            console.log('   Universal Mandate Monitor System is ready for deployment.');
        } else if (errorCount === 0) {
            console.log('✅ VALIDATION PASSED WITH WARNINGS - System operational with minor issues.');
            console.log('   Review warnings for potential optimizations.');
        } else {
            console.log('❌ VALIDATION FAILED - Critical issues detected.');
            console.log('   Resolve errors before deploying the monitoring system.');
        }
        
        console.log('');
        
        // Detailed error reporting
        if (errorCount > 0) {
            console.log('❌ ERRORS FOUND:');
            this.validationErrors.forEach((error, index) => {
                console.log(`   ${index + 1}. [${error.severity}] ${error.category}: ${error.message}`);
            });
            console.log('');
        }
        
        if (warningCount > 0) {
            console.log('⚠️  WARNINGS:');
            this.validationWarnings.forEach((warning, index) => {
                console.log(`   ${index + 1}. ${warning.category}: ${warning.message}`);
            });
            console.log('');
        }
        
        console.log('═══════════════════════════════════════════════════════════════════════════════════════');
        console.log('Universal Mandate Monitor System Validation Complete');
        console.log('═══════════════════════════════════════════════════════════════════════════════════════');
        
        // Return validation result
        return {
            passed: errorCount === 0,
            errors: errorCount,
            warnings: warningCount,
            successes: successCount,
            totalTime: totalTime,
            details: {
                errors: this.validationErrors,
                warnings: this.validationWarnings,
                successes: this.testResults.filter(r => r.type === 'SUCCESS')
            }
        };
    }
    
    logSuccess(message) {
        this.testResults.push({ type: 'SUCCESS', message, timestamp: new Date().toISOString() });
        console.log(message);
    }
    
    logWarning(category, message) {
        this.validationWarnings.push({ category, message, timestamp: new Date().toISOString() });
        console.log(`⚠️  WARNING: ${category} - ${message}`);
    }
    
    logError(severity, category, message) {
        this.validationErrors.push({ severity, category, message, timestamp: new Date().toISOString() });
        console.log(`❌ ERROR [${severity}]: ${category} - ${message}`);
    }
}

// Main execution
if (require.main === module) {
    const validator = new MonitoringSystemValidator();
    
    validator.runCompleteValidation()
        .then((result) => {
            process.exit(result.passed ? 0 : 1);
        })
        .catch((error) => {
            console.error('🚨 VALIDATION FAILED WITH EXCEPTION:', error.message);
            process.exit(1);
        });
}

module.exports = { MonitoringSystemValidator };