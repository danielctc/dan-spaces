#!/bin/bash
# Show status of all submodules

cd "$(dirname "$0")/.."

echo "=== Submodule Status ==="
git submodule status
echo ""

echo "=== Git Status per Submodule ==="
git submodule foreach 'echo "--- $name ---" && git status -s'
