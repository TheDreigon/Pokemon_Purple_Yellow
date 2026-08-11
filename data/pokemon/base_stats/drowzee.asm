	db DEX_DROWZEE ; pokedex id
	base_stat_row 60, 50, 45, 85, 40 ; hp atk def spc spd
	db PSYCHIC_TYPE, DARK ; type
	db 215 ; catch rate  ; base stage, BST 280
	db 80 ; base exp  ; BST 280 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/drowzee.pic", 0, 1 ; sprite dimensions
	dw DrowzeePicFront, DrowzeePicBack

	db TACKLE, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Psychic/Dark hypnotist pre-evo.
	tmhm BODY_SLAM, NIGHT_SHADE, CONFUSE_RAY, FAKE_TEARS, EXTRASENSORY, \
	     TAKE_DOWN, PSYCHIC_M, DARK_PULSE, DOUBLE_EDGE
	; end

	db BANK(DrowzeePicFront) ; which bank this mon's pics live in
	assert BANK(DrowzeePicFront) == BANK(DrowzeePicBack), \
	    "Drowzee: front and back pics must share a bank"
