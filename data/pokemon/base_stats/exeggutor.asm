	db DEX_EXEGGUTOR ; pokedex id
	base_stat_row 90, 70, 90, 120, 60 ; hp atk def spc spd

	db GRASS, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 212 ; base exp

	INCBIN "gfx/pokemon/front/exeggutor.pic", 0, 1 ; sprite dimensions
	dw ExeggutorPicFront, ExeggutorPicBack

	db ABSORB, GROWTH, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex egg-tree Grass/Psychic, arvore pesada. auto
	; BODY_SLAM/PSYCHIC_M/DARK_PULSE/PETAL_DANCE/DOUBLE_EDGE. bonus
	; TAKE_DOWN/EARTHQUAKE. fun (4 via TM, regra global last-stage
	; Forte) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm BODY_SLAM, MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, \
	     TAKE_DOWN, PSYCHIC_M, DARK_PULSE, EARTHQUAKE, PETAL_DANCE, \
	     DOUBLE_EDGE
	; end

	db 0 ; padding
