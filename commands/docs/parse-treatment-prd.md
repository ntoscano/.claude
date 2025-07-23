---
allowed-tools: Read, Write, Bash, Grep, Glob, Task, TodoWrite, mcp__taskmaster-ai__add_tag, mcp__taskmaster-ai__use_tag, mcp__taskmaster-ai__list_tags, mcp__taskmaster-ai__get_tasks
description: Parse a treatment protocol requirements document (PRD) into TaskMaster JSON format for therapeutic session delivery
---

# Parse Treatment PRD into TaskMaster Tasks

## Context

- **User Request:** $ARGUMENTS
- Current directory: !`pwd`
- Task Master state: !`cat .taskmaster/state.json 2>/dev/null || echo "No state file yet"`
- Current tag: !`jq -r '.currentTag // "master"' .taskmaster/state.json 2>/dev/null || echo "master"`
- Available tags: !`jq -r '.tags | keys | join(", ")' .taskmaster/tasks/tasks.json 2>/dev/null || echo "No tags yet"`
- Treatment PRD files: !`ls -la .taskmaster/docs/prd-*-chunks.md 2>/dev/null | tail -5 || echo "No treatment PRD files found"`

## Goal

Parse a Treatment Protocol Requirements Document (PRD) into structured TaskMaster JSON tasks that enable AI-delivered therapeutic sessions. This command creates tasks for DELIVERING THERAPEUTIC CONTENT in virtual sessions, NOT for building software or implementing technical features.

**CRITICAL: Tasks should focus on PRESENTING therapy content, GUIDING users through exercises, and MAINTAINING therapeutic role - not on software development, system building, or technical implementation.**

## Process

### 1. Determine Treatment PRD Location

**Think about which treatment PRD file the user wants to parse.**

Check for:
- Explicit treatment PRD path in arguments (e.g., `.taskmaster/docs/prd-cognitive-distortion-chunks.md`)
- Pattern matching for treatment PRDs: `.taskmaster/docs/prd-*-chunks.md`
- Default treatment PRD locations

### 2. Extract Treatment Information for SESSION DELIVERY

From the treatment PRD, extract:
- **Treatment Name**: From filename pattern `prd-[treatment-name]-chunks.md`
- **Therapeutic Role**: CBT therapist persona, boundaries, interaction style
- **Task Structure**: Treatment-specific therapeutic tasks with 4 subtasks each, ALWAYS starting with "Set Therapeutic Role and Context" as Task 1
- **Complete Therapeutic Content**: All original clinical material embedded in subtasks

**FOCUS: Each task should be about DELIVERING therapeutic content to users, not building systems or implementing features. Use action words like "Present", "Guide", "Explain", "Help user practice" - NOT "Implement", "Develop", "Create system", "Build".**

**CRITICAL REQUIREMENT: ALL treatment protocols must begin with Task 1 "Set Therapeutic Role and Context" containing these standard subtasks:**
1. **Establish CBT therapist persona** - Use calm, supportive CBT therapist role with professional boundaries
2. **Explain session structure and expectations** - Describe virtual therapy format and educational approach
3. **Introduce treatment concept** - Present specific treatment focus (with engaging metaphor if appropriate)
4. **User acknowledgment and readiness check** - Ensure understanding before proceeding to treatment content

### 3. Tag Context Decision for Treatment

**Treatment protocols require specific tag management:**

- **Always create treatment-specific tag**: Use pattern `[treatment-name]-session`
- **Never use master tag**: Treatment sessions must be isolated
- **Tag naming**: Extract from PRD filename (e.g., `cognitive-distortion-session`)

### 4. Execute Treatment Parse Workflow

Based on treatment PRD structure:

1. **Extract treatment name from PRD filename**
2. **Create treatment session tag**
3. **Switch to treatment tag context**
4. **Parse therapeutic tasks with complete clinical content**
5. **Generate tasks with 4 subtasks each (starting with standard Task 1 "Set Therapeutic Role and Context")**
6. **Ensure proper task dependencies for therapeutic progression**

## Treatment PRD Structure Recognition

Treatment PRDs follow this specific structure:

### Task Pattern Recognition
```markdown
### Task [N]: [Task Title]
**Subtasks:**
- **[N].1: [Subtask Title]** - [Complete therapeutic content]
- **[N].2: [Subtask Title]** - [Complete therapeutic content]
- **[N].3: [Subtask Title]** - [Complete therapeutic content]
- **[N].4: [Subtask Title]** - [Complete therapeutic content]
```

### Therapeutic Content Preservation for SESSION DELIVERY
- Extract complete original therapeutic content from each subtask for PRESENTATION to users
- Preserve clinical language and evidence-based material for DELIVERY during sessions
- Maintain therapeutic progression and dependencies for GUIDED session flow
- Include all examples, analogies, and exercise instructions for USER INTERACTION

**REMEMBER: Tasks are for AI to DELIVER content in therapeutic conversations, not to build technical systems.**

## Execution Steps

### Treatment PRD Parsing Workflow

```markdown
1. **Extract treatment name** from PRD filename:
   - Pattern: `prd-[treatment-name]-chunks.md`
   - Example: `cognitive-distortion` from `prd-cognitive-distortion-chunks.md`

2. **Create treatment session tag**:
   - Tag name: `[treatment-name]-session`
   - Description: "Virtual therapy session for [treatment-name] protocol delivery"

3. **Switch to treatment tag**:
   - Use: use_tag to set therapeutic context

4. **Parse treatment PRD into tasks**:
   - Read PRD content structure
   - Extract 18 therapeutic tasks
   - Parse 4 subtasks per task with complete content
   - Set proper dependencies for therapeutic sequence

5. **Generate TaskMaster JSON**:
   - Create properly formatted tasks.json structure
   - Include metadata for treatment session context
   - Preserve all therapeutic content in subtasks
```

## TaskMaster JSON Structure for Treatment

Generate this exact JSON structure:

```json
{
  "[treatment-name]-session": {
    "tasks": [
      {
        "id": 1,
        "title": "[Task Title from PRD]",
        "description": "[Task description from PRD]",
        "details": "[Complete task details]",
        "testStrategy": "",
        "status": "pending",
        "dependencies": [],
        "priority": "high|medium",
        "subtasks": [
          {
            "id": 1,
            "title": "[Subtask title]",
            "description": "[Complete therapeutic content from PRD]",
            "details": "",
            "status": "pending",
            "dependencies": [],
            "parentTaskId": 1
          }
        ]
      }
    ],
    "metadata": {
      "created": "[ISO timestamp]",
      "updated": "[ISO timestamp]",
      "description": "Tasks for [treatment-name]-session context"
    }
  }
}
```

## Content Extraction Rules for THERAPEUTIC SESSION DELIVERY

### From Treatment PRD to TaskMaster JSON:

1. **Task Extraction for SESSION DELIVERY**:
   - Each `### Task [N]: [Title]` becomes a TaskMaster task for CONTENT DELIVERY
   - Preserve exact title and description from PRD but focus on DELIVERING to users
   - Extract complete `details` section content for AI to PRESENT during sessions
   - **Task titles should focus on delivery**: "Present cognitive distortion concept", "Guide user through thought record", "Help user identify patterns"

2. **Subtask Extraction for USER INTERACTION**:
   - Each `**[N].[X]: [Title]** - [Content]` becomes a subtask for USER GUIDANCE
   - Include complete therapeutic content in `description` field for AI to DELIVER conversationally
   - Preserve all clinical material, examples, and exercises for INTERACTIVE presentation
   - **Subtask descriptions should be therapeutic actions**: "Present this content: [exact clinical material]", "Guide user through this exercise: [steps]", "Help user practice: [instructions]"

3. **AVOID SOFTWARE DEVELOPMENT LANGUAGE**:
   - ❌ DON'T USE: "Implement", "Develop", "Create system", "Build infrastructure", "Configure"
   - ✅ DO USE: "Present", "Guide", "Explain", "Help user", "Deliver content", "Facilitate exercise"

### GOOD vs BAD TASK EXAMPLES:

**❌ BAD (Software Development Focus):**
- "Implement Step 1 - Automatic Negative Thoughts Awareness"
- "Develop the complete Step 1 therapeutic content"
- "Create comprehensive session state management system"
- "Build thought record teaching module"

**✅ GOOD (Therapeutic Session Focus):**  
- "Present Automatic Negative Thoughts Education"
- "Guide User Through Thought Record Practice"
- "Help User Identify Personal Thinking Patterns"
- "Facilitate All-or-Nothing Thinking Recognition Exercise"

4. **Dependency Mapping**:
   - Sequential dependencies: Task N depends on Task N-1
   - Foundation tasks (1-2) get priority "high"
   - Distortion tasks (3-13) get priority "medium" 
   - Technique tasks (14-18) get priority "high"

4. **Therapeutic Role Preservation**:
   - Extract therapeutic role specification from PRD
   - Include in Task 1 subtasks for proper AI persona setup

## Interactive Flow

Based on User Request, determine the appropriate flow:

### If arguments include treatment PRD path:
1. **Extract treatment name** from filename
2. **Create treatment session tag**
3. **Parse the treatment PRD into JSON**
4. **Write to tasks.json in correct format**

### If arguments include treatment name:
1. **Look for corresponding treatment PRD**
2. **Confirm PRD found and parseable**
3. **Execute full parsing workflow**

### If no arguments:
1. **List available treatment PRDs**
2. **Ask user to specify which treatment to parse**
3. **Execute parsing for selected treatment**

## Therapeutic Content Validation

### During Parsing, Ensure:

- **Complete Content**: All therapeutic material from PRD is included
- **Clinical Accuracy**: Original clinical language is preserved
- **Exercise Instructions**: Exact reflection exercise steps are included
- **Therapeutic Progression**: Sequential dependencies maintain learning flow
- **Role Boundaries**: AI therapeutic limits are clearly specified

### Quality Checks:

- **18 Tasks Generated**: Verify complete protocol structure
- **4 Subtasks Each**: Ensure proper task breakdown
- **Content Preservation**: Check that no therapeutic material is lost
- **JSON Validity**: Confirm proper TaskMaster format structure

## Example Usage

```bash
# Parse specific treatment PRD
/parse-treatment-prd .taskmaster/docs/prd-cognitive-distortion-chunks.md

# Parse by treatment name
/parse-treatment-prd cognitive-distortion

# Parse with automatic detection
/parse-treatment-prd
```

## Output

The command will:

1. **Create Treatment Tag**: `[treatment-name]-session`
2. **Generate tasks.json**: Properly formatted TaskMaster structure
3. **Preserve Content**: All therapeutic material included in subtasks
4. **Set Dependencies**: Sequential therapeutic progression maintained
5. **Enable AI Delivery**: Ready for Claude-powered session orchestration

## Next Steps Suggestion

After parsing, recommend:

1. **Switch to treatment tag**: Use `/task:list` to view generated tasks
2. **Start therapeutic session**: Use `/task:next` to begin protocol delivery
3. **Review task structure**: Verify therapeutic content is complete
4. **Test AI delivery**: Ensure Claude can access all clinical material for session facilitation

## Therapeutic Compliance

This command ensures:

- **Clinical Fidelity**: Original therapeutic content is preserved exactly
- **Evidence-Based**: All CBT concepts and techniques maintain clinical accuracy
- **Session Structure**: Proper therapeutic progression from foundation to application
- **AI Boundaries**: Clear therapeutic limits for AI-delivered sessions

The resulting TaskMaster tasks enable authentic, AI-orchestrated virtual therapy sessions while maintaining complete therapeutic integrity.