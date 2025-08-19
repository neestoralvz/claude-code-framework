#!/usr/bin/env node

/**
 * AUTOMATED TICKET STATUS TRACKING DASHBOARD ENGINE
 * 
 * Production-ready real-time dashboard system that eliminates manual status tracking
 * through automated hooks, registry synchronization, and lifecycle management.
 */

const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

class TicketDashboardEngine {
    constructor() {
        this.baseDir = '/Users/nalve/.claude';
        this.dashboardDir = path.join(this.baseDir, 'operations/ticket-dashboard');
        this.todosDir = path.join(this.baseDir, 'todos');
        this.registryFile = path.join(this.baseDir, 'planning/TICKET_REGISTRY.md');
        
        this.statusMap = {
            'pending': '⏳',
            'in_progress': '🔄', 
            'completed': '✅',
            'resolved': '✔️',
            'blocked': '🚫',
            'archived': '📦'
        };
        
        this.priorityMap = {
            'critical': '🔥',
            'high': '🔴',
            'medium': '🟡',
            'low': '🟢'
        };
        
        this.init();
    }
    
    init() {
        this.setupDirectories();
        this.loadConfiguration();
        this.startStatusMonitor();
    }
    
    setupDirectories() {
        const dirs = [
            'core', 'hooks', 'agents', 'automation', 'api',
            'data', 'logs', 'cache', 'reports', 'metrics'
        ];
        
        dirs.forEach(dir => {
            const fullPath = path.join(this.dashboardDir, dir);
            if (!fs.existsSync(fullPath)) {
                fs.mkdirSync(fullPath, { recursive: true });
            }
        });
    }
    
    loadConfiguration() {
        this.config = {
            refreshInterval: 5000, // 5 seconds
            autoSave: true,
            enableHooks: true,
            trackAgents: true,
            autoFileMovement: true,
            auditTrail: true,
            realTimeSync: true
        };
        
        const configFile = path.join(this.dashboardDir, 'core/config.json');
        if (fs.existsSync(configFile)) {
            const savedConfig = JSON.parse(fs.readFileSync(configFile, 'utf8'));
            this.config = { ...this.config, ...savedConfig };
        } else {
            this.saveConfiguration();
        }
    }
    
    saveConfiguration() {
        const configFile = path.join(this.dashboardDir, 'core/config.json');
        fs.writeFileSync(configFile, JSON.stringify(this.config, null, 2));
    }
    
    startStatusMonitor() {
        console.log('🚀 Starting Automated Ticket Dashboard Engine...');
        
        this.monitorInterval = setInterval(() => {
            this.scanTicketChanges();
            this.updateRegistry();
            this.generateMetrics();
        }, this.config.refreshInterval);
        
        // Setup file watchers for real-time updates
        this.setupFileWatchers();
        
        console.log('✅ Dashboard Engine is running - monitoring for ticket changes...');
    }
    
    setupFileWatchers() {
        if (!fs.existsSync(this.todosDir)) return;
        
        fs.watch(this.todosDir, { recursive: true }, (eventType, filename) => {
            if (filename && filename.endsWith('.md')) {
                console.log(`📁 Detected change in: ${filename}`);
                setTimeout(() => {
                    this.processTicketChange(filename);
                }, 1000); // Debounce
            }
        });
    }
    
    scanTicketChanges() {
        if (!fs.existsSync(this.todosDir)) return;
        
        const ticketFiles = this.getTicketFiles();
        const currentState = this.analyzeTicketState(ticketFiles);
        
        // Compare with cached state
        const cacheFile = path.join(this.dashboardDir, 'cache/ticket-state.json');
        let previousState = {};
        
        if (fs.existsSync(cacheFile)) {
            previousState = JSON.parse(fs.readFileSync(cacheFile, 'utf8'));
        }
        
        // Detect changes
        const changes = this.detectChanges(previousState, currentState);
        
        if (changes.length > 0) {
            console.log(`🔄 Detected ${changes.length} ticket changes`);
            this.processChanges(changes);
            this.saveTicketState(currentState);
        }
    }
    
    getTicketFiles() {
        const ticketFiles = [];
        const dirs = ['pending', 'in-progress', 'completed'];
        
        dirs.forEach(dir => {
            const dirPath = path.join(this.todosDir, dir);
            if (fs.existsSync(dirPath)) {
                const files = fs.readdirSync(dirPath)
                    .filter(f => f.endsWith('.md'))
                    .map(f => ({
                        path: path.join(dirPath, f),
                        dir: dir,
                        filename: f,
                        status: dir.replace('-', '_')
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
                lastUpdate: new Date().toISOString()
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
            updated: frontmatter.updated || new Date().toISOString(),
            path: file.path,
            directory: file.dir
        };
    }
    
    detectChanges(previousState, currentState) {
        const changes = [];
        
        // Check for new tickets
        Object.keys(currentState.tickets).forEach(id => {
            if (!previousState.tickets || !previousState.tickets[id]) {
                changes.push({
                    type: 'created',
                    ticket: currentState.tickets[id],
                    timestamp: new Date().toISOString()
                });
            } else {
                // Check for status changes
                const prev = previousState.tickets[id];
                const current = currentState.tickets[id];
                
                if (prev.status !== current.status) {
                    changes.push({
                        type: 'status_changed',
                        ticket: current,
                        previousStatus: prev.status,
                        newStatus: current.status,
                        timestamp: new Date().toISOString()
                    });
                }
                
                if (prev.priority !== current.priority) {
                    changes.push({
                        type: 'priority_changed',
                        ticket: current,
                        previousPriority: prev.priority,
                        newPriority: current.priority,
                        timestamp: new Date().toISOString()
                    });
                }
            }
        });
        
        // Check for deleted tickets
        if (previousState.tickets) {
            Object.keys(previousState.tickets).forEach(id => {
                if (!currentState.tickets[id]) {
                    changes.push({
                        type: 'deleted',
                        ticket: previousState.tickets[id],
                        timestamp: new Date().toISOString()
                    });
                }
            });
        }
        
        return changes;
    }
    
    processChanges(changes) {
        changes.forEach(change => {
            this.logChange(change);
            this.executeHooks(change);
            
            if (this.config.autoFileMovement) {
                this.handleFileMovement(change);
            }
        });
    }
    
    logChange(change) {
        const logFile = path.join(this.dashboardDir, 'logs/changes.log');
        const logEntry = `${change.timestamp} - ${change.type}: ${change.ticket.id} - ${change.ticket.title}\n`;
        
        fs.appendFileSync(logFile, logEntry);
        
        if (this.config.auditTrail) {
            this.updateAuditTrail(change);
        }
    }
    
    executeHooks(change) {
        if (!this.config.enableHooks) return;
        
        const hookFile = path.join(this.dashboardDir, 'hooks/status-hooks.js');
        if (fs.existsSync(hookFile)) {
            try {
                const hooks = require(hookFile);
                if (hooks[change.type]) {
                    hooks[change.type](change);
                }
            } catch (error) {
                console.error('❌ Hook execution error:', error.message);
            }
        }
    }
    
    handleFileMovement(change) {
        if (change.type === 'status_changed') {
            this.moveTicketFile(change.ticket, change.previousStatus, change.newStatus);
        }
    }
    
    moveTicketFile(ticket, fromStatus, toStatus) {
        const fromDir = this.statusToDirectory(fromStatus);
        const toDir = this.statusToDirectory(toStatus);
        
        const oldPath = path.join(this.todosDir, fromDir, path.basename(ticket.path));
        const newPath = path.join(this.todosDir, toDir, path.basename(ticket.path));
        
        if (fs.existsSync(oldPath) && fromDir !== toDir) {
            try {
                // Ensure target directory exists
                const targetDir = path.dirname(newPath);
                if (!fs.existsSync(targetDir)) {
                    fs.mkdirSync(targetDir, { recursive: true });
                }
                
                // Update frontmatter with new status and timestamp
                let content = fs.readFileSync(oldPath, 'utf8');
                content = this.updateTicketFrontmatter(content, {
                    status: toStatus,
                    updated: new Date().toISOString()
                });
                
                // Write to new location
                fs.writeFileSync(newPath, content);
                
                // Remove old file
                fs.unlinkSync(oldPath);
                
                console.log(`📁 Moved ticket ${ticket.id} from ${fromDir}/ to ${toDir}/`);
                
            } catch (error) {
                console.error(`❌ Error moving ticket file: ${error.message}`);
            }
        }
    }
    
    statusToDirectory(status) {
        const dirMap = {
            'pending': 'pending',
            'in_progress': 'in-progress',
            'completed': 'completed',
            'resolved': 'completed',
            'blocked': 'pending',
            'archived': 'completed'
        };
        
        return dirMap[status] || 'pending';
    }
    
    updateTicketFrontmatter(content, updates) {
        const frontmatterMatch = content.match(/^---\n([\s\S]*?)\n---/);
        
        if (frontmatterMatch) {
            let frontmatter = frontmatterMatch[1];
            
            Object.keys(updates).forEach(key => {
                const regex = new RegExp(`^${key}:.*$`, 'm');
                if (regex.test(frontmatter)) {
                    frontmatter = frontmatter.replace(regex, `${key}: "${updates[key]}"`);
                } else {
                    frontmatter += `\n${key}: "${updates[key]}"`;
                }
            });
            
            return content.replace(/^---\n[\s\S]*?\n---/, `---\n${frontmatter}\n---`);
        } else {
            // Add frontmatter if it doesn't exist
            const newFrontmatter = Object.keys(updates)
                .map(key => `${key}: "${updates[key]}"`)
                .join('\n');
            return `---\n${newFrontmatter}\n---\n\n${content}`;
        }
    }
    
    updateRegistry() {
        if (!this.config.realTimeSync) return;
        
        try {
            const state = this.loadTicketState();
            if (!state) return;
            
            this.synchronizeRegistry(state);
            
        } catch (error) {
            console.error('❌ Registry update error:', error.message);
        }
    }
    
    synchronizeRegistry(state) {
        if (!fs.existsSync(this.registryFile)) return;
        
        let content = fs.readFileSync(this.registryFile, 'utf8');
        
        // Update executive summary metrics
        content = this.updateRegistryMetrics(content, state);
        
        // Update timestamp
        content = content.replace(
            /last_review: ".*?"/,
            `last_review: "${new Date().toISOString().split('T')[0]}"`
        );
        
        fs.writeFileSync(this.registryFile, content);
        console.log('✅ Registry synchronized with current ticket state');
    }
    
    updateRegistryMetrics(content, state) {
        const total = state.summary.total;
        const completed = state.summary.byStatus.completed || 0;
        const resolved = state.summary.byStatus.resolved || 0;
        const inProgress = state.summary.byStatus.in_progress || 0;
        const pending = state.summary.byStatus.pending || 0;
        
        const completionRate = total > 0 ? ((completed + resolved) / total * 100).toFixed(1) : 0;
        
        // Update the metrics table
        const metricsPattern = /(\| Status \| Count \| Percentage \| Progress \|[\s\S]*?\| \*\*TOTAL\*\* \| \*\*\d+\*\* \| \*\*100%\*\* \| \*\*[^*]+\*\* \|)/;
        
        const newMetrics = `| Status | Count | Percentage | Progress |
|--------|-------|------------|----------|
| ✅ **Completed** | **${completed}** | **${(completed/total*100).toFixed(1)}%** | Major system components operational |
| ✔️ **Resolved** | **${resolved}** | **${(resolved/total*100).toFixed(1)}%** | Workflow optimizations complete |
| 🔄 **In Progress** | **${inProgress}** | **${(inProgress/total*100).toFixed(1)}%** | Active development in progress |
| ⏳ **Pending** | **${pending}** | **${(pending/total*100).toFixed(1)}%** | Queued for execution |
| **TOTAL** | **${total}** | **100%** | **System completion ${completionRate}%** |`;
        
        if (metricsPattern.test(content)) {
            content = content.replace(metricsPattern, newMetrics);
        }
        
        return content;
    }
    
    generateMetrics() {
        const state = this.loadTicketState();
        if (!state) return;
        
        const metrics = {
            timestamp: new Date().toISOString(),
            summary: state.summary,
            trends: this.calculateTrends(state),
            performance: this.calculatePerformance(state)
        };
        
        const metricsFile = path.join(this.dashboardDir, 'metrics/current.json');
        fs.writeFileSync(metricsFile, JSON.stringify(metrics, null, 2));
        
        // Generate daily metrics archive
        const date = new Date().toISOString().split('T')[0];
        const archiveFile = path.join(this.dashboardDir, 'metrics', `${date}.json`);
        fs.writeFileSync(archiveFile, JSON.stringify(metrics, null, 2));
    }
    
    calculateTrends(state) {
        // Load historical data and calculate trends
        const metricsDir = path.join(this.dashboardDir, 'metrics');
        const files = fs.readdirSync(metricsDir)
            .filter(f => f.match(/^\d{4}-\d{2}-\d{2}\.json$/))
            .sort()
            .slice(-7); // Last 7 days
            
        const trends = {
            completionRate: [],
            ticketVelocity: [],
            avgTimeToComplete: []
        };
        
        files.forEach(file => {
            try {
                const data = JSON.parse(fs.readFileSync(path.join(metricsDir, file), 'utf8'));
                const total = data.summary.total;
                const completed = (data.summary.byStatus.completed || 0) + (data.summary.byStatus.resolved || 0);
                
                trends.completionRate.push({
                    date: file.replace('.json', ''),
                    rate: total > 0 ? (completed / total * 100) : 0
                });
            } catch (error) {
                // Skip invalid files
            }
        });
        
        return trends;
    }
    
    calculatePerformance(state) {
        return {
            totalTickets: state.summary.total,
            completionRate: Object.keys(state.summary.byStatus).reduce((acc, status) => {
                if (status === 'completed' || status === 'resolved') {
                    acc += state.summary.byStatus[status];
                }
                return acc;
            }, 0) / state.summary.total * 100,
            activeTickets: (state.summary.byStatus.in_progress || 0) + (state.summary.byStatus.pending || 0),
            lastUpdate: state.summary.lastUpdate
        };
    }
    
    updateAuditTrail(change) {
        const auditFile = path.join(this.dashboardDir, 'data/audit-trail.json');
        let auditData = [];
        
        if (fs.existsSync(auditFile)) {
            auditData = JSON.parse(fs.readFileSync(auditFile, 'utf8'));
        }
        
        auditData.push({
            id: `audit_${Date.now()}`,
            change: change,
            timestamp: new Date().toISOString(),
            source: 'automated_dashboard'
        });
        
        // Keep only last 1000 entries
        if (auditData.length > 1000) {
            auditData = auditData.slice(-1000);
        }
        
        fs.writeFileSync(auditFile, JSON.stringify(auditData, null, 2));
    }
    
    loadTicketState() {
        const cacheFile = path.join(this.dashboardDir, 'cache/ticket-state.json');
        if (fs.existsSync(cacheFile)) {
            return JSON.parse(fs.readFileSync(cacheFile, 'utf8'));
        }
        return null;
    }
    
    saveTicketState(state) {
        const cacheFile = path.join(this.dashboardDir, 'cache/ticket-state.json');
        fs.writeFileSync(cacheFile, JSON.stringify(state, null, 2));
    }
    
    processTicketChange(filename) {
        console.log(`🔄 Processing ticket change: ${filename}`);
        this.scanTicketChanges();
    }
    
    stop() {
        if (this.monitorInterval) {
            clearInterval(this.monitorInterval);
            console.log('🛑 Dashboard Engine stopped');
        }
    }
    
    // API Methods for external integration
    getStatus() {
        const state = this.loadTicketState();
        return state ? state.summary : null;
    }
    
    getTicketById(id) {
        const state = this.loadTicketState();
        return state && state.tickets ? state.tickets[id] : null;
    }
    
    getAllTickets() {
        const state = this.loadTicketState();
        return state ? state.tickets : {};
    }
    
    forceSync() {
        this.scanTicketChanges();
        this.updateRegistry();
        this.generateMetrics();
        console.log('✅ Force sync completed');
    }
}

// Export for module usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = TicketDashboardEngine;
}

// CLI execution
if (require.main === module) {
    const dashboard = new TicketDashboardEngine();
    
    // Handle graceful shutdown
    process.on('SIGINT', () => {
        console.log('\n🛑 Shutting down dashboard engine...');
        dashboard.stop();
        process.exit(0);
    });
    
    process.on('SIGTERM', () => {
        dashboard.stop();
        process.exit(0);
    });
    
    // Keep the process running
    process.on('uncaughtException', (error) => {
        console.error('❌ Uncaught exception:', error);
    });
    
    process.on('unhandledRejection', (reason, promise) => {
        console.error('❌ Unhandled rejection at:', promise, 'reason:', reason);
    });
}
