# Universal Navigation Template Standard

## Analysis Summary

**Current State**: 72 total markdown files in system/, 62 have navigation, 10 missing navigation

**Inconsistencies Found**:
- Mixed navigation patterns (some have Back + Home, others only Home)
- Inconsistent link formatting (relative vs absolute paths)
- Missing contextual information in many files
- No standardized breadcrumb hierarchy

## Universal Navigation Pattern

### Standard Header Template

```markdown

---

# [File Title]

**Context**: [Brief explanation of file's role in framework]

---

[Content goes here]

---

```

### Navigation Components

1. **Top Navigation Bar**: Emoji-based quick navigation
   - 🏠 System Hub: Always links to system/INDEX.md
   - 📁 Parent Directory: Links to parent directory or section index
   - 📖 Current Section: Internal anchor link

2. **Context Statement**: One-line explanation of file's purpose

3. **Bottom Navigation**: Text-based detailed navigation
   - Back to Parent: Specific parent section (PRINCIPLES, BEHAVIORS, etc.)
   - System Home: Always links to system/INDEX.md

### Path Resolution Rules

1. **From system/ root files**: Use `INDEX.md`
2. **From subdirectories**: Use `../INDEX.md`
3. **Parent links**: Use specific parent (e.g., `../PRINCIPLES.md`)
4. **Special cases**: Some files only need System Home link

### Implementation Priorities

1. **Missing Navigation Files**:
   - system/PRINCIPLES.md
   - system/PROCESSES.md
   - system/BEHAVIORS.md
   - system/processes/think-hard.md
   - system/processes/research-and-document.md
   - system/processes/think-harder.md
   - system/processes/think.md
   - system/README.md
   - system/INDEX.md
   - system/examples/automation-decision.md

2. **Standardization Targets**: All 72 system files

## Template Variants

### Root Level Files (system/PRINCIPLES.md, etc.)
```markdown

---

```

### Subdirectory Files (system/principles/*, etc.)
```markdown

---

```

### Special Cases (INDEX.md files)
```markdown

---

```

## Success Metrics

- [ ] 100% files contain navigation to INDEX.md
- [ ] Consistent emoji navigation bar across all files
- [ ] Clear contextual information in every file
- [ ] All navigation links functional and accurate
- [ ] Framework feels cohesive and easily navigable

## Implementation Strategy

1. Create automated navigation insertion script
2. Process files systematically by directory
3. Validate all links after implementation
4. Test navigation flow across entire framework
