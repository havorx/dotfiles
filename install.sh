#!/usr/bin/env bash
set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

source "$DOTFILES/lib/utils.sh"

step() {
  local name="$1"; shift
  printf "\n==> %s\n" "$name"
  if "$@"; then
    printf "  ✓ %s\n" "$name"
  else
    printf "  ✗ %s FAILED\n" "$name"
    return 1
  fi
}

echo "Bootstrapping dotfiles on $OS..."

case "$OS" in
  Darwin)
    step "Xcode CLI"    source "$DOTFILES/install/00-xcode.sh"
    step "Packages"      source "$DOTFILES/install/01-packages-darwin.sh"
    ;;
  Linux)
    step "Packages"      source "$DOTFILES/install/01-packages-linux.sh"
    ;;
esac

step "oh-my-zsh"   source "$DOTFILES/install/02-oh-my-zsh.sh"
step "mise"         source "$DOTFILES/install/04-mise.sh"
step "Stow"         source "$DOTFILES/install/05-stow.sh"
step "tmux TPM"    source "$DOTFILES/install/03-tpm.sh"
step "zshenv"       source "$DOTFILES/install/06-zshenv.sh"
step "Shell"        source "$DOTFILES/install/07-shell.sh"

if [ "$OS" = "Darwin" ]; then
  step "macOS services" source "$DOTFILES/install/08-services-darwin.sh"
fi

echo -e "\n✓ All done! Restart your terminal or run: exec zsh"