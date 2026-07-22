	db DEX_ALAKAZAM ; pokedex id
	base_stat_row 55, 50, 45, 135, 125 ; hp atk def spc spd

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 50 ; catch rate
	db 186 ; base exp

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

	db 0 ; padding
