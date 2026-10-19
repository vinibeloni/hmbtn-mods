# Save anywhere

**English** · [Português (Brasil)](README.pt-BR.md) · [← all mods](../../README.md)

Open the game's own diary **save** or **load** screen from the field, without going to bed.

Version 0.5.0 · for **Harvest Moon: Back to Nature (USA, SLUS-01115)** only.

## Controls

| Action | Gamepad | Default keyboard |
|---|---|---|
| Save | **L2 + R2** (hold both) | **E + R** |
| Load | **L1 + R1** (hold both) | **Q + W** |

The keyboard keys are the game's default bindings (`keybinds.ini`); if you rebound them,
use your own keys for L1, R1, L2 and R2.

## What to expect

- **Save** opens the game's normal memory card screen ("Select a MEMORY CARD slot"). You
  can abort it: "Aborting save. Is that OK?" → Yes, and you are back in the field.
- A save keeps the **time of day** and the **item in your hand**.
- **Load** opens the game's normal load screen. **It replaces the current game** with the
  diary you pick: anything since your last save is lost.
- After a load the game does **not** put you back where you saved. It plays its usual
  farmhouse wake-up scene: your character appears at the table and eats breakfast, then you
  get control back, holding the same item as when you saved. That meal is the game's own
  scene; the mod does not add it and does not skip it.
- Loading with L1 + R1 also turns the camera once, because L1 and R1 rotate it in the field.

## When it works

The combos only fire while you are free in the field. They are refused:

- during a dialogue or a cutscene (a save made during an event used to reload into that
  event's dialogue),
- while the Start menu is open.

They are **not** guarded on the "Now Loading" screen, so do not press them while the game
is loading.

## Install

1. Open [`mod.toml`](mod.toml) in this folder and click **Download raw file**.
2. Put it in a folder named `save-anywhere` inside `mods/hmbtn/` next to the game executable
   (create the folders if missing). You end up with `mods/hmbtn/save-anywhere/mod.toml`. No zip
   or release needed: the mod is that one file.
3. Restart the game. Mods are read when the game starts.

To remove it, delete the `save-anywhere` folder and restart. Requires the game build with
the mod engine (see the [main README](../../README.md#install)).

## Compatibility

USA disc, SLUS-01115, only. The mod writes to the game's RAM at fixed addresses; on another
version or region it would write to the wrong place and nothing can detect that.

Tested by the author in play: saving outdoors while holding an item, then loading it.
Not tested: saving late in the day.

## How it works

Both combos do what the game does itself: they write the words `SetMode` writes, the mode
word at `0x8005E39C` (7 = memory card save screen, 8 = load screen) and the word after it at
`0x8005E3A0` (set to 0). Each combo requires `0x80127208 == 1` (no dialogue or event) and
`0x800A072C == 0x18` (Start menu closed), and forbids the other combo's buttons so holding
all four fires neither. The full reasoning, with how each address was found, is in the
comment block of [`mod.toml`](mod.toml).

**Why not Select?** Select is the game's MAP button. In earlier versions the map opened when
the game came back from the load screen. L2 and R2 do nothing in the field (measured), and
L1 and R1 only rotate the camera.

## Changelog

- **0.5.0**: save is L2 + R2 and load is L1 + R1 (Select opened the map after a load).
- **0.4.0 and earlier**: save was Select + L1 and load was Select + R1; refused during events
  and with the Start menu open.

## License

[PolyForm Noncommercial 1.0.0](../../LICENSE). Unofficial fan project; contains no game data.
