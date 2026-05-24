#!/usr/bin/env bash
set -euo pipefail
if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "Run as root." >&2; exit 1
fi

rm -f /usr/lib/rmguard/rmguard
rmdir --ignore-fail-on-non-empty /usr/lib/rmguard 2>/dev/null || true
rm -f /usr/local/bin/rmguard
rm -f /etc/profile.d/rmguard.sh
# We don't delete /etc/rmguard.conf as a courtesy:
echo "rmguard uninstalled. If you want, delete /etc/rmguard.conf manually."
