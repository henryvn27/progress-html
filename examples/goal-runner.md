# Goal Runner Wiring Example

When `/goal` runs in a repo with `progress.html`, update the page beside the normal goal artifacts.

## Lifecycle Mapping

| Goal event | `progress.html` update |
| --- | --- |
| plan created | add or update `Plan` slice as `done` |
| loop starts | add or update `Loop pack: <name>` as `active` |
| loop evidence written | mark loop `verifying` or `done` |
| blocker found | mark slice `blocked` and name the blocker |
| `orca unify` runs | update `Readiness score` slice |
| handoff written | mark `Handoff` as `done` and link `.orca/handoffs/<goal>.md` |

## Prompt Addition

```text
Before each `/goal` status report, check whether `progress.html` exists. If it does, update the matching slice from `.orca/state.env`, `.orca/runs`, `.orca/loops`, and `.orca/handoffs`. Then mention the file path.
```

## Example Row

```text
Slice: Readiness score
State: done
Owner: goal-runner
Next action: Hand off or start the next bounded goal.
Verification: `.orca/state.env` has `readiness_score`, handoff path is present.
```

