#!/usr/bin/env bash
set -uo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../lib/utils.sh"

clone_if_missing https://github.com/tmux-plugins/tpm \
  "$HOME/.tmux/plugins/tpm"

echo "  Installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins