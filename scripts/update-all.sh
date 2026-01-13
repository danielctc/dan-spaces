#!/bin/bash
# Update all submodules to latest from upstream

echo "Updating all submodules..."

cd "$(dirname "$0")/.."

git submodule foreach 'git fetch origin && git pull origin main'

echo "Done. Remember to commit submodule pointer updates:"
echo "  git add . && git commit -m 'chore: update submodules'"
