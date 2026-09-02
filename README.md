# timko's dotfiles

A dotfiles management system with automated setup and configuration.

## What This Repo Does

This repository contains my personal dotfiles and a management tool (`dotty`) that automates:
- Installing Oh My Zsh
- Installing required packages (Homebrew on macOS, apt/snap on Ubuntu)
- Cloning vendor shell integrations
- Creating symlinks for configuration files
- Loading zsh configuration files in a structured way

> **Note:** Package installation is driven by `config/packages.conf` and is OS-aware. On macOS it uses Homebrew; on Debian/Ubuntu it uses `apt` and `snap` (see `dotty packages`). Other platforms skip package installation with a warning.

## Quick Start

1. Clone this repository:
```sh
git clone <repo-url> ~/dotfiles
```

2. Run the initialization command:
```sh
~/dotfiles/bin/dotty init
```

This will:
- Install packages (including `yq` and `git`) from `config/packages.conf`:
  - **macOS:** install Homebrew if needed, then the `mac_brew` packages
  - **Ubuntu/Debian:** install the `apt` and `snap` packages
- Install Oh My Zsh (if not already installed; requires `git`, which is installed in the step above)
- Clone vendor dependencies into `vendor/`
- Create symlinks from `config/links.conf` (including `config/zsh/zshrc` to `~/.zshrc`)

3. Reload your shell:
```sh
source ~/.zshrc
```

## Using dotty

The `dotty` command provides several subcommands:

### `dotty init`
Initialize everything: install packages, install Oh My Zsh, clone vendor dependencies, and create symlinks. Packages are installed before Oh My Zsh so that `git` is available for the Oh My Zsh installer.

### `dotty packages`
Install everything declared in `config/packages.conf` (plus the extra installs in `config/custom-installs.zsh`). Each line in `packages.conf` is `<manager> <package>`; the manager token decides where it runs:
- **`mac_brew`** packages install via Homebrew, macOS only.
- **`apt`** and **`snap`** packages install wherever that command is available (Debian/Ubuntu).

After the package managers run, `config/custom-installs.zsh` handles tools that aren't in a package manager:
- `mise` — installed via its official installer on Linux (macOS gets it from Homebrew).
- `zoxide` — installed via its official installer on Linux (macOS gets it from Homebrew).
- the `bat -> batcat` shim — on Debian/Ubuntu `bat` installs its binary as `batcat`, so a `bat -> batcat` symlink is created in `~/.local/bin` to match macOS.

On Linux, `/snap/bin` and `~/.local/bin` are added to `PATH` so freshly installed tools (like `mise`, the `bat` shim, and `yq`) are found within the same `dotty` run.

### `dotty brew`
Install Homebrew (if needed) and install the `mac_brew` packages from `config/packages.conf`.  
**Note:** This command only works on macOS. On other platforms it warns and skips. Use `dotty packages` for an OS-aware install.

### `dotty links`
Create symlinks from `config/links.conf`. This command:
- Parses the plain-text config with shell built-ins (no `yq` or other dependency)
- Creates symlinks if they don't already exist
- Skips existing symlinks that point to the correct location
- Backs up anything else in the way to `~/.dotfiles-backup/<timestamp>/`

Pass `--dry-run` (or `-n`) to preview what would happen without changing anything:
```sh
dotty links --dry-run
```

### `dotty help`
Show help message with available commands.

## Repository Structure

```
dotfiles/
├── bin/
│   ├── dotty              # Main dotfiles management command
│   └── newalias           # Quickly add aliases to aliases.sh
├── config/
│   ├── packages.conf      # Package list (<manager> <package>, OS-aware)
│   ├── custom-installs.zsh # Installs for tools not in a package manager
│   ├── links.conf         # Symlink definitions (plain two-column file)
│   ├── git/
│   │   └── gitignore_global
│   ├── ideavimrc          # IntelliJ IDEA Vim configuration
│   ├── teleport.yaml      # Directory shortcuts for teleport function
│   ├── tmux/
│   │   └── tmux.conf
│   ├── zellij/
│   │   └── config.kdl
│   ├── vscode/
│   │   ├── keybindings.json
│   │   └── settings.json
│   └── zsh/               # Zsh configuration files
│       ├── zshrc          # Main zshrc (symlinked to ~/.zshrc)
│       ├── ohmyzsh.zsh    # Oh My Zsh theme and plugins
│       ├── aliases.sh     # Shell aliases
│       ├── functions.sh   # Custom shell functions
│       ├── fzf.sh         # FZF configuration (also loads fzf-git plugin)
│       ├── zsh-autosuggestions.zsh
│       └── paths.sh       # PATH modifications
└── docs/
    ├── cheatsheet.md      # Main quick reference
    ├── cheatsheets/
    │   └── zellij.md
    └── vscode.md          # VSCode notes
```

## Configuration Files

### Zsh Configuration

`config/zsh/zshrc` is symlinked to `~/.zshrc` and sources the following modules:
1. `ohmyzsh.zsh` - Oh My Zsh theme and plugins (loaded before oh-my-zsh.sh)
2. `paths.sh` - PATH modifications
3. `fzf.sh` - FZF environment variables and options (also loads fzf-git plugin)
4. `functions.sh` - Custom shell functions
5. `aliases.sh` - Shell aliases
6. `zsh-autosuggestions.zsh` - Zsh autosuggestions integration

It also:
- Loads Homebrew into PATH on Apple Silicon Macs
- Sets `EDITOR=nvim`
- Sources `~/.fzf.zsh` when present
- Activates `mise` when available
- Activates `zoxide` when available
- Shows a `NORMAL` right-prompt indicator in vi mode
- Prepends the hostname to the prompt when connected over SSH

Machine-specific configuration (paths, aliases, SDK setups) goes in `~/.zshrc.local`, which is sourced at the end of zshrc if it exists. This file should not be committed to the repo.

### Packages

Packages are defined in `config/packages.conf`, a plain file with the format
`<manager> <package> [flags...]`. Blank lines and lines starting with `#` are
ignored. The manager token in the first column controls where each package
installs:

```
# <manager>  <package>   [flags...]
mac_brew      neovim                 # brew, macOS only
apt           git                    # apt, wherever apt-get exists
snap          nvim         --classic # snap install nvim --classic
```

- A `mac_` / `linux_` prefix scopes the line to that OS (e.g. `mac_brew` makes
  the macOS-only intent explicit, since Homebrew can also exist on Linux).
- A bare token (`apt`, `snap`) runs wherever that manager's command is
  available, regardless of OS.
- Anything after the package name is passed straight through to the install
  command, so flags like `snap`'s `--classic` (needed for `nvim`) or `brew`'s
  `--HEAD` just work.

Like `links.conf`, this file is parsed with shell built-ins, so `dotty
packages` needs no external tools. Tools that aren't in a package manager
(currently `mise`, `zoxide`, and the `bat -> batcat` shim) live in
`config/custom-installs.zsh`, which `dotty` sources and runs on every OS — each
install function there does its own platform check.

### Symlinks

Symlinks are defined in `config/links.conf`, a plain two-column file
(`<source> <destination>`). The source is relative to the repo root; a
leading `~` in the destination expands to `$HOME`. Blank lines and lines
starting with `#` are ignored.

```
# <source>                    <destination>
config/ideavimrc              ~/.ideavimrc
config/git/gitignore_global   ~/.gitignore
config/teleport.yaml          ~/.teleport.yaml
config/zsh/zshrc              ~/.zshrc
config/tmux/tmux.conf         ~/.tmux.conf
config/zellij/config.kdl      ~/.config/zellij/config.kdl
```

Columns are split on whitespace, so the alignment is cosmetic — one space
works just as well. This format is parsed with shell built-ins, so `dotty
links` needs no external tools (it no longer depends on `yq`).

Run `dotty links` to create all symlinks, or `dotty links --dry-run` to
preview them first.

> **Note:**  
> This command only *creates* links as defined in `config/links.conf`.  
> It does **not** remove previously created links.  
> In the future, a lock file might be added to handle link removal.


## Custom Functions

### teleport

Navigate to directories from anywhere using shortcuts defined in `~/.teleport.json` or `~/.teleport.yaml`.

**YAML version** (requires `yq`):
```sh
yaml_teleport code  # Navigate to ~/code
yaml_teleport tmp   # Navigate to ~/tmp
```

**JSON version** (requires `jq`):
```sh
json_teleport code
```

Configuration example (`~/.teleport.yaml`):
```yaml
places:
  code: /Users/timko/code
  tmp: /Users/timko/tmp
```

### newalias

Quickly add a new alias to `aliases.sh` without opening the file:
```sh
newalias gs "git status"
# Appends: alias gs="git status"
```

Checks for duplicates and reminds you to reload your shell.

### Other Functions

- `cheatsheet` - View the cheatsheet (aliased as `chtsht`)
- `gcol` - Git checkout local branch (interactive with fzf)
- `gcoi` - Git checkout interactive (includes remotes)
- `edit-project` - Open a project from `~/code` with `$EDITOR`
- `mkfile` - Create a directory and file in one command
- `caplog` - Run a command with color, mirroring output to `./dev.log` in the current dir (e.g. `caplog bun dev`)
- `wt` - Jump to a git worktree of the current repo with fzf, showing branch, short sha, and path (e.g. `wt fix` cds straight in when only one matches)

## ZSH Plugins

### fzf-git.sh

Git integration for fzf. Install with:
```sh
~/dotfiles/bin/dotty init
```

This clones `fzf-git.sh` into `~/dotfiles/vendor/fzf-git.sh`, where `config/zsh/fzf.sh` sources it if present.

### zsh-autosuggestions

Install with:
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## Vim/Neovim

Neovim configuration is in a separate repository:
```sh
git clone git@github.com:timkomip/timko-vim.git ~/.config/nvim
```

## License

Personal dotfiles - use at your own risk.
