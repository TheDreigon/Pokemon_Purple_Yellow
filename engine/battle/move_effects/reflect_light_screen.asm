ReflectLightScreenEffect_:
	ld hl, wPlayerBattleStatus3
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .reflectLightScreenEffect
	ld hl, wEnemyBattleStatus3
	ld de, wEnemyMoveEffect
.reflectLightScreenEffect
	ld a, [de]
	cp LIGHT_SCREEN_EFFECT
	jr nz, .reflect
	bit HAS_LIGHT_SCREEN_UP, [hl] ; is mon already protected by light screen?
	jr nz, .moveFailed
	set HAS_LIGHT_SCREEN_UP, [hl] ; mon is now protected by light screen
	ld hl, LightScreenProtectedText
	jr .playAnim
.reflect
	bit HAS_REFLECT_UP, [hl] ; is mon already protected by reflect?
	jr nz, .moveFailed
	set HAS_REFLECT_UP, [hl] ; mon is now protected by reflect
	ld hl, ReflectGainedArmorText
.playAnim
	push hl
; v0.7: PlayCurrentMoveAnimation moved to the Battle Effects bank; the fixed
; BANK(BattleCore) dispatch would jump into garbage. farcall recomputes, and
; the text pointer this routine is carrying survives in the push above.
	farcall PlayCurrentMoveAnimation
	pop hl
	jp PrintText
.moveFailed
	ld c, 50
	call DelayFrames
; v0.7: PrintButItFailedText_ moved to the Battle Effects bank, and
; EffectCallBattleCore switches to a HARDCODED BANK(BattleCore) before the
; jump -- it would land on garbage. farjp recomputes the target's real bank.
	farjp PrintButItFailedText_

LightScreenProtectedText:
	text_far _LightScreenProtectedText
	text_end

ReflectGainedArmorText:
	text_far _ReflectGainedArmorText
	text_end

EffectCallBattleCore:
	ld b, BANK(BattleCore)
	jp Bankswitch
