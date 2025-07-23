---
allowed-tools: all
description: Break down any request into subtasks, identify gaps, and proceed interactively
---

# Please Do Interactive

**User Request:** $ARGUMENTS

## Process

1. **Analyze Request**
   - Core goal and implicit requirements
   - Assumptions and potential issues

2. **Break Down Tasks**
   - Main components and dependencies
   - Complexity and blockers

3. **Identify Gaps**
   - Missing specs, ambiguities
   - Technical decisions needed
   - Edge cases

4. **Ask Questions**
   - Group related questions (5-7 max)
   - Provide options when applicable
   - Explain why each matters

5. **Execute**
   - Refine plan based on answers
   - Use TodoWrite for complex tasks
   - Implement confidently

## Question Structure

**🎯 Core:** What exactly should happen?
**🔧 Technical:** Which approach? What constraints?
**🚨 Edge Cases:** Error handling? Special scenarios?
**📁 Context:** Where to implement? Existing patterns?

## Example

**User:** "please-do-interactive implement caching"

**Response:**
I'll help implement caching. Let me clarify:

1. **What to cache?**
   a) API responses b) DB queries c) Computed values d) Other

2. **Primary goal?**
   a) Reduce latency b) Lower load c) Cut costs d) All

3. **Strategy?**
   a) In-memory b) Redis c) File-based d) Need recommendation

4. **Invalidation?**
   a) TTL b) Event-based c) Manual d) Combination

Answer with number/letter (e.g., "1a, 2d") or provide details.

## Guidelines

**DO:** Ask critical questions upfront, provide context, give examples
**DON'T:** Over-question, assume critical features, repeat answered questions

After clarification: Summarize → Create todos → Execute → Verify