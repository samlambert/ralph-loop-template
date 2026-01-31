# AGENTS.md

## Ralph Loop Instructions

You are running in a Ralph Loop - an autonomous coding loop.

### Each iteration:
1. Read `RALPH_TASK.md` and find the first unchecked `[ ]` task
2. Implement that single task
3. Run tests: `pytest tests/ -v` (if tests exist)
4. If tests pass: mark the task `[x]` in RALPH_TASK.md
5. Commit: `git add -A && git commit -m "ralph: <description>"`
6. If ALL tasks are complete, output `<ralph>COMPLETE</ralph>`
7. Otherwise, output `<ralph>CONTINUE</ralph>`

### Rules:
- Only work on ONE task per iteration
- Always run feedback loops (tests/lint) before committing
- Never commit if tests fail - fix first
- Keep changes small and focused
