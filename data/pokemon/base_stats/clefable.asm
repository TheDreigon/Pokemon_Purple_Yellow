	db DEX_CLEFABLE ; pokedex id
	base_stat_row 100, 70, 75, 100, 65 ; hp atk def spc spd
	db FAIRY, FAIRY ; type
	db 25 ; catch rate
	db 129 ; base exp

	INCBIN "gfx/pokemon/front/clefable.pic", 0, 1 ; sprite dimensions
	dw ClefablePicFront, ClefablePicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex mystical moon-fairy. auto
	; MIMIC/METRONOME/DAZZLE_GLEAM/CHARM/LIGHT_SCREEN/REFLECT/CALM_MIND/PETAL_DANCE.
	; bonus BODY_SLAM/FAKE_TEARS/EXTRASENSORY/PSYCHIC_M. fun (4 via TM,
	; regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     DAZZLE_GLEAM, FAKE_TEARS, CHARM, EXTRASENSORY, PSYCHIC_M, \
	     LIGHT_SCREEN, REFLECT, CALM_MIND, PETAL_DANCE
	; end

	db 0 ; padding
