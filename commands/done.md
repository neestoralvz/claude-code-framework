
---

**IF executing this command** → READ [CLAUDE.md](../CLAUDE.md#framework-overview), THEN execute this command


# Done Command

**Context**: Simple command to wrap up and save session work

---

## Usage

```
done [optional: notes]
```

## What It Does

Wraps up the session by executing [Session Conclusion Workflow](../system/processes/session-conclusion-workflow.md):

1. **Git Operations** - Clean repository state with descriptive commits
2. **Pattern & Workflow Gap Analysis** - Extract insights and identify missing workflows  
3. **Knowledge Documentation** - Update framework with session learnings
4. **Agent Optimization** - Analyze and enhance agent ecosystem
5. **Transition Preparation** - Prepare seamless continuation materials

## Examples

**Basic Usage:**
```
done
```

**With Notes:**
```
done "Completed TDD/BDD framework setup"
```

## Expected Results

- Clean git repository with session work committed
- Framework documentation updated with insights
- Missing workflows automatically created
- Agent ecosystem optimized based on session patterns
- Complete transition materials for future sessions

## Integration

- **Process Reference**: [Session Conclusion Workflow](../system/processes/session-conclusion-workflow.md)
- **Strategic Context**: Maintains orchestrator role through agent coordination
- **Framework Alignment**: Follows "Simple and Easy" principles through automation

---

