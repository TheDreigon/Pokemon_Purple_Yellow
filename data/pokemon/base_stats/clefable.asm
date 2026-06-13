	db DEX_CLEFABLE ; pokedex id
	base_stat_row 100, 70, 75, 100, 65 ; hp atk def spc spd
	db FAIRY, FAIRY ; type
	db 25 ; catch rate
	db 129 ; base exp

	INCBIN "gfx/pokemon/front/clefable.pic", 0, 1 ; sprite dimensions
	dw ClefablePicFront, ClefablePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    CALM_MIND,    CHARM,        DAZZLE_GLEAM, EXTRASENSORY, \
	     FAKE_TEARS,   LIGHT_SCREEN, METRONOME,    MIMIC,        PETAL_DANCE, \
	     PSYCHIC_M,    REFLECT,      MIRROR_MOVE,  SUBSTITUTE
	; end

	db 0 ; padding
