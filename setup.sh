#!/usr/bin/env bash
# Stage this mod into a Source SDK 2013 checkout and apply the build patches.
set -euo pipefail

SDK_DIR="${SDK_DIR:-$HOME/Projects/source-sdk-2013}"
SRC="$SDK_DIR/src"

if [ ! -d "$SDK_DIR/.git" ]; then
    echo "SDK checkout not found at $SDK_DIR"
    echo "  git clone https://github.com/ValveSoftware/source-sdk-2013 \"$SDK_DIR\""
    exit 1
fi

# --- stage mod files ---
mkdir -p "$SDK_DIR/game/skate" "$SRC/game/server/skate" \
         "$SRC/game/server" "$SRC/game/client"
cp game/gameinfo.txt             "$SDK_DIR/game/skate/gameinfo.txt"
cp src/game/server/skate/*       "$SRC/game/server/skate/"
cp src/game/server/server_skate.vpc  "$SRC/game/server/server_skate.vpc"
cp src/game/client/client_skate.vpc  "$SRC/game/client/client_skate.vpc"

# --- patches (singleplayer HL2 code is not in Valve's maintained build) ---
# 1. NULL ambiguity in hl2_gamerules.cpp
sed -i 's/NULL, NULL, NULL, 0, 0 )/(char const*)NULL, (char const*)NULL, (char const*)NULL, 0, 0 )/' \
    "$SRC/game/shared/hl2/hl2_gamerules.cpp"

# 2. Register the "SKATE" game conditional
grep -q '"SKATE"' "$SRC/vpc_scripts/default.vgc" || \
    sed -i 's/\t"SDK"\n/\t"SDK"\n\t"SKATE"\n/' "$SRC/vpc_scripts/default.vgc"
python3 - "$SRC/vpc_scripts/default.vgc" <<'EOF'
import sys
p = sys.argv[1]
s = open(p).read()
if '"SKATE"' not in s:
    s = s.replace('\t"SDK"\n', '\t"SDK"\n\t"SKATE"\n')
    open(p,'w').write(s)
EOF

# 3. Add skate projects to projects.vgc
python3 - "$SRC/vpc_scripts/projects.vgc" <<'EOF'
import sys
p = sys.argv[1]
s = open(p).read()
s = s.replace('\t"game\\client\\client_hl2mp.vpc"\t\t[$HL2MP]\n}',
              '\t"game\\client\\client_hl2mp.vpc"\t\t[$HL2MP]\n\t"game\\client\\client_skate.vpc"\t\t[$SKATE]\n}')
s = s.replace('\t"game\\server\\server_hl2mp.vpc"\t\t[$HL2MP]\n}',
              '\t"game\\server\\server_hl2mp.vpc"\t\t[$HL2MP]\n\t"game\\server\\server_skate.vpc"\t\t[$SKATE]\n}')
open(p,'w').write(s)
EOF

# 4. Add /skate to the VPC invocation in buildallprojects
sed -i 's|devtools/bin/vpc /hl2mp /tf /linux64|devtools/bin/vpc /hl2mp /tf /skate /linux64|' \
    "$SRC/buildallprojects"

echo "staged mod into $SDK_DIR"
echo "build:  cd $SRC && nix shell nixpkgs#podman -c bash ./buildallprojects release"
