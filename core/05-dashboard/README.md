# Claude Framework Dashboard

A comprehensive metrics and monitoring dashboard for the Claude Simple and Easy Framework. Provides real-time visibility into framework health, agent usage, git status, operations, and system performance.

## 🚀 Quick Start

### Starting the Dashboard

1. **Local File Access** (Simplest):
   ```bash
   # Open dashboard directly in browser
   open /Users/nalve/.claude/system/dashboard/index.html
   ```

2. **Full Server Mode** (Recommended):
   ```bash
   # Start the dashboard API server
   cd /Users/nalve/.claude/system/dashboard/scripts
   python3 dashboard_api.py
   
   # Then open browser to:
   # http://127.0.0.1:8080
   ```

3. **Custom Configuration**:
   ```bash
   # Start server with custom settings
   python3 dashboard_api.py --host 0.0.0.0 --port 8081 --framework-root /path/to/framework
   ```

## 📊 Dashboard Features

### System Health Overview
- **Framework Health Score**: Overall framework integrity and compliance
- **Hook Status**: Active hooks and execution health
- **Git Repository**: Changes, commits, and repository status
- **Operations Activity**: Recent operations and session metrics

### Framework Components
- **Principles**: Core decision-making guidelines (13 principles)
- **Personalities**: Collaborative interaction styles (7 personalities) 
- **Processes**: Workflows and procedures (14+ processes)
- **Standards**: Quality and consistency rules (10+ standards)

### Usage Analytics
- **Agent Usage Trends**: Deployment patterns and preferences
- **Hook Execution Stats**: Performance and success rates
- **Quick Metrics**: Sessions, activity, and framework updates
- **Performance Data**: Response times and resource usage

### Operations Timeline
- **Recent Operations**: Last 10 framework operations
- **Activity Summary**: Development patterns and trends
- **Git Integration**: Commit history and repository health

### Navigation Hub
- **Quick Links**: Direct access to framework components
- **Tools & Utilities**: Scripts, hooks, and maintenance tools
- **Framework Structure**: Organized access to all system files
- **Action Buttons**: Health checks, metrics updates, data export

## 🔧 API Endpoints

The dashboard provides a REST API for programmatic access:

### Core Endpoints

```http
GET /api/health          # Framework health check
GET /api/metrics         # Comprehensive metrics
GET /api/agents          # Agent usage analytics  
GET /api/git-status      # Git repository status
GET /api/operations      # Operations directory status
GET /api/navigation      # Framework navigation data
GET /api/realtime-metrics # Real-time hook metrics
GET /api/status          # Overall dashboard status
```

### Example Usage

```bash
# Get framework health
curl http://127.0.0.1:8080/api/health

# Get agent usage analytics
curl http://127.0.0.1:8080/api/agents

# Get real-time metrics
curl http://127.0.0.1:8080/api/realtime-metrics
```

## 📈 Metrics Collection

### Manual Collection
```bash
# Collect comprehensive metrics
/Users/nalve/.claude/system/dashboard/scripts/collect_metrics.py

# Run health check
/Users/nalve/.claude/system/dashboard/scripts/health_check.py

# Analyze agent usage
/Users/nalve/.claude/system/dashboard/scripts/agent_tracker.py

# Monitor git and operations
/Users/nalve/.claude/system/dashboard/scripts/git_operations_monitor.py
```

### Automated Collection
Metrics are automatically updated via hooks:
- **post_tool_use.py**: Updates metrics after tool execution
- **session_start.py**: Tracks session initiation
- **Real-time Updates**: Dashboard reflects live activity

### Data Storage
- **Metrics Cache**: `/Users/nalve/.claude/system/dashboard/data/metrics_cache.json`
- **Activity Log**: `/Users/nalve/.claude/system/dashboard/data/activity_log.jsonl`
- **Health Reports**: `/Users/nalve/.claude/system/dashboard/data/health_report_*.json`
- **Usage Data**: `/Users/nalve/.claude/system/dashboard/data/agent_usage_*.json`

## 🛠️ Configuration

### Dashboard Settings
The dashboard adapts to your framework configuration automatically. Key settings:

- **Framework Root**: `/Users/nalve/.claude` (configurable)
- **Auto-refresh**: Every 5 minutes (configurable in JS)
- **API Cache**: 2-15 minutes depending on data type
- **Chart Colors**: Consistent with framework branding

### Hook Integration
Dashboard metrics are updated automatically when hooks are enabled:

1. **Enable Hooks**: Ensure Claude Code hooks are configured
2. **Automatic Updates**: Metrics update after each tool use
3. **Real-time Data**: Dashboard shows live framework activity

### Customization
Modify dashboard behavior by editing:
- **CSS**: `/Users/nalve/.claude/system/dashboard/assets/css/dashboard.css`
- **JavaScript**: `/Users/nalve/.claude/system/dashboard/assets/js/dashboard.js`
- **API Server**: `/Users/nalve/.claude/system/dashboard/scripts/dashboard_api.py`

## 📋 Dashboard Sections

### 1. Health Cards
- **Framework**: Overall health score and status
- **Hooks**: Active hooks and execution rate
- **Git**: Repository status and changes
- **Operations**: Session count and activity

### 2. Component Statistics  
- **File Counts**: Actual counts from framework directories
- **Links**: Direct access to component documentation
- **Status**: Health indicators for each component

### 3. Analytics Charts
- **Agent Usage**: Doughnut chart of agent deployments
- **Hook Stats**: Bar chart of hook execution counts
- **Trends**: Time-series data for usage patterns

### 4. Quick Metrics
- **Total Sessions**: Cumulative framework usage
- **Session Frequency**: Average sessions per day
- **Top Personality**: Most-used agent personality
- **Framework Updates**: Recent tool executions

### 5. Operations Timeline
- **Recent Activity**: Last 10 operations with timestamps
- **Operation Types**: Categorized by activity type
- **File Counts**: Documents generated per operation

### 6. Navigation Grid
- **Documentation**: Links to core framework files
- **Tools**: Access to utilities and maintenance scripts  
- **Structure**: Organized view of framework directories
- **Actions**: Quick dashboard operations

## 🔍 Troubleshooting

### Common Issues

**Dashboard Won't Load**
```bash
# Check if files exist
ls -la /Users/nalve/.claude/system/dashboard/

# Verify permissions
chmod +x /Users/nalve/.claude/system/dashboard/scripts/*.py
```

**API Server Won't Start**
```bash
# Check port availability
lsof -i :8080

# Start with debug output
python3 dashboard_api.py --host 127.0.0.1 --port 8081
```

**No Data Showing**
```bash
# Run manual metrics collection
cd /Users/nalve/.claude/system/dashboard/scripts
python3 collect_metrics.py

# Check hook integration
/Users/nalve/.claude/hooks/test_hooks.py
```

**Permission Errors**
```bash
# Fix hook permissions
chmod +x /Users/nalve/.claude/hooks/*.py

# Fix script permissions
chmod +x /Users/nalve/.claude/system/dashboard/scripts/*.py
```

### Debug Mode
Enable debug output for troubleshooting:

```bash
# Run health check with verbose output
python3 health_check.py 2>&1 | tee debug.log

# Check API responses
curl -v http://127.0.0.1:8080/api/health
```

## 🚀 Performance

### Optimization Features
- **Smart Caching**: API responses cached for 2-15 minutes
- **Incremental Updates**: Only changed data refreshed  
- **Lazy Loading**: Charts rendered on demand
- **Compression**: JSON data minimized for transfer

### Resource Usage
- **Memory**: ~10-20MB for dashboard server
- **Storage**: ~1-5MB for metrics cache and logs
- **CPU**: Minimal, spikes during metrics collection
- **Network**: Local-only by default

## 🔐 Security

### Access Control
- **Local Only**: Default binding to 127.0.0.1
- **No Authentication**: Designed for local framework use
- **File Permissions**: Respects system file permissions
- **Sandboxed**: Limited to framework directory

### Data Privacy
- **Local Data**: All metrics stored locally
- **No External Calls**: Dashboard works offline
- **Framework Only**: Only monitors framework activity
- **Opt-in**: Dashboard use is optional

## 🎯 Integration

### With Framework Workflows
- **Automatic Updates**: Hooks update metrics seamlessly
- **Workflow Visibility**: Operations show in timeline
- **Health Monitoring**: Issues surface in dashboard
- **Performance Tracking**: Framework efficiency visible

### With Git Workflow  
- **Commit Tracking**: Recent commits displayed
- **Change Monitoring**: Uncommitted changes tracked
- **Repository Health**: Branch and remote status
- **Activity Correlation**: Git activity vs framework usage

### With Agent System
- **Usage Analytics**: Agent deployment patterns
- **Performance Metrics**: Agent effectiveness tracking
- **Trend Analysis**: Agent preference evolution
- **Recommendation Engine**: Usage optimization suggestions

## 📚 Advanced Usage

### Programmatic Access
```python
# Using the API directly
import requests

# Get current health status
response = requests.get('http://127.0.0.1:8080/api/health')
health_data = response.json()

print(f"Framework health: {health_data['health_score']}%")
```

### Custom Metrics
Extend the dashboard with custom metrics:

```python
# Add custom metric collection
from update_dashboard_metrics import DashboardMetricsUpdater

updater = DashboardMetricsUpdater()
custom_data = {"custom_metric": "value"}
updater.update_from_hook_data({
    "event": "custom_event",
    "custom_data": custom_data
})
```

### Automation Scripts
```bash
#!/bin/bash
# Daily dashboard maintenance script

cd /Users/nalve/.claude/system/dashboard/scripts

# Collect fresh metrics
python3 collect_metrics.py

# Run health check
python3 health_check.py

# Archive old logs
find ../data -name "*.log" -mtime +30 -delete
```

## 🤝 Contributing

### Dashboard Improvements
1. **Fork**: Copy dashboard files to development location
2. **Modify**: Update HTML, CSS, JS, or Python as needed
3. **Test**: Ensure dashboard functions correctly
4. **Document**: Update README with changes
5. **Deploy**: Copy changes back to framework

### Adding Metrics
1. **Identify Data Source**: Determine what to measure
2. **Update Collector**: Modify collection scripts
3. **Update API**: Add new endpoint if needed
4. **Update Frontend**: Add display components
5. **Test Integration**: Ensure end-to-end functionality

### Reporting Issues
- **Framework Issues**: Report via framework channels
- **Dashboard Bugs**: Create detailed reproduction steps
- **Feature Requests**: Describe use case and requirements
- **Performance Issues**: Include system information and logs

---

## 📄 License

Part of the Claude Simple and Easy Framework. Use in accordance with framework licensing.

## 🔗 Related Documentation

- [Framework Overview](../README.md)
- [System Index](../INDEX.md)  
- [Hooks Documentation](../../hooks/README.md)
- [Processes](../PROCESSES.md)
- [Standards](../STANDARDS.md)