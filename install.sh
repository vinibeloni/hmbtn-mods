#!/usr/bin/env sh
# Copy mods into the game's mods/hmbtn/ folder.
#
#   ./install.sh /path/to/folder/with/the/exe
#   ./install.sh /path/to/folder/with/the/exe save-anywhere
#
# Restart the game afterwards: mods are read at launch.
set -eu

[ $# -ge 1 ] || { echo "usage: $0 <game dir> [mod ...]" >&2; exit 2; }
GAME=$1; shift
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

[ -d "$GAME" ] || { echo "error: not a directory: $GAME" >&2; exit 1; }
ls "$GAME"/Harvest_Moon* >/dev/null 2>&1 || {
    echo "error: no Harvest_Moon* executable in $GAME; pass the folder that holds it" >&2
    exit 1
}

DEST="$GAME/mods/hmbtn"
mkdir -p "$DEST"

if [ $# -eq 0 ]; then
    set -- $(cd "$ROOT/mods" && ls -d */ | tr -d /)
fi
for n in "$@"; do
    [ -f "$ROOT/mods/$n/mod.toml" ] || { echo "error: unknown mod: $n" >&2; exit 1; }
    rm -rf "$DEST/$n"
    cp -R "$ROOT/mods/$n" "$DEST/$n"
    echo "installed $n -> $DEST/$n"
done
echo "Restart the game to load them."