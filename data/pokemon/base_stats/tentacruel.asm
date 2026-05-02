	db DEX_TENTACRUEL ; pokedex id
	base_stat_row 100, 80, 60, 120, 90 ; hp atk def spc spd

	db WATER, POISON ; type
	db 60 ; catch rate
	db 205 ; base exp

	INCBIN "gfx/pokemon/front/tentacruel.pic", 0, 1 ; sprite dimensions
	dw TentacruelPicFront, TentacruelPicBack

	db WRAP, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm AGILITY,      BIND,         ICE_BEAM,     LEECH_LIFE,   SHOCK_WAVE, \
	     TOXIC,        WATER_PULSE,  MIMIC,        MIRROR_MOVE,  SUBSTITUTE, \
	     METRONOME,    CUT,          SURF
	; end

	db 0 ; padding
