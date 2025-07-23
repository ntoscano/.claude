# 🤖 Parallel Claude Code Agents Setup

## Quick Start - Complete Workflow

```bash
# 1. Initialize n parallel agents  
./parallel-manager.sh init my-feature 4

# 2. Execute task across all agents
./parallel-manager.sh execute "Implement user authentication system"

# 3. Monitor progress
./parallel-manager.sh status

# 4. Cleanup when complete (merges results)
./parallel-manager.sh cleanup
```

## 🔄 Full Lifecycle Management

### Phase 1: Initialize (`/init-parallel` or CLI)
- Creates n worktrees in `./trees/` directory
- Each agent gets separate branch: `feature-agent1`, `feature-agent2`, etc.
- Installs dependencies in parallel
- Creates session tracking file

### Phase 2: Execute (`/execute-parallel` or CLI) 
- Launches n Claude Code sessions automatically (macOS)
- Each agent gets specific task instructions
- Agents work in complete isolation
- Progress tracked through git commits

### Phase 3: Monitor (`./parallel-manager.sh status`)
- Shows which agents are active/complete
- Displays recent commits from each agent
- Tracks overall session progress

### Phase 4: Cleanup (`/cleanup-parallel` or CLI)
- **Automatic detection** of completed work
- **Interactive merge strategy** (merge all, pick best, or manual)
- **Safe cleanup** - won't delete uncommitted work
- **Complete cleanup** - removes worktrees, branches, temp files

## 🎯 Claude Commands Usage

### Method 1: Claude Slash Commands
```
/init-parallel my-feature 4
/execute-parallel "Build authentication system"  
/cleanup-parallel
```

### Method 2: Direct Script (Recommended)
```bash
./parallel-manager.sh init ui-redesign 3
./parallel-manager.sh execute "Redesign the homepage components"
./parallel-manager.sh status  
./parallel-manager.sh cleanup
```

## 🛠️ Advanced Features

### Automatic Dependency Management
- Each worktree gets independent `node_modules`
- Dependencies installed in parallel during init
- No conflicts between agent environments

### Smart Cleanup System
```bash
# Safe cleanup (interactive)
./parallel-manager.sh cleanup

# Force cleanup (skips prompts)  
./parallel-manager.sh cleanup --force
```

### Merge Strategies
1. **Merge All**: Combine all agent results
2. **Pick Best**: Select one agent's work as the winner
3. **No Merge**: Just cleanup worktrees, keep branches
4. **Cancel**: Abort cleanup for manual review

### Session Persistence
- Session state stored in `.parallel-session`
- Survives terminal restarts
- Tracks feature name, agent count, creation time
- Enables status monitoring across sessions

## 🔍 Monitoring & Debugging

### Check Active Sessions
```bash
./parallel-manager.sh status
```

Shows:
- Feature name and agent count
- Creation timestamp
- Agent completion status
- Recent commits from each agent
- Worktree health status

### Manual Agent Launch
If automatic launch fails:
```bash
# Terminal 1
cd trees/my-feature-agent1 && claude

# Terminal 2  
cd trees/my-feature-agent2 && claude

# etc...
```

### Git Integration
```bash
# See all worktrees
git worktree list

# Check specific agent's work
cd trees/my-feature-agent1
git log --oneline
git diff main

# Manual worktree cleanup
git worktree remove trees/my-feature-agent1
git worktree prune
```

## 🚀 Usage Patterns

### Pattern 1: Feature Development
```bash
./parallel-manager.sh init auth-system 3
./parallel-manager.sh execute "Implement JWT authentication with login/logout/refresh"
# Agents work in parallel on different aspects
./parallel-manager.sh cleanup  # Pick best implementation
```

### Pattern 2: A/B Testing Approaches  
```bash
./parallel-manager.sh init performance-test 2
./parallel-manager.sh execute "Optimize homepage load time - try different approaches"
# Agent 1: Image optimization route
# Agent 2: Code splitting route  
./parallel-manager.sh cleanup  # Compare and choose best
```

### Pattern 3: Parallel Bug Fixes
```bash
./parallel-manager.sh init bugfix-batch 4
./parallel-manager.sh execute "Fix the login, navigation, and search bugs"
# Each agent tackles different bugs
./parallel-manager.sh cleanup  # Merge all fixes
```

### Pattern 4: Code Exploration
```bash
./parallel-manager.sh init explore-options 3  
./parallel-manager.sh execute "Research and prototype 3 different state management solutions"
# Each agent explores different libraries
./parallel-manager.sh cleanup  # Create comparison branch
```

## ⚠️ Safety Features

### Prevents Data Loss
- ✅ Never removes worktrees with uncommitted changes
- ✅ Interactive confirmation before merging
- ✅ Shows work summary before cleanup
- ✅ Creates backup branches automatically

### Isolation Guarantees  
- ✅ Separate git branches for each agent
- ✅ Independent file systems (no conflicts)
- ✅ Isolated Claude Code contexts
- ✅ Parallel dependency installations

### Error Recovery
- ✅ Session state survives crashes
- ✅ Partial cleanup support (some agents can fail)
- ✅ Manual override options (`--force`)
- ✅ Git worktree prune for corrupted state

## 🧹 Cleanup Behavior

### What Gets Cleaned Up
- ✅ All agent worktrees in `./trees/`
- ✅ Temporary agent branches (optional)
- ✅ Session tracking file (`.parallel-session`)
- ✅ Stale git worktree references

### What Gets Preserved
- ✅ Merged work in main/feature branch
- ✅ Commit history from all agents
- ✅ Any manually created files outside `./trees/`

## 📁 Directory Structure During Session

```
project/
├── .parallel-session          # Session tracking
├── trees/                     # Temporary agent worktrees
│   ├── my-feature-agent1/     # Agent 1 workspace
│   ├── my-feature-agent2/     # Agent 2 workspace  
│   └── my-feature-agent3/     # Agent 3 workspace
└── .claude/
    ├── commands/              # Claude slash commands
    │   ├── init-parallel.md
    │   ├── execute-parallel.md
    │   └── cleanup-parallel.md
    └── scripts/
        └── parallel-manager.sh    # Main orchestrator
```

## 🎛️ Configuration

### Environment Requirements
- **Git 2.5+** (for worktree support)
- **Node.js/npm** (for dependency management)
- **macOS Terminal** (for auto-launch, optional)
- **Claude Code** (latest version)

### Customization
Edit `parallel-manager.sh` to modify:
- Default agent count (currently 4)
- Worktree location (`./trees/`)
- Merge strategies
- Auto-launch behavior

---

## 🎯 The Complete Answer to Your Question

**"How does Claude know to spin up n worktrees and clean them up?"**

1. **Claude Slash Commands**: `/init-parallel feature-name 4` → Claude runs the orchestrator
2. **Automatic Lifecycle**: Creates → Executes → Monitors → Cleans up
3. **Session Tracking**: `.parallel-session` file maintains state
4. **Smart Cleanup**: Detects when work is done, merges results safely
5. **Safety First**: Never loses uncommitted work, interactive confirmation

**Usage**: Just tell Claude: *"Set up 4 parallel agents to work on authentication"* 

Claude will:
1. Run `/init-parallel auth 4` 
2. Launch 4 isolated Claude Code sessions
3. Monitor their progress
4. When done, merge results and cleanup automatically

**Zero manual worktree management required!** 🎉