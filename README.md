# Harvest Moon: Back to Nature — mods

Drop-in mods for the native PC port of **Harvest Moon: Back to Nature (USA, SLUS-01115)**
built by [harvest-moon-btn-psx-recomp](https://github.com/vinibeloni/harvest-moon-btn-psx-recomp).

A mod is a folder with one `mod.toml`. Put it in `mods/hmbtn/` next to the game
executable and it is active; remove it and it is gone. No rebuild, no regeneration, no
in-game toggle.

## Mods

| Mod | What it does | Controls |
|---|---|---|
| [`save-anywhere`](mods/save-anywhere/mod.toml) | Open the diary save or load screen from the field, without going to bed. A save keeps the time of day and the item in hand; the game always reloads you inside the farmhouse. | **L2 + R2** save, **L1 + R1** load |

Each mod's `mod.toml` starts with a comment block explaining what it does and what it
does not guard against. Read it before using the mod. `save-anywhere`, for example,
refuses to fire during a dialogue or event and while the Start menu is open, but not on
the "Now Loading" screen, and **loading replaces the current game**.

### What a load looks like (`save-anywhere`)

Confirmed in play: save outdoors while holding a weed, then load. The game does **not**
put you back where you saved. It starts the farmhouse wake-up scene it always plays when
a diary is loaded: the character appears at the table and eats breakfast, then control
returns and the character is holding the same weed again. That meal is the game's own
scene, not something the mod adds, and the mod does not skip it. What survives a save and
load: the time of day and the item in hand. What does not: the position (always the
farmhouse).

## Install

You need the game built from the repository above, with the mod engine
(branch `feat/drop-in-mods`, commit `5eb3c45` or later).

1. Download the zip of the mod you want from the **Releases** page
   (`save-anywhere-<version>.zip`).
2. Extract it into the `mods/hmbtn/` folder next to the game executable
   (create the folder if it is not there). You end up with
   `mods/hmbtn/save-anywhere/mod.toml`.
3. Restart the game. Mods are read when the game starts.

To remove a mod, delete its folder. Extracting into a folder named after the mod
(`mods/hmbtn/save-anywhere/save-anywhere/mod.toml`) also works.

Instead of the zips, from a clone of this repository:

```powershell
.\install.ps1 -GameDir "C:\path\to\folder\with\the\exe" [-Mod save-anywhere]
```

```sh
./install.sh /path/to/folder/with/the/exe [save-anywhere]
```

To check that the engine took it, run `python3 psxrecomp/tools/debug_client.py mod_counters`
in the game repository: it shows `hmbtn.patchengine.mods_loaded`, and `.mods_rejected` if
a mod failed to parse (a mod that fails to parse is rejected whole, never half-applied).

## Making a release

```sh
python3 tools/package.py                 # builds dist/<mod>-<version>.zip, one per mod
gh release create v1 dist/*.zip --title "..." --notes "..."
```

Each zip holds a single top-level folder named after the mod, with forward-slash entry
names so it unzips correctly on Windows, macOS and Linux, and a fixed timestamp so the
same sources always give the same zip. Bump `version` in the mod's `mod.toml` first; the
zip is named after it. Note that release downloads need a **public** repository: on a
private one only people you have added can download them.
## Compatibility

These mods write to the game's RAM at fixed addresses. They are **only valid for the USA
disc, SLUS-01115**. On another version or region they would write to the wrong place, and
the engine has no way to know. Every `[[patch]]` carries the stock word it expects
(`expected`) and is skipped when RAM holds anything else; `[[trigger]]` writes are not
guarded that way.

## Writing a mod

The `mod.toml` format (`[[patch]]`, `[[trigger]]`, `[[require]]`, `[[write]]`) is defined
and documented in the game repository: see the "Drop-in mods" section of its `CLAUDE.md`
and the header comment of `src/mods/hmbtn_patchengine.c`. Rules that matter:

- Find addresses by measurement, not by guessing, and write down how you found them in
  the mod's comment block.
- Check the game's state **before** pressing a trigger while testing: a fired trigger
  changes the game state and every later reading is then wrong.
- A trigger should say what it refuses to run during (dialogue, events, menus).

## What must never be committed here

No game data: no disc image, executable, ROM, BIOS, memory card or save, and no dump of
the game's RAM or code. This repository holds `mod.toml` files and scripts only, and you
supply your own legally obtained copy of the game. `tools/check_no_game_data.py` enforces
it; turn the commit gate on once per clone:

```sh
git config core.hooksPath .githooks
```

## License

[PolyForm Noncommercial License 1.0.0](LICENSE). You may use, copy, modify and share this
code for any noncommercial purpose (personal use, hobby projects, study, nonprofits,
education, and so on). You may **not** sell it or use it commercially. This is a
source-available license, not an OSI "open source" license. The game engine this builds
on, [psxrecomp](https://github.com/mstan/psxrecomp), uses the same license.

This is an unofficial fan project. It is not affiliated with or endorsed by Natsume or the
rights holders of Harvest Moon, and it contains no game data: you need your own legally
obtained copy of the game.
