# Framework Modification Workflow

## Purpose
Establish mandatory procedures for any modifications to CLAUDE.md or other core framework files to prevent violations and maintain system integrity.

## Scope
Applies to ALL modifications of:
- CLAUDE.md (global framework configuration)
- CLAUDE.local.md (local customizations)
- Core framework files in /core/
- System configuration files
- Agent definitions and templates

## MANDATORY WORKFLOW - NO EXCEPTIONS

### Phase 1: Pre-Modification Analysis

#### Step 1: Progressive Thinking (MANDATORY)
**THINK** → Initial analysis
- What change is needed?
- Why is it needed?
- What impact will it have?

**THINK HARD** → Deep analysis
- Review existing framework structure
- Identify integration points
- Consider edge cases

**THINK HARDER** → Strategic optimization
- Analyze performance implications
- Evaluate maintenance impact
- Assess scalability

**ULTRA THINK** → Meta-analysis
- Framework alignment verification
- System-wide impact assessment
- Optimization opportunities

#### Step 2: Context7 Research (MANDATORY)
```bash
# Research best practices for framework modifications
context7 "framework configuration best practices"
context7 "system configuration management"
context7 "CLAUDE.md modification patterns"
```

#### Step 3: TodoWrite Planning (MANDATORY)
Create atomic tasks:
1. Research framework modification patterns
2. Deploy framework-update-specialist agent
3. Validate current framework state
4. Plan modification implementation
5. Execute modification with agent
6. Validate framework coherence
7. Document changes and patterns
8. Commit with comprehensive message

### Phase 2: Agent Deployment (MANDATORY)

#### Step 1: Deploy Framework Update Specialist
```bash
# Deploy specialized agent for framework modifications
Task: "Act as a framework-update-specialist. You are modifying CLAUDE.md to [describe change]. 
Ensure:
1. Maintain framework hierarchy and structure
2. Preserve all existing functionality
3. Follow Simple and Easy Framework principles
4. Document all changes comprehensively
5. Validate framework coherence after modification"
```

#### Step 2: Deploy Validation Agent
```bash
# Deploy second agent for independent validation
Task: "Act as a framework-validation-specialist. Review the CLAUDE.md modifications for:
1. Structural integrity
2. Functional preservation
3. Integration compatibility
4. Documentation completeness
5. Framework coherence"
```

### Phase 3: Implementation (WITH AGENTS ONLY)

#### Step 1: Pre-modification Backup
```bash
# Create timestamped backup
cp CLAUDE.md CLAUDE.md.backup.$(date +%Y%m%d-%H%M%S)
```

#### Step 2: Execute Modification
- Agent performs the modification
- Maintains formatting consistency
- Preserves section hierarchy
- Updates version number if applicable

#### Step 3: Immediate Validation
```bash
# Validate structure
grep -n "^##" CLAUDE.md | head -20

# Check critical sections
grep "UNIVERSAL EXECUTION MANDATES" CLAUDE.md
grep "Progressive Think" CLAUDE.md
grep "Agent Deployment" CLAUDE.md
```

### Phase 4: Validation and Evidence (MANDATORY)

#### Step 1: Framework Coherence Tests
1. Verify all sections present
2. Confirm numbering sequences
3. Validate cross-references
4. Check formatting consistency

#### Step 2: Functional Testing
1. Test modified functionality
2. Verify existing features work
3. Confirm no regressions
4. Document test results

#### Step 3: Evidence Generation
```bash
# Generate diff evidence
git diff CLAUDE.md > modification-evidence.diff

# Create validation report
echo "Framework Modification Validation" > validation-report.md
echo "Date: $(date)" >> validation-report.md
echo "Changes: [describe]" >> validation-report.md
echo "Tests Passed: [list]" >> validation-report.md
```

### Phase 5: Documentation and Commit (MANDATORY)

#### Step 1: Document in Framework
If new pattern discovered, add to CLAUDE.md:
- Pattern description
- Usage guidelines
- Example implementation

#### Step 2: Create Comprehensive Commit
```bash
git add CLAUDE.md
git add work/[timestamp]-framework-modification/
git commit -m "$(cat <<'EOF'
Enhance framework with [modification description]

- Added: [what was added]
- Modified: [what was changed]
- Validated: [validation performed]
- Evidence: [evidence location]

Framework coherence maintained and validated.
All tests passing.

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

#### Step 3: Push Changes
```bash
git push origin main
```

## VIOLATION DETECTION TRIGGERS

### Automatic Red Flags
1. Direct Edit/MultiEdit to CLAUDE.md without agent
2. Missing Context7 research before modification
3. Absent Progressive Thinking documentation
4. No validation evidence generated
5. Incomplete commit messages

### Response to Violations
1. **IMMEDIATE STOP** - Halt all work
2. **Deploy System Guardian** - Activate protection protocols
3. **Document Violation** - Record pattern and context
4. **Revert if Necessary** - Restore from backup
5. **Proper Re-implementation** - Follow this workflow

## FRAMEWORK FILE PROTECTION MATRIX

| File Type | Protection Level | Required Agents | Validation Depth |
|-----------|-----------------|-----------------|------------------|
| CLAUDE.md | MAXIMUM | 2 (Update + Validate) | COMPREHENSIVE |
| Core Framework | HIGH | 2 (Specialist + Guardian) | THOROUGH |
| Agent Definitions | MEDIUM | 1 (Agent Specialist) | STANDARD |
| Documentation | STANDARD | 1 (Documentation Specialist) | BASIC |

## ENFORCEMENT MECHANISMS

### Preemptive Protection
1. TodoWrite must include framework modification tasks
2. Context7 must precede any framework file access
3. Agents must be deployed before file modification
4. Validation must occur before commit

### Active Monitoring
1. System Guardian personality auto-activates for framework files
2. Validation specialist deployed for all modifications
3. Evidence generation required for all changes
4. Commit message must document validation

## SUMMARY

**CRITICAL MANDATE**: NO framework modifications without following this workflow.

**REMEMBER**: 
- Framework files are system-critical
- Violations cause system instability
- Proper process prevents failures
- Agents ensure quality modifications

**ALWAYS**:
1. Think progressively (4 levels)
2. Research with Context7
3. Deploy specialized agents
4. Validate comprehensively
5. Document everything

This workflow ensures framework integrity, prevents violations, and maintains system stability.

---

**Workflow Version**: 1.0
**Created**: 2025-08-20
**Purpose**: Prevent framework modification violations
**Status**: ACTIVE AND MANDATORY