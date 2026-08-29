PayDayEffect_:
	xor a
	ld hl, wcd6d
	ld [hli], a
	ldh a, [hWhoseTurn]
	and a
	ld a, [wBattleMonLevel]
	jr z, .payDayEffect
	ld a, [wEnemyMonLevel]
.payDayEffect
; level * 2 -- or, since v0.7 (his request 2026-08-28), level * 3 on a
; critical hit: the money gets the same x1.5 the damage got. The guard is
; on EXACTLY 1: the OHKO scaffolding parks $2/$ff in wCriticalHitOrOHKO
; and must not pay. 3xL overflows a byte above L85, so the carry crosses
; into the 16-bit dividend (Divide already runs 4-byte, b=$4).
	ld b, a ; b = level
	add a ; a = level * 2 (max 200, never carries)
	ld c, a
	ld a, [wCriticalHitOrOHKO]
	dec a ; exactly 1? (dec leaves carry alone)
	ld a, c
	jr nz, .noCritBonus
	add b ; a = level * 3; sets carry above L85
.noCritBonus
	ldh [hDividend + 3], a
	ld a, 0 ; NOT xor -- the carry must survive to the adc
	adc a ; a = the carry, 0 or 1
	ldh [hDividend + 2], a
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
; convert to BCD
	ld a, 100
	ldh [hDivisor], a
	ld b, $4
	call Divide
	ldh a, [hQuotient + 3]
	ld [hli], a
	ldh a, [hRemainder]
	ldh [hDividend + 3], a
	ld a, 10
	ldh [hDivisor], a
	ld b, $4
	call Divide
	ldh a, [hQuotient + 3]
	swap a
	ld b, a
	ldh a, [hRemainder]
	add b
	ld [hl], a
	ld de, wTotalPayDayMoney + 2
	ld c, $3
	predef AddBCDPredef
	ld hl, CoinsScatteredText
	jp PrintText

CoinsScatteredText:
	text_far _CoinsScatteredText
	text_end
