Goal: reduce software entropy.

Process:
1. Scan for code smells (unused exports, dead code, duplication).
2. Fix ONE issue.
3. Run feedback loops to verify no regressions.
4. Append a short entry to progress.txt and commit.

If no issues remain, output <ralph>COMPLETE</ralph>.
Otherwise, output <ralph>CONTINUE</ralph>.
