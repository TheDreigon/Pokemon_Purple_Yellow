	db DEX_ALAKAZAM ; pokedex id
	base_stat_row 55, 50, 45, 135, 125 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 45 ; catch rate  ; set by hand: reads the throw before it happens
	db 190 ; base exp  ; escolha dele: luta acima do BST dele

	INCBIN "gfx/pokemon/front/alakazam.pic", 0, 1 ; sprite dimensions
	dw AlakazamPicFront, AlakazamPicBack

	db TELEPORT, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex psychic mage; wide movepool matching its maximal intelligence.
	tmhm SHOCK_WAVE, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     DAZZLE_GLEAM, AGILITY, FAKE_TEARS, EXTRASENSORY, PSYCHIC_M, \
	     LIGHT_SCREEN, DARK_PULSE, SHADOW_BALL, REFLECT, CALM_MIND, \
	     FLASH, ROCK_THROW
	; end

	db BANK(AlakazamPicFront) ; which bank this mon's pics live in
	assert BANK(AlakazamPicFront) == BANK(AlakazamPicBack), \
	    "Alakazam: front and back pics must share a bank"
