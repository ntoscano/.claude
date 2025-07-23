---
allowed-tools: Bash, Grep, Read, Task
description: Git add all and commit with concise, thorough message (optional --review flag)
---

# Git Commit (gc)

**Purpose:** Stage all changes and create a commit with a concise but thorough message.

**⚠️ IMPORTANT: This command MUST ask for user confirmation before committing. Never auto-commit.**

## Options
- `--review` or `-r`: Run code review on staged changes before committing

## Process

### 1. Handle Review Flag (if provided)
If `$ARGUMENTS` contains `--review` or `-r`:
- Run `/project:code-review` on staged changes
- Ask: "Code review complete. Proceed with commit? (y/n)"
- Exit if no, continue if yes

### 2. Analyze Staged Changes
- Run `git status` to see staged files
- Use `git diff --cached` to understand staged changes

### 3. Generate Commit Message
Create message that is:
- **Concise:** One line summary (50-72 chars)
- **Professional:** No emojis, signatures, or fluff
- **Single file:** Simple one-line message
- **Multiple files:** Multi-line with bullets (one per file minimum)
- **NO "Co-Authored-By" or metadata**

Use conventional commit prefixes when natural:
`feat:` `fix:` `refactor:` `docs:` `style:` `test:` `chore:`

### 4. Confirm Commit Message
**CRITICAL - STOP FOR USER CONFIRMATION:**
- Display proposed commit message
- Ask: "Does this commit message look right to you? (Y/n)"
- Wait for response (default YES on Enter)
- If "n": Ask for preferred message
- **DO NOT SKIP - NO AUTO-COMMIT**

### 5. Commit Staged Changes (ONLY AFTER CONFIRMATION)
- Run `git commit -m 'message'` using confirmed message
- **NO signatures, emojis, or "Generated with" attributions**
- **NO "Co-Authored-By" or metadata**

## Examples

### Simple Commits
- "Add user authentication module"
- "Fix memory leak in data processor"

### Multi-File Commits
```
feat: Add parallel agent system

- commands/parallel/init.md: Add initialization command
- scripts/agent.js: Core lifecycle management
- lib/worktree.js: Worktree creation and isolation
```

## Guidelines
- One bullet per file for multi-file changes
- Format: `file.ts: Change description`
- Group related changes when logical
- Focus on WHAT changed, not HOW
- **CRITICAL: Never commit without user confirmation**
- **CRITICAL: Use EXACTLY the confirmed message**