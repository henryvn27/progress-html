# Tool Wiring Examples

These are copy-paste additions for other tools.

## Generic Tool

```text
If the target repo has `progress.html`, update it after this tool changes a meaningful state. Use one slice per durable tool outcome. Include state, next action, and verification evidence.
```

## GitHub Flow

```text
If `progress.html` exists, update it when branch, PR, CI, review, or merge state changes. Verification should include PR URL, check name, commit hash, or merge result.
```

## QA

```text
If `progress.html` exists, update it after each QA checkpoint. Verification should include the command, screenshot, log, or report path. Mark failures as blocked or verifying, not done.
```

## Notion

```text
If `progress.html` exists, update tracker-sync state when a Notion payload is queued, synced, or blocked. Verification should include the payload path or Notion page URL.
```

## Learning

```text
If `progress.html` exists, use the active slice and blocker fields to choose what to teach. Do not store learner preferences in `progress.html`; update the learner profile instead.
```

