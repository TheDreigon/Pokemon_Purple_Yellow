	db DEX_GOLDUCK ; pokedex id
	base_stat_row 80, 80, 70, 90, 85 ; hp atk def spc spd
	db WATER, PSYCHIC_TYPE ; type
	db 75 ; catch rate
	db 174 ; base exp

	INCBIN "gfx/pokemon/front/golduck.pic", 0, 1 ; sprite dimensions
	dw GolduckPicFront, GolduckPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; v0.7 Pass 3: apex pato psiquico nadador. auto
	; WATER_PULSE/ICY_PULSE/NIGHT_SHADE/EXTRASENSORY/PSYCHIC_M/ICE_BEAM/SURF.
	; bonus DAZZLE_GLEAM/AGILITY/TOXIC/LIGHT_SCREEN/REFLECT. HM
	; CUT/SURF/STRENGTH. fun (4 via TM, regra global last-stage Forte)
	; MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm WATER_PULSE, ICY_PULSE, NIGHT_SHADE, MIMIC, MIRROR_MOVE, \
	     SUBSTITUTE, METRONOME, DAZZLE_GLEAM, AGILITY, TOXIC, \
	     EXTRASENSORY, PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, REFLECT, \
	     CUT, SURF, STRENGTH
	; end

	db 0 ; padding
