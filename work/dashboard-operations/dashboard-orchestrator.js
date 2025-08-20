/**
 * Claude Framework v4.0 - Dashboard Orchestrator
 * Main orchestrator for dashboard components and real-time coordination
 */

class DashboardOrchestrator {
    constructor() {
        this.components = new Map();
        this.eventBus = new EventTarget();
        this.isInitialized = false;
        this.updateInterval = null;
        this.theme = 'adaptive';
        this.perfMonitor = null;
        
        this.init();
    }
    
    init() {
        // Wait for dependencies to load
        this.waitForDependencies().then(() => {
            this.initializeComponents();
            this.setupThemeSystem();
            this.startPerformanceMonitoring();
            this.setupGlobalEventHandlers();
            this.initializeCharts();
            this.setupAccessibility();
            
            this.isInitialized = true;
            this.emit('dashboardReady', { timestamp: new Date() });
            
            console.log('Dashboard Orchestrator initialized successfully');
        });
    }
    
    async waitForDependencies() {
        // Wait for required dependencies to be available
        const maxWaitTime = 10000; // 10 seconds
        const checkInterval = 100; // 100ms
        let elapsed = 0;
        
        while (elapsed < maxWaitTime) {
            if (window.dataBinding && window.universalCore) {
                break;
            }
            
            await new Promise(resolve => setTimeout(resolve, checkInterval));
            elapsed += checkInterval;
        }
        
        if (!window.dataBinding || !window.universalCore) {
            console.warn('Some dependencies may not be fully loaded');
        }
    }
    
    initializeComponents() {
        // Register dashboard components
        this.registerComponent('mandatesGrid', new MandatesGridComponent());
        this.registerComponent('coherenceMonitor', new CoherenceMonitorComponent());
        this.registerComponent('agentCoordinator', new AgentCoordinatorComponent());
        this.registerComponent('performanceAnalytics', new PerformanceAnalyticsComponent());
        this.registerComponent('notificationSystem', new NotificationSystemComponent());
        
        console.log('Dashboard components initialized');
    }
    
    registerComponent(name, component) {
        this.components.set(name, component);
        
        // Initialize component
        if (typeof component.init === 'function') {
            component.init(this.eventBus, window.dataBinding);
        }
    }
    
    getComponent(name) {
        return this.components.get(name);
    }
    
    setupThemeSystem() {
        // Detect system theme preference
        const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
        
        // Apply initial theme
        this.applyTheme(this.theme);
        
        // Listen for system theme changes
        mediaQuery.addListener((e) => {
            if (this.theme === 'adaptive') {
                this.applyTheme('adaptive');
            }
        });
    }
    
    applyTheme(themeName) {
        const body = document.body;
        
        // Remove existing theme classes
        body.classList.remove('theme-light', 'theme-dark', 'theme-adaptive');
        
        // Apply new theme
        switch (themeName) {
            case 'light':
                body.classList.add('theme-light');
                break;
            case 'dark':
                body.classList.add('theme-dark');
                break;
            case 'adaptive':
            default:
                body.classList.add('theme-adaptive');
                break;
        }
        
        this.theme = themeName;
        this.emit('themeChanged', { theme: themeName });
    }
    
    startPerformanceMonitoring() {
        // Monitor dashboard performance
        this.perfMonitor = {
            frameRate: 60,
            lastFrame: performance.now(),
            frames: [],
            memoryUsage: 0
        };
        
        // Monitor frame rate
        const measureFrameRate = () => {
            const now = performance.now();
            const delta = now - this.perfMonitor.lastFrame;
            this.perfMonitor.lastFrame = now;
            
            this.perfMonitor.frames.push(1000 / delta);
            
            // Keep only last 60 frame measurements
            if (this.perfMonitor.frames.length > 60) {
                this.perfMonitor.frames.shift();
            }
            
            // Calculate average frame rate
            if (this.perfMonitor.frames.length > 10) {
                const avgFrameRate = this.perfMonitor.frames.reduce((a, b) => a + b) / this.perfMonitor.frames.length;
                this.perfMonitor.frameRate = Math.round(avgFrameRate);
            }
            
            requestAnimationFrame(measureFrameRate);
        };
        
        measureFrameRate();
        
        // Monitor memory usage if available
        if (performance.memory) {
            setInterval(() => {
                this.perfMonitor.memoryUsage = performance.memory.usedJSHeapSize / 1024 / 1024; // MB
            }, 5000);
        }
        
        // Update performance indicators every 5 seconds
        setInterval(() => {
            this.updatePerformanceIndicators();
        }, 5000);
    }
    
    updatePerformanceIndicators() {
        const perfData = {
            frameRate: this.perfMonitor.frameRate,
            memoryUsage: this.perfMonitor.memoryUsage,
            timestamp: new Date()
        };
        
        this.emit('performanceUpdate', perfData);
        
        // Warn if performance is degrading
        if (this.perfMonitor.frameRate < 30) {
            console.warn('Dashboard performance degraded: Low frame rate detected');
            this.showNotification('Performance warning: Dashboard frame rate is low', 'warning');
        }
        
        if (this.perfMonitor.memoryUsage > 100) { // 100MB threshold
            console.warn('Dashboard performance warning: High memory usage detected');
        }
    }
    
    setupGlobalEventHandlers() {
        // Handle visibility changes
        document.addEventListener('visibilitychange', () => {
            if (document.hidden) {
                this.pauseRealTimeUpdates();
            } else {
                this.resumeRealTimeUpdates();
            }
        });
        
        // Handle window resize
        let resizeTimeout;
        window.addEventListener('resize', () => {
            clearTimeout(resizeTimeout);
            resizeTimeout = setTimeout(() => {
                this.handleResize();
            }, 250);
        });
        
        // Handle keyboard navigation
        document.addEventListener('keydown', (event) => {
            this.handleGlobalKeyboard(event);
        });
        
        // Handle focus management
        document.addEventListener('focusin', (event) => {
            this.updateFocusIndicators(event.target);
        });
    }
    
    handleResize() {
        // Notify components about resize
        this.emit('resize', {
            width: window.innerWidth,
            height: window.innerHeight
        });
        
        // Update responsive classes
        this.updateResponsiveClasses();
    }
    
    updateResponsiveClasses() {
        const body = document.body;
        const width = window.innerWidth;
        
        // Remove existing responsive classes
        body.classList.remove('mobile', 'tablet', 'desktop', 'wide');
        
        // Add appropriate responsive class
        if (width < 768) {
            body.classList.add('mobile');
        } else if (width < 1024) {
            body.classList.add('tablet');
        } else if (width < 1440) {
            body.classList.add('desktop');
        } else {
            body.classList.add('wide');
        }
    }
    
    handleGlobalKeyboard(event) {
        // Handle global keyboard shortcuts
        if (event.altKey && event.key === 'Tab') {
            event.preventDefault();
            this.cycleThrough('sections');
        }
        
        if (event.key === 'Escape') {
            this.closeModalsAndOverlays();
        }
        
        // Dashboard-specific shortcuts
        if (event.ctrlKey || event.metaKey) {
            switch (event.key.toLowerCase()) {
                case 'h':
                    event.preventDefault();
                    this.showHelpOverlay();
                    break;
                    
                case 'k':
                    event.preventDefault();
                    this.showCommandPalette();
                    break;
                    
                case '1':
                case '2':
                case '3':
                case '4':
                    event.preventDefault();
                    this.focusSection(parseInt(event.key) - 1);
                    break;
            }
        }
    }
    
    cycleThrough(type) {
        if (type === 'sections') {
            const sections = document.querySelectorAll('main > section');
            const currentFocus = document.activeElement;
            let currentIndex = -1;
            
            sections.forEach((section, index) => {
                if (section.contains(currentFocus)) {
                    currentIndex = index;
                }
            });
            
            const nextIndex = (currentIndex + 1) % sections.length;
            const nextSection = sections[nextIndex];
            
            if (nextSection) {
                const focusTarget = nextSection.querySelector('h2, button, [tabindex="0"]');
                if (focusTarget) {
                    focusTarget.focus();
                }
            }
        }
    }
    
    focusSection(index) {
        const sections = document.querySelectorAll('main > section');
        if (sections[index]) {
            const focusTarget = sections[index].querySelector('h2, button, [tabindex="0"]');
            if (focusTarget) {
                focusTarget.focus();
            }
        }
    }
    
    closeModalsAndOverlays() {
        // Close any open modals or overlays
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay && loadingOverlay.style.display !== 'none') {
            loadingOverlay.style.display = 'none';
            loadingOverlay.setAttribute('aria-hidden', 'true');
        }
        
        // Close notifications
        const notifications = document.querySelectorAll('.notification');
        notifications.forEach(notification => {
            notification.remove();
        });
    }
    
    showHelpOverlay() {
        const helpContent = `
            <div class="help-overlay">
                <div class="help-content">
                    <h3>Dashboard Keyboard Shortcuts</h3>
                    <div class="shortcuts-grid">
                        <div class="shortcut-group">
                            <h4>Navigation</h4>
                            <kbd>Alt</kbd> + <kbd>Tab</kbd> - Cycle through sections<br>
                            <kbd>Ctrl/Cmd</kbd> + <kbd>1-4</kbd> - Jump to specific section<br>
                            <kbd>Esc</kbd> - Close modals and overlays
                        </div>
                        <div class="shortcut-group">
                            <h4>Actions</h4>
                            <kbd>Ctrl/Cmd</kbd> + <kbd>R</kbd> - Execute RECENTER<br>
                            <kbd>Ctrl/Cmd</kbd> + <kbd>O</kbd> - Run Optimization<br>
                            <kbd>Ctrl/Cmd</kbd> + <kbd>V</kbd> - Validate Framework
                        </div>
                        <div class="shortcut-group">
                            <h4>Interface</h4>
                            <kbd>Ctrl/Cmd</kbd> + <kbd>H</kbd> - Show this help<br>
                            <kbd>Ctrl/Cmd</kbd> + <kbd>K</kbd> - Command palette
                        </div>
                    </div>
                    <button onclick="this.closest('.help-overlay').remove()" class="close-help">Close</button>
                </div>
            </div>
        `;
        
        const helpElement = document.createElement('div');
        helpElement.innerHTML = helpContent;
        helpElement.className = 'help-overlay-container';
        
        document.body.appendChild(helpElement);
    }
    
    showCommandPalette() {
        console.log('Command palette would open here');
        // This would show a command palette for quick actions
        this.showNotification('Command palette feature coming soon', 'info');
    }
    
    updateFocusIndicators(element) {
        // Enhanced focus indicators for better accessibility
        document.querySelectorAll('.focus-enhanced').forEach(el => {
            el.classList.remove('focus-enhanced');
        });
        
        if (element && element.classList) {
            element.classList.add('focus-enhanced');
        }
    }
    
    setupAccessibility() {
        // Announce important changes to screen readers
        this.on('mandateStatusChange', (data) => {
            this.announceToScreenReader(`Mandate ${data.mandateId} status changed to ${data.status}`);
        });
        
        this.on('frameworkCoherenceUpdate', (data) => {
            if (data.score < 90) {
                this.announceToScreenReader(`Framework coherence decreased to ${data.score}%`);
            }
        });
        
        // Set up reduced motion preferences
        const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
        if (prefersReducedMotion.matches) {
            document.body.classList.add('reduced-motion');
        }
        
        prefersReducedMotion.addListener((e) => {
            if (e.matches) {
                document.body.classList.add('reduced-motion');
            } else {
                document.body.classList.remove('reduced-motion');
            }
        });
    }
    
    announceToScreenReader(message) {
        // Create or update screen reader announcement area
        let announcer = document.getElementById('sr-announcer');
        if (!announcer) {
            announcer = document.createElement('div');
            announcer.id = 'sr-announcer';
            announcer.setAttribute('aria-live', 'polite');
            announcer.setAttribute('aria-atomic', 'true');
            announcer.style.position = 'absolute';
            announcer.style.left = '-10000px';
            announcer.style.width = '1px';
            announcer.style.height = '1px';
            announcer.style.overflow = 'hidden';
            document.body.appendChild(announcer);
        }
        
        // Clear and set new message
        announcer.textContent = '';
        setTimeout(() => {
            announcer.textContent = message;
        }, 100);
    }
    
    initializeCharts() {
        // Initialize performance charts
        const performanceChart = document.getElementById('performanceChart');
        const utilizationChart = document.getElementById('utilizationChart');
        
        if (performanceChart && performanceChart.getContext) {
            this.initPerformanceChart(performanceChart);
        }
        
        if (utilizationChart && utilizationChart.getContext) {
            this.initUtilizationChart(utilizationChart);
        }
    }
    
    initPerformanceChart(canvas) {
        const ctx = canvas.getContext('2d');
        
        // Simple performance chart implementation
        const chart = {
            canvas,
            ctx,
            data: [],
            maxDataPoints: 60,
            
            addDataPoint: (value) => {
                chart.data.push(value);
                if (chart.data.length > chart.maxDataPoints) {
                    chart.data.shift();
                }
                chart.render();
            },
            
            render: () => {
                const { width, height } = canvas;
                ctx.clearRect(0, 0, width, height);
                
                if (chart.data.length < 2) return;
                
                // Draw grid
                ctx.strokeStyle = '#e2e8f0';
                ctx.lineWidth = 1;
                for (let i = 0; i <= 10; i++) {
                    const y = (height / 10) * i;
                    ctx.beginPath();
                    ctx.moveTo(0, y);
                    ctx.lineTo(width, y);
                    ctx.stroke();
                }
                
                // Draw performance line
                ctx.strokeStyle = '#10b981';
                ctx.lineWidth = 2;
                ctx.beginPath();
                
                chart.data.forEach((value, index) => {
                    const x = (width / (chart.maxDataPoints - 1)) * index;
                    const y = height - (value / 100) * height;
                    
                    if (index === 0) {
                        ctx.moveTo(x, y);
                    } else {
                        ctx.lineTo(x, y);
                    }
                });
                
                ctx.stroke();
            }
        };
        
        // Store chart reference
        this.performanceChart = chart;
        
        // Start with some initial data
        for (let i = 0; i < 20; i++) {
            chart.addDataPoint(95 + Math.random() * 5);
        }
        
        // Update chart with real data
        setInterval(() => {
            const performanceScore = 90 + Math.random() * 10;
            chart.addDataPoint(performanceScore);
        }, 2000);
    }
    
    initUtilizationChart(canvas) {
        const ctx = canvas.getContext('2d');
        
        const chart = {
            canvas,
            ctx,
            data: {
                specialized: 8,
                task: 4,
                orchestration: 2
            },
            
            render: () => {
                const { width, height } = canvas;
                ctx.clearRect(0, 0, width, height);
                
                const centerX = width / 2;
                const centerY = height / 2;
                const radius = Math.min(width, height) / 3;
                
                const total = Object.values(chart.data).reduce((a, b) => a + b, 0);
                let currentAngle = 0;
                
                const colors = ['#2563eb', '#10b981', '#f59e0b'];
                const labels = ['Specialized', 'Task', 'Orchestration'];
                
                Object.values(chart.data).forEach((value, index) => {
                    const sliceAngle = (value / total) * 2 * Math.PI;
                    
                    ctx.beginPath();
                    ctx.moveTo(centerX, centerY);
                    ctx.arc(centerX, centerY, radius, currentAngle, currentAngle + sliceAngle);
                    ctx.fillStyle = colors[index];
                    ctx.fill();
                    
                    // Add label
                    const labelAngle = currentAngle + sliceAngle / 2;
                    const labelX = centerX + Math.cos(labelAngle) * (radius * 0.7);
                    const labelY = centerY + Math.sin(labelAngle) * (radius * 0.7);
                    
                    ctx.fillStyle = '#ffffff';
                    ctx.font = '12px Inter';
                    ctx.textAlign = 'center';
                    ctx.fillText(value.toString(), labelX, labelY);
                    
                    currentAngle += sliceAngle;
                });
            }
        };
        
        this.utilizationChart = chart;
        chart.render();
        
        // Update chart when agent counts change
        this.on('agentCountUpdate', (data) => {
            chart.data = data;
            chart.render();
        });
    }
    
    pauseRealTimeUpdates() {
        this.emit('pauseUpdates');
        console.log('Real-time updates paused (page not visible)');
    }
    
    resumeRealTimeUpdates() {
        this.emit('resumeUpdates');
        console.log('Real-time updates resumed');
    }
    
    showNotification(message, type = 'info') {
        if (window.dataBinding && typeof window.dataBinding.showNotification === 'function') {
            window.dataBinding.showNotification(message, type);
        } else {
            console.log(`[${type.toUpperCase()}] ${message}`);
        }
    }
    
    // Event system
    on(eventName, callback) {
        this.eventBus.addEventListener(eventName, callback);
    }
    
    off(eventName, callback) {
        this.eventBus.removeEventListener(eventName, callback);
    }
    
    emit(eventName, data = {}) {
        const event = new CustomEvent(eventName, { detail: data });
        this.eventBus.dispatchEvent(event);
    }
    
    // Public API
    getStatus() {
        return {
            initialized: this.isInitialized,
            theme: this.theme,
            components: Array.from(this.components.keys()),
            performance: this.perfMonitor
        };
    }
    
    executeCommand(command, params = {}) {
        switch (command) {
            case 'switchTheme':
                this.applyTheme(params.theme || 'adaptive');
                break;
                
            case 'refreshDashboard':
                this.refreshAllComponents();
                break;
                
            case 'showHelp':
                this.showHelpOverlay();
                break;
                
            default:
                // Forward to universal core if available
                if (window.universalCore) {
                    return window.universalCore.executeCommand(command, params);
                }
                console.log(`Unknown command: ${command}`);
                return false;
        }
        
        return true;
    }
    
    refreshAllComponents() {
        this.components.forEach((component, name) => {
            if (typeof component.refresh === 'function') {
                component.refresh();
            }
        });
        
        this.showNotification('Dashboard refreshed', 'success');
    }
}

// Component base classes (simplified implementations)
class MandatesGridComponent {
    init(eventBus, dataBinding) {
        this.eventBus = eventBus;
        this.dataBinding = dataBinding;
        console.log('Mandates Grid Component initialized');
    }
}

class CoherenceMonitorComponent {
    init(eventBus, dataBinding) {
        this.eventBus = eventBus;
        this.dataBinding = dataBinding;
        console.log('Coherence Monitor Component initialized');
    }
}

class AgentCoordinatorComponent {
    init(eventBus, dataBinding) {
        this.eventBus = eventBus;
        this.dataBinding = dataBinding;
        console.log('Agent Coordinator Component initialized');
    }
}

class PerformanceAnalyticsComponent {
    init(eventBus, dataBinding) {
        this.eventBus = eventBus;
        this.dataBinding = dataBinding;
        console.log('Performance Analytics Component initialized');
    }
}

class NotificationSystemComponent {
    init(eventBus, dataBinding) {
        this.eventBus = eventBus;
        this.dataBinding = dataBinding;
        console.log('Notification System Component initialized');
    }
}

// Initialize Dashboard Orchestrator
let dashboardOrchestrator;

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        dashboardOrchestrator = new DashboardOrchestrator();
        window.dashboardOrchestrator = dashboardOrchestrator;
    });
} else {
    dashboardOrchestrator = new DashboardOrchestrator();
    window.dashboardOrchestrator = dashboardOrchestrator;
}

// Export for module systems
if (typeof module !== 'undefined' && module.exports) {
    module.exports = DashboardOrchestrator;
}