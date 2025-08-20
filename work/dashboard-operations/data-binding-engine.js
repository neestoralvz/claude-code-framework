/**
 * Claude Framework v4.0 - Data Binding Engine
 * Real-time data binding system for Universal Operation Mode Dashboard
 */

class DataBindingEngine {
    constructor() {
        this.data = new Map();
        this.bindings = new Map();
        this.subscriptions = new Map();
        this.updateQueue = [];
        this.isUpdating = false;
        
        this.init();
    }
    
    init() {
        // Initialize default data
        this.setDefaults();
        
        // Set up DOM observers
        this.observeDOM();
        
        // Start real-time update cycle
        this.startUpdateCycle();
        
        // Set up WebSocket connection for real-time updates
        this.setupWebSocket();
        
        console.log('Data Binding Engine initialized');
    }
    
    setDefaults() {
        // Universal Operation Mode Status
        this.set('operationMode', 'Universal Operation Mode');
        this.set('capabilityLevel', 'Maximum');
        this.set('frameworkCoherence', 100);
        this.set('coherencePercentage', '100%');
        this.set('healthStatus', 'Optimal');
        this.set('agentCount', 0);
        
        // Universal Execution Mandates Status
        this.set('mandatesStatus', '16/16 Active');
        
        // Core Methodology Cluster
        this.set('progressiveThinkStatus', 'active');
        this.set('analysisDepth', 100);
        this.set('thinkingLevels', '4/4 Levels');
        this.set('agentDeploymentStatus', 'active');
        this.set('deploymentRate', 100);
        this.set('deploymentPercentage', '100%');
        this.set('todowriteStatus', 'active');
        this.set('taskAtomicity', 100);
        this.set('atomicTasks', 'Atomic');
        this.set('evidenceStatus', 'active');
        this.set('validationRate', 100);
        this.set('evidencePercentage', '100%');
        
        // Research & Preparation Cluster
        this.set('context7Status', 'active');
        this.set('researchCoverage', 100);
        this.set('researchQuality', 'Comprehensive');
        this.set('documentationStatus', 'active');
        this.set('docCompliance', 100);
        this.set('complianceLevel', 'Full');
        this.set('qualityStatus', 'active');
        this.set('tddBddCoverage', 100);
        this.set('qualityScore', 'Excellent');
        this.set('patternStatus', 'active');
        this.set('patternCapture', 100);
        this.set('patternCount', 'Active');
        
        // Workflow Automation Cluster
        this.set('gitStatus', 'active');
        this.set('commitRate', 100);
        this.set('gitHealth', 'Synced');
        this.set('parallelStatus', 'active');
        this.set('concurrencyLevel', 80);
        this.set('parallelAgents', '8/10');
        this.set('sessionStatus', 'active');
        this.set('recenterStatus', 100);
        this.set('sessionHealth', 'Optimal');
        this.set('updateStatus', 'active');
        this.set('autoDocStatus', 100);
        this.set('updateFrequency', 'Real-time');
        
        // Intelligence Amplification Cluster
        this.set('personalityStatus', 'active');
        this.set('adaptationLevel', 100);
        this.set('personalityBlend', 'Optimal');
        this.set('knowledgeStatus', 'active');
        this.set('autoLoadRate', 100);
        this.set('knowledgeScope', 'Universal');
        this.set('qaStatus', 'active');
        this.set('excellenceLevel', 100);
        this.set('qaScore', 'Maximum');
        this.set('optimizationStatus', 'active');
        this.set('detectionRate', 100);
        this.set('optimizationCount', 'Continuous');
        
        // Framework Coherence Metrics
        this.set('coherenceScore', 100);
        this.set('componentIntegration', 'Seamless');
        this.set('integrationTrend', '↗');
        this.set('dependencyHealth', 'Optimal');
        this.set('dependencyTrend', '→');
        this.set('performanceIndex', 'Excellent');
        this.set('performanceTrend', '↗');
        this.set('errorRate', '0.00%');
        this.set('errorTrend', '↘');
        
        // Agent Deployment Coordination
        this.set('totalAgents', '12 Active');
        this.set('specializedCount', 8);
        this.set('taskCount', 4);
        this.set('orchestrationCount', 2);
        
        // System Info
        this.set('lastUpdate', this.formatTime(new Date()));
        this.set('connectionStatus', 'connected');
    }
    
    observeDOM() {
        // Find all elements with data-bind attributes
        const bindableElements = document.querySelectorAll('[data-bind]');
        
        bindableElements.forEach(element => {
            const bindKey = element.getAttribute('data-bind');
            
            if (!this.bindings.has(bindKey)) {
                this.bindings.set(bindKey, []);
            }
            
            this.bindings.get(bindKey).push(element);
        });
        
        // Set up mutation observer for dynamically added elements
        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                mutation.addedNodes.forEach((node) => {
                    if (node.nodeType === Node.ELEMENT_NODE) {
                        const bindableElements = node.querySelectorAll ? 
                            node.querySelectorAll('[data-bind]') : [];
                        
                        bindableElements.forEach(element => {
                            const bindKey = element.getAttribute('data-bind');
                            
                            if (!this.bindings.has(bindKey)) {
                                this.bindings.set(bindKey, []);
                            }
                            
                            this.bindings.get(bindKey).push(element);
                            
                            // Update the new element with current data
                            if (this.data.has(bindKey)) {
                                this.updateElement(element, bindKey, this.data.get(bindKey));
                            }
                        });
                    }
                });
            });
        });
        
        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    }
    
    set(key, value) {
        const oldValue = this.data.get(key);
        this.data.set(key, value);
        
        // Queue update if value changed
        if (oldValue !== value) {
            this.queueUpdate(key, value);
        }
        
        // Notify subscribers
        if (this.subscriptions.has(key)) {
            this.subscriptions.get(key).forEach(callback => {
                try {
                    callback(value, oldValue, key);
                } catch (error) {
                    console.error('Data binding subscription error:', error);
                }
            });
        }
    }
    
    get(key) {
        return this.data.get(key);
    }
    
    subscribe(key, callback) {
        if (!this.subscriptions.has(key)) {
            this.subscriptions.set(key, []);
        }
        
        this.subscriptions.get(key).push(callback);
        
        // Return unsubscribe function
        return () => {
            const callbacks = this.subscriptions.get(key);
            if (callbacks) {
                const index = callbacks.indexOf(callback);
                if (index > -1) {
                    callbacks.splice(index, 1);
                }
            }
        };
    }
    
    queueUpdate(key, value) {
        this.updateQueue.push({ key, value });
        
        if (!this.isUpdating) {
            this.processUpdateQueue();
        }
    }
    
    processUpdateQueue() {
        this.isUpdating = true;
        
        // Use requestAnimationFrame for smooth updates
        requestAnimationFrame(() => {
            while (this.updateQueue.length > 0) {
                const { key, value } = this.updateQueue.shift();
                this.updateBindings(key, value);
            }
            
            this.isUpdating = false;
            
            // Process any updates that came in during this cycle
            if (this.updateQueue.length > 0) {
                this.processUpdateQueue();
            }
        });
    }
    
    updateBindings(key, value) {
        const elements = this.bindings.get(key);
        if (elements) {
            elements.forEach(element => {
                this.updateElement(element, key, value);
            });
        }
    }
    
    updateElement(element, key, value) {
        try {
            // Handle different types of updates based on element and value type
            if (element.hasAttribute('data-bind')) {
                // Text content updates
                if (element.tagName === 'SPAN' || element.tagName === 'DIV' || 
                    element.tagName === 'P' || element.tagName === 'STRONG') {
                    element.textContent = value;
                }
                
                // Progress bar updates
                if (element.classList.contains('progress-fill') && typeof value === 'number') {
                    element.style.width = `${value}%`;
                }
                
                // Status dot updates
                if (element.classList.contains('status-dot')) {
                    element.className = `status-dot ${value}`;
                }
                
                // Coherence circle updates
                if (element.classList.contains('score-circle') && typeof value === 'number') {
                    const percentage = (value / 100) * 360;
                    element.style.background = `conic-gradient(from 0deg, var(--secondary-green) 0deg, var(--secondary-green) ${percentage}deg, var(--background-tertiary) ${percentage}deg)`;
                }
                
                // Connection status updates
                if (element.classList.contains('status-indicator')) {
                    if (key === 'connectionStatus') {
                        element.className = `status-indicator ${value}`;
                    }
                }
                
                // Special handling for specific elements
                if (key === 'lastUpdate') {
                    element.textContent = this.formatTime(new Date());
                }
            }
            
            // Add smooth transition animation
            element.style.transition = 'all 0.3s ease-in-out';
            
        } catch (error) {
            console.error(`Error updating element for key ${key}:`, error);
        }
    }
    
    startUpdateCycle() {
        // Update timestamp every second
        setInterval(() => {
            this.set('lastUpdate', this.formatTime(new Date()));
        }, 1000);
        
        // Simulate real-time data updates
        setInterval(() => {
            this.simulateRealTimeUpdates();
        }, 5000);
    }
    
    simulateRealTimeUpdates() {
        // Simulate slight variations in metrics to show real-time activity
        const concurrencyVariation = Math.floor(Math.random() * 3) + 8; // 8-10
        this.set('parallelAgents', `${concurrencyVariation}/10`);
        this.set('concurrencyLevel', (concurrencyVariation / 10) * 100);
        
        // Simulate agent count changes
        const agentVariation = Math.floor(Math.random() * 5) + 10; // 10-14
        this.set('agentCount', agentVariation);
        this.set('totalAgents', `${agentVariation} Active`);
        
        // Update specialized agent counts
        const specialized = Math.floor(agentVariation * 0.6);
        const task = Math.floor(agentVariation * 0.3);
        const orchestration = agentVariation - specialized - task;
        
        this.set('specializedCount', specialized);
        this.set('taskCount', task);
        this.set('orchestrationCount', orchestration);
        
        // Simulate coherence fluctuations (minor)
        const coherenceVar = 98 + Math.random() * 2; // 98-100%
        this.set('coherenceScore', Math.round(coherenceVar));
        this.set('coherencePercentage', `${Math.round(coherenceVar)}%`);
        this.set('frameworkCoherence', Math.round(coherenceVar));
    }
    
    setupWebSocket() {
        // Note: This would connect to a real WebSocket server in production
        // For now, we'll simulate the connection
        
        console.log('WebSocket connection simulated - ready for real-time updates');
        
        // Simulate connection status changes
        let isConnected = true;
        
        setInterval(() => {
            // Simulate occasional disconnection/reconnection
            if (Math.random() < 0.01) { // 1% chance every interval
                isConnected = !isConnected;
                this.set('connectionStatus', isConnected ? 'connected' : 'disconnected');
                
                if (isConnected) {
                    this.showNotification('Connection restored', 'success');
                } else {
                    this.showNotification('Connection lost - attempting to reconnect...', 'warning');
                }
                
                // Auto-reconnect after 3 seconds
                if (!isConnected) {
                    setTimeout(() => {
                        isConnected = true;
                        this.set('connectionStatus', 'connected');
                        this.showNotification('Connection restored', 'success');
                    }, 3000);
                }
            }
        }, 10000);
    }
    
    showNotification(message, type = 'info') {
        const container = document.getElementById('notificationContainer');
        if (!container) return;
        
        const notification = document.createElement('div');
        notification.className = `notification ${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <span class="notification-message">${message}</span>
                <button class="notification-close" onclick="this.parentElement.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        `;
        
        container.appendChild(notification);
        
        // Auto-remove after 5 seconds
        setTimeout(() => {
            if (notification.parentElement) {
                notification.remove();
            }
        }, 5000);
    }
    
    formatTime(date) {
        const now = new Date();
        const diff = now - date;
        
        if (diff < 60000) { // Less than 1 minute
            return 'Just now';
        } else if (diff < 3600000) { // Less than 1 hour
            const minutes = Math.floor(diff / 60000);
            return `${minutes} minute${minutes !== 1 ? 's' : ''} ago`;
        } else {
            return date.toLocaleTimeString();
        }
    }
    
    // Public API methods
    updateMandateStatus(mandateId, status, metrics = {}) {
        // Update specific mandate status and metrics
        this.set(`mandate${mandateId}Status`, status);
        
        Object.entries(metrics).forEach(([key, value]) => {
            this.set(`mandate${mandateId}${key}`, value);
        });
    }
    
    updateFrameworkCoherence(score, metrics = {}) {
        this.set('coherenceScore', score);
        this.set('coherencePercentage', `${score}%`);
        this.set('frameworkCoherence', score);
        
        Object.entries(metrics).forEach(([key, value]) => {
            this.set(key, value);
        });
    }
    
    updateAgentStatus(counts = {}) {
        const { specialized = 0, task = 0, orchestration = 0 } = counts;
        const total = specialized + task + orchestration;
        
        this.set('specializedCount', specialized);
        this.set('taskCount', task);
        this.set('orchestrationCount', orchestration);
        this.set('agentCount', total);
        this.set('totalAgents', `${total} Active`);
    }
    
    triggerSystemUpdate() {
        // Force a complete system update
        this.set('lastUpdate', this.formatTime(new Date()));
        
        // Trigger coherence calculation
        this.calculateFrameworkCoherence();
        
        // Update all mandate statuses
        this.refreshMandateStatuses();
        
        this.showNotification('System status updated', 'success');
    }
    
    calculateFrameworkCoherence() {
        // Calculate overall framework coherence based on mandate statuses
        let activeCount = 0;
        const totalMandates = 16;
        
        for (let i = 1; i <= totalMandates; i++) {
            const status = this.get(`mandate${i}Status`) || 'active';
            if (status === 'active') {
                activeCount++;
            }
        }
        
        const coherenceScore = Math.round((activeCount / totalMandates) * 100);
        this.updateFrameworkCoherence(coherenceScore);
    }
    
    refreshMandateStatuses() {
        // Refresh all mandate statuses - in a real system, this would
        // fetch from the actual framework monitoring system
        const mandates = [
            'progressiveThink', 'agentDeployment', 'todowrite', 'evidence',
            'context7', 'documentation', 'quality', 'pattern',
            'git', 'parallel', 'session', 'update',
            'personality', 'knowledge', 'qa', 'optimization'
        ];
        
        mandates.forEach((mandate, index) => {
            // Simulate occasional status changes
            if (Math.random() < 0.05) { // 5% chance of status change
                const statuses = ['active', 'warning', 'active', 'active']; // Bias towards active
                const randomStatus = statuses[Math.floor(Math.random() * statuses.length)];
                this.set(`${mandate}Status`, randomStatus);
            }
        });
    }
}

// Initialize the data binding engine when DOM is ready
let dataBinding;

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        dataBinding = new DataBindingEngine();
        window.dataBinding = dataBinding; // Make it globally available
    });
} else {
    dataBinding = new DataBindingEngine();
    window.dataBinding = dataBinding;
}

// Export for module systems
if (typeof module !== 'undefined' && module.exports) {
    module.exports = DataBindingEngine;
}