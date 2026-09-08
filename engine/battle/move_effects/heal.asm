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
	jr nz, .passed
; v1.0 (2026-09-08, Forte): the user's HP is full. RECOVER and SOFTBOILED clear
; the user's status now, so with a status to clear they still work (cure only,
; no "regained health" line); everything else fails here as it always did.
	ld a, b
	cp RECOVER
	jr z, .fullHPCureOnly
	cp SOFTBOILED
	jr z, .fullHPCureOnly
	jp .failed ; no effect if user's HP is already at its maximum
.fullHPCureOnly
	call .userStatusPtr
	ld a, [hl]
	and a
	jp z, .failed
	ld c, 50
	call DelayFrames
	xor a
	ld [hl], a
	farcall PlayCurrentMoveAnimation
	ld hl, RegainedStatusText
	jp PrintText
.userStatusPtr
; hl = the user's status byte
	ld hl, wBattleMonStatus
	ldh a, [hWhoseTurn]
	and a
	ret z
	ld hl, wEnemyMonStatus
	ret
.passed
	ld a, b
	cp REST
	jr z, .restPath
	cp SOFTBOILED
	jr z, .softboiledPath
	cp RECOVER
	jr z, .recoverPath
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
.recoverPath
; v1.0 (2026-09-08, Forte): RECOVER also clears the user's status - a move slot
; that only did half a HYPER POTION was rarely worth carrying. Heal still /2.
	call .clearUserStatus
	or 1 ; ensure NZ so .healHP runs the /2 divide
	jr .healHP
.softboiledPath
; v0.6: Softboiled also clears the user's status (no sleep).
; v1.0 (2026-09-08): and heals 3/4 of max HP instead of 1/2, so CHANSEY keeps a
; signature now that RECOVER clears status too.
	call .clearUserStatus
	jr .softboiledDivide
.clearUserStatus
; clears the user's status if it has one and says so; de and hl preserved
	push hl
	push de
	ld c, 50
	call DelayFrames
	call .userStatusPtr
	ld a, [hl]
	and a
	jr z, .noStatusToClear ; nothing to clear; skip the refreshed line
	xor a
	ld [hl], a ; clear status
	ld hl, RegainedStatusText
	call PrintText
.noStatusToClear
	pop de
	pop hl
	ret
.growthDivide
; v0.6: GROWTH (effect ATTACK_SPATK_UP1_HEAL_EFFECT) calls into HealEffect_ for the
; heal portion only, with a 1/4 max HP divisor. SPC+1 happens in the wrapper
; handler (AttackSpAtkUp1HealEffect in effects.asm), which sets wMoveDidntMiss=1
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
.softboiledDivide
; v1.0 (2026-09-08): bc = maxHP - maxHP / 4 = 3/4 of max HP. de (the HP
; pointer) is live here, so the quarter is computed in a saved copy.
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld c, a
	ld a, [hl]
	ld [wHPBarMaxHP+1], a
	ld b, a
	push de
	ld d, b
	ld e, c
	srl d
	rr e
	srl d
	rr e ; de = maxHP / 4
	ld a, c
	sub e
	ld c, a
	ld a, b
	sbc d
	ld b, a ; bc = maxHP - maxHP / 4
	pop de
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
; v0.6: AttackSpAtkUp1HealEffect (Growth) sets wMoveDidntMiss=1 before farcalling
; HealEffect_, so this skip avoids re-playing the move anim that the SPC+1 leg
; already played. Other callers (Recover/Rest/Softboiled) leave the flag at 0.
	ld a, [wMoveDidntMiss]
	and a
	jr nz, .skipMoveAnim
; v0.7: PlayCurrentMoveAnimation moved to the Battle Effects bank;
; EffectCallBattleCore switches to the hardcoded BANK(BattleCore) and would
; jump into garbage. farcall recomputes the real bank.
	farcall PlayCurrentMoveAnimation
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
; v0.7: PrintButItFailedText_ moved to the Battle Effects bank, and
; EffectCallBattleCore switches to a HARDCODED BANK(BattleCore) before the
; jump -- it would land on garbage. farjp recomputes the target's real bank.
	farjp PrintButItFailedText_

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
