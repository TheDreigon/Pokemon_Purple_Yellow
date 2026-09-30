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
	ld a, 1 ; suppress the stat-up animation (ours already played)
.raiseAccuracy ; v1.0 (F2): a = the E5 flag - 1 here, 0 from .alreadyUsing
	ld [wMoveDidntMiss], a
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
	push de
	ld a, ACCURACY_UP1_EFFECT
	ld [de], a
	farcall StatModifierUpEffect
	pop de
	ld a, FOCUS_ENERGY_EFFECT
	ld [de], a
	ret
.alreadyUsing
; v1.0 (F2, 2026-09-30; Forte: "sim, ainda podemos o ter o accuracy a subir caso consiga"):
; already pumped (its own FOCUS ENERGY or a DIRE HIT: one bit, x3 once, it never stacks), the
; crit half is refused and says so, and the ACCURACY +1 still runs - refused only at +6, where
; StatModifierUpEffect says "won't go any higher!" - as BULK UP at ATTACK +6 still raises its
; DEFENSE. It used to fail whole and lose that raise. Both sides (hWhoseTurn).
	ld c, 50
	call DelayFrames
	; v0.7: FE-specific failure text instead of the generic "But, it failed!"
	ld hl, AlreadyBoostedText
	call PrintText
	xor a ; no animation yet: StatModifierUpEffect plays FOCUS ENERGY's if ACCURACY rises (E5)
	jr .raiseAccuracy

GettingPumpedText:
	text_pause
	text_far _GettingPumpedText
	text_end

AlreadyBoostedText:
	text_far _FocusEnergyAlreadyText
	text_end
