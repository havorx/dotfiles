#!/usr/bin/env bash
set -euo pipefail

if command -v docker &>/dev/null; then
  echo "  Docker already installed."
  docker --version
  exit 0
fi

# ── Add Docker's apt repository ──
sudo apt update && sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# ── Install packages ──
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ── Add user to docker group ──
sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker "$USER"

echo "  Docker installed. Log out and back in for docker group to take effect."