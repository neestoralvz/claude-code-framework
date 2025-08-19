# Registry System Architecture

## Overview
Centralized registry system for managing components, services, and configurations within Claude Code framework.

## Registry Types

### 1. Component Registry
- **Location**: `/scripts/registries/components.json`
- **Purpose**: Track all reusable components and their dependencies
- **Schema**: Component ID, version, dependencies, location, metadata

### 2. Service Registry  
- **Location**: `/scripts/registries/services.json`
- **Purpose**: Manage services, agents, and their capabilities
- **Schema**: Service name, type, capabilities, endpoints, health status

### 3. Configuration Registry
- **Location**: `/scripts/registries/configurations.json`
- **Purpose**: Central configuration management
- **Schema**: Config key, value, scope, override hierarchy

### 4. Agent Registry
- **Location**: `/scripts/registries/agents.json`
- **Purpose**: Track agent capabilities and specializations
- **Schema**: Agent name, expertise, status, deployment info

## Registry Manager
- **Location**: `/scripts/registry-manager.sh`
- **Purpose**: CRUD operations for all registries
- **Features**: Validation, versioning, backup, search

## Integration Points
- Hooks system for automatic updates
- Commands for manual registry operations
- Agents for registry-based discovery
- Configuration system for registry settings