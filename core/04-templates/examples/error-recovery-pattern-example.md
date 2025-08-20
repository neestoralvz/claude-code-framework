
---

**IF reading individually** → READ [EXAMPLES.md](../EXAMPLES.md#implementation-examples) for context, THEN navigate to this specific example


# Error Recovery Pattern Example

**Context**: Practical example demonstrating framework implementation patterns


Real example showing how to handle errors gracefully with automatic recovery strategies.

## The Situation

We're processing data that might have validation errors, but instead of failing completely, we want to clean and retry the data when possible.

## Implementation Pattern

```python
from pydantic import BaseModel, ValidationError, ValidatorFunctionWrapHandler
from typing import Any

def clean_and_retry(value: Any, handler: ValidatorFunctionWrapHandler) -> str:
    try:
        return handler(value)
    except ValidationError as err:
        if err.errors()[0]['type'] == 'string_too_long':
            # Truncate and retry
            return handler(value[:50])
        elif err.errors()[0]['type'] == 'string_pattern_mismatch':
            # Clean special characters and retry
            cleaned = ''.join(c for c in value if c.isalnum() or c.isspace())
            return handler(cleaned)
        else:
            # Re-raise for unhandled error types
            raise

class CleanDataModel(BaseModel):
    name: str = Field(max_length=50, pattern=r'^[a-zA-Z0-9\s]+$')
    
    @field_validator('name', mode='wrap')
    @classmethod
    def clean_name(cls, v, handler):
        return clean_and_retry(v, handler)
```

## Results

Data that would normally fail validation gets automatically cleaned and processed successfully. Users see their data accepted with appropriate cleaning rather than rejection.

## Key Benefits

Graceful handling of common data problems. Automatic recovery reduces user friction. Clear separation between recoverable and non-recoverable errors.

## When to Apply

Use this pattern when you can define reasonable automatic corrections for common validation failures.

---
