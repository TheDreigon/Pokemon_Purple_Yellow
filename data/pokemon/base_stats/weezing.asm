	db DEX_WEEZING ; pokedex id
	base_stat_row 90, 95, 100, 95, 50 ; hp atk def spc spd
	db POISON, GAS ; type
	db 60 ; catch rate
	db 173 ; base exp

	INCBIN "gfx/pokemon/front/weezing.pic", 0, 1 ; sprite dimensions
	dw WeezingPicFront, WeezingPicBack

	db TACKLE, SMOG, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm DARK_PULSE,   FLAMETHROWER, LIGHT_SCREEN, NIGHT_SHADE,  SCARY_FACE, \
	     TOXIC,        MIMIC,        MIRROR_MOVE,  SUBSTITUTE,   METRONOME
	; end

	db 0 ; padding
