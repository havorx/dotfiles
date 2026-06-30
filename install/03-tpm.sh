#!/usr/bin/env bash
set -uo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../lib/utils.sh"

clone_if_missing https://github.com/tmux-plugins/tpm \
  "$HOME/.tmux/plugins/tpm"

echo "  Installing tmux plugins..."
export XDG_CONFIG_HOME="$HOME/.config"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.config/tmux/plugins"
mkdir -p "$TMUX_PLUGIN_MANAGER_PATH"
~/.tmux/plugins/tpm/bin/install_plugins