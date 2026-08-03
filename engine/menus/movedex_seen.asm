; The half of the MOVEDEX "seen" bitfield that only the MOVEDEX ever calls.
;
; It lives here rather than in the home bank because ROM0 is the tightest space
; in the project and none of this is needed from battle: MarkMoveSeenByID, the
; one routine that is, stays in home/movedex_seen.asm.

ASSERT NUM_ATTACKS % 8 != 0, "CountMovedexSeen's mask assumes the last wMovedexSeen byte is partial"

; Test move id a. Returns z if the move has NOT been seen.
; Preserves bc, de and hl.
IsMoveSeen::
	and a
	ret z
	cp NUM_ATTACKS + 1
	jr nc, .unseen
	push bc
	push de
	push hl
	dec a
	ld c, a
	ld b, FLAG_TEST
	ld hl, wMovedexSeen
	predef FlagActionPredef
	ld a, c
	pop hl
	pop de
	pop bc
	and a
	ret
.unseen
	xor a
	ret

; Every move the player's own party knows counts as seen.
;
; This is the same courtesy the POKéDEX already extends to a gift Pokémon, which
; counts as owned before you have ever seen one in the wild. Without it the
; MOVEDEX would be blank for precisely the move a player wants to look up before
; spending a TM on it.
;
; Called when the MOVEDEX opens rather than on every learn/trade/evolve/TM path,
; so there is no way to put a move into the party that this can miss.
;
; The party only, not the boxes: a boxed Pokemon is not with you, and the moment
; you withdraw it its moves are counted. The boxes other than the current one
; live in SRAM and would need bank switching to read.
MarkPartyMovesSeen::
	ld a, [wPartyCount]
	and a
	ret z
	ld b, a
	ld hl, wPartyMon1Moves
.monLoop
	push bc
	push hl
	ld c, NUM_MOVES
.moveLoop
	ld a, [hli]
	push bc
	push hl
	call MarkMoveSeenByID
	pop hl
	pop bc
	dec c
	jr nz, .moveLoop
	pop hl
	ld de, wPartyMon2 - wPartyMon1
	add hl, de
	pop bc
	dec b
	jr nz, .monLoop
	ret

; Number of moves seen, in a.
CountMovedexSeen::
; A save written before this feature had other things at these addresses, so the
; unused top bits of the last byte can carry junk that would count as moves which
; do not exist. Clear them once, here, where the number is about to be shown.
	ld hl, wMovedexSeenEnd - 1
	ld a, [hl]
	and (1 << (NUM_ATTACKS % 8)) - 1
	ld [hl], a
	ld hl, wMovedexSeen
	ld b, wMovedexSeenEnd - wMovedexSeen
	call CountSetBits
	ld a, [wNumSetBits]
	ret
