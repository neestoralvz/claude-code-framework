#!/usr/bin/env node

/**
 * DOCKER INTEGRATION SCRIPT
 * 
 * Handles seamless integration between containerized dashboard and host Claude system
 * Manages data synchronization, file mounting, and real-time communication
 */

const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

class DockerIntegration {
    constructor() {
        this.claudeBaseDir = process.env.CLAUDE_DATA_DIR || '/Users/nalve/.claude';
        this.containerDataDir = process.env.CLAUDE_BASE_DIR || '/claude-data';
        this.dashboardDir = '/app';
        
        this.integrationConfig = {
            syncInterval: 5000,
            enableRealTimeSync: true,
            enableFileWatching: true,
            enableBackups: true,
            validateIntegrity: true
        };
        
        this.init();
    }
    
    init() {
        console.log('🔗 Initializing Docker Integration...');
        this.loadIntegrationConfig();
        this.setupDataMounts();
        this.startSynchronization();
        this.setupHealthMonitoring();
    }
    
    loadIntegrationConfig() {
        const configFile = path.join(this.dashboardDir, 'core/integration-config.json');
        
        if (fs.existsSync(configFile)) {
            try {
                const config = JSON.parse(fs.readFileSync(configFile, 'utf8'));
                this.integrationConfig = { ...this.integrationConfig, ...config };
                console.log('✅ Integration configuration loaded');
            } catch (error) {
                console.warn('⚠️  Failed to load integration config, using defaults');
            }
        }
    }
    
    setupDataMounts() {
        console.log('📁 Setting up data mount integration...');
        
        try {
            // Verify Claude data directory is mounted
            if (!fs.existsSync(this.containerDataDir)) {
                throw new Error('Claude data directory not mounted');
            }
            
            // Check critical Claude directories
            const criticalDirs = ['todos', 'docs', 'operations'];
            const missingDirs = criticalDirs.filter(dir => 
                !fs.existsSync(path.join(this.containerDataDir, dir))
            );
            
            if (missingDirs.length > 0) {
                console.warn('⚠️  Missing Claude directories:', missingDirs.join(', '));
            }
            
            // Create symlinks for easier access
            this.createDataSymlinks();
            
            console.log('✅ Data mount integration verified');
            
        } catch (error) {
            console.error('❌ Data mount setup failed:', error.message);
            throw error;
        }
    }
    
    createDataSymlinks() {
        const symlinks = [
            { source: path.join(this.containerDataDir, 'todos'), target: '/app/linked-todos' },
            { source: path.join(this.containerDataDir, 'docs'), target: '/app/linked-docs' },
            { source: path.join(this.containerDataDir, 'operations'), target: '/app/linked-operations' }
        ];
        
        symlinks.forEach(({ source, target }) => {
            try {
                if (fs.existsSync(source) && !fs.existsSync(target)) {
                    fs.symlinkSync(source, target);
                    console.log(`🔗 Created symlink: ${target} -> ${source}`);
                }
            } catch (error) {
                // Symlink creation may fail in some Docker configurations
                console.warn(`⚠️  Could not create symlink ${target}:`, error.message);
            }
        });
    }
    
    startSynchronization() {
        if (!this.integrationConfig.enableRealTimeSync) {
            console.log('🔄 Real-time sync disabled');
            return;
        }
        
        console.log('🔄 Starting real-time synchronization...');
        
        // Start periodic sync
        this.syncInterval = setInterval(() => {
            this.performDataSync();
        }, this.integrationConfig.syncInterval);
        
        // Setup file watchers if enabled
        if (this.integrationConfig.enableFileWatching) {
            this.setupFileWatchers();
        }
        
        console.log('✅ Real-time synchronization started');
    }
    
    setupFileWatchers() {
        try {
            const todosDir = path.join(this.containerDataDir, 'todos');
            const registryFile = path.join(this.containerDataDir, 'docs/planning/TICKET_REGISTRY.md');
            
            // Watch todos directory
            if (fs.existsSync(todosDir)) {
                fs.watch(todosDir, { recursive: true }, (eventType, filename) => {
                    if (filename && filename.endsWith('.md')) {
                        console.log(`📁 Detected ticket change: ${filename}`);
                        this.handleTicketChange(filename);
                    }
                });
            }
            
            // Watch registry file
            if (fs.existsSync(registryFile)) {
                fs.watch(registryFile, (eventType) => {
                    console.log(`📋 Registry change detected: ${eventType}`);
                    this.handleRegistryChange();
                });
            }
            
            console.log('👁️  File watchers active');
            
        } catch (error) {
            console.warn('⚠️  File watcher setup failed:', error.message);
        }
    }
    
    performDataSync() {
        try {
            // Sync ticket state from host to container
            this.syncTicketState();
            
            // Sync registry updates
            this.syncRegistryUpdates();
            
            // Validate data integrity
            if (this.integrationConfig.validateIntegrity) {
                this.validateDataIntegrity();
            }
            
        } catch (error) {
            console.error('❌ Sync error:', error.message);
        }
    }
    
    syncTicketState() {
        try {
            const hostTicketsDir = path.join(this.containerDataDir, 'todos');
            
            if (!fs.existsSync(hostTicketsDir)) {
                return;
            }
            
            // Scan for ticket changes
            const ticketFiles = this.scanTicketFiles(hostTicketsDir);
            const currentState = this.analyzeTicketState(ticketFiles);
            
            // Update container state
            const stateFile = path.join(this.dashboardDir, 'cache/ticket-state.json');
            fs.writeFileSync(stateFile, JSON.stringify(currentState, null, 2));
            
            // Update sync timestamp
            const syncFile = path.join(this.dashboardDir, 'cache/last-sync.json');
            fs.writeFileSync(syncFile, JSON.stringify({
                timestamp: new Date().toISOString(),
                ticketCount: Object.keys(currentState.tickets || {}).length,
                source: 'docker-integration'
            }, null, 2));
            
        } catch (error) {
            console.error('❌ Ticket state sync failed:', error.message);
        }
    }
    
    syncRegistryUpdates() {
        try {
            const registryFile = path.join(this.containerDataDir, 'docs/planning/TICKET_REGISTRY.md');
            
            if (!fs.existsSync(registryFile)) {
                return;
            }
            
            // Read current registry state
            const registryContent = fs.readFileSync(registryFile, 'utf8');
            
            // Cache registry content for dashboard access
            const registryCache = path.join(this.dashboardDir, 'cache/registry-content.json');
            fs.writeFileSync(registryCache, JSON.stringify({
                content: registryContent,
                lastUpdate: new Date().toISOString(),
                size: registryContent.length
            }, null, 2));
            
        } catch (error) {
            console.error('❌ Registry sync failed:', error.message);
        }
    }
    
    scanTicketFiles(todosDir) {
        const ticketFiles = [];
        const dirs = ['pending', 'in-progress', 'completed'];
        
        dirs.forEach(dir => {
            const dirPath = path.join(todosDir, dir);
            if (fs.existsSync(dirPath)) {
                const files = fs.readdirSync(dirPath)
                    .filter(f => f.endsWith('.md'))
                    .map(f => ({
                        path: path.join(dirPath, f),
                        dir: dir,
                        filename: f,
                        status: dir.replace('-', '_'),
                        lastModified: fs.statSync(path.join(dirPath, f)).mtime
                    }));
                ticketFiles.push(...files);
            }
        });
        
        return ticketFiles;
    }
    
    analyzeTicketState(ticketFiles) {
        const state = {
            tickets: {},
            summary: {
                total: 0,
                byStatus: {},
                byPriority: {},
                lastUpdate: new Date().toISOString(),
                syncSource: 'docker-integration'
            },
            integration: {
                containerDataDir: this.containerDataDir,
                syncTimestamp: new Date().toISOString(),
                fileCount: ticketFiles.length
            }
        };
        
        ticketFiles.forEach(file => {
            try {
                const content = fs.readFileSync(file.path, 'utf8');
                const ticket = this.parseTicket(content, file);
                
                state.tickets[ticket.id] = ticket;
                state.summary.total++;
                
                // Update status counts
                state.summary.byStatus[ticket.status] = 
                    (state.summary.byStatus[ticket.status] || 0) + 1;
                    
                // Update priority counts
                state.summary.byPriority[ticket.priority] = 
                    (state.summary.byPriority[ticket.priority] || 0) + 1;
                    
            } catch (error) {
                console.error(`❌ Error parsing ticket ${file.path}:`, error.message);
            }
        });
        
        return state;
    }
    
    parseTicket(content, file) {
        const frontmatterMatch = content.match(/^---\n([\s\S]*?)\n---/);
        let frontmatter = {};
        
        if (frontmatterMatch) {
            const frontmatterText = frontmatterMatch[1];
            frontmatterText.split('\n').forEach(line => {
                const match = line.match(/^(\w+):\s*(.+)$/);
                if (match) {
                    frontmatter[match[1]] = match[2].replace(/['"]/g, '');
                }
            });
        }
        
        return {
            id: frontmatter.id || file.filename.replace('.md', ''),
            title: frontmatter.title || 'Untitled',
            status: frontmatter.status || file.status,
            priority: frontmatter.priority || 'medium',
            category: frontmatter.category || 'general',
            assignee: frontmatter.assignee || 'unassigned',
            created: frontmatter.created || new Date().toISOString(),
            updated: frontmatter.updated || file.lastModified.toISOString(),
            path: file.path,
            directory: file.dir,
            containerPath: file.path.replace(this.containerDataDir, this.claudeBaseDir)
        };
    }
    
    validateDataIntegrity() {
        try {
            const checks = [
                this.validateTicketStateFile(),
                this.validateRegistryCache(),
                this.validateSyncTimestamp()
            ];
            
            const passed = checks.filter(check => check.valid).length;
            const total = checks.length;
            
            const integrityReport = {
                timestamp: new Date().toISOString(),
                passed: passed,
                total: total,
                healthy: passed === total,
                checks: checks
            };
            
            const integrityFile = path.join(this.dashboardDir, 'data/integration-integrity.json');
            fs.writeFileSync(integrityFile, JSON.stringify(integrityReport, null, 2));
            
            if (!integrityReport.healthy) {
                console.warn(`⚠️  Data integrity issues: ${passed}/${total} checks passed`);
            }
            
        } catch (error) {
            console.error('❌ Integrity validation failed:', error.message);
        }
    }
    
    validateTicketStateFile() {
        try {
            const stateFile = path.join(this.dashboardDir, 'cache/ticket-state.json');
            
            if (!fs.existsSync(stateFile)) {
                return { name: 'ticket-state', valid: false, error: 'File not found' };
            }
            
            const content = fs.readFileSync(stateFile, 'utf8');
            const state = JSON.parse(content);
            
            if (!state.tickets || !state.summary) {
                return { name: 'ticket-state', valid: false, error: 'Invalid structure' };
            }
            
            return { name: 'ticket-state', valid: true, ticketCount: Object.keys(state.tickets).length };
            
        } catch (error) {
            return { name: 'ticket-state', valid: false, error: error.message };
        }
    }
    
    validateRegistryCache() {
        try {
            const cacheFile = path.join(this.dashboardDir, 'cache/registry-content.json');
            
            if (!fs.existsSync(cacheFile)) {
                return { name: 'registry-cache', valid: false, error: 'Cache not found' };
            }
            
            const cache = JSON.parse(fs.readFileSync(cacheFile, 'utf8'));
            
            if (!cache.content || !cache.lastUpdate) {
                return { name: 'registry-cache', valid: false, error: 'Invalid cache structure' };
            }
            
            return { name: 'registry-cache', valid: true, size: cache.size };
            
        } catch (error) {
            return { name: 'registry-cache', valid: false, error: error.message };
        }
    }
    
    validateSyncTimestamp() {
        try {
            const syncFile = path.join(this.dashboardDir, 'cache/last-sync.json');
            
            if (!fs.existsSync(syncFile)) {
                return { name: 'sync-timestamp', valid: false, error: 'Sync file not found' };
            }
            
            const sync = JSON.parse(fs.readFileSync(syncFile, 'utf8'));
            const lastSync = new Date(sync.timestamp);
            const now = new Date();
            const ageMins = (now - lastSync) / (1000 * 60);
            
            if (ageMins > 10) { // Alert if sync is more than 10 minutes old
                return { name: 'sync-timestamp', valid: false, error: `Sync too old: ${ageMins.toFixed(1)} minutes` };
            }
            
            return { name: 'sync-timestamp', valid: true, ageMinutes: ageMins.toFixed(1) };
            
        } catch (error) {
            return { name: 'sync-timestamp', valid: false, error: error.message };
        }
    }
    
    handleTicketChange(filename) {
        console.log(`🎫 Processing ticket change: ${filename}`);
        
        // Trigger immediate sync
        setTimeout(() => {
            this.performDataSync();
        }, 1000);
    }
    
    handleRegistryChange() {
        console.log('📋 Processing registry change');
        
        // Trigger immediate registry sync
        setTimeout(() => {
            this.syncRegistryUpdates();
        }, 1000);
    }
    
    setupHealthMonitoring() {
        console.log('🏥 Setting up integration health monitoring...');
        
        // Health check interval
        this.healthInterval = setInterval(() => {
            this.performHealthCheck();
        }, 30000); // Every 30 seconds
    }
    
    performHealthCheck() {
        try {
            const health = {
                timestamp: new Date().toISOString(),
                integration: {
                    dataMount: fs.existsSync(this.containerDataDir),
                    syncActive: !!this.syncInterval,
                    watchersActive: true
                },
                lastSync: this.getLastSyncInfo(),
                performance: {
                    uptime: process.uptime(),
                    memory: process.memoryUsage().rss / (1024 * 1024) // MB
                }
            };
            
            const healthFile = path.join(this.dashboardDir, 'data/integration-health.json');
            fs.writeFileSync(healthFile, JSON.stringify(health, null, 2));
            
        } catch (error) {
            console.error('❌ Health check failed:', error.message);
        }
    }
    
    getLastSyncInfo() {
        try {
            const syncFile = path.join(this.dashboardDir, 'cache/last-sync.json');
            if (fs.existsSync(syncFile)) {
                return JSON.parse(fs.readFileSync(syncFile, 'utf8'));
            }
        } catch (error) {
            // Ignore errors
        }
        return null;
    }
    
    stop() {
        console.log('🛑 Stopping Docker integration...');
        
        if (this.syncInterval) {
            clearInterval(this.syncInterval);
        }
        
        if (this.healthInterval) {
            clearInterval(this.healthInterval);
        }
        
        console.log('✅ Docker integration stopped');
    }
    
    // API for external access
    getIntegrationStatus() {
        return {
            containerDataDir: this.containerDataDir,
            syncEnabled: !!this.syncInterval,
            config: this.integrationConfig,
            uptime: process.uptime()
        };
    }
}

// Export for module usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = DockerIntegration;
}

// CLI execution
if (require.main === module) {
    const integration = new DockerIntegration();
    
    // Handle graceful shutdown
    process.on('SIGINT', () => {
        console.log('\n🛑 Shutting down integration...');
        integration.stop();
        process.exit(0);
    });
    
    process.on('SIGTERM', () => {
        integration.stop();
        process.exit(0);
    });
    
    // Keep the process running
    process.stdin.resume();
}