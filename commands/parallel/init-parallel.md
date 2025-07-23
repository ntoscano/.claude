# Initialize Parallel Development Worktrees

Create n parallel worktrees for concurrent Claude Code sessions.

**Usage**: `/init-parallel feature-name 4` (creates 4 parallel agents)

## Steps to Execute:

1. **Parse Arguments**:
   - Extract feature name and number of agents from $ARGUMENTS
   - Default to 4 agents if number not specified

2. **Create Worktrees**:
   ```bash
   # For each agent 1 to N:
   git worktree add ./trees/{feature-name}-agent{N} -b {feature-name}-agent{N}
   ```

3. **Setup Dependencies**:
   - Copy essential files (.env, package.json, etc.) to each worktree
   - Install npm dependencies in parallel for each worktree

4. **Create Tracking File**:
   ```bash
   echo "feature={feature-name}" > .parallel-session
   echo "agents={N}" >> .parallel-session  
   echo "created=$(date)" >> .parallel-session
   ```

5. **Display Results**:
   - Show `git worktree list`
   - Provide launch commands for each agent
   - Show cleanup command

## Expected Output:
- N worktrees created in `./trees/` directory
- Each worktree on separate branch
- Dependencies installed in each
- Ready for parallel Claude Code sessions