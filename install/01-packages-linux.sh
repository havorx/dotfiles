#!/usr/bin/env bash
set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES/lib/utils.sh"

# ── apt packages ──
echo "  Installing apt packages..."
sudo apt update

# Phase 1: Core prerequisites (brew prerequisites per official docs)
sudo apt install -y git curl file procps build-essential

# Phase 2: Shell + essential tools
sudo apt install -y zsh stow

mkdir -p ~/.local/bin
ln -sf /usr/bin/fdfind ~/.local/bin/fd 2>/dev/null || true
ln -sf /usr/bin/batcat ~/.local/bin/bat 2>/dev/null || ln -sf /usr/bin/bat ~/.local/bin/bat 2>/dev/null || true

# ── Homebrew (needs git + curl from Phase 1) ──
if ! cmd_exists brew; then
  echo "  Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Phase 3: Brew packages (needs brew)
echo "  Installing brew packages..."
brew install neovim lazygit lazydocker git-delta lf

# Phase 4: Core dev tools (optional failures OK)
sudo apt install -y tmux fzf ripgrep fd-find bat 2>/dev/null || true

# Phase 5: Extras (optional)
sudo apt install -y eza htop 2>/dev/null || true
sudo apt install -y fastfetch 2>/dev/null || echo "  (fastfetch not available, optional)"

# ── Manual / curl installs (uses curl from Phase 1) ──
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