	db DEX_CHANSEY ; pokedex id
	base_stat_row 250, 5, 5, 100, 70 ; hp atk def spc spd
	db NORMAL, FAIRY ; type
	db 30 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/chansey.pic", 0, 1 ; sprite dimensions
	dw ChanseyPicFront, ChanseyPicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    CALM_MIND,    CHARM,        DAZZLE_GLEAM, EXTRASENSORY, \
	     FAKE_TEARS,   LIGHT_SCREEN, METRONOME,    PETAL_DANCE,  PSYCHIC_M, \
	     REFLECT,      SEISMIC_TOSS, MIMIC,        MIRROR_MOVE,  SUBSTITUTE
	; end

	db 0 ; padding
