	db DEX_BUTTERFREE ; pokedex id
	base_stat_row 60, 60, 55, 95, 85 ; hp atk def spc spd
	db BUG, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 160 ; base exp

	INCBIN "gfx/pokemon/front/butterfree.pic", 0, 1 ; sprite dimensions
	dw ButterfreePicFront, ButterfreePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Butterfly Bug/Psychic. Psychic STAB EXTRASENSORY/PSYCHIC_M. Wing
	; HURRICANE, scale-dust DAZZLE_GLEAM. HM FLY/FLASH (luminous wings).
	; Fun moves: last-stage line.
	tmhm MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, DAZZLE_GLEAM, \
	     HURRICANE, EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, REFLECT, \
	     PETAL_DANCE, FLY, FLASH
	; end

	db 0 ; padding
