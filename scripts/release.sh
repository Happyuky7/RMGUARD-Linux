#!/usr/bin/env bash
# Build and prepare release package
set -euo pipefail

if [[ $# -eq 0 ]]; then
  echo "Usage: $0 <version>"
  echo "Example: $0 0.0.2"
  exit 1
fi

VERSION="$1"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=========================================="
echo "Building rmguard release v$VERSION"
echo "=========================================="
echo ""

# Build the .deb package
echo "📦 Building .deb package..."
"$ROOT/scripts/package.sh" "$VERSION"

echo ""
echo "=========================================="
echo "✅ Release ready!"
echo "=========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Test the package:"
echo "   sudo apt install $ROOT/build/rmguard_${VERSION}_all.deb"
echo ""
echo "2. Create GitHub release:"
echo "   - Go to: https://github.com/Happyuky7/RMGUARD-Linux/releases/new"
echo "   - Tag: v$VERSION"
echo "   - Title: rmguard v$VERSION"
echo "   - Upload: $ROOT/build/rmguard_${VERSION}_all.deb"
echo ""
echo "3. Verify rmguard-cli version:"
echo "   - Edit: src/rmguard-cli"
echo "   - Change: VERSION=\"$VERSION\""
echo ""
echo "4. Commit and push:"
echo "   git add ."
echo "   git commit -m \"Release v$VERSION\""
echo "   git tag v$VERSION"
echo "   git push && git push --tags"
echo ""
