PrintStatusAilment::
	ld a, [de]
	bit PSN, a
	jr nz, .psn
	bit BRN, a
	jr nz, .brn
	bit FRZ, a
	jr nz, .frz
	bit PAR, a
	jr nz, .par
	and SLP_MASK
	jr nz, .slp
; v1.0 (2026-11-18): no hard status. In a battle a #MON of the player's party that bleeds says BLD
; (MenuMonBleeding, engine/battle/soft_status.asm: the party slot the menu is drawing, read from its
; battle conditions byte); otherwise Z and nothing written, as before (the STATS page then writes "OK").
	push de
	push hl
	farcall MenuMonBleeding
	pop hl
	pop de
	ret z
	ld a, "B" ; (ld keeps the NZ)
	ld [hli], a
	ld a, "L"
	ld [hli], a
	ld [hl], "D"
	ret
.slp
	ld a, "S"
	ld [hli], a
	ld a, "L"
	ld [hli], a
	ld [hl], "P"
	ret
.psn
	ld a, "P"
	ld [hli], a
	ld a, "S"
	ld [hli], a
	ld [hl], "N"
	ret
.brn
	ld a, "B"
	ld [hli], a
	ld a, "R"
	ld [hli], a
	ld [hl], "N"
	ret
.frz
	ld a, "F"
	ld [hli], a
	ld a, "R"
	ld [hli], a
	ld [hl], "Z"
	ret
.par
	ld a, "P"
	ld [hli], a
	ld a, "A"
	ld [hli], a
	ld [hl], "R"
	ret
