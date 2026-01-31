#!/bin/bash
# ralph-once.sh - Run one Ralph iteration (HITL mode)
# Usage: ./ralph-once.sh

set -e

PROMPT="@AGENTS.md @RALPH_TASK.md

Read RALPH_TASK.md. Find the first unchecked [ ] task.
Implement it. Run tests if they exist.
If pass: mark [x], commit with 'ralph: description'.
Output <ralph>COMPLETE</ralph> if all done, else <ralph>CONTINUE</ralph>.
"

echo "Running single Ralph iteration..."
claude -p "$PROMPT"
