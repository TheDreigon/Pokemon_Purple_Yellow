	db DEX_SLOWBRO ; pokedex id
	base_stat_row 100, 75, 100, 85, 30 ; hp atk def spc spd

	db WATER, PSYCHIC_TYPE ; type
	db 75 ; catch rate
	db 164 ; base exp

	INCBIN "gfx/pokemon/front/slowbro.pic", 0, 1 ; sprite dimensions
	dw SlowbroPicFront, SlowbroPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex slow Water/Psychic tank. auto
	; WATER_PULSE/ICY_PULSE/BODY_SLAM/EXTRASENSORY/PSYCHIC_M/ICE_BEAM.
	; bonus CONFUSE_RAY/TOXIC/LIGHT_SCREEN/REFLECT. HM SURF/STRENGTH.
	; fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm WATER_PULSE, ICY_PULSE, BODY_SLAM, CONFUSE_RAY, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, TOXIC, EXTRASENSORY, \
	     PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, REFLECT, SURF, \
	     STRENGTH
	; end

	db 0 ; padding
