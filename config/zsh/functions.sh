function my-funcs() {
  echo "teleport - teleport to dir"
  echo "gcol - git checkout local"
  echo "edit-project - interative open in vim (assume ~/code)"
}

function teleport() {
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
