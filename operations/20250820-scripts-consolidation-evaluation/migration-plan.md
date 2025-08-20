# Scripts Consolidation Migration Plan

## Executive Migration Strategy

**OBJECTIVE**: Consolidate 64 executable scripts from `/scripts/` into `/system/tools/` per framework standards

**SCOPE**: Systematic 4-phase migration of High Priority (32) and Medium Priority (32) scripts with comprehensive dependency management

**TIMELINE**: 4 phases with validation checkpoints and rollback capabilities

## Migration Phases

### Phase 1: High Priority Core Infrastructure (Week 1)
**Strategic Impact**: Critical system functionality - framework operations depend on these**

**Scripts to Migrate (8 scripts)**:
1. **Library Functions** (`/system/tools/lib/`)
   - `lib/link-validator.sh` → Core link validation functionality
   - `lib/link-categorizer.sh` → Link classification system
   - `lib/link-extractor.sh` → Link extraction utilities  
   - `lib/report-generator.sh` → Report generation framework
   - `libs/context7-file-operations.sh` → Context7 integration

2. **Security System** (`/system/tools/security/`)
   - `security/authentication/password-manager.sh` → Password management
   - `security/encryption/crypto-engine.sh` → Encryption capabilities

3. **Core Management** (`/system/tools/core/`)
   - `core/registry/registry-manager.sh` → Registry CRUD operations

**Dependencies**: Registry files (agents.json, components.json, services.json)
**Risk Level**: LOW - Well-contained functionality
**Validation Required**: Password system, registry operations, link validation

### Phase 2: Quality Assurance Framework (Week 2) 
**Strategic Impact**: Quality control and automated compliance**

**Scripts to Migrate (24 scripts)**:
1. **Enforcement System** (`/system/tools/enforcement/`)
   - `enforcement/master-enforcement-orchestrator.sh` → Central enforcement coordination
   - `enforcement/enforcement-dashboard-generator.sh` → Dashboard generation
   - All 9 core enforcement scripts (batch-correction, code-block, cross-reference, etc.)

2. **Validation System** (`/system/tools/validation/`)  
   - `validation/master-validation-orchestrator.sh` → Central validation coordination
   - `validation/validation-dashboard-generator.sh` → Dashboard generation
   - `validation/ci-integration.sh` → CI/CD integration
   - All 8 core validation scripts (code-block, cross-reference, file-naming, etc.)
   - 2 principle validation scripts

**Dependencies**: Enforcement and validation scripts have complex interdependencies
**Risk Level**: MEDIUM - Complex orchestration system
**Validation Required**: Enforcement execution, validation workflows, dashboard generation

### Phase 3: Documentation and Utilities (Week 3)
**Strategic Impact**: Content management and operational efficiency**

**Scripts to Migrate (16 scripts)**:
1. **Documentation Tools** (`/system/tools/documentation/`)
   - 9 scripts for content generation, link management, and navigation
   - Includes TOC generation, breadcrumb management, link scanning

2. **Utility Scripts** (`/system/tools/utilities/`)
   - 7 scripts for analysis, interface management, and pattern detection
   - Includes dependency analysis, ticket management, status line

**Dependencies**: Documentation scripts may reference each other
**Risk Level**: LOW-MEDIUM - Self-contained with minimal external dependencies  
**Validation Required**: Documentation generation, utility functionality

### Phase 4: Operational Safety and Agent Management (Week 4)
**Strategic Impact**: System monitoring and agent coordination**

**Scripts to Migrate (16 scripts)**:
1. **Crash Prevention System** (`/system/tools/monitoring/`)
   - 15 scripts for system monitoring, safety, and operational stability
   - Includes batch processing, resource monitoring, early warning systems

2. **Agent Management** (`/system/tools/agents/`)
   - 1 script for agent reorganization

**Dependencies**: Monitoring scripts may have complex interdependencies
**Risk Level**: LOW - Operational safety scripts are typically self-contained
**Validation Required**: Monitoring capabilities, agent management

## Directory Structure Design

### Proposed `/system/tools/` Organization
```
/system/tools/
├── lib/                    # Shared library functions
├── security/               # Security and authentication
├── core/                   # Core system management  
├── enforcement/            # Quality enforcement
├── validation/             # Quality validation
├── documentation/          # Content management
├── utilities/              # General utilities
├── monitoring/             # System monitoring & safety
├── agents/                 # Agent management
└── config/                 # Configuration files
```

## Migration Dependencies and Risks

### Critical Dependencies
1. **Registry Files**: `registries/*.json` - Decision needed on location
2. **Configuration Files**: `config/*.txt`, `config/*.json` - May need migration
3. **Relative Path References**: Many scripts use relative paths requiring updates
4. **Script Interdependencies**: Enforcement/validation systems have complex relationships

### Risk Mitigation Strategies
1. **Comprehensive Backup**: Full backup before each phase
2. **Incremental Validation**: Test functionality after each script migration
3. **Dependency Mapping**: Map all script interdependencies before migration
4. **Configuration Update**: Update all path references during migration
5. **Rollback Capability**: Maintain ability to restore previous state

### High-Risk Scenarios
1. **Registry Manager Failure**: Would impact all registry-dependent operations
2. **Enforcement System Disruption**: Could affect quality control workflows
3. **Security System Issues**: Password/encryption functionality problems
4. **Configuration Misalignment**: Scripts unable to find configurations

## Configuration Strategy

### Registry Files Decision Required
**Option A**: Move to `/system/registries/` (maintains system organization)
**Option B**: Keep in `/scripts/registries/` (preserves existing references)  
**Option C**: Move to `/system/tools/config/registries/` (consolidates with tools)

**Recommendation**: Option A for framework consistency

### Configuration Files
- Migrate `config/` directory contents to `/system/tools/config/`
- Update all script references to new configuration paths
- Maintain configuration file structure and naming

## Success Criteria and Validation

### Phase Completion Criteria
1. **Functional Validation**: All migrated scripts execute successfully
2. **Dependency Verification**: All script interdependencies work correctly
3. **Path Resolution**: All configuration and relative paths resolve correctly
4. **Performance Validation**: No degradation in execution performance
5. **Integration Testing**: Scripts integrate properly with existing framework

### Framework Compliance Validation
1. **Directory Purity**: Only executable scripts in `/system/tools/`
2. **Organization Standards**: Logical subdirectory organization maintained
3. **Documentation Alignment**: Framework documentation reflects new structure
4. **Command Integration**: All commands reference correct script locations

## Resource Requirements

### Technical Resources
- **Development Time**: 4 weeks (1 week per phase)
- **Testing Time**: 1 week total (distributed across phases)  
- **Documentation Updates**: Throughout migration process

### Risk Management Resources
- **Backup Storage**: Space for complete framework backups
- **Rollback Procedures**: Documented restoration processes
- **Monitoring**: Validation of system functionality throughout migration

## Implementation Commands

### Pre-Migration Setup
```bash
# Create directory structure
mkdir -p /system/tools/{lib,security,core,enforcement,validation,documentation,utilities,monitoring,agents,config}

# Create comprehensive backup
cp -r /scripts/ /backups/scripts-pre-migration-$(date +%Y%m%d)
```

### Phase 1 Migration Example
```bash
# Migrate library functions
mv /scripts/lib/* /system/tools/lib/
mv /scripts/libs/* /system/tools/lib/

# Update path references in migrated scripts
# Migrate security scripts
mv /scripts/security/* /system/tools/security/

# Migrate core management
mv /scripts/core/registry/* /system/tools/core/
```

### Post-Migration Validation
```bash
# Validate functionality
/system/tools/validation/master-validation-orchestrator.sh

# Test enforcement system  
/system/tools/enforcement/master-enforcement-orchestrator.sh --dry-run

# Verify security system
/system/tools/security/password-manager.sh list
```

## Cleanup Strategy

### Post-Migration Cleanup (After successful validation)
1. **Archive Useful Content**: Move valuable documentation to appropriate locations
2. **Remove Obsolete Scripts**: Delete cleanup and migration-specific scripts
3. **Preserve Backups**: Maintain backup directories for recovery
4. **Remove Empty Directories**: Clean up empty `/scripts/` subdirectories
5. **Update Documentation**: Reflect new script locations in framework docs

### Obsolete Content Removal
- Migration and cleanup scripts (12 scripts at root level)
- Historical backup directories (evaluate for archival vs removal)
- Unused documentation files (evaluate for integration vs removal)

## Success Metrics

### Quantitative Metrics
- **64 scripts migrated** to appropriate `/system/tools/` subdirectories
- **100% functionality preserved** across all migrated scripts  
- **0 broken dependencies** after migration completion
- **Framework compliance achieved** per CLAUDE.md standards

### Qualitative Metrics
- Clean, organized `/system/tools/` directory structure
- Improved framework maintainability
- Enhanced discoverability of tools and utilities
