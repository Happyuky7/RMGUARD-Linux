#!/usr/bin/env bash
set -euo pipefail
# Simulate an interactive session
export RM_GUARD=1

# 1) Should block top-level paths
if /usr/lib/rmguard/rmguard -rf /etc 2>/dev/null; then
  echo "FAIL: didn't block /etc"; exit 1
else
  echo "OK blocked /etc"
fi

# 2) Should allow /tmp
touch /tmp/x.$$; /usr/lib/rmguard/rmguard -f /tmp/x.$$
[[ -e /tmp/x.$$ ]] && { echo "FAIL: couldn't delete in /tmp"; exit 1; } || echo "OK /tmp allowed"

echo ""
echo "✅ All tests passed successfully"
