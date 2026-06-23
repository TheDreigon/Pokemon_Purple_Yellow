	db DEX_ARBOK ; pokedex id
	base_stat_row 60, 90, 90, 60, 100 ; hp atk def spc spd
	db POISON, DARK ; type
	db 90 ; catch rate
	db 147 ; base exp

	INCBIN "gfx/pokemon/front/arbok.pic", 0, 1 ; sprite dimensions
	dw ArbokPicFront, ArbokPicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Poison/Dark matured cobra, last-stage.
	tmhm QUICK_ATTACK, BIND, FAINT_ATTACK, BODY_SLAM, IRON_TAIL, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     POISON_BITE, TOXIC, INTIMIDATE, SCARY_FACE, TAKE_DOWN, \
	     DOUBLE_EDGE, CUT
	; end

	db 0 ; padding
