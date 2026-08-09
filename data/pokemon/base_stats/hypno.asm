	db DEX_HYPNO ; pokedex id
	base_stat_row 85, 75, 70, 105, 65 ; hp atk def spc spd
	db PSYCHIC_TYPE, DARK ; type
	db 75 ; catch rate  ; final stage, BST 400
	db 165 ; base exp

	INCBIN "gfx/pokemon/front/hypno.pic", 0, 1 ; sprite dimensions
	dw HypnoPicFront, HypnoPicBack

	db TACKLE, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex hypnotist Psychic/Dark.
	; Fun moves (global last-stage rule): MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BODY_SLAM, NIGHT_SHADE, CONFUSE_RAY, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, FAKE_TEARS, EXTRASENSORY, SCARY_FACE, \
	     TAKE_DOWN, PSYCHIC_M, DARK_PULSE, SHADOW_BALL, REFLECT, \
	     CALM_MIND, DOUBLE_EDGE, ROCK_THROW
	; end

	db BANK(HypnoPicFront) ; which bank this mon's pics live in
	assert BANK(HypnoPicFront) == BANK(HypnoPicBack), \
	    "Hypno: front and back pics must share a bank"
