#!/bin/bash
# ralph-once.sh - Run one Ralph iteration (HITL mode)
# Usage: ./ralph-once.sh

set -e

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

echo "Running single Ralph iteration..."
run_ralph
