# Universal Mandate Monitor System

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Node](https://img.shields.io/badge/node-%3E%3D14.0.0-brightgreen.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Status](https://img.shields.io/badge/status-active-success.svg)

## Overview

The **Universal Mandate Monitor System** is a comprehensive real-time monitoring solution that tracks all 16 Universal Execution Mandates across four pattern clusters. It provides continuous monitoring, compliance tracking, violation detection, and performance optimization for the Claude Framework's Universal Operation Mode.

### Key Features

- **Real-Time Monitoring**: Live tracking of all 16 mandates with subsecond updates
- **Pattern Cluster Visualization**: Organized tracking across 4 mandate clusters
- **Compliance Metrics**: Detailed compliance scoring and trend analysis
- **Violation Detection**: Automatic detection and alerting of mandate violations
- **Web Dashboard**: Beautiful, responsive web interface with real-time updates
- **API Integration**: RESTful API for external system integration
- **Performance Analytics**: Comprehensive performance and optimization tracking

## Mandate Clusters

### 1. Core Methodology (Primary Pattern Cluster)
**CRITICAL** - Foundation mandates that must never be compromised

| ID | Mandate | Description | Tracking Points |
|---|---|---|---|
| 1 | Progressive Think | 4-level analysis tracking (Think → Think Hard → Think Harder → Ultra Think) | 4 levels |
| 2 | Agent Deployment | Specialized agent usage monitoring - NEVER work directly | 4 stages |
| 3 | TodoWrite Tracking | Task atomization compliance - ALL tasks broken down | 4 phases |
| 4 | Evidence Validation | Proof requirement verification for ALL claims | 4 steps |

### 2. Research & Preparation (Secondary Pattern Cluster)  
**MANDATORY** - Research and documentation mandates for quality assurance

| ID | Mandate | Description | Tracking Points |
|---|---|---|---|
| 5 | Context7 Research | MANDATORY library integration before coding | 4 stages |
| 6 | System Documentation | Framework adherence tracking - check docs first | 4 phases |
| 7 | Quality Standards | TDD/BDD methodology monitoring - Red-Green-Refactor | 4 cycles |
| 8 | Pattern Documentation | Discovery recording verification - document immediately | 4 steps |

### 3. Workflow Automation (Tertiary Pattern Cluster)
**AUTOMATED** - Automation and integration mandates for efficiency

| ID | Mandate | Description | Tracking Points |
|---|---|---|---|
| 9 | Git Integration | Auto-commit + push behavior tracking | 4 stages |
| 10 | Parallel Execution | Concurrent agent monitoring (MAX 10 per message) | 4 phases |
| 11 | Session Management | RECENTER workflow activation tracking | 4 steps |
| 12 | Framework Updates | CLAUDE.md correction tracking - immediate updates | 4 stages |

### 4. Intelligence Amplification (Quaternary Pattern Cluster)
**INTELLIGENT** - Advanced intelligence and optimization mandates

| ID | Mandate | Description | Tracking Points |
|---|---|---|---|
| 13 | Personality Orchestration | Dynamic optimal adaptation monitoring - 7 personalities active | 4 phases |
| 14 | Knowledge Integration | Framework knowledge loading - auto-load relevant info | 4 stages |
| 15 | Quality Assurance | Excellence standards compliance - maximum quality always | 4 gates |
| 16 | Optimization Detection | Improvement identification tracking - continuous enhancement | 4 levels |

## Installation

### Prerequisites
- Node.js >= 14.0.0
- npm or yarn package manager
- Modern web browser for dashboard access

### Quick Setup
```bash
# Clone or navigate to the monitoring directory
cd /Users/nalve/.claude/tools/monitoring

# Install dependencies
npm install

# Start the monitoring system
npm start
```

### Development Setup
```bash
# Install development dependencies
npm install

# Start in development mode with demo data
npm run dev

# Run with live reload
npx nodemon server.js --demo
```

## Usage

### Command Line Interface

#### Start Monitoring Dashboard
```bash
# Terminal-based monitoring
npm run monitor
# or
node mandate-monitor-dashboard.js
```

#### Start Web Server
```bash
# Start web server with dashboard
npm start
# or
node server.js

# Start with demo data
npm run demo
# or 
node server.js --demo
```

### Web Dashboard

Access the web dashboard at: `http://localhost:3000/dashboard`

**Dashboard Features:**
- Real-time mandate status visualization
- Pattern cluster activation heatmap
- Compliance metrics and trends
- Recent activity feed
- Violation alerts and reporting
- Interactive mandate details

### API Endpoints

The monitoring system provides a RESTful API for integration:

#### GET Endpoints
```bash
# Get all mandate definitions
GET /api/mandates

# Get current status of all mandates  
GET /api/status

# Get recent pattern activations
GET /api/activity

# Get compliance metrics and reports
GET /api/compliance

# Get violation reports
GET /api/violations
```

#### POST Endpoints  
```bash
# Activate a specific mandate
POST /api/mandate/{mandateKey}
Content-Type: application/json
{
  "trackingPoint": "think-level-1",
  "metadata": { "analysisDepth": "initial" }
}

# Report a mandate violation
POST /api/violation/{mandateKey}  
Content-Type: application/json
{
  "violationType": "DIRECT_WORK",
  "description": "Attempted direct implementation",
  "severity": "HIGH"
}
```

#### Example API Usage
```bash
# Check system status
curl http://localhost:3000/api/status

# Activate progressive thinking mandate
curl -X POST http://localhost:3000/api/mandate/progressive-think \
  -H "Content-Type: application/json" \
  -d '{"trackingPoint": "think-level-2", "metadata": {"depth": "deep"}}'

# Report a violation
curl -X POST http://localhost:3000/api/violation/agent-deployment \
  -H "Content-Type: application/json" \
  -d '{"violationType": "DIRECT_WORK", "description": "Bypassed agent deployment", "severity": "CRITICAL"}'
```

## Configuration

### Environment Variables
```bash
# Server configuration
PORT=3000                    # Web server port
NODE_ENV=development         # Environment mode

# Monitoring configuration  
REFRESH_RATE=1000           # Dashboard refresh rate (ms)
MAX_ACTIVITIES=50           # Maximum activities to track
COMPLIANCE_THRESHOLD=80.0   # Minimum compliance threshold
```

### Configuration Files

#### `mandate-definitions.json`
Contains comprehensive definitions for all 16 mandates:
- Mandate metadata and descriptions
- Tracking point definitions
- Violation types and severities  
- Compliance thresholds
- Alert rules and performance targets

#### `package.json`
NPM package configuration with:
- Script definitions
- Dependency management
- Development tools configuration
- Testing and validation setup

## Monitoring Concepts

### Compliance Scoring
Each mandate receives a compliance score from 0-100% based on:
- **Tracking Point Activation**: Percentage of required tracking points triggered
- **Violation History**: Impact of recorded violations on score  
- **Performance Metrics**: Response time and success rate factors
- **Temporal Decay**: Recent performance weighted more heavily

### Pattern Activation States
- **🟢 Active (100%)**: All tracking points activated, no violations
- **🟡 Partial (50-99%)**: Some tracking points activated, minor issues
- **🔴 Inactive (0-49%)**: Few tracking points activated, significant issues

### Alert Severity Levels
- **CRITICAL**: System-breaking violations requiring immediate attention
- **HIGH**: Important violations affecting mandate compliance  
- **MEDIUM**: Performance issues requiring monitoring
- **LOW**: Minor optimizations and improvements

## Development

### Project Structure
```
/Users/nalve/.claude/tools/monitoring/
├── mandate-monitor-dashboard.js    # Core monitoring logic
├── mandate-monitor-web.html        # Web dashboard interface
├── server.js                      # HTTP server and API
├── mandate-definitions.json       # Mandate configuration
├── package.json                   # NPM configuration
├── README.md                      # This documentation
└── test/                         # Test files
    └── mandate-monitor.test.js    # Test suite
```

### Testing
```bash
# Run all tests
npm test

# Run tests with coverage
npm run test -- --coverage

# Validate monitoring system  
npm run validate

# Health check
npm run health-check
```

### Adding New Mandates

1. **Update Configuration**: Add mandate definition to `mandate-definitions.json`
2. **Update Monitor**: Modify `UniversalMandateMonitor` class to handle new mandate
3. **Update Dashboard**: Add UI elements for new mandate in web interface
4. **Add Tests**: Create test cases for new mandate functionality
5. **Update Documentation**: Document the new mandate in this README

### Code Style
- Use ES6+ features and modern JavaScript
- Follow consistent naming conventions  
- Add comprehensive JSDoc comments
- Maintain high test coverage (>90%)
- Use meaningful variable and function names

## Deployment

### Production Deployment
```bash
# Build the monitoring system
npm run build

# Deploy to production
npm run deploy

# Start in production mode
NODE_ENV=production npm start
```

### Docker Deployment
```dockerfile
FROM node:18-alpine

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

COPY . .

EXPOSE 3000
CMD ["npm", "start"]
```

### Environment Configuration
```bash
# Production environment
export NODE_ENV=production
export PORT=3000
export REFRESH_RATE=5000
export MAX_ACTIVITIES=100

# Start production server
npm start
```

## Performance

### Optimization Features
- **Real-time Updates**: Sub-second monitoring refresh rates
- **Memory Management**: Efficient data structure usage with cleanup
- **API Caching**: Response caching for frequently accessed data
- **Event-driven Architecture**: Minimal CPU usage with event-based updates

### Performance Targets
- **Response Time**: < 50ms for API calls  
- **Memory Usage**: < 100MB for monitoring system
- **CPU Usage**: < 5% during normal operation
- **Uptime**: 99.9% availability target

### Monitoring Metrics
```bash
# Export monitoring data
npm run export-data

# Generate compliance report  
npm run generate-report
```

## Troubleshooting

### Common Issues

**Server Won't Start**
```bash
# Check if port is already in use
lsof -i :3000

# Try different port
PORT=3001 npm start
```

**Dashboard Not Loading**
```bash
# Verify server is running
npm run health-check

# Check browser console for JavaScript errors
# Ensure all files are in correct locations
```

**API Calls Failing**
```bash
# Verify API endpoint exists
curl http://localhost:3000/api/status

# Check request format and headers
# Review server logs for error details  
```

**Missing Mandate Data**  
```bash
# Verify mandate-definitions.json exists and is valid JSON
node -e "console.log(require('./mandate-definitions.json'))"

# Check file permissions and accessibility
ls -la mandate-definitions.json
```

### Debug Mode
```bash
# Enable debug logging
DEBUG=* npm start

# Run with detailed output
NODE_ENV=development npm run demo
```

## Contributing

### Development Workflow
1. Fork the repository
2. Create a feature branch
3. Make changes with tests
4. Run the validation suite
5. Submit a pull request

### Pull Request Guidelines
- [ ] All tests passing
- [ ] Code coverage maintained >90%  
- [ ] Documentation updated
- [ ] API endpoints documented
- [ ] Performance impact assessed

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions:
- **Issues**: Report bugs and feature requests via GitHub Issues
- **Documentation**: Comprehensive API and usage documentation included
- **Community**: Active community support and contributions welcome

---

## Appendix

### Mandate Activation Examples

#### Progressive Thinking Activation
```javascript
// Activate progressive thinking mandate
monitor.activateMandate('progressive-think', 'think-level-2', {
  analysisDepth: 'deep',
  complexity: 'high',
  domain: 'system-architecture'
});
```

#### Agent Deployment Tracking
```javascript  
// Track agent deployment
monitor.activateMandate('agent-deployment', 'agent-deployed', {
  agentType: 'testing-specialist', 
  specialization: 'TDD-methodology',
  taskComplexity: 'medium'
});
```

#### Violation Reporting
```javascript
// Report mandate violation
monitor.recordViolation('context7-research', 'BYPASSED_RESEARCH', 
  'Started coding without Context7 library research', 'CRITICAL');
```

### Integration Examples

#### Express.js Integration
```javascript
const express = require('express');
const { UniversalMandateMonitor } = require('./mandate-monitor-dashboard');

const app = express();
const monitor = new UniversalMandateMonitor();

app.use('/monitoring', (req, res) => {
  res.json(monitor.generateComplianceReport());
});
```

#### WebSocket Integration
```javascript
const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 8080 });

wss.on('connection', (ws) => {
  // Send real-time updates to connected clients
  monitor.on('mandateActivated', (data) => {
    ws.send(JSON.stringify({ type: 'activation', data }));
  });
});
```

---

**Built with Universal Excellence • Perpetual Optimization • Maximum Capability**

*This monitoring system is part of the Claude Framework v4.0 Universal Operation Mode ecosystem.*