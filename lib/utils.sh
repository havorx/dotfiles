#!/usr/bin/env bash

clone_if_missing() {
  local repo="$1" dest="$2"
  if [ ! -d "$dest" ]; then
    echo "  Installing: $(basename "$dest")"
    git clone --depth 1 "$repo" "$dest"
  else
    echo "  Already installed: $(basename "$dest")"
  fi
}

cmd_exists() {
  command -v "$1" &>/dev/null
}