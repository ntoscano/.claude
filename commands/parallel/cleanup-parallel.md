# Cleanup Parallel Development Session

Automatically merge results and cleanup worktrees when parallel work is complete.

**Usage**: `/cleanup-parallel` or `/cleanup-parallel --force`

## Steps to Execute:

1. **Check Session Status**:
   - Read `.parallel-session` file
   - Verify all worktrees exist
   - Check for uncommitted changes in each

2. **Review Results**:
   - Show git status for each worktree
   - Display commits made in each branch
   - Identify which agents completed work

3. **Merge Strategy** (Interactive):
   - Option 1: Merge all branches into main
   - Option 2: Cherry-pick specific commits
   - Option 3: Create feature branch from best result
   - Option 4: Manual review before merge

4. **Clean Worktrees**:
   ```bash
   # For each worktree:
   if git -C "./trees/{feature}-agent{N}" diff-index --quiet HEAD; then
     git worktree remove ./trees/{feature}-agent{N}
   else
     echo "⚠️ Agent {N} has uncommitted changes"
   fi
   ```

5. **Final Cleanup**:
   ```bash
   git worktree prune
   rm -f .parallel-session
   rm -rf ./trees  # if empty
   ```

## Safety Features:
- Never force-remove worktrees with uncommitted changes
- Always show what will be merged before merging  
- Create backup branches before cleanup
- Preserve work if --force not specified

## Expected Output:
- Merged results in main branch
- All temporary worktrees removed
- Clean git worktree list
- Summary of work completed