	db DEX_DROWZEE ; pokedex id
	base_stat_row 60, 50, 45, 85, 40 ; hp atk def spc spd
	db PSYCHIC_TYPE, DARK ; type
	db 190 ; catch rate
	db 102 ; base exp

	INCBIN "gfx/pokemon/front/drowzee.pic", 0, 1 ; sprite dimensions
	dw DrowzeePicFront, DrowzeePicBack

	db TACKLE, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: pre-evo hipnotista Psychic/Dark, backbone tight. auto
	; NIGHT_SHADE/EXTRASENSORY/PSYCHIC_M/DARK_PULSE. bonus
	; BODY_SLAM/CONFUSE_RAY/FAKE_TEARS/TAKE_DOWN/DOUBLE_EDGE.
	tmhm BODY_SLAM, NIGHT_SHADE, CONFUSE_RAY, FAKE_TEARS, EXTRASENSORY, \
	     TAKE_DOWN, PSYCHIC_M, DARK_PULSE, DOUBLE_EDGE
	; end

	db 0 ; padding
