---
title: "Cross-Platform Compatibility Component"
author: "Claude Code System"
date: "2025-08-18"
version: "1.0.0"
dependencies: ["../../../principles/formatting.md"]
purpose: "Ensure naming works across different operating systems"
---

[Previous: Study naming-conventions.md for overview](naming-conventions.md) | [Return to hub for navigation](../../index.md)

# CROSS-PLATFORM COMPATIBILITY COMPONENT

⏺ **Principle**: This component implements [formatting.md](../../principles/formatting.md) cross-platform standards for universal compatibility.

## Characters to Avoid
- **Windows reserved**: `< > : " | ? * \`
- **Path separators**: `/` (except in URLs), `\` (except in Windows paths)
- **Special characters**: `# % & { } + [ ] @ ! $ ' ( ) = ; ,`
- **Control characters**: ASCII 0-31 (non-printable)

## Characters to Prefer
- **ASCII letters**: `a-z`, `A-Z`
- **Numbers**: `0-9`
- **Safe separators**: `-` (hyphen), `_` (underscore), `.` (dot)
- **Meaningful abbreviations**: When full words are too long

## Length Considerations
- **Filesystem limits**: Most systems support 255 characters for filenames
- **Practical limits**: Keep under 100 characters for usability
- **Path limits**: Keep full paths under 260 characters (Windows limitation)

## Case Sensitivity Awareness
- **Linux/Unix**: Case-sensitive filesystems (`File.md` ≠ `file.md`)
- **macOS**: Case-insensitive by default but case-preserving
- **Windows**: Case-insensitive (`File.md` = `file.md`)
- **Best practice**: Treat all systems as case-sensitive for consistency

[Return to naming-conventions.md](naming-conventions.md)