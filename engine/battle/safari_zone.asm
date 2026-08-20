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
; v0.7 catch rework: there is nothing to restore here any more, and the branch
; that used to skip the restore is gone with it (it had become `jr nz` to the
; very next instruction). The ROCK stopped touching wEnemyMonActualCatchRate --
; it raises the SAFARI BALL's own multiplier instead, which GetCatchBallDivisor
; reads off wSafariEscapeFactor -- so this counter reaching zero IS the expiry.
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
