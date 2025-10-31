#!/bin/bash
# Setup script for creating and pushing to forked submodule repositories
# Run this after creating forks on GitHub

set -e

FORK_USER="alphadon"

echo "=========================================="
echo "EA31337 Submodule Fork Setup"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to setup fork remote and push
setup_and_push() {
    local submodule_path=$1
    local repo_name=$2
    local has_changes=$3

    echo ""
    echo -e "${YELLOW}Processing: ${repo_name}${NC}"
    echo "Path: ${submodule_path}"

    cd "/workspaces/EA31337/${submodule_path}"

    # Check if fork remote exists
    if git remote get-url fork &>/dev/null; then
        echo "  - Fork remote already exists"
    else
        echo "  - Adding fork remote..."
        git remote add fork "https://github.com/${FORK_USER}/${repo_name}.git"
    fi

    # Check if on a branch or detached HEAD
    current_branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")

    if [ -z "$current_branch" ]; then
        echo "  - Currently in detached HEAD, creating dev branch..."
        git checkout -b dev
    else
        echo "  - Current branch: ${current_branch}"
    fi

    if [ "$has_changes" = "true" ]; then
        echo -e "  - ${GREEN}HAS LOCAL CHANGES - Ready to push${NC}"
        echo "  - Run: cd ${submodule_path} && git push fork dev"
    else
        echo "  - No local changes"
    fi

    cd /workspaces/EA31337
}

echo ""
echo "Step 1: Please create these forks on GitHub:"
echo "  1. Fork https://github.com/EA31337/EA31337-classes"
echo "  2. Fork https://github.com/EA31337/EA31337-indicators"
echo "  3. Fork https://github.com/EA31337/EA31337-strategies"
echo "  4. Fork https://github.com/EA31337/Strategy-Meta"
echo ""
echo "Press ENTER when forks are created..."
read -r

# Setup each submodule
echo ""
echo "=========================================="
echo "Setting up submodule remotes..."
echo "=========================================="

setup_and_push "src/include/classes" "EA31337-classes" "true"
setup_and_push "src/indicators" "EA31337-indicators" "false"
setup_and_push "src/strategies" "EA31337-strategies" "false"
setup_and_push "src/strategies-meta" "Strategy-Meta" "false"

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "To push classes submodule changes:"
echo "  cd src/include/classes"
echo "  git push fork dev"
echo ""
echo "The other submodules have no local changes."
echo ""
