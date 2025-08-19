
# Output Generation System

## Analysis Output Structure

```json
{
  "timestamp": "ISO-8601-format",
  "user_request": "original_user_request_text",
  "analysis_summary": {
    "complexity_level": "high|medium|low",
    "domain_classification": "development|infrastructure|documentation|analysis|mixed",
    "command_type": "atomic|orchestration|concatenation",
    "execution_pattern": "single|parallel|sequential",
    "coordination_requirements": "none|basic|advanced",
    "estimated_duration": "short|medium|long",
    "resource_intensity": "low|medium|high"
  },
  "agent_perspectives": {
    "general_purpose": {
      "complexity_assessment": "detailed_analysis",
      "technical_requirements": ["requirement1", "requirement2"],
      "execution_considerations": ["consideration1", "consideration2"],
      "risk_factors": ["risk1", "risk2"]
    },
    "ux_architect": {
      "user_experience_impact": "analysis_details",
      "interface_requirements": ["ui_req1", "ui_req2"],
      "accessibility_considerations": ["a11y1", "a11y2"],
      "design_pattern_opportunities": ["pattern1", "pattern2"]
    },
    "project_optimizer": {
      "architectural_impact": "analysis_details",
      "optimization_opportunities": ["opt1", "opt2"],
      "structural_considerations": ["struct1", "struct2"],
      "modularization_potential": ["mod1", "mod2"]
    },
    "system_auditor": {
      "compliance_requirements": ["comp1", "comp2"],
      "validation_needs": ["val1", "val2"],
      "quality_gates": ["gate1", "gate2"],
      "risk_assessment": "detailed_risk_analysis"
    },
    "delegation_advisor": {
      "command_recommendations": ["cmd1", "cmd2"],
      "agent_selection_rationale": "detailed_reasoning",
      "execution_path_analysis": "path_optimization_details",
      "resource_allocation_advice": ["resource1", "resource2"]
    }
  },
  "recommendations": {
    "primary_command": "/commands/category/optimal-command.md",
    "alternative_commands": ["/commands/alt1.md", "/commands/alt2.md"],
    "required_agents": ["agent1", "agent2"],
    "execution_sequence": "parallel|sequential|mixed",
    "confidence_score": 0.95,
    "rationale": "detailed_reasoning_for_recommendations"
  },
  "orchestrator_guidance": {
    "immediate_action": "execute_primary_command|request_clarification|generate_ticket",
    "preparation_steps": ["step1", "step2"],
    "success_criteria": ["criteria1", "criteria2"],
    "validation_requirements": ["val_req1", "val_req2"]
  }
}
```

## File Generation Protocol

1. **Analysis synthesis** from all agent perspectives
2. **Structured data generation** following defined schema
3. **File output** to `./operations/{conversation-id}/intent-analysis.json`
4. **Backup generation** to `./operations/{conversation-id}/intent-analysis-backup-{timestamp}.json`
5. **Orchestrator notification** with file location and summary
