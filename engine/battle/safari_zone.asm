PrintSafariZoneBattleText:
	ld hl, wSafariBaitFactor
	ld a, [hl]
	and a
	jr z, .no_bait
	dec [hl]
	ld hl, SafariZoneEatingText
	jr .done
.no_bait
	dec hl
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld hl, SafariZoneAngryText
	jr nz, .done
; v0.7 catch rework: nothing to restore here any more. The ROCK stopped
; touching wEnemyMonActualCatchRate -- it raises the SAFARI BALL's own
; multiplier instead -- and this counter reaching zero is what ends that.
.done
	push hl
	call LoadScreenTilesFromBuffer1
	pop hl
	jp PrintText

SafariZoneEatingText:
	text_far _SafariZoneEatingText
	text_end

SafariZoneAngryText:
	text_far _SafariZoneAngryText
	text_end
