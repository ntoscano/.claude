Perform intelligent search and replace across the project:

Search pattern: $ARGUMENTS
Context: Understand the semantic meaning, not just text matching

1. Find all occurrences considering code context
2. Identify which replacements are safe
3. Skip replacements in comments/strings if code-only
4. Preserve formatting and indentation
5. Update related files (tests, docs, configs)
6. Show preview of all changes before applying

Use AST-aware searching where possible.
