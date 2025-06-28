# timko's dotfiles setup and notes

## Install (via oh my zsh)

```sh
ln -s ~/dotfiles/oh-my-zsh/custom/plugins/timko ~/.oh-my-zsh/custom/plugins/timko

```

Then enable plugin in .zshrc

```sh
plugins = (
  git
  timko
)
```

## ZSH Plugins

[fzf-git.sh](https://github.com/junegunn/fzf-git.sh)

Note: Currently sourced in `timko` plugin. TODO: Find better way to do this.

```
mkdir -p ~/.fzf
git clone git@github.com:junegunn/fzf-git.sh.git ~/.fzf
```

[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## Vim?

Clone [timko-vim](https://github.com/timkomip/timko-vim)

```sh
git clone git@github.com:timkomip/timko-vim.git ~/.config/nvim
```

## ZSH Functions

### teleport

Navigate to a directory from anywhere in the filesystem.

_Requires_ `jq` to be installed.

```sh
teleport code # navigate to the ~/code directory from anywhere
teleport tmp # navigate to the ~/tmp directory from anywhere
```

Locations are defined in `~/.teleport.json`. For example:

```json
{
  "tmp": "/Users/michael.timko/tmp",
  "code": "/Users/michael.timko/code"
}
```
