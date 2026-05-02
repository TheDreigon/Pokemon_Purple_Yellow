	db DEX_WIGGLYTUFF ; pokedex id
	base_stat_row 140, 70, 40, 70, 70 ; hp atk def spc spd
	db NORMAL, FAIRY ; type
	db 50 ; catch rate
	db 109 ; base exp

	INCBIN "gfx/pokemon/front/wigglytuff.pic", 0, 1 ; sprite dimensions
	dw WigglytuffPicFront, WigglytuffPicBack

	db SING, DOUBLESLAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    CHARM,        DAZZLE_GLEAM, DOUBLE_EDGE,  EXTRASENSORY, \
	     FAKE_TEARS,   MIRROR_MOVE,  PSYCHIC_M,    RAGE,         MIMIC, \
	     SUBSTITUTE,   METRONOME,    FLY
	; end

	db 0 ; padding
