HealEffect_:
	ldh a, [hWhoseTurn]
	and a
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	ld a, [wPlayerMoveNum]
	jr z, .healEffect
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	ld a, [wEnemyMoveNum]
.healEffect
	ld b, a
	ld a, [de]
	cp [hl]
	inc de
	inc hl
	jr nz, .passed
	ld a, [de]
	sbc [hl]
	jp z, .failed ; no effect if user's HP is already at its maximum
.passed
	ld a, b
	cp REST
	jr z, .restPath
	cp SOFTBOILED
	jr z, .softboiledPath
	cp GROWTH
	jr z, .growthDivide
	jr .healHP
.restPath
	push hl
	push de
	push af
	ld c, 50
	call DelayFrames
	ld hl, wBattleMonStatus
	ldh a, [hWhoseTurn]
	and a
	jr z, .restEffect
	ld hl, wEnemyMonStatus
.restEffect
	ld a, [hl]
	and a
	ld [hl], 2 ; clear status and set number of turns asleep to 2
	ld hl, StartedSleepingEffect ; if mon didn't have an status
	jr z, .printRestText
	ld hl, FellAsleepBecameHealthyText ; if mon had an status
.printRestText
	call PrintText
	pop af
	pop de
	pop hl
	jr .healHP
.softboiledPath
; v0.6: Softboiled also clears the user's status (no sleep). Heal still /2.
	push hl
	push de
	ld c, 50
	call DelayFrames
	ld hl, wBattleMonStatus
	ldh a, [hWhoseTurn]
	and a
	jr z, .softboiledStatusPtr
	ld hl, wEnemyMonStatus
.softboiledStatusPtr
	ld a, [hl]
	and a
	jr z, .softboiledNoStatus ; nothing to clear; skip refreshed message
	xor a
	ld [hl], a ; clear status
	push de
	ld hl, RegainedStatusText
	call PrintText
	pop de
.softboiledNoStatus
	pop de
	pop hl
	or 1 ; ensure NZ so .healHP runs the /2 divide
	jr .healHP
.growthDivide
; v0.6: GROWTH (effect SPECIAL_UP1_HEAL_EFFECT) calls into HealEffect_ for the
; heal portion only, with a 1/4 max HP divisor. SPC+1 happens in the wrapper
; handler (SpecialUp1HealEffect in effects.asm), which sets wMoveDidntMiss=1
; before this farcall to suppress the move-anim replay in .playAnim below.
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld c, a
	ld a, [hl]
	ld [wHPBarMaxHP+1], a
	ld b, a
	srl b
	rr c
	srl b
	rr c ; bc = maxHP / 4
	jr .gotHPAmountToHeal
.healHP
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld c, a
	ld a, [hl]
	ld [wHPBarMaxHP+1], a
	ld b, a
	jr z, .gotHPAmountToHeal
; Recover and Softboiled only heal for half the mon's max HP
	srl b
	rr c
.gotHPAmountToHeal
; update HP
	ld a, [de]
	ld [wHPBarOldHP], a
	add c
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
	ld a, [de]
	ld [wHPBarOldHP+1], a
	adc b
	ld [de], a
	ld [wHPBarNewHP+1], a
	inc hl
	inc de
	ld a, [de]
	dec de
	sub [hl]
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .playAnim
; copy max HP to current HP if an overflow occurred
	ld a, [hli]
	ld [de], a
	ld [wHPBarNewHP+1], a
	inc de
	ld a, [hl]
	ld [de], a
	ld [wHPBarNewHP], a
.playAnim
; v0.6: SpecialUp1HealEffect (Growth) sets wMoveDidntMiss=1 before farcalling
; HealEffect_, so this skip avoids re-playing the move anim that the SPC+1 leg
; already played. Other callers (Recover/Rest/Softboiled) leave the flag at 0.
	ld a, [wMoveDidntMiss]
	and a
	jr nz, .skipMoveAnim
	ld hl, PlayCurrentMoveAnimation
	call EffectCallBattleCore
.skipMoveAnim
	ldh a, [hWhoseTurn]
	and a
	hlcoord 10, 9
	ld a, $1
	jr z, .updateHPBar
	hlcoord 2, 2
	xor a
.updateHPBar
	ld [wHPBarType], a
	predef UpdateHPBar2
	ld hl, DrawHUDsAndHPBars
	call EffectCallBattleCore
	ld hl, RegainedHealthText
	jp PrintText
.failed
	ld c, 50
	call DelayFrames
	ld hl, PrintButItFailedText_
	jp EffectCallBattleCore

StartedSleepingEffect:
	text_far _StartedSleepingEffect
	text_end

FellAsleepBecameHealthyText:
	text_far _FellAsleepBecameHealthyText
	text_end

RegainedHealthText:
	text_far _RegainedHealthText
	text_end

RegainedStatusText:
	text_far _RegainedStatusText
	text_end
