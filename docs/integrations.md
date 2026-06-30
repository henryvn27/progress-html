# Integration Recipes

Use these recipes when a project already has `progress.html`. They are instructions for agents and tools, not hooks.

## Detection Rule

At the start of a meaningful run:

1. Look for `progress.html` in the repo root.
2. If missing, do nothing unless the user asks for visible progress.
3. If present, treat it as the user-visible status surface.
4. Update it at normal lifecycle checkpoints.
5. Mention the path in user-facing status notes when useful.

Do not start a watcher, daemon, commit hook, or background process.

## Goal Runner

Good fit: `/goal`, bounded goal loops, plan-only runs, auto cycles, readiness scoring, and handoff.

Known goal-runner artifacts:

- `.orca/state.env`
- `.orca/runs/<goal>-plan.md`
- `.orca/loops/<goal>/<loop>.pass`
- `.orca/handoffs/<goal>.md`
- `.orca/notion/outbox/*.json`

Update `progress.html` at these points:

- after goal contract or plan is created
- after each loop pack step is attempted
- after `orca unify`
- after readiness score changes
- when a blocker is proven
- when the handoff file is written

Timing:

- when a slice starts, add `data-estimate-min`
- when a slice finishes, add `data-actual-min`
- keep the original estimate so the learning log can compare estimate vs actual

Suggested slice names:

- Goal contract
- Plan
- Loop pack: `<loop-name>`
- Readiness score
- Handoff
- Tracker sync

Suggested row text:

```text
Slice: Loop pack: docs-sync
State: verifying
Owner: goal-runner
Next action: Run the docs-sync check and record evidence.
Verification: .orca/loops/<goal>/docs-sync.pass
```

## Agent Orchestration

Good fit: planner, builder, reviewer, QA, coordinator, and background workers.

Use `progress.html` as the shared user-facing surface. Keep deeper coordination in the normal shared-state files.

Update `progress.html` when:

- a worker accepts a slice
- a worker finishes or blocks
- ownership changes
- the coordinator changes phase
- a resume note is written

When a worker accepts a slice, record its estimate. When it finishes, record the actual duration. The page uses those pairs to improve future remaining-time estimates.

Suggested slice names:

- Planner: scope
- Builder: implementation
- Reviewer: findings
- QA: regression pass
- Coordinator: handoff

## Background Mode

Good fit: unattended but bounded progress.

Update `progress.html` once per iteration and at stop:

- iteration started
- artifact produced
- blocker found
- stop condition reached
- final receipt written

Use one row/card per iteration when the run is short. For longer runs, keep one active row and add the receipt path to verification.

## GitHub Flow Manager

Good fit: branches, PRs, review comments, CI, merge readiness.

Update `progress.html` when:

- branch is created
- PR is opened
- CI starts or fails
- review comments are addressed
- PR is merged

Suggested slice names:

- Branch
- PR
- CI
- Review feedback
- Merge

## QA Review Kit

Good fit: smoke checks, regression checks, UI inspection, screenshots.

Update `progress.html` when:

- QA scope is defined
- a check passes
- a check fails
- screenshots or logs are captured
- QA signs off or blocks

Verification should point to the exact screenshot, log, command, or report.

## Notion Bridge

Good fit: issue status, outbox payloads, tracker handoffs.

Update `progress.html` when:

- Notion payload is queued
- outbox sync succeeds
- sync fails
- tracker status changes

Verification should point to `.orca/notion/outbox`, `.orca/notion/synced`, or the live Notion page when available.

## Learning Sidecar

Good fit: teaching the user what the worker is doing.

Use `progress.html` as teaching context:

- explain the active slice
- avoid re-explaining done slices unless the user asks
- use blockers and verification fields to decide explanation depth
- record user feedback in the learner profile, not in `progress.html`

## Minimal Prompt Snippet

Add this to another tool's instructions:

```text
If `progress.html` exists in the target repo, update it at each lifecycle checkpoint. Keep it user-visible: current slice, state, next action, blocker if any, time estimate, actual duration when done, and verification evidence. Do not install hooks or start a watcher.
```

For bulk installation across tool repos, use [../prompts/install-progress-html.md](../prompts/install-progress-html.md).
