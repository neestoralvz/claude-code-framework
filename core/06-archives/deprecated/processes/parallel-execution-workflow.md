
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Parallel Execution Workflow

**Context**: Workflow process defining procedural steps and execution patterns


How to deploy multiple specialized agents efficiently to handle tasks in parallel.

**MANDATORY**: All parallel execution must be performed through concurrent agent deployment (MAX 10 agents per message). Never attempt sequential execution when parallel is possible.

## When to Use Parallel Execution

When you have multiple independent tasks that can run simultaneously, like processing several files, validating multiple inputs, or making several API calls. The key is that tasks must not depend on each other.

## Setup Process

**Deploy parallel-coordinator** to orchestrate concurrent execution:

**Agent Instructions**: "Set up parallel execution for [tasks]:
- Identify tasks that can run independently
- Group similar tasks for batch processing
- Prepare up to 10 concurrent agent deployments
- Ensure no resource conflicts between agents"

## Execution Management

**Deploy multiple specialists simultaneously** (single message, multiple Task calls):

**Pattern**: Deploy up to 10 agents in ONE message:
```
Task 1: Deploy [specialist-1] for [task-1]
Task 2: Deploy [specialist-2] for [task-2]
Task 3: Deploy [specialist-3] for [task-3]
...(up to 10 concurrent deployments)
```

**Agent Instructions**: "Monitor parallel execution and track success/failure for each deployed agent."

## Result Coordination

**Deploy results-aggregator** to consolidate outputs:

**Agent Instructions**: "Coordinate results from parallel execution:
- Collect outputs from all deployed agents
- Handle partial failures gracefully
- Combine successful results
- Document errors for failed tasks
- Provide consolidated summary"

## Real Examples

**Parallel Agent Deployment Patterns**:

1. **Multi-file Processing**: Deploy file-processor agents for each file (up to 10)
2. **Batch Validation**: Deploy validation-specialist for each item concurrently
3. **Test Suite Execution**: Deploy testing-specialist for each test category
4. **Documentation Updates**: Deploy documentation-specialist for each section
5. **Code Analysis**: Deploy analysis-specialist for each module simultaneously

---
