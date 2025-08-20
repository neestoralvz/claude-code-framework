---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process

# Command Creation Workflow

**Purpose**: Systematic process for creating, validating, and integrating new framework commands while maintaining consistency, usability, and Simple and Easy principles.

**When to Use**: When creating new user-facing commands for CLAUDE.md command system integration.

**Strategic Value**: Ensures command consistency, prevents framework fragmentation, maintains user experience quality through systematic validation and integration processes.

---

## Workflow Overview

**Command**: Create new framework command with systematic validation

**Framework Integration**: Maintains Simple and Easy Framework principles while ensuring command system coherence and cross-reference accuracy.

**Quality Assurance**: Multi-stage validation process ensures command meets usability, consistency, and integration standards.

---

## Step-by-Step Process

### Step 1: Command Design and Naming
**Objective**: Create intuitive, consistent command that follows framework principles

**Actions**:
1. **Identify Command Purpose**:
   - Define specific user need being addressed
   - Validate against existing command coverage
   - Ensure distinct value proposition

2. **Apply Naming Conventions**:
   - Use simple, intuitive verbs (done, recenter, status)
   - Avoid technical jargon or complex terms
   - Test naming against Simple and Easy principles
   - Validate name doesn't conflict with existing commands

3. **Design Command Interface**:
   - Define required parameters (minimize where possible)
   - Specify optional parameters with clear defaults
   - Design help text and usage examples
   - Plan error handling and validation messages

**Success Criteria**:
- Command name passes Simple and Easy validation
- Purpose clearly defined and non-overlapping
- Interface design supports immediate usability
- Naming conventions followed consistently

### Step 2: Command Documentation Creation
**Objective**: Create comprehensive command documentation following framework standards

**Actions**:
1. **Create Command File**: `/commands/[command-name].md`
   - Use standard command template structure
   - Include purpose, usage, examples, and process references
   - Add validation criteria and success metrics
   - Document integration points with other commands

2. **Write Clear Documentation**:
   - Purpose statement in one sentence
   - Usage examples with realistic scenarios
   - Parameter documentation with defaults
   - Integration workflow references
   - Troubleshooting and error handling guidance

3. **Cross-Reference Integration**:
   - Link to relevant workflow processes
   - Reference supporting framework documents
   - Include related command relationships
   - Add framework principle alignments

**Success Criteria**:
- Command documentation follows standard template
- All required sections completed with clear content
- Cross-references accurate and functional
- Examples demonstrate practical usage

### Step 3: CLAUDE.md Integration
**Objective**: Integrate new command into framework command system

**Actions**:
1. **Add Command Entry**:
   - Insert in appropriate CLAUDE.md section
   - Follow existing command formatting patterns
   - Include conditional logic (IF...THEN structure)
   - Add descriptive command purpose

2. **Validate Integration**:
   - Check command placement in logical grouping
   - Ensure formatting consistency with existing commands
   - Verify conditional logic accuracy
   - Test command discoverability

3. **Update Command Cross-References**:
   - Add references from related workflow processes
   - Update any affected documentation sections
   - Ensure bidirectional linking where appropriate
   - Validate reference accuracy

**Success Criteria**:
- Command properly integrated into CLAUDE.md structure
- Formatting consistent with existing patterns
- Cross-references maintain framework coherence
- Command easily discoverable by users

### Step 4: Framework Validation
**Objective**: Comprehensive validation of command integration and consistency

**Actions**:
1. **Consistency Validation**:
   - Verify command follows naming conventions
   - Check documentation template compliance
   - Validate cross-reference accuracy
   - Ensure framework principle alignment

2. **Integration Testing**:
   - Test command discoverability in CLAUDE.md
   - Validate workflow process references
   - Check for broken links or references
   - Verify example accuracy and usability

3. **Quality Assurance**:
   - Review against Simple and Easy principles
   - Validate user experience quality
   - Check for potential conflicts with existing commands
   - Ensure documentation clarity and completeness

**Success Criteria**:
- All validation checks pass without errors
- Framework consistency maintained
- No broken references or integration issues
- Quality standards met for user experience

### Step 5: Documentation and Commit
**Objective**: Complete command creation with proper version control and documentation

**Actions**:
1. **Create Comprehensive Commit**:
   - Stage all command-related files
   - Write descriptive commit message explaining command purpose
   - Include rationale for command creation
   - Reference any related issues or user requests

2. **Update Process Documentation**:
   - Add command to relevant process workflow lists
   - Update command count in framework documentation
   - Document command creation in session notes
   - Archive command creation rationale

3. **Validation Documentation**:
   - Document validation results
   - Record any issues encountered and resolutions
   - Note framework improvements or optimizations discovered
   - Update pattern registry with command creation insights

**Success Criteria**:
- Clean commit with comprehensive documentation
- Framework documentation updated accurately
- Command creation process documented for future reference
- Validation results archived for quality tracking

---

## Quality Gates

### Gate 1: Design Validation
- Command name passes Simple and Easy test
- Purpose clearly defined and non-overlapping
- Interface design supports immediate usability
- No conflicts with existing commands

### Gate 2: Documentation Quality
- All required documentation sections complete
- Examples demonstrate practical usage
- Cross-references accurate and functional
- Framework standards followed consistently

### Gate 3: Integration Validation
- CLAUDE.md integration follows existing patterns
- Cross-references maintain system coherence
- Command easily discoverable by users
- Framework consistency preserved

### Gate 4: System Validation
- All validation checks pass
- No broken references or integration issues
- Quality standards met for user experience
- Framework integrity maintained

---

## Success Metrics

**Technical Excellence**:
- Command creation completed without validation errors
- Framework consistency maintained throughout process
- All cross-references accurate and functional
- Documentation follows established standards

**User Experience**:
- Command name intuitive and discoverable
- Usage examples clear and practical
- Integration supports immediate usability
- Help and error messages provide clear guidance

**Framework Integration**:
- Simple and Easy principles followed consistently
- Command enhances rather than complicates framework
- Cross-references maintain system coherence
- Documentation supports framework evolution

---

## Integration with Framework

**CLAUDE.md Alignment**: Command creation process integrated with framework guidance system

**Simple and Easy Principles**: Every step validates against simplicity and usability criteria

**Quality Standards**: Comprehensive validation ensures command meets framework quality requirements

**Framework Evolution**: Command creation process contributes to systematic framework improvement

---

## Usage Examples

**New Session Management Command**:
```
Step 1: Design
- Purpose: Provide session status overview
- Name: "status" (simple, intuitive)
- Interface: status [optional: detailed]

Step 2: Documentation
- Create: commands/status.md
- Include: purpose, usage examples, workflow references

Step 3: Integration
- Add to CLAUDE.md Session Commands section
- Cross-reference with session-related workflows

Step 4: Validation
- Check naming consistency
- Verify cross-references
- Test discoverability

Step 5: Commit
- Stage files with descriptive commit
- Update framework documentation
- Document creation rationale
```

**Expected Outcomes**:
- New command integrated seamlessly into framework
- Framework consistency maintained
- User experience enhanced through systematic design
- Documentation supports immediate command adoption

---