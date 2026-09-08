ResidualEffects2:
; non-side effects not included in ResidualEffects1
; stat-affecting moves, sleep-inflicting moves, and Bide
; e.g., Swords Dance, Bide, Hypnosis
	db EFFECT_01
	db ATTACK_UP1_EFFECT
	db DEFENSE_UP1_EFFECT
	db SPEED_UP1_EFFECT
	db SPATK_UP1_EFFECT
	db ACCURACY_UP1_EFFECT
	db EVASION_UP1_EFFECT
	db ATTACK_DOWN1_EFFECT
	db DEFENSE_DOWN1_EFFECT
	db SPEED_DOWN1_EFFECT
	db SPATK_DOWN1_EFFECT
	db ACCURACY_DOWN1_EFFECT
	db EVASION_DOWN1_EFFECT
	db BIDE_EFFECT
	db SLEEP_EFFECT
	db ATTACK_UP2_EFFECT
	db DEFENSE_UP2_EFFECT
	db SPEED_UP2_EFFECT
	db SPATK_UP2_EFFECT
	db ACCURACY_UP2_EFFECT
	db EVASION_UP2_EFFECT
	db ATTACK_DOWN2_EFFECT
	db DEFENSE_DOWN2_EFFECT
	db SPEED_DOWN2_EFFECT
	db SPATK_DOWN2_EFFECT
	db ACCURACY_DOWN2_EFFECT
	db EVASION_DOWN2_EFFECT
	db ATTACK_DEFENSE_UP1_EFFECT     ; dual-stat
	db ACCURACY_EVASION_DOWN1_EFFECT ; dual-stat
	db ATTACK_ACCURACY_UP1_EFFECT    ; dual-stat
	db SPEED_EVASION_UP1_EFFECT      ; dual-stat
	db SPDEF_SPEED_DOWN1_EFFECT    ; dual-stat
	db SPATK_SPDEF_ACCURACY_UP1_EFFECT   ; dual-stat (Calm Mind revised)
	; NOTE: every 0-BP stat/heal effect MUST have an entry here. Otherwise it
	; dispatches via the post-damage fallthrough, which pre-sets
	; wMoveDidntMiss=1 and silences the move animation (the anim guard in
	; StatModifierUp/DownEffect).
	db SPATK_SPEED_UP1_EFFECT      ; dual-stat (Quiver Dance)
	db SPEED_EVASION_DOWN1_EFFECT    ; dual-stat (Psychic Bind)
	db ATTACK_UP1_DOWN1_EFFECT       ; mixed dual-stat (Fierce Roar)
	db ATTACK_SPATK_UP1_HEAL_EFFECT       ; stat + heal (Growth revised)
	db SPDEF_DOWN2_FLINCH_EFFECT   ; stat + flinch (Metal Sound, 2026-09-01)
	db SPDEF_DOWN1_FLINCH_EFFECT   ; stat + flinch (Screech, 2026-09-01)
	db ATTACK_DOWN2_FLINCH_EFFECT    ; stat + flinch (Intimidate, 2026-09-05)
	db SPEED_DOWN2_FLINCH_EFFECT     ; stat + flinch (Scary Face, 2026-09-05)
	db SPEED_DOWN1_FLINCH_EFFECT     ; stat + flinch (Hinder, 2026-09-08)
	db SPDEF_UP2_EFFECT              ; Amnesia (the split, 2026-09-06)
	db SPDEF_DOWN2_EFFECT            ; Fake Tears (the split); NOT the side effect, which rides on a damaging move
	db -1 ; end
