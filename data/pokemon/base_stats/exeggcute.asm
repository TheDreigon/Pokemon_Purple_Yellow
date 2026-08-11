	db DEX_EXEGGCUTE ; pokedex id
	base_stat_row 60, 35, 30, 80, 30 ; hp atk def spc spd

	db GRASS, PSYCHIC_TYPE ; type
	db 250 ; catch rate  ; base stage, BST 235, easy to approach
	db 50 ; base exp  ; BST 235 - muitas fraquezas (-5)

	INCBIN "gfx/pokemon/front/exeggcute.pic", 0, 1 ; sprite dimensions
	dw ExeggcutePicFront, ExeggcutePicBack

	db ABSORB, GROWTH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Immobile Grass/Psychic egg cluster, short backbone. Ladder prereq: EXTRASENSORY.
	tmhm EXTRASENSORY, PSYCHIC_M, DARK_PULSE, PETAL_DANCE
	; end

	db BANK(ExeggcutePicFront) ; which bank this mon's pics live in
	assert BANK(ExeggcutePicFront) == BANK(ExeggcutePicBack), \
	    "Exeggcute: front and back pics must share a bank"
