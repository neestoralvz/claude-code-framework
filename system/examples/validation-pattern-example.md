[🏠 System Hub](../INDEX.md) | [📁 Parent Directory](./) | [📖 Current Section](#)

---

# Validation Pattern Example

**Context**: Practical example demonstrating framework implementation patterns


Real example showing how to implement robust validation with clear error feedback.

## The Situation

We need to validate user input for a task creation system, ensuring all fields are proper and providing helpful feedback when they're not.

## Implementation Pattern

```python
from pydantic import BaseModel, ValidationError, field_validator
from typing import Literal

class TaskInput(BaseModel):
    title: str
    status: Literal["pending", "in_progress", "completed"]
    priority: int
    
    @field_validator('title')
    @classmethod
    def validate_title(cls, v):
        if len(v.strip()) < 3:
            raise ValueError('Task title must be at least 3 characters')
        return v.strip()
    
    @field_validator('priority')
    @classmethod
    def validate_priority(cls, v):
        if not 1 <= v <= 5:
            raise ValueError('Priority must be between 1 and 5')
        return v

# Usage with clear error handling
try:
    task = TaskInput(title="", status="invalid", priority=10)
except ValidationError as e:
    for error in e.errors():
        print(f"Field '{error['loc'][0]}': {error['msg']}")
```

## Results

Users get specific feedback like "Field 'title': Task title must be at least 3 characters" instead of generic validation errors.

## Key Benefits

Input validation happens immediately with specific field-level feedback. The system prevents bad data from entering while giving users clear guidance on how to fix problems.

---
**Navigation:** [↑ System Home](../INDEX.md)
