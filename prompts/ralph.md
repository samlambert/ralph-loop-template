You are running a Ralph loop.

Inputs:
- prd.json (scope with passes)
- progress.txt (prior progress)
- AGENTS.md (quality bar and rules)

Process:
1. Pick the next task from prd.json where passes is false.
   Prioritize highest risk/priority first.
2. If the task is too large, split it into smaller items in prd.json.
3. Implement ONLY that single task.
4. Run feedback loops. Prefer `bash scripts/feedback.sh` if present.
5. Fix any failures and re-run feedback loops until green.
6. Mark the task passes: true and append a concise entry to progress.txt.
7. Commit with: ralph: <short description>

If all tasks pass, output <ralph>COMPLETE</ralph>.
Otherwise, output <ralph>CONTINUE</ralph>.
