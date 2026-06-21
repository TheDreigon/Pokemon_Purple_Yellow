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
	; Apex slow Water/Psychic tank.
	tmhm WATER_PULSE, ICY_PULSE, BODY_SLAM, CONFUSE_RAY, MIMIC, \
	     MIRROR_MOVE, SUBSTITUTE, METRONOME, TOXIC, EXTRASENSORY, \
	     PSYCHIC_M, LIGHT_SCREEN, ICE_BEAM, REFLECT, SURF, \
	     STRENGTH
	; end

	db 0 ; padding
