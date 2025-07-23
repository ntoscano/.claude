#!/bin/bash

# Parallel Claude Code Manager
# Handles full lifecycle: create → execute → cleanup

set -e

BASE_DIR="$(pwd)"
TREES_DIR="$BASE_DIR/trees"
SESSION_FILE="$BASE_DIR/.parallel-session"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}[$(date +%H:%M:%S)]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
    exit 1
}

# Initialize parallel session
init_parallel() {
    local feature_name="$1"
    local num_agents="${2:-4}"
    
    if [[ -z "$feature_name" ]]; then
        error "Feature name required: ./parallel-manager.sh init my-feature [num_agents]"
    fi
    
    log "Initializing $num_agents parallel worktrees for feature: $feature_name"
    
    # Clean up any existing session
    if [[ -f "$SESSION_FILE" ]]; then
        warning "Existing parallel session found. Cleaning up first..."
        cleanup_parallel
    fi
    
    # Create trees directory
    mkdir -p "$TREES_DIR"
    
    # Create worktrees
    for i in $(seq 1 $num_agents); do
        local branch_name="${feature_name}-agent${i}"
        local worktree_path="$TREES_DIR/${branch_name}"
        
        log "Creating worktree: $branch_name"
        git worktree add "$worktree_path" -b "$branch_name"
        
        # Copy essential files
        if [[ -f ".env" ]]; then
            cp .env "$worktree_path/"
        fi
        
        # Install dependencies in background
        log "Installing dependencies for agent $i..."
        (cd "$worktree_path" && npm install > /dev/null 2>&1) &
    done
    
    # Wait for all npm installs
    wait
    success "All dependencies installed"
    
    # Create session tracking file
    cat > "$SESSION_FILE" << EOF
feature=$feature_name
agents=$num_agents
created="$(date)"
status=initialized
EOF
    
    success "Created $num_agents parallel worktrees for '$feature_name'"
    git worktree list
    
    echo ""
    echo "🚀 Ready to launch agents:"
    for i in $(seq 1 $num_agents); do
        echo "   Terminal $i: cd trees/${feature_name}-agent${i} && claude"
    done
    echo ""
    echo "📋 Or use: ./parallel-manager.sh execute \"your task description\""
    echo "🧹 Cleanup: ./parallel-manager.sh cleanup"
}

# Execute parallel tasks
execute_parallel() {
    local task_description="$1"
    
    if [[ ! -f "$SESSION_FILE" ]]; then
        error "No parallel session found. Run 'init' first."
    fi
    
    source "$SESSION_FILE"
    
    if [[ -z "$task_description" ]]; then
        error "Task description required: ./parallel-manager.sh execute \"task description\""
    fi
    
    log "Launching $agents Claude Code sessions for task: $task_description"
    
    # Create task instructions for each agent
    for i in $(seq 1 $agents); do
        local agent_dir="$TREES_DIR/${feature}-agent${i}"
        cat > "$agent_dir/AGENT_TASK.md" << EOF
# Agent $i Task

**Feature**: $feature
**Task**: $task_description
**Agent Role**: Agent $i of $agents

## Instructions:
1. Work on the assigned task in this isolated worktree
2. Commit your changes with descriptive messages
3. Create a RESULTS.md file documenting what you accomplished
4. Signal completion by creating a .AGENT_COMPLETE file

## Coordination:
- You are Agent $i working in parallel with $(($agents - 1)) other agents
- Each agent works in a separate worktree/branch
- Focus on your specific part of the overall task
- Communicate results through git commits and RESULTS.md

## Workspace:
- Branch: ${feature}-agent${i}
- Directory: $agent_dir
- Isolated from other agents' work
EOF
    done
    
    # Launch Claude Code sessions (macOS)
    if command -v osascript &> /dev/null; then
        for i in $(seq 1 $agents); do
            local agent_dir="$TREES_DIR/${feature}-agent${i}"
            osascript -e "tell application \"Terminal\" to do script \"cd '$agent_dir' && echo '🤖 Agent $i: $task_description' && echo '📁 $(pwd)' && echo '🌿 Branch: ${feature}-agent${i}' && echo '' && cat AGENT_TASK.md && echo '' && claude\""
        done
    else
        # Fallback for non-macOS
        log "macOS auto-launch not available. Launch manually:"
        for i in $(seq 1 $agents); do
            echo "   Terminal $i: cd trees/${feature}-agent${i} && claude"
        done
    fi
    
    # Update session status
    sed -i '' 's/status=.*/status=executing/' "$SESSION_FILE"
    
    success "Launched $agents parallel Claude Code sessions"
    echo ""
    echo "📊 Monitor progress with: ./parallel-manager.sh status"
    echo "🧹 Cleanup when done: ./parallel-manager.sh cleanup"
}

# Show status of parallel session
show_status() {
    if [[ ! -f "$SESSION_FILE" ]]; then
        error "No parallel session found."
    fi
    
    source "$SESSION_FILE"
    
    echo "🔄 Parallel Session Status"
    echo "=========================="
    echo "Feature: $feature"
    echo "Agents: $agents"
    echo "Created: $created"
    echo "Status: $status"
    echo ""
    
    echo "📋 Worktree Status:"
    git worktree list | grep trees/ || echo "No worktrees found"
    echo ""
    
    echo "🎯 Agent Progress:"
    for i in $(seq 1 $agents); do
        local agent_dir="$TREES_DIR/${feature}-agent${i}"
        if [[ -d "$agent_dir" ]]; then
            local branch_status="Active"
            if [[ -f "$agent_dir/.AGENT_COMPLETE" ]]; then
                branch_status="✅ Complete"
            elif [[ -f "$agent_dir/RESULTS.md" ]]; then
                branch_status="🔄 In Progress"
            fi
            echo "   Agent $i: $branch_status"
            
            # Show recent commits
            local commits=$(cd "$agent_dir" && git log --oneline -3 2>/dev/null || echo "No commits")
            if [[ "$commits" != "No commits" ]]; then
                echo "     Latest commits:"
                echo "$commits" | sed 's/^/       /'
            fi
        else
            echo "   Agent $i: ❌ Missing"
        fi
    done
}

# Cleanup parallel session
cleanup_parallel() {
    local force_flag="$1"
    
    if [[ ! -f "$SESSION_FILE" ]]; then
        warning "No parallel session found to cleanup"
        return 0
    fi
    
    source "$SESSION_FILE"
    
    log "Cleaning up parallel session: $feature ($agents agents)"
    
    # Check for uncommitted changes first
    local dirty_agents=()
    for i in $(seq 1 $agents); do
        local agent_dir="$TREES_DIR/${feature}-agent${i}"
        if [[ -d "$agent_dir" ]]; then
            cd "$agent_dir"
            if ! git diff-index --quiet HEAD 2>/dev/null; then
                dirty_agents+=("$i")
            fi
            cd "$BASE_DIR"
        fi
    done
    
    # Warn about dirty worktrees
    if [[ ${#dirty_agents[@]} -gt 0 && "$force_flag" != "--force" ]]; then
        warning "Agents with uncommitted changes: ${dirty_agents[*]}"
        echo "Review and commit changes, or use --force to discard"
        echo ""
        for agent in "${dirty_agents[@]}"; do
            echo "Agent $agent status:"
            local agent_dir="$TREES_DIR/${feature}-agent${agent}"
            cd "$agent_dir" && git status --short
            cd "$BASE_DIR"
            echo ""
        done
        return 1
    fi
    
    # Show summary of work before cleanup
    echo ""
    echo "📊 Work Summary:"
    for i in $(seq 1 $agents); do
        local agent_dir="$TREES_DIR/${feature}-agent${i}"
        if [[ -d "$agent_dir" ]]; then
            echo "Agent $i commits:"
            cd "$agent_dir"
            git log --oneline main..HEAD 2>/dev/null | sed 's/^/  /' || echo "  No commits"
            cd "$BASE_DIR"
        fi
    done
    echo ""
    
    # Interactive merge strategy (unless force)
    if [[ "$force_flag" != "--force" ]]; then
        echo "🔀 Merge Strategy:"
        echo "1) Merge all agent branches to main"
        echo "2) Create single feature branch from best result"  
        echo "3) No merge - just cleanup worktrees"
        echo "4) Cancel cleanup"
        read -p "Choose option (1-4): " merge_choice
        
        case $merge_choice in
            1)
                git checkout main
                for i in $(seq 1 $agents); do
                    local branch_name="${feature}-agent${i}"
                    if git show-ref --verify --quiet "refs/heads/$branch_name"; then
                        log "Merging $branch_name to main"
                        git merge --no-ff "$branch_name" -m "Merge $branch_name: parallel work"
                    fi
                done
                ;;
            2)
                read -p "Which agent had the best result? (1-$agents): " best_agent
                local best_branch="${feature}-agent${best_agent}"
                git checkout -b "$feature" main
                git merge --no-ff "$best_branch" -m "Merge best result from $best_branch"
                success "Created feature branch '$feature' from agent $best_agent"
                ;;
            3)
                log "Skipping merge - only cleaning up worktrees"
                ;;
            4)
                log "Cleanup cancelled"
                return 0
                ;;
            *)
                error "Invalid choice"
                ;;
        esac
    fi
    
    # Remove worktrees
    for i in $(seq 1 $agents); do
        local agent_dir="$TREES_DIR/${feature}-agent${i}"
        local branch_name="${feature}-agent${i}"
        
        if [[ -d "$agent_dir" ]]; then
            if [[ "$force_flag" == "--force" ]]; then
                git worktree remove --force "$agent_dir"
            else
                git worktree remove "$agent_dir" 2>/dev/null || {
                    warning "Could not remove $agent_dir (dirty worktree)"
                    continue
                }
            fi
            success "Removed worktree: agent $i"
            
            # Optionally delete branch
            if [[ "$force_flag" == "--force" ]]; then
                git branch -D "$branch_name" 2>/dev/null || true
            fi
        fi
    done
    
    # Final cleanup
    git worktree prune
    rm -f "$SESSION_FILE"
    
    if [[ -d "$TREES_DIR" ]] && [[ -z "$(ls -A "$TREES_DIR")" ]]; then
        rmdir "$TREES_DIR"
    fi
    
    success "Parallel session cleanup complete"
    git worktree list
}

# Main command dispatcher
case "$1" in
    init|initialize)
        init_parallel "$2" "$3"
        ;;
    exec|execute)
        execute_parallel "$2"
        ;;
    status)
        show_status
        ;;
    cleanup|clean)
        cleanup_parallel "$2"
        ;;
    *)
        echo "🌳 Parallel Claude Code Manager"
        echo ""
        echo "Usage: $0 <command> [options]"
        echo ""
        echo "Commands:"
        echo "  init <feature-name> [num-agents]  Initialize parallel worktrees"
        echo "  execute \"<task>\"                  Launch Claude agents with task"
        echo "  status                           Show session status"
        echo "  cleanup [--force]                Merge results and cleanup"
        echo ""
        echo "Examples:"
        echo "  $0 init ui-redesign 3           # Create 3 parallel agents"
        echo "  $0 execute \"Improve homepage\"   # Launch agents with task"  
        echo "  $0 status                       # Check progress"
        echo "  $0 cleanup                      # Merge and cleanup"
        echo ""
        echo "Current session:"
        if [[ -f "$SESSION_FILE" ]]; then
            source "$SESSION_FILE"
            echo "  Feature: $feature ($agents agents)"
        else
            echo "  No active session"
        fi
        ;;
esac