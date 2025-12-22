#!/usr/bin/env zsh

# Bootstrap script for dotfiles
# Loads all configuration files from config/zsh directory

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
ZSH_CONFIG_DIR="$DOTFILES_DIR/config/zsh"

# Array of config files to source (in order)
typeset -a config_files
config_files=(
  plugins.zsh
  fzf.sh
  paths.sh
  functions.sh
  aliases.sh
)

# Source all zsh configuration files
if [ -d "$ZSH_CONFIG_DIR" ]; then
  for file in "${config_files[@]}"; do
    local config_file="$ZSH_CONFIG_DIR/$file"
    if [ -f "$config_file" ]; then
      source "$config_file"
    fi
  done
else
  echo "Warning: ZSH config directory not found: $ZSH_CONFIG_DIR" >&2
fi

