# oh-my-zsh configuration
# This file sets oh-my-zsh theme and plugins
# Must be sourced BEFORE oh-my-zsh.sh in .zshrc

ZSH_THEME="robbyrussell"

plugins=(
  colored-man-pages
  git
  node
  npm
  gh
  vi-mode
  aliases
  mise
)

# macOS-only plugins
if [[ "$OSTYPE" == darwin* ]]; then
  plugins+=(brew iterm2)
fi

# plugins that require manual installation
if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
  plugins+=(zsh-autosuggestions)
fi

