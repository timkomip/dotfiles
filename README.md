# timko's dotfiles setup and notes

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
