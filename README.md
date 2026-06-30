# Progress HTML

Static `progress.html` ledger template and agent instructions for showing all active work slices in a way users can inspect at any time.

Parent manager: https://github.com/henryvn27/orca-framework

## Philosophy

No hooks. No daemon. No complex event bus.

Agents update `progress.html` directly whenever they finish or change a meaningful slice: plan, build, QA, review, ship, blocker, or handoff. Periodically, the agent checks whether `progress.html` still matches the current plan and tells the user where to open it.

## Template

- [Ledger](templates/progress-ledger.html), a dense operational table with latest update first and clear color-coded state rows.

The template is static HTML with inline CSS and inline JavaScript. No external dependencies.

When created with `bin/progress-html init`, the generated file is automatically personalized from the target repo's project name, existing color tokens, and the first local logo/icon asset it can find.

## Agent Rule

Use [docs/agent-instructions.md](docs/agent-instructions.md). The rule is simple: update `progress.html` when slice state changes, then offer the user the file path or link.

## Integrations

Use [docs/integrations.md](docs/integrations.md) when another tool sees an existing `progress.html`.

- `/goal` and goal runner: [examples/goal-runner.md](examples/goal-runner.md)
- generic tool wiring: [examples/tool-wiring.md](examples/tool-wiring.md)

## Install Prompt

Use [prompts/install-progress-html.md](prompts/install-progress-html.md) to ask Codex or Claude Code to install root `progress.html` files across every standalone tool repo and keep that rule for future tool repos.

## Verify

```sh
ruby scripts/verify.rb
```

## Research

See [docs/research.md](docs/research.md).
