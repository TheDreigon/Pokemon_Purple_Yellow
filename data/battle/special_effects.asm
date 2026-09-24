SpecialEffects:
; Effects from arrays 2, 4, and 5B, minus Twineedle.
; Includes all effects that do not need to be called at the end of
; ExecutePlayerMove (or ExecuteEnemyMove), because they have already been handled
	db DRAIN_HP_EFFECT
	db EXPLODE_EFFECT
	db DREAM_EATER_EFFECT
	db PAY_DAY_EFFECT
	db SWIFT_EFFECT
	db TWO_TO_FIVE_ATTACKS_EFFECT
	db EFFECT_1E
	db CHARGE_EFFECT
	db SUPER_FANG_EFFECT
	db TARGET_LEVEL_DAMAGE_EFFECT
	db USER_LEVEL_DAMAGE_EFFECT
	db SET_DAMAGE_EFFECT
	db FLY_EFFECT
	db ATTACK_TWICE_EFFECT
	db JUMP_KICK_EFFECT
	db RECOIL_EFFECT
	db HYPER_BEAM_EFFECT ; v1.0 (2026-09-24): runs from AlwaysHappenSideEffects now - listed here so .executeOtherEffects does not run it a second time
	; fallthrough
SpecialEffectsCont:
; damaging moves whose effect is executed prior to damage calculation
	db THRASH_PETAL_DANCE_EFFECT
	db TRAPPING_EFFECT
	db -1 ; end
