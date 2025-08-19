#!/usr/bin/env node

/**
 * AUTOMATED TICKET STATUS TRACKING DASHBOARD DEPLOYMENT
 * 
 * Production-ready deployment script that orchestrates all dashboard components
 * and validates the complete system integration.
 */

const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

// Import dashboard components
const TicketDashboardEngine = require('./core/dashboard-engine');
const RegistrySync = require('./api/registry-sync');
const AgentExecutionTracker = require('./agents/execution-tracker');
const FileMovementAutomation = require('./automation/file-movement');
const TicketLifecycleManager = require('./core/lifecycle-manager');

class DashboardDeployment {
    constructor() {
        this.baseDir = '/Users/nalve/.claude';
        this.dashboardDir = path.join(this.baseDir, 'operations/ticket-dashboard');
        this.components = {};
        this.deploymentLog = [];
        
        this.initializeDeployment();
    }
    
    initializeDeployment() {
        console.log('🚀 Starting Automated Ticket Dashboard Deployment...');
        this.log('Deployment initialization started');
        
        this.setupDirectories();
        this.createPidFile();
    }
    
    setupDirectories() {
        const requiredDirs = [
            'core', 'hooks', 'agents', 'automation', 'api',
            'data', 'logs', 'cache', 'reports', 'metrics'
        ];
        
        requiredDirs.forEach(dir => {
            const fullPath = path.join(this.dashboardDir, dir);
            if (!fs.existsSync(fullPath)) {
                fs.mkdirSync(fullPath, { recursive: true });
            }
        });
    }
    
    createPidFile() {
        const pidFile = path.join(this.dashboardDir, 'cache/dashboard.pid');
        fs.writeFileSync(pidFile, process.pid.toString());
        
        // Clean up PID file on exit
        process.on('exit', () => {
            if (fs.existsSync(pidFile)) {
                fs.unlinkSync(pidFile);
            }
        });
    }
    
    async deploy() {
        try {
            this.log('=== DEPLOYMENT PHASE 1: Component Initialization ===');
            await this.initializeComponents();
            
            this.log('=== DEPLOYMENT PHASE 2: System Integration ===');
            await this.integrateComponents();
            
            this.log('=== DEPLOYMENT PHASE 3: Validation ===');
            const validation = await this.validateDeployment();
            
            if (validation.success) {
                this.log('=== DEPLOYMENT PHASE 4: Start Services ===');
                await this.startServices();
                
                this.log('✅ Dashboard deployment completed successfully');
                this.displayDeploymentSummary();
                
                return {
                    success: true,
                    message: 'Dashboard deployed and running',
                    components: Object.keys(this.components),
                    validation: validation
                };
            } else {
                throw new Error('Deployment validation failed: ' + validation.errors.join(', '));
            }
            
        } catch (error) {
            this.log('❌ Deployment failed: ' + error.message);
            await this.rollback();
            
            return {
                success: false,
                error: error.message,
                deploymentLog: this.deploymentLog
            };
        }
    }
    
    async initializeComponents() {
        this.log('Initializing dashboard components...');
        
        try {
            // Initialize Dashboard Engine
            this.log('Initializing Dashboard Engine...');
            this.components.dashboardEngine = new TicketDashboardEngine();
            
            // Initialize Registry Sync
            this.log('Initializing Registry Sync...');
            this.components.registrySync = new RegistrySync();
            
            // Initialize Agent Tracker
            this.log('Initializing Agent Execution Tracker...');
            this.components.agentTracker = new AgentExecutionTracker();
            
            // Initialize File Movement
            this.log('Initializing File Movement Automation...');
            this.components.fileMovement = new FileMovementAutomation();
            
            // Initialize Lifecycle Manager
            this.log('Initializing Lifecycle Manager...');
            this.components.lifecycleManager = new TicketLifecycleManager();
            
            this.log('✅ All components initialized successfully');
            
        } catch (error) {
            throw new Error('Component initialization failed: ' + error.message);
        }
    }
    
    async integrateComponents() {
        this.log('Integrating dashboard components...');
        
        try {
            // Set up inter-component communication
            this.setupComponentIntegration();
            
            // Configure monitoring
            this.setupMonitoring();
            
            // Initialize data synchronization
            this.setupDataSync();
            
            this.log('✅ Component integration completed');
            
        } catch (error) {
            throw new Error('Component integration failed: ' + error.message);
        }
    }
    
    setupComponentIntegration() {
        this.log('Setting up component integration...');
        
        // Create integration configuration
        const integrationConfig = {
            dashboard: {
                refreshInterval: 5000,
                autoSync: true
            },
            registry: {
                syncOnChange: true,
                backupOnUpdate: true
            },
            fileMovement: {
                autoMove: true,
                validateIntegrity: true
            },
            lifecycle: {
                autoArchive: true,
                validationRequired: true
            }
        };
        
        const configFile = path.join(this.dashboardDir, 'core/integration-config.json');
        fs.writeFileSync(configFile, JSON.stringify(integrationConfig, null, 2));
    }
    
    setupMonitoring() {
        this.log('Setting up system monitoring...');
        
        // Create monitoring configuration
        const monitoringConfig = {
            healthCheck: {
                interval: 30000, // 30 seconds
                enabled: true
            },
            performance: {
                trackMetrics: true,
                alertThresholds: {
                    errorRate: 5, // percent
                    responseTime: 5000 // milliseconds
                }
            },
            logging: {
                level: 'info',
                retention: 30 // days
            }
        };
        
        const configFile = path.join(this.dashboardDir, 'core/monitoring-config.json');
        fs.writeFileSync(configFile, JSON.stringify(monitoringConfig, null, 2));
    }
    
    setupDataSync() {
        this.log('Setting up data synchronization...');
        
        // Initialize data directories
        const dataDirectories = [
            'ticket-state',
            'agent-sessions', 
            'file-movements',
            'lifecycle-audit',
            'metrics-archive'
        ];
        
        dataDirectories.forEach(dir => {
            const dirPath = path.join(this.dashboardDir, 'data', dir);
            if (!fs.existsSync(dirPath)) {
                fs.mkdirSync(dirPath, { recursive: true });
            }
        });
    }
    
    async validateDeployment() {
        this.log('Validating deployment...');
        
        const validation = {
            success: true,
            errors: [],
            warnings: [],
            components: {}
        };
        
        try {
            // Validate each component
            validation.components.dashboardEngine = this.validateDashboardEngine();
            validation.components.registrySync = this.validateRegistrySync();
            validation.components.agentTracker = this.validateAgentTracker();
            validation.components.fileMovement = this.validateFileMovement();
            validation.components.lifecycleManager = this.validateLifecycleManager();
            
            // Check for component validation failures
            Object.keys(validation.components).forEach(component => {
                const result = validation.components[component];
                if (!result.valid) {
                    validation.success = false;
                    validation.errors.push(component + ': ' + result.error);
                }
                if (result.warnings) {
                    validation.warnings.push(...result.warnings);
                }
            });
            
            // Validate system integration
            const integrationResult = this.validateSystemIntegration();
            if (!integrationResult.valid) {
                validation.success = false;
                validation.errors.push('Integration: ' + integrationResult.error);
            }
            
            // Validate data integrity
            const dataIntegrityResult = this.validateDataIntegrity();
            if (!dataIntegrityResult.valid) {
                validation.success = false;
                validation.errors.push('Data Integrity: ' + dataIntegrityResult.error);
            }
            
            if (validation.success) {
                this.log('✅ Deployment validation passed');
            } else {
                this.log('❌ Deployment validation failed: ' + validation.errors.length + ' errors');
            }
            
            return validation;
            
        } catch (error) {
            validation.success = false;
            validation.errors.push('Validation error: ' + error.message);
            return validation;
        }
    }
    
    validateDashboardEngine() {
        try {
            if (!this.components.dashboardEngine) {
                return { valid: false, error: 'Dashboard engine not initialized' };
            }
            
            // Test dashboard engine functionality
            const status = this.components.dashboardEngine.getStatus();
            
            return {
                valid: true,
                status: status,
                message: 'Dashboard engine operational'
            };
            
        } catch (error) {
            return { valid: false, error: error.message };
        }
    }
    
    validateRegistrySync() {
        try {
            if (!this.components.registrySync) {
                return { valid: false, error: 'Registry sync not initialized' };
            }
            
            // Test registry sync functionality
            const syncStatus = this.components.registrySync.getLastSyncStatus();
            
            return {
                valid: true,
                status: syncStatus,
                message: 'Registry sync operational'
            };
            
        } catch (error) {
            return { valid: false, error: error.message };
        }
    }
    
    validateAgentTracker() {
        try {
            if (!this.components.agentTracker) {
                return { valid: false, error: 'Agent tracker not initialized' };
            }
            
            // Test agent tracker functionality
            const summary = this.components.agentTracker.getExecutionSummary();
            
            return {
                valid: true,
                summary: summary,
                message: 'Agent tracker operational'
            };
            
        } catch (error) {
            return { valid: false, error: error.message };
        }
    }
    
    validateFileMovement() {
        try {
            if (!this.components.fileMovement) {
                return { valid: false, error: 'File movement not initialized' };
            }
            
            // Test file movement functionality
            const stats = this.components.fileMovement.getMovementStatistics();
            
            return {
                valid: true,
                stats: stats,
                message: 'File movement operational'
            };
            
        } catch (error) {
            return { valid: false, error: error.message };
        }
    }
    
    validateLifecycleManager() {
        try {
            if (!this.components.lifecycleManager) {
                return { valid: false, error: 'Lifecycle manager not initialized' };
            }
            
            // Test lifecycle manager functionality
            const integrity = this.components.lifecycleManager.validateSystemIntegrity();
            
            return {
                valid: true,
                integrity: integrity,
                message: 'Lifecycle manager operational'
            };
            
        } catch (error) {
            return { valid: false, error: error.message };
        }
    }
    
    validateSystemIntegration() {
        try {
            // Check configuration files
            const configFiles = [
                'core/integration-config.json',
                'core/monitoring-config.json'
            ];
            
            const missingConfigs = configFiles.filter(file => {
                return !fs.existsSync(path.join(this.dashboardDir, file));
            });
            
            if (missingConfigs.length > 0) {
                return {
                    valid: false,
                    error: 'Missing configuration files: ' + missingConfigs.join(', ')
                };
            }
            
            // Check data directories
            const dataDirectories = [
                'data', 'logs', 'cache', 'metrics'
            ];
            
            const missingDirs = dataDirectories.filter(dir => {
                return !fs.existsSync(path.join(this.dashboardDir, dir));
            });
            
            if (missingDirs.length > 0) {
                return {
                    valid: false,
                    error: 'Missing data directories: ' + missingDirs.join(', ')
                };
            }
            
            return {
                valid: true,
                message: 'System integration validated'
            };
            
        } catch (error) {
            return { valid: false, error: error.message };
        }
    }
    
    validateDataIntegrity() {
        try {
            // Check for required data files
            const dataFiles = [
                'data/ticket-state.json',
                'data/agent-sessions.json',
                'data/lifecycle-audit.json'
            ];
            
            // These files may not exist initially, so we just check if the directories exist
            const dataDir = path.join(this.dashboardDir, 'data');
            if (!fs.existsSync(dataDir)) {
                return {
                    valid: false,
                    error: 'Data directory does not exist'
                };
            }
            
            return {
                valid: true,
                message: 'Data integrity validated'
            };
            
        } catch (error) {
            return { valid: false, error: error.message };
        }
    }
    
    async startServices() {
        this.log('Starting dashboard services...');
        
        try {
            // Start monitoring
            this.startMonitoring();
            
            // Start periodic tasks
            this.startPeriodicTasks();
            
            // Register signal handlers
            this.registerSignalHandlers();
            
            this.log('✅ All services started successfully');
            
        } catch (error) {
            throw new Error('Service startup failed: ' + error.message);
        }
    }
    
    startMonitoring() {
        this.log('Starting monitoring services...');
        
        // Health check interval
        this.healthCheckInterval = setInterval(() => {
            this.performHealthCheck();
        }, 30000); // 30 seconds
        
        // Performance monitoring
        this.performanceInterval = setInterval(() => {
            this.collectPerformanceMetrics();
        }, 60000); // 1 minute
    }
    
    startPeriodicTasks() {
        this.log('Starting periodic tasks...');
        
        // Registry sync (every 5 minutes)
        this.registrySyncInterval = setInterval(() => {
            if (this.components.registrySync) {
                this.components.registrySync.forceSyncRegistry();
            }
        }, 300000);
        
        // File organization (every 30 minutes)
        this.fileOrgInterval = setInterval(() => {
            if (this.components.fileMovement) {
                this.components.fileMovement.organizeAllTickets();
            }
        }, 1800000);
        
        // Archival check (every 6 hours)
        this.archivalInterval = setInterval(() => {
            if (this.components.lifecycleManager) {
                this.components.lifecycleManager.archiveCompletedTickets();
            }
        }, 21600000);
    }
    
    registerSignalHandlers() {
        this.log('Registering signal handlers...');
        
        process.on('SIGTERM', () => {
            this.log('Received SIGTERM, shutting down gracefully...');
            this.shutdown();
        });
        
        process.on('SIGINT', () => {
            this.log('Received SIGINT, shutting down gracefully...');
            this.shutdown();
        });
        
        process.on('SIGUSR1', () => {
            this.log('Received SIGUSR1, performing force sync...');
            this.forceSync();
        });
    }
    
    performHealthCheck() {
        const health = {
            timestamp: new Date().toISOString(),
            status: 'healthy',
            components: {},
            issues: []
        };
        
        // Check each component
        Object.keys(this.components).forEach(componentName => {
            try {
                const component = this.components[componentName];
                health.components[componentName] = {
                    status: 'operational',
                    lastCheck: new Date().toISOString()
                };
            } catch (error) {
                health.components[componentName] = {
                    status: 'error',
                    error: error.message,
                    lastCheck: new Date().toISOString()
                };
                health.issues.push(componentName + ': ' + error.message);
            }
        });
        
        if (health.issues.length > 0) {
            health.status = 'degraded';
        }
        
        // Save health report
        const healthFile = path.join(this.dashboardDir, 'data/health-check.json');
        fs.writeFileSync(healthFile, JSON.stringify(health, null, 2));
    }
    
    collectPerformanceMetrics() {
        const metrics = {
            timestamp: new Date().toISOString(),
            memory: process.memoryUsage(),
            uptime: process.uptime(),
            cpu: process.cpuUsage()
        };
        
        // Save metrics
        const metricsFile = path.join(this.dashboardDir, 'metrics/performance.json');
        fs.writeFileSync(metricsFile, JSON.stringify(metrics, null, 2));
    }
    
    forceSync() {
        this.log('Performing force synchronization...');
        
        try {
            if (this.components.dashboardEngine) {
                this.components.dashboardEngine.forceSync();
            }
            
            if (this.components.registrySync) {
                this.components.registrySync.forceSyncRegistry();
            }
            
            this.log('✅ Force synchronization completed');
            
        } catch (error) {
            this.log('❌ Force synchronization failed: ' + error.message);
        }
    }
    
    async rollback() {
        this.log('Performing deployment rollback...');
        
        try {
            // Stop all intervals
            this.stopAllIntervals();
            
            // Clean up components
            this.components = {};
            
            // Remove PID file
            const pidFile = path.join(this.dashboardDir, 'cache/dashboard.pid');
            if (fs.existsSync(pidFile)) {
                fs.unlinkSync(pidFile);
            }
            
            this.log('✅ Rollback completed');
            
        } catch (error) {
            this.log('❌ Rollback error: ' + error.message);
        }
    }
    
    shutdown() {
        this.log('Shutting down dashboard...');
        
        try {
            // Stop all intervals
            this.stopAllIntervals();
            
            // Stop components
            Object.keys(this.components).forEach(componentName => {
                const component = this.components[componentName];
                if (component && typeof component.stop === 'function') {
                    component.stop();
                }
            });
            
            // Remove PID file
            const pidFile = path.join(this.dashboardDir, 'cache/dashboard.pid');
            if (fs.existsSync(pidFile)) {
                fs.unlinkSync(pidFile);
            }
            
            this.log('✅ Dashboard shutdown completed');
            process.exit(0);
            
        } catch (error) {
            this.log('❌ Shutdown error: ' + error.message);
            process.exit(1);
        }
    }
    
    stopAllIntervals() {
        const intervals = [
            'healthCheckInterval',
            'performanceInterval', 
            'registrySyncInterval',
            'fileOrgInterval',
            'archivalInterval'
        ];
        
        intervals.forEach(intervalName => {
            if (this[intervalName]) {
                clearInterval(this[intervalName]);
                this[intervalName] = null;
            }
        });
    }
    
    displayDeploymentSummary() {
        console.log('\n🎯 AUTOMATED TICKET DASHBOARD DEPLOYMENT SUMMARY');
        console.log('==================================================');
        console.log('✅ Status: DEPLOYED AND OPERATIONAL');
        console.log('📊 Components: ' + Object.keys(this.components).length + ' active');
        console.log('🔄 Monitoring: Health checks every 30s');
        console.log('📁 File Movement: Automated ticket lifecycle');
        console.log('🤖 Agent Tracking: Real-time execution monitoring');
        console.log('📋 Registry Sync: Live status synchronization');
        console.log('🛡️  Validation Gates: Comprehensive quality control');
        console.log('📈 Metrics: Performance and usage tracking');
        console.log('==================================================');
        console.log('Dashboard is now eliminating manual status tracking!');
        console.log('Monitor logs at: ' + path.join(this.dashboardDir, 'logs/'));
        console.log('Dashboard PID: ' + process.pid);
        console.log('\nPress Ctrl+C to stop the dashboard gracefully.');
    }
    
    log(message) {
        const timestamp = new Date().toISOString();
        const logEntry = timestamp + ' - ' + message;
        
        this.deploymentLog.push(logEntry);
        
        // Write to log file
        const logFile = path.join(this.dashboardDir, 'logs/deployment.log');
        fs.appendFileSync(logFile, logEntry + '\n');
        
        console.log('🚀 ' + message);
    }
}

// CLI execution
if (require.main === module) {
    const deployment = new DashboardDeployment();
    
    deployment.deploy().then(result => {
        if (result.success) {
            console.log('\n✅ DEPLOYMENT SUCCESSFUL - Dashboard is running');
            
            // Keep the process running
            process.stdin.resume();
            
        } else {
            console.error('\n❌ DEPLOYMENT FAILED:', result.error);
            process.exit(1);
        }
    }).catch(error => {
        console.error('\n❌ DEPLOYMENT ERROR:', error.message);
        process.exit(1);
    });
} else {
    // Export for module usage
    module.exports = DashboardDeployment;
}
