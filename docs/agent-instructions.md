# Progress HTML Agent Instructions

Use this when a repo has a `progress.html` file or when the user asks for visible progress across slices, chunks, phases, specs, or goals.

## Detection

At the start of meaningful work, check whether `progress.html` exists in the repo root. If it exists, wire your normal work checkpoints into it. If it does not exist, do not create one unless the user asked for visible progress.

## Rule

Keep `progress.html` current. No hook system is required.

Update the file directly when:

- A plan, slice, chunk, phase, or milestone is created.
- A slice changes state: queued, active, waiting, blocked, verifying, done.
- You finish a meaningful batch of work.
- You discover a blocker or resolve one.
- You change the scope, order, owner, or verification path.
- You are about to hand off, pause, or finish.

## Periodic Check

During longer work, check `progress.html` against the current plan at natural pauses:

- after planning
- after implementation batches
- after verification
- before final response

If it is stale, update it before reporting progress.

## User Visibility

When helpful, mention the file path in user-facing updates:

```text
I updated progress.html with the current slice status.
```

If the environment can open local files, offer to open it. If not, provide the path.

## Content Contract

Every `progress.html` should show:

- current goal
- latest update first
- all slices or chunks
- each slice state in text, not color only
- owner or actor when useful
- blocker or wait reason when present
- verification evidence or next verification step
- last-updated timestamp

## Editing Guidance

- Prefer changing text and rows over redesigning the page.
- Keep visual style quiet and functional.
- Do not add framework dependencies, generated assets, external fonts, or analytics.
- Do not hide skipped or blocked work. Mark it clearly.
- Do not mark a slice done without evidence or a clear verification note.

## Tool Integrations

See [integrations.md](integrations.md) for `/goal`, orchestration, background mode, GitHub flow, QA, Notion, and learning-sidecar recipes.
