	db DEX_CLEFABLE ; pokedex id
	base_stat_row 100, 70, 75, 100, 65 ; hp atk def spc spd
	db FAIRY, FAIRY ; type
	db 90 ; catch rate  ; final stage, BST 410, easy to approach
	db 129 ; base exp

	INCBIN "gfx/pokemon/front/clefable.pic", 0, 1 ; sprite dimensions
	dw ClefablePicFront, ClefablePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex mystical moon-fairy. Fairy/psychic kit
	; (DAZZLE_GLEAM/CHARM/FAKE_TEARS/EXTRASENSORY/PSYCHIC_M), screens
	; (LIGHT_SCREEN/REFLECT/CALM_MIND), PETAL_DANCE, BODY_SLAM. 4 fun
	; moves (last stage).
	tmhm BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     DAZZLE_GLEAM, FAKE_TEARS, CHARM, EXTRASENSORY, PSYCHIC_M, \
	     LIGHT_SCREEN, REFLECT, CALM_MIND, PETAL_DANCE, FLASH
	; end

	db BANK(ClefablePicFront) ; which bank this mon's pics live in
	assert BANK(ClefablePicFront) == BANK(ClefablePicBack), \
	    "Clefable: front and back pics must share a bank"
