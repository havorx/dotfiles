#!/usr/bin/env bash
set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES/lib/utils.sh"

# ── apt packages ──
echo "  Installing apt packages..."
sudo apt update
sudo apt install -y \
  git zsh tmux fzf ripgrep fd-find bat eza htop fastfetch stow \
  build-essential curl unzip

mkdir -p ~/.local/bin
ln -sf /usr/bin/fdfind ~/.local/bin/fd
ln -sf /usr/bin/batcat ~/.local/bin/bat 2>/dev/null || ln -sf /usr/bin/bat ~/.local/bin/bat

# ── Homebrew (for packages needing latest versions) ──
if ! cmd_exists brew; then
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo "  Installing brew packages..."
brew install neovim lazygit lazydocker git-delta lf

# ── Manual / curl installs ──
if ! cmd_exists starship; then
  echo "  Installing starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

if ! cmd_exists zoxide; then
  echo "  Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

if [ ! -x "$HOME/.local/bin/mise" ]; then
  echo "  Installing mise..."
  curl https://mise.run | sh
fi