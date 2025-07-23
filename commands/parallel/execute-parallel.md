# Execute Parallel Tasks Across Worktrees

Launch Claude Code sessions in parallel worktrees and execute tasks.

**Usage**: `/execute-parallel "task description here"`

## Steps to Execute:

1. **Verify Parallel Session**:
   - Check if `.parallel-session` exists
   - Read feature name and number of agents
   - Verify worktrees still exist

2. **Prepare Task Instructions**:
   - Create task instruction file for each agent
   - Include specific context for each agent's role
   - Set up task coordination if needed

3. **Launch Agents** (macOS with Terminal):
   ```bash
   # For each worktree:
   osascript -e "tell application \"Terminal\" to do script \"cd '{worktree_path}' && echo 'Agent {N}: {task}' && claude\""
   ```

4. **Monitor Progress**:
   - Create status tracking system
   - Show which agents are active
   - Provide coordination commands

## Expected Output:
- N Terminal windows opened with Claude Code sessions
- Each agent working in isolated worktree
- Status tracking file created
- Coordination commands displayed