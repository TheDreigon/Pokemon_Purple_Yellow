SetDamageEffects:
; moves that do damage but not through normal calculations
; e.g., Super Fang, Seismic Toss
	db SUPER_FANG_EFFECT
	db TARGET_LEVEL_DAMAGE_EFFECT
	db USER_LEVEL_DAMAGE_EFFECT
	db SET_DAMAGE_EFFECT
	db -1 ; end
