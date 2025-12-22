# ctrl-t - select file
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-R - copy file to clipboard with ctrl-y
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# alt-c - change directory
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# Source fzf-git.sh from vendor directory
local dotfiles_dir="${DOTFILES_DIR:-$HOME/dotfiles}"
local fzf_git_script="$dotfiles_dir/vendor/fzf-git.sh/fzf-git.sh"

if [ -f "$fzf_git_script" ]; then
  source "$fzf_git_script"
fi