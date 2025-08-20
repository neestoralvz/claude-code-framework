# Strategic Orchestration Workflow
**Context**: Agent coordination and strategic decision-making process for complex multi-agent operations
---

**IF reading individually** → READ [PROCESSES.md](../PROCESSES.md#workflow-processes) for context, THEN navigate to this specific process


## When To Use
- Agent coordination needed
- Complex multi-step operations requiring orchestration
- Strategic decisions about resource allocation
- Multiple tactical work streams need coordination

## Strategic Orchestrator Role
Operate exclusively at strategic level - make decisions, coordinate agents, synthesize outcomes. Deploy specialized agents for ALL tactical work including analysis, implementation, and validation. Consume only executive summaries from agents to preserve cognitive load for strategic decisions.

## Task Tool Protocol
- Use Task Tool for ALL tasks without exception
- Maintain cognitive load efficiency - I orchestrate, agents execute
- Create Front Engineering approach for ultra-specific task definition
- Provide direct file references and specific sections to agents
- Use operations/ folder with timestamped subfolders for intermediate work
- Final deliverables executed by standards-expert agents
- Evidence-based success criteria that are verifiable and transparent
- Restart requirement if 100% compliance not achieved

## Strategic Decision Framework
- **Strategic vs Tactical Classification**: Classify all work as Strategic (orchestrator) vs Tactical (agent)
- **Cognitive Load Protection**: Consume only executive summaries, never tactical details
- **Strategic Context Continuity**: Maintain big-picture perspective across all agent deployments
- **Agent Briefing Protocol**: Provide strategic context, objectives, and executive summary requirements

## Decision Points
Decision points occur when agents identify:
- Multiple strategic options
- Resource allocation needs
- Priority conflicts
- Integration requirements

**Decision Process**: 
1. Synthesize agent summaries
2. Analyze strategic alternatives
3. Assess implications
4. Choose direction
5. Deploy agents to execute
6. Document decisions for strategic continuity

## Strategic Reporting Standards
All agents must provide executive summaries containing:
- **Strategic Impact Summary**: objective achievement, decisions required, risks, next steps
- **Key Insights**: strategic implications only
- **Tactical Details Location**: for reference but not consumption

Orchestrator reads ONLY strategic summaries to maintain cognitive focus.

## Cross-Conversation Agent Deployment
When created agents aren't available in current conversation context, provide complete deployment message for new conversation:
- Include: current status, direct file references, specific agent to deploy, mission objectives, success criteria
- Format: Clear instructions that enable immediate agent deployment in fresh context
- Always specify exact agent ID from registry and required deliverable location
- Provide operations/ timestamped subdirectory instruction for intermediate work

### Strategic Context Transfer
- Include high-level objectives, strategic constraints, and decision history
- Executive Summary Requirements: Specify strategic impact focus, not tactical details
- Decision Point Clarity: Define what strategic decisions may be required from agent work

## TDD/BDD Agent Validation Standards

### Orchestrator Validation Requirements

**Agent Deployment with TDD/BDD Compliance:**
- **Pre-Deployment Validation**: Ensure agents understand TDD/BDD requirements
- **Execution Monitoring**: Continuous validation of agent TDD/BDD compliance
- **Evidence Collection**: Systematic collection of validation evidence from agents
- **Quality Gate Enforcement**: Mandatory quality gates with evidence requirements

**Strategic Decision Validation:**
```yaml
strategic_validation_framework:
  agent_selection_validation:
    - tdd_bdd_capability: agents_must_demonstrate_compliance
    - evidence_collection_ability: agents_must_provide_comprehensive_evidence
    - cross_validation_participation: agents_must_validate_peer_outputs
  coordination_validation:
    - parallel_execution_evidence: proof_of_coordinated_execution
    - integration_success_evidence: proof_of_successful_integration
    - quality_consistency_evidence: proof_of_uniform_quality_standards
```

### Multi-Agent Evidence Synthesis

**Strategic Evidence Requirements:**
- **Agent Individual Evidence**: TDD/BDD compliance proof from each agent
- **Cross-Agent Validation Evidence**: Proof of successful agent-to-agent validation
- **System Integration Evidence**: Proof of successful multi-agent system integration
- **Quality Assurance Evidence**: Proof that all quality standards are met consistently

**Evidence-Based Strategic Decisions:**
- All strategic decisions must be supported by agent-provided evidence
- Quality gates must be validated with comprehensive evidence packages
- Integration decisions must be backed by cross-agent validation results
- Resource allocation decisions must consider agent validation capacity

## Related Documentation
When using this workflow, READ these files as needed:
- **Agent Creation**: READ operations/20250819-192114-agent-template-creation/ for templates and deployment guidelines
- **Agent Registry**: READ agents/registry/ for available specialized agents
- **Agent Coordination TDD**: READ [agent-coordination-tdd-workflow.md](agent-coordination-tdd-workflow.md) for comprehensive multi-agent TDD/BDD integration
- **Parallel Agent Coordination**: READ [parallel-agent-coordination-workflow.md](parallel-agent-coordination-workflow.md) for cross-agent validation patterns
