# Progress HTML

Use this skill when the user wants a visible `progress.html` tracker, or when a repo already contains one.

## Behavior

1. Locate `progress.html`.
2. If it does not exist, create it with `bin/progress-html init --template ledger|rail|board` when available, otherwise copy one of the templates in `templates/` only when the user asked for visible progress.
3. Update it whenever slice or chunk state changes.
4. Periodically compare it to the current plan.
5. Before final response, make sure the file is current.
6. Mention the path or offer to open it when useful.
7. Keep timestamps current for changed slices or chunks.

## State Language

Use short text labels:

- queued
- active
- waiting
- blocked
- verifying
- done

Do not rely on color only.

## Template Choice

- Use `progress-ledger.html` for dense repo, release, or migration work.
- Use `progress-rail.html` for sequential plan/spec work.
- Use `progress-board.html` for parallel chunks with several active states.

## Constraints

- No hooks.
- No daemons.
- No generated assets.
- No external web dependencies.
- No redesign during routine updates.

## Integration Rule

When another tool is running and `progress.html` exists, update the existing page at that tool's natural lifecycle checkpoints. Examples live in `docs/integrations.md` and `examples/`.
