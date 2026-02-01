#!/bin/bash
# ralph-loop.sh - Run Ralph in a loop (AFK mode)
# Usage: ./ralph-loop.sh [max_iterations]

set -e

MAX=${1:-10}

DEFAULT_PROMPT="@AGENTS.md @prd.json @progress.txt @prompts/ralph.md"
PROMPT=${RALPH_PROMPT:-$DEFAULT_PROMPT}
DEFAULT_MODEL=${RALPH_MODEL:-gpt-5.2-codex}
RUNNER=${RALPH_RUNNER:-dockersandbox}
RUNNER_ARGS=${RALPH_RUNNER_ARGS:-"run agent --force --model ${DEFAULT_MODEL}"}

if ! command -v "$RUNNER" >/dev/null 2>&1; then
    echo "Runner not found: $RUNNER" >&2
    exit 1
fi

run_ralph() {
    "$RUNNER" $RUNNER_ARGS -p "$PROMPT"
}

for ((i=1; i<=MAX; i++)); do
    echo "=== Ralph iteration $i of $MAX ==="
    
    result=$(run_ralph)
    echo "$result"
    
    if [[ "$result" == *"<ralph>COMPLETE</ralph>"* ]]; then
        echo "All tasks complete!"
        exit 0
    fi
done

echo "Reached max iterations ($MAX)"
