# Architecture decisions (MADR)

We use [MADR minimal](https://github.com/adr/madr/blob/develop/template/adr-template-minimal.md) in `docs/decisions/`.

## Sections

1. Context and Problem Statement  
2. Considered Options  
3. Decision Outcome  
4. Consequences (Good / Bad under outcome)

Copy `docs/decisions/adr-template-minimal.md` for new records. Use the next free four-digit id (see index in `docs/decisions/README.md`).

## Granularity

- **Not** every tiny edit—no ADR for typos or format-only commits.
- **Yes** when a **git commit** is decision-worthy (someone would ask “why?”).
- Add the ADR with the change, **after commit**, or **retroactively** from `git log` / `git show` when backfilling.

## Format

Format ADR markdown with the same headless Neovim pass as other docs.
