# timko's dotfiles

A dotfiles management system with automated setup and configuration.

## What This Repo Does

This repository contains my personal dotfiles and a management tool (`dotty`) that automates:
- Initializing dotfiles in your shell configuration
- Installing Homebrew and required packages
- Creating symlinks for configuration files
- Loading zsh configuration files in a structured way

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
- Add the bootstrap script to your `~/.zshrc`
- Install Homebrew (if not already installed)
- Install packages from `config/Brewfile` (including `yq`)
- Create symlinks from `config/links.yml`

3. Reload your shell:
```sh
source ~/.zshrc
```

## Using dotty

The `dotty` command provides several subcommands:

### `dotty init`
Initialize everything: add bootstrap to zshrc, install brew packages, and create symlinks.

### `dotty brew`
Install Homebrew (if needed) and install packages from `config/Brewfile`.

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
│   └── dotfiles-health    # Health check script
├── bootstrap.sh           # Entry point for loading zsh config
├── config/
│   ├── Brewfile           # Homebrew packages to install
│   ├── links.yml          # Symlink definitions
│   ├── git/
│   │   └── gitignore_global
│   ├── ideavimrc          # IntelliJ IDEA Vim configuration
│   ├── teleport.json      # Directory shortcuts for teleport function
│   ├── vscode/
│   │   ├── keybindings.json
│   │   └── settings.json
│   └── zsh/               # Zsh configuration files
│       ├── aliases.sh     # Shell aliases
│       ├── functions.sh   # Custom shell functions
│       ├── fzf.sh         # FZF configuration
│       ├── paths.sh       # PATH modifications
│       └── plugins.zsh    # Plugin loading
└── docs/
    ├── cheatsheet.md      # Quick reference
    └── vscode.md          # VSCode notes
```

## Configuration Files

### Zsh Configuration

The `bootstrap.sh` script loads configuration files from `config/zsh/` in this order:
1. `plugins.zsh` - Loads external plugins (e.g., fzf-git)
2. `fzf.sh` - FZF environment variables and options
3. `paths.sh` - PATH modifications
4. `functions.sh` - Custom shell functions
5. `aliases.sh` - Shell aliases

You can extend the configuration by adding files to the `config_files` array in `bootstrap.sh`:
```zsh
config_files+=(custom.sh)
```

### Symlinks

Symlinks are defined in `config/links.yml`:
```yaml
links:
  - from: ~/dotfiles/config/ideavimrc
    to: ~/.ideavimrc
  - from: ~/dotfiles/config/git/gitignore_global
    to: ~/.gitignore_global
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

# Aliased as 't'
t code
t tmp
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

### Other Functions

- `cheatsheet` - View the cheatsheet (aliased as `chtsht`)
- `gcol` - Git checkout local branch (interactive with fzf)
- `gcoi` - Git checkout interactive (includes remotes)
- `edit-project` - Open a project from `~/code` in nvim

## ZSH Plugins

### fzf-git.sh

Git integration for fzf. Install with:
```sh
mkdir -p ~/.fzf
git clone git@github.com:junegunn/fzf-git.sh.git ~/.fzf/fzf-git.sh
```

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
