ApplyOutOfBattlePoisonDamage:
	ld a, [wd730]
	add a
	jp c, .noBlackOut ; no black out if joypad states are being simulated
	ld a, [wd492]
	bit 7, a
	jp nz, .noBlackOut
	ld a, [wd72e]
	bit 6, a
	jp nz, .noBlackOut
	ld a, [wPartyCount]
	and a
	jp z, .noBlackOut
	call IncrementDayCareMonExp
	call Func_c4c7
	ld a, [wStepCounter]
	and $3 ; is the counter a multiple of 4?
	jr nz, .skipPoisonEffectAndSound ; only apply poison damage every fourth step
; v1.0 (2026-11-11): the damage, its texts, the flash and the sound are
; StepToxicTick's (engine/events/toxic_step.asm, bank $10): only a bad POISON bites
; out of battle now, and in Normal it stops at 1 HP and is over. The two loops that
; were here needed more room than this bank has.
	farcall StepToxicTick
.skipPoisonEffectAndSound
	predef AnyPartyAlive
	ld a, d
	and a
	jr nz, .noBlackOut
	call EnableAutoTextBoxDrawing
	ld a, TEXT_BLACKED_OUT
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72e
	set 5, [hl]
	ld a, $ff
	jr .done
.noBlackOut
	xor a
.done
	ld [wOutOfBattleBlackout], a
	ret

Func_c4c7:
	ld a, [wStepCounter]
	and a
	jr nz, .asm_c4de
	call Random
	and $1
	jr z, .asm_c4de
	calladb_ModifyPikachuHappiness $6
.asm_c4de
	ld hl, wPikachuMood
	ld a, [hl]
	cp $80
	jr z, .asm_c4ef
	jr c, .asm_c4ea
	dec a
	dec a
.asm_c4ea
	inc a
	ld [hl], a
	cp $80
	ret nz
.asm_c4ef
	xor a
	ld [wd49c], a
	ret
