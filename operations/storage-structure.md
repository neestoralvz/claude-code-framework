# Multi-Analysis Storage Structure

## Organization Pattern
```
operations/
├── conv-{id}/                          # Conversation isolation
│   ├── analyses/                       # JSON outputs from analysis agents
│   │   ├── sales-analysis.json         # Sales analyst output
│   │   ├── exploration-analysis.json   # Exploration analyst output
│   │   ├── research-analysis.json      # Research analyst output
│   │   ├── intent-analysis.json        # Intent analysis output
│   │   └── backups/                    # Timestamped backups
│   │       ├── sales-analysis-{timestamp}.json
│   │       ├── exploration-analysis-{timestamp}.json
│   │       └── research-analysis-{timestamp}.json
│   ├── reports/                        # Processed reports for orchestrator
│   │   ├── consolidated-report.json    # Final orchestrator input
│   │   ├── executive-summary.json      # High-level summary
│   │   └── decision-matrix.json        # Decision support data
│   ├── tasks/                          # Task-specific organization
│   │   ├── task-{id}/                  # Individual task containers
│   │   │   ├── analysis-outputs/       # Agent JSON results
│   │   │   ├── report-output/          # Generated reports
│   │   │   └── metadata.json           # Task execution data
│   │   └── task-registry.json          # Task tracking index
│   └── metadata/                       # Conversation metadata
│       ├── conversation-info.json      # Session information
│       ├── agent-execution-log.json    # Agent deployment history
│       └── orchestrator-decisions.json # Decision tracking
```

## File Type Specifications

### Analysis Files (`./analyses/`)
- **Format**: JSON with standardized schema per agent type
- **Naming**: `{agent-type}-analysis.json`
- **Backup**: Timestamped versions in `./backups/`
- **Schema**: Agent-specific JSON structure with metadata

### Report Files (`./reports/`)
- **consolidated-report.json**: Multi-agent synthesis for orchestrator
- **executive-summary.json**: High-level insights and recommendations
- **decision-matrix.json**: Structured decision support data

### Task Organization (`./tasks/`)
- **Task Isolation**: Each task gets dedicated subfolder
- **Analysis Storage**: Task-specific analysis outputs
- **Report Generation**: Task-level report synthesis
- **Metadata Tracking**: Execution history and status

## Data Flow Pattern
1. **Analysis Agents** → Generate JSON → `./analyses/{agent-type}-analysis.json`
2. **Report Generator** → Process JSON → `./reports/consolidated-report.json`
3. **Orchestrator** → Read Reports → Make Decisions
4. **Task System** → Organize by Task → `./tasks/task-{id}/`

## Integration Points
- **Multi-Agent Coordination**: Shared analysis folder access
- **Report Generation**: Centralized JSON processing
- **Orchestrator Interface**: Standardized report consumption
- **Task Tracking**: Hierarchical organization with metadata