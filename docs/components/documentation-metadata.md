# Documentation Metadata Standards

## Migration Notice

**⚠️ MIGRATION COMPLETE**: This component has been consolidated into [organization.md](../principles/organization.md#documentation-metadata-standards) as part of the documentation standards migration. **Use the organization principle for current metadata standards.** This component is maintained for historical reference only.

**Current Location**: [Apply organization.md for comprehensive metadata standards](../principles/organization.md#documentation-metadata-standards)

---

Metadata standards for general documentation files in the system.

## Base Fields
```yaml
---
title: "{{DOCUMENT_TITLE}}"
author: "System"
date: "{{DATE}}"
version: "{{VERSION}}"
keywords: [{{DOCUMENT_KEYWORDS}}]
last_review: "{{DATE}}"

# Documentation-specific fields
dependencies: [{{DOCUMENT_DEPENDENCIES}}]
prerequisites: [{{DOCUMENT_PREREQUISITES}}]
audience: "{{DOCUMENT_AUDIENCE}}"
purpose: "{{DOCUMENT_PURPOSE}}"

# Additional documentation fields
category: "documentation"
type: "{{DOCUMENT_TYPE}}" # index, guide, reference, template, ticket
status: "{{DOCUMENT_STATUS}}" # draft, active, deprecated, archived
scope: "{{DOCUMENT_SCOPE}}" # global, local, component-specific
maintainer: "{{DOCUMENT_MAINTAINER}}"
---
```

## Common Documentation Types
- **index**: Navigation and overview documents
- **guide**: How-to and instructional content
- **reference**: Technical specifications and API docs
- **template**: Reusable document structures
- **ticket**: Planning and task tracking

## Common Documentation Keywords
- documentation, overview, navigation, hub, index
- guide, tutorial, howto, instructions, walkthrough
- reference, specification, technical, api, detailed
- template, boilerplate, structure, pattern, reusable
- planning, ticket, task, implementation, tracking