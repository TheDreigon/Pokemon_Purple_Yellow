ResidualEffects2:
; non-side effects not included in ResidualEffects1
; stat-affecting moves, sleep-inflicting moves, and Bide
; e.g., Meditate, Bide, Hypnosis
	db EFFECT_01
	db ATTACK_UP1_EFFECT
	db DEFENSE_UP1_EFFECT
	db SPEED_UP1_EFFECT
	db SPECIAL_UP1_EFFECT
	db ACCURACY_UP1_EFFECT
	db EVASION_UP1_EFFECT
	db ATTACK_DOWN1_EFFECT
	db DEFENSE_DOWN1_EFFECT
	db SPEED_DOWN1_EFFECT
	db SPECIAL_DOWN1_EFFECT
	db ACCURACY_DOWN1_EFFECT
	db EVASION_DOWN1_EFFECT
	db BIDE_EFFECT
	db SLEEP_EFFECT
	db ATTACK_UP2_EFFECT
	db DEFENSE_UP2_EFFECT
	db SPEED_UP2_EFFECT
	db SPECIAL_UP2_EFFECT
	db ACCURACY_UP2_EFFECT
	db EVASION_UP2_EFFECT
	db ATTACK_DOWN2_EFFECT
	db DEFENSE_DOWN2_EFFECT
	db SPEED_DOWN2_EFFECT
	db SPECIAL_DOWN2_EFFECT
	db ACCURACY_DOWN2_EFFECT
	db EVASION_DOWN2_EFFECT
	db ATTACK_DEFENSE_UP1_EFFECT     ; dual-stat
	db ACCURACY_EVASION_DOWN1_EFFECT ; dual-stat
	db ATTACK_ACCURACY_UP1_EFFECT    ; dual-stat
	db SPEED_EVASION_UP1_EFFECT      ; dual-stat
	db SPECIAL_SPEED_DOWN1_EFFECT    ; dual-stat
	db SPECIAL_ACCURACY_UP1_EFFECT   ; dual-stat (Calm Mind revised)
	; v0.7 gap fix: these four 0-BP dual/mixed effects were added in v0.5/v0.6
	; without a ResidualEffects2 entry, so they dispatched via the post-damage
	; fallthrough instead — which pre-sets wMoveDidntMiss=1 and silenced their
	; move animation (the anim guard in StatModifierUp/DownEffect saw it).
	db SPECIAL_SPEED_UP1_EFFECT      ; dual-stat (Quiver Dance)
	db SPEED_EVASION_DOWN1_EFFECT    ; dual-stat (Psychic Bind)
	db ATTACK_UP1_DOWN1_EFFECT       ; mixed dual-stat (Fierce Roar)
	db SPECIAL_UP1_HEAL_EFFECT       ; stat + heal (Growth revised)
	db -1 ; end
