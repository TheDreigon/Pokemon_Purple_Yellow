	db DEX_DROWZEE ; pokedex id
	base_stat_row 60, 50, 45, 85, 40 ; hp atk def spc spd
	db PSYCHIC_TYPE, DARK ; type
	db 190 ; catch rate
	db 102 ; base exp

	INCBIN "gfx/pokemon/front/drowzee.pic", 0, 1 ; sprite dimensions
	dw DrowzeePicFront, DrowzeePicBack

	db TACKLE, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    DARK_PULSE,   DOUBLE_EDGE,  EXTRASENSORY, FAKE_TEARS, \
	     NIGHT_SHADE,  PSYCHIC_M,    TAKE_DOWN
	; end

	db 0 ; padding
