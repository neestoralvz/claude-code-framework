# Dashboard Operations

This directory contains operational files for the Simple Framework dashboard system.

## Structure

- `data/` - Metrics, logs, and cache files
- `hooks/` - Configuration and testing files for hooks integration
- `scripts/` - Operational scripts for dashboard functionality
- `index.html` - Main dashboard interface
- `start_dashboard.sh` - Dashboard startup script

## Purpose

These are operational files that generate temporary data and provide runtime functionality. They belong in the work directory as they are:

1. **Operational** - Runtime files, not framework definitions
2. **Temporary** - Generate data that changes frequently  
3. **Implementation-specific** - Specific to current deployment

## Framework Integration

The dashboard supports the Simple Framework but is not part of the core framework structure itself.