---
name: create-pr
description: |
  Create a GitHub PR using the context from the current session. Write a concise
  PR body that explains main changes, highlights critical/supporting/skim-safe
  parts, links important file:line locations, and adds inline comments where useful.
argument-hint: "[title]"
triggers:
  - "create-pr"
  - "create pr"
  - "create PR"
  - "create pull request"
  - "make a pr"
  - "make PR"
  - "pr create"
---

# /create-pr

Create a PR after making changes. Assume you have session context for what
changed and why. Use git only to verify details and line numbers.

## What to do

1. Check branch/status and infer base branch. Ask if unclear.
2. Draft a PR title and body from session context.
3. Create the PR with `gh pr create`.
4. Add a few inline comments for important non-obvious changes.
5. Report the PR URL and inline comment count.

## PR Body

Keep it concise. Explain why, not just what.

```markdown
## Summary

[2-4 sentences: problem solved, approach taken, important rationale]

## Changes

### Critical — review carefully
- [`path/to/file.ext:42`](https://github.com/OWNER/REPO/pull/PR_NUMBER/files#diff-SHA256R42) — why this matters / tradeoff / edge case

### Supporting
- [`path/to/file.ext:88`](https://github.com/OWNER/REPO/pull/PR_NUMBER/files#diff-SHA256R88) — supporting change

### Safe to Skim
- `path/to/file.ext` — mechanical / formatting / trivial

## Notes

[Optional: alternatives considered, rollout notes, risk]
```

Rules:
- Link important locations to the GitHub PR diff view, not plain text.
- Use Markdown like [`path/to/file.ext:42`](https://github.com/OWNER/REPO/pull/PR_NUMBER/files#diff-SHA256R42).
- Don't list every file; GitHub already shows the file list.
- Omit empty sections.
- If the PR is trivial, keep it very short.

Diff link format:
```bash
FILE="path/to/file.ext"
LINE=42
HASH=$(printf '%s' "$FILE" | sha256sum | cut -d' ' -f1)
echo "${PR_URL}/files#diff-${HASH}R${LINE}"
```

Use `R${LINE}` for the right/new side of the diff. Use `L${LINE}` only when linking to a deleted/old-side line.

## Useful Commands

```bash
git status --short
git diff --stat origin/main...HEAD
git diff origin/main...HEAD
git log --oneline origin/main...HEAD
git show HEAD:path/to/file | nl -ba | sed -n '35,55p'
```

## Create PR

```bash
gh pr create --base "$BASE_BRANCH" --title "$TITLE" --body-file "$BODY_FILE"
```

If a PR already exists, update it instead:

```bash
gh pr edit "$PR_NUMBER" --title "$TITLE" --body-file "$BODY_FILE"
```

## Inline Comments

Post only comments that help reviewers understand non-obvious changes. Aim for
0-5 comments, not coverage.

Good inline comments explain:
- Why this approach was chosen
- Edge cases handled here
- Security/performance tradeoffs
- Workarounds or external constraints

```bash
HEAD_SHA=$(git rev-parse HEAD)

gh api "repos/${OWNER}/${REPO}/pulls/${PR_NUMBER}/comments" \
  -f commit_id="$HEAD_SHA" \
  -f path="path/to/file.ext" \
  -f line=42 \
  -f side="RIGHT" \
  -f body="Why this line/change matters."
```

Derive `OWNER`/`REPO` from `gh repo view --json owner,name` or the remote URL.

## Done

Tell the user:
- PR URL
- Inline comments added
- Any notable risk or follow-up
