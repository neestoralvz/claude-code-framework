
[Previous: Study code-block-standards.md for overview](code-block-standards.md) | [Return to hub for navigation](../../philosophy/index.md)

# LANGUAGE-SPECIFIC CODE BLOCKS COMPONENT

⏺ **Principle**: This component implements [formatting.md](../../../principles/formatting.md) language standards for proper code block categorization.

## Bash/Shell Scripts
**Purpose**: Executable commands and scripts
```bash
# Commands intended for execution
find docs/ -name "*.md" -exec wc -l {} \;
```

## Markdown Examples
**Purpose**: Documentation formatting examples
```markdown
# Use for documentation structure examples
[Navigate to section for specific purpose](path/to/file.md#section)

## Section Headers
Content formatting guidelines
```

## YAML Configuration
**Purpose**: Configuration files and metadata
```yaml
# Configuration examples
title: "Document Title"
dependencies: ["file1.md", "file2.md"]
version: "1.0.0"
```

## JavaScript Code
**Purpose**: Client-side scripts and functions
```javascript
// Code examples and implementations
function processData(input) {
  return input.map(item => transform(item));
}
```

## Python Code
**Purpose**: Server-side scripts and automation
```python
# Python implementations and examples
def validate_file_structure(directory):
    return check_compliance(directory)
```

## JSON Data
**Purpose**: Data structures and API responses
```json
{
  "status": "success",
  "data": {
    "items": ["item1", "item2"]
  }
}
```

## SQL Queries
**Purpose**: Database operations and schema
```sql
-- Database query examples
SELECT * FROM documents 
WHERE type = 'component' 
ORDER BY last_modified DESC;
```

[Return to code-block-standards.md](code-block-standards.md)
