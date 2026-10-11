# HL2 Skate

Skate 3-style skateboarding as a Half-Life 2 (Source SDK 2013) mod.

## Structure

- `game/gameinfo.txt` — mounts HL2 content on Source SDK Base 2013 Singleplayer.
- `src/game/server/skate/skateboard.{h,cpp}` — `CSkateboard` entity skeleton.
- `flake.nix` — dev shell (podman/docker) + pinned SDK source.
- `setup.sh` — stages the mod into a Source SDK 2013 checkout.

## Setup

```
nix develop                 # podman/docker + SDK source
./setup.sh                  # copy mod into $HOME/Projects/source-sdk-2013
```

`setup.sh` needs a Source SDK 2013 checkout (cloned, or use `$SDK_DIR` to
point elsewhere). The flake also pins the exact SDK revision.

## Build

```
cd $HOME/Projects/source-sdk-2013/src
./buildallprojects          # runs in the Steam Runtime "sniper" SDK container
```

The build compiles the whole HL2 game code (32-bit) via VPC + ninja inside a
Steam Runtime container. `buildallprojects` hardcodes `podman`; if you use
docker, either install podman or patch `src/sdk_container` to use `docker run`
instead (`--userns=keep-id` → `--user $(id -u):$(id -g)`).

The mod also needs `server_skate.vpc` / `client_skate.vpc` (copies of the HL2
ones with `GAMENAME "skate"`) and `skateboard.cpp` listed in the server project.

## Run

```
~/.local/share/Steam/steamapps/common/Source SDK Base 2013 Singleplayer/hl2.sh -game skate
```

## Roadmap

1. [x] Mod folder + gameinfo
2. [x] `CSkateboard` entity skeleton
3. [ ] VPC projects + first build (Steam Runtime container)
4. [ ] Board model (Blender Source tools -> .mdl)
5. [ ] Riding + movement (VPhysics, player attach)
6. [ ] Flick-it trick system (flips/shoves/grinds)
7. [ ] Animation (ped crouch/kick) — still the hard part
