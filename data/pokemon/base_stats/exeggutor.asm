	db DEX_EXEGGUTOR ; pokedex id
	base_stat_row 90, 70, 90, 120, 60 ; hp atk def spc spd

	db GRASS, PSYCHIC_TYPE ; type
	db 65 ; catch rate  ; final stage, BST 430
	db 212 ; base exp

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

	db 0 ; padding
