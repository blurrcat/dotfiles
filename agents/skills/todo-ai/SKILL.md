---
name: todo-ai
description: complete tasks defined by [TODO @AI] in code.
---
- look for `[TODO @AI]` in current directory
- treat each one as a task and complete them
- if you have question about a task, ask user for clarify. Don't ignore it or silently make assumptions.
- after completing all, summarize what's been done using numbered list. Order them by importance. For example, a naming change is less important than a functionality change.
