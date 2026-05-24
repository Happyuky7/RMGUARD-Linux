#!/usr/bin/env bash
# Builds rmguard_X.X.X_all.deb (or the version you pass as arg) and leaves it in build/
set -euo pipefail

VER="${1:-0.0.1}"
PKG="rmguard"
ARCH="all"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$ROOT/build"
PKGDIR="$BUILD/pkg"
README_FILE="$ROOT/README.md"

if [[ ! -f "$README_FILE" && -f "$ROOT/README.MD" ]]; then
  README_FILE="$ROOT/README.MD"
fi

rm -rf "$BUILD"
mkdir -p "$PKGDIR/DEBIAN" \
         "$PKGDIR/usr/lib/$PKG" \
         "$PKGDIR/etc/profile.d" \
         "$PKGDIR/usr/share/doc/$PKG"

# Control file
cat >"$PKGDIR/DEBIAN/control" <<EOF
Package: $PKG
Version: $VER
Section: utils
Priority: optional
Architecture: $ARCH
Depends: bash, coreutils
Maintainer: Happyuky7 (https://github.com/Happyuky7)
Description: Guard to prevent dangerous rm usage (rm -f /*, rm -rf /etc)
 rmguard intercepts 'rm' in interactive shells and blocks root-level paths.
EOF

# Files
install -m 0755 "$ROOT/src/rmguard" "$PKGDIR/usr/lib/$PKG/rmguard"
install -m 0755 "$ROOT/src/rmguard-cli" "$PKGDIR/usr/local/bin/rmguard"
install -m 0644 "$ROOT/etc/profile.d/rmguard.sh" "$PKGDIR/etc/profile.d/rmguard.sh"
install -m 0644 "$ROOT/config/rmguard.conf" "$PKGDIR/usr/share/doc/$PKG/rmguard.conf.example"

# Documentation
install -m 0644 "$README_FILE" "$PKGDIR/usr/share/doc/$PKG/README.md"
install -m 0644 "$ROOT/LICENSE" "$PKGDIR/usr/share/doc/$PKG/LICENSE"
gzip -9 "$PKGDIR/usr/share/doc/$PKG/README.md"

# Postinst: copy config example if it doesn't exist
cat >"$PKGDIR/DEBIAN/postinst" <<'EOF'
#!/bin/sh
set -e
if [ ! -f /etc/rmguard.conf ]; then
  cp -n /usr/share/doc/rmguard/rmguard.conf.example /etc/rmguard.conf || true
fi
exit 0
EOF
chmod 0755 "$PKGDIR/DEBIAN/postinst"

# Build .deb
DEB="$BUILD/${PKG}_${VER}_${ARCH}.deb"
dpkg-deb --build "$PKGDIR" "$DEB"

echo ""
echo "=========================================="
echo "✅ Package built successfully!"
echo "=========================================="
echo ""
echo "Package: $DEB"
echo "Version: $VER"
echo ""
echo "INSTALLATION OPTIONS:"
echo ""
echo "1. Install locally:"
echo "   sudo apt install $DEB"
echo "   (or: sudo dpkg -i $DEB && sudo apt -f install)"
echo ""
echo "2. Upload to GitHub Releases:"
echo "   - Go to: https://github.com/Happyuky7/RMGUARD-Linux/releases/new"
echo "   - Create tag: v$VER"
echo "   - Upload file: $(basename "$DEB")"
echo ""
echo "3. Users can then install with:"
echo "   wget https://github.com/Happyuky7/RMGUARD-Linux/releases/download/v$VER/$(basename "$DEB")"
echo "   sudo apt install ./$(basename "$DEB")"
echo ""
echo "=========================================="
