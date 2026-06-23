#!/usr/bin/env python3
"""
One-shot tool to port move SFX assignments from an older version of
data/moves/sfx.asm into the current file (which currently has SFX_POUND
as a placeholder for every move).

Strategy:
  1. Parse both files. Each line has the form:
        db SFX_X, pitch, tempo ; MOVE_NAME
     The move name is in the comment after `; `.
  2. Match by MOVE_NAME with normalisation (case-insensitive, strip
     non-alphanumerics) plus a small manual-override table for renames
     (VOLT_ATTACK -> VOLT_TACKLE, FLEX -> BULK_UP, DAZE_GLEAM ->
     DAZZLE_GLEAM, mirroring the animation port).
  3. For each match, substitute the SFX line in the new file.
  4. New-only moves (no equivalent in the old file) get a speculative
     SFX from a hand-picked SPECULATIONS table — modelled on the
     closest existing move's sound (same idea as the speculation
     bodies in animations.asm).
  5. Old-only moves are reported but not used.

Use --apply to write the new file in place; without it, dry-run.
"""

import argparse
import re
from pathlib import Path

OLD_PATH = Path("/mnt/d/Games/More Games/Pokemon/Pokemon Romhacks/Mine/Pokemon_Purple_Yellow _old/data/moves/sfx_duplicate.asm")
NEW_PATH = Path("/mnt/d/Games/More Games/Pokemon/Pokemon Romhacks/Mine/Pokemon_Purple_Yellow/data/moves/sfx.asm")

# Each row matches `\tdb SFX_X, $pp, $tt ; MOVE_NAME`. Capture the
# whole left side (db SFX..., pitch, tempo) plus the comment name.
LINE_RE = re.compile(
    r"^(\s*db\s+\S+\s*,\s*\$[0-9a-fA-F]+\s*,\s*\$[0-9a-fA-F]+)\s*;\s*([A-Z][A-Z0-9_]*)\s*$"
)

# Manual renames: NEW_MOVE -> OLD_MOVE (the old project's name).
MANUAL_OVERRIDES = {
    "DAZZLE_GLEAM": "DAZE_GLEAM",
    "VOLT_TACKLE":  "VOLT_ATTACK",
    "BULK_UP":      "FLEX",
}

# Speculative SFX for moves that didn't exist in the old project. Each
# entry is the full RHS of a `db ...` line (no leading tab, no comment).
# Modelled on the closest existing move's sound, with small pitch/tempo
# tweaks where it improves the feel.
SPECULATIONS = {
    # FUNGUS
    "SPORE_DAZE":   "db SFX_BATTLE_1C,          $11, $a0", # powder, like Spore
    "PARASITE":     "db SFX_BATTLE_24,          $40, $80", # drain, like Mega Drain
    # GHOST
    "WILL_O_WISP":  "db SFX_BATTLE_19,          $40, $a0", # ghostly flame, like Ember
    # POISON
    "TOXIC_FANGS":  "db SFX_BATTLE_1B,          $20, $80", # fang+poison, like Poison Fang
    # ROCK
    "HEAD_SMASH":   "db SFX_BATTLE_18,          $20, $a0", # head impact, like Headbutt but heavier
    # BIRD (new status)
    "FIERCE_ROAR":  "db SFX_BATTLE_0B,          $10, $a0", # roar, like Growl + lower pitch
    # FIRE
    "IGNITE":       "db SFX_BATTLE_19,          $00, $80", # fire startup, like Ember
    # FIGHTING
    "MACH_PUNCH":   "db SFX_BATTLE_0C,          $20, $40", # fast punch, like Karate Chop sped up
    "SKY_UPPERCUT": "db SFX_BATTLE_0C,          $00, $a0", # uppercut, like Karate Chop
}


def parse_sfx(path):
    """Return (lines, {MOVE_NAME -> (line_index, rhs_template)}).

    rhs_template is the captured `db SFX_X, $pp, $tt` substring (no
    comment) from the line, ready for substitution into the new file.
    lines is the full file (so we can rewrite it later).
    """
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines(keepends=True)
    by_name = {}
    for i, raw in enumerate(lines):
        m = LINE_RE.match(raw.rstrip("\n"))
        if not m:
            continue
        rhs = m.group(1).strip()  # `db SFX_X, $pp, $tt`
        name = m.group(2)
        by_name[name] = (i, rhs)
    return lines, by_name


def normalise(name):
    return re.sub(r"[^a-z0-9]", "", name.lower())


def find_match(new_name, old_by_name):
    """Return the matching OLD entry name for a NEW move name, or None."""
    if new_name in MANUAL_OVERRIDES:
        candidate = MANUAL_OVERRIDES[new_name]
        if candidate in old_by_name:
            return candidate
    if new_name in old_by_name:
        return new_name
    nn = normalise(new_name)
    for old_name in old_by_name:
        if normalise(old_name) == nn:
            return old_name
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true",
                    help="Actually rewrite the new file. Without this, dry-run.")
    args = ap.parse_args()

    old_lines, old_by_name = parse_sfx(OLD_PATH)
    new_lines, new_by_name = parse_sfx(NEW_PATH)

    print(f"Old file: {len(old_by_name)} move SFX entries")
    print(f"New file: {len(new_by_name)} move SFX entries")
    print()

    confident = []      # (new_name, old_name)
    speculations_used = []
    new_only = []
    used_old = set()

    for new_name in new_by_name:
        old_name = find_match(new_name, old_by_name)
        if old_name is not None:
            confident.append((new_name, old_name))
            used_old.add(old_name)
        elif new_name in SPECULATIONS:
            speculations_used.append(new_name)
        else:
            new_only.append(new_name)

    old_only = [n for n in old_by_name if n not in used_old]

    print(f"=== {len(confident)} CONFIDENT matches ===")
    for nname, oname in confident:
        marker = "" if nname == oname else f"  (renamed from {oname})"
        print(f"  {nname}{marker}")
    print()
    print(f"=== {len(speculations_used)} SPECULATIONS (new-only with hand-picked SFX) ===")
    for n in speculations_used:
        print(f"  {n}: {SPECULATIONS[n]}")
    print()
    print(f"=== {len(new_only)} NEW-ONLY without speculation (placeholder kept) ===")
    for n in new_only:
        print(f"  {n}")
    print()
    print(f"=== {len(old_only)} OLD-ONLY (lost in port) ===")
    for n in old_only:
        print(f"  {n}")
    print()

    if not args.apply:
        print("(dry-run; pass --apply to write the file)")
        return

    # --- Write substitutions ---
    out = list(new_lines)
    edits = 0

    for new_name, old_name in confident:
        new_idx, _ = new_by_name[new_name]
        _, old_rhs = old_by_name[old_name]
        line = out[new_idx]
        # Preserve the leading whitespace and the trailing comment.
        m = LINE_RE.match(line.rstrip("\n"))
        if not m:
            print(f"  WARN: line {new_idx} unexpectedly didn't re-match for {new_name}, skipping")
            continue
        leading_ws = line[: line.index("db")]
        new_line = f"{leading_ws}{old_rhs} ; {new_name}\n"
        out[new_idx] = new_line
        edits += 1

    for new_name in speculations_used:
        new_idx, _ = new_by_name[new_name]
        line = out[new_idx]
        leading_ws = line[: line.index("db")]
        new_line = f"{leading_ws}{SPECULATIONS[new_name]} ; {new_name}\n"
        out[new_idx] = new_line
        edits += 1

    NEW_PATH.write_text("".join(out), encoding="utf-8")
    print(f"WROTE {NEW_PATH} with {edits} ported SFX rows.")


if __name__ == "__main__":
    main()
