#!/usr/bin/env python3
"""
One-shot tool to port animation bodies from an older version of
data/moves/animations.asm into the current file.

Strategy:
  1. Parse both files, extracting each `XxxAnim:` block (label + body
     up to the next blank line / next label / `; ===` divider).
  2. Normalise label names (lowercase, strip non-letters) to find
     matches across renames like ThunderShock vs Thundershock,
     PsyBeam vs Psybeam, CrabHammer vs Crabhammer.
  3. Print three lists for the human to review:
        - CONFIDENT matches (will be ported automatically)
        - BORDERLINE matches (similar but not identical normalisations,
          surface to human)
        - CURRENT-only labels (left untouched)
        - OLD-only labels (lost in port; informational)
  4. With --apply, rewrites the current file in place: for each
     confident match, replaces the body of the current label with the
     body from the old file (preserving the label line itself).

Borderline detection uses Levenshtein distance on the normalised name
(small edit distance + same length-ish). Anything ambiguous is flagged
not auto-applied.
"""

import argparse
import re
import sys
from pathlib import Path

OLD_PATH = Path("/mnt/d/Games/More Games/Pokemon/Pokemon Romhacks/Mine/Pokemon_Purple_Yellow - Notes/animations_duplicate.asm")
NEW_PATH = Path("/mnt/d/Games/More Games/Pokemon/Pokemon Romhacks/Mine/Pokemon_Purple_Yellow/data/moves/animations.asm")

LABEL_RE = re.compile(r"^([A-Z][A-Za-z0-9]+Anim):\s*$")


def parse_anims(path):
    """Return {label_name: (start_line, body_lines_including_label)}.

    A block runs from the label line until the next label, blank line
    that's followed by a divider/label, or end of file.
    """
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines(keepends=True)

    blocks = {}
    i = 0
    while i < len(lines):
        m = LABEL_RE.match(lines[i])
        if not m:
            i += 1
            continue
        label = m.group(1)
        start = i
        # Body extends until we hit another label OR a blank line
        # immediately followed by a comment divider / another label.
        # Keep it simple: include label line + following lines until
        # we hit either a blank line or the next label.
        body = [lines[i]]
        i += 1
        while i < len(lines):
            line = lines[i]
            if LABEL_RE.match(line):
                break
            if line.strip() == "":
                # blank line — body ends here (don't include the blank)
                break
            body.append(line)
            i += 1
        blocks[label] = (start, body)
    return blocks, lines


def normalise(name):
    """Lowercase, strip the trailing 'anim', strip non-alphanumerics.

    Keeps digits so labels like TradeBallAppear1 and TradeBallAppear2
    stay distinct.
    """
    n = name.lower()
    if n.endswith("anim"):
        n = n[:-4]
    return re.sub(r"[^a-z0-9]", "", n)


# Manual overrides for renames the auto-matcher can't safely infer.
# Maps NEW label -> OLD label.
MANUAL_OVERRIDES = {
    # Old had a typo "Daze" instead of "Dazzle". Same Fairy move.
    "DazzleGleamAnim": "DazeGleamAnim",
    # Volt Tackle is Pikachu's signature electric move; old called it
    # "Volt Attack". Same intended animation per project owner.
    "VoltTackleAnim": "VoltAttackAnim",
    # Old "Flex" was effectively today's Bulk Up (an Atk/Def-buff move).
    # Same intended animation per project owner.
    "BulkUpAnim": "FlexAnim",
}


def parse_move_animation_labels(lines):
    """Return the set of labels that are MOVE animations (not meta).

    Walks the AttackAnimationPointers table at the top of the file and
    collects every `dw XxxAnim` line up to (but not including) the
    `assert_table_length NUM_ATTACKS` marker. Anything after that line
    is a non-move animation (status overlays, ball tosses, trade
    cinematics, palette tricks, etc.) and we don't touch it — the
    project owner only wants to port move animation bodies.
    """
    move_labels = set()
    in_table = False
    for line in lines:
        s = line.strip()
        if s.startswith("AttackAnimationPointers:"):
            in_table = True
            continue
        if not in_table:
            continue
        if "assert_table_length NUM_ATTACKS" in s:
            break
        # Match `dw XxxAnim` (with possible comment after)
        m = re.match(r"dw\s+([A-Z][A-Za-z0-9]+Anim)\b", s)
        if m:
            move_labels.add(m.group(1))
    return move_labels


def levenshtein(a, b):
    if a == b:
        return 0
    if not a:
        return len(b)
    if not b:
        return len(a)
    prev = list(range(len(b) + 1))
    for i, ca in enumerate(a, 1):
        cur = [i]
        for j, cb in enumerate(b, 1):
            cost = 0 if ca == cb else 1
            cur.append(min(cur[-1] + 1, prev[j] + 1, prev[j - 1] + cost))
        prev = cur
    return prev[-1]


def find_matches(old_blocks, new_blocks):
    """Return (confident, borderline, new_only, old_only).

    confident: list of (new_label, old_label) where normalised names match.
    borderline: list of (new_label, old_label, distance) where distance
        is small but not zero.
    new_only: list of new_label values with no plausible old match.
    old_only: list of old_label values not used as a match.
    """
    old_norm = {normalise(l): l for l in old_blocks}
    new_norm = {normalise(l): l for l in new_blocks}

    confident = []
    new_only = []
    used_old = set()

    for nlabel in new_blocks:
        # Manual override takes precedence
        if nlabel in MANUAL_OVERRIDES:
            old_label = MANUAL_OVERRIDES[nlabel]
            if old_label in old_blocks:
                confident.append((nlabel, old_label))
                used_old.add(old_label)
                continue
        nn = normalise(nlabel)
        if nn in old_norm:
            old_label = old_norm[nn]
            confident.append((nlabel, old_label))
            used_old.add(old_label)
        else:
            new_only.append(nlabel)

    # Borderline: new_only items that have a close old match (distance <= 2)
    borderline = []
    still_new_only = []
    for nlabel in new_only:
        nn = normalise(nlabel)
        candidates = []
        for on, ol in old_norm.items():
            if ol in used_old:
                continue
            d = levenshtein(nn, on)
            if d <= 2 and abs(len(nn) - len(on)) <= 2:
                candidates.append((d, ol))
        if candidates:
            candidates.sort()
            best_d, best_ol = candidates[0]
            borderline.append((nlabel, best_ol, best_d))
        else:
            still_new_only.append(nlabel)

    old_only = [l for l in old_blocks if l not in used_old]
    # Remove old labels that show up in borderline (they may still get used)
    borderline_old = {ol for _, ol, _ in borderline}
    old_only = [l for l in old_only if l not in borderline_old]

    return confident, borderline, still_new_only, old_only


def apply_ports(new_lines, new_blocks, old_blocks, ports):
    """Rewrite new_lines in place by replacing bodies for each port.

    ports: list of (new_label, old_label) pairs.
    Returns the new list of lines.
    """
    # Build a mapping new_label -> (old_label, old_body_lines_excluding_label)
    # Keep new_label's own label line, replace following body with old body.
    edits = []  # list of (new_start, new_body_len, replacement_lines)
    for nlabel, olabel in ports:
        n_start, n_body = new_blocks[nlabel]
        _, o_body = old_blocks[olabel]
        # n_body[0] is label line; rest is body
        # Replacement: keep n_body[0], use o_body[1:] as the new body
        replacement = [n_body[0]] + o_body[1:]
        edits.append((n_start, len(n_body), replacement))

    # Apply edits in REVERSE order (so earlier indices stay valid)
    edits.sort(key=lambda e: e[0], reverse=True)
    out = list(new_lines)
    for start, length, repl in edits:
        out[start : start + length] = repl
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true",
                    help="Actually rewrite the new file. Without this, dry-run.")
    args = ap.parse_args()

    old_blocks, _ = parse_anims(OLD_PATH)
    new_blocks, new_lines = parse_anims(NEW_PATH)

    # Restrict to MOVE animations only — the project owner doesn't want
    # the ball-toss / trade / status / palette anims overwritten.
    move_labels = parse_move_animation_labels(new_lines)
    new_blocks_move = {l: b for l, b in new_blocks.items() if l in move_labels}

    print(f"Old file: {len(old_blocks)} anim blocks total")
    print(f"New file: {len(new_blocks)} anim blocks total")
    print(f"New file: {len(new_blocks_move)} of those are MOVE animations (the porting target)")
    print()

    confident, borderline, new_only, old_only = find_matches(old_blocks, new_blocks_move)

    print(f"=== {len(confident)} CONFIDENT matches (will port) ===")
    for nlabel, olabel in confident:
        marker = "" if nlabel == olabel else f"  (renamed from {olabel})"
        print(f"  {nlabel}{marker}")
    print()

    print(f"=== {len(borderline)} BORDERLINE matches (review needed) ===")
    for nlabel, olabel, d in borderline:
        print(f"  new:{nlabel:<28s}  old:{olabel:<28s}  edit_distance={d}")
    print()

    print(f"=== {len(new_only)} NEW-ONLY (no old match, will keep current placeholder) ===")
    for label in new_only:
        print(f"  {label}")
    print()

    print(f"=== {len(old_only)} OLD-ONLY (will be lost in port) ===")
    for label in old_only:
        print(f"  {label}")
    print()

    if args.apply:
        ports = list(confident)
        out_lines = apply_ports(new_lines, new_blocks, old_blocks, ports)
        NEW_PATH.write_text("".join(out_lines), encoding="utf-8")
        print(f"WROTE {NEW_PATH} with {len(ports)} ported anim bodies.")
    else:
        print("(dry-run; pass --apply to write the file)")


if __name__ == "__main__":
    main()
