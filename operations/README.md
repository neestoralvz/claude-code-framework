# Operations Directory

## Purpose
Conversation-isolated storage for intent analysis results and operational data.

## Structure
```
operations/
├── conv-{timestamp}/     # Timestamped conversation folders
├── conv-{session-id}/    # Session-based conversation folders  
├── conv-001/            # Numbered conversation folders
├── conv-002/
└── README.md
```

## Conversation Isolation
- Each conversation gets its own subfolder
- Prevents data mixing between sessions
- Maintains lowercase naming convention
- Supports multiple conversation ID formats:
  - `conv-YYYYMMDD-HHMMSS` (timestamp-based)
  - `conv-{session-id}` (session-based)
  - `conv-{n}` (numbered)

## File Types
- `intent-analysis.json` - Parallel agent analysis results
- `conversation-metadata.json` - Session information
- `agent-outputs/` - Individual agent result files
- `command-history.json` - Executed commands log

## Usage
Each parallel intent analysis command outputs to:
`./operations/{conversation-id}/intent-analysis.json`