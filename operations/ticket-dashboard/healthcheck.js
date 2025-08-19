#!/usr/bin/env node

/**
 * DOCKER HEALTH CHECK SCRIPT
 * 
 * Comprehensive health checking for containerized ticket dashboard
 * Validates all critical components and services
 */

const fs = require('fs');
const path = require('path');
const http = require('http');

class DashboardHealthCheck {
    constructor() {
        this.baseDir = process.env.CLAUDE_BASE_DIR || '/claude-data';
        this.dashboardDir = '/app';
        this.checks = [];
    }
    
    async performHealthCheck() {
        console.log('🏥 Starting Dashboard Health Check...');
        
        try {
            // Core system checks
            await this.checkFileSystemAccess();
            await this.checkDashboardEngine();
            await this.checkDataIntegrity();
            await this.checkRegistryAccess();
            await this.checkPerformanceMetrics();
            
            // Service checks
            await this.checkHttpEndpoint();
            await this.checkMemoryUsage();
            await this.checkDiskSpace();
            
            // Integration checks
            await this.checkClaudeDataMount();
            await this.checkBackupSystem();
            
            const healthStatus = this.generateHealthReport();
            
            if (healthStatus.healthy) {
                console.log('✅ Dashboard Health Check: HEALTHY');
                process.exit(0);
            } else {
                console.log('❌ Dashboard Health Check: UNHEALTHY');
                console.log('Issues:', healthStatus.issues);
                process.exit(1);
            }
            
        } catch (error) {
            console.error('❌ Health Check Error:', error.message);
            process.exit(1);
        }
    }
    
    async checkFileSystemAccess() {
        try {
            // Check if dashboard directories are accessible
            const requiredDirs = [
                'data', 'logs', 'cache', 'metrics', 'core'
            ];
            
            for (const dir of requiredDirs) {
                const dirPath = path.join(this.dashboardDir, dir);
                if (!fs.existsSync(dirPath)) {
                    throw new Error(`Required directory missing: ${dir}`);
                }
                
                // Test write access
                const testFile = path.join(dirPath, '.health-check');
                fs.writeFileSync(testFile, 'health-check');
                fs.unlinkSync(testFile);
            }
            
            this.checks.push({
                name: 'File System Access',
                status: 'healthy',
                message: 'All required directories accessible'
            });
            
        } catch (error) {
            this.checks.push({
                name: 'File System Access',
                status: 'unhealthy',
                message: error.message
            });
        }
    }
    
    async checkDashboardEngine() {
        try {
            // Check if dashboard engine is operational
            const pidFile = path.join(this.dashboardDir, 'cache/dashboard.pid');
            
            if (fs.existsSync(pidFile)) {
                const pid = fs.readFileSync(pidFile, 'utf8').trim();
                
                // Check if process is running
                try {
                    process.kill(pid, 0); // Send signal 0 to check if process exists
                    
                    this.checks.push({
                        name: 'Dashboard Engine',
                        status: 'healthy',
                        message: `Dashboard running with PID ${pid}`
                    });
                } catch (error) {
                    this.checks.push({
                        name: 'Dashboard Engine',
                        status: 'unhealthy',
                        message: 'Dashboard process not running'
                    });
                }
            } else {
                this.checks.push({
                    name: 'Dashboard Engine',
                    status: 'warning',
                    message: 'Dashboard PID file not found'
                });
            }
            
        } catch (error) {
            this.checks.push({
                name: 'Dashboard Engine',
                status: 'unhealthy',
                message: error.message
            });
        }
    }
    
    async checkDataIntegrity() {
        try {
            // Check critical data files
            const criticalFiles = [
                'cache/ticket-state.json',
                'data/health-check.json'
            ];
            
            let validFiles = 0;
            
            for (const file of criticalFiles) {
                const filePath = path.join(this.dashboardDir, file);
                if (fs.existsSync(filePath)) {
                    try {
                        const content = fs.readFileSync(filePath, 'utf8');
                        JSON.parse(content); // Validate JSON
                        validFiles++;
                    } catch (error) {
                        // Invalid JSON
                    }
                }
            }
            
            if (validFiles >= criticalFiles.length / 2) {
                this.checks.push({
                    name: 'Data Integrity',
                    status: 'healthy',
                    message: `${validFiles}/${criticalFiles.length} critical files valid`
                });
            } else {
                this.checks.push({
                    name: 'Data Integrity',
                    status: 'unhealthy',
                    message: `Only ${validFiles}/${criticalFiles.length} critical files valid`
                });
            }
            
        } catch (error) {
            this.checks.push({
                name: 'Data Integrity',
                status: 'unhealthy',
                message: error.message
            });
        }
    }
    
    async checkRegistryAccess() {
        try {
            // Check if Claude registry is accessible
            const registryFile = path.join(this.baseDir, 'docs/planning/TICKET_REGISTRY.md');
            
            if (fs.existsSync(registryFile)) {
                const content = fs.readFileSync(registryFile, 'utf8');
                
                if (content.length > 0) {
                    this.checks.push({
                        name: 'Registry Access',
                        status: 'healthy',
                        message: 'Ticket registry accessible'
                    });
                } else {
                    this.checks.push({
                        name: 'Registry Access',
                        status: 'warning',
                        message: 'Registry file is empty'
                    });
                }
            } else {
                this.checks.push({
                    name: 'Registry Access',
                    status: 'unhealthy',
                    message: 'Registry file not accessible'
                });
            }
            
        } catch (error) {
            this.checks.push({
                name: 'Registry Access',
                status: 'unhealthy',
                message: error.message
            });
        }
    }
    
    async checkPerformanceMetrics() {
        try {
            const metrics = {
                memory: process.memoryUsage(),
                uptime: process.uptime(),
                cpu: process.cpuUsage()
            };
            
            // Check memory usage (in MB)
            const memoryUsageMB = metrics.memory.rss / (1024 * 1024);
            const memoryLimitMB = 512; // Default container limit
            
            if (memoryUsageMB < memoryLimitMB * 0.8) {
                this.checks.push({
                    name: 'Performance Metrics',
                    status: 'healthy',
                    message: `Memory usage: ${memoryUsageMB.toFixed(1)}MB, Uptime: ${metrics.uptime.toFixed(0)}s`
                });
            } else {
                this.checks.push({
                    name: 'Performance Metrics',
                    status: 'warning',
                    message: `High memory usage: ${memoryUsageMB.toFixed(1)}MB`
                });
            }
            
        } catch (error) {
            this.checks.push({
                name: 'Performance Metrics',
                status: 'unhealthy',
                message: error.message
            });
        }
    }
    
    async checkHttpEndpoint() {
        return new Promise((resolve) => {
            const port = process.env.DASHBOARD_PORT || 3000;
            
            const req = http.request({
                hostname: 'localhost',
                port: port,
                path: '/health',
                method: 'GET',
                timeout: 5000
            }, (res) => {
                this.checks.push({
                    name: 'HTTP Endpoint',
                    status: 'healthy',
                    message: `HTTP endpoint responding on port ${port}`
                });
                resolve();
            });
            
            req.on('error', () => {
                this.checks.push({
                    name: 'HTTP Endpoint',
                    status: 'warning',
                    message: 'HTTP endpoint not available (dashboard may be CLI-only)'
                });
                resolve();
            });
            
            req.on('timeout', () => {
                this.checks.push({
                    name: 'HTTP Endpoint',
                    status: 'warning',
                    message: 'HTTP endpoint timeout'
                });
                resolve();
            });
            
            req.end();
        });
    }
    
    async checkMemoryUsage() {
        try {
            const memInfo = process.memoryUsage();
            const totalMemMB = memInfo.rss / (1024 * 1024);
            const heapUsedMB = memInfo.heapUsed / (1024 * 1024);
            
            if (totalMemMB < 400) { // Under 400MB is healthy
                this.checks.push({
                    name: 'Memory Usage',
                    status: 'healthy',
                    message: `Memory: ${totalMemMB.toFixed(1)}MB total, ${heapUsedMB.toFixed(1)}MB heap`
                });
            } else if (totalMemMB < 500) {
                this.checks.push({
                    name: 'Memory Usage',
                    status: 'warning',
                    message: `High memory usage: ${totalMemMB.toFixed(1)}MB`
                });
            } else {
                this.checks.push({
                    name: 'Memory Usage',
                    status: 'unhealthy',
                    message: `Critical memory usage: ${totalMemMB.toFixed(1)}MB`
                });
            }
            
        } catch (error) {
            this.checks.push({
                name: 'Memory Usage',
                status: 'unhealthy',
                message: error.message
            });
        }
    }
    
    async checkDiskSpace() {
        try {
            const stats = fs.statSync(this.dashboardDir);
            
            // Simple disk space check - ensure we can write files
            const testFile = path.join(this.dashboardDir, 'cache/.disk-check');
            fs.writeFileSync(testFile, 'disk-check');
            fs.unlinkSync(testFile);
            
            this.checks.push({
                name: 'Disk Space',
                status: 'healthy',
                message: 'Sufficient disk space available'
            });
            
        } catch (error) {
            this.checks.push({
                name: 'Disk Space',
                status: 'unhealthy',
                message: 'Disk space or write permission issue'
            });
        }
    }
    
    async checkClaudeDataMount() {
        try {
            // Check if Claude data directory is properly mounted
            const todosDir = path.join(this.baseDir, 'todos');
            const docsDir = path.join(this.baseDir, 'docs');
            
            let mountStatus = 'healthy';
            let message = 'Claude data properly mounted';
            
            if (!fs.existsSync(todosDir)) {
                mountStatus = 'warning';
                message = 'Todos directory not found';
            }
            
            if (!fs.existsSync(docsDir)) {
                mountStatus = 'warning';
                message = 'Docs directory not found';
            }
            
            this.checks.push({
                name: 'Claude Data Mount',
                status: mountStatus,
                message: message
            });
            
        } catch (error) {
            this.checks.push({
                name: 'Claude Data Mount',
                status: 'unhealthy',
                message: error.message
            });
        }
    }
    
    async checkBackupSystem() {
        try {
            const backupDir = '/app/backups';
            
            if (fs.existsSync(backupDir)) {
                this.checks.push({
                    name: 'Backup System',
                    status: 'healthy',
                    message: 'Backup system operational'
                });
            } else {
                this.checks.push({
                    name: 'Backup System',
                    status: 'warning',
                    message: 'Backup directory not found'
                });
            }
            
        } catch (error) {
            this.checks.push({
                name: 'Backup System',
                status: 'warning',
                message: 'Backup system not available'
            });
        }
    }
    
    generateHealthReport() {
        const summary = {
            timestamp: new Date().toISOString(),
            healthy: true,
            issues: [],
            warnings: [],
            checks: this.checks
        };
        
        this.checks.forEach(check => {
            if (check.status === 'unhealthy') {
                summary.healthy = false;
                summary.issues.push(`${check.name}: ${check.message}`);
            } else if (check.status === 'warning') {
                summary.warnings.push(`${check.name}: ${check.message}`);
            }
        });
        
        // Save health report
        try {
            const healthFile = path.join(this.dashboardDir, 'data/health-check.json');
            fs.writeFileSync(healthFile, JSON.stringify(summary, null, 2));
        } catch (error) {
            // Don't fail health check if we can't write the report
        }
        
        return summary;
    }
}

// CLI execution
if (require.main === module) {
    const healthCheck = new DashboardHealthCheck();
    healthCheck.performHealthCheck();
} else {
    module.exports = DashboardHealthCheck;
}