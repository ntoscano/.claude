---
allowed-tools: Bash, Grep, Read, Task
description: Git add all and commit with concise, thorough message (optional --review flag)
---

# Git Commit (gc)

**Purpose:** Stage all changes and create a commit with a concise but thorough message.

## Options

- `--review` or `-r`: Run code review on staged changes before committing

## Process

### 1. Handle Review Flag (if provided)

If `$ARGUMENTS` contains `--review` or `-r`:
- Stage all changes with `git add .`
- Run the code review command: `/project:code-review`
- Wait for review completion
- Ask user: "Code review complete. Proceed with commit? (y/n)"
- If no, exit without committing
- If yes, continue to step 2

### 2. Check Git Status

Run git status to see what changes exist.

### 3. Analyze Changes

- Review modified files
- Check git diff to understand changes
- Look at recent commits for style consistency
- Determine if this is a simple change or a larger feature

### 4. Generate Commit Message

Create a message that is:
- **Concise:** One line summary (50-72 chars ideally)
- **Thorough:** Captures the essence of all changes
- **Clear:** Uses present tense, imperative mood
- **Professional:** No emojis, no signatures, no fluff

For larger changes:
- First line: Overall summary
- Blank line
- Bullet points for major components/changes

### 5. Stage and Commit

- Run `git add .`
- Create commit with generated message

## Message Format

Follow conventional commit style when applicable:
- `feat:` for new features
- `fix:` for bug fixes
- `refactor:` for code restructuring
- `docs:` for documentation
- `style:` for formatting
- `test:` for tests
- `chore:` for maintenance

But keep it simple - don't force a prefix if it doesn't fit naturally.

## Examples

### Simple Commits
- "Add user authentication module"
- "Fix memory leak in data processor"
- "Refactor database connection logic"
- "Update API endpoints for v2 compatibility"
- "Remove deprecated payment methods"

### Larger Feature Commits
```
feat: Add parallel Claude Code agent system

- Complete lifecycle management (init → execute → cleanup)
- Automatic worktree creation and dependency installation
- Claude slash commands for parallel development workflow
- Safe cleanup with interactive merge strategies
- Session persistence and progress monitoring
- Support for n parallel agents with isolated workspaces
```

```
refactor: Restructure authentication system

- Extract auth logic into dedicated service
- Implement token refresh mechanism
- Add support for OAuth2 providers
- Migrate existing sessions to new format
- Update all API endpoints to use new auth
```

```
fix: Resolve critical data synchronization issues

- Fix race condition in concurrent writes
- Add proper mutex locking for shared resources
- Implement retry logic for failed sync operations
- Add comprehensive error handling
- Include telemetry for sync failures
```

## Guidelines

- Use bullet points for multiple related changes
- Keep bullet points concise and parallel in structure
- Only use multi-line format when changes are substantial
- Group related changes together
- Focus on WHAT changed, not implementation details

## Important Notes

- NO emojis
- NO signatures or attribution
- NO verbose explanations in the commit message
- Keep technical but accessible
- Let the code tell the HOW, commit tells the WHAT