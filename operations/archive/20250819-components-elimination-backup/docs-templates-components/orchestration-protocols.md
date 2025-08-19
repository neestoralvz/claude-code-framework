
[Previous: Study coordination strategies](agent-coordination-strategies.md) | [Return to components index](README.md) | [Study component usage](../../components/COMPONENT_USAGE.md) | [Next: Review parallel coordination](parallel-agent-coordination.md)

# ORCHESTRATION PROTOCOLS

⏺ **Principle**: All communication flows exclusively through the main orchestrating Claude instance, maintaining strict communication boundaries between system components.

## Communication Protocol Framework

### Authorized Communication Channels
- **User ↔ Main Claude Instance** - Direct bidirectional communication only
- **Main Claude Instance ↔ Task Tool Agents** - Delegation and reporting only
- **PROHIBITED: User ↔ Task Tool Agents** - No direct user-agent communication
- **PROHIBITED: Agent ↔ Agent** - No inter-agent communication

### Communication Flow Protocol
1. **User Request Intake** - Main instance receives and analyzes user requirements
2. **Task Orchestration** - Main instance determines delegation strategy
3. **Agent Deployment** - Main instance launches Task Tool with specific instructions
4. **Agent Execution** - Task Tool agent executes in isolation with provided context
5. **Result Integration** - Main instance receives agent output and validates
6. **User Communication** - Main instance presents integrated results to user

### Protocol Enforcement Rules
- **Main instance maintains conversation context** - Never lose user communication thread
- **All agent communication is unidirectional** - Agents report back, never initiate
- **No agent autonomy beyond task scope** - Agents execute only assigned instructions
- **User sees only integrated results** - Raw agent outputs are processed first

## Quality Oversight

⏺ **Principle**: Quality oversight implements [workflow.md validation phase](../principles/workflow.md#7-validation) through systematic main instance verification of all delegated work.

### Validation Standards
- **Framework compliance verification** - Ensure adherence to all principles
- **Technical quality assessment** - Validate implementation excellence
- **User requirement fulfillment** - Confirm complete task satisfaction
- **Integration compatibility** - Verify seamless workflow incorporation

### Main Instance Responsibilities
- **Never present unvalidated outputs** - Always verify before user presentation
- **Maintain quality consistency** - Ensure uniform standards across agents
- **Provide coherent communication** - Integrate agent results professionally
- **Preserve context continuity** - Maintain conversation flow and quality

### Continuous Improvement
- **Agent performance tracking** - Monitor effectiveness and efficiency
- **Pattern optimization** - Refine delegation strategies based on results
- **Catalog enhancement** - Improve agent selection through experience
- **Framework evolution** - Adapt orchestration methodology as needed

## Orchestration Methodology

### Core Orchestration Rules
- **Main instance retains user communication** - Never delegate direct user interaction
- **Deploy Task Tool for all complex operations** - Preserve main instance context
- **Coordinate multiple agent deployments** - Manage parallel and sequential task execution
- **Validate all agent outputs** - Ensure quality before user presentation

### Strategic Control Points
- **Task intake and analysis** - Main instance evaluates user requirements
- **Agent selection and deployment** - Strategic choice of specialized tools
- **Output integration and validation** - Quality assurance and coherent presentation
- **Workflow progression** - Phase management and completion tracking

## Protocol Implementation

### Agent Deployment Framework
⏺ **Principle**: The Task Tool serves as the exclusive mechanism for deploying specialized agents, with precise usage patterns defined for optimal orchestration.

#### Required Elements
1. **Contextual Background** - Provide complete task context in prompt parameter
2. **Specific Instructions** - Define exact deliverables and success criteria
3. **Framework Compliance** - Ensure agent follows all applicable principles
4. **Output Specifications** - Clarify expected format and integration requirements

#### Communication Constraints
- **No inter-agent communication** - Each agent operates in isolation
- **No user interaction** - Agents receive context only through Task Tool
- **Single output delivery** - Agents return results once to main instance
- **No state persistence** - Each deployment is stateless and independent

### Integration and Validation

#### Pre-Deployment Coordination
- **Extract delegation context** - Prepare comprehensive agent briefing
- **Define success criteria** - Establish clear validation requirements
- **Prepare integration strategy** - Plan result incorporation methodology
- **Set quality expectations** - Communicate framework compliance requirements

#### Post-Deployment Integration
- **Validate agent deliverables** - Verify quality and completeness
- **Integrate with main context** - Seamlessly incorporate results
- **Present coherent results** - Maintain user communication quality
- **Track completion status** - Update workflow progression

## Cross-References

### Primary Navigation
- [Return to components index](README.md)
- [Review component usage guidelines](../../components/COMPONENT_USAGE.md)
- [Study coordination strategies](agent-coordination-strategies.md)

### Related Components
- [Study task analysis framework](task-analysis-framework.md)
- [Review coordination strategies](agent-coordination-strategies.md)
- [Apply workflow phases](workflow-phases.md)

### Framework References
- [Apply communication principles](../../principles/communication.md)
- [Follow workflow methodology](../../principles/workflow.md)
- [Study directive principles](../../principles/directive.md)

[⬆ Return to top](#orchestration-protocols)
