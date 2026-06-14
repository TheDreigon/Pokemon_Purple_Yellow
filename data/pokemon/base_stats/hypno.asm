	db DEX_HYPNO ; pokedex id
	base_stat_row 85, 75, 70, 105, 65 ; hp atk def spc spd
	db PSYCHIC_TYPE, DARK ; type
	db 75 ; catch rate
	db 165 ; base exp

	INCBIN "gfx/pokemon/front/hypno.pic", 0, 1 ; sprite dimensions
	dw HypnoPicFront, HypnoPicBack

	db TACKLE, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex hipnotista Psychic/Dark. auto
	; NIGHT_SHADE/EXTRASENSORY/SCARY_FACE/PSYCHIC_M/DARK_PULSE/SHADOW_BALL/REFLECT.
	; bonus
	; BODY_SLAM/CONFUSE_RAY/FAKE_TEARS/TAKE_DOWN/CALM_MIND/DOUBLE_EDGE.
	; fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BODY_SLAM, NIGHT_SHADE, CONFUSE_RAY, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, FAKE_TEARS, EXTRASENSORY, SCARY_FACE, \
	     TAKE_DOWN, PSYCHIC_M, DARK_PULSE, SHADOW_BALL, REFLECT, \
	     CALM_MIND, DOUBLE_EDGE
	; end

	db 0 ; padding
