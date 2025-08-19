# Command Guidance System - Contextual Recommendations

⏺ **Principle**: Implement [directive.md ultimate authority](../../docs/principles/directive.md) through intelligent guidance delivery and apply [workflow.md systematic execution](../../docs/principles/workflow.md) for optimal command recommendation.

## Command Purpose

Provide comprehensive command guidance system that delivers contextual recommendations for manual command selection based on current system state, recent violations, enforcement history, and intelligent analysis of user requirements.

## Command Execution

### Phase 1: Contextual Analysis Engine

**Execute comprehensive context assessment for optimal guidance:**

#### System State Context Analysis
```
Context Analysis Framework:
┌─────────────────────┬──────────────────┬─────────────────┬────────────────────┐
│ Context Dimension   │ Data Sources     │ Analysis Method │ Guidance Impact    │
├─────────────────────┼──────────────────┼─────────────────┼────────────────────┤
│ Current System State│ Initialization  │ Real-time       │ High Priority      │
│ Recent Violations   │ Compliance Logs  │ Pattern Analysis│ Critical Influence │
│ Command History     │ Execution Logs   │ Success Patterns│ Medium Priority    │
│ User Patterns       │ Request Analysis │ Intent Recognition│ High Influence   │
│ Performance Metrics │ System Monitor   │ Trend Analysis  │ Medium Priority    │
│ Resource Status     │ Resource Monitor │ Availability    │ Low Priority       │
└─────────────────────┴──────────────────┴─────────────────┴────────────────────┘
```

#### Multi-Dimensional Context Evaluation
```
Context Assessment Matrix:

System Health Dimension:
├─ Initialization Status: Complete/Partial/Failed/Unknown
│  ├─ Complete (100%): Standard command recommendations
│  ├─ Partial (50-99%): Prioritize system-initialization.md
│  ├─ Failed (<50%): Emergency protocol guidance
│  └─ Unknown: Diagnostic command recommendations
├─ Compliance Status: Compliant/Minor Violations/Major Violations/Critical
│  ├─ Compliant: Full command selection available
│  ├─ Minor Violations: Enhanced monitoring guidance
│  ├─ Major Violations: Enforcement command priority
│  └─ Critical: Emergency intervention guidance
└─ Performance Status: Optimal/Good/Degraded/Critical
   ├─ Optimal: All commands available with efficiency focus
   ├─ Good: Standard recommendations with performance notes
   ├─ Degraded: Performance optimization command priority
   └─ Critical: Emergency performance intervention guidance

Task Context Dimension:
├─ Task Complexity: Simple/Moderate/Complex/Unknown
│  ├─ Simple: Single command recommendations
│  ├─ Moderate: Command sequence guidance
│  ├─ Complex: Multi-analysis and ticket creation guidance
│  └─ Unknown: Clarification and analysis command priority
├─ Task Type: Analysis/Management/Workflow/Enforcement/Generation
│  ├─ Analysis: system-audit.md, modularize.md priorities
│  ├─ Management: create-ticket.md, review-tickets.md focus
│  ├─ Workflow: workflow phase commands sequence
│  ├─ Enforcement: compliance and delegation commands
│  └─ Generation: creation commands with validation
└─ Task Urgency: Immediate/Urgent/Scheduled/Background
   ├─ Immediate: Emergency command guidance
   ├─ Urgent: High-priority command recommendations
   ├─ Scheduled: Optimal command selection with planning
   └─ Background: Optimization and maintenance commands
```

### Phase 2: Intelligent Recommendation Engine

**Execute context-aware command recommendation generation:**

#### Recommendation Algorithm Framework
```
Recommendation Generation Process:
1. Context Data Aggregation (< 100ms)
   ├─ System state snapshot capture
   ├─ Recent history analysis
   ├─ Performance metric evaluation
   └─ User pattern recognition

2. Command Capability Assessment (< 200ms)
   ├─ Available command evaluation
   ├─ Command-task fitness scoring
   ├─ Resource requirement analysis
   └─ Success probability calculation

3. Recommendation Ranking (< 150ms)
   ├─ Multi-criteria decision analysis
   ├─ Context-weighted scoring
   ├─ Risk assessment integration
   └─ Confidence score calculation

4. Guidance Generation (< 100ms)
   ├─ Primary recommendation selection
   ├─ Alternative option identification
   ├─ Contextual explanation creation
   └─ Next-step guidance preparation
```

#### Command Recommendation Matrix
```
Primary Command Categories with Context-Aware Recommendations:

System Analysis Commands:
├─ system-audit.md
│  ├─ Recommended When:
│  │  ├─ System issues detected or suspected
│  │  ├─ New codebase or unfamiliar environment
│  │  ├─ Baseline establishment needed
│  │  └─ Comprehensive analysis required
│  ├─ Context Indicators:
│  │  ├─ Recent violations or errors
│  │  ├─ Performance degradation patterns
│  │  ├─ Unknown system state
│  │  └─ Complex problem identification needed
│  ├─ Guidance Message: "Comprehensive system analysis for issue discovery and baseline establishment"
│  └─ Next Steps: "Review generated tickets and execute priority recommendations"
├─ modularize.md
│  ├─ Recommended When:
│  │  ├─ Large codebase complexity management
│  │  ├─ Component extraction required
│  │  ├─ Code organization issues identified
│  │  └─ Structural improvement needed
│  ├─ Context Indicators:
│  │  ├─ Code complexity violations detected
│  │  ├─ File size limit breaches
│  │  ├─ Maintenance difficulty reports
│  │  └─ Reusability improvement opportunities
│  ├─ Guidance Message: "Code organization and component extraction for improved maintainability"
│  └─ Next Steps: "Review extracted components and validate structural improvements"
└─ intelligent-command-selection.md
   ├─ Recommended When:
   │  ├─ Command selection uncertainty
   │  ├─ Multiple viable command options
   │  ├─ Selection optimization needed
   │  └─ Decision support required
   ├─ Context Indicators:
   │  ├─ User confusion or hesitation
   │  ├─ Suboptimal command history
   │  ├─ Complex task requirements
   │  └─ First-time user patterns
   ├─ Guidance Message: "Intelligent analysis for optimal command selection"
   └─ Next Steps: "Execute recommended command with confidence scoring"

Management Commands:
├─ create-ticket.md
│  ├─ Recommended When:
│  │  ├─ Complex multi-step tasks
│  │  ├─ Task organization needed
│  │  ├─ Priority management required
│  │  └─ Systematic tracking desired
│  ├─ Context Indicators:
│  │  ├─ Large or complex user requests
│  │  ├─ Multiple interconnected issues
│  │  ├─ Long-term project requirements
│  │  └─ Team coordination needs
│  ├─ Guidance Message: "Systematic task organization and priority management"
│  └─ Next Steps: "Review generated tickets and execute based on priority"
├─ system-initialization.md
│  ├─ Recommended When:
│  │  ├─ Session startup issues
│  │  ├─ Framework initialization problems
│  │  ├─ System recovery needed
│  │  └─ Foundation establishment required
│  ├─ Context Indicators:
│  │  ├─ Incomplete system initialization
│  │  ├─ Framework component failures
│  │  ├─ Authority hierarchy issues
│  │  └─ Core system instability
│  ├─ Guidance Message: "Complete system foundation establishment and framework activation"
│  └─ Next Steps: "Verify initialization success and proceed with task execution"
└─ command-reference-matrix.md
   ├─ Recommended When:
   │  ├─ Problem-command mapping needed
   │  ├─ Enforcement guidance required
   │  ├─ Complex decision support needed
   │  └─ Escalation pathway guidance
   ├─ Context Indicators:
   │  ├─ Problem identification without clear solution
   │  ├─ Violation response planning
   │  ├─ Multiple enforcement options
   │  └─ Systematic remediation needs
   ├─ Guidance Message: "Problem-to-command mapping for optimal resolution"
   └─ Next Steps: "Execute recommended command sequence with monitoring"
```

### Phase 3: Adaptive Guidance Learning

**Advanced learning systems and personalization detailed in**: [guidance-algorithms.md](guidance-algorithms.md)

Core learning capabilities:
- **Outcome Tracking**: Monitor recommendation success and user satisfaction
- **Pattern Recognition**: Identify successful context-recommendation patterns
- **Adaptive Enhancement**: Refine algorithms based on performance feedback
- **Predictive Development**: Anticipate user needs and prepare proactive guidance

### Phase 4: Dynamic Guidance Delivery  

**Dynamic delivery and integration systems detailed in**: [guidance-integrations.md](guidance-integrations.md)

Core delivery capabilities:
- **Urgency-Based Delivery**: Adapt presentation to task urgency
- **Complexity-Aware Presentation**: Match guidance detail to task complexity
- **Context-Sensitive Formatting**: Optimize guidance for user context
- **Real-Time Adaptation**: Update guidance based on changing conditions

## Integration Framework

**Comprehensive integration and performance optimization detailed in**: [guidance-integrations.md](guidance-integrations.md)

### Core Integration Points
- **System Monitoring**: Real-time state and compliance data integration
- **Command Framework**: Command capability assessment and mapping coordination
- **User Experience**: Context-aware delivery and optimization
- **Performance**: Sub-500ms guidance generation with resource efficiency

## Validation Requirements

**Phase 1 Validation:**
- [ ] Contextual analysis accurately assesses system state and user requirements
- [ ] Multi-dimensional evaluation provides comprehensive guidance foundation
- [ ] Context weighting appropriately influences recommendation quality
- [ ] Analysis engine operates efficiently with minimal resource overhead

**Phase 2 Validation:**
- [ ] Recommendation engine generates optimal command suggestions
- [ ] Command capability assessment accurately predicts success
- [ ] Ranking algorithm prioritizes recommendations effectively
- [ ] Guidance generation meets sub-500ms delivery requirements

**Phase 3 Validation:**
- [ ] Learning framework improves guidance quality over time
- [ ] Personalization enhances user experience and efficiency
- [ ] Adaptive optimization demonstrates measurable improvement
- [ ] Pattern recognition enables predictive guidance capabilities

**Phase 4 Validation:**
- [ ] Dynamic delivery adapts guidance to context and urgency
- [ ] Interactive features enhance decision-making quality
- [ ] Real-time adaptation maintains guidance relevance
- [ ] Quality metrics demonstrate continuous improvement

## Success Criteria

**Guidance Effectiveness:**
- Recommendation accuracy: Target >90% optimal command selection
- User acceptance rate: Target >85% guidance utilization
- Decision efficiency: Target >40% reduction in command selection time
- Task success rate: Target >95% successful task completion with guidance

**User Experience Quality:**
- Contextual relevance: Target >90% context-appropriate recommendations
- Personalization effectiveness: Target demonstrable improvement over time
- Delivery efficiency: Target <500ms guidance generation and delivery
- Satisfaction metrics: Target high user satisfaction with guidance quality

**System Integration:**
- Monitoring integration: Seamless real-time data flow from all monitoring systems
- Command framework coordination: Accurate capability assessment and recommendation
- Learning effectiveness: Continuous improvement in guidance quality
- Performance optimization: Minimal overhead with maximum guidance value

**Priority level: HIGH**
- Essential for optimal user experience and command selection efficiency
- Important for reducing user cognitive load and decision complexity
- Required for system accessibility and ease of use
- Key component for user adoption and framework effectiveness