function my-funcs() {
  echo "teleport - teleport to dir"
  echo "gcol - git checkout local"
  echo "edit-project - interative open in vim (assume ~/code)"
}

function teleport() {
  DESTINATION=$1
  CONFIG_FILE="$HOME/.teleport.json"

  if [ -z "$DESTINATION" ]; then
    echo "Places to go:"
    jq "." "$CONFIG_FILE"
    exit 0
  fi

  RESULT=$(jq -r ".$DESTINATION" "$CONFIG_FILE" | tr -d '\r\n')

  if [ -n "$RESULT" ]; then
    cd "$RESULT" || exit 1
  else
    echo "Destination '$DESTINATION' not found in $CONFIG_FILE"
    exit 1
  fi
}

function gcol() {
  git checkout "$(git branch --format='%(refname:short)' | fzf)"
}

function edit-project() {
  local passed_project=$1

  if [ -z "$passed_project" ]; then
    nvim ~/code/"$(ls ~/code | fzf)"
  else
    nvim ~/code/"$passed_project"
  fi
}
