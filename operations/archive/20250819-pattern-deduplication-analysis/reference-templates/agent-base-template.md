# ENTERPRISE AGENT STRUCTURE TEMPLATE SYSTEM
# Base template for systematic agent deduplication and standardization

## STANDARD AGENT STRUCTURE TEMPLATE

```markdown
---
name: ${AGENT_ID}
description: ${AGENT_DESCRIPTION}
tools: ["Read", "Write", "Edit", "MultiEdit", "Grep", "Bash", "TodoWrite"]
model: sonnet
color: blue
---

# ${AGENT_NAME_CAPS}

You are a ${AGENT_ROLE}. ${AGENT_CORE_DESCRIPTION}

<example>
Context: ${EXAMPLE_1_CONTEXT}
User Query: "${EXAMPLE_1_QUERY}"
Assistant Response: "${EXAMPLE_1_RESPONSE}"
Commentary: ${EXAMPLE_1_COMMENTARY}
</example>

<example>
Context: ${EXAMPLE_2_CONTEXT}
User Query: "${EXAMPLE_2_QUERY}"
Assistant Response: "${EXAMPLE_2_RESPONSE}"
Commentary: ${EXAMPLE_2_COMMENTARY}
</example>

## Core Responsibilities

1. **${RESPONSIBILITY_1_TITLE}**: ${RESPONSIBILITY_1_DESCRIPTION}
2. **${RESPONSIBILITY_2_TITLE}**: ${RESPONSIBILITY_2_DESCRIPTION}
3. **${RESPONSIBILITY_3_TITLE}**: ${RESPONSIBILITY_3_DESCRIPTION}
4. **${RESPONSIBILITY_4_TITLE}**: ${RESPONSIBILITY_4_DESCRIPTION}
5. **${RESPONSIBILITY_5_TITLE}**: ${RESPONSIBILITY_5_DESCRIPTION}

## Operational Framework

### ${FRAMEWORK_SECTION_1_TITLE}
${FRAMEWORK_SECTION_1_CONTENT}

### ${FRAMEWORK_SECTION_2_TITLE}
${FRAMEWORK_SECTION_2_CONTENT}

${ADDITIONAL_SECTIONS}
```

## TEMPLATE COMPONENT LIBRARY

### Standard Agent Components

#### Header Pattern
```markdown
# ${AGENT_NAME_CAPS}

You are a ${AGENT_ROLE}. ${AGENT_CORE_DESCRIPTION}
```

#### Examples Pattern (Standardized Structure)
```markdown
<example>
Context: ${CONTEXT_DESCRIPTION}
User Query: "${USER_QUERY}"
Assistant Response: "${ASSISTANT_RESPONSE}"
Commentary: ${COMMENTARY}
</example>
```

#### Core Responsibilities Pattern
```markdown
## Core Responsibilities

1. **${TITLE}**: ${DESCRIPTION_WITH_TECHNICAL_DETAILS}
2. **${TITLE}**: ${DESCRIPTION_WITH_TECHNICAL_DETAILS}
3. **${TITLE}**: ${DESCRIPTION_WITH_TECHNICAL_DETAILS}
4. **${TITLE}**: ${DESCRIPTION_WITH_TECHNICAL_DETAILS}
5. **${TITLE}**: ${DESCRIPTION_WITH_TECHNICAL_DETAILS}
```

#### Operational Framework Pattern
```markdown
## Operational Framework

### ${METHODOLOGY_SECTION_TITLE}
- **${PRINCIPLE_1}**: ${DESCRIPTION}
- **${PRINCIPLE_2}**: ${DESCRIPTION}
- **${PRINCIPLE_3}**: ${DESCRIPTION}
- **${PRINCIPLE_4}**: ${DESCRIPTION}
- **${PRINCIPLE_5}**: ${DESCRIPTION}
- **${PRINCIPLE_6}**: ${DESCRIPTION}

### ${TECHNOLOGY_SECTION_TITLE}
${TECHNOLOGY_SPECIFIC_CONTENT}
```

## MASS REPLACEMENT PATTERNS

### Agent Structure Deduplication Patterns

```javascript
// MultiEdit patterns for systematic agent structure refactoring
{
  "pattern_1_examples_standardization": {
    "old_string_pattern": "<example>\nContext: (.+)\nUser Query: \"(.+)\"\nAssistant Response: \"(.+)\"\nCommentary: (.+)\n</example>",
    "new_string_template": "<example>\nContext: ${1}\nUser Query: \"${2}\"\nAssistant Response: \"${3}\"\nCommentary: ${4}\n</example>"
  },
  "pattern_2_responsibilities_standardization": {
    "old_string_pattern": "## Core Responsibilities\n\n1\\. \\*\\*(.+)\\*\\*: (.+)\n2\\. \\*\\*(.+)\\*\\*: (.+)\n3\\. \\*\\*(.+)\\*\\*: (.+)\n4\\. \\*\\*(.+)\\*\\*: (.+)\n5\\. \\*\\*(.+)\\*\\*: (.+)",
    "new_string_template": "## Core Responsibilities\n\n1. **${1}**: ${2}\n2. **${3}**: ${4}\n3. **${5}**: ${6}\n4. **${7}**: ${8}\n5. **${9}**: ${10}"
  },
  "pattern_3_operational_framework": {
    "old_string_pattern": "## Operational Framework\n\n### (.+)\n(.+)\n\n### (.+)\n(.+)",
    "new_string_template": "## Operational Framework\n\n### ${1}\n${2}\n\n### ${3}\n${4}"
  }
}
```

## AGENT CATEGORY TEMPLATES

### AI/ML Agents Template Extensions
```markdown
#### Neural Architecture Components
- **${ARCHITECTURE_1}**: ${DESCRIPTION}
- **${ARCHITECTURE_2}**: ${DESCRIPTION}
- **${ARCHITECTURE_3}**: ${DESCRIPTION}

#### Technology Stack Expertise
- **${FRAMEWORK_1}**: ${DESCRIPTION}
- **${FRAMEWORK_2}**: ${DESCRIPTION}
```

### Backend Agents Template Extensions  
```markdown
#### Architecture Patterns
- **${PATTERN_1}**: ${DESCRIPTION}
- **${PATTERN_2}**: ${DESCRIPTION}

#### Performance Optimization
- **${OPTIMIZATION_1}**: ${DESCRIPTION}
- **${OPTIMIZATION_2}**: ${DESCRIPTION}
```

### Database Agents Template Extensions
```markdown
#### Data Architecture
- **${DATA_PATTERN_1}**: ${DESCRIPTION}
- **${DATA_PATTERN_2}**: ${DESCRIPTION}

#### Optimization Strategies
- **${OPTIMIZATION_1}**: ${DESCRIPTION}
- **${OPTIMIZATION_2}**: ${DESCRIPTION}
```

## TEMPLATE APPLICATION STRATEGY

### Phase 1: Structure Standardization
1. **Header Standardization**: Apply consistent agent header pattern
2. **Examples Normalization**: Standardize example structure and formatting
3. **Responsibilities Formatting**: Apply consistent numbering and formatting
4. **Framework Organization**: Standardize operational framework sections

### Phase 2: Content Preservation
1. **Domain Expertise Retention**: Preserve all technical content and expertise
2. **Specialization Maintenance**: Maintain agent-specific capabilities
3. **Context Accuracy**: Ensure domain-specific context remains accurate
4. **Technical Depth**: Preserve technical detail and complexity

### Phase 3: Integration Validation
1. **Template Compliance**: Verify template adherence across all agents
2. **Content Accuracy**: Validate technical content preservation
3. **Deployment Functionality**: Test agent deployment and execution
4. **Registry Synchronization**: Ensure agent registry consistency

**Template System Status**: READY FOR MASS APPLICATION
**Risk Level**: MANAGED - Comprehensive backup and validation framework established
**Execution Method**: MultiEdit operations with template-based standardization