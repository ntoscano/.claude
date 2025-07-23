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

- Review modified files with `git status` and `git diff --name-only`
- Check git diff to understand changes in each file
- Look at recent commits for style consistency
- Determine if this is a simple change or a larger feature
- Count number of files changed

### 4. Generate Commit Message

Create a message that is:
- **Concise:** One line summary (50-72 chars ideally)
- **Thorough:** Captures the essence of all changes
- **Clear:** Uses present tense, imperative mood
- **Professional:** No emojis, no signatures, no fluff

Message structure rules:
- **Single file change:** Can use simple one-line message
- **Multiple files (2+):** Must use multi-line format with bullets
- **Minimum one bullet per file changed** when using bullet format
- Group related file changes together when logical

For multi-file changes:
- First line: Overall summary
- Blank line
- At least one bullet point per file describing what changed
- Group related changes when multiple files serve same purpose

### 5. Confirm Commit Message

- Display the proposed commit message
- **REQUIRED:** Ask user: "Proceed with this commit message? (y/n)"
- If no, ask for user to provide their own message
- If yes, continue to step 6
- **NEVER proceed without explicit confirmation**

### 6. Stage and Commit

- Run `git add .`
- Create commit ONLY with confirmed message
- Do NOT commit if user has not confirmed

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

### Multi-File Commits (2+ files)
```
feat: Add parallel Claude Code agent system

- commands/parallel/init-parallel.md: Add initialization command
- commands/parallel/execute-parallel.md: Add execution workflow
- commands/parallel/cleanup-parallel.md: Add cleanup strategies
- scripts/parallel-agent.js: Core agent lifecycle management
- lib/worktree-manager.js: Worktree creation and isolation
- lib/session-store.js: Persistence and progress monitoring
```

```
refactor: Restructure authentication system

- services/auth.service.ts: Extract auth logic into dedicated service
- middleware/auth.middleware.ts: Implement token refresh mechanism
- config/oauth.config.ts: Add OAuth2 provider configurations
- migrations/001-auth-sessions.sql: Migrate session format
- api/users/route.ts: Update to use new auth service
- api/profile/route.ts: Update to use new auth service
- api/settings/route.ts: Update to use new auth service
```

```
fix: Resolve critical data synchronization issues

- lib/sync-manager.ts: Fix race condition with mutex locking
- lib/data-writer.ts: Add write queue for concurrent operations
- lib/sync-retry.ts: Implement exponential backoff retry logic
- middleware/error-handler.ts: Add sync-specific error handling
- lib/telemetry.ts: Add sync failure tracking and metrics
- tests/sync.test.ts: Add comprehensive sync tests
```

## Guidelines

- **Required:** At least one bullet per file when multiple files changed
- Include filename at start of each bullet (e.g., `file.ts: Change description`)
- Keep bullet points concise and parallel in structure
- Group related file changes when they serve the same purpose
- Focus on WHAT changed in each file, not HOW
- Single file changes can use simple one-line format

## Important Notes

- NO emojis
- NO signatures or attribution
- NO verbose explanations in the commit message
- Keep technical but accessible
- Let the code tell the HOW, commit tells the WHAT
- **CRITICAL: Never commit without user confirmation of the message**
