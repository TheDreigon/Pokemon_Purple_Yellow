	db DEX_EXEGGUTOR ; pokedex id
	base_stat_row 60, 70, 90, 120, 80, 60 ; hp atk def spatk spdef spd

	db GRASS, PSYCHIC_TYPE ; type
	db 75 ; catch rate  ; final stage, BST 480
	db 170 ; base exp  ; BST 430 - muitas fraquezas (-5)

	INCBIN "gfx/pokemon/front/exeggutor.pic", 0, 1 ; sprite dimensions
	dw ExeggutorPicFront, ExeggutorPicBack

	db ABSORB, GROWTH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex egg-tree Grass/Psychic, a heavy tree. Ladder prereqs: BULLDOZE, EXTRASENSORY.
	tmhm BULLDOZE, BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, EXTRASENSORY, TAKE_DOWN, PSYCHIC_M, DARK_PULSE, \
	     EARTHQUAKE, PETAL_DANCE, DOUBLE_EDGE
	; end

	db BANK(ExeggutorPicFront) ; which bank this mon's pics live in
	assert BANK(ExeggutorPicFront) == BANK(ExeggutorPicBack), \
	    "Exeggutor: front and back pics must share a bank"
