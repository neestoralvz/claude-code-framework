
# Agent Component Usage Guide

## Overview
This guide explains how to use the modular agent components based on the `agent-architect.md` structure to create new agents following the exact pattern.

## Component Structure (Based on agent-architect.md)

### 1. Frontmatter (frontmatter-template.yaml)
Replace placeholders:
- `{{AGENT_NAME}}`: Kebab-case identifier (e.g., agent-architect)
- `{{COMPREHENSIVE_DESCRIPTION_WITH_EXAMPLES}}`: Full description with \n formatting and multiple <example> blocks
- `{{TOOLS_LIST}}`: Specific tools from available set
- `{{COLOR}}`: green, blue, yellow, red, or purple

### 2. Agent Identity (agent-identity-template.md)
Replace placeholders:
- `{{EXPERT_TITLE}}`: Your professional title
- `{{DOMAIN_EXPERTISE}}`: Your expertise domain
- `{{SPECIFIC_AREAS}}`: Specific areas of expertise
- `{{PRIMARY_OBJECTIVE}}`: Main objective
- `{{VALUE_PROPOSITION}}`: Value you provide

### 3. Core Operational Framework (operational-framework-architect-template.md)
5 phases, each with 3-5 actions:
- `{{PHASE_N_NAME}}`: Name of operational phase
- `{{ACTION_N_N}}`: Specific action in "You will/You [verb]" format
- `{{DELIVERABLES}}`: What you create
- `{{DELIVERABLE_N_N}}`: Specific deliverable items
- `{{QUALITY_ASPECT}}`: Quality to ensure
- `{{TRADEOFF}}`: Balance to maintain

### 4. Quality Assurance Protocol (qa-protocol-architect-template.md)
7 quality checks:
- `{{OUTPUT_TYPE}}`: What you're finalizing
- `{{VERIFICATION_POINT_N}}`: Verification criteria
- `{{VALIDATION_POINT_N}}`: Validation criteria
- `{{ASSURANCE_POINT_N}}`: Assurance criteria
- `{{CONFIRMATION_POINT_N}}`: Confirmation criteria
- `{{TEST_POINT_N}}`: Testing criteria
- `{{REVIEW_POINT_N}}`: Review criteria
- `{{FINAL_VALIDATION_N}}`: Final validation

### 5. Output Requirements (output-requirements-template.md)
8 required components:
- `{{OUTPUT_TYPE}}`: Type of deliverable
- `{{COMPONENT_N_NAME}}`: Component name
- `{{COMPONENT_N_DESCRIPTION}}`: Component description

### 6. Decision Principles (decision-principles-architect-template.md)
7 principles in "You [verb]" format:
- `{{PREFERENCE_1}}` / `{{ALTERNATIVE_1}}`: Favored vs alternative approach
- `{{PRIORITY_CONSIDERATION}}`: What to prioritize
- `{{EXISTING_BOUNDARIES}}`: What to respect
- `{{OPTIMIZATION_GOAL}}`: What to optimize for
- `{{COMPETING_NEEDS}}`: What to balance
- `{{DESIGN_CONSIDERATION}}`: Design focus
- `{{UNIQUE_VALUE}}`: Unique value to ensure

### 7. Edge Case Handling (edge-cases-architect-template.md)
5 scenarios in "For X: You Y" format:
- `{{SCENARIO_N}}`: Edge case scenario
- `{{ACTION_AND_PROTOCOL_N}}`: Specific action and protocol
- `{{DESIGN_APPROACH_N}}`: Design approach
- `{{OPTIMIZATION_STRATEGY_N}}`: Optimization strategy
- `{{ENHANCEMENT_APPROACH_N}}`: Enhancement approach
- `{{CLARIFICATION_PROCESS_N}}`: Clarification process

### 8. Continuous Improvement (continuous-improvement-template.md) - Optional
5 proactive actions:
- `{{IMPROVEMENT_AREA}}`: Area to identify improvements
- `{{ENHANCEMENT_TYPE}}`: Type of enhancements to suggest
- `{{KNOWLEDGE_CAPTURE}}`: What to document
- `{{OPTIMIZATION_STRATEGY}}`: What to propose
- `{{GAP_IDENTIFICATION}}`: What gaps to monitor

### 9. Closing Statement (closing-architect-template.md)
3 qualities, 3 standards, 2 principles:
- `{{QUALITY_N}}` / `{{APPROACH/METHOD/OUTPUT}}`: Three quality descriptors
- `{{DELIVERABLE}}`: What you create
- `{{STANDARD_N}}`: Three standards
- `{{IMPACT}}`: Direct impact
- `{{PRINCIPLE_N}}`: Two principles to maintain

## Assembly Process

To create a new agent following agent-architect.md structure:

1. Copy all component templates
2. Replace placeholders with domain-specific values
3. Assemble in exact order:
   - Frontmatter (YAML)
   - Agent Identity
   - Core Operational Framework (5 phases)
   - Quality Assurance Protocol (7 checks)
   - Output Requirements (8 components)
   - Decision Principles (7 principles)
   - Edge Case Handling (5 scenarios)
   - Continuous Improvement (5 actions - optional)
   - Closing Statement

## Structure Requirements

- **Operational Framework**: MUST have exactly 5 phases
- **Quality Assurance**: MUST have exactly 7 checks
- **Output Requirements**: MUST have exactly 8 components
- **Decision Principles**: MUST have exactly 7 principles
- **Edge Cases**: MUST have exactly 5 scenarios
- **Voice**: Use "You are/You will/You [verb]" throughout

## Example Usage

See `agent-architect.md` for the gold standard implementation.
See `AGENT_TEMPLATE.md` for a template with placeholders.

## Benefits

- **Consistency**: All agents follow agent-architect.md structure
- **Maintainability**: Single source of truth for agent structure
- **Efficiency**: Modular components eliminate duplication
- **Clarity**: Exact requirements (5 phases, 7 checks, 8 outputs, etc.)
- **Standards**: Gold standard from agent-architect.md

## Component Files

Active components based on agent-architect.md:
- [Use agent-identity-template.md for expert role and mission](agent-identity-template.md)
- [Apply operational-framework-architect-template.md for 5 operational phases](operational-framework-architect-template.md)
- [Follow qa-protocol-architect-template.md for 7 quality checks](qa-protocol-architect-template.md)
- [Implement output-requirements-template.md for 8 output components](output-requirements-template.md)
- [Apply decision-principles-architect-template.md for 7 decision principles](decision-principles-architect-template.md)
- [Handle edge-cases-architect-template.md for 5 edge case scenarios](edge-cases-architect-template.md)
- [Use continuous-improvement-template.md for 5 improvement actions (optional)](continuous-improvement-template.md)
- [Apply closing-architect-template.md for final characterization](closing-architect-template.md)

[Return to agents directory](../commands-docs/README.md) | [View AGENT_DEFINITION.md](../AGENT_DEFINITION.md)
