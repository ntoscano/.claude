---
allowed-tools: all
description: Break down any request into subtasks, identify gaps, and proceed interactively
---

# Please Do Interactive

## Context

- **User Request:** $ARGUMENTS

## Goal

Break down the user's request into manageable subtasks, identify any gaps in knowledge or context that might cause issues, clarify these gaps interactively, then proceed with implementation using the gathered information.

## Process

### 1. Request Analysis

**Think deeply about the request:**
- What is the core goal?
- What are the implicit requirements?
- What assumptions am I making?
- What could go wrong?

### 2. Task Breakdown

Break the request into logical subtasks:
- Identify main components
- Order tasks by dependencies
- Estimate complexity of each task
- Note potential blockers

### 3. Gap Identification

**Identify knowledge/context gaps:**
- Missing specifications
- Ambiguous requirements
- Technical decisions needed
- Environmental assumptions
- Edge cases to consider

### 4. Interactive Clarification

Ask targeted questions about identified gaps:
- Present questions clearly with options when applicable
- Group related questions
- Prioritize critical gaps first
- Provide context for why each question matters

### 5. Implementation Plan

Based on clarifications:
- Refine task breakdown
- Update approach based on answers
- Create detailed implementation steps
- Proceed with execution

## Question Framework

When asking clarifying questions, structure them as:

### 🎯 Core Requirements
- What exactly should happen?
- What's the expected outcome?

### 🔧 Technical Details
- Which approach is preferred?
- What constraints exist?

### 🚨 Edge Cases
- How should errors be handled?
- What about special scenarios?

### 📁 Context
- Where should changes be made?
- What existing patterns to follow?

## Example Interaction

**User:** "please-do-interactive implement a caching system"

**Assistant Response:**

I'll help you implement a caching system. Let me break this down and identify what I need to know.

### Task Breakdown:
1. Design cache architecture
2. Implement cache storage
3. Add cache invalidation
4. Integrate with existing code
5. Add monitoring/debugging

### Clarifying Questions:

**1. What type of data will be cached?**
   a. API responses
   b. Database queries
   c. Computed values
   d. Static assets
   e. Other (please specify)

**2. What's the primary goal?**
   a. Reduce latency
   b. Lower server load
   c. Reduce API costs
   d. All of the above

**3. Which caching strategy do you prefer?**
   a. In-memory (fast, volatile)
   b. Redis (distributed, persistent)
   c. File-based (simple, persistent)
   d. Browser storage (client-side)
   e. Unsure - need recommendation

**4. How should the cache be invalidated?**
   a. Time-based (TTL)
   b. Event-based (on updates)
   c. Manual (explicit clear)
   d. Combination of above

**5. Which parts of your app need caching?**
   a. Specific routes/endpoints
   b. Database layer
   c. External API calls
   d. Entire application

**6. Do you have existing caching code?**
   a. Yes - need to extend it
   b. No - starting fresh
   c. Some partial implementation

Please answer with the question number and letter choice (e.g., "1a, 2d, 3e") or provide additional details where needed.

## Implementation Guidelines

After receiving clarifications:

1. **Summarize Understanding:**
   - Restate the requirements
   - Confirm the approach
   - List deliverables

2. **Create Todo List:**
   - Use TodoWrite for complex tasks
   - Track progress systematically
   - Update status as you work

3. **Execute with Confidence:**
   - Implement based on clarified requirements
   - Follow stated preferences
   - Handle identified edge cases

4. **Verify & Report:**
   - Test implementation
   - Document decisions made
   - Report completion status

## Best Practices

### DO:
- Ask about critical decisions upfront
- Group related questions together
- Provide context for why you're asking
- Give examples in questions
- Proceed confidently after clarification

### DON'T:
- Ask too many questions at once (5-7 max)
- Ask about trivial implementation details
- Make assumptions about critical features
- Proceed with major gaps unaddressed
- Repeat questions already answered

## Usage Examples

```
/please-do-interactive refactor the authentication system

/please-do-interactive add real-time notifications

/please-do-interactive optimize database queries
```