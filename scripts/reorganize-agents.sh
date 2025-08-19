#!/bin/bash

# Agent reorganization script - moves all agents to hierarchical structure
# Run from /Users/nalve/.claude directory

AGENTS_DIR="/Users/nalve/.claude/agents"

echo "Starting agent reorganization..."

# Core System Agents (already moved: enforcement-monitor, system-auditor, validation-engineer)
# Move compliance-auditor (already done manually)

# Development/Architecture Agents
echo "Moving development/architecture agents..."
mv "$AGENTS_DIR/agent-architect.md" "$AGENTS_DIR/development/architecture/"
mv "$AGENTS_DIR/agent-creator.md" "$AGENTS_DIR/development/architecture/"
mv "$AGENTS_DIR/api-architect.md" "$AGENTS_DIR/development/architecture/"
mv "$AGENTS_DIR/data-architect.md" "$AGENTS_DIR/development/architecture/"
mv "$AGENTS_DIR/infrastructure-architect.md" "$AGENTS_DIR/development/architecture/"

# Development/Quality Agents
echo "Moving development/quality agents..."
mv "$AGENTS_DIR/test-architect.md" "$AGENTS_DIR/development/quality/"
mv "$AGENTS_DIR/performance-optimizer.md" "$AGENTS_DIR/development/quality/"
mv "$AGENTS_DIR/security-analyst.md" "$AGENTS_DIR/development/quality/"

# Development/Workflow Agents
echo "Moving development/workflow agents..."
mv "$AGENTS_DIR/git-workflow-specialist.md" "$AGENTS_DIR/development/workflow/"
mv "$AGENTS_DIR/configuration-manager.md" "$AGENTS_DIR/development/workflow/"
mv "$AGENTS_DIR/migration-specialist.md" "$AGENTS_DIR/development/workflow/"
mv "$AGENTS_DIR/integration-coordinator.md" "$AGENTS_DIR/development/workflow/"

# Operations/Infrastructure Agents
echo "Moving operations/infrastructure agents..."
mv "$AGENTS_DIR/deployment-coordinator.md" "$AGENTS_DIR/operations/infrastructure/"

# Operations/Monitoring Agents  
echo "Moving operations/monitoring agents..."
mv "$AGENTS_DIR/monitoring-specialist.md" "$AGENTS_DIR/operations/monitoring/"
mv "$AGENTS_DIR/metrics-analyst.md" "$AGENTS_DIR/operations/monitoring/"

# Operations/Compliance Agents
echo "Moving operations/compliance agents..."
mv "$AGENTS_DIR/incident-coordinator.md" "$AGENTS_DIR/operations/compliance/"

# Project Management/Coordination Agents
echo "Moving project-management/coordination agents..."
mv "$AGENTS_DIR/delegation-advisor.md" "$AGENTS_DIR/project-management/coordination/"
mv "$AGENTS_DIR/ticket-executor.md" "$AGENTS_DIR/project-management/coordination/"

# Project Management/Analytics Agents
echo "Moving project-management/analytics agents..."
mv "$AGENTS_DIR/project-optimizer.md" "$AGENTS_DIR/project-management/analytics/"

# User Experience Agents
echo "Moving user-experience agents..."
mv "$AGENTS_DIR/ux-architect.md" "$AGENTS_DIR/user-experience/"

# Content Agents
echo "Moving content agents..."
mv "$AGENTS_DIR/documentation-curator.md" "$AGENTS_DIR/content/"
mv "$AGENTS_DIR/knowledge-curator.md" "$AGENTS_DIR/content/"

# Remove .gitkeep files
echo "Cleaning up .gitkeep files..."
find "$AGENTS_DIR" -name ".gitkeep" -type f -delete

echo "Agent reorganization complete!"
echo "Remaining files in root agents directory:"
ls -la "$AGENTS_DIR"