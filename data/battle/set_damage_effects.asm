SetDamageEffects:
; moves that do damage but not through normal calculations
; e.g., Super Fang, etc
	db SUPER_FANG_EFFECT
	db SPECIAL_DAMAGE_EFFECT
	db -1 ; end
