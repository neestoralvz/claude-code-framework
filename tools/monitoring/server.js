#!/usr/bin/env node

/**
 * Universal Mandate Monitor Server
 * 
 * Real-time monitoring server for the Universal Execution Mandates dashboard
 * Provides API endpoints and serves the monitoring web interface
 * 
 * Author: Universal Mandate Monitor Specialist  
 * Version: 1.0.0
 * Created: 2025-08-20
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const { UniversalMandateMonitor } = require('./mandate-monitor-dashboard.js');

class MandateMonitorServer {
    constructor(port = 3000) {
        this.port = port;
        this.monitor = new UniversalMandateMonitor();
        this.server = null;
        
        // MIME types for serving files
        this.mimeTypes = {
            '.html': 'text/html',
            '.js': 'application/javascript',
            '.css': 'text/css',
            '.json': 'application/json',
            '.png': 'image/png',
            '.ico': 'image/x-icon'
        };
        
        this.init();
    }
    
    init() {
        console.log('🔄 Initializing Universal Mandate Monitor Server...');
        
        // Start the monitoring system
        this.monitor.startRealTimeMonitoring();
        
        // Create HTTP server
        this.server = http.createServer((req, res) => {
            this.handleRequest(req, res);
        });
        
        console.log('✅ Server initialized successfully');
    }
    
    handleRequest(req, res) {
        const parsedUrl = new URL(req.url, `http://${req.headers.host}`);
        const pathname = parsedUrl.pathname;
        const method = req.method;
        
        // Add CORS headers for API calls
        res.setHeader('Access-Control-Allow-Origin', '*');
        res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
        res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
        
        // Handle OPTIONS request for CORS preflight
        if (method === 'OPTIONS') {
            res.writeHead(200);
            res.end();
            return;
        }
        
        // Route handling
        if (pathname === '/' || pathname === '/dashboard') {
            this.serveDashboard(res);
        } else if (pathname === '/api/mandates') {
            this.serveAPIEndpoint(res, 'mandates');
        } else if (pathname === '/api/status') {
            this.serveAPIEndpoint(res, 'status');
        } else if (pathname === '/api/activity') {
            this.serveAPIEndpoint(res, 'activity');
        } else if (pathname === '/api/compliance') {
            this.serveAPIEndpoint(res, 'compliance');
        } else if (pathname === '/api/violations') {
            this.serveAPIEndpoint(res, 'violations');
        } else if (pathname.startsWith('/api/mandate/') && method === 'POST') {
            this.handleMandateActivation(req, res, pathname);
        } else if (pathname.startsWith('/api/violation/') && method === 'POST') {
            this.handleViolationReport(req, res, pathname);
        } else {
            this.serve404(res);
        }
    }
    
    serveDashboard(res) {
        const dashboardPath = path.join(__dirname, 'mandate-monitor-web.html');
        
        fs.readFile(dashboardPath, 'utf8', (err, data) => {
            if (err) {
                this.serve500(res, 'Failed to load dashboard');
                return;
            }
            
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(data);
        });
    }
    
    serveAPIEndpoint(res, endpoint) {
        let data = {};
        
        try {
            switch (endpoint) {
                case 'mandates':
                    data = {
                        mandates: this.monitor.mandateDefinitions,
                        timestamp: new Date().toISOString()
                    };
                    break;
                    
                case 'status':
                    data = {
                        status: this.monitor.mandateStatus,
                        uptime: (performance.now() - this.monitor.startTime) / 1000,
                        timestamp: new Date().toISOString()
                    };
                    break;
                    
                case 'activity':
                    data = {
                        activities: this.monitor.patternActivationHistory.slice(-50),
                        count: this.monitor.patternActivationHistory.length,
                        timestamp: new Date().toISOString()
                    };
                    break;
                    
                case 'compliance':
                    data = {
                        metrics: this.monitor.complianceMetrics,
                        report: this.monitor.generateComplianceReport(),
                        timestamp: new Date().toISOString()
                    };
                    break;
                    
                case 'violations':
                    const allViolations = [];
                    Object.entries(this.monitor.mandateStatus).forEach(([key, mandate]) => {
                        mandate.violations.forEach(violation => {
                            allViolations.push({
                                mandateKey: key,
                                mandateName: mandate.name,
                                cluster: mandate.cluster,
                                ...violation
                            });
                        });
                    });
                    
                    data = {
                        violations: allViolations,
                        count: allViolations.length,
                        timestamp: new Date().toISOString()
                    };
                    break;
                    
                default:
                    this.serve404(res);
                    return;
            }
            
            res.writeHead(200, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify(data, null, 2));
            
        } catch (error) {
            this.serve500(res, `API Error: ${error.message}`);
        }
    }
    
    handleMandateActivation(req, res, pathname) {
        const mandateKey = pathname.split('/').pop();
        
        let body = '';
        req.on('data', chunk => {
            body += chunk.toString();
        });
        
        req.on('end', () => {
            try {
                const requestData = JSON.parse(body);
                const { trackingPoint, metadata } = requestData;
                
                const success = this.monitor.activateMandate(mandateKey, trackingPoint, metadata);
                
                if (success) {
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({
                        success: true,
                        message: `Mandate ${mandateKey} activated successfully`,
                        timestamp: new Date().toISOString()
                    }));
                } else {
                    res.writeHead(400, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({
                        success: false,
                        message: `Failed to activate mandate ${mandateKey}`,
                        timestamp: new Date().toISOString()
                    }));
                }
                
            } catch (error) {
                this.serve500(res, `Mandate activation error: ${error.message}`);
            }
        });
    }
    
    handleViolationReport(req, res, pathname) {
        const mandateKey = pathname.split('/').pop();
        
        let body = '';
        req.on('data', chunk => {
            body += chunk.toString();
        });
        
        req.on('end', () => {
            try {
                const requestData = JSON.parse(body);
                const { violationType, description, severity = 'MEDIUM' } = requestData;
                
                this.monitor.recordViolation(mandateKey, violationType, description, severity);
                
                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({
                    success: true,
                    message: `Violation recorded for mandate ${mandateKey}`,
                    timestamp: new Date().toISOString()
                }));
                
            } catch (error) {
                this.serve500(res, `Violation report error: ${error.message}`);
            }
        });
    }
    
    serve404(res) {
        res.writeHead(404, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            error: 'Not Found',
            message: 'The requested resource was not found',
            timestamp: new Date().toISOString()
        }));
    }
    
    serve500(res, message = 'Internal Server Error') {
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            error: 'Internal Server Error',
            message: message,
            timestamp: new Date().toISOString()
        }));
    }
    
    start() {
        this.server.listen(this.port, () => {
            console.log('═══════════════════════════════════════════════════════════════════════════════════════');
            console.log('                    🔄 UNIVERSAL MANDATE MONITOR SERVER                                ');
            console.log('                              Real-Time Dashboard Active                                ');
            console.log('═══════════════════════════════════════════════════════════════════════════════════════');
            console.log(`🌐 Server running at: http://localhost:${this.port}`);
            console.log(`📊 Dashboard available at: http://localhost:${this.port}/dashboard`);
            console.log('');
            console.log('📡 API Endpoints:');
            console.log(`   GET  /api/mandates     - Mandate definitions and configuration`);
            console.log(`   GET  /api/status       - Current mandate status and tracking`);
            console.log(`   GET  /api/activity     - Pattern activation history`);
            console.log(`   GET  /api/compliance   - Compliance metrics and reports`);
            console.log(`   GET  /api/violations   - Violation reports and alerts`);
            console.log(`   POST /api/mandate/{key} - Activate specific mandate`);
            console.log(`   POST /api/violation/{key} - Report mandate violation`);
            console.log('');
            console.log('═══════════════════════════════════════════════════════════════════════════════════════');
            console.log('UNIVERSAL OPERATION MODE: Maximum Capability • Universal Excellence • Perpetual Optimization');
            console.log('═══════════════════════════════════════════════════════════════════════════════════════');
            console.log('');
        });
    }
    
    stop() {
        if (this.server) {
            this.server.close(() => {
                console.log('🛑 Universal Mandate Monitor Server stopped');
            });
        }
        
        if (this.monitor) {
            this.monitor.stopMonitoring();
        }
    }
    
    // Demo endpoints for testing
    startDemo() {
        console.log('🎯 Starting demo mode with simulated mandate activations...');
        
        // Simulate various mandate activations for demo
        const demoActivations = [
            { key: 'progressive-think', point: 'think-level-1', delay: 2000 },
            { key: 'agent-deployment', point: 'agent-deployed', delay: 4000 },
            { key: 'todowrite-tracking', point: 'task-atomized', delay: 6000 },
            { key: 'evidence-validation', point: 'proof-provided', delay: 8000 },
            { key: 'context7-research', point: 'context7-triggered', delay: 10000 },
            { key: 'git-integration', point: 'auto-commit-triggered', delay: 12000 },
            { key: 'parallel-execution', point: 'agents-queued', delay: 14000 },
            { key: 'personality-orchestration', point: 'optimal-blend-calculated', delay: 16000 }
        ];
        
        demoActivations.forEach(({ key, point, delay }) => {
            setTimeout(() => {
                this.monitor.activateMandate(key, point, { mode: 'demo' });
                console.log(`📈 Demo: Activated ${key} → ${point}`);
            }, delay);
        });
        
        // Simulate some violations for demonstration
        setTimeout(() => {
            this.monitor.recordViolation('agent-deployment', 'DIRECT_WORK', 'Demo violation: attempted direct work', 'HIGH');
            console.log('🚨 Demo: Recorded violation for agent-deployment');
        }, 18000);
        
        setTimeout(() => {
            this.monitor.recordViolation('context7-research', 'BYPASSED_CONTEXT7', 'Demo violation: bypassed research', 'CRITICAL');
            console.log('🚨 Demo: Recorded violation for context7-research');
        }, 20000);
    }
}

// Main execution
if (require.main === module) {
    const port = process.env.PORT || 3000;
    const isDemoMode = process.argv.includes('--demo');
    
    const server = new MandateMonitorServer(port);
    
    // Handle graceful shutdown
    process.on('SIGINT', () => {
        console.log('\n🛑 Shutting down Universal Mandate Monitor Server...');
        server.stop();
        process.exit(0);
    });
    
    process.on('SIGTERM', () => {
        console.log('\n🛑 Received SIGTERM, shutting down gracefully...');
        server.stop();
        process.exit(0);
    });
    
    // Start the server
    server.start();
    
    // Start demo if requested
    if (isDemoMode) {
        server.startDemo();
    }
    
    console.log('💡 Tip: Use Ctrl+C to stop the server');
    console.log('💡 Tip: Add --demo flag to run with simulated data');
}

module.exports = { MandateMonitorServer };