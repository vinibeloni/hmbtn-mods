# Fast dialogue

**English** · [Português (Brasil)](README.pt-BR.md) · [← all mods](../../README.md)

Text boxes print about three times faster. Always on, no button to press.

Version 0.1.1 · for **Harvest Moon: Back to Nature (USA, SLUS-01115)** only.

## What to expect

- Every character still prints, in order. Measured in the game: 0.64 characters per game
  tick in the stock game, 2.05 with the mod.
- Cross still advances a finished box exactly as before, and does not skip the next one.
- Boxes that close **on their own** (no Cross prompt, for example the village tour with the
  mayor) are timed by the scene, not by the text. Faster text means less time to read them.
  If that bothers you, lower the speed (below).

## Change the speed yourself

Open `mods/hmbtn/fast-dialogue/mod.toml` in any text editor. In the second `[[patch]]`, change
the last digit of the `replace` line, save, and restart the game:

| `replace` | Speed |
|---|---|
| `0x24420002` (default) | about 3x |
| `0x24420003` | about 4.5x |
| `0x24420004` | about 6x |
| `0x2442000F` | the maximum |

Only 2 was checked through the whole opening, and 4 on the policeman event. Other values are
not tested.

## Install

1. Open [`mod.toml`](mod.toml) in this folder and click **Download raw file**.
2. Put it in a folder named `fast-dialogue` inside `mods/hmbtn/` next to the game executable
   (create the folders if missing). You end up with `mods/hmbtn/fast-dialogue/mod.toml`. No zip
   or release needed: the mod is that one file.
3. Restart the game. Mods are read when the game starts.

To remove it, delete the `fast-dialogue` folder and restart: the text goes back to the stock
speed. Requires the game build with the mod engine (see the [main README](../../README.md#install)).

## Compatibility

USA disc, SLUS-01115, only. Both patches carry the stock word they expect (`expected`) and are
skipped if RAM holds anything else.

Tested by the author in play: the policeman event (all boxes complete, game continues) and
the village tour. Not tested: name entry, shops and yes/no prompts, and saving right after a
fast scene.

## How it works

Two guarded patches in the game's message routine (`0x80018B98`, main executable):

| Address | Stock | Patched | Effect |
|---|---|---|---|
| `0x80018C10` | `lh a0,472($gp)` | `addiu a0,zero,0` | no wait between characters |
| `0x80018C58` | `addiu v0,v0,1` | `addiu v0,v0,2` | two characters per step |

The drawing loop draws every character up to the revealed count, so a bigger step skips
nothing. How each address was found is in the comment block of [`mod.toml`](mod.toml).

## Changelog

- **0.1.1**: documented how to change the speed (comment only, same patches).
- **0.1.0**: first version, about 3x.

## License

[PolyForm Noncommercial 1.0.0](../../LICENSE). Unofficial fan project; contains no game data.
