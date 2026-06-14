	db DEX_SCYTHER ; pokedex id
	base_stat_row 60, 105, 80, 55, 110 ; hp atk def spc spd

	db BUG, FLYING ; type
	db 45 ; catch rate
	db 187 ; base exp

	INCBIN "gfx/pokemon/front/scyther.pic", 0, 1 ; sprite dimensions
	dw ScytherPicFront, ScytherPicBack

	db SCRATCH, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: blade-NINJA mantis (R11 vs Pinsir — speed/blades
	; identity). auto
	; QUICK_ATTACK/FAINT_ATTACK/AGILITY/AERIAL_ACE/SWORDS_DANCE/CUT/FLY.
	; bonus
	; IRON_TAIL/DRAGON_CLAW/SCARY_FACE/TAKE_DOWN/DARK_PULSE/DOUBLE_EDGE.
	; HM CUT/FLY. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm QUICK_ATTACK, FAINT_ATTACK, IRON_TAIL, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, AGILITY, AERIAL_ACE, DRAGON_CLAW, \
	     SCARY_FACE, TAKE_DOWN, DARK_PULSE, SWORDS_DANCE, DOUBLE_EDGE, \
	     CUT, FLY
	; end

	db 0 ; padding
