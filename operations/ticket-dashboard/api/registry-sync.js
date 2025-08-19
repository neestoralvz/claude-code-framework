/**
 * REGISTRY INTEGRATION SYSTEM
 * 
 * Real-time registry synchronization with conflict resolution
 * and automatic metrics recalculation triggers.
 */

const fs = require('fs');
const path = require('path');

class RegistrySync {
    constructor() {
        this.baseDir = '/Users/nalve/.claude';
        this.registryFile = path.join(this.baseDir, 'planning/TICKET_REGISTRY.md');
        this.dashboardDir = path.join(this.baseDir, 'operations/ticket-dashboard');
        this.logFile = path.join(this.dashboardDir, 'logs/registry-sync.log');
        
        this.setupLogging();
        this.initializeSync();
    }
    
    setupLogging() {
        const logsDir = path.dirname(this.logFile);
        if (!fs.existsSync(logsDir)) {
            fs.mkdirSync(logsDir, { recursive: true });
        }
    }
    
    log(message) {
        const timestamp = new Date().toISOString();
        const logEntry = `${timestamp} - ${message}\n`;
        fs.appendFileSync(this.logFile, logEntry);
        console.log(`🔄 ${message}`);
    }
    
    forceSyncRegistry() {
        this.log('Force synchronization requested');
        
        const ticketState = this.loadTicketState();
        if (ticketState) {
            this.updateRegistryFromTicketState(ticketState);
            this.triggerMetricsRecalculation(ticketState);
        } else {
            this.log('No ticket state available for sync');
        }
    }
    
    loadTicketState() {
        const stateFile = path.join(this.dashboardDir, 'cache/ticket-state.json');
        if (fs.existsSync(stateFile)) {
            try {
                return JSON.parse(fs.readFileSync(stateFile, 'utf8'));
            } catch (error) {
                this.log(`Error loading ticket state: ${error.message}`);
            }
        }
        return null;
    }
}

module.exports = RegistrySync;
