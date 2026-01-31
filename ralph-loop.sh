#!/bin/bash
# ralph-loop.sh - Run Ralph in a loop (AFK mode)
# Usage: ./ralph-loop.sh [max_iterations]

set -e

MAX=${1:-10}

PROMPT="@AGENTS.md @RALPH_TASK.md

Read RALPH_TASK.md. Find the first unchecked [ ] task.
Implement it. Run tests if they exist.
If pass: mark [x], commit with 'ralph: description'.
Output <ralph>COMPLETE</ralph> if all done, else <ralph>CONTINUE</ralph>.
"

for ((i=1; i<=MAX; i++)); do
    echo "=== Ralph iteration $i of $MAX ==="
    
    result=$(claude -p "$PROMPT")
    echo "$result"
    
    if [[ "$result" == *"<ralph>COMPLETE</ralph>"* ]]; then
        echo "All tasks complete!"
        exit 0
    fi
done

echo "Reached max iterations ($MAX)"
