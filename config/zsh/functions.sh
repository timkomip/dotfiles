# List all available custom functions with brief descriptions
function my-funcs() {
  echo "cheatsheet - helpful reminders of aliases and stuff"
  echo "json_teleport - teleport to dir using JSON config"
  echo "yaml_teleport - teleport to dir using YAML config (alias: t)"
  echo "gcol - git checkout local branch (fzf)"
  echo "gcoi - git checkout interactive (fzf with remotes)"
  echo "edit-project - interactive open in editor (assume ~/code, uses \$EDITOR)"
  echo "mkfile - create directory and file in one command"
}

# Display the cheatsheet documentation
# Uses bat if available, otherwise falls back to less
function cheatsheet() {
  if command -v bat &>/dev/null; then
    bat "$HOME"/dotfiles/docs/cheatsheet.md
  else
    less "$HOME"/dotfiles/docs/cheatsheet.md
  fi

}

# Navigate to a directory defined in ~/.teleport.json
# Usage: json_teleport [destination]
#   - If no destination provided, lists all available destinations
#   - Requires jq to be installed
#   - Config file format: { "destination": "/path/to/dir" }
function json_teleport() {
  DESTINATION=$1
  CONFIG_FILE="$HOME/.teleport.json"

  if ! type "jq" >/dev/null; then
    echo "Please install jq"
    return
  fi

  if [ -z "$DESTINATION" ]; then
    echo "Places to go:"
    jq "." "$CONFIG_FILE"
    return
  fi

  RESULT=$(jq -r ".$DESTINATION" "$CONFIG_FILE" | tr -d '')

  if [ -n "$RESULT" ]; then
    cd "$RESULT" || return
  else
    echo "Destination '$DESTINATION' not found in $CONFIG_FILE"
  fi
}

# Navigate to a directory defined in ~/.teleport.yaml
# Usage: yaml_teleport [destination] (also available as alias: t)
#   - If no destination provided, lists all available destinations
#   - Requires yq to be installed
#   - Config file format: places: { destination: "/path/to/dir" }
function yaml_teleport() {
  DESTINATION=$1
  CONFIG_FILE="$HOME/.teleport.yaml"

  if ! type "yq" >/dev/null; then
    echo "Please install yq"
    return
  fi

  if [ -z "$DESTINATION" ]; then
    echo "Places to go:"
    yq eval "." "$CONFIG_FILE"
    return
  fi

  RESULT=$(yq eval ".places.$DESTINATION" "$CONFIG_FILE")

  if [ "$RESULT" != "null" ]; then
    cd "$RESULT" || return
  else
    echo "Destination '$DESTINATION' not found in $CONFIG_FILE"
  fi
}

# Interactive git checkout for local branches using fzf
# Usage: gcol
#   - Opens fzf to select a local branch
#   - Checks out the selected branch
function gcol() {
  git branch --format='%(refname:short)' | fzf --no-multi | xargs git checkout
}

# Interactive git checkout for all branches (local and remote) using fzf
# Usage: gcoi
#   - Opens fzf to select any branch (local or remote)
#   - Checks out the selected branch
#   - Requires _fzf_git_each_ref function (typically from fzf git plugin)
function gcoi() {
  _fzf_git_each_ref --no-multi | xargs git checkout
}

# Open a project from ~/code directory using $EDITOR
# Usage: edit-project [project_name]
#   - If no project name provided, opens fzf to select from ~/code
#   - If project name provided, directly opens ~/code/project_name
#   - Uses $EDITOR environment variable (defaults to nvim if not set)
function edit-project() {
  local passed_project=$1
  local editor="${EDITOR:-nvim}"

  if [ -z "$passed_project" ]; then
    $editor ~/code/"$(ls ~/code | fzf)"
  else
    $editor ~/code/"$passed_project"
  fi
}

# Create a directory and file in one command
# Usage: mkfile <directory_path> <filename>
#   - Creates the directory (and parent directories) if they don't exist
#   - Creates the file inside the directory
# Example: mkfile path/to/dir file.txt
function mkfile() {
  mkdir -p -- "$1" && touch -- "$1"/"$2"
}
