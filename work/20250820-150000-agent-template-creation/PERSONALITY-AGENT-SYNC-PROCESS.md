# Personality-Agent Sync Process

**Purpose**: Prevent critical gaps between personality references in CLAUDE.md and available deployable agents

## Sync Process Overview

This process ensures every personality reference in CLAUDE.md has a corresponding deployable agent, maintaining system integrity and user trust.

## Validation Protocol

### Pre-Commit Validation Steps

1. **Extract Personality References**
   ```bash
   grep -E "personalities/.*\.md" CLAUDE.md | grep -oE "personalities/[^)]*\.md"
   ```

2. **Verify Corresponding Agents Exist**
   - For each personality file, check if corresponding agent exists
   - Agent naming convention: `{personality-name}-agent.md`
   - Agent location: `agents/*/` directories

3. **Validate Agent Functionality**
   - Verify YAML frontmatter is complete
   - Ensure agent has proper tools, model, and color specified
   - Confirm agent description matches personality use case

### Automated Validation Script

```bash
#!/bin/bash
# validate-personality-agent-sync.sh

CLAUDE_MD="CLAUDE.md"
AGENT_DIRS="agents"
PERSONALITY_DIR="system/personalities"

# Extract personality references from CLAUDE.md
PERSONALITIES=$(grep -oE "personalities/[^)]*\.md" "$CLAUDE_MD" | sed 's/personalities\///' | sed 's/\.md//')

echo "Validating personality-agent sync..."

for personality in $PERSONALITIES; do
    personality_file="$PERSONALITY_DIR/$personality.md"
    agent_file=$(find "$AGENT_DIRS" -name "*$personality*agent*.md" -type f | head -1)
    
    if [ ! -f "$personality_file" ]; then
        echo "ERROR: Personality file missing: $personality_file"
        exit 1
    fi
    
    if [ -z "$agent_file" ]; then
        echo "ERROR: No agent found for personality: $personality"
        echo "  Expected agent pattern: *$personality*agent*.md"
        exit 1
    fi
    
    echo "✓ $personality -> $agent_file"
done

echo "All personality-agent mappings validated successfully"
```

## Agent Creation Process

### 1. Identify Missing Agents

Run validation script to identify personalities without corresponding agents.

### 2. Create Agent Template

For each missing personality:

1. **Read Personality Definition**
   ```bash
   Read system/personalities/{personality-name}.md
   ```

2. **Extract Core Capabilities**
   - Mission/purpose from personality file
   - Core characteristics and communication style
   - When the personality should be active

3. **Create Agent File**
   ```yaml
   ---
   name: {personality-name}
   description: {when this agent should be invoked}
   tools: {relevant tools based on capabilities}
   model: sonnet
   color: {appropriate color}
   ---
   
   # {Personality Name} Agent
   
   {Agent system prompt based on personality definition}
   ```

### 3. Validate Agent Deployment

1. **Test Agent Creation**
   ```bash
   # Test in Claude Code
   /agents
   # Verify new agent appears in list
   ```

2. **Test Agent Functionality**
   - Create simple task for the agent
   - Verify agent responds appropriately
   - Confirm agent behavior matches personality description

## Integration Requirements

### CLAUDE.md Integration

1. **Personality Commands Section**
   - Every personality reference MUST have corresponding agent
   - Agent names should be consistent with personality names
   - Descriptions should clearly indicate when to use each

2. **Agent Creation Commands Section**
   - Include validation requirements
   - Reference sync process for new personalities
   - Mandate agent creation for personality references

### Framework Integration

1. **Pre-commit Hooks**
   - Add validation script to git pre-commit hooks
   - Block commits that create personality-agent gaps
   - Require agent creation before personality references

2. **Documentation Standards**
   - Any personality addition requires agent creation
   - Agent updates must maintain personality alignment
   - Regular sync audits in framework evaluation

## Quality Assurance

### Validation Checkpoints

1. **Development Phase**
   - Before adding personality references
   - During agent template creation
   - After agent deployment

2. **Maintenance Phase**
   - Weekly sync validation
   - After framework updates
   - Before major releases

### Success Metrics

- **100% Coverage**: Every personality has corresponding agent
- **Functional Validation**: All personality workflows complete successfully  
- **User Experience**: No broken references or failed commands
- **System Integrity**: Framework promises match capabilities

## Troubleshooting

### Common Issues

1. **Agent Not Found**: Check agent naming conventions and directory structure
2. **Invalid YAML**: Validate frontmatter syntax and required fields
3. **Wrong Tools**: Ensure agent has appropriate tools for personality capabilities
4. **Model Mismatch**: Use `sonnet` for most agents unless specific requirements

### Resolution Process

1. **Identify Gap**: Run validation script
2. **Create Agent**: Follow agent creation process
3. **Test Deployment**: Verify functionality
4. **Update Documentation**: Ensure consistency
5. **Validate Integration**: Run full sync check

## Implementation Priority

### Immediate (Critical)
1. Create missing agents for all personalities
2. Deploy validation script
3. Test all personality-agent mappings

### Strategic (Next Session)  
1. Integrate validation into pre-commit hooks
2. Add automated testing for personality workflows
3. Create agent template generator for new personalities

This sync process ensures the framework maintains integrity between conceptual personalities and deployable operational capabilities.