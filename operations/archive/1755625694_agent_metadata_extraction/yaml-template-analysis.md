# AGENT YAML TEMPLATE SCHEMA ANALYSIS

## Progressive Thinking Analysis

**Think**: Initial analysis reveals a minimal YAML template structure focused on essential agent metadata fields.

**Think Hard**: Deeper examination shows the template emphasizes simplicity with only core operational fields (name, description, tools, model, color) while the broader framework includes standardized content structure and validation protocols.

## Template Schema Documentation

### Core YAML Structure

Based on analysis of `/Users/nalve/.claude/system/agents-docs/templates/agent-yaml-template.yaml`, the standardized agent metadata format contains:

```yaml
---
# CENTRALIZED AGENT YAML TEMPLATE

# STANDARD AGENT TEMPLATE STRUCTURE
agent_template:
  name: "{AGENT_NAME}"
  description: "{AGENT_DESCRIPTION}"
  tools: "{AGENT_TOOLS_ARRAY}"
  model: "{AGENT_MODEL}"
  color: "{AGENT_COLOR}"

---
```

### Extended Metadata Schema (From Frontmatter Template)

Additional analysis of `/Users/nalve/.claude/system/agents-docs/components/shared/frontmatter-template.yaml` reveals extended agent metadata options:

```yaml
# TEMPLATE PARA AGENTES (MINIMAL)
agent_template: |
  ---
  name: "{{AGENT_NAME}}"
  description: "{{DESCRIPTION}}"
  tools: [{{TOOLS}}]
  model: "{{MODEL}}"
  color: "{{COLOR}}"
  ---
```

### Field Definitions and Structure

#### Core Required Fields

1. **name**: `{AGENT_NAME}`
   - Purpose: Unique identifier for the agent
   - Format: String, kebab-case recommended
   - Example: "exploration-analyst", "backend-specialist"

2. **description**: `{AGENT_DESCRIPTION}`
   - Purpose: Brief functional description of agent capabilities
   - Format: String, concise explanation
   - Example: "System exploration and pattern analysis specialist"

3. **tools**: `{AGENT_TOOLS_ARRAY}`
   - Purpose: Array of tools the agent can access
   - Format: Array of strings
   - Example: ["Read", "Write", "Bash", "Grep"]

4. **model**: `{AGENT_MODEL}`
   - Purpose: AI model specification for the agent
   - Format: String, model identifier
   - Example: "claude-3-sonnet", "gpt-4"

5. **color**: `{AGENT_COLOR}`
   - Purpose: Visual identification color for UI/logging
   - Format: String, color name or hex code
   - Example: "blue", "#3498db"

### Agent Content Structure Framework

From analysis of existing agents, the metadata extraction should capture:

#### Structural Components

1. **Header Section**
   - Agent title (H1)
   - Specialist designation banner
   - Core role description

2. **Specialization Section**
   - Core competencies list
   - JSON output schema (if applicable)
   - Technical specifications

3. **Execution Protocol**
   - Input processing methodology
   - Framework workflow steps
   - Output generation requirements

4. **Quality Assurance**
   - Validation gates
   - Output standards
   - Quality checkpoints

5. **Integration Points**
   - System integration notes
   - File output specifications
   - Cross-agent coordination

### Metadata Extraction Schema

For systematic agent metadata collection, the following template structure should be used:

```yaml
extraction_schema:
  basic_metadata:
    name: "extracted from filename and title"
    description: "extracted from role description"
    category: "extracted from directory path"
    specialization: "extracted from core competencies"
    
  technical_metadata:
    tools: "inferred from agent capabilities"
    model: "default or specified model"
    color: "assigned based on category"
    output_format: "extracted from execution protocol"
    
  functional_metadata:
    core_responsibilities: "extracted from responsibilities section"
    execution_phases: "extracted from operational framework"
    validation_requirements: "extracted from quality assurance"
    integration_points: "extracted from integration section"
    
  structural_metadata:
    file_path: "full path to agent file"
    directory_category: "extracted from parent directories"
    last_modified: "file system timestamp"
    content_sections: "list of major content sections"
```

### Template Structure Validation

The analysis confirms that agent files should follow this hierarchy:

1. **YAML Frontmatter** (when present)
2. **Agent Title** (H1 header)
3. **Specialist Banner** (analysis-only designation)
4. **Role Description** (core purpose statement)
5. **Structured Content Sections** (varies by agent type)

### Implementation Notes

- Current agent files lack YAML frontmatter - metadata must be extracted from content
- Template emphasizes minimal metadata to avoid over-engineering
- Color and model fields may need default assignment during extraction
- Tools array should be inferred from agent capabilities and restrictions
- Category classification should be derived from directory structure

### Systematic Collection Strategy

For comprehensive agent metadata extraction:

1. **Directory Traversal**: Parse all `.md` files in agent directories
2. **Content Analysis**: Extract metadata from structured content sections
3. **Schema Mapping**: Map extracted data to YAML template fields
4. **Validation**: Ensure all required fields are populated
5. **Output Generation**: Create consolidated metadata registry

This template schema provides the foundation for systematic agent metadata extraction across the entire agent ecosystem.