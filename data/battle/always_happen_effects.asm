AlwaysHappenSideEffects:
; Attacks that aren't finished after they faint the opponent.
	db DRAIN_HP_EFFECT
	db EXPLODE_EFFECT
	db DREAM_EATER_EFFECT
	db PAY_DAY_EFFECT
	db TWO_TO_FIVE_ATTACKS_EFFECT
	db HYPER_BEAM_EFFECT ; v1.0 (2026-09-24): the recharge is owed even when the target faints or its SUBSTITUTE breaks
	db EFFECT_1E
	db ATTACK_TWICE_EFFECT
	db RECOIL_EFFECT
	db TWINEEDLE_EFFECT
	db -1 ; end
