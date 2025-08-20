---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#execution-processes) for context, THEN navigate to this specific process


# Context7 Compliance Enforcement Workflow

**Context**: Mandatory enforcement workflow ensuring Context7 research occurs before any library implementation

---

## Overview

This workflow establishes automatic enforcement gates that prevent library implementation work from proceeding without proper Context7 research. It creates systematic checkpoints and automatic triggers.

## Mandatory Context7 Triggers

### Automatic Detection Patterns
**IF any of these patterns detected** → MANDATORY Context7 research required:

- **Library imports/requires** - Any import, require, or include statements
- **Framework configuration** - Config files for React, Vue, Angular, etc.
- **Package management** - package.json, requirements.txt, Gemfile changes
- **API integration** - HTTP clients, SDK usage, service integration
- **Database operations** - ORM usage, query builders, migrations
- **Testing frameworks** - Jest, pytest, RSpec configuration or usage
- **Build tools** - webpack, Vite, Rollup, Gulp configuration
- **Deployment tools** - Docker, Kubernetes, CI/CD pipeline setup

### Library Implementation Keywords
**IF these terms appear in user requests** → MANDATORY Context7 research:
- "implement", "integrate", "setup", "configure", "install"
- "use [library]", "add [framework]", "connect to [service]"
- "create with [tool]", "build using [library]"
- "migrate to [framework]", "upgrade [dependency]"

## Pre-Implementation Validation Gates

### Gate 1: Library Identification
```
BEFORE any implementation work:
1. Identify ALL libraries/frameworks involved
2. List each library requiring Context7 research
3. Verify library names and current versions
4. Check for deprecated or superseded libraries
```

### Gate 2: Context7 Research Requirement
```
FOR EACH identified library:
1. MUST resolve library ID using Context7
2. MUST retrieve current documentation
3. MUST review implementation patterns
4. MUST identify best practices and examples
5. MUST capture breaking changes and updates
```

### Gate 3: Implementation Approval
```
ONLY after Context7 research completed:
1. Verify research covers all implementation needs
2. Confirm understanding of current API patterns
3. Validate compatibility with project requirements
4. Document Context7 findings for reference
```

## Automatic Activation Protocol

### Request Analysis Phase
**IMMEDIATELY upon receiving user request:**

1. **Scan for library/framework mentions** in user message
2. **Check for implementation keywords** that trigger Context7
3. **Analyze code snippets** for external dependencies
4. **Identify configuration requirements** that need research

### Enforcement Decision Matrix
```
IF library work detected AND no Context7 research → BLOCK implementation
IF Context7 research incomplete → REQUIRE completion before proceeding  
IF Context7 research current → ALLOW implementation to proceed
IF Context7 research outdated → REQUIRE refresh before proceeding
```

### Blocking Implementation Protocol
**WHEN Context7 required but not completed:**

```
STOP Implementation Message:
"MANDATORY Context7 research required before proceeding with [library/framework] implementation.

REQUIRED STEPS:
1. Resolve library ID: [library name]
2. Retrieve current documentation
3. Review implementation patterns
4. Capture best practices and examples
5. Document research findings

Implementation blocked until Context7 research completed."
```

## Context7 Research Validation

### Research Completeness Checklist
- [ ] Library ID resolved using Context7 tool
- [ ] Current documentation retrieved (within last 6 months)
- [ ] Implementation patterns reviewed and understood
- [ ] Best practices identified and documented
- [ ] Breaking changes and updates noted
- [ ] Code examples studied and available for reference

### Research Quality Standards
1. **Current Information** - Documentation from last 6 months preferred
2. **Implementation Focus** - Patterns relevant to specific use case
3. **Best Practices** - Security, performance, maintainability considerations
4. **Integration Guidance** - How library works with project ecosystem
5. **Error Handling** - Common issues and resolution patterns

## Violation Prevention Measures

### Early Warning System
**DETECT potential Context7 violations:**

- User mentions library without research request
- Implementation begins without Context7 documentation
- Code references external APIs without research
- Configuration files modified without library research

### Automatic Course Correction
**WHEN violation detected:**

1. **Immediate STOP** - Halt current implementation work
2. **Context7 Requirement** - Specify exact research needed
3. **Implementation Block** - Prevent progress until research complete
4. **Research Guidance** - Provide Context7 usage instructions
5. **Validation Check** - Verify research completion before resuming

### Compliance Monitoring
**ONGOING verification:**

- Track Context7 usage patterns
- Monitor implementation quality post-research
- Identify gaps in research coverage
- Document successful research-to-implementation workflows

## Integration with Other Workflows

### TodoWrite Integration
**IF Context7 research required:**
```
Add Context7 tasks to TodoWrite:
1. Resolve [library] ID using Context7
2. Research current [library] documentation  
3. Review [library] implementation patterns
4. Document [library] best practices
5. Validate [library] integration approach
```

### Agent Deployment Integration
**IF specialized Context7 research needed:**
```
Deploy context7-research-specialist:
"Research [library] using Context7 for [specific use case]:
- Focus on [implementation area]
- Prioritize [specific features]
- Document [integration requirements]
- Validate [compatibility concerns]"
```

### TDD Integration
**AFTER Context7 research:**
```
Context7-Informed TDD Process:
1. Write tests based on Context7 documentation
2. Implement using Context7 patterns
3. Validate against Context7 best practices
4. Refactor using Context7 optimization guidance
```

## Success Criteria

- [ ] Context7 research completed for ALL libraries before implementation
- [ ] Current documentation retrieved and reviewed
- [ ] Implementation patterns understood and documented
- [ ] Best practices identified and integrated into approach
- [ ] No implementation work begins without proper Context7 research
- [ ] Context7 findings documented for team reference
- [ ] Implementation quality improved through proper research

## Emergency Override Protocol

**ONLY in genuine emergencies where Context7 unavailable:**

1. **Document emergency condition** requiring override
2. **Implement minimal viable solution** with explicit warnings
3. **Add technical debt tracking** for missing Context7 research
4. **Schedule Context7 research** as immediate post-emergency task
5. **Refactor implementation** once Context7 research completed

**Emergency Override Approval**: Must be explicitly requested and justified.

---

**Remember**: Context7 research is MANDATORY, not optional. No exceptions without emergency override approval.