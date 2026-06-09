# Tools that aren't (reliably) in a package manager. Sourced and run by
# `dotty packages` on every OS; each function does its own platform check.
# This file is sourced by bin/dotty, so is_linux/is_macos/ensure_linux_path
# are in scope.

# mise: macOS installs it via Homebrew (see packages.conf); on Linux it isn't
# reliably packaged, so use the official installer.
function install_mise() {
  is_linux || return 0
  if command -v mise &>/dev/null; then
    echo "mise is already installed"; return 0
  fi
  echo "Installing mise..."
  curl -fsSL https://mise.run | sh || echo "  ⚠ Failed to install mise" >&2
}

# zoxide: macOS installs it via Homebrew (see packages.conf); on Linux it isn't
# reliably packaged, so use the official installer (drops the binary in
# ~/.local/bin, which ensure_linux_path makes sure is on PATH).
function install_zoxide() {
  is_linux || return 0
  if command -v zoxide &>/dev/null; then
    echo "zoxide is already installed"; return 0
  fi
  echo "Installing zoxide..."
  if curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh; then
    ensure_linux_path
  else
    echo "  ⚠ Failed to install zoxide" >&2
  fi
}

# bat -> batcat shim: Debian/Ubuntu install bat's binary as "batcat"; expose it
# as "bat" in ~/.local/bin so configs/aliases match macOS (where it's "bat").
function install_bat_shim() {
  is_linux || return 0
  if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
    ensure_linux_path
    echo "  ✓ linked bat -> batcat in ~/.local/bin"
  fi
}

function custom_installs() {
  install_mise
  install_zoxide
  install_bat_shim
}
