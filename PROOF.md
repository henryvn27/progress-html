# Proof

This repo contains three complete static `progress.html` templates plus an instruction layer agents can install into projects.

## Verify

```sh
ruby scripts/verify.rb
```

The verifier checks that each template is standalone, includes slice/chunk status content, avoids external assets, and includes accessible non-color status labels.

`docs/integrations.md` and `examples/` show how existing tools wire to `progress.html` without hooks, watchers, or wrappers.

`prompts/install-progress-html.md` is the install prompt for applying this tool across standalone tool repos and future tool extraction work.
