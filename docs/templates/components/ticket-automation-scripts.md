# Ticket Automation Scripts

⏺ **Principle**: These automation tools implement [engineering.md](../principles/engineering.md) by providing systematic registry maintenance and reporting capabilities through automated quality control processes.

## Update Registry
```bash
# Run from project root
./scripts/update-ticket-registry.sh
```

## Generate Status Report
```bash
# Generate weekly status report
./scripts/generate-ticket-report.sh
```

## Bulk Status Update
```bash
# Update multiple ticket statuses
./scripts/bulk-status-update.sh
```

## Script Usage Notes
- All scripts should be run from the project root directory
- Ensure proper permissions are set for script execution
- Scripts automatically update registry files and maintain consistency
- Status reports are generated in markdown format for easy review