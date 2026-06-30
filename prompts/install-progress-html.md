# Install Progress HTML Across Tool Repos

Use this prompt in Codex or Claude Code from the parent directory that contains the standalone tool repos.

```text
Install Progress HTML across every standalone tool repo in this workspace.

Goal:
- Every tool repo gets a root `progress.html` unless it already has one.
- Existing `progress.html` files are preserved and updated, not replaced.
- Moving forward, every tool repo includes instructions that agents must update `progress.html` at meaningful lifecycle checkpoints.
- Do not add hooks, watchers, daemons, package dependencies, generated assets, or wrapper commands.

Source:
- Use the Progress HTML repo as the source of truth.
- Prefer `templates/progress-ledger.html` for dense tool repos.
- Use `templates/progress-rail.html` only when the repo is mostly sequential workflow documentation.
- Use `templates/progress-board.html` only when the repo naturally has parallel chunks.
- Use `docs/agent-instructions.md` and `docs/integrations.md` for the installed rule.

Process:
1. Inspect git status in the parent workspace and in each tool repo before editing.
2. Skip repos with unrelated dirty work unless the dirty work is clearly the active Progress HTML install.
3. For each clean tool repo:
   - If `progress.html` is missing, copy the best template to `progress.html`.
   - Prefer `bin/progress-html init --template ledger|rail|board` when available so the generated file picks up the repo name, colors, and local logo/icon automatically.
   - Rewrite example content so it describes that repo's real current state.
   - Keep a clear `Do next` block near the top.
   - Keep the accessible progress bar.
   - Keep text state labels: queued, active, waiting, blocked, verifying, done.
   - Add or update a short agent instruction in the repo README or skill docs:
     `If progress.html exists, update it after meaningful lifecycle changes and before final response. Do not install hooks or watchers.`
4. For repos that already have `progress.html`:
   - Do not replace it.
   - Ensure it has current goal, Do next, progress bar, latest update, slice/chunk list, state labels, and verification evidence.
5. Update the manager/catalog repo documentation so future tool repos are expected to include root `progress.html` and the lifecycle update rule.
6. Run the smallest available verifier for each changed repo. If no verifier exists, at least run a file/syntax check that matches the repo.
7. Commit each repo separately with a scoped message.
8. Push branches and open PRs, or merge directly only if that repo's policy already uses direct merges.
9. Report:
   - repos updated
   - repos skipped and why
   - PR links or commits
   - verification commands and results
   - path to each installed `progress.html`

Install rule for future repos:
When creating or extracting a new standalone tool repo, create root `progress.html` during repo setup. It should show the current goal, Do next, progress bar, latest update, all slices/chunks, state labels, owner, next action, and verification evidence. Agents must update it directly at lifecycle checkpoints. No hooks, watchers, daemons, or wrappers.
```
