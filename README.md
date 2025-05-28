# timko's dotfiles setup and notes

## Install (via oh my zsh)

```sh
ln -s ~/dotfiles/oh-my-zsh/plugins/timko ~/.oh-my-zsh/custom/plugins/timko

```

Then enable plugin in .zshrc

```sh
plugins = (
  git
  timko
)
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
