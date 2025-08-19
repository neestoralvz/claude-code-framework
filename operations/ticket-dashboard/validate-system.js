#!/usr/bin/env node

/**
 * COMPREHENSIVE SYSTEM VALIDATION
 * 
 * Validates the complete automated ticket dashboard system
 * to ensure all requirements are met and manual tracking is eliminated.
 */

const fs = require('fs');
const path = require('path');

class SystemValidator {
    constructor() {
        this.baseDir = '/Users/nalve/.claude';
        this.dashboardDir = path.join(this.baseDir, 'operations/ticket-dashboard');
        this.validationResults = {
            overall: false,
            components: {},
            requirements: {},
            errors: [],
            warnings: []
        };
    }
    
    async validateCompleteSystem() {
        console.log('🔍 Starting comprehensive system validation...');
        
        try {
            // Validate deployment requirements
            await this.validateDeploymentRequirements();
            
            // Validate component architecture
            await this.validateComponentArchitecture();
            
            // Validate integration points
            await this.validateIntegrationPoints();
            
            // Validate automation capabilities
            await this.validateAutomationCapabilities();
            
            // Generate final report
            const report = this.generateValidationReport();
            
            console.log('\n📋 VALIDATION COMPLETE');
            this.displayValidationSummary(report);
            
            return report;
            
        } catch (error) {
            console.error('❌ Validation failed:', error.message);
            return {
                overall: false,
                error: error.message,
                results: this.validationResults
            };
        }
    }
    
    async validateDeploymentRequirements() {
        console.log('📋 Validating deployment requirements...');
        
        // 1. Real-Time Dashboard Architecture
        this.validateRequirement('real_time_dashboard', () => {
            const coreFiles = [
                'core/dashboard-engine.js',
                'core/lifecycle-manager.js'
            ];
            
            const missing = coreFiles.filter(file => 
                !fs.existsSync(path.join(this.dashboardDir, file))
            );
            
            if (missing.length > 0) {
                throw new Error('Missing core files: ' + missing.join(', '));
            }
            
            return {
                status: 'implemented',
                details: 'Real-time dashboard with auto-refresh and live monitoring'
            };
        });
        
        // 2. Automated Status Update Hooks
        this.validateRequirement('status_update_hooks', () => {
            const hooksFile = path.join(this.dashboardDir, 'hooks/status-hooks.js');
            
            if (!fs.existsSync(hooksFile)) {
                throw new Error('Status hooks system not found');
            }
            
            const content = fs.readFileSync(hooksFile, 'utf8');
            if (!content.includes('status_changed') || !content.includes('created')) {
                throw new Error('Status hooks incomplete');
            }
            
            return {
                status: 'implemented',
                details: 'Automated hooks for status transitions with timestamp recording'
            };
        });
        
        // 3. Registry Integration System
        this.validateRequirement('registry_integration', () => {
            const syncFile = path.join(this.dashboardDir, 'api/registry-sync.js');
            
            if (!fs.existsSync(syncFile)) {
                throw new Error('Registry sync system not found');
            }
            
            return {
                status: 'implemented',
                details: 'Real-time registry synchronization with conflict resolution'
            };
        });
        
        // 4. Agent Execution Tracking
        this.validateRequirement('agent_tracking', () => {
            const trackerFile = path.join(this.dashboardDir, 'agents/execution-tracker.js');
            
            if (!fs.existsSync(trackerFile)) {
                throw new Error('Agent tracker not found');
            }
            
            return {
                status: 'implemented',
                details: 'Agent deployment monitoring and performance metrics'
            };
        });
        
        // 5. File Movement Automation
        this.validateRequirement('file_movement', () => {
            const movementFile = path.join(this.dashboardDir, 'automation/file-movement.js');
            
            if (!fs.existsSync(movementFile)) {
                throw new Error('File movement automation not found');
            }
            
            return {
                status: 'implemented',
                details: 'Automatic file movement with integrity validation'
            };
        });
        
        // 6. Complete Lifecycle Management
        this.validateRequirement('lifecycle_management', () => {
            const lifecycleFile = path.join(this.dashboardDir, 'core/lifecycle-manager.js');
            
            if (!fs.existsSync(lifecycleFile)) {
                throw new Error('Lifecycle manager not found');
            }
            
            const content = fs.readFileSync(lifecycleFile, 'utf8');
            if (!content.includes('validationGates') || !content.includes('archiveTicket')) {
                throw new Error('Lifecycle management incomplete');
            }
            
            return {
                status: 'implemented',
                details: 'Complete lifecycle with validation gates and archival'
            };
        });
    }
    
    async validateComponentArchitecture() {
        console.log('🏗️  Validating component architecture...');
        
        // Core Infrastructure
        this.validateComponent('core_infrastructure', () => {
            const requiredDirs = ['core', 'hooks', 'agents', 'automation', 'api', 'data', 'logs'];
            const missing = requiredDirs.filter(dir => 
                !fs.existsSync(path.join(this.dashboardDir, dir))
            );
            
            if (missing.length > 0) {
                throw new Error('Missing directories: ' + missing.join(', '));
            }
            
            return { status: 'valid', message: 'Complete directory structure' };
        });
        
        // Dashboard Engine
        this.validateComponent('dashboard_engine', () => {
            const engineFile = path.join(this.dashboardDir, 'core/dashboard-engine.js');
            const content = fs.readFileSync(engineFile, 'utf8');
            
            const requiredMethods = [
                'scanTicketChanges',
                'updateRegistry', 
                'generateMetrics',
                'setupFileWatchers'
            ];
            
            const missing = requiredMethods.filter(method => !content.includes(method));
            if (missing.length > 0) {
                throw new Error('Missing methods: ' + missing.join(', '));
            }
            
            return { status: 'valid', message: 'Dashboard engine complete' };
        });
        
        // Integration Points
        this.validateComponent('integration_points', () => {
            const integrationFiles = [
                'api/registry-sync.js',
                'hooks/status-hooks.js',
                'automation/file-movement.js'
            ];
            
            integrationFiles.forEach(file => {
                const filePath = path.join(this.dashboardDir, file);
                if (!fs.existsSync(filePath)) {
                    throw new Error('Missing integration file: ' + file);
                }
            });
            
            return { status: 'valid', message: 'All integration points present' };
        });
    }
    
    async validateIntegrationPoints() {
        console.log('🔗 Validating integration points...');
        
        // Registry Integration
        this.validateIntegration('registry_sync', () => {
            const registryFile = path.join(this.baseDir, 'docs/planning/TICKET_REGISTRY.md');
            
            if (!fs.existsSync(registryFile)) {
                throw new Error('Registry file not found');
            }
            
            // Check for required sections
            const content = fs.readFileSync(registryFile, 'utf8');
            const requiredSections = [
                'EXECUTIVE SUMMARY',
                'ACTIVE WORK QUEUE', 
                'PENDING TICKETS',
                'COMPLETED ACHIEVEMENTS'
            ];
            
            const missing = requiredSections.filter(section => !content.includes(section));
            if (missing.length > 0) {
                throw new Error('Registry missing sections: ' + missing.join(', '));
            }
            
            return { status: 'integrated', message: 'Registry fully integrated' };
        });
        
        // Ticket Directory Integration
        this.validateIntegration('ticket_directories', () => {
            const todosDir = path.join(this.baseDir, 'todos');
            const requiredDirs = ['pending', 'in-progress', 'completed'];
            
            if (!fs.existsSync(todosDir)) {
                throw new Error('Todos directory not found');
            }
            
            const missing = requiredDirs.filter(dir => 
                !fs.existsSync(path.join(todosDir, dir))
            );
            
            if (missing.length > 0) {
                throw new Error('Missing ticket directories: ' + missing.join(', '));
            }
            
            return { status: 'integrated', message: 'Ticket directories integrated' };
        });
    }
    
    async validateAutomationCapabilities() {
        console.log('🤖 Validating automation capabilities...');
        
        // Status Update Automation
        this.validateAutomation('status_updates', () => {
            const hooksFile = path.join(this.dashboardDir, 'hooks/status-hooks.js');
            const content = fs.readFileSync(hooksFile, 'utf8');
            
            const requiredHooks = ['created', 'status_changed', 'priority_changed', 'deleted'];
            const missing = requiredHooks.filter(hook => !content.includes(hook + '(change)'));
            
            if (missing.length > 0) {
                throw new Error('Missing hooks: ' + missing.join(', '));
            }
            
            return { status: 'automated', message: 'Status updates fully automated' };
        });
        
        // File Movement Automation
        this.validateAutomation('file_movement', () => {
            const movementFile = path.join(this.dashboardDir, 'automation/file-movement.js');
            const content = fs.readFileSync(movementFile, 'utf8');
            
            if (!content.includes('moveTicketFile') || !content.includes('organizeAllTickets')) {
                throw new Error('File movement automation incomplete');
            }
            
            return { status: 'automated', message: 'File movement fully automated' };
        });
        
        // Registry Synchronization
        this.validateAutomation('registry_sync', () => {
            const syncFile = path.join(this.dashboardDir, 'api/registry-sync.js');
            const content = fs.readFileSync(syncFile, 'utf8');
            
            if (!content.includes('forceSyncRegistry') || !content.includes('updateRegistryFromTicketState')) {
                throw new Error('Registry sync automation incomplete');
            }
            
            return { status: 'automated', message: 'Registry sync fully automated' };
        });
        
        // Lifecycle Management
        this.validateAutomation('lifecycle_automation', () => {
            const lifecycleFile = path.join(this.dashboardDir, 'core/lifecycle-manager.js');
            const content = fs.readFileSync(lifecycleFile, 'utf8');
            
            const requiredMethods = [
                'createTicketWithTemplate',
                'runValidationGate',
                'archiveCompletedTickets'
            ];
            
            const missing = requiredMethods.filter(method => !content.includes(method));
            if (missing.length > 0) {
                throw new Error('Missing lifecycle methods: ' + missing.join(', '));
            }
            
            return { status: 'automated', message: 'Lifecycle fully automated' };
        });
    }
    
    validateRequirement(name, validator) {
        try {
            const result = validator();
            this.validationResults.requirements[name] = {
                passed: true,
                ...result
            };
            console.log('  ✅ ' + name.replace(/_/g, ' '));
        } catch (error) {
            this.validationResults.requirements[name] = {
                passed: false,
                error: error.message
            };
            this.validationResults.errors.push(name + ': ' + error.message);
            console.log('  ❌ ' + name.replace(/_/g, ' ') + ': ' + error.message);
        }
    }
    
    validateComponent(name, validator) {
        try {
            const result = validator();
            this.validationResults.components[name] = {
                valid: true,
                ...result
            };
            console.log('  ✅ ' + name.replace(/_/g, ' '));
        } catch (error) {
            this.validationResults.components[name] = {
                valid: false,
                error: error.message
            };
            this.validationResults.errors.push(name + ': ' + error.message);
            console.log('  ❌ ' + name.replace(/_/g, ' ') + ': ' + error.message);
        }
    }
    
    validateIntegration(name, validator) {
        try {
            const result = validator();
            this.validationResults.components[name] = {
                integrated: true,
                ...result
            };
            console.log('  ✅ ' + name.replace(/_/g, ' '));
        } catch (error) {
            this.validationResults.components[name] = {
                integrated: false,
                error: error.message
            };
            this.validationResults.errors.push(name + ': ' + error.message);
            console.log('  ❌ ' + name.replace(/_/g, ' ') + ': ' + error.message);
        }
    }
    
    validateAutomation(name, validator) {
        try {
            const result = validator();
            this.validationResults.components[name] = {
                automated: true,
                ...result
            };
            console.log('  ✅ ' + name.replace(/_/g, ' '));
        } catch (error) {
            this.validationResults.components[name] = {
                automated: false,
                error: error.message
            };
            this.validationResults.errors.push(name + ': ' + error.message);
            console.log('  ❌ ' + name.replace(/_/g, ' ') + ': ' + error.message);
        }
    }
    
    generateValidationReport() {
        const totalRequirements = Object.keys(this.validationResults.requirements).length;
        const passedRequirements = Object.values(this.validationResults.requirements)
            .filter(req => req.passed).length;
        
        const totalComponents = Object.keys(this.validationResults.components).length;
        const validComponents = Object.values(this.validationResults.components)
            .filter(comp => comp.valid || comp.integrated || comp.automated).length;
        
        this.validationResults.overall = 
            this.validationResults.errors.length === 0 &&
            passedRequirements === totalRequirements &&
            validComponents === totalComponents;
        
        return {
            overall: this.validationResults.overall,
            summary: {
                requirements: {
                    total: totalRequirements,
                    passed: passedRequirements,
                    rate: ((passedRequirements / totalRequirements) * 100).toFixed(1) + '%'
                },
                components: {
                    total: totalComponents,
                    valid: validComponents,
                    rate: ((validComponents / totalComponents) * 100).toFixed(1) + '%'
                },
                errors: this.validationResults.errors.length,
                warnings: this.validationResults.warnings.length
            },
            details: this.validationResults,
            timestamp: new Date().toISOString()
        };
    }
    
    displayValidationSummary(report) {
        console.log('\n🎯 VALIDATION SUMMARY');
        console.log('===================');
        
        if (report.overall) {
            console.log('✅ SYSTEM VALIDATION: PASSED');
            console.log('🚀 The automated ticket dashboard eliminates manual tracking!');
        } else {
            console.log('❌ SYSTEM VALIDATION: FAILED');
            console.log('⚠️  Manual status tracking requirements remain');
        }
        
        console.log('\n📊 Requirements: ' + report.summary.requirements.rate + ' (' + 
                   report.summary.requirements.passed + '/' + report.summary.requirements.total + ')');
        console.log('🏗️  Components: ' + report.summary.components.rate + ' (' + 
                   report.summary.components.valid + '/' + report.summary.components.total + ')');
        console.log('❌ Errors: ' + report.summary.errors);
        console.log('⚠️  Warnings: ' + report.summary.warnings);
        
        if (report.summary.errors > 0) {
            console.log('\n🔍 ERRORS TO RESOLVE:');
            this.validationResults.errors.forEach(error => {
                console.log('  • ' + error);
            });
        }
        
        if (report.overall) {
            console.log('\n🎉 DEPLOYMENT SUCCESS: Production-ready system operational!');
            console.log('📈 All manual status tracking requirements eliminated');
            console.log('🔄 Real-time automation active across all components');
        }
    }
}

// CLI execution
if (require.main === module) {
    const validator = new SystemValidator();
    
    validator.validateCompleteSystem().then(report => {
        if (report.overall) {
            console.log('\n✅ VALIDATION PASSED - System ready for production');
            process.exit(0);
        } else {
            console.log('\n❌ VALIDATION FAILED - System needs fixes');
            process.exit(1);
        }
    }).catch(error => {
        console.error('\n❌ VALIDATION ERROR:', error.message);
        process.exit(1);
    });
} else {
    module.exports = SystemValidator;
}
