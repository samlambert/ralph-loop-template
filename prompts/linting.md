Goal: eliminate lint errors.

Process:
1. Run the lint command (prefer ./scripts/feedback.sh if it runs lint).
2. Fix ONE lint error or warning.
3. Re-run lint to verify it is resolved.
4. Append a short entry to progress.txt and commit.

If no lint errors remain, output <ralph>COMPLETE</ralph>.
Otherwise, output <ralph>CONTINUE</ralph>.
