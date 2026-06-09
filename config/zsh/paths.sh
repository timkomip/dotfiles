export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"

# snap-installed tools (e.g. nvim) live in /snap/bin, which isn't always
# added to PATH under zsh on WSL/Ubuntu
[ -d /snap/bin ] && export PATH="/snap/bin:$PATH"
