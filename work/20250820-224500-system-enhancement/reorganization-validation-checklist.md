# Core Reorganization Validation Checklist

_Use this checklist to verify the reorganization is complete and functional_

## Pre-Migration Validation

### System State
- [ ] Current core folder backed up
- [ ] All active sessions closed
- [ ] Git repository committed and pushed
- [ ] CLAUDE.md backup created
- [ ] Agent templates documented

### Dependency Analysis
- [ ] All file references in CLAUDE.md identified
- [ ] Cross-references between core files mapped
- [ ] External dependencies documented
- [ ] Agent template references noted
- [ ] Workflow dependencies understood

## Migration Execution

### Structure Creation
- [ ] All new directories created
- [ ] Proper permissions set (755 for dirs, 644 for files)
- [ ] README.md files placed in each category
- [ ] Directory hierarchy verified (max 3 levels)

### File Migration
- [ ] All root .md files migrated
- [ ] Subdirectory contents copied
- [ ] Dashboard structure reorganized
- [ ] Backup files moved to archives
- [ ] No files left unmigrated

### Reference Updates
- [ ] CLAUDE.md references updated
- [ ] Internal cross-references updated
- [ ] Agent templates updated
- [ ] Workflow files updated
- [ ] Example files updated

## Post-Migration Testing

### System Functionality
- [ ] `/recenter` command works
- [ ] `/done` command works
- [ ] `/project` command works
- [ ] TodoWrite creates tasks
- [ ] Progressive Thinking activates

### Agent Deployment
- [ ] Agent templates load correctly
- [ ] Task tool finds agents
- [ ] Agent specialization works
- [ ] Parallel deployment functional
- [ ] Agent coordination operational

### Workflow Execution
- [ ] TDD/BDD workflows execute
- [ ] Session conclusion workflow runs
- [ ] Framework evaluation works
- [ ] Development workflow functional
- [ ] All processes accessible

### Documentation Access
- [ ] All README files accessible
- [ ] Navigation links work
- [ ] Examples load correctly
- [ ] Templates accessible
- [ ] Standards documentation found

### Integration Tests
- [ ] Git hooks still function
- [ ] Dashboard operations work
- [ ] Checks run successfully
- [ ] Tools execute properly
- [ ] Registries accessible

## Cleanup Verification

### Old Structure
- [ ] Compatibility links created
- [ ] Deprecated files archived
- [ ] Backup location documented
- [ ] Transition plan communicated
- [ ] Removal date scheduled

### Documentation
- [ ] Migration report generated
- [ ] Change log updated
- [ ] User notification sent
- [ ] Training materials updated
- [ ] FAQ prepared

## Performance Validation

### Navigation Speed
- [ ] File discovery improved
- [ ] Category access faster
- [ ] Search results clearer
- [ ] Mental model simpler
- [ ] Learning curve reduced

### Maintenance Efficiency
- [ ] Updates easier to make
- [ ] New files placement clear
- [ ] Archive process defined
- [ ] Cleanup schedule set
- [ ] Growth path established

## Risk Mitigation Confirmation

### Rollback Preparation
- [ ] Backup verified complete
- [ ] Rollback script ready
- [ ] Recovery time estimated
- [ ] Communication plan ready
- [ ] Support team briefed

### Monitoring Setup
- [ ] Error logs monitored
- [ ] User feedback channel open
- [ ] Performance metrics tracked
- [ ] Issue tracking active
- [ ] Resolution process defined

## Sign-off Criteria

### Technical Validation
- [ ] All tests pass (100%)
- [ ] No broken references
- [ ] No missing files
- [ ] Performance acceptable
- [ ] Security maintained

### User Acceptance
- [ ] Navigation intuitive
- [ ] Documentation clear
- [ ] Workflows uninterrupted
- [ ] Training complete
- [ ] Feedback positive

### Final Approval
- [ ] Technical lead approval
- [ ] User representative approval
- [ ] Documentation complete
- [ ] Rollback tested
- [ ] Go-live authorized

## Post-Implementation Review (Day 7)

### Success Metrics
- [ ] User satisfaction measured
- [ ] Navigation time reduced
- [ ] Error rate decreased
- [ ] Maintenance time improved
- [ ] Discovery rate increased

### Lessons Learned
- [ ] Migration process documented
- [ ] Issues encountered recorded
- [ ] Solutions applied noted
- [ ] Improvements identified
- [ ] Next steps planned

---

## Validation Summary

**Total Items**: 95
**Completed**: ___/95
**Success Rate**: ___%

**Migration Status**: ☐ Ready | ☐ In Progress | ☐ Complete | ☐ Validated

**Notes**:
_____________________________________
_____________________________________
_____________________________________

**Validated By**: _________________ **Date**: _________

---

_This checklist ensures comprehensive validation of the core folder reorganization._