FocusEnergyEffect_:
	ld hl, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .notEnemy
	ld hl, wEnemyBattleStatus2
.notEnemy
	bit GETTING_PUMPED, [hl] ; is mon already using focus energy?
	jr nz, .alreadyUsing
	set GETTING_PUMPED, [hl] ; mon is now using focus energy
	callfar PlayCurrentMoveAnimation
	ld hl, GettingPumpedText
	call PrintText
; v0.7: Focus Energy also raises the user's Accuracy by one stage (crit
; boost + Acc+1). Same spoof pattern as the dual-stat handlers in
; effects.asm: point the move-effect var at ACCURACY_UP1_EFFECT and run the
; generic stat-up handler — it reads the effect id from WRAM, so it is safe
; to reach via farcall. Restore FOCUS_ENERGY_EFFECT afterwards.
	ldh a, [hWhoseTurn]
	ld de, wPlayerMoveEffect
	and a
	jr z, .gotEffectPtr
	ld de, wEnemyMoveEffect
.gotEffectPtr
	ld a, 1
	ld [wMoveDidntMiss], a ; suppress the stat-up animation (ours already played)
	push de
	ld a, ACCURACY_UP1_EFFECT
	ld [de], a
	farcall StatModifierUpEffect
	pop de
	ld a, FOCUS_ENERGY_EFFECT
	ld [de], a
	ret
.alreadyUsing
	ld c, 50
	call DelayFrames
	jpfar PrintButItFailedText_

GettingPumpedText:
	text_pause
	text_far _GettingPumpedText
	text_end
