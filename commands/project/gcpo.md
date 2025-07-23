---
allowed-tools: Bash, Grep, Read, Task
description: Git commit and push to origin - extends gc with automatic push
---

# Git Commit and Push to Origin (gcpo)

**Purpose:** Stage all changes, create a commit with a concise but thorough message, then push to origin.

## Options

- `--review` or `-r`: Run code review on staged changes before committing

## Process

### 1. Run Git Commit

Execute the full `/project:gc` command with any provided arguments (including --review flag if specified).

### 2. Push to Origin

After successful commit:
- Get current branch name: `git branch --show-current`
- Push to origin: `git push origin [current-branch]`
- If push fails due to no upstream tracking:
  - Set upstream: `git push --set-upstream origin [current-branch]`

### 3. Confirm Success

Show push result and current status:
- Display push output
- Show brief git log of latest commit
- Confirm synchronization with origin

## Error Handling

- If commit fails or is cancelled, do not push
- If push fails, show error and suggest next steps
- Handle cases where branch doesn't exist on remote yet

## Example Usage

```bash
# Simple commit and push
/project:gcpo

# With code review before commit
/project:gcpo --review
```

## Flow Summary

1. Stage changes → 2. (Optional) Code review → 3. Generate commit message → 4. Confirm message → 5. Commit → 6. Push to origin

The command ensures your local changes are committed with a quality message (that you've confirmed) and immediately synchronized with the remote repository.

## Note

This command inherits all functionality from `/project:gc`, including:
- Commit message generation and confirmation
- Optional code review with `--review` flag
- Professional commit message formatting
