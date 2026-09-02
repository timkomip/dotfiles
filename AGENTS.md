# timko's dotfiles

Personal dotfiles plus `dotty`, a small shell tool that installs packages,
clones vendor plugins, and symlinks config into `$HOME`. Everything is
plain POSIX/zsh shell — no build step, no external deps beyond what
`dotty packages` installs.

Read @README.md before making changes.

## Layout

- `bin/` — executable commands on `PATH` (`dotty`, `newalias`)
- `lib/` — shell libraries sourced by `bin/dotty`
- `config/` — everything that gets symlinked or read as config
  - `config/zsh/` — zshrc and the modules it sources (aliases, functions, paths, fzf)
  - `config/git/`, `config/tmux/`, `config/zellij/`, `config/vscode/` — per-tool config
  - `config/links.conf` — `<source> <destination>` symlink table
  - `config/packages.conf` — `<manager> <package> [flags]` package table
  - `config/custom-installs.zsh` — installs for tools no package manager covers
- `docs/` — cheatsheets and notes
- `vendor/` — cloned third-party shell plugins; never edit by hand

New config file? Add it under `config/`, register it in `config/links.conf`,
and document it in README.md.

## Rules

- Update README.md whenever behavior, structure, or config format changes.
  The "Repository Structure" tree and the relevant section both need to match.
- Update doc blocks on functions when changing them.
- Alert me if a change would commit secrets — keys, tokens, passwords,
  private hostnames. Nothing sensitive belongs in this repo; machine-local
  values go in `~/.zshrc.local` (gitignored, never committed).
- Alert me if a change looks client- or project-specific. This repo is
  public and generic: no client names, employer names, internal URLs, or
  work-project details. Suggest `~/.zshrc.local` instead.
- Keep shell portable across macOS and Debian/Ubuntu; guard OS-specific
  bits with a platform check.
