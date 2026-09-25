#!/bin/bash
# WorkDe Website — Quick Deploy Script
# Run this from inside your WorkDe repo root: bash website/deploy.sh

set -e

echo ""
echo "🔨 WorkDe Website Deploy Script"
echo "================================"
echo ""

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")
WEBSITE_DIR="$REPO_ROOT/website"

# Check we're in a git repo
if ! git -C "$REPO_ROOT" status > /dev/null 2>&1; then
  echo "❌ Error: Not inside a git repository."
  echo "   Please run this from inside your WorkDe repo."
  exit 1
fi

echo "📁 Repo root: $REPO_ROOT"
echo ""

# Stage and commit website changes
cd "$REPO_ROOT"
git add website/
CHANGED=$(git diff --cached --name-only | wc -l | tr -d ' ')

if [ "$CHANGED" = "0" ]; then
  echo "ℹ️  No changes to commit. Website is already up to date."
else
  echo "📝 Committing $CHANGED changed file(s)..."
  git commit -m "Update WorkDe website [$(date '+%Y-%m-%d %H:%M')]"
  echo "✅ Committed."
fi

# Push to main
echo ""
echo "🚀 Pushing to GitHub..."
git push origin main
echo "✅ Pushed."

echo ""
echo "🌐 GitHub Pages will deploy in ~30 seconds."
echo "   Check status: https://github.com/ImM0han/WorkDe/actions"
echo ""
echo "   Your site: https://imm0han.github.io/WorkDe"
echo "   (or your custom domain if CNAME is configured)"
echo ""
