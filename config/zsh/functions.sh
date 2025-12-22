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
#   - If no project name provided, opens fzf to interactively select from ~/code
#   - If project name provided, directly opens ~/code/project_name
#   - Uses $EDITOR environment variable (defaults to nvim if not set)
#   - Validates project names to prevent path traversal attacks
#   - Returns error if ~/code directory doesn't exist
#   - Returns error if specified project doesn't exist
# Examples:
#   edit-project              # Interactive selection with fzf
#   edit-project my-app       # Open ~/code/my-app
#   EDITOR=code edit-project web  # Open ~/code/web in VS Code
function edit-project() {
  local passed_project=$1
  local editor="${EDITOR:-nvim}"
  local code_dir="$HOME/code"

  # Validate that ~/code directory exists
  if [ ! -d "$code_dir" ]; then
    echo "Error: $code_dir does not exist" >&2
    return 1
  fi

  if [ -z "$passed_project" ]; then
    # Interactive mode: use fzf to select project
    local selected=$(ls "$code_dir" | fzf)
    if [ -z "$selected" ]; then
      # User cancelled fzf selection
      return 1
    fi
    # Validate selected project name (prevent path traversal attacks)
    if [[ "$selected" =~ \.\./ ]] || [[ "$selected" =~ ^/ ]]; then
      echo "Error: Invalid project name" >&2
      return 1
    fi
    # Open selected project using basename to sanitize path
    $editor "$code_dir/$(basename "$selected")"
  else
    # Direct mode: open specified project
    # Validate project name (prevent path traversal attacks)
    if [[ "$passed_project" =~ \.\./ ]] || [[ "$passed_project" =~ ^/ ]]; then
      echo "Error: Invalid project name. Use only the project directory name." >&2
      return 1
    fi
    # Use basename to prevent any path manipulation
    local project_name=$(basename "$passed_project")
    local project_path="$code_dir/$project_name"
    # Check if project exists before opening
    if [ ! -e "$project_path" ]; then
      echo "Error: Project '$project_name' does not exist in $code_dir" >&2
      return 1
    fi
    $editor "$project_path"
  fi
}

# Create a directory and file in one command
# Usage: mkfile <directory_path> <filename>
#   - Creates the directory (and parent directories) if they don't exist
#   - Creates the file inside the directory
# Example: mkfile path/to/dir file.txt
function mkfile() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: mkfile requires both directory path and filename" >&2
    echo "Usage: mkfile <directory_path> <filename>" >&2
    return 1
  fi

  local dir_path="$1"
  local filename="$2"

  # Validate filename (prevent path traversal in filename)
  if [[ "$filename" =~ \.\./ ]] || [[ "$filename" =~ / ]]; then
    echo "Error: Filename cannot contain path separators or '..'" >&2
    return 1
  fi

  # Use basename on filename to ensure it's just a filename
  local safe_filename=$(basename "$filename")

  mkdir -p -- "$dir_path" && touch -- "$dir_path"/"$safe_filename"
}
