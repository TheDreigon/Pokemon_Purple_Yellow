HighCriticalMoves:
	; DARK
	db NIGHT_SLASH
	db GORE_ATTACK
	db PAY_DAY
	; DRAGON
	db DRAGON_CLAW
	db OUTRAGE
	db HYPER_BEAM
	; ELECTRIC
	db VOLT_TACKLE
	; FIGHTING
	db KARATE_CHOP
	db LEEK_STRIKE
	db SKY_UPPERCUT
	db HI_JUMP_KICK
	; FIRE
	db EXPLOSION
	; GRASS
	db RAZOR_LEAF
	; NORMAL
	db SLASH
	db HORN_CHARGE
	db DOUBLE_EDGE
	db HYPER_FANG
	; PSYCHIC
	db MIND_BREAK ; NOTE: currently inert — MIND_BREAK uses PARALYZE_EFFECT,
	              ; which is in ResidualEffects1 (pure status path: skips
	              ; damage calc AND CriticalHitTest entirely). Kept here for
	              ; when the move gets a damaging effect. See HANDOVER audit.
	; ROCK
	db HORN_DRILL
	; STEEL
	db CUT
	db -1 ; end
