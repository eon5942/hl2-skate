#!/usr/bin/env bash
# Launch the HL2 Skate mod (64-bit) with the Steam Runtime libraries.
set -euo pipefail

TOOL="$HOME/.local/share/Steam/steamapps/common/Source SDK Base 2013 Multiplayer"
RUNTIME="$HOME/.local/share/Steam/steamapps/common/SteamLinuxRuntime_sniper"
RTLIB=$(find "$RUNTIME/var" -type d -path "*/usr/lib/x86_64-linux-gnu" 2>/dev/null | head -1)
SDL3LIB=$(find "$RUNTIME" -type d -path "*/files/lib/x86_64-linux-gnu" 2>/dev/null | head -1)

# sdl2-classic (real SDL2) first, then Debian libs, then SDL3.
export LD_LIBRARY_PATH="$TOOL/bin/linux64:$RTLIB/sdl2-classic:$RTLIB:${SDL3LIB:-}"

cd "$TOOL"
exec "$TOOL/hl2_linux64" -game skate "$@"
