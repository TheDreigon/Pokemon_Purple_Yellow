	db DEX_CHANSEY ; pokedex id
	base_stat_row 250, 5, 5, 100, 70 ; hp atk def spc spd
	db NORMAL, FAIRY ; type
	db 95 ; catch rate  ; solo stage, BST 430, easy to approach
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/chansey.pic", 0, 1 ; sprite dimensions
	dw ChanseyPicFront, ChanseyPicBack

	db SOFTBOILED, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; Normal/Fairy heal-tank, single stage. Fairy/support kit
	; (DAZZLE_GLEAM/FAKE_TEARS/CHARM/EXTRASENSORY/PSYCHIC_M), screens
	; (LIGHT_SCREEN/REFLECT/CALM_MIND), SEISMIC_TOSS for flat damage,
	; TOXIC for stall. 4 fun moves (last stage).
	tmhm SEISMIC_TOSS, BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, DAZZLE_GLEAM, FAKE_TEARS, CHARM, EXTRASENSORY, \
	     PSYCHIC_M, LIGHT_SCREEN, REFLECT, CALM_MIND, PETAL_DANCE, \
	     TOXIC
	; end

	db BANK(ChanseyPicFront) ; which bank this mon's pics live in
	assert BANK(ChanseyPicFront) == BANK(ChanseyPicBack), \
	    "Chansey: front and back pics must share a bank"
