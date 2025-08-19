---
title: "CLAUDE.md Validation Templates"
author: "Claude Code System"
date: "2025-08-18"
version: "2.0.0"
dependencies: ["../claude-md-templates.md", "claude-md-generation.md"]
prerequisites: ["Understanding of CLAUDE.md structure", "Basic validation principles"]
audience: "Project developers and quality assurance teams"
purpose: "Provide focused validation templates and testing tools for CLAUDE.md quality assurance"
keywords: ["claude-md", "validation", "testing", "quality", "checklists"]
last_review: "2025-08-18"
---

[Previous: Study claude-md-generation.md for automation](claude-md-generation.md) | [Return to hub for navigation](../../index.md) | [Review PRINCIPLES.md for framework](../../PRINCIPLES.md) | [Next: Browse templates index for overview](../templates/)

# CLAUDE.md VALIDATION TEMPLATES

## Table of Contents
- [Purpose](#purpose)
- [Architecture](#architecture)
- [Available Components](#available-components)
- [Usage Guidelines](#usage-guidelines)
- [Implementation Guide](#implementation-guide)
- [Benefits](#benefits)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Purpose

⏺ **Principle**: This component implements [engineering.md](../../principles/engineering.md) quality standards by providing systematic validation approaches that ensure CLAUDE.md files meet operational framework requirements.

Provide focused validation templates and testing tools to ensure CLAUDE.md files meet quality standards and integrate properly with the operational framework.

## Quality Checklists

### Pre-Implementation Validation
```markdown
## CLAUDE.md Quality Checklist - Pre-Implementation

### Framework Integration
- [ ] Project-specific focus confirmed (not abstract framework creation)
- [ ] All referenced commands exist and are accessible
- [ ] All referenced agents exist and are properly configured
- [ ] Structure follows operational framework standards
- [ ] Integration points clearly defined and functional

### Content Quality
- [ ] Length under 200 lines (recommended maximum)
- [ ] Project context clearly defined
- [ ] Technical requirements specific and measurable
- [ ] Workflow integration explicit and actionable
- [ ] No generic placeholder content

### Link Validation
- [ ] All command links functional: [command-name.md](commands/command-name.md)
- [ ] All agent links functional: [agent-name.md](agents/agent-name.md)
- [ ] All principle links functional: [principle.md](docs/principles/principle.md)
- [ ] Internal project paths verified and accessible
- [ ] No broken or circular references
```

### Post-Implementation Validation
```markdown
## CLAUDE.md Quality Checklist - Post-Implementation

### Operational Testing
- [ ] Enhances development workflow (team confirmation)
- [ ] No conflicts with core functionality
- [ ] All commands execute successfully in project context
- [ ] All paths and directories accessible
- [ ] Test commands run without errors

### Team Integration
- [ ] Team members understand immediately upon reading
- [ ] New team members can onboard using CLAUDE.md
- [ ] Instructions lead to successful task completion
- [ ] No confusion about project-specific requirements

### Maintenance Planning
- [ ] Regular maintenance plan established
- [ ] Update triggers identified (dependency changes, etc.)
- [ ] Responsibility for maintenance assigned
- [ ] Version control integration working
```

### Framework Compliance Validation
```markdown
## Framework Compliance Checklist

### Required Sections
- [ ] **Operational Framework Integration** section present
- [ ] **Project Context** clearly defined
- [ ] **Key Directories & Framework Alignment** specified
- [ ] **Workflow Integration** with phase references
- [ ] **Critical Project Requirements** (1-3 constraints)

### Required Framework References
- [ ] References [workflow.md](docs/principles/workflow.md) for phases
- [ ] Links to [commands/](commands/) directory
- [ ] Connects to [agents/](agents/) for complex tasks
- [ ] Cites [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for organization
- [ ] Applies relevant [principles](docs/principles/) for methodology
```

## Integration Testing

### Basic Integration Test Script
```bash
#!/bin/bash
# test-claude-md-integration.sh
echo "🔍 Testing CLAUDE.md integration..."

# Test file existence
[ -f "CLAUDE.md" ] && echo "✅ File exists" || { echo "❌ File missing"; exit 1; }

# Test framework references
grep -q "docs/principles/workflow.md" CLAUDE.md && echo "✅ Workflow reference" || echo "❌ Missing workflow"
grep -q "commands/" CLAUDE.md && echo "✅ Commands reference" || echo "❌ Missing commands"
grep -q "agents/" CLAUDE.md && echo "✅ Agents reference" || echo "❌ Missing agents"

# Test file size
lines=$(wc -l < CLAUDE.md)
if [ "$lines" -le 200 ]; then
    echo "✅ Optimal size: $lines lines"
elif [ "$lines" -le 300 ]; then
    echo "⚠️  Acceptable size: $lines lines"
else
    echo "❌ Too large: $lines lines"
fi

echo "✅ Integration test complete"
```

### Advanced Integration Tests
- **Framework Link Integrity**: Validate all framework references
- **Command Execution**: Test build and deployment commands  
- **Project Structure**: Verify PROJECT_STRUCTURE.md alignment

*(Complete test implementations available in repository)*

## Automated Validation

### GitHub Actions Validation
**Workflow Features**:
- Automatic validation on push/PR
- File size enforcement
- Framework reference validation
- Integration test execution

### Pre-commit Hooks
**Local Validation**:
- Run validation before commits
- Prevent broken CLAUDE.md commits
- Quick feedback during development

### Performance Validation
**Metrics Tested**:
- File read performance
- Complexity analysis (lines, words, characters)
- Readability scoring (words per line)
- Link density validation

*(Complete automation configurations available in repository)*

## Critical Validation Rule

**Every CLAUDE.md file must answer: "What do I do?" and "Why does this project need specific instructions?"**

If these questions aren't clearly answered, the file violates the project-specific principle and must be revised.

[⬆ Return to top](#claude-md-validation-templates)

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub](../../index.md)
- [Study claude-md-templates.md for base structure](../claude-md-templates.md)
- [Apply claude-md-generation.md for automation](claude-md-generation.md)
- [Browse templates index for overview](../templates/)

### Related Principles
- [Apply engineering.md for quality standards](../../principles/engineering.md)
- [Follow workflow.md for systematic validation](../../principles/workflow.md)
- [Use fundamental.md for simplicity](../../principles/fundamental.md)

### Related Components
- [Study claude-md-templates.md for base patterns](../claude-md-templates.md)
- [Apply engineering-standards.md for quality](../engineering-standards.md)
- [Follow workflow-phases.md for execution](../workflow-phases.md)

[⬆ Return to top](#claude-md-validation-templates)