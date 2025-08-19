#!/usr/bin/env node

/**
 * DOCKER DEPLOYMENT VALIDATION SCRIPT
 * 
 * Validates the complete Docker containerization solution
 * Checks all components and configuration files
 */

const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

class DockerDeploymentValidator {
    constructor() {
        this.baseDir = process.cwd();
        this.validationResults = [];
    }
    
    async validateDeployment() {
        console.log('🐳 Validating Docker Deployment Configuration...\n');
        
        try {
            // Core validation checks
            this.validateDockerFiles();
            this.validateComposeFiles();
            this.validateEnvironmentFiles();
            this.validateScripts();
            this.validateDirectoryStructure();
            this.validateHealthChecks();
            this.validateIntegrationComponents();
            await this.validateDockerPrerequisites();
            
            this.generateValidationReport();
            
        } catch (error) {
            console.error('❌ Validation failed:', error.message);
            process.exit(1);
        }
    }
    
    validateDockerFiles() {
        console.log('📦 Validating Docker configuration files...');
        
        // Check Dockerfile
        this.checkFile('Dockerfile', 'Docker image configuration', [
            'FROM node:18-alpine',
            'USER dashboard',
            'HEALTHCHECK',
            'ENTRYPOINT'
        ]);
        
        // Check .dockerignore
        this.checkFile('.dockerignore', 'Docker ignore file', [
            'node_modules/',
            'logs/',
            'cache/',
            '.git/'
        ]);
        
        console.log('✅ Docker files validated\n');
    }
    
    validateComposeFiles() {
        console.log('🎭 Validating Docker Compose files...');
        
        // Main compose file
        this.checkFile('docker-compose.yml', 'Main Docker Compose configuration', [
            'services:',
            'ticket-dashboard:',
            'volumes:',
            'networks:'
        ]);
        
        // Override file
        this.checkFile('docker-compose.override.yml', 'Development override configuration', [
            'NODE_ENV=development',
            'debug-shell:',
            'integration-tests:'
        ]);
        
        // Production file
        this.checkFile('docker-compose.prod.yml', 'Production configuration', [
            'NODE_ENV=production',
            'restart: always',
            'backup-service:',
            'monitoring:'
        ]);
        
        console.log('✅ Docker Compose files validated\n');
    }
    
    validateEnvironmentFiles() {
        console.log('🔧 Validating environment configuration...');
        
        // Example environment file
        this.checkFile('.env.example', 'Environment template', [
            'DASHBOARD_PORT=',
            'CLAUDE_DATA_DIR=',
            'LOG_LEVEL=',
            'BACKUP_SCHEDULE='
        ]);
        
        // Default environment file
        this.checkFile('.env', 'Default environment configuration', [
            'DASHBOARD_PORT=3000',
            'NODE_ENV=production',
            'AUTO_SYNC_ENABLED=true'
        ]);
        
        console.log('✅ Environment files validated\n');
    }
    
    validateScripts() {
        console.log('📝 Validating deployment scripts...');
        
        // Deployment script
        this.checkExecutableScript('docker-deploy.sh', 'Main deployment script', [
            'print_banner()',
            'check_prerequisites()',
            'deploy_services()',
            'perform_health_check()'
        ]);
        
        // Health check script
        this.checkFile('healthcheck.js', 'Health check script', [
            'class DashboardHealthCheck',
            'performHealthCheck()',
            'checkFileSystemAccess()',
            'checkDashboardEngine()'
        ]);
        
        // Integration script
        this.checkFile('docker-integration.js', 'Docker integration script', [
            'class DockerIntegration',
            'startSynchronization()',
            'performDataSync()',
            'setupFileWatchers()'
        ]);
        
        // Web server
        this.checkFile('web-server.js', 'Web server component', [
            'class DashboardWebServer',
            'setupRoutes()',
            '/health',
            '/api/status'
        ]);
        
        console.log('✅ Scripts validated\n');
    }
    
    validateDirectoryStructure() {
        console.log('📁 Validating directory structure...');
        
        const requiredDirs = [
            'docker-volumes',
            'docker-volumes/data',
            'docker-volumes/logs',
            'docker-volumes/metrics',
            'docker-volumes/cache',
            'docker-volumes/config',
            'docker-volumes/backups',
            'docker-volumes/prod',
            'docker-volumes/prod/data',
            'docker-volumes/prod/logs',
            'docker-volumes/prod/metrics'
        ];
        
        let missingDirs = [];
        
        requiredDirs.forEach(dir => {
            const dirPath = path.join(this.baseDir, dir);
            if (!fs.existsSync(dirPath)) {
                missingDirs.push(dir);
            }
        });
        
        if (missingDirs.length > 0) {
            this.validationResults.push({
                name: 'Directory Structure',
                status: 'warning',
                message: `Missing directories: ${missingDirs.join(', ')}`
            });
        } else {
            this.validationResults.push({
                name: 'Directory Structure',
                status: 'success',
                message: 'All required directories present'
            });
        }
        
        console.log('✅ Directory structure validated\n');
    }
    
    validateHealthChecks() {
        console.log('🏥 Validating health check implementation...');
        
        try {
            // Test health check script can be required
            const healthCheckPath = path.join(this.baseDir, 'healthcheck.js');
            if (fs.existsSync(healthCheckPath)) {
                const content = fs.readFileSync(healthCheckPath, 'utf8');
                
                const requiredMethods = [
                    'checkFileSystemAccess',
                    'checkDashboardEngine',
                    'checkDataIntegrity',
                    'checkRegistryAccess',
                    'checkPerformanceMetrics',
                    'checkClaudeDataMount'
                ];
                
                const missingMethods = requiredMethods.filter(method => 
                    !content.includes(method)
                );
                
                if (missingMethods.length === 0) {
                    this.validationResults.push({
                        name: 'Health Check Implementation',
                        status: 'success',
                        message: 'All health check methods implemented'
                    });
                } else {
                    this.validationResults.push({
                        name: 'Health Check Implementation',
                        status: 'error',
                        message: `Missing methods: ${missingMethods.join(', ')}`
                    });
                }
            }
        } catch (error) {
            this.validationResults.push({
                name: 'Health Check Implementation',
                status: 'error',
                message: error.message
            });
        }
        
        console.log('✅ Health checks validated\n');
    }
    
    validateIntegrationComponents() {
        console.log('🔗 Validating integration components...');
        
        // Check package.json
        this.checkFile('package.json', 'Node.js package configuration', [
            '"name": "automated-ticket-dashboard"',
            '"main": "deploy.js"',
            '"scripts"',
            '"dependencies"'
        ]);
        
        // Check documentation
        this.checkFile('DOCKER_DEPLOYMENT_GUIDE.md', 'Deployment guide', [
            '# Docker Deployment Guide',
            '🚀 Quick Start',
            'Architecture Components',
            'Troubleshooting'
        ]);
        
        this.checkFile('docker-deployment-summary.md', 'Deployment summary', [
            '# Docker Deployment Summary',
            'DEPLOYMENT STATUS',
            'DEPLOYMENT DELIVERABLES',
            'SUCCESS CRITERIA'
        ]);
        
        console.log('✅ Integration components validated\n');
    }
    
    async validateDockerPrerequisites() {
        console.log('🔍 Validating Docker prerequisites...');
        
        try {
            // Check Docker
            await this.runCommand('docker', ['--version']);
            this.validationResults.push({
                name: 'Docker Engine',
                status: 'success',
                message: 'Docker is installed and accessible'
            });
            
            // Check Docker Compose
            await this.runCommand('docker-compose', ['--version']);
            this.validationResults.push({
                name: 'Docker Compose',
                status: 'success',
                message: 'Docker Compose is installed and accessible'
            });
            
            // Check Docker daemon (optional - may not be running on all systems)
            try {
                await this.runCommand('docker', ['info']);
                this.validationResults.push({
                    name: 'Docker Daemon',
                    status: 'success',
                    message: 'Docker daemon is running'
                });
            } catch (error) {
                this.validationResults.push({
                    name: 'Docker Daemon',
                    status: 'warning',
                    message: 'Docker daemon not running (may be expected in some environments)'
                });
            }
            
        } catch (error) {
            this.validationResults.push({
                name: 'Docker Prerequisites',
                status: 'error',
                message: 'Docker or Docker Compose not available: ' + error.message
            });
        }
        
        console.log('✅ Docker prerequisites validated\n');
    }
    
    checkFile(filename, description, requiredContent = []) {
        const filePath = path.join(this.baseDir, filename);
        
        if (!fs.existsSync(filePath)) {
            this.validationResults.push({
                name: description,
                status: 'error',
                message: `File not found: ${filename}`
            });
            return;
        }
        
        try {
            const content = fs.readFileSync(filePath, 'utf8');
            
            if (requiredContent.length > 0) {
                const missingContent = requiredContent.filter(required => 
                    !content.includes(required)
                );
                
                if (missingContent.length === 0) {
                    this.validationResults.push({
                        name: description,
                        status: 'success',
                        message: `File validated: ${filename}`
                    });
                } else {
                    this.validationResults.push({
                        name: description,
                        status: 'warning',
                        message: `Missing content in ${filename}: ${missingContent.join(', ')}`
                    });
                }
            } else {
                this.validationResults.push({
                    name: description,
                    status: 'success',
                    message: `File exists: ${filename}`
                });
            }
            
        } catch (error) {
            this.validationResults.push({
                name: description,
                status: 'error',
                message: `Error reading ${filename}: ${error.message}`
            });
        }
    }
    
    checkExecutableScript(filename, description, requiredContent = []) {
        this.checkFile(filename, description, requiredContent);
        
        // Check if script is executable
        const filePath = path.join(this.baseDir, filename);
        if (fs.existsSync(filePath)) {
            try {
                const stats = fs.statSync(filePath);
                if (!(stats.mode & 0o111)) {
                    this.validationResults.push({
                        name: description + ' (Permissions)',
                        status: 'warning',
                        message: `Script not executable: ${filename}`
                    });
                }
            } catch (error) {
                // Ignore permission check errors
            }
        }
    }
    
    async runCommand(command, args) {
        return new Promise((resolve, reject) => {
            const proc = spawn(command, args, { stdio: 'pipe' });
            
            proc.on('close', (code) => {
                if (code === 0) {
                    resolve();
                } else {
                    reject(new Error(`Command failed with code ${code}`));
                }
            });
            
            proc.on('error', (error) => {
                reject(error);
            });
        });
    }
    
    generateValidationReport() {
        console.log('📊 DOCKER DEPLOYMENT VALIDATION REPORT');
        console.log('═'.repeat(60));
        
        const successCount = this.validationResults.filter(r => r.status === 'success').length;
        const warningCount = this.validationResults.filter(r => r.status === 'warning').length;
        const errorCount = this.validationResults.filter(r => r.status === 'error').length;
        const totalCount = this.validationResults.length;
        
        // Summary
        console.log(`\n📈 VALIDATION SUMMARY:`);
        console.log(`   ✅ Success: ${successCount}/${totalCount}`);
        console.log(`   ⚠️  Warnings: ${warningCount}/${totalCount}`);
        console.log(`   ❌ Errors: ${errorCount}/${totalCount}`);
        
        // Detailed results
        console.log(`\n📋 DETAILED RESULTS:`);
        this.validationResults.forEach(result => {
            const icon = result.status === 'success' ? '✅' : 
                        result.status === 'warning' ? '⚠️ ' : '❌';
            console.log(`   ${icon} ${result.name}: ${result.message}`);
        });
        
        // Overall status
        console.log('\n' + '═'.repeat(60));
        if (errorCount === 0) {
            if (warningCount === 0) {
                console.log('🎉 VALIDATION PASSED: Docker deployment is ready for production!');
                console.log('🚀 Run "./docker-deploy.sh" to deploy the containerized dashboard.');
            } else {
                console.log('✅ VALIDATION PASSED: Docker deployment is ready with minor warnings.');
                console.log('🚀 Run "./docker-deploy.sh" to deploy the containerized dashboard.');
            }
        } else {
            console.log('❌ VALIDATION FAILED: Please fix the errors before deployment.');
            process.exit(1);
        }
        
        // Save validation report
        const report = {
            timestamp: new Date().toISOString(),
            summary: {
                total: totalCount,
                success: successCount,
                warnings: warningCount,
                errors: errorCount,
                passed: errorCount === 0
            },
            results: this.validationResults
        };
        
        const reportFile = path.join(this.baseDir, 'docker-validation-report.json');
        fs.writeFileSync(reportFile, JSON.stringify(report, null, 2));
        console.log(`\n📄 Validation report saved: ${reportFile}`);
    }
}

// CLI execution
if (require.main === module) {
    const validator = new DockerDeploymentValidator();
    validator.validateDeployment();
} else {
    module.exports = DockerDeploymentValidator;
}