---
allowed-tools: Bash, Read, Write, Glob, Grep, Task, TodoWrite, mcp__taskmaster-ai__parse_prd
description: Generate a structured protocol requirements document from raw treatment content for AI therapeutic session delivery
---

# Generate a Treatment Protocol Requirements Document (PRD)

## Context

- **User Request:** $ARGUMENTS
- **Project Root:** !`pwd`
- **Treatment Files Directory:** !`ls -la treatments/ 2>/dev/null || echo "No treatment files found"`
- **Existing Treatment PRDs:** !`ls -la .taskmaster/docs/prd-*-chunks.md 2>/dev/null || echo "No existing treatment PRDs found"`
- **Project Status:** @CLAUDE.md#project-status
- **App Design:** @.taskmaster/docs/app-design-document.md
- **Tech Stack:** @.taskmaster/docs/tech-stack.md

## Goal

To transform raw treatment material (worksheets, protocols, therapeutic content) into a structured Protocol Requirements Document (PRD) that enables AI agents to deliver authentic, evidence-based virtual therapy sessions through TaskMaster orchestration.

## Process

1. **Read Treatment Source File:**
   - Accept file path to raw treatment content (e.g., `treatments/cognitiveDistortion.md`)
   - Analyze the therapeutic content structure and educational flow
   - Identify key treatment components: definitions, examples, exercises, techniques

2. **Treatment Analysis:**
   - Extract therapeutic learning objectives
   - Identify natural break points for session chunking
   - Preserve all original clinical content verbatim
   - Map therapeutic progression and dependencies

3. **Ask Clarifying Questions:**
   - Ask 3-4 targeted questions about treatment delivery:
     - **Therapeutic Role**: "What type of therapist persona should the AI adopt? (e.g., CBT therapist, supportive counselor, educational guide)"
     - **Session Structure**: "How should the content be chunked? By topic, by exercise, or by therapeutic technique?"
     - **User Interaction**: "What level of user engagement is expected? (reflection exercises, written responses, verbal discussion)"
     - **Clinical Boundaries**: "What therapeutic boundaries should the AI maintain? (no diagnosis, crisis intervention limits, etc.)"

4. **Generate Treatment PRD:**
   - Follow the cognitive distortion PRD structure as template
   - Include complete original therapeutic content in subtasks
   - Create sequential task progression through treatment material
   - Maintain clinical fidelity and evidence-based approach

5. **Save and Next Steps:**
   - Save as `prd-[treatment-name]-chunks.md` in `.taskmaster/docs/`
   - Suggest running Task Master parse command for task generation

## Treatment PRD Structure Requirements

The Treatment PRD must follow this exact structure:

### Header Format
```markdown
# [Treatment Name] Treatment - Protocol Requirements Document
```

### Project Context Section (Standard for All Treatment PRDs)
```markdown
## Project Context

**Project Status: Pre-MVP**

- Read this file: `.taskmaster/docs/app-design-document.md` - App design document
- Read this file: `.taskmaster/docs/tech-stack.md` - Tech stack, architecture
- DO NOT care about breaking changes. We didn't deploy yet.
- DO NOT care about unit testing, accessibility, visual testing (Storybook), and performance optimization unless asked.
- Care about therapeutic fidelity, role boundaries, session state persistence, and content accuracy. In general, follow patterns from existing cognitive therapy protocols.

**Current Stage Focus:**
- **Core Functionality**: AI-powered virtual therapy session delivery
- **Treatment Protocol Processing**: Breaking down protocols into manageable chunks
- **Session Flow Management**: TaskMaster orchestration to keep sessions on track
- **Basic Error Handling**: Graceful failures in CLI environment
- **AI Integration**: Claude-powered content breakdown and session guidance
```

### Treatment Protocol Overview Section
```markdown
## [Treatment Name] Virtual Therapy Protocol

This PRD defines the therapeutic protocol tasks for delivering the [treatment description] as an AI-orchestrated virtual therapy session. The protocol breaks the treatment into sequential therapeutic tasks, each containing complete original therapeutic content for AI delivery.

**Note**: All technical infrastructure (Claude Code MCP, TaskMaster AI, CLI interface, session management, etc.) is provided by the existing project setup. This PRD focuses solely on the therapeutic protocol content and session flow.
```

### Therapeutic Protocol Structure Section
```markdown
## Therapeutic Protocol Structure

**[Number] Primary Therapeutic Tasks** following the established TaskMaster pattern:
- Each task represents a complete therapeutic learning unit
- 4 subtasks per task containing full original content from the treatment
- Sequential progression through [treatment methodology] education and techniques
- Complete therapeutic material embedded for AI agent delivery

**Per-Task Structure:**
- Educational explanation (1-2 subtasks) - **MUST INCLUDE**: Complete original definitions, psychological context, and impact descriptions from source material
- Example scenarios and analogies - **MUST INCLUDE**: Specific real-world examples and therapeutic metaphors from original treatment
- User reflection exercise - **MUST INCLUDE**: Exact exercise instructions, guided questions, and completion criteria from source material
- User input capture and storage to `sessions/` directory (if applicable)

**CRITICAL REQUIREMENT**: Each subtask must contain the complete original therapeutic content from the source material, not abbreviated summaries. The AI agent must have access to the full body of evidence-based knowledge to maintain clinical fidelity.
```

### Therapeutic Role Specification Section
```markdown
## **Therapeutic Role Specification**

**Based on treatment methodology:**
- Calm, supportive CBT therapist persona
- Short explanations followed by guided questions
- No analysis or evaluation of user responses
- Stay focused on treatment content, avoid off-topic discussion
- Wait for user responses before proceeding
- Empathetic but structured approach
```

### Task Breakdown Pattern
Each therapeutic concept should become a TaskMaster task with 4 subtasks:
1. **Educational explanation** - Complete original theoretical content
2. **Examples and analogies** - All original case studies, metaphors, scenarios
3. **User reflection exercise** - Exact exercise instructions from source material
4. **Capture user input** - Optional storage for session continuity

### Content Preservation Requirements
- **CRITICAL**: Include complete original therapeutic content, not summaries
- Embed full text from source material in subtasks for AI agent access
- Preserve clinical accuracy and evidence-based language
- Maintain therapeutic progression and dependencies

## Clarifying Questions Framework

Adapt these questions based on the specific treatment provided:

- **Therapeutic Approach**: "What therapeutic modality does this treatment represent? (CBT, DBT, mindfulness, etc.)"
- **Target Population**: "Who is this treatment designed for? (depression, anxiety, general mental health, etc.)"
- **Session Goals**: "What should users accomplish by completing this protocol?"
- **AI Boundaries**: "What therapeutic limits should the AI maintain during delivery?"
- **Content Chunking**: "How should the material be divided into manageable therapeutic segments?"
- **Exercise Format**: "How should reflection exercises be presented and captured?"

## Output Specifications

- **Format:** Markdown (`.md`)
- **Location:** `.taskmaster/docs/`
- **Filename:** `prd-[treatment-name]-chunks.md`
- **Content:** Complete therapeutic protocol with embedded source material

## Usage Example

```
/create-treatment-prd treatments/cognitiveDistortion.md
```

This will:
1. Read the cognitive distortion treatment file
2. Ask clarifying questions about therapeutic delivery
3. Generate a structured PRD with complete therapeutic content
4. Save as `prd-cognitive-distortion-chunks.md`
5. Enable AI-orchestrated therapy session delivery via TaskMaster

## Final Instructions

1. **Preserve Clinical Content**: Never summarize or abbreviate therapeutic material
2. **Maintain Evidence Base**: Keep all original clinical language and concepts
3. **Structure for AI Delivery**: Organize content for conversational therapeutic flow
4. **Enable TaskMaster Integration**: Create parseable task structure for session orchestration
5. **Suggest Parse Command**: Recommend using Task Master to convert PRD into actionable tasks

The goal is to bridge the gap between static therapeutic worksheets and dynamic AI-delivered virtual therapy sessions while maintaining complete clinical fidelity.