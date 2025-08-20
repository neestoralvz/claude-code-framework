# Medical Bibliography Verification Agent Templates

**Project:** Picadura de Alacrán (Scorpion Sting) Medical Bibliography Verification System  
**Created:** 2025-08-20  
**Framework:** Claude Code Specialized Agent Architecture  

## Overview

This package contains 5 specialized medical agent templates designed for systematic verification, research, and organization of scorpion sting medical literature. Each agent is purpose-built with domain-specific expertise and evidence-based validation protocols.

## Agent Template Files

### Core Medical Agents (Opus Model)
- **`medical-bibliography-verifier.md`** - Medical reference accuracy and credibility verification
- **`medical-literature-researcher.md`** - Comprehensive medical literature search and analysis

### Support Agents (Sonnet Model)  
- **`bibliography-link-tester.md`** - Link accessibility and functionality validation
- **`medical-reference-consolidator.md`** - Reference organization and database management
- **`presentation-bibliography-formatter.md`** - Presentation-ready bibliography formatting

### Documentation
- **`DEPLOYMENT-GUIDELINES.md`** - Complete deployment and validation framework
- **`README.md`** - This overview document

## Quick Deployment

1. Create medical agent directory:
   ```bash
   mkdir -p ~/.claude/agents/medical
   ```

2. Copy all agent templates:
   ```bash
   cp *.md ~/.claude/agents/medical/
   ```

3. Verify deployment:
   ```
   /agents list
   ```

## Agent Specializations

| Agent | Model | Color | Primary Function |
|-------|--------|-------|-----------------|
| medical-bibliography-verifier | opus | red | Medical accuracy verification |
| medical-literature-researcher | opus | blue | Comprehensive literature research |
| bibliography-link-tester | sonnet | green | Link validation and testing |
| medical-reference-consolidator | sonnet | purple | Reference organization |
| presentation-bibliography-formatter | sonnet | orange | Bibliography formatting |

## Workflow Integration

**Sequential Processing Pipeline:**
1. **Research Phase:** medical-literature-researcher conducts comprehensive searches
2. **Verification Phase:** medical-bibliography-verifier validates accuracy and credibility  
3. **Testing Phase:** bibliography-link-tester ensures accessibility
4. **Organization Phase:** medical-reference-consolidator structures references
5. **Presentation Phase:** presentation-bibliography-formatter creates deliverables

## Evidence-Based Standards

All agents implement:
- Medical accuracy validation (95% threshold)
- Evidence-based methodology compliance
- Scorpion sting domain specialization
- Quality assurance protocols
- Integration validation requirements

## Template Architecture Features

- **Standardized YAML Frontmatter:** Consistent agent configuration
- **Medical Domain Expertise:** Specialized knowledge for scorpion sting literature
- **Evidence-Based Protocols:** Systematic validation and quality assurance
- **Integration Framework:** Seamless agent collaboration workflows
- **Quality Metrics:** Measurable success criteria and validation requirements

## Usage Instructions

Deploy these templates as functional agents in the Claude Code system to enable specialized medical bibliography verification capabilities for scorpion sting research projects.

See `DEPLOYMENT-GUIDELINES.md` for detailed deployment and validation procedures.