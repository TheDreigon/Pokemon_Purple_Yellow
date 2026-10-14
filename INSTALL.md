# Building Pokémon Purple Yellow

These steps build the ROMs from the source. Playing the game needs none of this: apply the release patch (the
`.bps` on the Releases page) to your own Pokémon Yellow ROM instead.


## What you need

- `make`, `gcc` and `git`. On Windows, use [WSL](https://learn.microsoft.com/windows/wsl/install) and follow the
  steps for Linux inside it.
- [rgbds](https://rgbds.gbdev.io/install) **0.6.1**, exactly: the
  [0.6.1 release](https://github.com/gbdev/rgbds/releases/tag/v0.6.1), or built from that tag. `rgbdscheck.asm`
  accepts rgbds 0.6.0 and newer, but only 0.6.1 is known to build the published ROMs byte for byte (rgbds 1.0.0,
  for one, stops at `rgbdscheck.asm`).
- Python 3, for `make bps` only (the standard library is enough).


## Get the source

```bash
git clone https://github.com/TheDreigon/Pokemon_Purple_Yellow.git
cd Pokemon_Purple_Yellow
```


## Where the Makefile finds rgbds

If `rgbds/rgbasm` exists, the Makefile runs `rgbasm`, `rgblink`, `rgbfix` and `rgbgfx` from the `rgbds/` folder
(it is gitignored: copy the four 0.6.1 programs there). Otherwise it runs the ones on your PATH. To use another
folder:

```bash
make RGBDS=path/to/rgbds-0.6.1/
```


## Build

```bash
make                # both ROMs
make yellow         # pokeyellow.gbc only
make yellow_debug   # pokeyellow_debug.gbc only
make clean          # remove the ROMs, the objects and the converted graphics
```

- `pokeyellow.gbc` is the release ROM.
- `pokeyellow_debug.gbc` is the same game with the debug menu (hold SELECT on the title screen).

`make compare` checks both ROMs against `roms.sha1`, which holds the hashes of the last release: a build of a
release tag passes it.


## The release patch

```bash
make bps BASEROM=path/to/your/rom.gbc
```

writes `pokeyellow.bps`, the patch from the retail English Pokémon Yellow:

- Pokemon - Yellow Version - Special Pikachu Edition (USA, Europe) (CGB+SGB Enhanced)
- SHA-1 `cc7d03262ebfaf2f06772c1a480c7d9d5f4a38e1`

Any other base file is refused, and the patch is written only once it decodes back to `pokeyellow.gbc` byte for
byte. `python3 tools/make_bps.py` also applies a patch (`apply`) and checks one (`verify`).


## Not supported

`make yellow_vc` (pret's patch for the 3DS Virtual Console) does not build: the files under `vc/` are left as they
came from pret.
