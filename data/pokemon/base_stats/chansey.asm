	db DEX_CHANSEY ; pokedex id
	base_stat_row 250, 5, 5, 100, 70 ; hp atk def spc spd
	db NORMAL, FAIRY ; type
	db 30 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/chansey.pic", 0, 1 ; sprite dimensions
	dw ChanseyPicFront, ChanseyPicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: Chansey Normal/Fairy heal-tank single-stage. auto
	; SEISMIC_TOSS/METRONOME/DAZZLE_GLEAM/FAKE_TEARS/CHARM/EXTRASENSORY/LIGHT_SCREEN/REFLECT/CALM_MIND/PETAL_DANCE.
	; bonus BODY_SLAM/PSYCHIC_M. fun (4 via TM, regra global last-stage
	; Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm SEISMIC_TOSS, BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, \
	     METRONOME, DAZZLE_GLEAM, FAKE_TEARS, CHARM, EXTRASENSORY, \
	     PSYCHIC_M, LIGHT_SCREEN, REFLECT, CALM_MIND, PETAL_DANCE
	; end

	db 0 ; padding
