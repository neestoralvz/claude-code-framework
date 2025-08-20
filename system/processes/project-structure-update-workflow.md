
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


# Project Structure Update Workflow

**Context**: Workflow process defining procedural steps and execution patterns



## Purpose
Update and reorganize project structure efficiently while preserving functionality.

## Workflow Steps

### 1. Analysis Phase
```bash
# Analyze current structure
find . -type f -name "*.md" | head -20
ls -la
git status
```

### 2. Planning Phase
- Document current structure
- Define target structure
- Identify files to move/rename/consolidate
- Plan validation steps

### 3. Backup Phase
```bash
# Create backup
git add .
git commit -m "Backup before structure update"
```

### 4. Execution Phase
```bash
# Create new directories
mkdir -p target/directory/structure

# Move files
mv source/file target/directory/

# Update references
find . -name "*.md" -exec sed -i 's/old-path/new-path/g' {} \;
```

### 5. Validation Phase
```bash
# Test structure
ls -la target/directory/
git status
# Verify links work
# Test functionality
```

### 6. Cleanup Phase
```bash
# Remove empty directories
find . -type d -empty -delete

# Commit changes
git add .
git commit -m "Update project structure"
```

## Quick Commands

### Structure Analysis
```bash
tree -L 3
find . -type f | wc -l
du -sh */ 2>/dev/null
```

### File Operations
```bash
# Bulk move
find source/ -name "*.md" -exec mv {} target/ \;

# Bulk rename
for file in *.old; do mv "$file" "${file%.old}.new"; done
```

### Validation
```bash
# Check broken links
grep -r "\[.*\](" . --include="*.md" | grep -v "http"

# Verify git tracking
git ls-files | wc -l
```

## Best Practices
- Always backup before major changes
- Update one section at a time
- Validate after each major change
- Keep commit history clean
- Test functionality after moves

---
