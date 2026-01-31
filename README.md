# Ralph Loop Template

Minimal template for autonomous AI coding loops.

## Files

- `AGENTS.md` - Instructions the AI reads each iteration
- `RALPH_TASK.md` - Your task checklist (edit this!)
- `ralph-once.sh` - Run one iteration (watch it work)
- `ralph-loop.sh` - Run multiple iterations (set and forget)

## Usage

1. Edit `RALPH_TASK.md` with your tasks
2. Run `./ralph-once.sh` to watch one iteration
3. Once confident, run `./ralph-loop.sh 10` for 10 iterations

## How It Works

Each iteration:
1. AI reads the task file
2. Picks first unchecked `[ ]` task
3. Implements it
4. Runs tests
5. Marks `[x]` and commits
6. Outputs `<ralph>COMPLETE</ralph>` or `<ralph>CONTINUE</ralph>`

Based on [Ralph Wiggum](https://ghuntley.com/ralph/) by @ghuntley.
