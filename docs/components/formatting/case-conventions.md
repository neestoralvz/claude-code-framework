---
title: "Case Conventions Component"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../../../principles/formatting.md"]
purpose: "Define case conventions for different contexts"
---

[Previous: Study naming-conventions.md for overview](naming-conventions.md) | [Return to hub for navigation](../../index.md)

# CASE CONVENTIONS COMPONENT

⏺ **Principle**: This component implements [formatting.md](../../principles/formatting.md) case standards for consistent naming across contexts.

## kebab-case
- **Usage**: Files, directories, URLs, HTML attributes
- **Pattern**: `lowercase-with-hyphens`
- **Examples**:
  - `agent-architect.md`
  - `user-interface-components`
  - `data-processing-pipeline`

## camelCase
- **Usage**: JavaScript variables, functions, properties
- **Pattern**: `firstWordLowercaseThenCapitalized`
- **Examples**:
  - `processUserData`
  - `getCurrentWorkingDirectory`
  - `validateInputParameters`

## PascalCase
- **Usage**: Classes, constructors, components, types
- **Pattern**: `EveryWordCapitalized`
- **Examples**:
  - `AgentArchitect`
  - `SystemValidator`
  - `DocumentProcessor`

## snake_case
- **Usage**: Python variables, database fields, configuration
- **Pattern**: `lowercase_with_underscores`
- **Examples**:
  - `user_input_data`
  - `system_configuration`
  - `database_connection`

## SCREAMING_SNAKE_CASE
- **Usage**: Constants, environment variables, global definitions
- **Pattern**: `UPPERCASE_WITH_UNDERSCORES`
- **Examples**:
  - `MAX_FILE_SIZE`
  - `API_BASE_URL`
  - `DEFAULT_TIMEOUT`

[Return to naming-conventions.md](naming-conventions.md)