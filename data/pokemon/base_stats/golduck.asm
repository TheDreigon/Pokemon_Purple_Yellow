	db DEX_GOLDUCK ; pokedex id
	base_stat_row 80, 80, 70, 90, 85 ; hp atk def spc spd
	db WATER, PSYCHIC_TYPE ; type
	db 75 ; catch rate  ; final stage, BST 405
	db 155 ; base exp  ; BST 405 - muitas fraquezas (-2)

	INCBIN "gfx/pokemon/front/golduck.pic", 0, 1 ; sprite dimensions
	dw GolduckPicFront, GolduckPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex psychic swimming duck. HM CUT/SURF/STRENGTH.
	; Fun moves (last-stage): MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm WATER_PULSE, ICY_PULSE, NIGHT_SHADE, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, DAZZLE_GLEAM, AGILITY, TOXIC, \
	     EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, REFLECT, \
	     CUT, SURF, STRENGTH, ROCK_THROW
	; end

	db BANK(GolduckPicFront) ; which bank this mon's pics live in
	assert BANK(GolduckPicFront) == BANK(GolduckPicBack), \
	    "Golduck: front and back pics must share a bank"
