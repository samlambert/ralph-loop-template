#!/bin/bash
set -euo pipefail

run_cmd() {
  echo "-> $*"
  "$@"
}

if [ -f "package.json" ] && command -v npm >/dev/null 2>&1; then
  npm_scripts="$(npm run -s 2>/dev/null || true)"

  run_npm_script() {
    local script="$1"
    if echo "$npm_scripts" | grep -qE "[[:space:]]+$script$"; then
      run_cmd npm run "$script"
    else
      echo "Skipping npm run $script (script not defined)"
    fi
  }

  run_npm_script lint
  run_npm_script typecheck
  run_npm_script test
fi

if [ -d "tests" ] || [ -f "pytest.ini" ] || [ -f "pyproject.toml" ]; then
  if command -v pytest >/dev/null 2>&1; then
    run_cmd pytest tests/ -v
  else
    echo "Skipping pytest (not installed)"
  fi
fi
