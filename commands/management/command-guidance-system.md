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

**Execute continuous guidance optimization and personalization:**

#### Learning Framework Integration
```
Guidance Learning System:
1. Recommendation Outcome Tracking
   ├─ User acceptance rate of recommendations
   ├─ Command execution success following guidance
   ├─ Task completion efficiency with guidance
   └─ User satisfaction with recommendation quality

2. Context Pattern Recognition
   ├─ Successful context-recommendation patterns
   ├─ Failed recommendation scenarios analysis
   ├─ User preference pattern identification
   └─ System state correlation with success

3. Adaptive Recommendation Enhancement
   ├─ Context weight adjustment based on outcomes
   ├─ Recommendation algorithm refinement
   ├─ Personalization parameter optimization
   └─ Success pattern reinforcement

4. Predictive Guidance Development
   ├─ User need prediction based on patterns
   ├─ Proactive recommendation preparation
   ├─ Context anticipation algorithms
   └─ Guidance delivery optimization
```

#### Personalization Engine
```
Personalization Framework:
├─ User Expertise Level Assessment
│  ├─ Beginner: Detailed guidance with explanations
│  ├─ Intermediate: Balanced guidance with options
│  ├─ Advanced: Concise guidance with alternatives
│  └─ Expert: Context-aware suggestions with minimal explanation
├─ Task Preference Pattern Learning
│  ├─ Preferred command categories identification
│  ├─ Working style pattern recognition
│  ├─ Efficiency preference optimization
│  └─ Quality vs speed preference analysis
├─ Context Sensitivity Adaptation
│  ├─ High context users: Detailed environmental analysis
│  ├─ Medium context users: Balanced context with focus
│  ├─ Low context users: Essential context only
│  └─ Context-minimal users: Direct recommendations
└─ Success Pattern Reinforcement
   ├─ Successful recommendation pattern emphasis
   ├─ Failed pattern avoidance
   ├─ Efficiency optimization based on history
   └─ Quality maintenance through pattern analysis
```

### Phase 4: Dynamic Guidance Delivery

**Execute intelligent, context-aware guidance presentation:**

#### Guidance Delivery Framework
```
Guidance Presentation System:
1. Urgency-Based Delivery
   ├─ Emergency: Immediate, critical guidance with clear action steps
   ├─ Urgent: Priority guidance with alternative options
   ├─ Standard: Comprehensive guidance with explanation
   └─ Background: Detailed guidance with learning opportunities

2. Complexity-Aware Presentation
   ├─ Simple Tasks: Direct command recommendation
   ├─ Moderate Tasks: Command sequence with rationale
   ├─ Complex Tasks: Analysis approach with multiple options
   └─ Unknown Tasks: Clarification guidance with diagnostic steps

3. Context-Sensitive Formatting
   ├─ High-Stakes Context: Detailed guidance with risk assessment
   ├─ Standard Context: Balanced guidance with options
   ├─ Learning Context: Educational guidance with explanations
   └─ Efficiency Context: Concise guidance with essential information

4. Interactive Guidance Features
   ├─ Confidence Scoring: Recommendation confidence levels
   ├─ Alternative Options: Multiple viable command choices
   ├─ Risk Assessment: Potential issues and mitigation
   └─ Success Prediction: Expected outcomes and benefits
```

#### Real-Time Guidance Adaptation
```
Dynamic Guidance Adjustment:
├─ System State Changes: Real-time guidance updates
├─ Context Evolution: Adaptive recommendation refinement
├─ User Feedback Integration: Immediate guidance improvement
└─ Performance Impact: Resource-aware guidance delivery

Guidance Quality Metrics:
├─ Relevance Score: Context-recommendation alignment
├─ Accuracy Score: Prediction vs actual outcome alignment
├─ Efficiency Score: Time-to-decision improvement
└─ Satisfaction Score: User experience quality measurement
```

## Integration Framework

### System Monitoring Integration
- **Real-Time State Monitor**: Current system state data for context analysis
- **System Monitor**: Performance metrics and health status for guidance
- **Protocol Compliance Verifier**: Compliance status for enforcement guidance
- **Automatic Trigger System**: Proactive guidance based on trigger conditions

### Command Framework Integration
- **Command Reference Matrix**: Problem-command mapping for guidance generation
- **Intelligent Command Selection**: Advanced selection algorithms for recommendations
- **Problem Classification Matrix**: Severity-based guidance prioritization
- **All Commands**: Capability assessment for recommendation accuracy

### User Experience Integration
- **Context-Aware Delivery**: Guidance adapted to user expertise and preferences
- **Learning Integration**: Continuous improvement based on user interactions
- **Efficiency Optimization**: Reduced decision time through intelligent guidance
- **Quality Assurance**: Validated recommendations for optimal outcomes

## Performance Optimization

### Sub-Second Guidance Generation
```
Performance Targets:
├─ Context Analysis: < 100ms (system state and history evaluation)
├─ Recommendation Generation: < 200ms (command assessment and ranking)
├─ Guidance Formatting: < 100ms (presentation and delivery preparation)
└─ Total Delivery Time: < 400ms (with 100ms buffer for sub-500ms delivery)
```

### Efficiency Framework
```
Optimization Strategies:
├─ Intelligent Caching: Pre-computed guidance for common scenarios
├─ Pattern Recognition: Fast pattern matching for context analysis
├─ Parallel Processing: Concurrent recommendation evaluation
└─ Resource Awareness: Guidance complexity adapted to system load
```

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