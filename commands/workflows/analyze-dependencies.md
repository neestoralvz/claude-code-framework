---
title: "Analyze Dependencies Command"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../planning/components/ticket-dependency-analysis.md", "../planning/TICKET_REGISTRY.md", "../docs/principles/agent-selection.md"]
prerequisites: ["Ticket registry access", "Dependency analysis framework", "Agent deployment capability"]
audience: "Project managers, developers, and system architects"
purpose: "Analyze ticket dependencies and generate parallel execution plans with conflict detection"
keywords: ["dependencies", "analysis", "parallel", "execution", "planning", "optimization", "conflicts"]
last_review: "2025-08-18"
---

[Previous: Create execution scheduler](execute-parallel-plan.md) | [Return to Commands Index](index.md) | [Master PRINCIPLES.md](../docs/PRINCIPLES.md) | [Next: Deploy create-ticket](create-ticket.md)

# ANALYZE DEPENDENCIES COMMAND

## Purpose

⏺ **Principle**: This command implements [Apply agent-selection.md MANDATORY agent-first execution](../../docs/principles/agent-selection.md#mandatory-agent-usage) for MANDATORY agent-first execution and applies [Apply workflow.md systematic dependency analysis](../../docs/principles/workflow.md#execution-phases) through systematic dependency analysis.

Analyze ticket dependencies, detect conflicts, and generate optimized parallel execution plans for efficient task completion.

## Command Syntax

```bash
# Analyze all pending tickets
analyze-dependencies

# Analyze specific ticket scope
analyze-dependencies --scope [pending|all|category] --category [system|mod|doc|feat]

# Generate execution plan
analyze-dependencies --generate-plan --strategy [maximum|balanced|sequential]

# Validate existing plan
analyze-dependencies --validate-plan execution-plan.yaml

# Detect conflicts only
analyze-dependencies --conflicts-only --report conflicts-report.md
```

## Execution Workflow

### Phase 1: Ticket Discovery and Parsing
- Scan ticket registry for target scope
- Parse ticket frontmatter for dependency declarations
- Extract file modification patterns
- Identify resource requirements and constraints

### Phase 2: Dependency Graph Construction
- Build directed dependency graph
- Map blocking relationships
- Identify sequential constraints
- Flag soft dependencies

### Phase 3: Conflict Detection
- Detect circular dependencies
- Identify file modification conflicts
- Flag resource competition issues
- Validate dependency integrity

### Phase 4: Execution Plan Generation
- Perform topological sort of dependency graph
- Group independent tickets for parallel execution
- Calculate critical path and bottlenecks
- Optimize execution order based on strategy

### Phase 5: Plan Validation and Output
- Validate execution plan feasibility
- Generate detailed execution report
- Create monitoring and tracking structure
- Output results in specified format

## Analysis Strategies

### Maximum Parallelism
- Execute maximum tickets simultaneously
- Minimize total execution time
- Requires highest system resources
- Best for dedicated execution environments

### Balanced Execution (Recommended)
- Balance parallelism with resource constraints
- Optimize for typical operational capacity
- Sustainable for ongoing development
- Handles resource conflicts gracefully

### Sequential Fallback
- Execute one ticket at a time
- Safest option for critical operations
- Minimal resource requirements
- Guaranteed conflict avoidance

## Dependency Types Analysis

### Blocking Dependencies
```yaml
# Ticket A must complete before Ticket B
dependencies:
  blocking: ["SYS-001", "MOD-003"]
```

### Sequential Dependencies
```yaml
# Tickets must execute in specific order
dependencies:
  sequential: ["SYS-002", "SYS-003"]
```

### File Conflicts
```yaml
# Tickets modifying same files
dependencies:
  file_conflicts: ["MOD-002"]
```

### Resource Conflicts
```yaml
# Tickets competing for resources
dependencies:
  resource_conflicts: ["SYS-004"]
```

## Expected Output

### Analysis Report
```
🔍 DEPENDENCY ANALYSIS REPORT
═══════════════════════════════════════════════

📊 Analysis Summary:
   Tickets Analyzed:     12
   Dependencies Found:   23
   Conflicts Detected:   2
   Parallel Groups:      4
   Critical Path Length: 5 tickets
   
🎯 Execution Plan:
   Strategy:            balanced
   Total Duration:      8.5 hours
   Parallelism Factor:  2.4x
   Resource Efficiency: 85%

🚨 Conflicts Detected:
   1. File Conflict: MOD-012 ↔ MOD-013 (both modify frontmatter-template.yaml)
   2. Resource Conflict: SYS-001 ↔ SYS-002 (both require registry updates)

📈 Parallel Groups:
   Group 1: [MOD-001, DOC-001, MOD-003] (2h, no conflicts)
   Group 2: [SYS-002, MOD-004] (3h, resolved conflicts)
   Group 3: [MOD-012] (1.5h, sequential after conflict resolution)
   Group 4: [SYS-003, DOC-002] (2h, no conflicts)

🎯 Critical Path: SYS-001 → MOD-012 → SYS-003 → DOC-002
```

### Execution Plan Output
```yaml
execution_plan:
  metadata:
    generated: "2025-08-18T10:30:00Z"
    strategy: "balanced"
    total_tickets: 12
    estimated_duration: "8.5 hours"
    parallelism_factor: 2.4
    
  conflicts:
    - type: "file_conflict"
      tickets: ["MOD-012", "MOD-013"]
      files: ["frontmatter-template.yaml"]
      resolution: "sequential_execution"
      
    - type: "resource_conflict"
      tickets: ["SYS-001", "SYS-002"]
      resource: "registry_updates"
      resolution: "mutex_coordination"
      
  parallel_groups:
    - group_id: 1
      tickets: ["MOD-001", "DOC-001", "MOD-003"]
      dependencies_resolved: true
      estimated_duration: "2 hours"
      resource_conflicts: false
      agents_required: 3
      
    - group_id: 2
      tickets: ["SYS-002", "MOD-004"]
      dependencies_resolved: true
      estimated_duration: "3 hours"
      resource_conflicts: true
      conflict_resolution: "mutex_coordination"
      agents_required: 2
      
  critical_path:
    tickets: ["SYS-001", "MOD-012", "SYS-003", "DOC-002"]
    total_duration: "6.5 hours"
    bottlenecks: ["MOD-012"]
    
  optimization_recommendations:
    - "Consider splitting MOD-012 to reduce critical path"
    - "Resource pooling for SYS tickets improves efficiency"
    - "Group 1 can start immediately without dependencies"
```

## Integration with Agent System

### Agent Assignment Strategy
```typescript
interface AgentAssignment {
  ticket_id: string;
  agent_type: 'project-optimizer' | 'agent-creator' | 'delegation-advisor';
  rationale: string;
  estimated_duration: number;
  resource_requirements: ResourceMap;
}
```

### Agent Deployment Planning
- Map ticket categories to optimal agent types
- Calculate agent resource requirements
- Plan agent deployment schedule
- Coordinate agent communication protocols

## Usage Examples

### Analyze Pending Modularization Tickets
```bash
analyze-dependencies --scope pending --category modularization --strategy balanced
```

### Generate Comprehensive Execution Plan
```bash
analyze-dependencies --generate-plan --output execution-plan.yaml --conflicts-report conflicts.md
```

### Validate Existing Plan
```bash
analyze-dependencies --validate-plan current-plan.yaml --check-feasibility
```

### Quick Conflict Check
```bash
analyze-dependencies --conflicts-only --format summary
```

## Error Handling

### Circular Dependencies
```bash
❌ ERROR: Circular dependency detected
🔄 Cycle: SYS-001 → MOD-002 → SYS-003 → SYS-001
💡 Resolution: Review dependency declarations and break cycle
```

### Invalid Dependencies
```bash
⚠️  WARNING: Invalid dependency reference
🎯 Ticket: MOD-012
❌ Invalid dependency: "NONEXISTENT-001"
💡 Available tickets: [list of valid IDs]
```

### Resource Conflicts
```bash
🚨 CONFLICT: File modification conflict detected
📂 File: frontmatter-template.yaml
🎯 Conflicting tickets: MOD-012, MOD-013
💡 Resolution strategies: sequential, merge, split
```

## Integration Points

### Registry Integration
- Real-time dependency tracking
- Automatic conflict detection
- Plan synchronization with ticket updates

### Command System Integration
- Seamless integration with execution commands
- Plan export and import capabilities
- Monitoring and control interfaces

### Agent System Integration
- Agent capability mapping
- Resource allocation planning
- Execution coordination protocols

## Success Criteria

### Primary Objectives
- [ ] **Complete Dependency Mapping**: All ticket dependencies accurately identified and documented
- [ ] **Conflict Detection Accuracy**: 100% of file and resource conflicts detected and documented
- [ ] **Execution Plan Optimization**: Generated plans achieve optimal parallelism within resource constraints
- [ ] **Validation Completeness**: All plans validated for feasibility and conflict resolution

### Quality Gates
- [ ] **Requirements Gate**: All ticket parsing and dependency extraction completed successfully
- [ ] **Process Gate**: Five-phase analysis workflow executed systematically per methodology
- [ ] **Output Gate**: Plans generated meet format standards and include required metadata
- [ ] **System Gate**: No regressions introduced to ticket registry or dependency tracking

### Validation Evidence
- **Functional Testing**: Execute analysis on known dependency scenarios with verified outcomes
- **Quality Metrics**: Compare manual dependency analysis vs. automated detection accuracy
- **Documentation**: Generated plans contain all required fields and valid references
- **Integration**: Plans successfully integrate with execution commands and agent system

### Completion Verification
- [ ] **Dependency Accuracy**: All declared dependencies correctly identified and validated
- [ ] **Conflict Resolution**: All detected conflicts have documented resolution strategies
- [ ] **Plan Feasibility**: Generated execution plans validated for resource and timeline feasibility
- [ ] **Agent Integration**: Agent assignments properly mapped to ticket requirements and capabilities

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../docs/index.md)
- [Browse commands index](index.md)
- [Access TICKET_REGISTRY.md](../planning/TICKET_REGISTRY.md)

### Related Commands
- [Execute parallel plan](execute-parallel-plan.md)
- [Monitor execution](monitor-execution.md)
- [Deploy create-ticket](create-ticket.md)

### Framework References
- [Study dependency analysis](../planning/components/ticket-dependency-analysis.md)
- [Apply agent selection](../docs/principles/agent-selection.md)
- [Follow workflow methodology](../docs/principles/workflow.md)

[⬆ Return to top](#analyze-dependencies-command)