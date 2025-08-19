
[Previous: formatting-standards.md](formatting-standards.md) | [Return: section-templates-hub.md](section-templates-hub.md)

# IMPERATIVE TONE PATTERNS COMPONENT

⏺ **Principle**: This component implements [communication.md](../../principles/communication.md) imperative tone requirements.

## Required Patterns
- **Direct Commands**: "Execute the build process" (not "You should execute...")
- **Action Focus**: "Configure the settings" (not "The settings can be configured")
- **Present Tense**: "Deploy the application" (not "Will deploy the application")
- **Active Voice**: "Update the documentation" (not "Documentation should be updated")

## Forbidden Patterns
- **Passive Voice**: Avoid "should be done" patterns
- **Conditional Language**: Avoid "might want to" or "could consider"
- **Uncertain Language**: Avoid "perhaps" or "maybe"
- **Personal References**: Avoid "you" or "we" in instructions

## Conversion Examples
### Before (Passive/Uncertain)
```markdown
## Things You Should Consider
- You might want to update the configuration
- The tests should probably be run
- It would be good to check the logs
```

### After (Imperative/Direct)
```markdown
## Execute Configuration Updates
- Update the configuration settings
- Run the test suite
- Check the application logs
```

## Template Examples
### Command Documentation
```markdown
## Execute Primary Function
Activate the core system functionality through the primary command interface.

## Configure Command Options
Set the required parameters for optimal system performance.

## Validate Command Results
Verify successful execution through system output analysis.
```

## Cross-References
- [Apply action-header-templates.md for structure](action-header-templates.md)
- [Use category-header-templates.md for organization](category-header-templates.md)
- [Follow formatting-standards.md for consistency](formatting-standards.md)
