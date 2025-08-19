/**
 * AUTOMATED STATUS UPDATE HOOKS
 * 
 * Command execution interceptors that automatically update ticket status
 * and trigger registry synchronization for real-time tracking.
 */

const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

class StatusHooks {
    constructor() {
        this.baseDir = '/Users/nalve/.claude';
        this.hooksEnabled = true;
        this.logFile = path.join(this.baseDir, 'operations/ticket-dashboard/logs/hooks.log');
        
        this.setupLogging();
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
        console.log(`🪝 ${message}`);
    }
    
    // Hook for ticket creation
    created(change) {
        this.log(`New ticket created: ${change.ticket.id} - ${change.ticket.title}`);
        
        // Auto-assign based on category
        this.autoAssignTicket(change.ticket);
        
        // Send notifications
        this.sendNotification('ticket_created', change);
        
        // Update project metrics
        this.updateMetrics('ticket_created', change);
        
        // Initialize tracking
        this.initializeTicketTracking(change.ticket);
    }
    
    // Hook for status changes
    status_changed(change) {
        this.log(`Status changed: ${change.ticket.id} (${change.previousStatus} → ${change.newStatus})`);
        
        // Handle specific status transitions
        this.handleStatusTransition(change);
        
        // Update timestamps
        this.updateTicketTimestamps(change);
        
        // Trigger automations
        this.triggerAutomations(change);
        
        // Send notifications
        this.sendNotification('status_changed', change);
        
        // Update project metrics
        this.updateMetrics('status_changed', change);
    }
    
    // Hook for priority changes
    priority_changed(change) {
        this.log(`Priority changed: ${change.ticket.id} (${change.previousPriority} → ${change.newPriority})`);
        
        // Reorder work queues
        this.reorderWorkQueues(change);
        
        // Send escalation notifications if priority increased
        if (this.isPriorityEscalation(change.previousPriority, change.newPriority)) {
            this.sendEscalationNotification(change);
        }
        
        // Update metrics
        this.updateMetrics('priority_changed', change);
    }
    
    // Hook for ticket deletion
    deleted(change) {
        this.log(`Ticket deleted: ${change.ticket.id} - ${change.ticket.title}`);
        
        // Archive ticket data
        this.archiveTicketData(change.ticket);
        
        // Clean up tracking files
        this.cleanupTicketTracking(change.ticket);
        
        // Update metrics
        this.updateMetrics('ticket_deleted', change);
    }
    
    // Auto-assignment logic
    autoAssignTicket(ticket) {
        const assignmentRules = {
            'agent-creation': 'agent-specialist',
            'audit': 'audit-specialist', 
            'optimization': 'performance-specialist',
            'integration': 'integration-specialist',
            'documentation': 'documentation-specialist',
            'testing': 'qa-specialist'
        };
        
        const assignee = assignmentRules[ticket.category] || 'general-specialist';
        
        if (assignee !== ticket.assignee) {
            this.updateTicketAssignee(ticket, assignee);
            this.log(`Auto-assigned ticket ${ticket.id} to ${assignee}`);
        }
    }
    
    // Handle specific status transitions
    handleStatusTransition(change) {
        const { previousStatus, newStatus, ticket } = change;
        
        switch (newStatus) {
            case 'in_progress':
                this.handleStartWork(ticket);
                break;
            case 'completed':
                this.handleCompletion(ticket);
                break;
            case 'blocked':
                this.handleBlocked(ticket);
                break;
            case 'archived':
                this.handleArchive(ticket);
                break;
        }
    }
    
    handleStartWork(ticket) {
        this.log(`Work started on ticket: ${ticket.id}`);
        
        // Create work session tracking
        this.startWorkSession(ticket);
        
        // Check for blockers
        this.checkForBlockers(ticket);
        
        // Set up progress monitoring
        this.setupProgressMonitoring(ticket);
    }
    
    handleCompletion(ticket) {
        this.log(`Work completed on ticket: ${ticket.id}`);
        
        // End work session tracking
        this.endWorkSession(ticket);
        
        // Run quality checks
        this.runQualityChecks(ticket);
        
        // Update dependent tickets
        this.updateDependentTickets(ticket);
        
        // Generate completion report
        this.generateCompletionReport(ticket);
    }
    
    handleBlocked(ticket) {
        this.log(`Ticket blocked: ${ticket.id}`);
        
        // Create blocking issue
        this.createBlockingIssue(ticket);
        
        // Pause work session
        this.pauseWorkSession(ticket);
        
        // Send escalation notification
        this.sendEscalationNotification({
            ticket: ticket,
            reason: 'blocked'
        });
    }
    
    handleArchive(ticket) {
        this.log(`Ticket archived: ${ticket.id}`);
        
        // Move to archive
        this.moveToArchive(ticket);
        
        // Clean up active tracking
        this.cleanupActiveTracking(ticket);
    }
    
    // Update ticket timestamps
    updateTicketTimestamps(change) {
        const { ticket, newStatus } = change;
        const timestamps = {};
        
        switch (newStatus) {
            case 'in_progress':
                timestamps.started_at = new Date().toISOString();
                break;
            case 'completed':
            case 'resolved':
                timestamps.completed_at = new Date().toISOString();
                if (ticket.started_at) {
                    const started = new Date(ticket.started_at);
                    const completed = new Date();
                    timestamps.duration_minutes = Math.round((completed - started) / (1000 * 60));
                }
                break;
            case 'blocked':
                timestamps.blocked_at = new Date().toISOString();
                break;
        }
        
        timestamps.updated = new Date().toISOString();
        
        this.updateTicketMetadata(ticket, timestamps);
    }
    
    // Update ticket metadata
    updateTicketMetadata(ticket, metadata) {
        try {
            if (!fs.existsSync(ticket.path)) return;
            
            let content = fs.readFileSync(ticket.path, 'utf8');
            
            // Update frontmatter
            Object.keys(metadata).forEach(key => {
                content = this.updateFrontmatter(content, key, metadata[key]);
            });
            
            fs.writeFileSync(ticket.path, content);
            
        } catch (error) {
            this.log(`Error updating metadata for ${ticket.id}: ${error.message}`);
        }
    }
    
    updateFrontmatter(content, key, value) {
        const frontmatterMatch = content.match(/^---\n([\s\S]*?)\n---/);
        
        if (frontmatterMatch) {
            let frontmatter = frontmatterMatch[1];
            const regex = new RegExp(`^${key}:.*$`, 'm');
            
            if (regex.test(frontmatter)) {
                frontmatter = frontmatter.replace(regex, `${key}: "${value}"`);
            } else {
                frontmatter += `\n${key}: "${value}"`;
            }
            
            return content.replace(/^---\n[\s\S]*?\n---/, `---\n${frontmatter}\n---`);
        } else {
            // Add frontmatter if it doesn't exist
            return `---\n${key}: "${value}"\n---\n\n${content}`;
        }
    }
    
    // Trigger automations based on status changes
    triggerAutomations(change) {
        const automationsFile = path.join(this.baseDir, 'operations/ticket-dashboard/automation/rules.json');
        
        if (fs.existsSync(automationsFile)) {
            try {
                const rules = JSON.parse(fs.readFileSync(automationsFile, 'utf8'));
                
                rules.forEach(rule => {
                    if (this.matchesRule(change, rule)) {
                        this.executeAutomation(rule, change);
                    }
                });
                
            } catch (error) {
                this.log(`Error processing automation rules: ${error.message}`);
            }
        }
    }
    
    matchesRule(change, rule) {
        if (rule.trigger !== change.type) return false;
        
        if (rule.conditions) {
            return rule.conditions.every(condition => {
                switch (condition.type) {
                    case 'status_equals':
                        return change.ticket.status === condition.value;
                    case 'status_changed_from':
                        return change.previousStatus === condition.value;
                    case 'status_changed_to':
                        return change.newStatus === condition.value;
                    case 'category_equals':
                        return change.ticket.category === condition.value;
                    case 'priority_equals':
                        return change.ticket.priority === condition.value;
                    default:
                        return false;
                }
            });
        }
        
        return true;
    }
    
    executeAutomation(rule, change) {
        this.log(`Executing automation: ${rule.name}`);
        
        rule.actions.forEach(action => {
            switch (action.type) {
                case 'run_command':
                    this.runCommand(action.command, change);
                    break;
                case 'create_ticket':
                    this.createFollowupTicket(action.template, change);
                    break;
                case 'update_ticket':
                    this.updateTicketField(change.ticket, action.field, action.value);
                    break;
                case 'send_notification':
                    this.sendNotification(action.event, change);
                    break;
            }
        });
    }
    
    // Work session tracking
    startWorkSession(ticket) {
        const sessionData = {
            ticket_id: ticket.id,
            started_at: new Date().toISOString(),
            status: 'active'
        };
        
        const sessionsFile = path.join(this.baseDir, 'operations/ticket-dashboard/data/work-sessions.json');
        let sessions = [];
        
        if (fs.existsSync(sessionsFile)) {
            sessions = JSON.parse(fs.readFileSync(sessionsFile, 'utf8'));
        }
        
        sessions.push(sessionData);
        fs.writeFileSync(sessionsFile, JSON.stringify(sessions, null, 2));
    }
    
    endWorkSession(ticket) {
        const sessionsFile = path.join(this.baseDir, 'operations/ticket-dashboard/data/work-sessions.json');
        
        if (fs.existsSync(sessionsFile)) {
            let sessions = JSON.parse(fs.readFileSync(sessionsFile, 'utf8'));
            
            const activeSession = sessions.find(s => s.ticket_id === ticket.id && s.status === 'active');
            
            if (activeSession) {
                activeSession.ended_at = new Date().toISOString();
                activeSession.status = 'completed';
                
                const started = new Date(activeSession.started_at);
                const ended = new Date(activeSession.ended_at);
                activeSession.duration_minutes = Math.round((ended - started) / (1000 * 60));
                
                fs.writeFileSync(sessionsFile, JSON.stringify(sessions, null, 2));
            }
        }
    }
    
    // Notification system
    sendNotification(event, change) {
        const notification = {
            id: `notify_${Date.now()}`,
            event: event,
            ticket: change.ticket,
            timestamp: new Date().toISOString(),
            details: change
        };
        
        // Save to notifications queue
        const notificationsFile = path.join(this.baseDir, 'operations/ticket-dashboard/data/notifications.json');
        let notifications = [];
        
        if (fs.existsSync(notificationsFile)) {
            notifications = JSON.parse(fs.readFileSync(notificationsFile, 'utf8'));
        }
        
        notifications.push(notification);
        
        // Keep only last 100 notifications
        if (notifications.length > 100) {
            notifications = notifications.slice(-100);
        }
        
        fs.writeFileSync(notificationsFile, JSON.stringify(notifications, null, 2));
        
        this.log(`Notification sent: ${event} for ticket ${change.ticket.id}`);
    }
    
    // Metrics updates
    updateMetrics(eventType, change) {
        const metricsFile = path.join(this.baseDir, 'operations/ticket-dashboard/data/event-metrics.json');
        let metrics = {
            events: [],
            counters: {}
        };
        
        if (fs.existsSync(metricsFile)) {
            metrics = JSON.parse(fs.readFileSync(metricsFile, 'utf8'));
        }
        
        // Add event
        metrics.events.push({
            type: eventType,
            ticket_id: change.ticket.id,
            timestamp: new Date().toISOString()
        });
        
        // Update counters
        metrics.counters[eventType] = (metrics.counters[eventType] || 0) + 1;
        
        // Keep only last 500 events
        if (metrics.events.length > 500) {
            metrics.events = metrics.events.slice(-500);
        }
        
        fs.writeFileSync(metricsFile, JSON.stringify(metrics, null, 2));
    }
    
    // Initialize ticket tracking
    initializeTicketTracking(ticket) {
        const trackingFile = path.join(this.baseDir, 'operations/ticket-dashboard/data/ticket-tracking.json');
        let tracking = {};
        
        if (fs.existsSync(trackingFile)) {
            tracking = JSON.parse(fs.readFileSync(trackingFile, 'utf8'));
        }
        
        tracking[ticket.id] = {
            created_at: new Date().toISOString(),
            status_history: [{
                status: ticket.status,
                timestamp: new Date().toISOString()
            }],
            priority_history: [{
                priority: ticket.priority,
                timestamp: new Date().toISOString()
            }]
        };
        
        fs.writeFileSync(trackingFile, JSON.stringify(tracking, null, 2));
    }
    
    // Utility methods
    isPriorityEscalation(previousPriority, newPriority) {
        const priorityLevels = {
            'low': 1,
            'medium': 2, 
            'high': 3,
            'critical': 4
        };
        
        return priorityLevels[newPriority] > priorityLevels[previousPriority];
    }
    
    runCommand(command, change) {
        const child = spawn('bash', ['-c', command], {
            cwd: this.baseDir,
            stdio: 'pipe'
        });
        
        child.stdout.on('data', (data) => {
            this.log(`Command output: ${data.toString().trim()}`);
        });
        
        child.stderr.on('data', (data) => {
            this.log(`Command error: ${data.toString().trim()}`);
        });
        
        child.on('close', (code) => {
            this.log(`Command completed with code: ${code}`);
        });
    }
    
    updateTicketAssignee(ticket, assignee) {
        this.updateTicketMetadata(ticket, { assignee: assignee });
    }
    
    updateTicketField(ticket, field, value) {
        this.updateTicketMetadata(ticket, { [field]: value });
    }
}

// Export hooks for the dashboard engine
module.exports = new StatusHooks();
