# Claude Code Systems Integration

## Overview
This implementation adds three integrated systems to the Claude Code framework:

1. **Hooks System** - Event-driven automation
2. **Registry System** - Component and service management  
3. **Password Management System** - Secure credential storage

## Quick Start

### System Status
```bash
# Check all systems
./scripts/core/orchestration/manage-systems.sh status

# System health check
./scripts/core/orchestration/manage-systems.sh health
```

### Hooks System
```bash
# List registered hooks
./scripts/hooks-executor.sh list

# Execute system startup hooks
./scripts/hooks-executor.sh system startup
```

### Registry System
```bash
# List all registries
./scripts/core/registry/registry-manager.sh list

# Search across registries
./scripts/core/registry/registry-manager.sh search "validation"

# View specific registry
./scripts/core/registry/registry-manager.sh read agents
```

### Password System
```bash
# List password categories
./scripts/password-manager.sh list

# Store a password
./scripts/password-manager.sh store api github_token "your_token" "GitHub API access"

# Retrieve a password
./scripts/password-manager.sh retrieve api github_token
```

## Architecture

### System Integration
- **Native Integration**: Built into existing Claude Code folder structure
- **Configuration**: Extends `settings.json` with proper Claude Code schema
- **Hooks Integration**: Uses official Claude Code hooks system
- **Security**: Enterprise-grade encryption and access controls

### File Structure
```
scripts/
├── hooks-system.md           # Hooks architecture documentation
├── registry-system.md        # Registry architecture documentation  
├── password-system.md        # Password system architecture documentation
├── manage-systems.sh         # Unified system management
├── hooks-executor.sh         # Hook execution engine
├── registry-manager.sh       # Registry management interface
├── password-manager.sh       # Password management interface
├── crypto-engine.sh          # Encryption/decryption engine
├── hooks-registry.json       # Hook configuration registry
├── registries/               # Component and service registries
│   ├── components.json       # Component registry
│   ├── agents.json          # Agent registry
│   └── services.json        # Service registry
├── vault/                    # Encrypted password storage
└── hooks/                    # Individual hook scripts
    ├── pre-command-validation.sh
    ├── post-command-quality.sh
    ├── update-structure.sh
    ├── update-registries.sh
    ├── context-backup.sh
    └── system-startup.sh
```

## Features

### Hooks System
- **Event-Driven**: Automatic execution on framework events
- **Configurable**: JSON-based hook configuration
- **Parallel Execution**: Concurrent hook execution with timeout management
- **Audit Logging**: Complete execution history and error tracking

### Registry System
- **Component Tracking**: Automatic discovery and registration
- **Service Discovery**: Health monitoring and capability tracking
- **Versioning**: Automatic backup and version management
- **Search**: Cross-registry search capabilities

### Password System
- **AES-256-GCM Encryption**: Military-grade encryption
- **Session Management**: Secure session handling with timeouts
- **Audit Logging**: Complete access history
- **Backup/Restore**: Encrypted backup management

## Security

### Encryption
- **Algorithm**: AES-256-GCM with authenticated encryption
- **Key Derivation**: PBKDF2 with 100,000 iterations
- **Random Generation**: Cryptographically secure random data

### Access Control
- **File Permissions**: Strict 700 permissions on sensitive directories
- **Session Management**: Time-limited session caching
- **Audit Logging**: Complete security event logging

### Compliance
- **Password Policies**: Configurable complexity requirements
- **Data Protection**: GDPR-compliant data handling
- **Audit Trail**: Complete operation history

## Integration with Claude Code

### Settings Configuration
The systems integrate through `settings.json`:
```json
{
  "hooks": {
    "UserPromptSubmit": [...],
    "PostToolUse": [...],
    "SessionStart": [...]
  },
  "env": {
    "CLAUDE_HOOKS_ENABLED": "true",
    "CLAUDE_REGISTRY_PATH": "scripts/registries",
    "CLAUDE_VAULT_PATH": "scripts/vault"
  }
}
```

### Native Folder Structure
- Uses existing `scripts/` directory
- Integrates with `logs/` directory
- Extends `agents/` and `commands/` tracking
- Preserves existing `docs/` organization

### Command Integration
- New management command: `commands/management/manage-systems.md`
- Automatic hook execution on command events
- Registry updates on file changes
- Security validation integration

## Usage Examples

### Development Workflow
```bash
# Initialize systems on new project
./scripts/core/orchestration/manage-systems.sh init

# Check system health
./scripts/core/orchestration/manage-systems.sh health

# Store API credentials
./scripts/password-manager.sh store api github_token "ghp_xyz..." "GitHub API"

# The hooks will automatically:
# - Validate commands before execution
# - Update registries after file changes
# - Backup context before major operations
# - Run quality checks after completion
```

### System Administration
```bash
# Backup all systems
./scripts/core/orchestration/manage-systems.sh backup

# Restore from backup
./scripts/core/orchestration/manage-systems.sh restore backups/systems_20250819_120000.tar.gz

# Enable/disable specific systems
./scripts/core/orchestration/manage-systems.sh enable hooks
./scripts/core/orchestration/manage-systems.sh disable password
```

## Documentation

### Complete Documentation
- **[Systems Integration Guide](docs/SYSTEMS_INTEGRATION.md)** - Comprehensive documentation
- **[Hooks System Architecture](scripts/hooks-system.md)** - Hooks system details
- **[Registry System Architecture](../scripts/registry-system.md)** - Registry system details
- **[Password System Architecture](../scripts/password-system.md)** - Password system details

### Command Documentation
- **[Manage Systems Command](../commands/domains/management/commands/manage-systems.md)** - Unified system management

## Troubleshooting

### Common Issues
1. **Hooks not executing**: Check `settings.json` configuration
2. **Registry errors**: Validate JSON syntax with `jq`
3. **Password decryption failures**: Verify master password
4. **Permission errors**: Check file permissions on vault directory

### Diagnostic Commands
```bash
# System diagnostics
./scripts/core/orchestration/manage-systems.sh health

# Individual system checks
./scripts/hooks-executor.sh list
./scripts/core/registry/registry-manager.sh validate components
./scripts/password-manager.sh list
```

### Log Files
- **Hooks**: `logs/hooks/hooks.log`
- **Registry**: `logs/registry/registry.log`  
- **Password**: `logs/password/password_manager.log`
- **Crypto**: `logs/crypto/security.log`
- **Systems**: `logs/systems/systems.log`

## Support

For issues or questions:
1. Check log files in `logs/` directories
2. Run system health check: `./scripts/core/orchestration/manage-systems.sh health`
3. Review configuration files for syntax errors
4. Verify file permissions on sensitive directories

## License

This implementation follows the same license as the Claude Code framework and maintains compatibility with all existing functionality while adding enterprise-grade system management capabilities.