
[Previous: Navigate to Documentation Hub](../../index.md) | [Return to documentation hub](../../index.md) | [Study multi-analysis system](../../../operations/storage-structure.md) | [Next: Review agent schemas](../../../agents/analytics/)

# MULTI-ANALYSIS JSON SCHEMA DOCUMENTATION

⏺ **Principle**: This documentation implements [engineering.md technical standards](../../principles/engineering.md) by defining comprehensive JSON schemas for multi-analysis system validation and consistency.

## Table of Contents
  - [Schema Overview](#schema-overview)
- [System Architecture](#system-architecture)
- [Schema Categories](#schema-categories)
  - [Analysis Agent Schemas](#analysis-agent-schemas)
- [Sales Analysis Schema](#sales-analysis-schema)
- [Exploration Analysis Schema](#exploration-analysis-schema)
- [Research Analysis Schema](#research-analysis-schema)
  - [Report Generator Schemas](#report-generator-schemas)
- [Consolidated Report Schema](#consolidated-report-schema)
- [Decision Matrix Schema](#decision-matrix-schema)
  - [Validation Standards](#validation-standards)
- [Schema Validation Rules](#schema-validation-rules)
- [Quality Metrics](#quality-metrics)
- [Error Handling](#error-handling)
  - [Integration Patterns](#integration-patterns)
- [Agent Output Flow](#agent-output-flow)
- [Report Generation Flow](#report-generation-flow)
- [Orchestrator Interface](#orchestrator-interface)
- [Error Recovery](#error-recovery)
  - [Usage Examples](#usage-examples)
- [Schema Validation Example](#schema-validation-example)
- [Cross-Schema Consistency Check](#cross-schema-consistency-check)
- [Report Schema Generation](#report-schema-generation)
  - [Cross-References](#cross-references)
- [Primary Navigation](#primary-navigation)
- [Related Documentation](#related-documentation)
- [Schema Files](#schema-files)
- [Integration Points](#integration-points)
- [Principle References](#principle-references)
- [Cross-References](#cross-references)

## Schema Overview

### System Architecture
```
User Request → Analysis Agents → JSON Outputs → Report Generator → Consolidated Reports → Orchestrator
```

### Schema Categories
1. **Analysis Schemas**: JSON structures for specialized analysis agents
2. **Report Schemas**: Consolidated report formats for orchestrator consumption
3. **Metadata Schemas**: Execution tracking and quality assessment
4. **Integration Schemas**: Cross-system communication formats

## Analysis Agent Schemas

### Sales Analysis Schema
**File**: `sales-analysis.json`
**Agent**: `sales-analyst.md`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Sales Analysis Output",
  "type": "object",
  "required": ["analysis_metadata", "sales_performance", "recommendations"],
  "properties": {
    "analysis_metadata": {
      "type": "object",
      "required": ["agent_type", "analysis_timestamp", "task_id", "confidence_score"],
      "properties": {
        "agent_type": { "type": "string", "enum": ["sales-analyst"] },
        "analysis_timestamp": { "type": "string", "format": "date-time" },
        "task_id": { "type": "string", "pattern": "^[a-zA-Z0-9-]+$" },
        "confidence_score": { "type": "number", "minimum": 0, "maximum": 1 },
        "data_sources": { "type": "array", "items": { "type": "string" } }
      }
    },
    "sales_performance": {
      "type": "object",
      "properties": {
        "revenue_metrics": {
          "type": "object",
          "properties": {
            "total_revenue": { "type": "number", "minimum": 0 },
            "revenue_growth": { "type": "number" },
            "revenue_by_segment": { "type": "object" }
          }
        },
        "conversion_metrics": {
          "type": "object",
          "properties": {
            "overall_conversion_rate": { "type": "number", "minimum": 0, "maximum": 1 },
            "funnel_conversion_rates": { "type": "object" },
            "conversion_trends": { "type": "array" }
          }
        }
      }
    },
    "recommendations": {
      "type": "object",
      "properties": {
        "immediate_actions": { "type": "array", "items": { "type": "string" } },
        "strategic_initiatives": { "type": "array", "items": { "type": "string" } },
        "risk_mitigation": { "type": "array", "items": { "type": "string" } },
        "growth_opportunities": { "type": "array", "items": { "type": "string" } }
      }
    }
  }
}
```

### Exploration Analysis Schema
**File**: `exploration-analysis.json`
**Agent**: `exploration-analyst.md`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Exploration Analysis Output",
  "type": "object",
  "required": ["analysis_metadata", "system_landscape", "recommendations"],
  "properties": {
    "analysis_metadata": {
      "type": "object",
      "required": ["agent_type", "analysis_timestamp", "task_id", "confidence_score"],
      "properties": {
        "agent_type": { "type": "string", "enum": ["exploration-analyst"] },
        "analysis_timestamp": { "type": "string", "format": "date-time" },
        "task_id": { "type": "string", "pattern": "^[a-zA-Z0-9-]+$" },
        "confidence_score": { "type": "number", "minimum": 0, "maximum": 1 },
        "exploration_scope": { "type": "string", "enum": ["system", "feature", "market", "technology"] },
        "coverage_percentage": { "type": "number", "minimum": 0, "maximum": 1 }
      }
    },
    "system_landscape": {
      "type": "object",
      "properties": {
        "architecture_overview": {
          "type": "object",
          "properties": {
            "system_type": { "type": "string", "enum": ["monolithic", "microservices", "hybrid"] },
            "technology_stack": { "type": "array", "items": { "type": "string" } },
            "deployment_model": { "type": "string", "enum": ["cloud", "on-premise", "hybrid"] },
            "scalability_patterns": { "type": "array", "items": { "type": "string" } }
          }
        }
      }
    },
    "recommendations": {
      "type": "object",
      "properties": {
        "immediate_wins": { "type": "array", "items": { "type": "string" } },
        "strategic_improvements": { "type": "array", "items": { "type": "string" } },
        "technology_adoption": { "type": "array", "items": { "type": "string" } },
        "architectural_changes": { "type": "array", "items": { "type": "string" } }
      }
    }
  }
}
```

### Research Analysis Schema
**File**: `research-analysis.json`
**Agent**: `research-analyst.md`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Research Analysis Output",
  "type": "object",
  "required": ["analysis_metadata", "research_scope", "findings_synthesis", "recommendations"],
  "properties": {
    "analysis_metadata": {
      "type": "object",
      "required": ["agent_type", "analysis_timestamp", "task_id", "confidence_score"],
      "properties": {
        "agent_type": { "type": "string", "enum": ["research-analyst"] },
        "analysis_timestamp": { "type": "string", "format": "date-time" },
        "task_id": { "type": "string", "pattern": "^[a-zA-Z0-9-]+$" },
        "confidence_score": { "type": "number", "minimum": 0, "maximum": 1 },
        "research_methodology": { "type": "string", "enum": ["systematic", "exploratory", "competitive", "academic"] },
        "evidence_quality": { "type": "string", "enum": ["high", "medium", "low"] }
      }
    },
    "research_scope": {
      "type": "object",
      "properties": {
        "research_questions": { "type": "array", "items": { "type": "string" } },
        "search_strategy": {
          "type": "object",
          "properties": {
            "keywords": { "type": "array", "items": { "type": "string" } },
            "databases": { "type": "array", "items": { "type": "string" } },
            "time_range": { "type": "string" },
            "inclusion_criteria": { "type": "array", "items": { "type": "string" } },
            "exclusion_criteria": { "type": "array", "items": { "type": "string" } }
          }
        }
      }
    },
    "findings_synthesis": {
      "type": "object",
      "properties": {
        "key_insights": { "type": "array", "items": { "type": "string" } },
        "emerging_trends": { "type": "array", "items": { "type": "string" } },
        "knowledge_gaps": { "type": "array", "items": { "type": "string" } }
      }
    },
    "recommendations": {
      "type": "object",
      "properties": {
        "strategic_direction": { "type": "array", "items": { "type": "string" } },
        "implementation_priorities": { "type": "array", "items": { "type": "string" } },
        "resource_requirements": { "type": "array", "items": { "type": "string" } }
      }
    }
  }
}
```

## Report Generator Schemas

### Consolidated Report Schema
**File**: `consolidated-report.json`
**Agent**: `report-generator.md`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Consolidated Analysis Report",
  "type": "object",
  "required": ["report_metadata", "executive_summary", "orchestrator_guidance"],
  "properties": {
    "report_metadata": {
      "type": "object",
      "required": ["generator", "generation_timestamp", "conversation_id", "synthesis_confidence"],
      "properties": {
        "generator": { "type": "string", "enum": ["report-generator"] },
        "generation_timestamp": { "type": "string", "format": "date-time" },
        "conversation_id": { "type": "string", "pattern": "^conv-[a-zA-Z0-9-]+$" },
        "task_id": { "type": "string" },
        "input_analyses": { "type": "array", "items": { "type": "string" } },
        "synthesis_confidence": { "type": "number", "minimum": 0, "maximum": 1 },
        "completeness_score": { "type": "number", "minimum": 0, "maximum": 1 }
      }
    },
    "executive_summary": {
      "type": "object",
      "properties": {
        "key_findings": { "type": "array", "items": { "type": "string" } },
        "strategic_recommendations": { "type": "array", "items": { "type": "string" } },
        "immediate_actions": { "type": "array", "items": { "type": "string" } },
        "risk_alerts": { "type": "array", "items": { "type": "string" } },
        "opportunity_highlights": { "type": "array", "items": { "type": "string" } }
      }
    },
    "orchestrator_guidance": {
      "type": "object",
      "required": ["recommended_action"],
      "properties": {
        "recommended_action": { "type": "string", "enum": ["immediate", "planned", "research_needed", "escalate"] },
        "command_suggestions": { "type": "array", "items": { "type": "string" } },
        "agent_deployment_needs": { "type": "array", "items": { "type": "string" } },
        "resource_requirements": { "type": "array", "items": { "type": "string" } },
        "timeline_estimate": { "type": "string", "enum": ["short", "medium", "long"] }
      }
    }
  }
}
```

### Decision Matrix Schema
**File**: `decision-matrix.json`
**Agent**: `report-generator.md`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Decision Support Matrix",
  "type": "object",
  "required": ["matrix_metadata", "decision_options", "evaluation_criteria", "recommendation_ranking"],
  "properties": {
    "matrix_metadata": {
      "type": "object",
      "required": ["generator", "generation_timestamp", "conversation_id"],
      "properties": {
        "generator": { "type": "string", "enum": ["report-generator"] },
        "generation_timestamp": { "type": "string", "format": "date-time" },
        "conversation_id": { "type": "string", "pattern": "^conv-[a-zA-Z0-9-]+$" },
        "decision_framework": { "type": "string", "default": "multi-criteria-analysis" }
      }
    },
    "decision_options": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "option_id": { "type": "string" },
          "option_name": { "type": "string" },
          "description": { "type": "string" },
          "estimated_effort": { "type": "string" },
          "expected_outcome": { "type": "string" }
        }
      }
    },
    "evaluation_criteria": {
      "type": "object",
      "patternProperties": {
        "^[a-z_]+$": {
          "type": "object",
          "properties": {
            "weight": { "type": "number", "minimum": 0, "maximum": 1 },
            "description": { "type": "string" }
          }
        }
      }
    },
    "recommendation_ranking": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "rank": { "type": "integer", "minimum": 1 },
          "option_id": { "type": "string" },
          "total_score": { "type": "number" },
          "confidence": { "type": "number", "minimum": 0, "maximum": 1 }
        }
      }
    }
  }
}
```

## Validation Standards

### Schema Validation Rules
1. **Required Fields**: All required fields must be present and non-null
2. **Data Types**: All fields must match specified data types
3. **Value Constraints**: Numeric fields must respect minimum/maximum constraints
4. **Format Validation**: Date-time and pattern fields must match specified formats
5. **Enum Validation**: Enumerated fields must contain only allowed values

### Quality Metrics
- **Completeness Score**: Percentage of optional fields populated
- **Confidence Score**: Agent's confidence in analysis accuracy (0-1)
- **Consistency Score**: Cross-analysis alignment measurement
- **Validation Status**: Schema compliance and quality assessment

### Error Handling
- **Schema Violations**: Log specific validation errors with field paths
- **Missing Data**: Handle gracefully with default values or null indicators
- **Type Mismatches**: Convert compatible types, reject incompatible data
- **Range Violations**: Clamp values to valid ranges with warnings

## Integration Patterns

### Agent Output Flow
```
Analysis Agent → Validate Schema → Store JSON → Notify Report Generator
```

### Report Generation Flow
```
Multiple JSON Inputs → Schema Validation → Cross-Analysis → Generate Reports → Validate Output
```

### Orchestrator Interface
```
Read Reports → Parse JSON → Validate Schema → Extract Guidance → Make Decisions
```

### Error Recovery
```
Schema Error → Log Details → Use Fallback Values → Continue Processing → Flag for Review
```

## Usage Examples

### Schema Validation Example
```javascript
// Validate sales analysis output
const salesSchema = require('./schemas/sales-analysis.json');
const Ajv = require('ajv');
const ajv = new Ajv();

const validate = ajv.compile(salesSchema);
const isValid = validate(salesAnalysisData);

if (!isValid) {
  console.log('Validation errors:', validate.errors);
}
```

### Cross-Schema Consistency Check
```javascript
// Ensure all analysis outputs have compatible metadata
function validateCrossAnalysisConsistency(analyses) {
  const taskIds = analyses.map(a => a.analysis_metadata.task_id);
  const uniqueTaskIds = [...new Set(taskIds)];
  
  if (uniqueTaskIds.length !== 1) {
    throw new Error('Inconsistent task IDs across analyses');
  }
}
```

### Report Schema Generation
```javascript
// Generate consolidated report with schema validation
function generateConsolidatedReport(analyses) {
  const report = {
    report_metadata: {
      generator: 'report-generator',
      generation_timestamp: new Date().toISOString(),
      conversation_id: analyses[0].analysis_metadata.conversation_id,
      input_analyses: analyses.map(a => a.analysis_metadata.agent_type),
      synthesis_confidence: calculateSynthesisConfidence(analyses)
    },
    // ... rest of report structure
  };
  
  validateReportSchema(report);
  return report;
}
```

[⬆ Return to top](#multi-analysis-json-schema-documentation)

## Cross-References

### Primary Navigation
- [Return to Documentation Hub](../index.md)
- [Study Multi-Analysis System](../../../../operations/storage-structure.md)
- [Review Analysis Agents](../../agents/analytics/)
- [Study Report Generator](../../../agents/analytics/report-generator.md)

### Related Documentation
- [Apply engineering.md technical standards](../../principles/engineering.md)
- [Study agent-selection.md for coordination](../../principles/agent-selection.md)
- [Review workflow.md for systematic execution](../../principles/workflow.md)

### Schema Files
- [Sales Analysis Agent](../../../agents/analytics/sales-analyst.md)
- [Exploration Analysis Agent](../../../agents/analytics/exploration-analyst.md)
- [Research Analysis Agent](../../../agents/analytics/research-analyst.md)
- [Report Generator Agent](../../../agents/analytics/report-generator.md)

### Integration Points
- [Operations Storage Structure](../../../../operations/storage-structure.md)
- [Multi-Analysis Command Integration](../../commands/orchestration/)
- [Agent Coordination Patterns](../../principles/agent-selection.md)

[⬆ Return to top](#multi-analysis-json-schema-documentation)