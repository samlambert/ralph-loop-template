# AGENTS.md

## Repo Quality Bar
- Production-quality, maintainable, testable code.
- Prefer clarity over cleverness; avoid hacks.
- Add/update docs or tests when behavior changes.

## Ralph Loop Inputs
- `prd.json`: structured scope items (category, description, steps, risk, passes).
- `progress.txt`: append-only progress log each iteration.
- `scripts/feedback.sh`: run feedback loops before commit.

## Each Iteration
1. Read `prd.json` and pick the highest-risk/priority item with `passes: false`.
2. If the item is too large, split it into smaller items in `prd.json`.
3. Implement ONLY that single item.
4. Run feedback loops (prefer `bash scripts/feedback.sh` if present).
5. If loops pass, set that item's `passes` to `true` and append to `progress.txt`.
6. Commit with `ralph: <short description>`.
7. If all items pass, output `<ralph>COMPLETE</ralph>`, else `<ralph>CONTINUE</ralph>`.

## Rules
- One logical change per commit; keep changes small and focused.
- Do not mark `passes: true` unless all verification steps succeed.
- Never commit if feedback loops fail; fix first.
- If blocked, document the blocker in `progress.txt` and stop.
