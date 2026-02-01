# Ralph Loop Template

Minimal template for autonomous AI coding loops with best practices baked in.

## Files

- `AGENTS.md` - quality bar and loop rules
- `prd.json` - scope/requirements with `passes` tracking
- `progress.txt` - append-only progress log per iteration
- `prompts/ralph.md` - canonical Ralph prompt
- `prompts/*.md` - optional loop variants (linting/coverage/entropy)
- `scripts/feedback.sh` - feedback loop runner (lint/tests/types)
- `ralph-once.sh` - run one iteration (sandboxed Cursor CLI by default)
- `ralph-loop.sh` - run multiple iterations (AFK, sandboxed Cursor CLI by default)

## Requirements

- Cursor CLI installed (`agent --version`)
- Docker Sandbox installed for AFK (`dockersandbox`)
- Cursor CLI permissions configured if you restrict commands

## Quick Start (Cursor CLI + Sandbox)

1. Edit `prd.json` with small, risk-first tasks.
2. Customize `scripts/feedback.sh` for your repo and ensure it's runnable.
3. Run `./ralph-once.sh` to watch one iteration (sandboxed).
4. Once confident, run `./ralph-loop.sh 10` for 10 iterations (sandboxed).

The scripts default to:

`dockersandbox run agent --force --model gpt-5.2-codex -p "<prompt>"`

## LLM Instructions (PRD + Ralph Setup)

You are an LLM asked to create a PRD and set up this repo for a Ralph loop.
Use the following asks and context to guide your work:

1. **Clarify the end state and constraints.**  
   Context: Ralph is autonomous; unclear goals cause infinite loops or low quality.
   Define what "done" means, what must not change, and any constraints.

2. **Produce a structured `prd.json`.**  
   Context: The PRD is the single source of truth and the task picker.
   Each item must include: `category`, `description`, `steps`, `risk`,
   `priority`, and `passes: false`. Keep tasks small and testable.

3. **Make tasks risk-first and split large work.**  
   Context: Risky integration or architecture should be solved early,
   while the context window is fresh and failures are cheaper.
   If a task is too large, break it into smaller PRD items.

4. **Set up feedback loops.**  
   Context: The loop should not commit bad code.
   Ensure `scripts/feedback.sh` runs the repo's lint/test/type checks.
   Do not allow commits if any feedback loop fails.

5. **Set up progress tracking.**  
   Context: Each loop run starts fresh, so `progress.txt` prevents rework.
   Append concise entries per iteration: item completed, decisions, files changed,
   and blockers.

6. **Confirm sandboxed, non-interactive execution.**  
   Context: AFK loops need safety and no human approvals.
   Use `dockersandbox run agent --force --model gpt-5.2-codex`.
   Only opt out of sandbox if explicitly requested.

7. **Keep commits small and consistent.**  
   Context: Tight feedback loops reduce regressions and simplify rollback.
   One logical change per commit; avoid unrelated edits.

8. **Stop only when all PRD items pass.**  
   Context: The stop condition must be explicit to avoid premature completion.
   Only output `<ralph>COMPLETE</ralph>` when all `passes` are true.

### What Makes a Good Ralph Loop PRD

- **Atomic tasks**: Each item is small enough to finish in one iteration.
- **Testable steps**: Verification steps are clear and runnable.
- **Risk-aware ordering**: High risk/priority items come first.
- **Explicit scope**: Edge cases and exclusions are spelled out.
- **Binary completion**: `passes` is only true when steps succeed.

### Good Workflow / Setup Principles

- **Single source of truth**: `prd.json` defines the work; `progress.txt` logs it.
- **Feedback loops first**: Tests/lint/typecheck gate every commit.
- **Sandbox for AFK**: Avoids destructive actions outside the repo.
- **Small steps**: Prefer several small commits over one large change.
- **Quality bar enforced**: Maintainable, production-ready code.

## Model Selection

Default model is `gpt-5.2-codex` (Codex high). Override via:

`RALPH_MODEL=gpt-5.2-codex ./ralph-loop.sh 10`

List available models with `agent models`.

## Running Without Sandbox (optional)

If you want to skip the sandbox, run locally:

`RALPH_RUNNER=agent RALPH_RUNNER_ARGS="--force --model gpt-5.2-codex" ./ralph-loop.sh 10`

## Sandbox Notes

- Ensure Cursor CLI is installed inside your sandbox image.
- Use `--force` to avoid interactive approvals; rely on CLI permissions to deny risky commands.

## Customization

- Swap prompts: `RALPH_PROMPT="@AGENTS.md @progress.txt @prompts/linting.md" ./ralph-loop.sh 10`
- Adjust feedback loops in `scripts/feedback.sh` to match your repo

## How It Works

Each iteration:
1. Reads `prd.json` and picks the highest-risk incomplete item
2. Implements ONLY that item
3. Runs `scripts/feedback.sh` (or equivalent checks)
4. Marks `passes: true`, appends to `progress.txt`, and commits
5. Outputs `<ralph>COMPLETE</ralph>` or `<ralph>CONTINUE</ralph>`

## Cleanup

Delete `progress.txt` once the sprint is done.

Based on [Ralph Wiggum](https://ghuntley.com/ralph/) by @ghuntley.
