#!/bin/bash
# Script to push submodule changes to forked repos
# Run this in the Dev Container after creating forks on Windows

set -e

cd /workspaces/EA31337

echo "=========================================="
echo "Pushing Submodule Changes to Forks"
echo "=========================================="
echo ""

# Classes submodule - HAS CHANGES TO PUSH
echo "1. Pushing classes submodule (7 commits)..."
cd src/include/classes
if git push fork dev 2>&1; then
    echo "   SUCCESS: Classes pushed successfully"
else
    echo "   ERROR: Failed to push classes - make sure fork exists"
    echo "     Create fork at: https://github.com/EA31337/EA31337-classes/fork"
fi
cd /workspaces/EA31337

# Indicators submodule - NO CHANGES, just establish fork
echo ""
echo "2. Pushing indicators submodule (no changes)..."
cd src/indicators
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" = "HEAD" ]; then
    git checkout -b dev 2>/dev/null || git checkout dev
fi
if git push fork dev 2>&1; then
    echo "   SUCCESS: Indicators pushed successfully"
else
    echo "   ERROR: Failed to push indicators"
fi
cd /workspaces/EA31337

# Strategies submodule - NO CHANGES, just establish fork
echo ""
echo "3. Pushing strategies submodule (no changes)..."
cd src/strategies
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" = "HEAD" ]; then
    git checkout -b dev 2>/dev/null || git checkout dev
fi
if git push fork dev 2>&1; then
    echo "   SUCCESS: Strategies pushed successfully"
else
    echo "   ERROR: Failed to push strategies"
fi
cd /workspaces/EA31337

# Strategies-meta submodule - NO CHANGES, just establish fork
echo ""
echo "4. Pushing strategies-meta submodule (no changes)..."
cd src/strategies-meta
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" = "HEAD" ]; then
    git checkout -b dev 2>/dev/null || git checkout dev
fi
if git push fork dev 2>&1; then
    echo "   SUCCESS: Strategies-meta pushed successfully"
else
    echo "   ERROR: Failed to push strategies-meta"
fi
cd /workspaces/EA31337

echo ""
echo "=========================================="
echo "Push Complete!"
echo "=========================================="
echo ""
echo "Verify forks at:"
echo "  https://github.com/alphadon/EA31337-classes"
echo "  https://github.com/alphadon/EA31337-indicators"
echo "  https://github.com/alphadon/EA31337-strategies"
echo "  https://github.com/alphadon/Strategy-Meta"
echo ""
