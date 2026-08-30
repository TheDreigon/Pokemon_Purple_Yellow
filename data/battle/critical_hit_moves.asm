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
	; GROUND
	db DIG ; ambush strike from below — same charge-move payoff as FLY
	; NORMAL
	db SLASH
	db HORN_CHARGE
	db DOUBLE_EDGE
	db HYPER_FANG
	; PSYCHIC
	db MIND_BREAK ; live since the move switched to PARALYZE_SIDE_EFFECT3
	              ; (damaging effect — goes through CriticalHitTest normally)
	; ROCK
	db HORN_DRILL
	; STEEL
	db CUT
	db -1 ; end
