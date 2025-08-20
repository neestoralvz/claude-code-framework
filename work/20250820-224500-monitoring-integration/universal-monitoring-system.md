# Universal Operation Monitoring System

_Version: 1.0 - Integrated with Framework v5.0_

## Core Philosophy

**Monitor everything. Display simply. Act intelligently.**

## Simple Access Pattern

The monitoring system follows the v5.0 workflow:

1. **Think** → What needs monitoring?
2. **Deploy Monitor** → Use monitoring agents
3. **Track** → Real-time status updates
4. **Done** → Automated response to issues

## Monitoring Commands

### Quick Status

**`/monitor`** → Display current system status dashboard
- Shows active agents, tasks, and performance
- Highlights any issues or bottlenecks
- Suggests optimizations automatically

### Deep Analysis

**`/monitor analyze`** → Deploy analysis agents for comprehensive review
- Pattern detection across all operations
- Performance bottleneck identification
- Optimization opportunity discovery

### Real-time Tracking

**`/monitor track [component]`** → Live monitoring of specific components
- Agent performance metrics
- Task completion rates
- Error frequency analysis
- Resource utilization

## Automated Monitoring Agents

### System Monitor Agent
```yaml
---
name: system-monitor
description: Continuously monitors system health and performance
tools: Bash, Grep, TodoWrite
model: haiku
color: cyan
---
Monitor system performance, track agent execution, detect anomalies
```

### Quality Monitor Agent
```yaml
---
name: quality-monitor
description: Validates quality standards and compliance
tools: Grep, Task
model: sonnet
color: green
---
Ensure TDD/BDD compliance, validate evidence, check standards
```

### Performance Monitor Agent
```yaml
---
name: performance-monitor
description: Tracks execution speed and resource usage
tools: Bash, Task
model: haiku
color: orange
---
Measure response times, track resource usage, identify bottlenecks
```

## Integration Points

### TodoWrite Integration
- Automatic task performance tracking
- Completion rate monitoring
- Bottleneck detection in workflows

### Task Tool Integration
- Agent deployment success rates
- Parallel execution efficiency
- Agent coordination metrics

### Context7 Integration
- Documentation lookup speed
- Cache hit rates
- API usage patterns

### Git Integration
- Commit frequency tracking
- Change impact analysis
- Error introduction detection

## Monitoring Dashboard

### Simple View (Default)
```
📊 System Status: Healthy
🤖 Active Agents: 3/10
✅ Tasks Completed: 45/50 (90%)
⚡ Performance: Optimal
🔍 Issues: None
```

### Detailed View (On Request)
```
╔══════════════════════════════════════╗
║     OPERATION MONITORING SYSTEM      ║
╠══════════════════════════════════════╣
║ Agents:                              ║
║   • testing-specialist: Active (2m)  ║
║   • general-purpose: Idle            ║
║   • system-monitor: Running          ║
║                                      ║
║ Performance:                         ║
║   • Response Time: 1.2s avg         ║
║   • CPU Usage: 15%                  ║
║   • Memory: 512MB                   ║
║                                      ║
║ Quality Metrics:                    ║
║   • Test Coverage: 95%              ║
║   • Evidence Rate: 100%             ║
║   • Error Rate: 0.1%                ║
╚══════════════════════════════════════╝
```

## Automated Responses

### Performance Issues
- **Slow Response** → Auto-deploy performance-monitor agent
- **High CPU** → Suggest parallel agent optimization
- **Memory Spike** → Trigger resource cleanup

### Quality Issues
- **Test Failure** → Deploy testing-specialist immediately
- **Missing Evidence** → Request validation agent deployment
- **Standard Violation** → Alert with specific correction

### Workflow Issues
- **Task Blockage** → Analyze dependencies, suggest resolution
- **Agent Conflict** → Coordinate parallel execution
- **Complex Request** → Trigger `/recenter` recommendation

## Monitoring Workflows

### Continuous Monitoring
```
1. System-monitor agent runs in background
2. Collects metrics every 30 seconds
3. Alerts on anomalies immediately
4. Logs to monitoring dashboard
```

### On-Demand Analysis
```
1. User requests `/monitor analyze`
2. Deploy analysis agents in parallel
3. Aggregate findings
4. Present actionable recommendations
```

### Issue Response
```
1. Monitor detects issue
2. Categorize severity (Info/Warning/Critical)
3. Deploy appropriate response agent
4. Track resolution progress
5. Validate fix effectiveness
```

## Data Collection

### Metrics Tracked
- Agent deployment frequency
- Task completion times
- Error occurrence patterns
- Resource utilization trends
- Framework compliance rates
- User interaction patterns

### Storage Location
```
~/.claude/monitoring/
├── metrics/           # Performance data
├── logs/             # Event logs
├── reports/          # Analysis reports
└── alerts/           # Issue notifications
```

## Simple Integration with v5.0

### In CLAUDE.md
Adds only two lines:
- To Slash Commands: **`/monitor`** → System status and health
- To Key Tools: **Monitor** → Continuous system observation

### In Workflow
Seamlessly integrates:
1. **Think** → Monitor identifies what needs attention
2. **Deploy Agent** → Monitor suggests optimal agents
3. **Track** → Monitor provides real-time updates
4. **Done** → Monitor validates completion

## Monitoring Best Practices

### Keep It Simple
- Default to simple dashboard view
- Only show details when requested
- Use clear status indicators

### Make It Actionable
- Every alert includes suggested action
- Automatic agent deployment for issues
- Clear resolution tracking

### Stay Unobtrusive
- Background monitoring by default
- Alerts only for significant issues
- Minimal performance impact

## Quick Start

1. **Enable Monitoring**: `/monitor enable`
2. **Check Status**: `/monitor`
3. **Deep Dive**: `/monitor analyze`
4. **Track Specific**: `/monitor track agents`

---

**Monitor simply. Respond intelligently. Optimize continuously.**