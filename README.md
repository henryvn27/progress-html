# Progress HTML

Static `progress.html` templates and agent instructions for showing all active work slices in a way users can inspect at any time.

Parent manager: https://github.com/henryvn27/orca-framework

## Philosophy

No hooks. No daemon. No complex event bus.

Agents update `progress.html` directly whenever they finish or change a meaningful slice: plan, build, QA, review, ship, blocker, or handoff. Periodically, the agent checks whether `progress.html` still matches the current plan and tells the user where to open it.

## Templates

- [Template A: Ledger](templates/progress-ledger.html), dense operational table with latest update first.
- [Template B: Rail](templates/progress-rail.html), vertical slice rail with clear current state.
- [Template C: Board](templates/progress-board.html), compact chunk board grouped by state.

All templates are static HTML with inline CSS and inline JavaScript. No external dependencies.

## Agent Rule

Use [docs/agent-instructions.md](docs/agent-instructions.md). The rule is simple: update `progress.html` when slice state changes, then offer the user the file path or link.

## Integrations

Use [docs/integrations.md](docs/integrations.md) when another tool sees an existing `progress.html`.

- `/goal` and goal runner: [examples/goal-runner.md](examples/goal-runner.md)
- generic tool wiring: [examples/tool-wiring.md](examples/tool-wiring.md)

## Verify

```sh
ruby scripts/verify.rb
```

## Research

See [docs/research.md](docs/research.md).
