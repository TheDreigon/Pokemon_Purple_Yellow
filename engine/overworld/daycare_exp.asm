IncrementDayCareMonExp:
	ld a, [wDayCareInUse]
	and a
	ret z
	call .step
; Forte, 2026-08-07: with the CHAMPION as a customer the day care doubles
; its care -- two exp per step once the Hall of Fame is signed. The call
; above plus the fall-through below is the second increment.
	ld a, [wGameStage]
	and a
	ret z
.step
	ld hl, wDayCareMonExp + 2
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ld a, [hl]
	cp $50
	ret c
	ld a, $50
	ld [hl], a
	ret
