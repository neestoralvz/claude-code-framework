---
title: "Ticket Integration and Troubleshooting"
component_type: "integration"
parent: "../TICKET_METHODOLOGY.md"
version: "1.0.0"
---

# Ticket Integration and Troubleshooting

## Integration Points

### With Documentation
- Link tickets to affected documentation
- Update docs when completing tickets
- Reference tickets in commit messages

### With Version Control
```bash
# Commit message format
git commit -m "Implement [TICKET-ID]: Brief description"

# Example
git commit -m "Implement MOD-001: Extract metadata templates"
```

### With CI/CD
- Automated ticket updates on deployment
- Link deployments to tickets
- Track implementation verification

## Troubleshooting

### Common Issues

**Ticket Not Found**
```bash
# Search all directories
find /planning/tickets -name "*TICKET-ID*"
```

**Status Update Failed**
```bash
# Manual status update
sed -i 's/status: old/status: new/' ticket-file.md
```

**Registry Out of Sync**
```bash
# Force registry rebuild
./scripts/rebuild-registry.sh --force
```

## Cross-References

### Primary Navigation
- [Navigate to Documentation Hub for central access](../../index.md)
- [Study PRINCIPLES.md for framework understanding](../principles/PRINCIPLES.md)
- [Access TICKET_REGISTRY.md for status dashboard](../TICKET_REGISTRY.md)
- [Browse commands index for available tools](../../../commands/index.md)

### Related Documentation
- [Apply ticket template for standardized creation](../templates/ticket-template.md)
- [Follow priority guidelines for classification](../guides/priority-guidelines.md)
- [Use status management for transitions](../guides/status-management.md)

### Automation Scripts
- [Execute manage-ticket-status.sh for status updates](../../../scripts/manage-ticket-status.sh)
- [Run update-ticket-registry.sh for synchronization](../../../scripts/update-ticket-registry.sh)
- [Generate reports with generate-ticket-report.sh](../../../scripts/generate-ticket-report.sh)

### Principle References
- [Apply organization.md for structural guidance](../../principles/organization.md)
- [Follow workflow.md for systematic execution](../../principles/workflow.md)
- [Use communication.md for clear documentation](../../principles/communication.md)
- [Implement engineering.md for quality standards](../../principles/engineering.md)

[Return to TICKET_METHODOLOGY.md](../TICKET_METHODOLOGY.md)