---
title: "Optimize Prompt Command"
author: "Claude Code System"
date: "2025-08-19"
version: "1.0.0"
command_type: "prompt-optimization"
execution_mode: "direct"
tools: ["Read", "Write", "Edit", "Grep", "TodoWrite"]
dependencies: ["agents/prompt-optimizer.md"]
prerequisites: ["Source prompt or protocol document"]
audience: "Developers optimizing SuperWhisper and AI prompts"
purpose: "Create zero-verbose, high-performance prompts from verbose source material"
keywords: ["prompt", "optimization", "superwhisper", "performance", "transcription"]
last_review: "2025-08-19"
---

# OPTIMIZE PROMPT COMMAND

## Command Syntax

```bash
optimize-prompt --input [source] --output [destination] --criteria [performance|clarity|conciseness]
```

## Core Function

Extract essential rules from verbose prompt documentation to create zero-verbose, high-performance prompts optimized for AI systems like SuperWhisper.

## Parameters

- `--input`: Source file path containing verbose prompt/protocol
- `--output`: Destination file path for optimized prompt
- `--criteria`: Optimization focus (performance, clarity, conciseness)

## Execution Protocol

### 1. Source Analysis
- Read source document completely
- Identify core instruction patterns
- Map essential rules and conversions
- Detect verbose content for removal

### 2. Content Extraction
- Extract symbol mappings and conversions
- Preserve technical term definitions
- Identify critical translation patterns
- Maintain context-specific rules

### 3. Optimization Processing
- Remove explanations and examples
- Eliminate redundant content
- Focus on actionable instructions
- Minimize token usage while preserving accuracy

### 4. Output Generation
- Create pure instruction format
- Apply specified optimization criteria
- Validate essential rules preservation
- Generate ready-to-deploy prompt

## Optimization Criteria

### Performance
- Minimal token usage
- Maximum accuracy preservation
- Essential rules only
- Direct instruction format

### Clarity
- Clear, unambiguous instructions
- Logical rule ordering
- Consistent terminology
- Precise action specifications

### Conciseness
- Zero redundancy
- Compressed essential content
- Streamlined format
- Focused scope

## Quality Validation

- ✓ Essential rules preserved completely
- ✓ Technical terms maintained accurately
- ✓ Verbose content eliminated
- ✓ Ready for target system deployment
- ✓ Performance criteria met

## Usage Examples

```bash
# Optimize SuperWhisper transcription protocol
optimize-prompt --input docs/transcription-superwhisper.md --output superwhisper-prompt.txt --criteria performance

# Optimize general AI prompt for clarity
optimize-prompt --input verbose-prompt.md --output clear-prompt.txt --criteria clarity

# Create concise instruction set
optimize-prompt --input detailed-instructions.md --output concise-instructions.txt --criteria conciseness
```

## Integration Points

- **Source**: Any verbose prompt/protocol documentation
- **Output**: Optimized prompt files ready for AI system deployment
- **Dependencies**: Uses prompt-optimizer agent for complex extractions
- **Validation**: Built-in quality assurance for rule preservation

## Command Categories

- **prompt-optimization**: Primary category
- **content-processing**: Secondary category
- **ai-integration**: Tertiary category