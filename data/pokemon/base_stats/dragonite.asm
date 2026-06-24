	db DEX_DRAGONITE ; pokedex id
	base_stat_row 110, 115, 80, 110, 85 ; hp atk def spc spd
	db DRAGON, DRAGON ; type
	db 9 ; catch rate
	db 218 ; base exp

	INCBIN "gfx/pokemon/front/dragonite.pic", 0, 1 ; sprite dimensions
	dw DragonitePicFront, DragonitePicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	; Apex Dragon with a vast movepool. HM CUT/FLY/SURF/STRENGTH. Fun
	; moves (last-stage) MIMIC/MIRROR_MOVE/SUBSTITUTE/METRONOME.
	tmhm ROCK_THROW, BIND, BULLDOZE, WATER_PULSE, ICY_PULSE, \
	     BODY_SLAM, FLAME_BURST, SHOCK_WAVE, IRON_TAIL, BULK_UP, \
	     MIMIC, MIRROR_MOVE, SUBSTITUTE, METRONOME, AGILITY, \
	     IRON_HEAD, AERIAL_ACE, HURRICANE, DRAGON_CLAW, EXTRASENSORY, \
	     INTIMIDATE, TAKE_DOWN, ICE_BEAM, FLAMETHROWER, THUNDERBOLT, \
	     EARTHQUAKE, ROCK_SLIDE, DOUBLE_EDGE, THRASH, OUTRAGE, \
	     CUT, FLY, SURF, STRENGTH, SEISMIC_TOSS
	; end

	db 0 ; padding
