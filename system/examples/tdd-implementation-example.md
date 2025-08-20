[🏠 System Hub](../INDEX.md) | [📁 Parent Directory](./) | [📖 Current Section](#)

---

# TDD Implementation Example

**Context**: Practical example demonstrating framework implementation patterns


Real example showing the complete Red-Green-Refactor cycle for implementing a validation function.

## The Requirement

We need a function that validates email addresses and provides specific error messages for different validation failures.

## Red - Write Failing Test

```python
import pytest
from email_validator import validate_email, EmailValidationError

def test_email_validation_success():
    result = validate_email("user@example.com")
    assert result.email == "user@example.com"
    assert result.normalized == "user@example.com"

def test_email_validation_missing_at_symbol():
    with pytest.raises(EmailValidationError) as exc_info:
        validate_email("userexample.com")
    assert "missing @ symbol" in str(exc_info.value)

def test_email_validation_invalid_domain():
    with pytest.raises(EmailValidationError) as exc_info:
        validate_email("user@invalid")
    assert "invalid domain" in str(exc_info.value)
```

## Green - Minimal Implementation

```python
import re
from dataclasses import dataclass

class EmailValidationError(Exception):
    pass

@dataclass
class EmailResult:
    email: str
    normalized: str

def validate_email(email: str) -> EmailResult:
    if "@" not in email:
        raise EmailValidationError("missing @ symbol")
    
    parts = email.split("@")
    if len(parts) != 2:
        raise EmailValidationError("invalid format")
    
    local, domain = parts
    if "." not in domain:
        raise EmailValidationError("invalid domain")
        
    return EmailResult(email=email, normalized=email.lower())
```

## Refactor - Improve Design

```python
import re
from dataclasses import dataclass
from typing import Pattern

class EmailValidationError(Exception):
    pass

@dataclass
class EmailResult:
    email: str
    normalized: str

class EmailValidator:
    EMAIL_PATTERN: Pattern = re.compile(r'^[^@]+@[^@]+\.[^@]+$')
    
    def validate(self, email: str) -> EmailResult:
        if not self._has_at_symbol(email):
            raise EmailValidationError("missing @ symbol")
        
        if not self._has_valid_domain(email):
            raise EmailValidationError("invalid domain")
            
        return EmailResult(email=email, normalized=email.lower())
    
    def _has_at_symbol(self, email: str) -> bool:
        return "@" in email and email.count("@") == 1
    
    def _has_valid_domain(self, email: str) -> bool:
        domain = email.split("@")[1]
        return "." in domain and len(domain) > 3

def validate_email(email: str) -> EmailResult:
    validator = EmailValidator()
    return validator.validate(email)
```

## Key Benefits Demonstrated

Tests drove the interface design - we knew exactly what the function should return. Each test failure gave us specific guidance about what to implement next. Refactoring was safe because tests caught any regressions.

---
**Navigation:** [↑ System Home](../INDEX.md)
