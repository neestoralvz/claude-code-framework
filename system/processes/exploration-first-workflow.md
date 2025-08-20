[🏠 System Hub](../INDEX.md) | [📁 Parent Directory](./) | [📖 Current Section](#)

---

# Exploration-First Workflow

**Context**: Workflow process defining procedural steps and execution patterns


**[System](../INDEX.md) › [Processes](../PROCESSES.md) › Exploration-First Workflow**

## Core Principle
**Explore → Understand → Act**

Always explore and understand before taking action to ensure quality results.

## Universal Process

### 1. Initial Exploration
```bash
# Understand current context
pwd
ls -la
git status
```

### 2. Deep Analysis
- **Read relevant files**: Use Read tool to examine existing code/docs
- **Search patterns**: Use Grep to find similar implementations
- **Check dependencies**: Look for related files and references
- **Understand structure**: Map out how pieces connect

### 3. Requirements Clarification
- What exactly needs to be done?
- What are the constraints?
- What are the success criteria?
- What could go wrong?

### 4. Planning Phase
- Design the approach
- Identify potential issues
- Plan validation steps
- Consider rollback options

### 5. Execution Phase
- Start with smallest change
- Test incrementally
- Validate each step
- Document as you go

### 6. Validation Phase
- Test functionality
- Check for side effects
- Verify requirements met
- Get feedback if needed

## Exploration Checklist

### For Code Changes
- [ ] Read existing code structure
- [ ] Find similar patterns in codebase
- [ ] Check import/dependency chains
- [ ] Look for tests that might break
- [ ] Understand naming conventions
- [ ] Check for configuration files

### For File Operations
- [ ] Check current directory structure
- [ ] Look for existing patterns
- [ ] Verify permissions
- [ ] Check for hidden files/directories
- [ ] Understand git status
- [ ] Look for related documentation

### For System Changes
- [ ] Check current system state
- [ ] Look for existing configurations
- [ ] Understand dependencies
- [ ] Check for running processes
- [ ] Verify backup/rollback options
- [ ] Test in safe environment first

## Common Commands for Exploration

### File System Exploration
```bash
# Structure overview
tree -L 3
find . -type f -name "*.md" | head -10
du -sh */ 2>/dev/null

# Content patterns
grep -r "pattern" . --include="*.md"
find . -name "*keyword*"
```

### Code Exploration
```bash
# Find functions/classes
grep -r "function\|class" . --include="*.js"
grep -r "def " . --include="*.py"

# Find imports/requires
grep -r "import\|require" . --include="*.js"
grep -r "from.*import" . --include="*.py"
```

### Git Exploration
```bash
# Recent changes
git log --oneline -10
git diff --name-only
git show --name-only

# Branch info
git branch -v
git status --porcelain
```

## Decision Framework

### Before Any Action Ask:
1. **What am I trying to achieve?**
2. **What already exists that I can build on?**
3. **What patterns should I follow?**
4. **What could this affect?**
5. **How will I verify success?**

### Red Flags (Stop and Explore More):
- Unfamiliar codebase structure
- No similar patterns found
- Many dependencies/references
- Complex existing logic
- No clear success criteria

### Green Lights (Safe to Proceed):
- Clear understanding of context
- Found similar patterns to follow
- Minimal impact scope
- Clear validation method
- Rollback plan ready

## Quick Reference

### Fast Exploration Commands
```bash
# Quick context
ls -la && pwd && git status

# Find examples
grep -r "keyword" . --include="*.md" | head -5

# Check patterns
find . -name "*pattern*" | head -10
```

### Validation Commands
```bash
# Test changes
git diff --name-only
npm test 2>/dev/null || echo "No npm tests"
python -m pytest 2>/dev/null || echo "No pytest"
```

## Remember
- **Better to explore twice than fix mistakes once**
- **Understanding context prevents breaking things**
- **Following existing patterns ensures consistency**
- **Validation early catches problems before they grow**

---
**Navigation:** [← Back to Processes](../PROCESSES.md) | [↑ System Home](../INDEX.md)
