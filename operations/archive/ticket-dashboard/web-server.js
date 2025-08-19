#!/usr/bin/env node

/**
 * WEB SERVER FOR AUTOMATED TICKET DASHBOARD
 * 
 * Optional HTTP interface for the containerized dashboard
 * Provides web-based monitoring and API endpoints
 */

const express = require('express');
const WebSocket = require('ws');
const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

class DashboardWebServer {
    constructor() {
        this.app = express();
        this.port = process.env.DASHBOARD_PORT || 3000;
        this.dashboardDir = '/app';
        this.claudeDir = process.env.CLAUDE_BASE_DIR || '/claude-data';
        
        this.setupMiddleware();
        this.setupRoutes();
        this.setupWebSocket();
    }
    
    setupMiddleware() {
        this.app.use(express.json());
        this.app.use(express.static(path.join(__dirname, 'public')));
        
        // CORS for container access
        this.app.use((req, res, next) => {
            res.header('Access-Control-Allow-Origin', '*');
            res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
            next();
        });
    }
    
    setupRoutes() {
        // Health check endpoint
        this.app.get('/health', (req, res) => {
            this.getHealthStatus().then(health => {
                res.json(health);
            }).catch(error => {
                res.status(500).json({ error: error.message });
            });
        });
        
        // Dashboard status endpoint
        this.app.get('/api/status', (req, res) => {
            this.getDashboardStatus().then(status => {
                res.json(status);
            }).catch(error => {
                res.status(500).json({ error: error.message });
            });
        });
        
        // Ticket data endpoint
        this.app.get('/api/tickets', (req, res) => {
            this.getTicketData().then(tickets => {
                res.json(tickets);
            }).catch(error => {
                res.status(500).json({ error: error.message });
            });
        });
        
        // Metrics endpoint
        this.app.get('/api/metrics', (req, res) => {
            this.getMetrics().then(metrics => {
                res.json(metrics);
            }).catch(error => {
                res.status(500).json({ error: error.message });
            });
        });
        
        // Registry sync endpoint
        this.app.post('/api/sync', (req, res) => {
            this.triggerSync().then(result => {
                res.json(result);
            }).catch(error => {
                res.status(500).json({ error: error.message });
            });
        });
        
        // Logs endpoint
        this.app.get('/api/logs/:type', (req, res) => {
            this.getLogs(req.params.type).then(logs => {
                res.json(logs);
            }).catch(error => {
                res.status(500).json({ error: error.message });
            });
        });
        
        // Dashboard UI
        this.app.get('/', (req, res) => {
            res.send(this.generateDashboardHTML());
        });
        
        // Configuration endpoint
        this.app.get('/api/config', (req, res) => {
            this.getConfiguration().then(config => {
                res.json(config);
            }).catch(error => {
                res.status(500).json({ error: error.message });
            });
        });
    }
    
    setupWebSocket() {
        this.wss = new WebSocket.Server({ port: 3001 });
        
        this.wss.on('connection', (ws) => {
            console.log('🔗 WebSocket client connected');
            
            // Send initial status
            this.getDashboardStatus().then(status => {
                ws.send(JSON.stringify({ type: 'status', data: status }));
            });
            
            // Setup periodic updates
            const updateInterval = setInterval(() => {
                if (ws.readyState === WebSocket.OPEN) {
                    this.getDashboardStatus().then(status => {
                        ws.send(JSON.stringify({ type: 'status', data: status }));
                    });
                }
            }, 5000);
            
            ws.on('close', () => {
                clearInterval(updateInterval);
                console.log('🔗 WebSocket client disconnected');
            });
        });
    }
    
    async getHealthStatus() {
        try {
            const healthFile = path.join(this.dashboardDir, 'data/health-check.json');
            
            if (fs.existsSync(healthFile)) {
                const health = JSON.parse(fs.readFileSync(healthFile, 'utf8'));
                return health;
            }
            
            return {
                timestamp: new Date().toISOString(),
                healthy: true,
                message: 'No health data available'
            };
            
        } catch (error) {
            return {
                timestamp: new Date().toISOString(),
                healthy: false,
                error: error.message
            };
        }
    }
    
    async getDashboardStatus() {
        try {
            const statusFile = path.join(this.dashboardDir, 'cache/ticket-state.json');
            
            if (fs.existsSync(statusFile)) {
                const status = JSON.parse(fs.readFileSync(statusFile, 'utf8'));
                return {
                    ...status,
                    server: {
                        uptime: process.uptime(),
                        memory: process.memoryUsage(),
                        pid: process.pid
                    }
                };
            }
            
            return {
                message: 'Dashboard initializing',
                server: {
                    uptime: process.uptime(),
                    memory: process.memoryUsage(),
                    pid: process.pid
                }
            };
            
        } catch (error) {
            return { error: error.message };
        }
    }
    
    async getTicketData() {
        try {
            const statusFile = path.join(this.dashboardDir, 'cache/ticket-state.json');
            
            if (fs.existsSync(statusFile)) {
                const data = JSON.parse(fs.readFileSync(statusFile, 'utf8'));
                return data.tickets || {};
            }
            
            return {};
            
        } catch (error) {
            throw new Error('Failed to load ticket data: ' + error.message);
        }
    }
    
    async getMetrics() {
        try {
            const metricsFile = path.join(this.dashboardDir, 'metrics/current.json');
            
            if (fs.existsSync(metricsFile)) {
                const metrics = JSON.parse(fs.readFileSync(metricsFile, 'utf8'));
                return metrics;
            }
            
            return { message: 'No metrics available' };
            
        } catch (error) {
            throw new Error('Failed to load metrics: ' + error.message);
        }
    }
    
    async triggerSync() {
        try {
            // Trigger a force sync through the dashboard engine
            const result = await new Promise((resolve, reject) => {
                const proc = spawn('node', ['core/dashboard-engine.js', '--force-sync'], {
                    cwd: this.dashboardDir
                });
                
                let output = '';
                proc.stdout.on('data', (data) => {
                    output += data.toString();
                });
                
                proc.on('close', (code) => {
                    if (code === 0) {
                        resolve({ success: true, output: output });
                    } else {
                        reject(new Error('Sync failed with code ' + code));
                    }
                });
            });
            
            return result;
            
        } catch (error) {
            throw new Error('Failed to trigger sync: ' + error.message);
        }
    }
    
    async getLogs(type) {
        try {
            const logFile = path.join(this.dashboardDir, 'logs', type + '.log');
            
            if (fs.existsSync(logFile)) {
                const content = fs.readFileSync(logFile, 'utf8');
                const lines = content.split('\n').filter(line => line.trim());
                
                // Return last 100 lines
                return {
                    type: type,
                    lines: lines.slice(-100),
                    totalLines: lines.length
                };
            }
            
            return {
                type: type,
                lines: [],
                message: 'Log file not found'
            };
            
        } catch (error) {
            throw new Error('Failed to read logs: ' + error.message);
        }
    }
    
    async getConfiguration() {
        try {
            const configFile = path.join(this.dashboardDir, 'core/config.json');
            
            if (fs.existsSync(configFile)) {
                const config = JSON.parse(fs.readFileSync(configFile, 'utf8'));
                return config;
            }
            
            return { message: 'No configuration available' };
            
        } catch (error) {
            throw new Error('Failed to load configuration: ' + error.message);
        }
    }
    
    generateDashboardHTML() {
        return `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Automated Ticket Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { background: #2c3e50; color: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }
        .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .status { padding: 10px; border-radius: 4px; margin: 10px 0; }
        .healthy { background: #d4edda; color: #155724; }
        .warning { background: #fff3cd; color: #856404; }
        .unhealthy { background: #f8d7da; color: #721c24; }
        .metrics { display: flex; justify-content: space-between; margin: 10px 0; }
        .metric { text-align: center; }
        .metric-value { font-size: 2em; font-weight: bold; color: #2c3e50; }
        .metric-label { color: #7f8c8d; }
        .log-viewer { background: #2c3e50; color: #ecf0f1; padding: 15px; border-radius: 4px; height: 200px; overflow-y: auto; font-family: monospace; font-size: 12px; }
        button { background: #3498db; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; }
        button:hover { background: #2980b9; }
        .connected { color: #27ae60; }
        .disconnected { color: #e74c3c; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Automated Ticket Dashboard</h1>
            <p>Production-ready containerized dashboard system</p>
            <div>Status: <span id="connection-status" class="disconnected">Connecting...</span></div>
        </div>
        
        <div class="grid">
            <div class="card">
                <h3>📊 System Health</h3>
                <div id="health-status">Loading...</div>
            </div>
            
            <div class="card">
                <h3>📋 Ticket Summary</h3>
                <div class="metrics" id="ticket-metrics">
                    <div class="metric">
                        <div class="metric-value" id="total-tickets">-</div>
                        <div class="metric-label">Total</div>
                    </div>
                    <div class="metric">
                        <div class="metric-value" id="completed-tickets">-</div>
                        <div class="metric-label">Completed</div>
                    </div>
                    <div class="metric">
                        <div class="metric-value" id="in-progress-tickets">-</div>
                        <div class="metric-label">In Progress</div>
                    </div>
                    <div class="metric">
                        <div class="metric-value" id="pending-tickets">-</div>
                        <div class="metric-label">Pending</div>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <h3>⚡ Performance</h3>
                <div id="performance-metrics">Loading...</div>
            </div>
            
            <div class="card">
                <h3>🔄 Actions</h3>
                <button onclick="triggerSync()">Force Sync</button>
                <button onclick="refreshData()">Refresh Data</button>
                <button onclick="downloadLogs()">Download Logs</button>
            </div>
        </div>
        
        <div class="card" style="margin-top: 20px;">
            <h3>📝 Recent Activity</h3>
            <div class="log-viewer" id="activity-log">Loading activity log...</div>
        </div>
    </div>

    <script>
        let ws;
        
        function connectWebSocket() {
            ws = new WebSocket('ws://localhost:3001');
            
            ws.onopen = function() {
                document.getElementById('connection-status').textContent = 'Connected';
                document.getElementById('connection-status').className = 'connected';
            };
            
            ws.onmessage = function(event) {
                const message = JSON.parse(event.data);
                if (message.type === 'status') {
                    updateDashboard(message.data);
                }
            };
            
            ws.onclose = function() {
                document.getElementById('connection-status').textContent = 'Disconnected';
                document.getElementById('connection-status').className = 'disconnected';
                setTimeout(connectWebSocket, 3000); // Reconnect
            };
        }
        
        function updateDashboard(data) {
            // Update ticket metrics
            if (data.summary) {
                document.getElementById('total-tickets').textContent = data.summary.total || 0;
                document.getElementById('completed-tickets').textContent = data.summary.byStatus?.completed || 0;
                document.getElementById('in-progress-tickets').textContent = data.summary.byStatus?.in_progress || 0;
                document.getElementById('pending-tickets').textContent = data.summary.byStatus?.pending || 0;
            }
            
            // Update performance metrics
            if (data.server) {
                const memoryMB = Math.round(data.server.memory.rss / 1024 / 1024);
                const uptimeHours = Math.round(data.server.uptime / 3600 * 100) / 100;
                document.getElementById('performance-metrics').innerHTML = 
                    'Memory: ' + memoryMB + 'MB<br>' +
                    'Uptime: ' + uptimeHours + 'h<br>' +
                    'PID: ' + data.server.pid;
            }
        }
        
        async function triggerSync() {
            try {
                const response = await fetch('/api/sync', { method: 'POST' });
                const result = await response.json();
                alert('Sync triggered successfully');
            } catch (error) {
                alert('Sync failed: ' + error.message);
            }
        }
        
        async function refreshData() {
            try {
                const response = await fetch('/api/status');
                const data = await response.json();
                updateDashboard(data);
            } catch (error) {
                console.error('Failed to refresh data:', error);
            }
        }
        
        async function downloadLogs() {
            window.open('/api/logs/deployment', '_blank');
        }
        
        async function loadHealth() {
            try {
                const response = await fetch('/api/health');
                const health = await response.json();
                
                let statusHTML = '';
                if (health.checks) {
                    health.checks.forEach(check => {
                        statusHTML += '<div class="status ' + check.status + '">' +
                                     check.name + ': ' + check.message + '</div>';
                    });
                } else {
                    statusHTML = '<div class="status healthy">System operational</div>';
                }
                
                document.getElementById('health-status').innerHTML = statusHTML;
            } catch (error) {
                document.getElementById('health-status').innerHTML = 
                    '<div class="status unhealthy">Failed to load health status</div>';
            }
        }
        
        // Initialize
        connectWebSocket();
        loadHealth();
        setInterval(loadHealth, 30000); // Update health every 30 seconds
    </script>
</body>
</html>
        `;
    }
    
    start() {
        this.server = this.app.listen(this.port, () => {
            console.log(`🌐 Dashboard web server running on port ${this.port}`);
            console.log(`📊 Dashboard UI: http://localhost:${this.port}`);
            console.log(`🔗 WebSocket: ws://localhost:3001`);
        });
        
        // Graceful shutdown
        process.on('SIGTERM', () => {
            console.log('🛑 Shutting down web server...');
            this.server.close(() => {
                if (this.wss) {
                    this.wss.close();
                }
                process.exit(0);
            });
        });
    }
}

// Export for module usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = DashboardWebServer;
}

// CLI execution
if (require.main === module) {
    const webServer = new DashboardWebServer();
    webServer.start();
}