#!/usr/bin/env bash
# Stage this mod into a Source SDK 2013 checkout.
# The SDK source is pinned as a flake input ($SDK_SRC in `nix develop`).
set -euo pipefail

SDK_DIR="${SDK_DIR:-$HOME/Projects/source-sdk-2013}"

# Use the pinned flake source if available, otherwise a local clone.
if [ ! -d "$SDK_DIR/.git" ]; then
    echo "SDK checkout not found at $SDK_DIR"
    echo "  git clone https://github.com/ValveSoftware/source-sdk-2013 \"$SDK_DIR\""
    exit 1
fi

mkdir -p "$SDK_DIR/game/skate" "$SDK_DIR/src/game/server/skate"
cp game/gameinfo.txt "$SDK_DIR/game/skate/gameinfo.txt"
cp src/game/server/skate/* "$SDK_DIR/src/game/server/skate/"

echo "staged mod into $SDK_DIR"
echo "build:  cd $SDK_DIR/src && ./buildallprojects"
