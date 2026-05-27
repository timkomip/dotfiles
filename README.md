# timko's dotfiles

A dotfiles management system with automated setup and configuration.

## What This Repo Does

This repository contains my personal dotfiles and a management tool (`dotty`) that automates:
- Installing Oh My Zsh
- Installing Homebrew and required packages (macOS only)
- Cloning vendor shell integrations
- Creating symlinks for configuration files
- Loading zsh configuration files in a structured way

> **Note:** Homebrew installation is only available on macOS. On other platforms, the brew-related commands will be skipped with a warning. Linux support may be added in the future.

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
- Install Oh My Zsh (if not already installed)
- Symlink `config/zsh/zshrc` to `~/.zshrc`
- Install Homebrew (if not already installed) - **macOS only**
- Install packages from `config/Brewfile` (including `yq`) - **macOS only**
- Clone vendor dependencies into `vendor/`
- Create symlinks from `config/links.yml`

3. Reload your shell:
```sh
source ~/.zshrc
```

## Using dotty

The `dotty` command provides several subcommands:

### `dotty init`
Initialize everything: install Oh My Zsh, install brew packages, clone vendor dependencies, and create symlinks.

### `dotty brew`
Install Homebrew (if needed) and install packages from `config/Brewfile`.  
**Note:** This command only works on macOS. On other platforms, it will display a warning and skip brew operations.

### `dotty links`
Create symlinks from `config/links.yml`. This command:
- Parses the YAML file using `yq`
- Creates symlinks if they don't already exist
- Skips existing symlinks that point to the correct location
- Warns about conflicts

### `dotty help`
Show help message with available commands.

## Repository Structure

```
dotfiles/
├── bin/
│   ├── dotty              # Main dotfiles management command
│   └── newalias           # Quickly add aliases to aliases.sh
├── config/
│   ├── Brewfile           # Homebrew packages to install
│   ├── links.yml          # Symlink definitions
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
- Shows a `NORMAL` right-prompt indicator in vi mode
- Prepends the hostname to the prompt when connected over SSH

Machine-specific configuration (paths, aliases, SDK setups) goes in `~/.zshrc.local`, which is sourced at the end of zshrc if it exists. This file should not be committed to the repo.

### Symlinks

Symlinks are defined in `config/links.yml`:
```yaml
links:
  - from: ~/dotfiles/config/ideavimrc
    to: ~/.ideavimrc
  - from: ~/dotfiles/config/git/gitignore_global
    to: ~/.gitignore
  - from: ~/dotfiles/config/teleport.yaml
    to: ~/.teleport.yaml
  - from: ~/dotfiles/config/zsh/zshrc
    to: ~/.zshrc
  - from: ~/dotfiles/config/tmux/tmux.conf
    to: ~/.tmux.conf
  - from: ~/dotfiles/config/zellij/config.kdl
    to: ~/.config/zellij/config.kdl
```

Run `dotty links` to create all symlinks.

> **Note:**  
> This command only *creates* links as defined in `config/links.yml`.  
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
