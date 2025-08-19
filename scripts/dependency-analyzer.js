#!/usr/bin/env node

/**
 * Ticket Dependency Analyzer
 * Analyzes ticket dependencies and generates parallel execution plans
 * 
 * Usage:
 *   node dependency-analyzer.js [options]
 * 
 * Options:
 *   --scope [pending|all|category]
 *   --category [system|modularization|documentation|feature]
 *   --strategy [maximum|balanced|sequential]
 *   --output [filename]
 *   --conflicts-only
 *   --validate-plan [filename]
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

class DependencyAnalyzer {
  constructor() {
    this.tickets = new Map();
    this.dependencyGraph = new Map();
    this.conflicts = [];
    this.parallelGroups = [];
  }

  /**
   * Load all tickets from the ticket registry and individual files
   */
  async loadTickets(scope = 'pending', category = null) {
    const ticketsPath = path.join(__dirname, '../docs/planning/tickets');
    const scopePath = path.join(ticketsPath, scope);
    
    if (!fs.existsSync(scopePath)) {
      throw new Error(`Scope directory not found: ${scopePath}`);
    }

    const ticketFiles = fs.readdirSync(scopePath)
      .filter(file => file.endsWith('.md'))
      .filter(file => !category || file.includes(category.toLowerCase()));

    for (const file of ticketFiles) {
      const filePath = path.join(scopePath, file);
      const ticket = await this.parseTicketFile(filePath);
      if (ticket) {
        this.tickets.set(ticket.ticket_id, ticket);
      }
    }

    console.log(`Loaded ${this.tickets.size} tickets for analysis`);
  }

  /**
   * Parse individual ticket file and extract metadata
   */
  async parseTicketFile(filePath) {
    try {
      const content = fs.readFileSync(filePath, 'utf8');
      const frontmatterMatch = content.match(/^---\n([\s\S]*?)\n---/);
      
      if (!frontmatterMatch) {
        console.warn(`No frontmatter found in ${filePath}`);
        return null;
      }

      const frontmatter = yaml.load(frontmatterMatch[1]);
      
      // Extract additional information from content
      const bodyContent = content.substring(frontmatterMatch[0].length);
      const affectedFiles = this.extractAffectedFiles(bodyContent);
      const resourceRequirements = this.analyzeResourceRequirements(bodyContent);

      return {
        ...frontmatter,
        file_path: filePath,
        affected_files: affectedFiles,
        resource_requirements: resourceRequirements,
        content_hash: this.calculateContentHash(content)
      };
    } catch (error) {
      console.error(`Error parsing ticket file ${filePath}:`, error.message);
      return null;
    }
  }

  /**
   * Extract files that will be affected by the ticket
   */
  extractAffectedFiles(content) {
    const filePatterns = [
      /`([^`]+\.md)`/g,
      /\[([^\]]+\.md)\]/g,
      /\/([^\/\s]+\.md)/g
    ];

    const files = new Set();
    
    for (const pattern of filePatterns) {
      let match;
      while ((match = pattern.exec(content)) !== null) {
        files.add(match[1]);
      }
    }

    return Array.from(files);
  }

  /**
   * Analyze resource requirements based on ticket content
   */
  analyzeResourceRequirements(content) {
    const requirements = {
      registry_access: content.includes('TICKET_REGISTRY') || content.includes('registry'),
      file_modifications: content.includes('modify') || content.includes('update') || content.includes('edit'),
      template_creation: content.includes('template') || content.includes('create'),
      validation_required: content.includes('validation') || content.includes('verify'),
      agent_intensive: content.includes('complex') || content.includes('comprehensive')
    };

    return requirements;
  }

  /**
   * Calculate content hash for change detection
   */
  calculateContentHash(content) {
    const crypto = require('crypto');
    return crypto.createHash('md5').update(content).digest('hex');
  }

  /**
   * Build dependency graph from ticket declarations
   */
  buildDependencyGraph() {
    console.log('Building dependency graph...');
    
    for (const [ticketId, ticket] of this.tickets) {
      const node = {
        ticket_id: ticketId,
        dependencies: this.normalizeDependencies(ticket.dependencies),
        affected_files: ticket.affected_files || [],
        resource_requirements: ticket.resource_requirements || {},
        priority: ticket.priority || 'MEDIUM',
        estimated_effort: this.parseEffort(ticket.estimated_effort)
      };

      this.dependencyGraph.set(ticketId, node);
    }

    // Analyze file conflicts
    this.analyzeFileConflicts();
    
    // Analyze resource conflicts
    this.analyzeResourceConflicts();
  }

  /**
   * Normalize dependency declarations to standard format
   */
  normalizeDependencies(deps) {
    if (!deps) return { blocking: [], sequential: [], soft: [], file_conflicts: [], resource_conflicts: [] };
    
    if (Array.isArray(deps)) {
      return { blocking: deps, sequential: [], soft: [], file_conflicts: [], resource_conflicts: [] };
    }

    return {
      blocking: deps.blocking || [],
      sequential: deps.sequential || [],
      soft: deps.soft || [],
      file_conflicts: deps.file_conflicts || [],
      resource_conflicts: deps.resource_conflicts || []
    };
  }

  /**
   * Parse effort estimation to hours
   */
  parseEffort(effort) {
    if (!effort) return 2; // Default 2 hours
    
    const match = effort.toString().match(/(\d+(?:\.\d+)?)/);
    return match ? parseFloat(match[1]) : 2;
  }

  /**
   * Analyze potential file modification conflicts
   */
  analyzeFileConflicts() {
    console.log('Analyzing file conflicts...');
    
    const fileMap = new Map();
    
    // Group tickets by affected files
    for (const [ticketId, node] of this.dependencyGraph) {
      for (const file of node.affected_files) {
        if (!fileMap.has(file)) {
          fileMap.set(file, []);
        }
        fileMap.get(file).push(ticketId);
      }
    }

    // Identify conflicts
    for (const [file, tickets] of fileMap) {
      if (tickets.length > 1) {
        this.conflicts.push({
          type: 'file_conflict',
          file: file,
          tickets: tickets,
          resolution_strategy: 'sequential',
          impact: 'medium'
        });

        // Add file_conflicts dependencies
        for (let i = 0; i < tickets.length; i++) {
          for (let j = i + 1; j < tickets.length; j++) {
            const node1 = this.dependencyGraph.get(tickets[i]);
            const node2 = this.dependencyGraph.get(tickets[j]);
            
            if (node1 && node2) {
              node1.dependencies.file_conflicts.push(tickets[j]);
              node2.dependencies.file_conflicts.push(tickets[i]);
            }
          }
        }
      }
    }
  }

  /**
   * Analyze resource conflicts
   */
  analyzeResourceConflicts() {
    console.log('Analyzing resource conflicts...');
    
    const resourceGroups = {
      registry_access: [],
      heavy_computation: [],
      template_creation: []
    };

    for (const [ticketId, node] of this.dependencyGraph) {
      if (node.resource_requirements.registry_access) {
        resourceGroups.registry_access.push(ticketId);
      }
      if (node.resource_requirements.agent_intensive) {
        resourceGroups.heavy_computation.push(ticketId);
      }
      if (node.resource_requirements.template_creation) {
        resourceGroups.template_creation.push(ticketId);
      }
    }

    // Add resource conflicts for registry access (mutex required)
    if (resourceGroups.registry_access.length > 1) {
      this.conflicts.push({
        type: 'resource_conflict',
        resource: 'registry_access',
        tickets: resourceGroups.registry_access,
        resolution_strategy: 'mutex_coordination',
        impact: 'low'
      });
    }

    // Add resource conflicts for heavy computation (limit parallelism)
    if (resourceGroups.heavy_computation.length > 3) {
      this.conflicts.push({
        type: 'resource_conflict',
        resource: 'computation_capacity',
        tickets: resourceGroups.heavy_computation,
        resolution_strategy: 'limited_parallelism',
        impact: 'medium'
      });
    }
  }

  /**
   * Detect circular dependencies
   */
  detectCycles() {
    console.log('Detecting circular dependencies...');
    
    const visited = new Set();
    const recursionStack = new Set();
    const cycles = [];

    const dfs = (ticketId, path = []) => {
      if (recursionStack.has(ticketId)) {
        const cycleStart = path.indexOf(ticketId);
        cycles.push(path.slice(cycleStart).concat(ticketId));
        return;
      }

      if (visited.has(ticketId)) return;

      visited.add(ticketId);
      recursionStack.add(ticketId);
      path.push(ticketId);

      const node = this.dependencyGraph.get(ticketId);
      if (node) {
        for (const dep of [...node.dependencies.blocking, ...node.dependencies.sequential]) {
          if (this.dependencyGraph.has(dep)) {
            dfs(dep, [...path]);
          }
        }
      }

      recursionStack.delete(ticketId);
    };

    for (const ticketId of this.dependencyGraph.keys()) {
      if (!visited.has(ticketId)) {
        dfs(ticketId);
      }
    }

    if (cycles.length > 0) {
      this.conflicts.push({
        type: 'circular_dependency',
        cycles: cycles,
        resolution_strategy: 'break_cycle',
        impact: 'high'
      });
    }

    return cycles;
  }

  /**
   * Generate parallel execution groups using topological sort
   */
  generateParallelGroups(strategy = 'balanced') {
    console.log(`Generating parallel groups with ${strategy} strategy...`);
    
    const inDegree = new Map();
    const adjList = new Map();
    
    // Initialize
    for (const ticketId of this.dependencyGraph.keys()) {
      inDegree.set(ticketId, 0);
      adjList.set(ticketId, []);
    }

    // Build adjacency list and calculate in-degrees
    for (const [ticketId, node] of this.dependencyGraph) {
      for (const dep of [...node.dependencies.blocking, ...node.dependencies.sequential]) {
        if (this.dependencyGraph.has(dep)) {
          adjList.get(dep).push(ticketId);
          inDegree.set(ticketId, inDegree.get(ticketId) + 1);
        }
      }
    }

    // Generate groups level by level
    const groups = [];
    let currentLevel = [];

    // Find tickets with no dependencies
    for (const [ticketId, degree] of inDegree) {
      if (degree === 0) {
        currentLevel.push(ticketId);
      }
    }

    while (currentLevel.length > 0) {
      const group = this.optimizeGroup(currentLevel, strategy);
      groups.push({
        group_id: groups.length + 1,
        tickets: group,
        estimated_duration: this.calculateGroupDuration(group),
        dependencies_resolved: true,
        resource_conflicts: this.hasGroupConflicts(group),
        agents_required: group.length
      });

      // Process next level
      const nextLevel = [];
      for (const ticketId of currentLevel) {
        for (const dependent of adjList.get(ticketId)) {
          inDegree.set(dependent, inDegree.get(dependent) - 1);
          if (inDegree.get(dependent) === 0) {
            nextLevel.push(dependent);
          }
        }
      }

      currentLevel = nextLevel;
    }

    this.parallelGroups = groups;
    return groups;
  }

  /**
   * Optimize group composition based on strategy
   */
  optimizeGroup(tickets, strategy) {
    switch (strategy) {
      case 'maximum':
        return tickets; // Execute all tickets in parallel
      
      case 'sequential':
        return tickets.slice(0, 1); // Execute one at a time
      
      case 'balanced':
      default:
        // Limit parallel tickets based on conflicts and resources
        return this.balanceGroup(tickets);
    }
  }

  /**
   * Balance group to avoid conflicts while maintaining parallelism
   */
  balanceGroup(tickets) {
    const conflictMap = new Map();
    
    // Map tickets involved in conflicts
    for (const conflict of this.conflicts) {
      if (conflict.type === 'file_conflict' || conflict.type === 'resource_conflict') {
        for (const ticket of conflict.tickets) {
          if (!conflictMap.has(ticket)) {
            conflictMap.set(ticket, []);
          }
          conflictMap.get(ticket).push(conflict);
        }
      }
    }

    const balanced = [];
    const remaining = [...tickets];

    while (remaining.length > 0 && balanced.length < 4) { // Max 4 parallel tickets
      let selected = null;
      
      // Find ticket with least conflicts with already selected tickets
      for (const ticket of remaining) {
        const hasConflict = balanced.some(selectedTicket => {
          return this.hasDirectConflict(ticket, selectedTicket);
        });
        
        if (!hasConflict) {
          selected = ticket;
          break;
        }
      }

      // If no conflict-free ticket found, take the first one
      if (!selected) {
        selected = remaining[0];
      }

      balanced.push(selected);
      remaining.splice(remaining.indexOf(selected), 1);
    }

    return balanced;
  }

  /**
   * Check if two tickets have direct conflicts
   */
  hasDirectConflict(ticket1, ticket2) {
    const node1 = this.dependencyGraph.get(ticket1);
    const node2 = this.dependencyGraph.get(ticket2);

    if (!node1 || !node2) return false;

    // Check file conflicts
    const file1 = new Set(node1.affected_files);
    const file2 = new Set(node2.affected_files);
    const hasFileOverlap = [...file1].some(file => file2.has(file));

    // Check resource conflicts
    const req1 = node1.resource_requirements;
    const req2 = node2.resource_requirements;
    const hasResourceConflict = req1.registry_access && req2.registry_access;

    return hasFileOverlap || hasResourceConflict;
  }

  /**
   * Calculate estimated duration for a group of tickets
   */
  calculateGroupDuration(tickets) {
    let maxDuration = 0;
    
    for (const ticketId of tickets) {
      const node = this.dependencyGraph.get(ticketId);
      if (node && node.estimated_effort > maxDuration) {
        maxDuration = node.estimated_effort;
      }
    }

    return maxDuration;
  }

  /**
   * Check if group has resource conflicts
   */
  hasGroupConflicts(tickets) {
    for (const conflict of this.conflicts) {
      if (conflict.type === 'file_conflict' || conflict.type === 'resource_conflict') {
        const overlapCount = tickets.filter(ticket => conflict.tickets.includes(ticket)).length;
        if (overlapCount > 1) {
          return true;
        }
      }
    }
    return false;
  }

  /**
   * Calculate critical path through the dependency graph
   */
  calculateCriticalPath() {
    console.log('Calculating critical path...');
    
    const distances = new Map();
    const predecessors = new Map();
    
    // Initialize distances
    for (const ticketId of this.dependencyGraph.keys()) {
      distances.set(ticketId, 0);
    }

    // Process groups in order to find longest path
    for (const group of this.parallelGroups) {
      for (const ticketId of group.tickets) {
        const node = this.dependencyGraph.get(ticketId);
        
        // Find maximum distance through dependencies
        let maxDistance = 0;
        let bestPredecessor = null;
        
        for (const dep of [...node.dependencies.blocking, ...node.dependencies.sequential]) {
          if (distances.has(dep)) {
            const depDistance = distances.get(dep) + this.dependencyGraph.get(dep).estimated_effort;
            if (depDistance > maxDistance) {
              maxDistance = depDistance;
              bestPredecessor = dep;
            }
          }
        }

        distances.set(ticketId, maxDistance);
        if (bestPredecessor) {
          predecessors.set(ticketId, bestPredecessor);
        }
      }
    }

    // Find ticket with maximum distance (end of critical path)
    let maxDistance = 0;
    let endTicket = null;
    
    for (const [ticketId, distance] of distances) {
      if (distance > maxDistance) {
        maxDistance = distance;
        endTicket = ticketId;
      }
    }

    // Reconstruct critical path
    const criticalPath = [];
    let current = endTicket;
    
    while (current) {
      criticalPath.unshift(current);
      current = predecessors.get(current);
    }

    return {
      tickets: criticalPath,
      total_duration: maxDistance + (endTicket ? this.dependencyGraph.get(endTicket).estimated_effort : 0),
      bottlenecks: this.identifyBottlenecks(criticalPath)
    };
  }

  /**
   * Identify bottleneck tickets in critical path
   */
  identifyBottlenecks(criticalPath) {
    const bottlenecks = [];
    
    for (const ticketId of criticalPath) {
      const node = this.dependencyGraph.get(ticketId);
      
      // Count how many tickets depend on this one
      let dependentCount = 0;
      for (const [otherTicketId, otherNode] of this.dependencyGraph) {
        if (otherTicketId !== ticketId) {
          const allDeps = [...otherNode.dependencies.blocking, ...otherNode.dependencies.sequential];
          if (allDeps.includes(ticketId)) {
            dependentCount++;
          }
        }
      }
      
      // Consider tickets with high dependency count or long duration as bottlenecks
      if (dependentCount > 2 || node.estimated_effort > 3) {
        bottlenecks.push(ticketId);
      }
    }

    return bottlenecks;
  }

  /**
   * Generate execution plan
   */
  generateExecutionPlan(strategy = 'balanced') {
    console.log('Generating execution plan...');
    
    this.buildDependencyGraph();
    this.detectCycles();
    this.generateParallelGroups(strategy);
    
    const criticalPath = this.calculateCriticalPath();
    const totalDuration = this.parallelGroups.reduce((sum, group) => sum + group.estimated_duration, 0);
    const parallelismFactor = totalDuration > 0 ? criticalPath.total_duration / totalDuration : 1;

    return {
      metadata: {
        generated: new Date().toISOString(),
        strategy: strategy,
        total_tickets: this.tickets.size,
        estimated_duration: `${criticalPath.total_duration} hours`,
        parallelism_factor: parseFloat(parallelismFactor.toFixed(2))
      },
      conflicts: this.conflicts,
      parallel_groups: this.parallelGroups,
      critical_path: criticalPath,
      optimization_recommendations: this.generateOptimizationRecommendations()
    };
  }

  /**
   * Generate optimization recommendations
   */
  generateOptimizationRecommendations() {
    const recommendations = [];

    // Check for bottlenecks
    const criticalPath = this.calculateCriticalPath();
    if (criticalPath.bottlenecks.length > 0) {
      recommendations.push(`Consider splitting bottleneck tickets: ${criticalPath.bottlenecks.join(', ')}`);
    }

    // Check for large groups
    const largeGroups = this.parallelGroups.filter(group => group.tickets.length > 4);
    if (largeGroups.length > 0) {
      recommendations.push('Large parallel groups may benefit from resource allocation limits');
    }

    // Check for many conflicts
    if (this.conflicts.length > 3) {
      recommendations.push('High number of conflicts detected - consider ticket restructuring');
    }

    // Check for low parallelism
    const avgGroupSize = this.parallelGroups.reduce((sum, group) => sum + group.tickets.length, 0) / this.parallelGroups.length;
    if (avgGroupSize < 2) {
      recommendations.push('Low parallelism detected - review dependency declarations for optimization opportunities');
    }

    return recommendations;
  }

  /**
   * Validate execution plan
   */
  validatePlan(plan) {
    console.log('Validating execution plan...');
    
    const issues = [];
    
    // Check for missing tickets
    const planTickets = new Set();
    for (const group of plan.parallel_groups) {
      for (const ticket of group.tickets) {
        planTickets.add(ticket);
      }
    }
    
    for (const ticketId of this.tickets.keys()) {
      if (!planTickets.has(ticketId)) {
        issues.push(`Missing ticket in plan: ${ticketId}`);
      }
    }

    // Check for dependency violations
    for (const group of plan.parallel_groups) {
      for (const ticketId of group.tickets) {
        const node = this.dependencyGraph.get(ticketId);
        if (node) {
          for (const dep of [...node.dependencies.blocking, ...node.dependencies.sequential]) {
            if (planTickets.has(dep)) {
              // Check if dependency is in an earlier group
              const depGroupIndex = plan.parallel_groups.findIndex(g => g.tickets.includes(dep));
              const ticketGroupIndex = plan.parallel_groups.findIndex(g => g.tickets.includes(ticketId));
              
              if (depGroupIndex >= ticketGroupIndex) {
                issues.push(`Dependency violation: ${ticketId} depends on ${dep} but appears in same or earlier group`);
              }
            }
          }
        }
      }
    }

    return {
      valid: issues.length === 0,
      issues: issues
    };
  }

  /**
   * Output results in various formats
   */
  outputResults(plan, format = 'yaml', filename = null) {
    let output;
    
    switch (format) {
      case 'json':
        output = JSON.stringify(plan, null, 2);
        break;
      case 'markdown':
        output = this.formatAsMarkdown(plan);
        break;
      case 'yaml':
      default:
        output = yaml.dump(plan, { indent: 2 });
        break;
    }

    if (filename) {
      fs.writeFileSync(filename, output);
      console.log(`Results written to ${filename}`);
    } else {
      console.log(output);
    }
  }

  /**
   * Format results as markdown report
   */
  formatAsMarkdown(plan) {
    let md = '# Dependency Analysis Report\n\n';
    
    md += `## Summary\n`;
    md += `- **Strategy**: ${plan.metadata.strategy}\n`;
    md += `- **Total Tickets**: ${plan.metadata.total_tickets}\n`;
    md += `- **Estimated Duration**: ${plan.metadata.estimated_duration}\n`;
    md += `- **Parallelism Factor**: ${plan.metadata.parallelism_factor}x\n\n`;

    if (plan.conflicts.length > 0) {
      md += `## Conflicts Detected (${plan.conflicts.length})\n\n`;
      for (const conflict of plan.conflicts) {
        md += `### ${conflict.type.replace('_', ' ').toUpperCase()}\n`;
        md += `- **Tickets**: ${conflict.tickets ? conflict.tickets.join(', ') : 'N/A'}\n`;
        md += `- **Resolution**: ${conflict.resolution_strategy}\n`;
        md += `- **Impact**: ${conflict.impact}\n\n`;
      }
    }

    md += `## Parallel Groups (${plan.parallel_groups.length})\n\n`;
    for (const group of plan.parallel_groups) {
      md += `### Group ${group.group_id}\n`;
      md += `- **Tickets**: ${group.tickets.join(', ')}\n`;
      md += `- **Duration**: ${group.estimated_duration} hours\n`;
      md += `- **Agents Required**: ${group.agents_required}\n`;
      md += `- **Conflicts**: ${group.resource_conflicts ? 'Yes' : 'No'}\n\n`;
    }

    md += `## Critical Path\n`;
    md += `- **Path**: ${plan.critical_path.tickets.join(' → ')}\n`;
    md += `- **Duration**: ${plan.critical_path.total_duration} hours\n`;
    
    if (plan.critical_path.bottlenecks.length > 0) {
      md += `- **Bottlenecks**: ${plan.critical_path.bottlenecks.join(', ')}\n`;
    }

    if (plan.optimization_recommendations.length > 0) {
      md += `\n## Optimization Recommendations\n\n`;
      for (const rec of plan.optimization_recommendations) {
        md += `- ${rec}\n`;
      }
    }

    return md;
  }
}

// CLI Interface
async function main() {
  const args = process.argv.slice(2);
  const options = {
    scope: 'pending',
    category: null,
    strategy: 'balanced',
    output: null,
    format: 'yaml',
    conflictsOnly: false,
    validatePlan: null
  };

  // Parse command line arguments
  for (let i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--scope':
        options.scope = args[++i];
        break;
      case '--category':
        options.category = args[++i];
        break;
      case '--strategy':
        options.strategy = args[++i];
        break;
      case '--output':
        options.output = args[++i];
        break;
      case '--format':
        options.format = args[++i];
        break;
      case '--conflicts-only':
        options.conflictsOnly = true;
        break;
      case '--validate-plan':
        options.validatePlan = args[++i];
        break;
    }
  }

  try {
    const analyzer = new DependencyAnalyzer();
    
    if (options.validatePlan) {
      // Validate existing plan
      const planContent = fs.readFileSync(options.validatePlan, 'utf8');
      const plan = yaml.load(planContent);
      
      await analyzer.loadTickets('all');
      const validation = analyzer.validatePlan(plan);
      
      console.log('Plan Validation Results:');
      console.log(`Valid: ${validation.valid}`);
      if (validation.issues.length > 0) {
        console.log('Issues:');
        validation.issues.forEach(issue => console.log(`  - ${issue}`));
      }
      return;
    }

    // Load tickets and analyze
    await analyzer.loadTickets(options.scope, options.category);
    
    if (options.conflictsOnly) {
      // Only detect and report conflicts
      analyzer.buildDependencyGraph();
      analyzer.detectCycles();
      
      const conflicts = analyzer.conflicts;
      console.log(`Found ${conflicts.length} conflicts:`);
      conflicts.forEach(conflict => {
        console.log(`  ${conflict.type}: ${conflict.tickets ? conflict.tickets.join(', ') : 'N/A'}`);
      });
      return;
    }

    // Generate full execution plan
    const plan = analyzer.generateExecutionPlan(options.strategy);
    analyzer.outputResults(plan, options.format, options.output);

  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

// Export for use as module
module.exports = DependencyAnalyzer;

// Run CLI if called directly
if (require.main === module) {
  main();
}