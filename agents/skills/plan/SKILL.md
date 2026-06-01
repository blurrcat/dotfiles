---
name: plan
description: |
  Plan before coding. Understand the user's request, ask clarifying questions,
  write a plan file in the current folder, and wait for explicit approval before
  implementing.
argument-hint: "[plan-name-or-topic]"
triggers:
  - "/plan"
  - "plan"
  - "make a plan"
---

# /plan

Do **not** code yet.

Use this skill to confirm understanding with the user before implementation.

## Rules

- Do not edit application code, implement features, run formatters, or commit.
- You may inspect the repo and ask clarifying questions.
- Write or update a plan file in the current folder.
- Only start building when the user explicitly says so: "go", "build it" etc.

## Workflow

1. Understand the request and relevant context.
2. Ask clarifying questions if the goal, constraints, or scope are unclear.
3. Infer a plan filename if not given:
   - `PLAN.md` for generic plans
   - `<topic>-plan.md` for named work, using kebab-case
4. Write the initial plan.
5. Stop and ask the user to review.

## Plan Shape

```markdown
# [Plan Title]

## Goal

## Current Understanding

## Open Questions

## Proposed Approach

## Files Likely to Change

## Risks / Tradeoffs

## Verification

## Out of Scope
```

Keep it concise and concrete. The point is to align with the user before coding,
not to prove general engineering knowledge.

## After User Feedback

Update the plan and summarize what changed. Continue iterating until the user
explicitly approves implementation.
