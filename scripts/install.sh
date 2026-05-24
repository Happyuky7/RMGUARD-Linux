#!/usr/bin/env bash
set -euo pipefail

# Manual installation (git clone). Run as root.
if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "Run as root." >&2; exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

install -d -m 0755 /usr/lib/rmguard
install -m 0755 "$ROOT_DIR/src/rmguard" /usr/lib/rmguard/rmguard

install -d -m 0755 /usr/local/bin
install -m 0755 "$ROOT_DIR/src/rmguard-cli" /usr/local/bin/rmguard

install -d -m 0755 /etc/profile.d
install -m 0644 "$ROOT_DIR/etc/profile.d/rmguard.sh" /etc/profile.d/rmguard.sh

# Optional config (doesn't overwrite if exists)
[[ -f /etc/rmguard.conf ]] || install -m 0644 "$ROOT_DIR/config/rmguard.conf" /etc/rmguard.conf

echo "rmguard installed."
echo "- Binary:     /usr/lib/rmguard/rmguard"
echo "- CLI:        /usr/local/bin/rmguard"
echo "- Profile.d:  /etc/profile.d/rmguard.sh"
echo "- Config:     /etc/rmguard.conf"
echo
echo "Open a NEW SSH session or run: 'source /etc/profile' to activate it."
echo "Run 'rmguard --help' for usage information."
